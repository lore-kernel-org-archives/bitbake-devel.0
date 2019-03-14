Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id A62F77C741
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 09:09:47 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2E99N9U032360
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 02:09:38 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Thu, 14 Mar 2019 02:09:34 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Mar 2019 17:28:20 +0800
Message-ID: <8074fc829447468b0f42672f17f31b83d3f3888b.1552555629.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1552555629.git.liezhi.yang@windriver.com>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 4/5] fetch2/gitsm: Add clean function
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
X-List-Received-Date: Thu, 14 Mar 2019 09:09:47 -0000
Content-Type: text/plain

The git's clean can only remove parent git repo from DL_DIR, but doesn't remove
submodules, this patch fixes the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/gitsm.py | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index b21fed2..bb61093 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -76,8 +76,8 @@ class GitSM(Git):
         for name in ud.names:
             try:
                 gitmodules = runfetchcmd("%s show %s:.gitmodules" % (ud.basecmd, ud.revisions[name]), d, quiet=True, workdir=workdir)
-            except:
-                # No submodules to update
+            except Exception as esc:
+                logger.info("No submodules found: %s" % workdir)
                 continue
 
             for m, md in parse_gitmodules(gitmodules).items():
@@ -164,6 +164,17 @@ class GitSM(Git):
         Git.download(self, ud, d)
         self.process_submodules(ud, ud.clonedir, download_submodule, d)
 
+    def clean(self, ud, d):
+        def clean_submodule(ud, url, module, modpath, d):
+            try:
+                newfetch = Fetch([url], d, cache=False)
+                newfetch.clean()
+            except Exception as e:
+                logger.warn('gitsm: submodule clean failed: %s %s' % (type(e).__name__, str(e)))
+
+        self.process_submodules(ud, ud.clonedir, clean_submodule, d)
+        Git.clean(self, ud, d)
+
     def unpack(self, ud, destdir, d):
         def unpack_submodules(ud, url, module, modpath, d):
             url += ";bareclone=1;nobranch=1"
-- 
2.7.4


