Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SAXcm-0000N0-G2
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 03:19:37 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 21 Mar 2012 19:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="131778625"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.222])
	by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2012 19:10:38 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 19:10:34 -0700
Message-Id: <935d406957d503fdf5d0eb22594926019abc6436.1332381654.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
In-Reply-To: <cover.1332381654.git.josh@linux.intel.com>
References: <cover.1332381654.git.josh@linux.intel.com>
Subject: [PATCH 09/10] ui/crumbs/hig: make the layer selection dialogue more closely match design
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
X-List-Received-Date: Thu, 22 Mar 2012 02:19:38 -0000

The layer dialogue design includes in-line remove/delete widgets next to
the layer path in the tree view for all layers other than the meta layer as
well as an in-line notice that the meta layer cannot be removed.

This is achieved  in this patch through the use of custom cell_data_func's
for the treeview to render the meta layer differently and a custom
CellRenderer implementation, CellRendererPixbufActivatable, which renders a
pixbuf and emits a clicked signal when the user clicks on it.

Fixes [YOCTO #2083]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hig.py |  125 +++++++++++++++++++++++++++++++++++------------
 1 files changed, 93 insertions(+), 32 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index e6020a3..05ac8d4 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -791,6 +791,27 @@ class DeployImageDialog (CrumbsDialog):
         os.close(f_from)
         os.close(f_to)
         self.progress_bar.hide()
+
+class CellRendererPixbufActivatable(gtk.CellRendererPixbuf):
+    """
+    A custom CellRenderer implementation which is activatable
+    so that we can handle user clicks
+    """
+    __gsignals__    = { 'clicked' : (gobject.SIGNAL_RUN_LAST,
+                                     gobject.TYPE_NONE,
+                                     (gobject.TYPE_STRING,)), }
+
+    def __init__(self):
+        gtk.CellRendererPixbuf.__init__(self)
+        self.set_property('mode', gtk.CELL_RENDERER_MODE_ACTIVATABLE)
+        self.set_property('follow-state', True)
+
+    """
+    Respond to a user click on a cell
+    """
+    def do_activate(self, even, widget, path, background_area, cell_area, flags):
+        self.emit('clicked', path)
+
 #
 # LayerSelectionDialog
 #
@@ -857,13 +878,13 @@ class LayerSelectionDialog (CrumbsDialog):
         layer_tv.set_rules_hint(True)
         layer_tv.set_headers_visible(False)
         tree_selection = layer_tv.get_selection()
-        tree_selection.set_mode(gtk.SELECTION_SINGLE)
+        tree_selection.set_mode(gtk.SELECTION_NONE)
 
         col0= gtk.TreeViewColumn('Path')
         cell0 = gtk.CellRendererText()
         cell0.set_padding(5,2)
         col0.pack_start(cell0, True)
-        col0.set_attributes(cell0, text=0)
+        col0.set_cell_data_func(cell0, self.draw_layer_path_cb)
         layer_tv.append_column(col0)
 
         scroll = gtk.ScrolledWindow()
@@ -899,18 +920,33 @@ class LayerSelectionDialog (CrumbsDialog):
             for layer in layers:
                 layer_store.set(layer_store.append(), 0, layer)
 
-            image = gtk.Image()
-            image.set_from_stock(gtk.STOCK_ADD,gtk.ICON_SIZE_MENU)
-            add_button = gtk.Button()
-            add_button.set_image(image)
+            col1 = gtk.TreeViewColumn('Enabled')
+            layer_tv.append_column(col1)
+
+            cell1 = CellRendererPixbufActivatable()
+            cell1.set_fixed_size(-1,35)
+            cell1.connect("clicked", self.del_cell_clicked_cb, layer_store)
+            col1.pack_start(cell1, True)
+            col1.set_cell_data_func(cell1, self.draw_delete_button_cb, layer_tv)
+
+            add_button = HobAltButton()
+            box = gtk.HBox(False, 6)
+            box.show()
+            add_button.add(box)
+            im = gtk.Image()
+            im.set_from_file(hic.ICON_INDI_ADD)
+            im.show()
+            box.pack_start(im, expand=False, fill=False, padding=6)
+            lbl = gtk.Label("Add layer")
+            lbl.set_alignment(0.0, 0.5)
+            lbl.show()
+            box.pack_start(lbl, expand=True, fill=True, padding=6)
             add_button.connect("clicked", self.layer_widget_add_clicked_cb, layer_store, window)
-            table_layer.attach(add_button, 0, 5, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
-            image = gtk.Image()
-            image.set_from_stock(gtk.STOCK_REMOVE,gtk.ICON_SIZE_MENU)
-            del_button = gtk.Button()
-            del_button.set_image(image)
-            del_button.connect("clicked", self.layer_widget_del_clicked_cb, tree_selection, layer_store)
-            table_layer.attach(del_button, 5, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
+            add_button.set_can_default(True)
+            add_button.grab_default()
+            add_button.set_can_focus(True)
+            add_button.grab_focus()
+            table_layer.attach(add_button, 0, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
         layer_tv.set_model(layer_store)
 
         hbox.show_all()
@@ -927,6 +963,11 @@ class LayerSelectionDialog (CrumbsDialog):
         self.split_model = split_model
         self.layers_changed = False
 
+        # icon for remove button in TreeView
+        im = gtk.Image()
+        im.set_from_file(hic.ICON_INDI_REMOVE)
+        self.rem_icon = im.get_pixbuf()
+
         # class members for internal use
         self.layer_store = None
 
@@ -935,27 +976,9 @@ class LayerSelectionDialog (CrumbsDialog):
         self.connect("response", self.response_cb)
                 
     def create_visual_elements(self):
-        hbox_top = gtk.HBox()
-        self.vbox.pack_start(hbox_top, expand=False, fill=False)
-
-        if self.split_model:
-            label = self.gen_label_widget("<b>Select Layers:</b>\n(Available layers under '${COREBASE}/layers/' directory)")
-        else:
-            label = self.gen_label_widget("<b>Select Layers:</b>")
-        hbox_top.pack_start(label, expand=False, fill=False)
-
-        tooltip = "Layer is a collection of bb files and conf files"
-        info = HobInfoButton(tooltip, self)
-        hbox_top.pack_end(info, expand=False, fill=False)
-
         layer_widget, self.layer_store = self.gen_layer_widget(self.split_model, self.layers, self.all_layers, self, None)
-        layer_widget.set_size_request(-1, 180)
+        layer_widget.set_size_request(450, 250)
         self.vbox.pack_start(layer_widget, expand=True, fill=True)
-
-        label = self.gen_label_widget("<b>Note:</b> '<i>meta</i>' is the Core layer for Yocto images please do not remove it.")
-        label.show()
-        self.vbox.pack_end(label, expand=False, fill=False)
-
         self.show_all()
 
     def response_cb(self, dialog, response_id):
@@ -974,6 +997,44 @@ class LayerSelectionDialog (CrumbsDialog):
         self.layers_changed = (self.layers != layers)
         self.layers = layers
 
+    """
+    A custom cell_data_func to draw a delete 'button' in the TreeView for layers
+    other than the meta layer. The deletion of which is prevented so that the
+    user can't shoot themselves in the foot too badly.
+    """
+    def draw_delete_button_cb(self, col, cell, model, it, tv):
+        path =  model.get_value(it, 0)
+        # Trailing slashes are uncommon in bblayers.conf but confuse os.path.basename
+        path.rstrip('/')
+        name = os.path.basename(path)
+        if name == "meta":
+            cell.set_sensitive(False)
+            cell.set_property('pixbuf', None)
+            cell.set_property('mode', gtk.CELL_RENDERER_MODE_INERT)
+        else:
+            cell.set_property('pixbuf', self.rem_icon)
+            cell.set_sensitive(True)
+            cell.set_property('mode', gtk.CELL_RENDERER_MODE_ACTIVATABLE)
+
+        return True
+
+    """
+    A custom cell_data_func to write an extra message into the layer path cell
+    for the meta layer. We should inform the user that they can't remove it for
+    their own safety.
+    """
+    def draw_layer_path_cb(self, col, cell, model, it):
+        path = model.get_value(it, 0)
+        name = os.path.basename(path)
+        if name == "meta":
+            cell.set_property('markup', "<b>Core layer for images: it cannot be removed</b>\n%s" % path)
+        else:
+            cell.set_property('text', path)
+
+    def del_cell_clicked_cb(self, cell, path, model):
+        it = model.get_iter_from_string(path)
+        model.remove(it)
+
 class ImageSelectionDialog (CrumbsDialog):
 
     __columns__ = [{
-- 
1.7.7.6



