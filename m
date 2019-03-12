Return-Path: <scott.murray@konsulko.com>
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
	[209.85.166.193])
	by mail.openembedded.org (Postfix) with ESMTP id 42FB97C66B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 22:42:45 +0000 (UTC)
Received: by mail-it1-f193.google.com with SMTP id 188so7258409itb.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 Mar 2019 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=konsulko.com; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=YsrwfiDtMdkCISoYm1vmo3+7epnW1P6L0vV9UIPK38Q=;
	b=GXxJBaaDl/IXiSG6vxeLqIa7UM4lDC2I04flbGja0r81Dno3n1LQJ0kINk7sNFLNBR
	Kfwt+JsGPqmYSEv93N/+kKvARc/O9w+s8i9vPidNlnhumdQs1r1bOMqmqSiEIFAzUagX
	HL/PIhFNxbBoOpJAd+jE98ozmNz9aFYlxz0m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=YsrwfiDtMdkCISoYm1vmo3+7epnW1P6L0vV9UIPK38Q=;
	b=XaOIRJYlp7m5grBnAn5U8xd2YkPh4/T0P1uDuPrMlN/GOwFP8EPZ7le/ayEcV9UGzz
	T9UQrstZMEpXC06ZpHiHGJI+Z8GpFpRuT99W1nAtfhsgOq2c96eG+6NXUhVbrkimM9W1
	wm9KgxauZuXJj7CVSUPAywyZK28X+/ochyZxVWc2qlWM5hL1wQWbudEjG1U9I+6Ob2B0
	+WmVaqk5agwORLijuYfRjCh+rf4QYivR3ODS94ilPswbaDRGEcemsXl5PFu5DH1LtCXW
	EP9M9VCem8U3psvBWhaTkEzWtCAqhqiFl/tk6AwcoJjknmcOGro60XJnXGtrjTz1SUiK
	y5Xg==
X-Gm-Message-State: APjAAAUjY636epup+/EjRI9neuvhhHLVbgIgEosH+MeHI2yFGVxHA8Cd
	OEoscBB9w5vKRBQSmubSnqFGs+Y18oY=
X-Google-Smtp-Source: APXvYqyCjpG5bWbvrHTU/B1B+xbb6WvhVlbTOwouGfaVqohHVNHGGXiMG3+NIiQQlkx2W1WZUnxtTQ==
X-Received: by 2002:a24:1cc9:: with SMTP id c192mr111022itc.80.1552430566169; 
	Tue, 12 Mar 2019 15:42:46 -0700 (PDT)
Received: from ghidorah.spiteful.org (69-165-244-87.cable.teksavvy.com.
	[69.165.244.87])
	by smtp.gmail.com with ESMTPSA id 25sm2843292iog.83.2019.03.12.15.42.45
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 12 Mar 2019 15:42:45 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Mar 2019 18:46:24 -0400
Message-Id: <20190312224627.12667-8-scott.murray@konsulko.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190312224627.12667-1-scott.murray@konsulko.com>
References: <20190312224627.12667-1-scott.murray@konsulko.com>
Subject: [1.40][PATCH 07/10] gitsm.py: Refactor the functions and simplify the class
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
X-List-Received-Date: Tue, 12 Mar 2019 22:42:45 -0000

From: Mark Hatle <mark.hatle@windriver.com>

The update_submodules and unpack_submodules functions were nearly indentical,
so we made a common function where the different behavior could be passed
in by the download and unpack users.  The new function is process_submodules.

Moved the parse_gitmodules function under the new process_submodules, since
there are no external callers.

Refactor the file relative path processing to the URL translation code.
We also add a warning to the translation if a relative ssh URL has been
detected.  Since this can cause a problem.

In the case of a relative URL that does not work after being translated,
it should be possible to use the MIRROR functions to manual translate the
generated relative URL into one that works properly.

Remove 'git config' processing on download contents.  It turns out this is not
necessary since all of the later components work using the git fetcher.

Limit the 'git submodule update' call to only when unpacking a non-bare
repository.  Submodules are always loaded as bare, so this prevents
intermediate unpacks from being attempted.

Finally, the test cases were updated and the new commit ids in the test
repository were updates as well.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 610dbee5634677f5055e2b36a3043cd197fb8c51)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 lib/bb/fetch2/gitsm.py | 232 ++++++++++++++++-------------------------
 lib/bb/tests/fetch.py  |  12 ++-
 2 files changed, 98 insertions(+), 146 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 83571f83..86198ee6 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -45,85 +45,96 @@ class GitSM(Git):
         """
         return ud.type in ['gitsm']
 
-    @staticmethod
-    def parse_gitmodules(gitmodules):
-        modules = {}
-        module = ""
-        for line in gitmodules.splitlines():
-            if line.startswith('[submodule'):
-                module = line.split('"')[1]
-                modules[module] = {}
-            elif module and line.strip().startswith('path'):
-                path = line.split('=')[1].strip()
-                modules[module]['path'] = path
-            elif module and line.strip().startswith('url'):
-                url = line.split('=')[1].strip()
-                modules[module]['url'] = url
-        return modules
-
-    def update_submodules(self, ud, d):
+    def process_submodules(self, ud, workdir, function, d):
+        """
+        Iterate over all of the submodules in this repository and execute
+        the 'function' for each of them.
+        """
+
         submodules = []
         paths = {}
         revision = {}
         uris = {}
-        local_paths = {}
-
+        subrevision = {}
+
+        def parse_gitmodules(gitmodules):
+            modules = {}
+            module = ""
+            for line in gitmodules.splitlines():
+                if line.startswith('[submodule'):
+                    module = line.split('"')[1]
+                    modules[module] = {}
+                elif module and line.strip().startswith('path'):
+                    path = line.split('=')[1].strip()
+                    modules[module]['path'] = path
+                elif module and line.strip().startswith('url'):
+                    url = line.split('=')[1].strip()
+                    modules[module]['url'] = url
+            return modules
+
+        # Collect the defined submodules, and their attributes
         for name in ud.names:
             try:
-                gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=ud.clonedir)
+                gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=workdir)
             except:
                 # No submodules to update
                 continue
 
-            for m, md in self.parse_gitmodules(gitmodules).items():
+            for m, md in parse_gitmodules(gitmodules).items():
+                try:
+                    module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], md['path']), d, quiet=True, workdir=workdir)
+                except:
+                    # If the command fails, we don't have a valid file to check.  If it doesn't
+                    # fail -- it still might be a failure, see next check...
+                    module_hash = ""
+
+                if not module_hash:
+                    logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", m)
+                    continue
+
                 submodules.append(m)
                 paths[m] = md['path']
                 revision[m] = ud.revisions[name]
                 uris[m] = md['url']
-                if uris[m].startswith('..'):
-                    newud = copy.copy(ud)
-                    newud.path = os.path.realpath(os.path.join(newud.path, md['url']))
-                    uris[m] = Git._get_repo_url(self, newud)
+                subrevision[m] = module_hash.split()[2]
 
         for module in submodules:
-            try:
-                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, revision[module], paths[module]), d, quiet=True, workdir=ud.clonedir)
-            except:
-                # If the command fails, we don't have a valid file to check.  If it doesn't
-                # fail -- it still might be a failure, see next check...
-                module_hash = ""
+            # Translate the module url into a SRC_URI
 
-            if not module_hash:
-                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
-                continue
-
-            module_hash = module_hash.split()[2]
-
-            # Build new SRC_URI
-            if "://" not in uris[module]:
-                # It's ssh if the format does NOT have "://", but has a ':'
+            if "://" in uris[module]:
+                # Properly formated URL already
+                proto = uris[module].split(':', 1)[0]
+                url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
+            else:
                 if ":" in uris[module]:
+                    # Most likely an SSH style reference
                     proto = "ssh"
                     if ":/" in uris[module]:
+                        # Absolute reference, easy to convert..
                         url = "gitsm://" + uris[module].replace(':/', '/', 1)
                     else:
+                        # Relative reference, no way to know if this is right!
+                        logger.warning("Submodule included by %s refers to relative ssh reference %s.  References may fail if not absolute." % (ud.url, uris[module]))
                         url = "gitsm://" + uris[module].replace(':', '/', 1)
-                else: # Fall back to 'file' if there is no ':'
+                else:
+                    # This has to be a file reference
                     proto = "file"
                     url = "gitsm://" + uris[module]
-            else:
-                proto = uris[module].split(':', 1)[0]
-                url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
+                    if uris[module].startswith('..'):
+                        # Local on disk relative reference
+                        newud = copy.copy(ud)
+                        newud.path = os.path.realpath(os.path.join(newud.path, md['url']))
+                        url = "gitsm://" + Git._get_repo_url(self, newud)
 
             url += ';protocol=%s' % proto
             url += ";name=%s" % module
-            url += ";bareclone=1;nocheckout=1;nobranch=1"
+            url += ";subpath=%s" % paths[module]
 
             ld = d.createCopy()
             # Not necessary to set SRC_URI, since we're passing the URI to
             # Fetch.
             #ld.setVar('SRC_URI', url)
-            ld.setVar('SRCREV_%s' % module, module_hash)
+            ld.setVar('SRCREV_%s' % module, subrevision[module])
 
             # Workaround for issues with SRCPV/SRCREV_FORMAT errors
             # error refer to 'multiple' repositories.  Only the repository
@@ -131,125 +142,58 @@ class GitSM(Git):
             ld.setVar('SRCPV', d.getVar('SRCPV'))
             ld.setVar('SRCREV_FORMAT', module)
 
-            newfetch = Fetch([url], ld, cache=False)
-            newfetch.download()
-            local_paths[module] = newfetch.localpath(url)
+            function(ud, url, module, paths[module], ld)
 
-            # Correct the submodule references to the local download version...
-            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_paths[module]}, d, workdir=ud.clonedir)
-
-            symlink_path = os.path.join(ud.clonedir, 'modules', paths[module])
-            if not os.path.exists(symlink_path):
-                try:
-                    os.makedirs(os.path.dirname(symlink_path), exist_ok=True)
-                except OSError:
-                    pass
-                os.symlink(local_paths[module], symlink_path)
-
-        return True
+        return submodules != []
 
     def download(self, ud, d):
-        Git.download(self, ud, d)
-        self.update_submodules(ud, d)
-
-    def unpack_submodules(self, repo_conf, ud, d):
-        submodules = []
-        paths = {}
-        revision = {}
-        uris = {}
-        local_paths = {}
-
-        for name in ud.names:
-            try:
-                gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=ud.destdir)
-            except:
-                # No submodules to update
-                continue
-
-            for m, md in self.parse_gitmodules(gitmodules).items():
-                submodules.append(m)
-                paths[m] = md['path']
-                revision[m] = ud.revisions[name]
-                uris[m] = md['url']
-                if uris[m].startswith('..'):
-                    newud = copy.copy(ud)
-                    newud.path = os.path.realpath(os.path.join(newud.path, md['url']))
-                    uris[m] = Git._get_repo_url(self, newud)
+        def download_submodule(ud, url, module, modpath, d):
+            url += ";bareclone=1;nobranch=1"
 
-        modules_updated = False
+            # Is the following still needed?
+            #url += ";nocheckout=1"
 
-        for module in submodules:
             try:
-                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, revision[module], paths[module]), d, quiet=True, workdir=ud.destdir)
-            except:
-                # If the command fails, we don't have a valid file to check.  If it doesn't
-                # fail -- it still might be a failure, see next check...
-                module_hash = ""
+                newfetch = Fetch([url], d, cache=False)
+                newfetch.download()
+            except Exception as e:
+                logger.error('gitsm: submodule download failed: %s %s' % (type(e).__name__, str(e)))
+                raise
 
-            if not module_hash:
-                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
-                continue
-
-            modules_updated = True
+        Git.download(self, ud, d)
+        self.process_submodules(ud, ud.clonedir, download_submodule, d)
 
-            module_hash = module_hash.split()[2]
+    def unpack(self, ud, destdir, d):
+        def unpack_submodules(ud, url, module, modpath, d):
+            url += ";bareclone=1;nobranch=1"
 
-            # Build new SRC_URI
-            if "://" not in uris[module]:
-                # It's ssh if the format does NOT have "://", but has a ':'
-                if ":" in uris[module]:
-                    proto = "ssh"
-                    if ":/" in uris[module]:
-                        url = "gitsm://" + uris[module].replace(':/', '/', 1)
-                    else:
-                        url = "gitsm://" + uris[module].replace(':', '/', 1)
-                else: # Fall back to 'file' if there is no ':'
-                    proto = "file"
-                    url = "gitsm://" + uris[module]
+            # Figure out where we clone over the bare submodules...
+            if ud.bareclone:
+                repo_conf = ud.destdir
             else:
-                proto = uris[module].split(':', 1)[0]
-                url = uris[module].replace('%s:' % proto, 'gitsm:', 1)
-
-            url += ';protocol=%s' % proto
-            url += ";name=%s" % module
-            url += ";bareclone=1;nobranch=1;subpath=%s" % paths[module]
-
-            ld = d.createCopy()
-            # Not necessary to set SRC_URI, since we're passing the URI to
-            # Fetch.
-            #ld.setVar('SRC_URI', url)
-            ld.setVar('SRCREV_%s' % module, module_hash)
+                repo_conf = os.path.join(ud.destdir, '.git')
 
-            # Workaround for issues with SRCPV/SRCREV_FORMAT errors
-            # error refer to 'multiple' repositories.  Only the repository
-            # in the original SRC_URI actually matters...
-            ld.setVar('SRCPV', d.getVar('SRCPV'))
-            ld.setVar('SRCREV_FORMAT', module)
+            try:
+                newfetch = Fetch([url], d, cache=False)
+                newfetch.unpack(root=os.path.join(repo_conf, 'modules'))
+            except Exception as e:
+                logger.error('gitsm: submodule unpack failed: %s %s' % (type(e).__name__, str(e)))
+                raise
 
-            newfetch = Fetch([url], ld, cache=False)
-            newfetch.unpack(root=os.path.join(repo_conf, 'modules'))
-            local_paths[module] = newfetch.localpath(url)
+            newfetch = Fetch([url], d, cache=False)
+            local_path = newfetch.localpath(url)
 
             # Correct the submodule references to the local download version...
-            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_paths[module]}, d, workdir=ud.destdir)
+            runfetchcmd("%(basecmd)s config submodule.%(module)s.url %(url)s" % {'basecmd': ud.basecmd, 'module': module, 'url' : local_path}, d, workdir=ud.destdir)
 
             if ud.shallow:
                 runfetchcmd("%(basecmd)s config submodule.%(module)s.shallow true" % {'basecmd': ud.basecmd, 'module': module}, d, workdir=ud.destdir)
 
             # Ensure the submodule repository is NOT set to bare, since we're checking it out...
-            runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=os.path.join(repo_conf, 'modules', paths[module]))
-
-        return modules_updated
+            runfetchcmd("%s config core.bare false" % (ud.basecmd), d, quiet=True, workdir=os.path.join(repo_conf, 'modules', modpath))
 
-    def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
 
-        # Copy over the submodules' fetched histories too.
-        if ud.bareclone:
-            repo_conf = ud.destdir
-        else:
-            repo_conf = os.path.join(ud.destdir, '.git')
-
-        if self.unpack_submodules(repo_conf, ud, d):
+        if not ud.bareclone and self.process_submodules(ud, ud.destdir, unpack_submodules, d):
             # Run submodule update, this sets up the directories -- without touching the config
             runfetchcmd("%s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 5fb5d04c..1497a3cf 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -894,15 +894,23 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_submodule(self):
         # URL with ssh submodules
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=0d3ffc14bce95e8b3a21a0a67bfe4c4a96ba6350"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=ssh-gitsm-tests;rev=f53765f515e0eeca569ed385bb1c89ce008bb058"
         # Original URL (comment this if you have ssh access to git.yoctoproject.org)
-        url = "gitsm://git.yoctoproject.org/git-submodule-test;rev=f12e57f2edf0aa534cf1616fa983d165a92b0842"
+        url = "gitsm://git.yoctoproject.org/git-submodule-test;branch=master;rev=132fea6e4dee56b61bcf5721c94e8b2445c6a017"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
         os.chdir(os.path.dirname(self.unpackdir))
         fetcher.unpack(self.unpackdir)
 
+        repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
+        self.assertTrue(os.path.exists(repo_path), msg='Unpacked repository missing')
+        self.assertTrue(os.path.exists(os.path.join(repo_path, 'bitbake')), msg='bitbake submodule missing')
+        self.assertFalse(os.path.exists(os.path.join(repo_path, 'na')), msg='uninitialized submodule present')
+
+        # Only when we're running the extended test with a submodule's submodule, can we check this.
+        if os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1')):
+            self.assertTrue(os.path.exists(os.path.join(repo_path, 'bitbake-gitsm-test1', 'bitbake')), msg='submodule of submodule missing')
 
 class TrustedNetworksTest(FetcherTest):
     def test_trusted_network(self):
-- 
2.17.2


