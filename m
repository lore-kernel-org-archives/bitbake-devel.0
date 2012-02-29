Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2k8F-00057w-24
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:03:52 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 05:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113064474"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 29 Feb 2012 05:55:00 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:14:58 +0800
Message-Id: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 01/32] Hob: make HobViewTable more general in hob and make the image selection dialog and the image details page reuse it.
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
X-List-Received-Date: Wed, 29 Feb 2012 14:03:52 -0000

This patch is to make the class HobViewTable more general as a tree view in Hob.
Now the recipe selection page and the package selection page are using it.
And we have tree views in the image selection dialog and the image details page, which used the class methods in HobWidget to create the tree views. That is not good in OO.

So, make them reuse HobViewTable to create its instances.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py                  |   37 +++++-
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |  168 +++++++---------------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |   65 +++++++--
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   28 +++--
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   30 +++--
 5 files changed, 176 insertions(+), 152 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 89dfe03..8f4f7cd 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -28,7 +28,7 @@ import re
 import subprocess
 import shlex
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import HobWidget
+from bb.ui.crumbs.hobwidget import HobWidget, HobViewTable
 from bb.ui.crumbs.progressbar import HobProgressBar
 
 """
@@ -561,6 +561,21 @@ class LayerSelectionDialog (gtk.Dialog):
 
 class ImageSelectionDialog (gtk.Dialog):
 
+    __columns__ = [{
+            'col_name' : 'Image name',
+            'col_id'   : 0,
+            'col_style': 'text',
+            'col_min'  : 400,
+            'col_max'  : 400
+        }, {
+            'col_name' : 'Select',
+            'col_id'   : 1,
+            'col_style': 'radio toggle',
+            'col_min'  : 160,
+            'col_max'  : 160
+    }]
+
+
     def __init__(self, image_folder, image_types, title, parent, flags, buttons):
         super(ImageSelectionDialog, self).__init__(title, parent, flags, buttons)
         self.connect("response", self.response_cb)
@@ -596,11 +611,25 @@ class ImageSelectionDialog (gtk.Dialog):
         open_button.connect("clicked", self.select_path_cb, self, entry)
         table.attach(open_button, 9, 10, 0, 1)
 
-        imgtv_widget, self.imgsel_tv = HobWidget.gen_imgtv_widget(400, 160)
-        self.vbox.pack_start(imgtv_widget, expand=True, fill=True)
+        self.image_table = HobViewTable(self.__columns__)
+        self.image_table.connect("toggled", self.toggled_cb)
+        self.vbox.pack_start(self.image_table, expand=True, fill=True)
 
         self.show_all()
 
+    def toggled_cb(self, table, cell, path, columnid, tree):
+        model = tree.get_model()
+        if not model:
+            return
+        iter = model.get_iter_first()
+        while iter:
+            rowpath = model.get_path(iter)
+            model[rowpath][columnid] = False
+            iter = model.iter_next(iter)
+
+        model[path][columnid] = True
+
+        
     def select_path_cb(self, action, parent, entry):
         dialog = gtk.FileChooserDialog("", parent,
                                        gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER,
@@ -627,7 +656,7 @@ class ImageSelectionDialog (gtk.Dialog):
         for image in imageset:
             self.image_store.set(self.image_store.append(), 0, image, 1, False)
 
-        self.imgsel_tv.set_model(self.image_store)
+        self.image_table.set_model(self.image_store)
 
     def response_cb(self, dialog, response_id):
         self.image_names = []
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 890151d..141c4ef 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -423,104 +423,6 @@ class HobWidget:
         return hbox, layer_store
 
     @classmethod
-    def _toggle_single_cb(cls, cell, select_path, treeview, toggle_column):
-        model = treeview.get_model()
-        if not model:
-            return
-        iter = model.get_iter_first()
-        while iter:
-            path = model.get_path(iter)
-            model[path][toggle_column] = False
-            iter = model.iter_next(iter)
-
-        model[select_path][toggle_column] = True
-
-    @classmethod
-    def gen_imgtv_widget(cls, col0_width, col1_width):
-        vbox = gtk.VBox(False, 10)
-
-        imgsel_tv = gtk.TreeView()
-        imgsel_tv.set_rules_hint(True)
-        imgsel_tv.set_headers_visible(False)
-        tree_selection = imgsel_tv.get_selection()
-        tree_selection.set_mode(gtk.SELECTION_SINGLE)
-
-        col0= gtk.TreeViewColumn('Image name')
-        cell0 = gtk.CellRendererText()
-        cell0.set_padding(5,2)
-        col0.pack_start(cell0, True)
-        col0.set_attributes(cell0, text=0)
-        col0.set_max_width(col0_width)
-        col0.set_min_width(col0_width)
-        imgsel_tv.append_column(col0)
-
-        col1= gtk.TreeViewColumn('Select')
-        cell1 = gtk.CellRendererToggle()
-        cell1.set_padding(5,2)
-        cell1.connect("toggled", cls._toggle_single_cb, imgsel_tv, 1)
-        col1.pack_start(cell1, True)
-        col1.set_attributes(cell1, active=1)
-        col1.set_max_width(col1_width)
-        col1.set_min_width(col1_width)
-        imgsel_tv.append_column(col1)
-
-        scroll = gtk.ScrolledWindow()
-        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
-        scroll.set_shadow_type(gtk.SHADOW_IN)
-        scroll.add(imgsel_tv)
-
-        vbox.pack_start(scroll, expand=True, fill=True)
-
-        return vbox, imgsel_tv
-
-    @classmethod
-    def gen_images_widget(cls, col0_width, col1_width, col2_width):
-        vbox = gtk.VBox(False, 10)
-
-        imgsel_tv = gtk.TreeView()
-        imgsel_tv.set_rules_hint(True)
-        imgsel_tv.set_headers_visible(False)
-        tree_selection = imgsel_tv.get_selection()
-        tree_selection.set_mode(gtk.SELECTION_SINGLE)
-
-        col0= gtk.TreeViewColumn('Image name')
-        cell0 = gtk.CellRendererText()
-        cell0.set_padding(5,2)
-        col0.pack_start(cell0, True)
-        col0.set_attributes(cell0, text=0)
-        col0.set_max_width(col0_width)
-        col0.set_min_width(col0_width)
-        imgsel_tv.append_column(col0)
-
-        col1= gtk.TreeViewColumn('Image size')
-        cell1 = gtk.CellRendererText()
-        cell1.set_padding(5,2)
-        col1.pack_start(cell1, True)
-        col1.set_attributes(cell1, text=1)
-        col1.set_max_width(col1_width)
-        col1.set_min_width(col1_width)
-        imgsel_tv.append_column(col1)
-
-        col2= gtk.TreeViewColumn('Select')
-        cell2 = gtk.CellRendererToggle()
-        cell2.set_padding(5,2)
-        cell2.connect("toggled", cls._toggle_single_cb, imgsel_tv, 2)
-        col2.pack_start(cell2, True)
-        col2.set_attributes(cell2, active=2)
-        col2.set_max_width(col2_width)
-        col2.set_min_width(col2_width)
-        imgsel_tv.append_column(col2)
-
-        scroll = gtk.ScrolledWindow()
-        scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_AUTOMATIC)
-        scroll.set_shadow_type(gtk.SHADOW_IN)
-        scroll.add(imgsel_tv)
-
-        vbox.pack_start(scroll, expand=True, fill=True)
-
-        return vbox, imgsel_tv
-
-    @classmethod
     def _on_add_item_clicked(cls, button, model):
         new_item = ["##KEY##", "##VALUE##"]
 
@@ -617,34 +519,59 @@ class HobViewTable (gtk.VBox):
     """
     A VBox to contain the table for different recipe views and package view
     """
-    def __init__(self, columns, reset_clicked_cb=None, toggled_cb=None):
+    __gsignals__ = {
+         "toggled"      : (gobject.SIGNAL_RUN_LAST,
+                           gobject.TYPE_NONE,
+                          (gobject.TYPE_PYOBJECT,
+                           gobject.TYPE_STRING,
+                           gobject.TYPE_INT,
+                           gobject.TYPE_PYOBJECT,)),
+         "changed"      : (gobject.SIGNAL_RUN_LAST,
+                           gobject.TYPE_NONE,
+                          (gobject.TYPE_PYOBJECT,
+                           gobject.TYPE_PYOBJECT,)),
+    }
+
+    def __init__(self, columns):
         gtk.VBox.__init__(self, False, 6)
         self.table_tree = gtk.TreeView()
         self.table_tree.set_headers_visible(True)
         self.table_tree.set_headers_clickable(True)
         self.table_tree.set_enable_search(True)
-        self.table_tree.set_search_column(0)
+        self.table_tree.set_rules_hint(True)
         self.table_tree.get_selection().set_mode(gtk.SELECTION_SINGLE)
+        self.table_tree.get_selection().connect("changed", self.selection_changed_cb, self.table_tree)
 
         for i in range(len(columns)):
             col = gtk.TreeViewColumn(columns[i]['col_name'])
             col.set_clickable(True)
             col.set_resizable(True)
             col.set_sort_column_id(columns[i]['col_id'])
-            col.set_min_width(columns[i]['col_min'])
-            col.set_max_width(columns[i]['col_max'])
+            if 'col_min' in columns[i].keys():
+                col.set_min_width(columns[i]['col_min'])
+            if 'col_max' in columns[i].keys():
+                col.set_max_width(columns[i]['col_max'])
             self.table_tree.append_column(col)
 
-            if columns[i]['col_style'] == 'toggle':
+            if (not 'col_style' in columns[i].keys()) or columns[i]['col_style'] == 'text':
+                cell = gtk.CellRendererText()
+                col.pack_start(cell, True)
+                col.set_attributes(cell, text=columns[i]['col_id'])
+            elif columns[i]['col_style'] == 'check toggle':
                 cell = gtk.CellRendererToggle()
                 cell.set_property('activatable', True)
-                cell.connect("toggled", toggled_cb, self.table_tree)
+                cell.connect("toggled", self.toggled_cb, i, self.table_tree)
+                self.toggle_id = i
+                col.pack_end(cell, True)
+                col.set_attributes(cell, active=columns[i]['col_id'])
+            elif columns[i]['col_style'] == 'radio toggle':
+                cell = gtk.CellRendererToggle()
+                cell.set_property('activatable', True)
+                cell.set_radio(True)
+                cell.connect("toggled", self.toggled_cb, i, self.table_tree)
+                self.toggle_id = i
                 col.pack_end(cell, True)
                 col.set_attributes(cell, active=columns[i]['col_id'])
-            elif columns[i]['col_style'] == 'text':
-                cell = gtk.CellRendererText()
-                col.pack_start(cell, True)
-                col.set_attributes(cell, text=columns[i]['col_id'])
 
         scroll = gtk.ScrolledWindow()
         scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
@@ -652,12 +579,27 @@ class HobViewTable (gtk.VBox):
         scroll.add(self.table_tree)
         self.pack_start(scroll, True, True, 0)
 
-        hbox = gtk.HBox(False, 5)
-        button = gtk.Button("Reset")
-        button.connect('clicked', reset_clicked_cb)
-        hbox.pack_end(button, False, False, 0)
+    def set_model(self, tree_model):
+        self.table_tree.set_model(tree_model)
+
+    def set_search_entry(self, search_column_id, entry):
+        self.table_tree.set_search_column(search_column_id)
+        self.table_tree.set_search_entry(entry)
+
+    def toggle_default(self):
+        model = self.table_tree.get_model()
+        if not model:
+            return
+        iter = model.get_iter_first()
+        if iter:
+            rowpath = model.get_path(iter)
+            model[rowpath][self.toggle_id] = True
+
+    def toggled_cb(self, cell, path, columnid, tree):
+        self.emit("toggled", cell, path, columnid, tree)
 
-        self.pack_start(hbox, False, False, 0)
+    def selection_changed_cb(self, selection, tree):
+        self.emit("changed", selection, tree)
 
 class HobViewBar (gtk.EventBox):
     """
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index e8419e0..7f93db7 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -23,7 +23,7 @@
 import gobject
 import gtk
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hic, HobWidget
+from bb.ui.crumbs.hobwidget import hic, HobViewTable
 from bb.ui.crumbs.hobpages import HobPage
 
 #
@@ -31,8 +31,28 @@ from bb.ui.crumbs.hobpages import HobPage
 #
 class ImageDetailsPage (HobPage):
 
+    __columns__ = [{
+            'col_name' : 'Image name',
+            'col_id'   : 0,
+            'col_style': 'text',
+            'col_min'  : 500,
+            'col_max'  : 500
+        }, {
+            'col_name' : 'Image size',
+            'col_id'   : 1,
+            'col_style': 'text',
+            'col_min'  : 100,
+            'col_max'  : 100
+        }, {
+            'col_name' : 'Select',
+            'col_id'   : 2,
+            'col_style': 'radio toggle',
+            'col_min'  : 100,
+            'col_max'  : 100
+    }]
+
     class DetailBox (gtk.EventBox):
-        def __init__(self, varlist, vallist, icon = None, button = None, color = HobColors.LIGHT_GRAY):
+        def __init__(self, widget = None, varlist = None, vallist = None, icon = None, button = None, color = HobColors.LIGHT_GRAY):
             gtk.EventBox.__init__(self)
 
             # set color
@@ -44,8 +64,11 @@ class ImageDetailsPage (HobPage):
             self.hbox.set_border_width(15)
             self.add(self.hbox)
 
-            # pack the icon and the text on the left
-            row = len(varlist)
+            if widget != None:
+                row = 1
+            elif varlist != None and vallist != None:
+                # pack the icon and the text on the left
+                row = len(varlist)
             self.table = gtk.Table(row, 20, True)
             self.table.set_size_request(100, -1)
             self.hbox.pack_start(self.table, expand=True, fill=True, padding=15)
@@ -54,8 +77,11 @@ class ImageDetailsPage (HobPage):
             if icon != None:
                 self.table.attach(icon, colid, colid + 2, 0, 1)
                 colid = colid + 2
-            for line in range(0, row):
-                self.table.attach(self.text2label(varlist[line], vallist[line]), colid, 20, line, line + 1)
+            if widget != None:
+                self.table.attach(widget, colid, 20, 0, 1)
+            elif varlist != None and vallist != None:
+                for line in range(0, row):
+                    self.table.attach(self.text2label(varlist[line], vallist[line]), colid, 20, line, line + 1)
 
             # pack the button on the right
             if button != None:
@@ -137,7 +163,7 @@ class ImageDetailsPage (HobPage):
             icon.set_from_pixbuf(pix_buffer)
             varlist = [""]
             vallist = ["Your image is ready"]
-            build_result = self.DetailBox(varlist=varlist, vallist=vallist, icon=icon, button=None, color=color)
+            build_result = self.DetailBox(varlist=varlist, vallist=vallist, icon=icon, color=color)
             self.box_group_area.pack_start(build_result, expand=False, fill=False)
 
         # Name
@@ -145,9 +171,12 @@ class ImageDetailsPage (HobPage):
         for image_name in image_names:
             image_size = self._size_to_string(os.stat(os.path.join(image_addr, image_name)).st_size)
             self.image_store.set(self.image_store.append(), 0, image_name, 1, image_size, 2, False)
-        images_widget, treeview = HobWidget.gen_images_widget(600, 200, 100)
-        treeview.set_model(self.image_store)
-        self.box_group_area.pack_start(images_widget, expand=False, fill=False)
+        image_table = HobViewTable(self.__columns__)
+        image_table.set_model(self.image_store)
+        image_table.toggle_default()
+        image_table.connect("toggled", self.toggled_cb)
+        view_files_button = gtk.LinkButton("file://%s" % image_addr, "View files")
+        self.box_group_area.pack_start(self.DetailBox(widget=image_table, button=view_files_button), expand=True, fill=True)
 
         # Machine, Base image and Layers
         layer_num_limit = 15
@@ -175,7 +204,7 @@ class ImageDetailsPage (HobPage):
 
             edit_config_button = gtk.LinkButton("Changes settings for build", "Edit configuration")
             edit_config_button.connect("clicked", self.edit_config_button_clicked_cb)
-            setting_detail = self.DetailBox(varlist=varlist, vallist=vallist, icon=None, button=edit_config_button)
+            setting_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_config_button)
             self.box_group_area.pack_start(setting_detail, expand=False, fill=False)
 
         # Packages included, and Total image size
@@ -188,7 +217,7 @@ class ImageDetailsPage (HobPage):
             edit_packages_button.connect("clicked", self.edit_packages_button_clicked_cb)
         else: # get to this page from "My images"
             edit_packages_button = None
-        package_detail = self.DetailBox(varlist=varlist, vallist=vallist, icon=None, button=edit_packages_button)
+        package_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_packages_button)
         self.box_group_area.pack_start(package_detail, expand=False, fill=False)
         if build_succeeded:
             buttonlist = ["Build new image", "Save as template", "Run image", "Deploy image"]
@@ -199,6 +228,18 @@ class ImageDetailsPage (HobPage):
 
         self.show_all()
 
+    def toggled_cb(self, table, cell, path, columnid, tree):
+        model = tree.get_model()
+        if not model:
+            return
+        iter = model.get_iter_first()
+        while iter:
+            rowpath = model.get_path(iter)
+            model[rowpath][columnid] = False
+            iter = model.iter_next(iter)
+
+        model[path][columnid] = True
+
     def create_bottom_buttons(self, buttonlist):
         # Create the buttons at the bottom
         bottom_buttons = gtk.HBox(False, 5)
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 8a8ab75..280d480 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -51,7 +51,7 @@ class PackageSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : PackageListModel.COL_INC,
-                       'col_style': 'toggle',
+                       'col_style': 'check toggle',
                        'col_min'  : 50,
                        'col_max'  : 50
                       }]
@@ -79,7 +79,7 @@ class PackageSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : PackageListModel.COL_INC,
-                       'col_style': 'toggle',
+                       'col_style': 'check toggle',
                        'col_min'  : 50,
                        'col_max'  : 50
                      }]
@@ -111,9 +111,19 @@ class PackageSelectionPage (HobPage):
         # append the tab
         for i in range(len(self.pages)):
             columns = self.pages[i]['columns']
-            tab = HobViewTable(columns, self.reset_clicked_cb, self.table_toggled_cb)
+            tab = HobViewTable(columns)
             filter = self.pages[i]['filter']
-            tab.table_tree.set_model(self.package_model.tree_model(filter))
+            tab.set_model(self.package_model.tree_model(filter))
+            tab.connect("toggled", self.table_toggled_cb)
+            if self.pages[i]['name'] == "Included":
+                tab.connect("changed", self.tree_selection_cb)
+
+            reset_button = gtk.Button("Reset")
+            reset_button.connect("clicked", self.reset_clicked_cb)
+            hbox = gtk.HBox(False, 5)
+            hbox.pack_end(reset_button, expand=False, fill=False)
+            tab.pack_start(hbox, expand=False, fill=False)
+
             label = gtk.Label(self.pages[i]['name'])
             self.ins.append_page(tab, label)
             self.tables.append(tab)
@@ -124,11 +134,7 @@ class PackageSelectionPage (HobPage):
         self.grid.attach(self.topbar, 0, 1, 0, 1, gtk.FILL | gtk.EXPAND, gtk.FILL | gtk.EXPAND, 1, 1)
         # set the search entry for each table
         for tab in self.tables:
-            tab.table_tree.set_search_entry(self.topbar.search)
-
-        inctab_tree_view = self.tables[len(self.pages)-1].table_tree
-        inctab_tree_selection = inctab_tree_view.get_selection()
-        inctab_tree_selection.connect("changed", self.tree_selection_cb, inctab_tree_view)
+            tab.set_search_entry(0, self.topbar.search)
 
         # add all into the dialog
         self.box_group_area.add(self.grid)
@@ -155,7 +161,7 @@ class PackageSelectionPage (HobPage):
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         button_box.pack_start(self.back_button, expand=False, fill=False)
 
-    def tree_selection_cb(self, tree_selection, tree_view):
+    def tree_selection_cb(self, table, tree_selection, tree_view):
         tree_model = tree_view.get_model()
         path, column = tree_view.get_cursor()
         if not path or column == tree_view.get_column(2):
@@ -218,7 +224,7 @@ class PackageSelectionPage (HobPage):
 
         self.builder.window_sensitive(True)
 
-    def table_toggled_cb(self, cell, view_path, view_tree):
+    def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree):
         # Click to include a package
         self.builder.window_sensitive(False)
         view_model = view_tree.get_model()
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index 73b8a1e..93540b2 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -56,7 +56,7 @@ class RecipeSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : RecipeListModel.COL_INC,
-                       'col_style': 'toggle',
+                       'col_style': 'check toggle',
                        'col_min'  : 50,
                        'col_max'  : 50
                       }]
@@ -78,7 +78,7 @@ class RecipeSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : RecipeListModel.COL_INC,
-                       'col_style': 'toggle',
+                       'col_style': 'check toggle',
                        'col_min'  : 50,
                        'col_max'  : 50
                       }]
@@ -101,7 +101,7 @@ class RecipeSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Included',
                        'col_id'   : RecipeListModel.COL_INC,
-                       'col_style': 'toggle',
+                       'col_style': 'check toggle',
                        'col_min'  : 50,
                        'col_max'  : 50
                       }]
@@ -135,9 +135,19 @@ class RecipeSelectionPage (HobPage):
         # append the tabs in order
         for i in range(len(self.pages)):
             columns = self.pages[i]['columns']
-            tab = HobViewTable(columns, self.reset_clicked_cb, self.table_toggled_cb)
+            tab = HobViewTable(columns)
             filter = self.pages[i]['filter']
-            tab.table_tree.set_model(self.recipe_model.tree_model(filter))
+            tab.set_model(self.recipe_model.tree_model(filter))
+            tab.connect("toggled", self.table_toggled_cb)
+            if self.pages[i]['name'] == "Included":
+                tab.connect("changed", self.tree_selection_cb)
+
+            reset_button = gtk.Button("Reset")
+            reset_button.connect("clicked", self.reset_clicked_cb)
+            hbox = gtk.HBox(False, 5)
+            hbox.pack_end(reset_button, expand=False, fill=False)
+            tab.pack_start(hbox, expand=False, fill=False)
+
             label = gtk.Label(self.pages[i]['name'])
             self.ins.append_page(tab, label)
             self.tables.append(tab)
@@ -148,11 +158,7 @@ class RecipeSelectionPage (HobPage):
         self.grid.attach(self.topbar, 0, 1, 0, 1, gtk.FILL | gtk.EXPAND, gtk.FILL | gtk.EXPAND)
         # set the search entry for each table
         for tab in self.tables:
-            tab.table_tree.set_search_entry(self.topbar.search)
-
-        inctab_tree_view = self.tables[len(self.pages)-1].table_tree
-        inctab_tree_selection = inctab_tree_view.get_selection()
-        inctab_tree_selection.connect("changed", self.tree_selection_cb, inctab_tree_view)
+            tab.set_search_entry(0, self.topbar.search)
 
         # add all into the window
         self.box_group_area.add(self.grid)
@@ -179,7 +185,7 @@ class RecipeSelectionPage (HobPage):
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         button_box.pack_start(self.back_button, expand=False, fill=False)
 
-    def tree_selection_cb(self, tree_selection, tree_view):
+    def tree_selection_cb(self, table, tree_selection, tree_view):
         tree_model = tree_view.get_model()
         path, column = tree_view.get_cursor()
         if not path or column == tree_view.get_column(2):
@@ -213,7 +219,7 @@ class RecipeSelectionPage (HobPage):
 
         self.builder.window_sensitive(True)
 
-    def table_toggled_cb(self, cell, view_path, view_tree):
+    def table_toggled_cb(self, table, cell, view_path, toggled_columnid, view_tree):
         # Click to include a recipe
         self.builder.window_sensitive(False)
         view_model = view_tree.get_model()
-- 
1.7.6



