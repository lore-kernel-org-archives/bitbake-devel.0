Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id D292A601D4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 17:15:26 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8PHFSNr022997
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Sep 2018 10:15:28 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 25 Sep 2018 10:15:27 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 25 Sep 2018 13:15:25 -0400
Message-ID: <20180925171525.30692-2-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20180925171525.30692-1-mark.hatle@windriver.com>
References: <20180925171525.30692-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v2] fetch2/gitsm.py: Rework the git submodule fetcher
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 25 Sep 2018 17:15:26 -0000
Content-Type: text/plain

The prior fetcher did not know how to work with MIRRORS, and did not
honor BB_NO_NETWORK and similar.

The new fetcher approach recursively calls 'gitsm' download on each
submodule detected.  This ensures that it will go throug the
standard download process.

Each downloaded submodule is then 'attached' to the original download in
the 'modules' directory.  This mimics the behavior of:

    git submodule init

but there is no chance it will contact the network without permission.

It then corrects upstream reference URIs.

The unpack steps simply copies the items from the downloads to the destdir.
Once copied the submodules are connected and we then run:

    git submodule update

According to the git documentation, git submodule init can and will modify
the project configuration and may connect to the network.  Doing the
work manually prevents this.  (This manual process is allowed based
on my reading of the documentation.)

See: https://git-scm.com/book/en/v2/Git-Tools-Submodules

The small change to the existing test is due to this new code always assuming
the code is from a remote system, and not a 'local' repository.  If this
assumption proves to be incorrect -- code will need to be added to deal
with local repositories without an upstream URI.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 279 +++++++++++++++++++++++++++----------------------
 lib/bb/tests/fetch.py  |   3 +
 2 files changed, 159 insertions(+), 123 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 8677309..51f8d0e 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -34,6 +34,8 @@ import bb
 from   bb.fetch2.git import Git
 from   bb.fetch2 import runfetchcmd
 from   bb.fetch2 import logger
+from   bb.fetch2 import Fetch
+from   bb.fetch2 import BBFetchException
 
 class GitSM(Git):
     def supports(self, ud, d):
@@ -42,96 +44,66 @@ class GitSM(Git):
         """
         return ud.type in ['gitsm']
 
-    def uses_submodules(self, ud, d, wd):
+    def update_submodules(self, ud, d):
+        submodules = []
+        paths = {}
+        uris = {}
+        local_paths = {}
+
         for name in ud.names:
             try:
-                runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=wd)
-                return True
-            except bb.fetch.FetchError:
-                pass
-        return False
+                gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=ud.clonedir)
+            except:
+                # No submodules to update
+                continue
 
-    def _set_relative_paths(self, repopath):
-        """
-        Fix submodule paths to be relative instead of absolute,
-        so that when we move the repo it doesn't break
-        (In Git 1.7.10+ this is done automatically)
-        """
-        submodules = []
-        with open(os.path.join(repopath, '.gitmodules'), 'r') as f:
-            for line in f.readlines():
+            module = ""
+            for line in gitmodules.splitlines():
                 if line.startswith('[submodule'):
-                    submodules.append(line.split('"')[1])
+                    module = line.split('"')[1]
+                    submodules.append(module)
+                elif module and line.strip().startswith('path'):
+                    path = line.split('=')[1].strip()
+                    paths[module] = path
+                elif module and line.strip().startswith('url'):
+                    url = line.split('=')[1].strip()
+                    uris[module] = url
 
         for module in submodules:
-            repo_conf = os.path.join(repopath, module, '.git')
-            if os.path.exists(repo_conf):
-                with open(repo_conf, 'r') as f:
-                    lines = f.readlines()
-                newpath = ''
-                for i, line in enumerate(lines):
-                    if line.startswith('gitdir:'):
-                        oldpath = line.split(': ')[-1].rstrip()
-                        if oldpath.startswith('/'):
-                            newpath = '../' * (module.count('/') + 1) + '.git/modules/' + module
-                            lines[i] = 'gitdir: %s\n' % newpath
-                            break
-                if newpath:
-                    with open(repo_conf, 'w') as f:
-                        for line in lines:
-                            f.write(line)
-
-            repo_conf2 = os.path.join(repopath, '.git', 'modules', module, 'config')
-            if os.path.exists(repo_conf2):
-                with open(repo_conf2, 'r') as f:
-                    lines = f.readlines()
-                newpath = ''
-                for i, line in enumerate(lines):
-                    if line.lstrip().startswith('worktree = '):
-                        oldpath = line.split(' = ')[-1].rstrip()
-                        if oldpath.startswith('/'):
-                            newpath = '../' * (module.count('/') + 3) + module
-                            lines[i] = '\tworktree = %s\n' % newpath
-                            break
-                if newpath:
-                    with open(repo_conf2, 'w') as f:
-                        for line in lines:
-                            f.write(line)
-
-    def update_submodules(self, ud, d, allow_network):
-        # We have to convert bare -> full repo, do the submodule bit, then convert back
-        tmpclonedir = ud.clonedir + ".tmp"
-        gitdir = tmpclonedir + os.sep + ".git"
-        bb.utils.remove(tmpclonedir, True)
-        os.mkdir(tmpclonedir)
-        os.rename(ud.clonedir, gitdir)
-        runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*true/bare = false/'", d)
-        runfetchcmd(ud.basecmd + " reset --hard", d, workdir=tmpclonedir)
-        runfetchcmd(ud.basecmd + " checkout -f " + ud.revisions[ud.names[0]], d, workdir=tmpclonedir)
-
-        try:
-            if allow_network:
-                fetch_flags = ""
-            else:
-                fetch_flags = "--no-fetch"
-
-            # The 'git submodule sync' sandwiched between two successive 'git submodule update' commands is
-            # intentional. See the notes on the similar construction in download() for an explanation.
-            runfetchcmd("%(basecmd)s submodule update --init --recursive %(fetch_flags)s || (%(basecmd)s submodule sync --recursive && %(basecmd)s submodule update --init --recursive %(fetch_flags)s)" % {'basecmd': ud.basecmd, 'fetch_flags' : fetch_flags}, d, workdir=tmpclonedir)
-        except bb.fetch.FetchError:
-            if allow_network:
-                raise
-            else:
-                # This method was called as a probe to see whether the submodule history
-                # is complete enough to allow the current working copy to have its
-                # modules filled in. It's not, so swallow up the exception and report
-                # the negative result.
-                return False
-        finally:
-            self._set_relative_paths(tmpclonedir)
-            runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare = true/'", d, workdir=tmpclonedir)
-            os.rename(gitdir, ud.clonedir,)
-            bb.utils.remove(tmpclonedir, True)
+            module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=True, workdir=ud.clonedir)
+            module_hash = module_hash.split()[2]
+
+            # Build new SRC_URI
+            proto = uris[module].split(':', 1)[0]
+            url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
+            url += ';protocol=%s' % proto
+            url += ";name=%s" % module
+            url += ";qbareclone=1;nocheckout=1"
+
+            ld = d.createCopy()
+            # Not necessary to set SRC_URI, since we're passing the URI to
+            # Fetch.
+            #ld.setVar('SRC_URI', url)
+            ld.setVar('SRCREV_%s' % module, module_hash)
+
+            # Workaround for issues with SRCPV/SRCREV_FORMAT errors
+            # error refer to 'multiple' repositories.  Only the repository
+            # in the original SRC_URI actually matters...
+            ld.setVar('SRCPV', d.getVar('SRCPV'))
+            ld.setVar('SRCREV_FORMAT', module)
+
+            newfetch = Fetch([url], ld, cache=False)
+            newfetch.download()
+            local_paths[module] = newfetch.localpath(url)
+
+            # Correct the submodule references to the local download version...
+            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_paths[module]}, d, workdir=ud.clonedir)
+            try:
+                os.mkdir(os.path.join(ud.clonedir, 'modules'))
+            except OSError:
+                pass
+            if not os.path.exists(os.path.join(ud.clonedir, 'modules', paths[module])):
+                os.symlink(local_paths[module], os.path.join(ud.clonedir, 'modules', paths[module]))
 
         return True
 
@@ -147,56 +119,117 @@ class GitSM(Git):
         # Now check that the submodule histories are new enough. The git-submodule command doesn't have
         # any clean interface for doing this aside from just attempting the checkout (with network
         # fetched disabled).
-        return not self.update_submodules(ud, d, allow_network=False)
+        return not self.update_submodules(ud, d)
 
     def download(self, ud, d):
         Git.download(self, ud, d)
 
         if not ud.shallow or ud.localpath != ud.fullshallow:
-            submodules = self.uses_submodules(ud, d, ud.clonedir)
-            if submodules:
-                self.update_submodules(ud, d, allow_network=True)
+            self.update_submodules(ud, d)
+
+    def copy_submodules(self, submodules, ud, destdir, d):
+        if ud.bareclone:
+            repo_conf = destdir
+        else:
+            repo_conf = os.path.join(destdir, '.git')
+
+        if submodules and not os.path.exists(os.path.join(repo_conf, 'modules')):
+            os.mkdir(os.path.join(repo_conf, 'modules'))
+
+        for module in submodules:
+            srcpath = os.path.join(ud.clonedir, 'modules', module)
+            modpath = os.path.join(repo_conf, 'modules', module)
+
+            if os.path.exists(srcpath):
+                if os.path.exists(os.path.join(srcpath, '.git')):
+                    srcpath = os.path.join(srcpath, '.git')
+
+                target = modpath
+                if os.path.exists(modpath):
+                    target = os.path.dirname(modpath)
+
+                runfetchcmd("cp -fpLR %s %s" % (srcpath, target), d)
+            elif os.path.exists(modpath):
+                # Module already exists, likely unpacked from a shallow mirror clone
+                pass
+            else:
+                # This is fatal, as we do NOT want git-submodule to hit the network
+                raise bb.fetch2.FetchError('Submodule %s does not exist in %s or %s.' % (module, srcpath, modpath))
 
     def clone_shallow_local(self, ud, dest, d):
         super(GitSM, self).clone_shallow_local(ud, dest, d)
 
-        runfetchcmd('cp -fpPRH "%s/modules" "%s/"' % (ud.clonedir, os.path.join(dest, '.git')), d)
+        # Copy over the submodules' fetched histories too.
+        repo_conf = os.path.join(dest, '.git')
+
+        submodules = []
+        for name in ud.names:
+            try:
+                gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revision), d, quiet=True, workdir=dest)
+            except:
+                # No submodules to update
+                continue
+
+            for line in gitmodules.splitlines():
+                if line.startswith('[submodule'):
+                    module = line.split('"')[1]
+                    submodules.append(module)
+
+        self.copy_submodules(submodules, ud, dest, d)
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
 
-        if self.uses_submodules(ud, d, ud.destdir):
-            runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
+        # Copy over the submodules' fetched histories too.
+        if ud.bareclone:
+            repo_conf = ud.destdir
+        else:
+            repo_conf = os.path.join(ud.destdir, '.git')
 
-            # Copy over the submodules' fetched histories too.
-            if ud.bareclone:
-                repo_conf = ud.destdir
-            else:
-                repo_conf = os.path.join(ud.destdir, '.git')
-
-            if os.path.exists(ud.clonedir):
-                # This is not a copy unpacked from a shallow mirror clone. So
-                # the manual intervention to populate the .git/modules done
-                # in clone_shallow_local() won't have been done yet.
-                runfetchcmd("cp -fpPRH %s %s" % (os.path.join(ud.clonedir, 'modules'), repo_conf), d)
-                fetch_flags = "--no-fetch"
-            elif os.path.exists(os.path.join(repo_conf, 'modules')):
-                # Unpacked from a shallow mirror clone. Manual population of
-                # .git/modules is already done.
-                fetch_flags = "--no-fetch"
-            else:
-                # This isn't fatal; git-submodule will just fetch it
-                # during do_unpack().
-                fetch_flags = ""
-                bb.error("submodule history not retrieved during do_fetch()")
-
-            # Careful not to hit the network during unpacking; all history should already
-            # be fetched.
-            #
-            # The repeated attempts to do the submodule initialization sandwiched around a sync to
-            # install the correct remote URLs into the submodules' .git/config metadata are deliberate.
-            # Bad remote URLs are leftover in the modules' .git/config files from the unpack of bare
-            # clone tarballs and an initial 'git submodule update' is necessary to prod them back to
-            # enough life so that the 'git submodule sync' realizes the existing module .git/config
-            # files exist to be updated.
-            runfetchcmd("%(basecmd)s submodule update --init --recursive %(fetch_flags)s || (%(basecmd)s submodule sync --recursive && %(basecmd)s submodule update --init --recursive %(fetch_flags)s)" % {'basecmd': ud.basecmd, 'fetch_flags': fetch_flags}, d, workdir=ud.destdir)
+        submodules = []
+        paths = {}
+        uris = {}
+        local_paths = {}
+        for name in ud.names:
+            try:
+                gitmodules = runfetchcmd("%s show HEAD:.gitmodules" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+            except:
+                # No submodules to update
+                continue
+
+            module = ""
+            for line in gitmodules.splitlines():
+                if line.startswith('[submodule'):
+                    module = line.split('"')[1]
+                    submodules.append(module)
+                elif module and line.strip().startswith('path'):
+                    path = line.split('=')[1].strip()
+                    paths[module] = path
+                elif module and line.strip().startswith('url'):
+                    url = line.split('=')[1].strip()
+                    uris[module] = url
+
+        self.copy_submodules(submodules, ud, ud.destdir, d)
+
+        for module in submodules:
+            srcpath = os.path.join(ud.clonedir, 'modules', module)
+            modpath = os.path.join(repo_conf, 'modules', module)
+
+            # Determine (from the submodule) the correct url to reference
+            try:
+                output = runfetchcmd("%(basecmd)s config remote.origin.url" % {'basecmd': ud.basecmd}, d, workdir=modpath)
+            except bb.fetch2.FetchError as e:
+                # No remote url defined in this submodule
+                continue
+
+            local_paths[module] = output
+
+            # Setup the local URL properly (like git submodule init or sync would do...)
+            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_paths[module]}, d, workdir=ud.destdir)
+
+            # Ensure the submodule repository is NOT set to bare, since we're checking it out...
+            runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=modpath)
+
+        if submodules:
+            # Run submodule update, this sets up the directories -- without touching the config
+            runfetchcmd("%s submodule update --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index e1c856f..9c5601a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1344,6 +1344,9 @@ class GitShallowTest(FetcherTest):
         smdir = os.path.join(self.tempdir, 'gitsubmodule')
         bb.utils.mkdirhier(smdir)
         self.git('init', cwd=smdir)
+        # Make this look like it was cloned from a remote...
+        self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
+        self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
         self.add_empty_file('asub', cwd=smdir)
 
         self.git('submodule init', cwd=self.srcdir)
-- 
1.8.3.1


