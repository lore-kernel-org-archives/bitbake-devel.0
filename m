Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5160F7C144
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Jan 2019 21:34:54 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0FLWnbx010207
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 15 Jan 2019 13:33:45 -0800
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 15 Jan 2019 13:33:13 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 Jan 2019 16:31:36 -0500
Message-ID: <20190115213137.113956-7-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20190115213137.113956-1-mark.hatle@windriver.com>
References: <20190115213137.113956-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 6/7] gitsm.py: Rework the shallow fetcher and test case
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
X-List-Received-Date: Tue, 15 Jan 2019 21:34:59 -0000
Content-Type: text/plain

A custom shallow submodule is no longer necessary, as the regular git
fetcher is used and shallow handling works with the same code.

The only general difference between the regular change is simply declaring a
clone as shallow, when appropriate.

This also removes a potential race condition in copying repositories
vs cloning them.

The gitsm shallow fetcher test was revised to verify that the submodule
is shallow cloned along with the primary repository.

The first step of this change was to be sure to clean the gitsubmodule download
directory, as was previously done with the may gitsource directory.

Additional test components were added to verify commit counts, and an
obsolete (and likely incorrect) test for the .git/modules directory to be
empty was also removed.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 66 +++-----------------------------------------------
 lib/bb/tests/fetch.py  | 10 +++++++-
 2 files changed, 13 insertions(+), 63 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index c172ab1..83571f8 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -150,68 +150,7 @@ class GitSM(Git):
 
     def download(self, ud, d):
         Git.download(self, ud, d)
-
-        if not ud.shallow or ud.localpath != ud.fullshallow:
-            self.update_submodules(ud, d)
-
-    def copy_submodules(self, submodules, ud, name, destdir, d):
-        if ud.bareclone:
-            repo_conf = destdir
-        else:
-            repo_conf = os.path.join(destdir, '.git')
-
-        if submodules and not os.path.exists(os.path.join(repo_conf, 'modules')):
-            os.mkdir(os.path.join(repo_conf, 'modules'))
-
-        for module, md in submodules.items():
-            srcpath = os.path.join(ud.clonedir, 'modules', md['path'])
-            modpath = os.path.join(repo_conf, 'modules', md['path'])
-
-            # Check if the module is initialized
-            try:
-                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], md['path']), d, quiet=True, workdir=ud.clonedir)
-            except:
-                # If the command fails, we don't have a valid file to check.  If it doesn't
-                # fail -- it still might be a failure, see next check...
-                module_hash = ""
-
-            if not module_hash:
-                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
-                continue
-
-            if os.path.exists(srcpath):
-                if os.path.exists(os.path.join(srcpath, '.git')):
-                    srcpath = os.path.join(srcpath, '.git')
-
-                target = modpath
-                if os.path.exists(modpath):
-                    target = os.path.dirname(modpath)
-
-                os.makedirs(os.path.dirname(target), exist_ok=True)
-                runfetchcmd("cp -fpLR %s %s" % (srcpath, target), d)
-            elif os.path.exists(modpath):
-                # Module already exists, likely unpacked from a shallow mirror clone
-                pass
-            else:
-                # This is fatal, as we do NOT want git-submodule to hit the network
-                raise bb.fetch2.FetchError('Submodule %s does not exist in %s or %s.' % (module, srcpath, modpath))
-
-    def clone_shallow_local(self, ud, dest, d):
-        super(GitSM, self).clone_shallow_local(ud, dest, d)
-
-        # Copy over the submodules' fetched histories too.
-        repo_conf = os.path.join(dest, '.git')
-
-        submodules = []
-        for name in ud.names:
-            try:
-                gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revision), d, quiet=True, workdir=dest)
-            except:
-                # No submodules to update
-                continue
-
-            submodules = self.parse_gitmodules(gitmodules)
-            self.copy_submodules(submodules, ud, name, dest, d)
+        self.update_submodules(ud, d)
 
     def unpack_submodules(self, repo_conf, ud, d):
         submodules = []
@@ -294,6 +233,9 @@ class GitSM(Git):
             # Correct the submodule references to the local download version...
             runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_paths[module]}, d, workdir=ud.destdir)
 
+            if ud.shallow:
+                runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
+
             # Ensure the submodule repository is NOT set to bare, since we're checking it out...
             runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=os.path.join(repo_conf, 'modules', paths[module]))
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 311c701..5fb5d04 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1316,6 +1316,7 @@ class GitShallowTest(FetcherTest):
         # fetch and unpack, from the shallow tarball
         bb.utils.remove(self.gitdir, recurse=True)
         bb.utils.remove(ud.clonedir, recurse=True)
+        bb.utils.remove(ud.clonedir.replace('gitsource', 'gitsubmodule'), recurse=True)
 
         # confirm that the unpacked repo is used when no git clone or git
         # mirror tarball is available
@@ -1470,6 +1471,7 @@ class GitShallowTest(FetcherTest):
         self.git('config --add remote.origin.url "%s"' % smdir, cwd=smdir)
         self.git('config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"', cwd=smdir)
         self.add_empty_file('asub', cwd=smdir)
+        self.add_empty_file('bsub', cwd=smdir)
 
         self.git('submodule init', cwd=self.srcdir)
         self.git('submodule add file://%s' % smdir, cwd=self.srcdir)
@@ -1479,10 +1481,16 @@ class GitShallowTest(FetcherTest):
         uri = 'gitsm://%s;protocol=file;subdir=${S}' % self.srcdir
         fetcher, ud = self.fetch_shallow(uri)
 
+        # Verify the main repository is shallow
         self.assertRevCount(1)
-        assert './.git/modules/' in bb.process.run('tar -tzf %s' % os.path.join(self.dldir, ud.mirrortarballs[0]))[0]
+
+        # Verify the gitsubmodule directory is present
         assert os.listdir(os.path.join(self.gitdir, 'gitsubmodule'))
 
+        # Verify the submodule is also shallow
+        self.assertRevCount(1, cwd=os.path.join(self.gitdir, 'gitsubmodule'))
+
+
     if any(os.path.exists(os.path.join(p, 'git-annex')) for p in os.environ.get('PATH').split(':')):
         def test_shallow_annex(self):
             self.add_empty_file('a')
-- 
1.8.3.1


