Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id AC5297C062
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Jan 2019 23:39:08 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x08NcpMf018413
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 8 Jan 2019 15:38:51 -0800 (PST)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 8 Jan 2019 15:38:50 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 8 Jan 2019 18:38:45 -0500
Message-ID: <20190108233847.81353-2-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20190108233847.81353-1-mark.hatle@windriver.com>
References: <20190108233847.81353-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/3] gitsm.py: Fix when a submodule is defined, but not initialized
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
X-List-Received-Date: Tue, 08 Jan 2019 23:39:08 -0000
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
 lib/bb/fetch2/gitsm.py | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 35729db..88609f0 100644
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
@@ -84,7 +86,12 @@ class GitSM(Git):
                     uris[m] = Git._get_repo_url(self, newud)
 
         for module in submodules:
-            module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], paths[module]), d, quiet=True, workdir=ud.clonedir)
+            module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, revision[module], paths[module]), d, quiet=True, workdir=ud.clonedir)
+
+            if not module_hash:
+                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
+                continue
+
             module_hash = module_hash.split()[2]
 
             # Build new SRC_URI
@@ -143,7 +150,7 @@ class GitSM(Git):
         if not ud.shallow or ud.localpath != ud.fullshallow:
             self.update_submodules(ud, d)
 
-    def copy_submodules(self, submodules, ud, destdir, d):
+    def copy_submodules(self, submodules, ud, name, destdir, d):
         if ud.bareclone:
             repo_conf = destdir
         else:
@@ -156,6 +163,13 @@ class GitSM(Git):
             srcpath = os.path.join(ud.clonedir, 'modules', md['path'])
             modpath = os.path.join(repo_conf, 'modules', md['path'])
 
+            # Check if the module is initialized
+            module_hash = runfetchcmd("%s ls-tree -z -d %s %s" % (ud.basecmd, ud.revisions[name], md['path']), d, quiet=True, workdir=ud.clonedir)
+
+            if not module_hash:
+                logger.debug(1, "submodule %s is defined, but is not initialized in the repository. Skipping", module)
+                continue
+
             if os.path.exists(srcpath):
                 if os.path.exists(os.path.join(srcpath, '.git')):
                     srcpath = os.path.join(srcpath, '.git')
@@ -188,7 +202,7 @@ class GitSM(Git):
                 continue
 
             submodules = self.parse_gitmodules(gitmodules)
-            self.copy_submodules(submodules, ud, dest, d)
+            self.copy_submodules(submodules, ud, name, dest, d)
 
     def unpack(self, ud, destdir, d):
         Git.unpack(self, ud, destdir, d)
@@ -211,7 +225,7 @@ class GitSM(Git):
                 continue
 
             submodules = self.parse_gitmodules(gitmodules)
-            self.copy_submodules(submodules, ud, ud.destdir, d)
+            self.copy_submodules(submodules, ud, name, ud.destdir, d)
 
             submodules_queue = [(module, os.path.join(repo_conf, 'modules', md['path'])) for module, md in submodules.items()]
             while len(submodules_queue) != 0:
-- 
1.8.3.1


