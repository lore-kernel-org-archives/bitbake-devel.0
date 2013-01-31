Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1U0tef-0004pH-3j
	for bitbake-devel@lists.openembedded.org;
	Thu, 31 Jan 2013 13:54:15 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 31 Jan 2013 04:38:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,576,1355126400"; d="scan'208";a="250739314"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 31 Jan 2013 04:38:27 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Jan 2013 14:43:08 +0200
Message-Id: <1359636188-21699-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: remove save/load template functionality
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
X-List-Received-Date: Thu, 31 Jan 2013 12:54:18 -0000

The Hob templates functionality, in its current incarnation,
is confusing and has no clear utility.

[YOCTO #3696]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py                |   33 ---------------
 bitbake/lib/bb/ui/crumbs/hobwidget.py              |    2 -
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   13 ------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |   42 +-------------------
 .../bb/ui/icons/templates/templates_display.png    |  Bin 5651 -> 0 bytes
 .../lib/bb/ui/icons/templates/templates_hover.png  |  Bin 5791 -> 0 bytes
 6 files changed, 1 insertion(+), 89 deletions(-)
 delete mode 100644 bitbake/lib/bb/ui/icons/templates/templates_display.png
 delete mode 100644 bitbake/lib/bb/ui/icons/templates/templates_hover.png

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 9da926d..1a38e75 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1225,39 +1225,6 @@ class Builder(gtk.Window):
                 self.update_config_async()
         dialog.destroy()
 
-    def show_load_template_dialog(self):
-        dialog = gtk.FileChooserDialog("Load Template Files", self,
-                                       gtk.FILE_CHOOSER_ACTION_OPEN)
-        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
-        HobAltButton.style_button(button)
-        button = dialog.add_button("Open", gtk.RESPONSE_YES)
-        HobButton.style_button(button)
-        filter = gtk.FileFilter()
-        filter.set_name("Hob Files")
-        filter.add_pattern("*.hob")
-        dialog.add_filter(filter)
-
-        response = dialog.run()
-        path = None
-        if response == gtk.RESPONSE_YES:
-            path = dialog.get_filename()
-        dialog.destroy()
-        return response == gtk.RESPONSE_YES, path
-
-    def show_save_template_dialog(self):
-        dialog = gtk.FileChooserDialog("Save Template Files", self,
-                                       gtk.FILE_CHOOSER_ACTION_SAVE)
-        button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
-        HobAltButton.style_button(button)
-        button = dialog.add_button("Save", gtk.RESPONSE_YES)
-        HobButton.style_button(button)
-        dialog.set_current_name("hob")
-        response = dialog.run()
-        if response == gtk.RESPONSE_YES:
-            path = dialog.get_filename()
-            self.save_template(path)
-        dialog.destroy()
-
     def get_image_extension(self):
         image_extension = {}
         for type in self.parameters.image_types:
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 3ca9066..0bdae3b 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -44,8 +44,6 @@ class hic:
     ICON_PACKAGES_HOVER_FILE      = os.path.join(HOB_ICON_BASE_DIR, ('packages/packages_hover.png'))
     ICON_LAYERS_DISPLAY_FILE      = os.path.join(HOB_ICON_BASE_DIR, ('layers/layers_display.png'))
     ICON_LAYERS_HOVER_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('layers/layers_hover.png'))
-    ICON_TEMPLATES_DISPLAY_FILE   = os.path.join(HOB_ICON_BASE_DIR, ('templates/templates_display.png'))
-    ICON_TEMPLATES_HOVER_FILE     = os.path.join(HOB_ICON_BASE_DIR, ('templates/templates_hover.png'))
     ICON_IMAGES_DISPLAY_FILE      = os.path.join(HOB_ICON_BASE_DIR, ('images/images_display.png'))
     ICON_IMAGES_HOVER_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('images/images_hover.png'))
     ICON_SETTINGS_DISPLAY_FILE    = os.path.join(HOB_ICON_BASE_DIR, ('settings/settings_display.png'))
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index a0cbe85..3b14205 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -55,12 +55,6 @@ class ImageConfigurationPage (HobPage):
         self.toolbar.set_orientation(gtk.ORIENTATION_HORIZONTAL)
         self.toolbar.set_style(gtk.TOOLBAR_BOTH)
 
-        template_button = self.append_toolbar_button(self.toolbar,
-            "Templates",
-            hic.ICON_TEMPLATES_DISPLAY_FILE,
-            hic.ICON_TEMPLATES_HOVER_FILE,
-            "Load a previously saved template",
-            self.template_button_clicked_cb)
         my_images_button = self.append_toolbar_button(self.toolbar,
             "Images",
             hic.ICON_IMAGES_DISPLAY_FILE,
@@ -486,13 +480,6 @@ class ImageConfigurationPage (HobPage):
         self.builder.configuration.initial_selected_image = self.builder.configuration.selected_image
         self.builder.show_recipes()
 
-    def template_button_clicked_cb(self, button):
-        response, path = self.builder.show_load_template_dialog()
-        if not response:
-            return
-        if path:
-            self.builder.load_template(path)
-
     def my_images_button_clicked_cb(self, button):
         self.builder.show_load_my_images_dialog()
 
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 1b60aa8..d586413 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -197,12 +197,6 @@ class ImageDetailsPage (HobPage):
         self.toolbar.set_orientation(gtk.ORIENTATION_HORIZONTAL)
         self.toolbar.set_style(gtk.TOOLBAR_BOTH)
 
-        template_button = self.append_toolbar_button(self.toolbar,
-            "Templates",
-            hic.ICON_TEMPLATES_DISPLAY_FILE,
-            hic.ICON_TEMPLATES_HOVER_FILE,
-            "Load a previously saved template",
-            self.template_button_clicked_cb)
         my_images_button = self.append_toolbar_button(self.toolbar,
             "Images",
             hic.ICON_IMAGES_DISPLAY_FILE,
@@ -265,11 +259,7 @@ class ImageDetailsPage (HobPage):
             self.build_result = self.BuildDetailBox(varlist=varlist, vallist=vallist, icon=icon, color=color)
             self.box_group_area.pack_start(self.build_result, expand=False, fill=False)
 
-        # create the buttons at the bottom first because the buttons are used in apply_button_per_image()
-        if self.build_succeeded:
-            self.buttonlist = ["Build new image", "Save as template", "Run image", "Deploy image"]
-        else: # get to this page from "My images"
-            self.buttonlist = ["Build new image", "Run image", "Deploy image"]
+        self.buttonlist = ["Build new image", "Run image", "Deploy image"]
 
         # Name
         self.image_store = []
@@ -582,26 +572,6 @@ class ImageDetailsPage (HobPage):
             created = True
             is_runnable = True
 
-        name = "Save as template"
-        if name in buttonlist:
-            if created == True:
-                # separator
-                #label = gtk.Label(" or ")
-                #self.details_bottom_buttons.pack_end(label, expand=False, fill=False)
-
-                # create button "Save as template"
-                save_button = HobAltButton("Save as template")
-            else:
-                save_button = HobButton("Save as template")
-                #save_button.set_size_request(205, 49)
-                save_button.set_flags(gtk.CAN_DEFAULT)
-                packed = True
-            save_button.set_tooltip_text("Save the image configuration for reuse")
-            button_id = save_button.connect("clicked", self.save_button_clicked_cb)
-            self.button_ids[button_id] = save_button
-            self.details_bottom_buttons.pack_end(save_button, expand=False, fill=False)
-            create = True
-
         name = "Build new image"
         if name in buttonlist:
             # create button "Build new image"
@@ -618,9 +588,6 @@ class ImageDetailsPage (HobPage):
 
         return is_runnable
 
-    def save_button_clicked_cb(self, button):
-        self.builder.show_save_template_dialog()
-
     def deploy_button_clicked_cb(self, button):
         if self.toggled_image:
             if self.num_toggled > 1:
@@ -648,13 +615,6 @@ class ImageDetailsPage (HobPage):
     def edit_packages_button_clicked_cb(self, button):
         self.builder.show_packages(ask=False)
 
-    def template_button_clicked_cb(self, button):
-        response, path = self.builder.show_load_template_dialog()
-        if not response:
-            return
-        if path:
-            self.builder.load_template(path)
-
     def my_images_button_clicked_cb(self, button):
         self.builder.show_load_my_images_dialog()
 
diff --git a/bitbake/lib/bb/ui/icons/templates/templates_display.png b/bitbake/lib/bb/ui/icons/templates/templates_display.png
deleted file mode 100644
index 153c7afb621a3a9562f57b3e7908e5d7409aabf0..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 5651
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

diff --git a/bitbake/lib/bb/ui/icons/templates/templates_hover.png b/bitbake/lib/bb/ui/icons/templates/templates_hover.png
deleted file mode 100644
index afb7165fe5ff8f54083a37533f085787e266825a..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 5791
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
Q`yT+Hsj8<^rEDAVKdzq=*Z=?k

-- 
1.7.9.5



