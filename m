Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHF8t-0008Kv-QH
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 16:00:28 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 09 Apr 2012 06:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="126874676"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 09 Apr 2012 06:51:09 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:39 +0800
Message-Id: <9777caf8458702194379782790fd2f063b12f754.1333980505.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 09/21] Hob: clean up and unify the steps for PACKAGE_GENERATING and FAST_IMAGE_GENERATING to call generate_packages_async() and fast_generate_image_async()
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
X-List-Received-Date: Mon, 09 Apr 2012 14:00:28 -0000

For the steps in PACKAGE_GENERATING, the patch consolidates them into
generate_packages_async() to call.

For the steps in FAST_IMAGE_GENERATING, the patch also consolidates them
into fast_generate_image_async() to call.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index a0ad5a0..8a95b94 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -345,6 +345,22 @@ class Builder(gtk.Window):
         self.set_user_config()
         self.handler.generate_recipes()
 
+    def generate_packages_async(self):
+        self.switch_page(self.PACKAGE_GENERATING)
+        # Build packages
+        _, all_recipes = self.recipe_model.get_selected_recipes()
+        self.set_user_config()
+        self.handler.reset_build()
+        self.handler.generate_packages(all_recipes)
+
+    def fast_generate_image_async(self):
+        self.switch_page(self.FAST_IMAGE_GENERATING)
+        # Build packages
+        _, all_recipes = self.recipe_model.get_selected_recipes()
+        self.set_user_config()
+        self.handler.reset_build()
+        self.handler.generate_packages(all_recipes)
+
     def load_template(self, path):
         self.template = TemplateMgr()
         self.template.load(path)
@@ -402,7 +418,6 @@ class Builder(gtk.Window):
         elif next_step == self.PACKAGE_GENERATING or next_step == self.FAST_IMAGE_GENERATING:
             # both PACKAGE_GENEATING and FAST_IMAGE_GENERATING share the same page
             self.build_details_page.show_page(next_step)
-            self.generate_packages()
 
         elif next_step == self.PACKAGE_GENERATED:
             pass
@@ -460,13 +475,6 @@ class Builder(gtk.Window):
         left = self.package_model.set_selected_packages(selected_packages)
         self.configuration.selected_packages += left
 
-    def generate_packages(self):
-        # Build packages
-        _, all_recipes = self.recipe_model.get_selected_recipes()
-        self.set_user_config()
-        self.handler.reset_build()
-        self.handler.generate_packages(all_recipes)
-
     def generate_image(self):
         # Build image
         self.set_user_config()
@@ -737,7 +745,7 @@ class Builder(gtk.Window):
             dialog.run()
             dialog.destroy()
             return
-        self.switch_page(self.PACKAGE_GENERATING)
+        self.generate_packages_async()
 
     def build_image(self):
         selected_packages = self.package_model.get_selected_packages()
@@ -767,7 +775,7 @@ class Builder(gtk.Window):
             dialog.destroy()
             return
 
-        self.switch_page(self.FAST_IMAGE_GENERATING)
+        self.fast_generate_image_async()
 
     def show_binb_dialog(self, binb):
         markup = "<b>Brought in by:</b>\n%s" % binb
@@ -977,7 +985,7 @@ class Builder(gtk.Window):
             response = dialog.run()
             dialog.destroy()
             if response == gtk.RESPONSE_YES:
-                self.switch_page(self.PACKAGE_GENERATING)
+                self.generate_packages_async()
             else:
                 self.switch_page(self.PACKAGE_SELECTION)
         else:
-- 
1.7.6



