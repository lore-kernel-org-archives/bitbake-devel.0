Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SGpI2-0004ss-FO
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Apr 2012 12:24:10 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 08 Apr 2012 03:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="126572398"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 08 Apr 2012 03:14:55 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Apr 2012 18:21:22 +0800
Message-Id: <2b94078dc73eb964cc51de9c46dcfaed1f3855d1.1333880210.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333880210.git.shane.wang@intel.com>
In-Reply-To: <cover.1333880210.git.shane.wang@intel.com>
References: <cover.1333880210.git.shane.wang@intel.com>
Subject: [PATCH 19/20] Hob: add tooltips into image details screen
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
X-List-Received-Date: Sun, 08 Apr 2012 10:24:10 -0000

[Yocto #2243]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index e550653..3eb6bcf 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -126,19 +126,19 @@ class ImageDetailsPage (HobPage):
             "Templates",
             hic.ICON_TEMPLATES_DISPLAY_FILE,
             hic.ICON_TEMPLATES_HOVER_FILE,
-            "Load a hob building template saved before",
+            "Load a previously saved template",
             self.template_button_clicked_cb)
         my_images_button = self.append_toolbar_button(self.toolbar,
-            "My images",
+            "Images",
             hic.ICON_IMAGES_DISPLAY_FILE,
             hic.ICON_IMAGES_HOVER_FILE,
-            "Open images built out previously for running or deployment",
+            "Open previously built images",
             self.my_images_button_clicked_cb)
         settings_button = self.append_toolbar_button(self.toolbar,
             "Settings",
             hic.ICON_SETTINGS_DISPLAY_FILE,
             hic.ICON_SETTINGS_HOVER_FILE,
-            "Other advanced settings for build",
+            "View additional build settings",
             self.settings_button_clicked_cb)
 
         self.details_top_buttons = self.add_onto_top_bar(self.toolbar)
@@ -206,6 +206,7 @@ class ImageDetailsPage (HobPage):
         image_table.connect("toggled", self.toggled_cb)
         view_files_button = HobAltButton("View files")
         view_files_button.connect("clicked", self.view_files_clicked_cb, image_addr)
+        view_files_button.set_tooltip_text("Open the directory containing the image files")
         self.box_group_area.pack_start(self.DetailBox(widget=image_table, button=view_files_button), expand=True, fill=True)
 
         # Machine, Base image and Layers
@@ -233,6 +234,7 @@ class ImageDetailsPage (HobPage):
                 i += 1
 
             edit_config_button = HobAltButton("Edit configuration")
+            edit_config_button.set_tooltip_text("Edit machine, base image and recipes")
             edit_config_button.connect("clicked", self.edit_config_button_clicked_cb)
             setting_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_config_button)
             self.box_group_area.pack_start(setting_detail, expand=False, fill=False)
@@ -244,6 +246,7 @@ class ImageDetailsPage (HobPage):
         vallist.append(default_image_size)
         if build_succeeded:
             edit_packages_button = HobAltButton("Edit packages")
+            edit_packages_button.set_tooltip_text("Edit the packages included in your image")
             edit_packages_button.connect("clicked", self.edit_packages_button_clicked_cb)
         else: # get to this page from "My images"
             edit_packages_button = None
@@ -316,7 +319,7 @@ class ImageDetailsPage (HobPage):
         if name in buttonlist:
             self.deploy_button = HobButton('Deploy image')
             self.deploy_button.set_size_request(205, 49)
-            self.deploy_button.set_tooltip_text("Deploy image to get your target board")
+            self.deploy_button.set_tooltip_text("Burn a live image to a USB drive or flash memory")
             self.deploy_button.set_flags(gtk.CAN_DEFAULT)
             self.deploy_button.connect("clicked", self.deploy_button_clicked_cb)
             bottom_buttons.pack_end(self.deploy_button, expand=False, fill=False)
@@ -331,6 +334,7 @@ class ImageDetailsPage (HobPage):
 
             # create button "Run image"
             self.run_button = HobAltButton("Run image")
+            self.run_button.set_tooltip_text("Start up an image with qemu emulator")
             self.run_button.connect("clicked", self.run_button_clicked_cb)
             bottom_buttons.pack_end(self.run_button, expand=False, fill=False)
             created = True
@@ -344,6 +348,7 @@ class ImageDetailsPage (HobPage):
 
             # create button "Save as template"
             save_button = HobAltButton("Save as template")
+            save_button.set_tooltip_text("Save the image configuration for reuse")
             save_button.connect("clicked", self.save_button_clicked_cb)
             bottom_buttons.pack_end(save_button, expand=False, fill=False)
             create = True
@@ -352,6 +357,7 @@ class ImageDetailsPage (HobPage):
         if name in buttonlist:
             # create button "Build new image"
             build_new_button = HobAltButton("Build new image")
+            build_new_button.set_tooltip_text("Create a new image from scratch")
             build_new_button.connect("clicked", self.build_new_button_clicked_cb)
             bottom_buttons.pack_start(build_new_button, expand=False, fill=False)
 
-- 
1.7.6



