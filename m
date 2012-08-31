Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1T7MqQ-0003qa-3Y
	for bitbake-devel@lists.openembedded.org;
	Fri, 31 Aug 2012 10:44:50 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 31 Aug 2012 00:00:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,346,1344236400"; d="scan'208";a="193952861"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga002.jf.intel.com with ESMTP; 31 Aug 2012 00:00:35 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Aug 2012 10:00:47 +0300
Message-Id: <1346396447-8565-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/packageselectionpage: Correctly restore previously selected packages
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
X-List-Received-Date: Fri, 31 Aug 2012 08:44:50 -0000

"Back" button from "Packageselection" page now restores correctly previously
selected packages list. Till now "Back" button was implemented just to switch
pages, not to cancel changes you have made to packages list.

[YOCTO #2984]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py              |   10 +++++++++-
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 7de4798..c6e0f39 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -123,6 +123,7 @@ class Configuration:
         self.selected_image = None
         self.selected_recipes = []
         self.selected_packages = []
+        self.initial_selected_packages = []
 
     def split_proxy(self, protocol, proxy):
         entry = []
@@ -519,6 +520,12 @@ class Builder(gtk.Window):
         self.handler.reset_build()
         self.handler.generate_packages(all_recipes, self.configuration.default_task)
 
+    def restore_initial_selected_packages(self):
+        self.package_model.set_selected_packages(self.configuration.initial_selected_packages)
+        for package in self.configuration.selected_packages:
+            if package not in self.configuration.initial_selected_packages:
+                self.package_model.exclude_item(self.package_model.find_path_for_item(package))
+
     def fast_generate_image_async(self, log = False):
         self.switch_page(self.FAST_IMAGE_GENERATING)
         if log:
@@ -658,6 +665,7 @@ class Builder(gtk.Window):
             self.build_details_page.show_page(next_step)
 
         elif next_step == self.PACKAGE_GENERATED:
+            self.configuration.initial_selected_packages = self.configuration.selected_packages
             if self.recipe_model.get_selected_image() == self.recipe_model.__custom_image__:
                 self.package_details_page.set_packages_curr_tab(self.package_details_page.ALL)
             else:
@@ -1334,4 +1342,4 @@ class Builder(gtk.Window):
             format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
             self.consolelog.setFormatter(format)
 
-            self.logger.addHandler(self.consolelog)
\ No newline at end of file
+            self.logger.addHandler(self.consolelog)
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 3576ed5..89bf047 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -192,6 +192,9 @@ class PackageSelectionPage (HobPage):
         self.builder.build_image()
 
     def back_button_clicked_cb(self, button):
+        self.builder.restore_initial_selected_packages()
+        self.refresh_selection()
+
         if self.builder.current_step ==  self.builder.PACKAGE_GENERATED:
             self.builder.show_recipes()
         elif self.builder.previous_step ==  self.builder.IMAGE_GENERATED:
-- 
1.7.9.5



