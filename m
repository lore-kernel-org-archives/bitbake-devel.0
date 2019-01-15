Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id A2E217C14B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Jan 2019 21:33:33 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0FLVqR2010187
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 15 Jan 2019 13:32:03 -0800
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 15 Jan 2019 13:31:42 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 Jan 2019 16:31:31 -0500
Message-ID: <20190115213137.113956-2-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20190115213137.113956-1-mark.hatle@windriver.com>
References: <20190115213137.113956-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/7] gitsm.py: Fix when a submodule is defined, but not initialized
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
X-List-Received-Date: Tue, 15 Jan 2019 21:33:33 -0000
Content-Type: text/plain

It is possible for a submodule to be defined in the .gitmodules file, but
never initialized in the repository itself.  This shows itself when searching
for the defined module hash you will get back a empty value.

Similarly we need to identify and skip defined but not initialized submodules
during the unpack stages as well.

Thanks to raphael.lisicki@siemens.com for their help is figuring out how
to resolve this issue.

Additionally a problem was found where, while unlikely, it may be possible
for the wrong revision to have been searched using ls-tree.  This has been
resolved in the update_submodules function by keeping the correct revision
along with the submodule path.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 35729db..b7959ff 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -64,6 +64,7 @@ class GitSM(Git):
     def update_submodules(self, ud, d):
         submodules = []
         paths = {}
+        revision = {}
         uris = {}
         local_paths = {}
 
@@ -77,6 +78,7 @@ class GitSM(Git):
             for m, md in self.parse_gitmodules(gitmodules).items():
                 submodules.append(m)
                 paths[m] = md['path']
+                revision[m] = ud.revisions[name]
                 uris[m] = md['url']
                 if uris[m].startswith('..'):
                     newud = copy.copy(ud)
@@ -84,7 +86,17 @@ class GitSM(Git):
                     uris[m] = Git._get_repo_url(self, newud)
 
         for module in submodules:
-            module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=True, workdir=ud.clonedir)
+            try:
+                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, revision[module], paths[module]), d, quiet=True, workdir=ud.clonedir)
+            except:
+                # If the command fails, we don't have a valid file to check.  If it doesn't
+                # fail -- it still might be a failure, see next check...
+                module_hash = ""
+
+            if not module_hash:
+                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
+                continue
+
             module_hash = module_hash.split()[2]
 
             # Build new SRC_URI
@@ -143,7 +155,7 @@ class GitSM(Git):
         if not ud.shallow or ud.localpath != ud.fullshallow:
             self.update_submodules(ud, d)
 
-    def copy_submodules(self, submodules, ud, destdir, d):
+    def copy_submodules(self, submodules, ud, name, destdir, d):
         if ud.bareclone:
             repo_conf = destdir
         else:
@@ -156,6 +168,18 @@ class GitSM(Git):
             srcpath = os.path.join(ud.clonedir, 'modules', md['path'])
             modpath = os.path.join(repo_conf, 'modules', md['path'])
 
+            # Check if the module is initialized
+            try:
+                module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], md['path']), d, quiet=True, workdir=ud.clonedir)
+            except:
+                # If the command fails, we don't have a valid file to check.  If it doesn't
+                # fail -- it still might be a failure, see next check...
+                module_hash = ""
+
+            if not module_hash:
+                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
+                continue
+
             if os.path.exists(srcpath):
                 if os.path.exists(os.path.join(srcpath, '.git')):
                     srcpath = os.path.join(srcpath, '.git')
@@ -188,7 +212,7 @@ class GitSM(Git):
                 continue
 
             submodules = self.parse_gitmodules(gitmodules)
-            self.copy_submodules(submodules, ud, dest, d)
+            self.copy_submodules(submodules, ud, name, dest, d)
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
@@ -211,7 +235,7 @@ class GitSM(Git):
                 continue
 
             submodules = self.parse_gitmodules(gitmodules)
-            self.copy_submodules(submodules, ud, ud.destdir, d)
+            self.copy_submodules(submodules, ud, name, ud.destdir, d)
 
             submodules_queue = [(module, os.path.join(repo_conf, 'modules', md['path'])) for module, md in submodules.items()]
             while len(submodules_queue) != 0:
-- 
1.8.3.1


