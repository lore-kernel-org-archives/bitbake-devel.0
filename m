Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ioanax.grigoropol@intel.com>) id 1TGRbr-00056h-D6
	for bitbake-devel@lists.openembedded.org;
	Tue, 25 Sep 2012 11:39:20 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 25 Sep 2012 02:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,481,1344236400"; d="scan'208";a="226138102"
Received: from ideapad (HELO localhost.localdomain) ([10.237.105.40])
	by fmsmga001.fm.intel.com with ESMTP; 25 Sep 2012 02:25:23 -0700
From: Ioana Grigoropol <ioanax.grigoropol@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Sep 2012 12:21:05 +0300
Message-Id: <1348564865-23697-1-git-send-email-ioanax.grigoropol@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: Buttons width and height are taken for host
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
X-List-Received-Date: Tue, 25 Sep 2012 09:39:20 -0000

- removed all set_size_request calls for buttons in order to:
	- force autosizing of buttons with regard to the text length
	- use host theme default height for buttons
- modified buttons on image details page to have the same height (default host one) and the width of the button with the largest text
- modified Stop button on build details page to have the default height by directly attaching it to the containing table instead of hbox

Signed-off-by: Ioana Grigoropol <ioanax.grigoropol@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py       |   12 +--
 bitbake/lib/bb/ui/crumbs/hig.py                    |    2 +-
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |   15 +--
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |  101 ++++++++++++++++----
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |    2 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py    |    2 +-
 6 files changed, 102 insertions(+), 32 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index a927c21..5add31d 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -165,7 +165,7 @@ class BuildDetailsPage (HobPage):
         self.builder.handler.build.model.connect_after("row-changed", self.scroll_to_present_row, self.scrolled_view_build.get_vadjustment(), self.build_tv)
 
         self.button_box = gtk.HBox(False, 6)
-        self.back_button = HobAltButton('&lt;&lt; Back')
+        self.back_button = HobAltButton('<< Back')
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         self.button_box.pack_start(self.back_button, expand=False, fill=False)
 
@@ -206,7 +206,7 @@ class BuildDetailsPage (HobPage):
 
         color = HobColors.ERROR
         build_fail_top = gtk.EventBox()
-        build_fail_top.set_size_request(-1, 200)
+        #build_fail_top.set_size_request(-1, 200)
         build_fail_top.modify_bg(gtk.STATE_NORMAL, gtk.gdk.color_parse(color))
 
         build_fail_tab = gtk.Table(14, 46, True)
@@ -229,7 +229,7 @@ class BuildDetailsPage (HobPage):
 
         # create button 'Edit packages'
         action_button = HobButton(primary_action)
-        action_button.set_size_request(-1, 40)
+        #action_button.set_size_request(-1, 40)
         action_button.set_tooltip_text("Edit the %s parameters" % actions)
         action_button.connect('clicked', self.failure_primary_action_button_clicked_cb, primary_action)
         build_fail_tab.attach(action_button, 4, 13, 9, 12)
@@ -269,7 +269,7 @@ class BuildDetailsPage (HobPage):
     def add_build_stop_top_bar(self, action, log_file=None):
         color = HobColors.LIGHT_GRAY
         build_stop_top = gtk.EventBox()
-        build_stop_top.set_size_request(-1, 200)
+        #build_stop_top.set_size_request(-1, 200)
         build_stop_top.modify_bg(gtk.STATE_NORMAL, gtk.gdk.color_parse(color))
         build_stop_top.set_flags(gtk.CAN_DEFAULT)
         build_stop_top.grab_default()
@@ -288,7 +288,7 @@ class BuildDetailsPage (HobPage):
         build_stop_tab.attach(label, 4, 26, 0, 6)
 
         action_button = HobButton("Edit %s" % action)
-        action_button.set_size_request(-1, 40)
+        #action_button.set_size_request(-1, 40)
         action_button.set_tooltip_text("Edit the %s parameters" % action)
         action_button.connect('clicked', self.stop_primary_action_button_clicked_cb, action)
         build_stop_tab.attach(action_button, 4, 13, 6, 9)
@@ -302,7 +302,7 @@ class BuildDetailsPage (HobPage):
 
         attach_pos = (24 if log_file else 14)
         build_button = HobAltButton("Build new image")
-        build_button.set_size_request(-1, 40)
+        #build_button.set_size_request(-1, 40)
         build_button.set_tooltip_text("Create a new image from scratch")
         build_button.connect('clicked', self.new_image_button_clicked_cb)
         build_stop_tab.attach(build_button, attach_pos, attach_pos + 9, 6, 9)
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index f304a68..fbce362 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -902,7 +902,7 @@ class DeployImageDialog (CrumbsDialog):
                 icon.set_from_pixbuf(pix_buffer)
                 button = gtk.Button("Select Image")
                 button.set_image(icon)
-                button.set_size_request(140, 50)
+                #button.set_size_request(140, 50)
                 table.attach(button, 9, 10, 1, 2, gtk.FILL, 0, 0, 0)
                 button.connect("clicked", self.select_image_button_clicked_cb)
 
diff --git a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
index cf7af2b..e1c7a67 100644
--- a/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
+++ b/bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py
@@ -167,13 +167,12 @@ class ImageConfigurationPage (HobPage):
         markup += "dev-manual.html#understanding-and-using-layers\">reference manual</a>."
         self.layer_info_icon = HobInfoButton(markup, self.get_parent())
 
-        self.progress_box = gtk.HBox(False, 6)
+#        self.progress_box = gtk.HBox(False, 6)
         self.progress_bar = HobProgressBar()
-        self.progress_box.pack_start(self.progress_bar, expand=True, fill=True)
+#        self.progress_box.pack_start(self.progress_bar, expand=True, fill=True)
         self.stop_button = HobAltButton("Stop")
         self.stop_button.connect("clicked", self.stop_button_clicked_cb)
-        self.progress_box.pack_end(self.stop_button, expand=False, fill=False)
-
+#        self.progress_box.pack_end(stop_button, expand=False, fill=False)
         self.machine_separator = gtk.HSeparator()
 
     def set_config_machine_layout(self, show_progress_bar = False):
@@ -183,7 +182,9 @@ class ImageConfigurationPage (HobPage):
         self.gtable.attach(self.layer_button, 14, 36, 7, 12)
         self.gtable.attach(self.layer_info_icon, 36, 40, 7, 11)
         if show_progress_bar:
-            self.gtable.attach(self.progress_box, 0, 40, 15, 19)
+            #self.gtable.attach(self.progress_box, 0, 40, 15, 18)
+            self.gtable.attach(self.progress_bar, 0, 37, 15, 18)
+            self.gtable.attach(self.stop_button, 37, 40, 15, 18, 0, 0)
         self.gtable.attach(self.machine_separator, 0, 40, 13, 14)
 
     def create_config_baseimg(self):
@@ -232,14 +233,14 @@ class ImageConfigurationPage (HobPage):
 
         # create button "Build image"
         self.just_bake_button = HobButton("Build image")
-        self.just_bake_button.set_size_request(205, 49)
+        #self.just_bake_button.set_size_request(205, 49)
         self.just_bake_button.set_tooltip_text("Build target image")
         self.just_bake_button.connect("clicked", self.just_bake_button_clicked_cb)
         button_box.pack_end(self.just_bake_button, expand=False, fill=False)
 
         # create button "Edit Image"
         self.edit_image_button = HobAltButton("Edit image")
-        self.edit_image_button.set_size_request(205, 49)
+        #self.edit_image_button.set_size_request(205, 49)
         self.edit_image_button.set_tooltip_text("Edit target image")
         self.edit_image_button.connect("clicked", self.edit_image_button_clicked_cb)
         button_box.pack_end(self.edit_image_button, expand=False, fill=False)
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 1af67f2..a843ad4 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -41,10 +41,10 @@ class ImageDetailsPage (HobPage):
             style.bg[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(color, False, False)
             self.set_style(style)
 
-            self.hbox = gtk.HBox()
-            self.hbox.set_border_width(10)
-            self.add(self.hbox)
-
+            self.row = gtk.Table(1, 2, False)
+            self.row.set_border_width(10)
+            self.add(self.row)
+        
             total_rows = 0
             if widget:
                 total_rows = 10
@@ -54,8 +54,8 @@ class ImageDetailsPage (HobPage):
             self.table = gtk.Table(total_rows, 20, True)
             self.table.set_row_spacings(6)
             self.table.set_size_request(100, -1)
-            self.hbox.pack_start(self.table, expand=True, fill=True, padding=15)
-
+            self.row.attach(self.table, 0, 1, 0, 1, xoptions=gtk.FILL|gtk.EXPAND, yoptions=gtk.FILL)
+            
             colid = 0
             rowid = 0
             self.line_widgets = {}
@@ -73,11 +73,80 @@ class ImageDetailsPage (HobPage):
             # pack the button on the right
             if button:
                 self.bbox = gtk.VBox()
-                self.bbox.pack_start(button, expand=True, fill=True)
+                self.bbox.pack_start(button, expand=True, fill=False)
                 if button2:
-                    self.bbox.pack_start(button2, expand=True, fill=True)
-                self.hbox.pack_end(self.bbox, expand=False, fill=False)
+                    self.bbox.pack_start(button2, expand=True, fill=False)
+                self.bbox.set_size_request(150,-1)
+                self.row.attach(self.bbox, 1, 2, 0, 1, xoptions=gtk.FILL, yoptions=gtk.EXPAND)
+                
+        def update_line_widgets(self, variable, value):
+            if len(self.line_widgets) == 0:
+                return
+            if not isinstance(self.line_widgets[variable], gtk.Label):
+                return
+            self.line_widgets[variable].set_markup(self.format_line(variable, value))
+
+        def wrap_line(self, inputs):
+            # wrap the long text of inputs
+            wrap_width_chars = 75
+            outputs = ""
+            tmps = inputs
+            less_chars = len(inputs)
+            while (less_chars - wrap_width_chars) > 0:
+                less_chars -= wrap_width_chars
+                outputs += tmps[:wrap_width_chars] + "\n               "
+                tmps = inputs[less_chars:]
+            outputs += tmps
+            return outputs
+
+        def format_line(self, variable, value):
+            wraped_value = self.wrap_line(value)
+            markup = "<span weight=\'bold\'>%s</span>" % variable
+            markup += "<span weight=\'normal\' foreground=\'#1c1c1c\' font_desc=\'14px\'>%s</span>" % wraped_value
+            return markup
+
+        def text2label(self, variable, value):
+            # append the name:value to the left box
+            # such as "Name: hob-core-minimal-variant-2011-12-15-beagleboard"
+            label = gtk.Label()
+            label.set_alignment(0.0, 0.5)
+            label.set_markup(self.format_line(variable, value))
+            return label
+
+    class BuildDetailBox (gtk.EventBox):
+        def __init__(self, varlist = None, vallist = None, icon = None, color = HobColors.LIGHT_GRAY):
+            gtk.EventBox.__init__(self)
+
+            # set color
+            style = self.get_style().copy()
+            style.bg[gtk.STATE_NORMAL] = self.get_colormap().alloc_color(color, False, False)
+            self.set_style(style)
 
+            self.hbox = gtk.HBox()
+            self.hbox.set_border_width(10)
+            self.add(self.hbox)
+
+            total_rows = 0
+            if varlist and vallist:
+                # pack the icon and the text on the left
+                total_rows += len(varlist)
+            self.table = gtk.Table(total_rows, 20, True)
+            self.table.set_row_spacings(6)
+            self.table.set_size_request(100, -1)
+            self.hbox.pack_start(self.table, expand=True, fill=True, padding=15)
+
+            colid = 0
+            rowid = 0
+            self.line_widgets = {}
+            if icon:
+                self.table.attach(icon, colid, colid + 2, 0, 1)
+                colid = colid + 2
+            if varlist and vallist:
+                for row in range(rowid, total_rows):
+                    index = row - rowid
+                    self.line_widgets[varlist[index]] = self.text2label(varlist[index], vallist[index])
+                    self.table.attach(self.line_widgets[varlist[index]], colid, 20, row, row + 1)
+                
         def update_line_widgets(self, variable, value):
             if len(self.line_widgets) == 0:
                 return
@@ -192,7 +261,7 @@ class ImageDetailsPage (HobPage):
             icon.set_from_pixbuf(pix_buffer)
             varlist = [""]
             vallist = ["Your image is ready"]
-            self.build_result = self.DetailBox(varlist=varlist, vallist=vallist, icon=icon, color=color)
+            self.build_result = self.BuildDetailBox(varlist=varlist, vallist=vallist, icon=icon, color=color)
             self.box_group_area.pack_start(self.build_result, expand=False, fill=False)
 
         # create the buttons at the bottom first because the buttons are used in apply_button_per_image()
@@ -271,7 +340,7 @@ class ImageDetailsPage (HobPage):
             change_kernel_button.connect("clicked", self.change_kernel_cb)
             change_kernel_button.set_tooltip_text("Change qemu kernel file")
             self.kernel_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=change_kernel_button)
-            self.box_group_area.pack_start(self.kernel_detail, expand=False, fill=False)
+            self.box_group_area.pack_start(self.kernel_detail, expand=True, fill=True)
 
         # Machine, Base image and Layers
         layer_num_limit = 15
@@ -316,7 +385,7 @@ class ImageDetailsPage (HobPage):
         else: # get to this page from "My images"
             edit_packages_button = None
         self.package_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_packages_button)
-        self.box_group_area.pack_start(self.package_detail, expand=False, fill=False)
+        self.box_group_area.pack_start(self.package_detail, expand=True, fill=True)
 
         # pack the buttons at the bottom, at this time they are already created.
         if self.build_succeeded:
@@ -478,7 +547,7 @@ class ImageDetailsPage (HobPage):
         name = "Deploy image"
         if name in buttonlist and self.test_deployable(image_name):
             deploy_button = HobButton('Deploy image')
-            deploy_button.set_size_request(205, 49)
+            #deploy_button.set_size_request(205, 49)
             deploy_button.set_tooltip_text("Burn a live image to a USB drive or flash memory")
             deploy_button.set_flags(gtk.CAN_DEFAULT)
             button_id = deploy_button.connect("clicked", self.deploy_button_clicked_cb)
@@ -499,7 +568,7 @@ class ImageDetailsPage (HobPage):
             else:
                 # create button "Run image" as the primary button
                 run_button = HobButton("Run image")
-                run_button.set_size_request(205, 49)
+                #run_button.set_size_request(205, 49)
                 run_button.set_flags(gtk.CAN_DEFAULT)
                 packed = True
             run_button.set_tooltip_text("Start up an image with qemu emulator")
@@ -520,7 +589,7 @@ class ImageDetailsPage (HobPage):
                 save_button = HobAltButton("Save as template")
             else:
                 save_button = HobButton("Save as template")
-                save_button.set_size_request(205, 49)
+                #save_button.set_size_request(205, 49)
                 save_button.set_flags(gtk.CAN_DEFAULT)
                 packed = True
             save_button.set_tooltip_text("Save the image configuration for reuse")
@@ -537,7 +606,7 @@ class ImageDetailsPage (HobPage):
             else:
                 build_new_button = HobButton("Build new image")
                 build_new_button.set_flags(gtk.CAN_DEFAULT)
-            build_new_button.set_size_request(205, 49)
+            #build_new_button.set_size_request(205, 49)
             self.details_bottom_buttons.pack_end(build_new_button, expand=False, fill=False)
             build_new_button.set_tooltip_text("Create a new image from scratch")
             button_id = build_new_button.connect("clicked", self.build_new_button_clicked_cb)
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 7e7828b..cea226e 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -146,7 +146,7 @@ class PackageSelectionPage (HobPage):
         self.box_group_area.pack_start(self.button_box, expand=False, fill=False)
 
         self.build_image_button = HobButton('Build image')
-        self.build_image_button.set_size_request(205, 49)
+        #self.build_image_button.set_size_request(205, 49)
         self.build_image_button.set_tooltip_text("Build target image")
         self.build_image_button.set_flags(gtk.CAN_DEFAULT)
         self.build_image_button.grab_default()
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index f252202..8655c29 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -170,7 +170,7 @@ class RecipeSelectionPage (HobPage):
         self.box_group_area.pack_end(button_box, expand=False, fill=False)
 
         self.build_packages_button = HobButton('Build packages')
-        self.build_packages_button.set_size_request(205, 49)
+        #self.build_packages_button.set_size_request(205, 49)
         self.build_packages_button.set_tooltip_text("Build selected recipes into packages")
         self.build_packages_button.set_flags(gtk.CAN_DEFAULT)
         self.build_packages_button.grab_default()
-- 
1.7.9.5



