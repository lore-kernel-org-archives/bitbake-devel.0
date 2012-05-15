Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SUAtg-0002pE-Dn
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 May 2012 08:06:12 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 14 May 2012 22:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="140710433"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 14 May 2012 22:56:11 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 15 May 2012 13:52:14 +0800
Message-Id: <00949d15d6a5109294db49986497ac19df93f73b.1337060999.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1337060999.git.dongxiao.xu@intel.com>
References: <cover.1337060999.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1337060999.git.dongxiao.xu@intel.com>
References: <cover.1337060999.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/2] Hob: Add filter for images listed in image combo
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
X-List-Received-Date: Tue, 15 May 2012 06:06:12 -0000

Define IMAGE_WHITE_PATTERN variable to indicate which image is allowed
to be displayed in image combobox.

Define IMAGE_BLACK_PATTERN variable to indicate which image is NOT
allowed to be displayed in image combobox.

This fixes [YOCTO #1581]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py                |    4 +++
 lib/bb/ui/crumbs/hobeventhandler.py        |    2 +
 lib/bb/ui/crumbs/imageconfigurationpage.py |   37 +++++++++++++++++++++++++---
 3 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 42d0f2c..a4fb5eb 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -213,6 +213,8 @@ class Parameters:
         self.all_layers = []
         self.image_names = []
         self.enable_proxy = False
+        self.image_white_pattern = ""
+        self.image_black_pattern = ""
 
         # for build log to show
         self.bb_version = ""
@@ -230,6 +232,8 @@ class Parameters:
         self.runnable_machine_patterns = params["runnable_machine_patterns"].split()
         self.deployable_image_types = params["deployable_image_types"].split()
         self.tmpdir = params["tmpdir"]
+        self.image_white_pattern = params["image_white_pattern"]
+        self.image_black_pattern = params["image_black_pattern"]
         # for build log to show
         self.bb_version = params["bb_version"]
         self.target_arch = params["target_arch"]
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 624d7b5..165688a 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -501,4 +501,6 @@ class HobHandler(gobject.GObject):
         params["cvs_proxy_host"] = self.runCommand(["getVariable", "CVS_PROXY_HOST"]) or ""
         params["cvs_proxy_port"] = self.runCommand(["getVariable", "CVS_PROXY_PORT"]) or ""
 
+        params["image_white_pattern"] = self.runCommand(["getVariable", "IMAGE_WHITE_PATTERN"]) or ""
+        params["image_black_pattern"] = self.runCommand(["getVariable", "IMAGE_BLACK_PATTERN"]) or ""
         return params
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index 0463ee8..1198817 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -22,6 +22,7 @@
 
 import gtk
 import glib
+import re
 from bb.ui.crumbs.progressbar import HobProgressBar
 from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import hic, HobImageButton, HobInfoButton, HobAltButton, HobButton
@@ -345,6 +346,16 @@ class ImageConfigurationPage (HobPage):
         active = -1
         cnt = 0
 
+        white_pattern = []
+        if self.builder.parameters.image_white_pattern:
+            for i in self.builder.parameters.image_white_pattern.split():
+                white_pattern.append(re.compile(i))
+
+        black_pattern = []
+        if self.builder.parameters.image_black_pattern:
+            for i in self.builder.parameters.image_black_pattern.split():
+                black_pattern.append(re.compile(i))
+
         it = image_model.get_iter_first()
         self._image_combo_disconnect_signal()
         model = self.image_combo.get_model()
@@ -356,10 +367,28 @@ class ImageConfigurationPage (HobPage):
             image_name = image_model[path][recipe_model.COL_NAME]
             if image_name == self.builder.recipe_model.__dummy_image__:
                 continue
-            self.image_combo.append_text(image_name)
-            if image_name == selected_image:
-                active = cnt
-            cnt = cnt + 1
+
+            if black_pattern:
+                allow = True
+                for pattern in black_pattern:
+                    if pattern.search(image_name):
+                        allow = False
+                        break
+            elif white_pattern:
+                allow = False
+                for pattern in white_pattern:
+                    if pattern.search(image_name):
+                        allow = True
+                        break
+            else:
+                allow = True
+
+            if allow:
+                self.image_combo.append_text(image_name)
+                if image_name == selected_image:
+                    active = cnt
+                cnt = cnt + 1
+
         self.image_combo.append_text(self.builder.recipe_model.__dummy_image__)
         if selected_image == self.builder.recipe_model.__dummy_image__:
             active = cnt
-- 
1.7.4.1



