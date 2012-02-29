Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kRx-0005xo-O2
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:24:13 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 06:15:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113068950"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 29 Feb 2012 06:14:36 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:27 +0800
Message-Id: <8215fe641661f250180c87d726073c0450e191b7.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 30/32] Hob: Fix pressing "stop" build
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 Feb 2012 14:24:14 -0000

From: Dongxiao Xu <dongxiao.xu@intel.com>

This commit fixes the behavior of clicking stop build button, it will
stay in the build detail screen and show build is failed.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index f41b6a4..a04d6fa 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -193,7 +193,6 @@ class Builder(gtk.Window):
         self.previous_step = None
 
         self.stopping = False
-        self.build_succeeded = True
 
         # recipe model and package model
         self.recipe_model = recipe_model
@@ -533,8 +532,7 @@ class Builder(gtk.Window):
         self.build_details_page.update_progress_bar("Build Started: ", fraction)
         self.build_details_page.reset_issues()
 
-    def handler_build_succeeded_cb(self, running_build):
-        self.build_succeeded = True
+    def build_succeeded(self):
         if self.current_step == self.FAST_IMAGE_GENERATING:
             fraction = 0.9
         elif self.current_step == self.IMAGE_GENERATING:
@@ -548,9 +546,9 @@ class Builder(gtk.Window):
         elif self.current_step == self.PACKAGE_GENERATING:
             fraction = 1.0
         self.build_details_page.update_progress_bar("Build Completed: ", fraction)
+        self.stopping = False
 
-    def handler_build_failed_cb(self, running_build):
-        self.build_succeeded = False
+    def build_failed(self):
         if self.current_step == self.FAST_IMAGE_GENERATING:
             fraction = 0.9
         elif self.current_step == self.IMAGE_GENERATING:
@@ -563,6 +561,16 @@ class Builder(gtk.Window):
         self.handler.build_failed_async()
         self.stopping = False
 
+    def handler_build_succeeded_cb(self, running_build):
+        if not self.stopping:
+            self.build_succeeded()
+        else:
+            self.build_failed()
+
+
+    def handler_build_failed_cb(self, running_build):
+        self.build_failed()
+
     def handler_task_started_cb(self, running_build, message): 
         fraction = message["current"] * 1.0/message["total"]
         title = "Build packages"
-- 
1.7.6



