Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S86Fl-0006FM-8e
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Mar 2012 09:41:45 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 15 Mar 2012 01:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="121224427"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 15 Mar 2012 01:32:12 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Mar 2012 16:30:00 +0800
Message-Id: <0347e99ca5c232832f2b490584d76872c6d77311.1331796806.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1331796806.git.dongxiao.xu@intel.com>
References: <cover.1331796806.git.dongxiao.xu@intel.com>
Subject: [PATCH 12/12] Hob: Change Box's padding value
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
X-List-Received-Date: Thu, 15 Mar 2012 08:41:45 -0000

For Box type of widget, change the padding value to be HIG consistent,
that is an increments of 6 pixels.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builddetailspage.py       |    6 +++---
 lib/bb/ui/crumbs/hig.py                    |   14 +++++++-------
 lib/bb/ui/crumbs/hobpages.py               |    2 +-
 lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +-
 lib/bb/ui/crumbs/imagedetailspage.py       |    2 +-
 lib/bb/ui/crumbs/packageselectionpage.py   |    2 +-
 lib/bb/ui/crumbs/recipeselectionpage.py    |    2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/lib/bb/ui/crumbs/builddetailspage.py b/lib/bb/ui/crumbs/builddetailspage.py
index 941f1e3..8b75ca0 100755
--- a/lib/bb/ui/crumbs/builddetailspage.py
+++ b/lib/bb/ui/crumbs/builddetailspage.py
@@ -40,9 +40,9 @@ class BuildDetailsPage (HobPage):
 
     def create_visual_elements(self):
         # create visual elements
-        self.vbox = gtk.VBox(False, 15)
+        self.vbox = gtk.VBox(False, 12)
 
-        self.progress_box = gtk.HBox(False, 5)
+        self.progress_box = gtk.HBox(False, 6)
         self.progress_bar = HobProgressBar()
         self.progress_box.pack_start(self.progress_bar, expand=True, fill=True)
         self.stop_button = gtk.LinkButton("Stop the build process", "Stop")
@@ -55,7 +55,7 @@ class BuildDetailsPage (HobPage):
         self.scrolled_view.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
         self.scrolled_view.add(self.build_tv)
 
-        self.button_box = gtk.HBox(False, 5)
+        self.button_box = gtk.HBox(False, 6)
         self.back_button = gtk.LinkButton("Go back to Image Configuration screen", "<< Back to image configuration")
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         self.button_box.pack_start(self.back_button, expand=False, fill=False)
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 28b7eef..67cc94e 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -127,7 +127,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         return label
 
     def gen_spinner_widget(self, content, lower, upper, tooltip=""):
-        hbox = gtk.HBox(False, 10)
+        hbox = gtk.HBox(False, 12)
         adjust = gtk.Adjustment(value=content, lower=lower, upper=upper, step_incr=1)
         spinner = gtk.SpinButton(adjustment=adjust, climb_rate=1, digits=0)
 
@@ -141,7 +141,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         return hbox, spinner
 
     def gen_combo_widget(self, curr_item, all_item, tooltip=""):
-        hbox = gtk.HBox(False, 10)
+        hbox = gtk.HBox(False, 12)
         combo = gtk.combo_box_new_text()
         hbox.pack_start(combo, expand=False, fill=False)
 
@@ -171,7 +171,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         dialog.destroy()
 
     def gen_entry_widget(self, split_model, content, parent, tooltip=""):
-        hbox = gtk.HBox(False, 10)
+        hbox = gtk.HBox(False, 12)
         entry = gtk.Entry()
         entry.set_text(content)
 
@@ -259,7 +259,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         model.set(it, column, val)
 
     def gen_pkgfmt_widget(self, curr_package_format, all_package_format, tooltip=""):
-        pkgfmt_hbox = gtk.HBox(False, 15)
+        pkgfmt_hbox = gtk.HBox(False, 12)
 
         pkgfmt_store = gtk.ListStore(int, str, gobject.TYPE_BOOLEAN)
         for format in curr_package_format.split():
@@ -358,9 +358,9 @@ class AdvancedSettingDialog (CrumbsDialog):
             model.remove(iter)
 
     def gen_editable_settings(self, setting, tooltip=""):
-        setting_hbox = gtk.HBox(False, 10)
+        setting_hbox = gtk.HBox(False, 12)
 
-        vbox = gtk.VBox(False, 10)
+        vbox = gtk.VBox(False, 12)
         setting_hbox.pack_start(vbox, expand=True, fill=True)
 
         setting_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_STRING)
@@ -403,7 +403,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         vbox.pack_start(scroll, expand=True, fill=True)
 
         # some buttons
-        hbox = gtk.HBox(True, 4)
+        hbox = gtk.HBox(True, 6)
         vbox.pack_start(hbox, False, False)
 
         button = gtk.Button(stock=gtk.STOCK_ADD)
diff --git a/lib/bb/ui/crumbs/hobpages.py b/lib/bb/ui/crumbs/hobpages.py
index be76d0d..bd4b292 100755
--- a/lib/bb/ui/crumbs/hobpages.py
+++ b/lib/bb/ui/crumbs/hobpages.py
@@ -39,7 +39,7 @@ class HobPage (gtk.VBox):
         else:
             self.title = title
 
-        self.box_group_area = gtk.VBox(False, 15)
+        self.box_group_area = gtk.VBox(False, 12)
         self.box_group_area.set_size_request(self.builder_width - 73 - 73, self.builder_height - 88 - 15 - 15)
         self.group_align = gtk.Alignment(xalign = 0, yalign=0.5, xscale=1, yscale=1)
         self.group_align.set_padding(15, 15, 73, 73)
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index a73eab1..c8f7a56 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -218,7 +218,7 @@ class ImageConfigurationPage (HobPage):
 
     def create_config_build_button(self):
         # Create the "Build packages" and "Just bake" buttons at the bottom
-        button_box = gtk.HBox(False, 5)
+        button_box = gtk.HBox(False, 6)
 
         # create button "Just bake"
         just_bake_button = gtk.Button()
diff --git a/lib/bb/ui/crumbs/imagedetailspage.py b/lib/bb/ui/crumbs/imagedetailspage.py
index 833c149..c063d74 100755
--- a/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/lib/bb/ui/crumbs/imagedetailspage.py
@@ -258,7 +258,7 @@ class ImageDetailsPage (HobPage):
 
     def create_bottom_buttons(self, buttonlist):
         # Create the buttons at the bottom
-        bottom_buttons = gtk.HBox(False, 5)
+        bottom_buttons = gtk.HBox(False, 6)
         created = False
 
         # create button "Deploy image"
diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index 4fb199e..1c335ac 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -133,7 +133,7 @@ class PackageSelectionPage (HobPage):
         # add all into the dialog
         self.box_group_area.add(self.grid)
 
-        button_box = gtk.HBox(False, 5)
+        button_box = gtk.HBox(False, 6)
         self.box_group_area.pack_start(button_box, expand=False, fill=False)
 
         self.build_image_button = gtk.Button()
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index 50d4363..d615ef1 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -157,7 +157,7 @@ class RecipeSelectionPage (HobPage):
         # add all into the window
         self.box_group_area.add(self.grid)
 
-        button_box = gtk.HBox(False, 5)
+        button_box = gtk.HBox(False, 6)
         self.box_group_area.pack_end(button_box, expand=False, fill=False)
 
         self.build_packages_button = gtk.Button()
-- 
1.7.4.1



