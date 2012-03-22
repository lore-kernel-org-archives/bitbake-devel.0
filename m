Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAXcl-0000Mz-0l
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 03:19:35 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 19:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131778617"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.222])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 19:10:37 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 19:10:30 -0700
Message-Id: <73526e46e43756d1f12b37546aadf1bb216555dd.1332381654.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
Subject: [PATCH 05/10] lib/bb/ui/crumbs: Add HobAltButton and use it
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
X-List-Received-Date: Thu, 22 Mar 2012 02:19:35 -0000

This adds a gtk.Button subclass for secondary actions which unsets the
relief so that the user is aware that the button is clickable and yet it is
more subtle than the primary action (such that the primary action is the
most obvious one) - this is per the interaction design.

Further we replace all uses of gtk.LinkButton with the new HobAltButton

Partially addresses [YOCTO #2105], a follow on patch will theme the button
so that it matches the visual design.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/builddetailspage.py       |    6 +++---
 lib/bb/ui/crumbs/hig.py                    |    2 +-
 lib/bb/ui/crumbs/hobwidget.py              |    9 ++++++++-
 lib/bb/ui/crumbs/imageconfigurationpage.py |   13 ++++++-------
 lib/bb/ui/crumbs/imagedetailspage.py       |   12 ++++++------
 lib/bb/ui/crumbs/packageselectionpage.py   |    4 ++--
 lib/bb/ui/crumbs/recipeselectionpage.py    |    4 ++--
 7 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/lib/bb/ui/crumbs/builddetailspage.py b/lib/bb/ui/crumbs/builddetailspage.py
index 7a5cfe6..3605ee1 100755
--- a/lib/bb/ui/crumbs/builddetailspage.py
+++ b/lib/bb/ui/crumbs/builddetailspage.py
@@ -22,7 +22,7 @@
 
 import gtk
 from bb.ui.crumbs.progressbar import HobProgressBar
-from bb.ui.crumbs.hobwidget import hic, HobNotebook
+from bb.ui.crumbs.hobwidget import hic, HobNotebook, HobAltButton
 from bb.ui.crumbs.runningbuild import RunningBuildTreeView
 from bb.ui.crumbs.runningbuild import BuildConfigurationTreeView
 from bb.ui.crumbs.runningbuild import BuildFailureTreeView
@@ -49,7 +49,7 @@ class BuildDetailsPage (HobPage):
         self.progress_box = gtk.HBox(False, 6)
         self.progress_bar = HobProgressBar()
         self.progress_box.pack_start(self.progress_bar, expand=True, fill=True)
-        self.stop_button = gtk.LinkButton("Stop the build process", "Stop")
+        self.stop_button = HobAltButton("Stop")
         self.stop_button.connect("clicked", self.stop_button_clicked_cb)
         self.progress_box.pack_end(self.stop_button, expand=False, fill=False)
 
@@ -78,7 +78,7 @@ class BuildDetailsPage (HobPage):
         self.notebook.append_page(self.scrolled_view_build, gtk.Label("Log"))
 
         self.button_box = gtk.HBox(False, 6)
-        self.back_button = gtk.LinkButton("Go back to Image Configuration screen", "<< Back to image configuration")
+        self.back_button = HobAltButton("Back to image configuration")
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         self.button_box.pack_start(self.back_button, expand=False, fill=False)
 
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index baad7b8..e6020a3 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -28,7 +28,7 @@ import re
 import subprocess
 import shlex
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton
+from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobAltButton
 from bb.ui.crumbs.progressbar import HobProgressBar
 
 """
diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index db52c47..189ffb4 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -171,11 +171,18 @@ class HobViewTable (gtk.VBox):
         if not view_column.get_title() in self.toggle_columns:
             self.emit("row-activated", tree.get_model(), path)
 
+class HobAltButton(gtk.Button):
+    """
+    A gtk.Button subclass which has no relief, and so is more discrete
+    """
+    def __init__(self, label=None):
+        gtk.Button.__init__(self, label)
+        self.set_relief(gtk.RELIEF_NONE)
+
 class HobXpmLabelButtonBox(gtk.EventBox):
     """ label: name of buttonbox
         description: the simple  description
     """
-
     def __init__(self, display_file="", hover_file="", label="", description=""):
         gtk.EventBox.__init__(self)
         self._base_state_flags = gtk.STATE_NORMAL
diff --git a/lib/bb/ui/crumbs/imageconfigurationpage.py b/lib/bb/ui/crumbs/imageconfigurationpage.py
index b0c5daa..f327be2 100644
--- a/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -24,7 +24,7 @@ import gtk
 import glib
 from bb.ui.crumbs.progressbar import HobProgressBar
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hic, HobXpmLabelButtonBox, HobInfoButton
+from bb.ui.crumbs.hobwidget import hic, HobXpmLabelButtonBox, HobInfoButton, HobAltButton
 from bb.ui.crumbs.hoblistmodel import RecipeListModel
 from bb.ui.crumbs.hobpages import HobPage
 
@@ -153,7 +153,7 @@ class ImageConfigurationPage (HobPage):
         self.progress_box = gtk.HBox(False, 6)
         self.progress_bar = HobProgressBar()
         self.progress_box.pack_start(self.progress_bar, expand=True, fill=True)
-        self.stop_button = gtk.LinkButton("Stop the parsing process", "Stop")
+        self.stop_button = HobAltButton("Stop")
         self.stop_button.connect("clicked", self.stop_button_clicked_cb)
         self.progress_box.pack_end(self.stop_button, expand=False, fill=False)
 
@@ -241,8 +241,7 @@ class ImageConfigurationPage (HobPage):
         button_box.pack_end(label, expand=False, fill=False)
 
         # create button "Build Packages"
-        build_packages_button = gtk.LinkButton("Build packages first based on recipe selection "
-            "for late customization on packages for the target image", "Build Packages")
+        build_packages_button = HobAltButton("Build Packages")
         build_packages_button.connect("clicked", self.build_packages_button_clicked_cb)
         button_box.pack_end(build_packages_button, expand=False, fill=False)
 
@@ -341,14 +340,14 @@ class ImageConfigurationPage (HobPage):
         self.image_combo.set_active(-1)
         self.image_combo.set_active(active)
 
-    def layer_button_clicked_cb(self, event, data):
+    def layer_button_clicked_cb(self, button):
         # Create a layer selection dialog
         self.builder.show_layer_selection_dialog()
 
-    def view_recipes_button_clicked_cb(self, event, data):
+    def view_recipes_button_clicked_cb(self, button):
         self.builder.show_recipes()
 
-    def view_packages_button_clicked_cb(self, event, data):
+    def view_packages_button_clicked_cb(self, button):
         self.builder.show_packages()
 
     def just_bake_button_clicked_cb(self, button):
diff --git a/lib/bb/ui/crumbs/imagedetailspage.py b/lib/bb/ui/crumbs/imagedetailspage.py
index b7663d8..9213255 100755
--- a/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/lib/bb/ui/crumbs/imagedetailspage.py
@@ -23,7 +23,7 @@
 import gobject
 import gtk
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hic, HobViewTable
+from bb.ui.crumbs.hobwidget import hic, HobViewTable, HobAltButton
 from bb.ui.crumbs.hobpages import HobPage
 
 #
@@ -213,7 +213,7 @@ class ImageDetailsPage (HobPage):
                     vallist.append(layer)
                 i += 1
 
-            edit_config_button = gtk.LinkButton("Changes settings for build", "Edit configuration")
+            edit_config_button = HobAltButton("Edit configuration")
             edit_config_button.connect("clicked", self.edit_config_button_clicked_cb)
             setting_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_config_button)
             self.box_group_area.pack_start(setting_detail, expand=False, fill=False)
@@ -224,7 +224,7 @@ class ImageDetailsPage (HobPage):
         vallist.append(pkg_num)
         vallist.append(image_size)
         if build_succeeded:
-            edit_packages_button = gtk.LinkButton("Change package selection for customization", "Edit packages")
+            edit_packages_button = HobAltButton("Edit packages")
             edit_packages_button.connect("clicked", self.edit_packages_button_clicked_cb)
         else: # get to this page from "My images"
             edit_packages_button = None
@@ -288,7 +288,7 @@ class ImageDetailsPage (HobPage):
                 bottom_buttons.pack_end(label, expand=False, fill=False)
 
             # create button "Run image"
-            run_button = gtk.LinkButton("Launch and boot the image in the QEMU emulator", "Run image")
+            run_button = HobAltButton("Run image")
             run_button.connect("clicked", self.run_button_clicked_cb)
             bottom_buttons.pack_end(run_button, expand=False, fill=False)
             created = True
@@ -301,7 +301,7 @@ class ImageDetailsPage (HobPage):
                 bottom_buttons.pack_end(label, expand=False, fill=False)
 
             # create button "Save as template"
-            save_button = gtk.LinkButton("Save the hob build template for future use", "Save as template")
+            save_button = HobAltButton("Save as template")
             save_button.connect("clicked", self.save_button_clicked_cb)
             bottom_buttons.pack_end(save_button, expand=False, fill=False)
             create = True
@@ -309,7 +309,7 @@ class ImageDetailsPage (HobPage):
         name = "Build new image"
         if name in buttonlist:
             # create button "Build new image"
-            build_new_button = gtk.LinkButton("Initiate another new build from the beginning", "Build new image")
+            build_new_button = HobAltButton("Build new image")
             build_new_button.connect("clicked", self.build_new_button_clicked_cb)
             bottom_buttons.pack_start(build_new_button, expand=False, fill=False)
 
diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index 23e460c..3b9c336 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -23,7 +23,7 @@
 import gtk
 import glib
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook
+from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook, HobAltButton
 from bb.ui.crumbs.hoblistmodel import PackageListModel
 from bb.ui.crumbs.hobpages import HobPage
 
@@ -144,7 +144,7 @@ class PackageSelectionPage (HobPage):
         self.build_image_button.connect("clicked", self.build_image_clicked_cb)
         button_box.pack_end(self.build_image_button, expand=False, fill=False)
 
-        self.back_button = gtk.LinkButton("Go back to Image Configuration screen", "<< Back to image configuration")
+        self.back_button = HobAltButton("Back to image configuration")
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         button_box.pack_start(self.back_button, expand=False, fill=False)
 
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index 6dd7c1e..c338d30 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -23,7 +23,7 @@
 import gtk
 import glib
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook
+from bb.ui.crumbs.hobwidget import HobViewTable, HobNotebook, HobAltButton
 from bb.ui.crumbs.hoblistmodel import RecipeListModel
 from bb.ui.crumbs.hobpages import HobPage
 
@@ -166,7 +166,7 @@ class RecipeSelectionPage (HobPage):
         self.build_packages_button.connect("clicked", self.build_packages_clicked_cb)
         button_box.pack_end(self.build_packages_button, expand=False, fill=False)
 
-        self.back_button = gtk.LinkButton("Go back to Image Configuration screen", "<< Back to image configuration")
+        self.back_button = HobAltButton("Back to image configuration")
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         button_box.pack_start(self.back_button, expand=False, fill=False)
 
-- 
1.7.7.6



