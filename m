Return-Path: <valentin.popa@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 6E64661A45
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Jul 2013 11:30:08 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 03 Jul 2013 04:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,987,1363158000"; d="scan'208";a="364687430"
Received: from vpopa-desktop.rb.intel.com ([10.237.105.66])
	by fmsmga002.fm.intel.com with ESMTP; 03 Jul 2013 04:30:06 -0700
From: Valentin Popa <valentin.popa@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Jul 2013 14:31:44 +0300
Message-Id: <1372851104-27705-1-git-send-email-valentin.popa@intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] HOB:Proper handle of SIGINT
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 03 Jul 2013 11:30:08 -0000

Modal dialogs doesn't run on the main loop so they cannot
catch any signal from the terminal. This patch makes sure
the dialogs are destroyed when a SIGINT is sent to HOB.

[YOCTO #3329]
Signed-off-by: Valentin Popa <valentin.popa@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index d5df60f..a2abb2a 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -30,6 +30,7 @@ import shlex
 import re
 import logging
 import sys
+import signal
 from bb.ui.crumbs.imageconfigurationpage import ImageConfigurationPage
 from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
 from bb.ui.crumbs.packageselectionpage import PackageSelectionPage
@@ -441,6 +442,8 @@ class Builder(gtk.Window):
 
         self.initiate_new_build_async()
 
+        signal.signal(signal.SIGINT, self.event_handle_SIGINT)
+
     def create_visual_elements(self):
         self.set_title("Hob")
         self.set_icon_name("applications-development")
@@ -1028,7 +1031,7 @@ class Builder(gtk.Window):
         dialog.destroy()
         self.build_failed()
 
-    def handler_task_started_cb(self, running_build, message): 
+    def handler_task_started_cb(self, running_build, message):
         fraction = message["current"] * 1.0/message["total"]
         title = "Build packages"
         if self.current_step == self.FAST_IMAGE_GENERATING:
@@ -1075,6 +1078,12 @@ class Builder(gtk.Window):
         else:
             gtk.main_quit()
 
+    def event_handle_SIGINT(self, signal, frame):
+        for w in gtk.window_list_toplevels():
+            if w.get_modal():
+                w.response(gtk.RESPONSE_DELETE_EVENT)
+        sys.exit(0)
+
     def build_packages(self):
         _, all_recipes = self.recipe_model.get_selected_recipes()
         if not all_recipes:
@@ -1090,7 +1099,7 @@ class Builder(gtk.Window):
 
     def build_image(self):
         selected_packages = self.package_model.get_selected_packages()
-        if not selected_packages:      
+        if not selected_packages:
             lbl = "<b>No selections made</b>\nYou have not made any selections"
             lbl = lbl + " so there isn't anything to bake at this time."
             dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
-- 
1.8.1.2


