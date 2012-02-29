Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kQl-0005pa-4g
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:22:59 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 06:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="116107737"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 29 Feb 2012 06:14:31 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:23 +0800
Message-Id: <299485306af5bd05f9cd47185e2ed4fe35b4b3c4.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 26/32] Hob: fix a bug that the image size is shown incorrectly in the image details page.
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
X-List-Received-Date: Wed, 29 Feb 2012 14:22:59 -0000

Originally, the image size shows the last item in the image tree view in the image details page.
That is not correct. We need to show the size of the image which the user chooses.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py              |    2 +-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   32 +++++++++++++++++++------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 9b96d8d..c5bd27a 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -1035,6 +1035,7 @@ class ImageSelectionDialog (CrumbsDialog):
         table.attach(open_button, 9, 10, 0, 1)
 
         self.image_table = HobViewTable(self.__columns__)
+        self.image_table.set_size_request(-1, 300)
         self.image_table.connect("toggled", self.toggled_cb)
         self.vbox.pack_start(self.image_table, expand=True, fill=True)
 
@@ -1052,7 +1053,6 @@ class ImageSelectionDialog (CrumbsDialog):
 
         model[path][columnid] = True
 
-        
     def select_path_cb(self, action, parent, entry):
         dialog = gtk.FileChooserDialog("", parent,
                                        gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 7f93db7..833c149 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -74,6 +74,7 @@ class ImageDetailsPage (HobPage):
             self.hbox.pack_start(self.table, expand=True, fill=True, padding=15)
 
             colid = 0
+            self.line_widgets = {}
             if icon != None:
                 self.table.attach(icon, colid, colid + 2, 0, 1)
                 colid = colid + 2
@@ -81,20 +82,31 @@ class ImageDetailsPage (HobPage):
                 self.table.attach(widget, colid, 20, 0, 1)
             elif varlist != None and vallist != None:
                 for line in range(0, row):
-                    self.table.attach(self.text2label(varlist[line], vallist[line]), colid, 20, line, line + 1)
+                    self.line_widgets[varlist[line]] = self.text2label(varlist[line], vallist[line])
+                    self.table.attach(self.line_widgets[varlist[line]], colid, 20, line, line + 1)
 
             # pack the button on the right
             if button != None:
                 self.hbox.pack_end(button, expand=False, fill=False)
 
+        def update_line_widgets(self, variable, value):
+            if len(self.line_widgets) == 0:
+                return
+            if not isinstance(self.line_widgets[variable], gtk.Label):
+                return
+            self.line_widgets[variable].set_markup(self.format_line(variable, value))
+
+        def format_line(self, variable, value):
+            markup = "<span weight=\'bold\'>%s</span>" % variable
+            markup += "<span weight=\'normal\' foreground=\'#1c1c1c\' font_desc=\'14px\'>%s</span>" % value
+            return markup
+
         def text2label(self, variable, value):
             # append the name:value to the left box
             # such as "Name: hob-core-minimal-variant-2011-12-15-beagleboard"
-            markup = "<span weight=\'bold\'>%s</span>" % variable
-            markup += "<span weight=\'normal\' foreground=\'#1c1c1c\' font_desc=\'14px\'>%s</span>" % value
             label = gtk.Label()
             label.set_alignment(0.0, 0.5)
-            label.set_markup(markup)
+            label.set_markup(self.format_line(variable, value))
             return label
 
     def __init__(self, builder):
@@ -141,8 +153,6 @@ class ImageDetailsPage (HobPage):
         image_addr = self.builder.parameters.image_addr
         image_names = self.builder.parameters.image_names
         if build_succeeded:
-            image_addr = self.builder.parameters.image_addr
-            image_names = self.builder.parameters.image_names
             machine = self.builder.configuration.curr_mach
             base_image = self.builder.recipe_model.get_selected_image()
             layers = self.builder.configuration.layers
@@ -174,6 +184,7 @@ class ImageDetailsPage (HobPage):
         image_table = HobViewTable(self.__columns__)
         image_table.set_model(self.image_store)
         image_table.toggle_default()
+        image_size = self._size_to_string(os.stat(os.path.join(image_addr, image_names[0])).st_size)
         image_table.connect("toggled", self.toggled_cb)
         view_files_button = gtk.LinkButton("file://%s" % image_addr, "View files")
         self.box_group_area.pack_start(self.DetailBox(widget=image_table, button=view_files_button), expand=True, fill=True)
@@ -217,8 +228,9 @@ class ImageDetailsPage (HobPage):
             edit_packages_button.connect("clicked", self.edit_packages_button_clicked_cb)
         else: # get to this page from "My images"
             edit_packages_button = None
-        package_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_packages_button)
-        self.box_group_area.pack_start(package_detail, expand=False, fill=False)
+        self.package_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_packages_button)
+        self.box_group_area.pack_start(self.package_detail, expand=False, fill=False)
+
         if build_succeeded:
             buttonlist = ["Build new image", "Save as template", "Run image", "Deploy image"]
         else: # get to this page from "My images"
@@ -228,6 +240,9 @@ class ImageDetailsPage (HobPage):
 
         self.show_all()
 
+    def refresh_package_detail_box(self, image_size):
+        self.package_detail.update_line_widgets("Total image size: ", image_size)
+
     def toggled_cb(self, table, cell, path, columnid, tree):
         model = tree.get_model()
         if not model:
@@ -239,6 +254,7 @@ class ImageDetailsPage (HobPage):
             iter = model.iter_next(iter)
 
         model[path][columnid] = True
+        self.refresh_package_detail_box(model[path][1])
 
     def create_bottom_buttons(self, buttonlist):
         # Create the buttons at the bottom
-- 
1.7.6



