Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFI-0003SV-To
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:33 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Mar 2012 05:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="123374972"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 21 Mar 2012 05:57:31 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:06 +0800
Message-Id: <518205d808dcba09901e514f8175f8ca43cbc0b2.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332334068.git.dongxiao.xu@intel.com>
References: <cover.1332334068.git.dongxiao.xu@intel.com>
Subject: [PATCH 02/17] Hob: Remove split model in GTK Hob
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:33 -0000

Since the GTK Hob will not use the server/client split model, thus
remove it from current Hob code. But we still keep the core mechanism
in bitbake server.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |   13 +----
 lib/bb/ui/crumbs/hig.py             |  103 ++++++++++++-----------------------
 lib/bb/ui/crumbs/hobeventhandler.py |   21 +------
 lib/bb/ui/hob.py                    |   11 +----
 4 files changed, 41 insertions(+), 107 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index b1aad54..d3b13c9 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -260,21 +260,14 @@ class Builder(gtk.Window):
         self.show_all()
         self.nb.set_current_page(0)
 
-    def get_split_model(self):
-        return self.handler.split_model
-
     def load_template(self, path):
         self.template = TemplateMgr()
         self.template.load(path)
         self.configuration.load(self.template)
 
-        if self.get_split_model():
-            if not set(self.configuration.layers) <= set(self.parameters.all_layers):
+        for layer in self.configuration.layers:
+            if not os.path.exists(layer+'/conf/layer.conf'):
                 return False
-        else:
-            for layer in self.configuration.layers:
-                if not os.path.exists(layer+'/conf/layer.conf'):
-                    return False
 
         self.switch_page(self.LAYER_CHANGED)
 
@@ -674,7 +667,6 @@ class Builder(gtk.Window):
         dialog = LayerSelectionDialog(title = "Layer Selection",
                      layers = copy.deepcopy(self.configuration.layers),
                      all_layers = self.parameters.all_layers,
-                     split_model = self.get_split_model(),
                      parent = self,
                      flags = gtk.DIALOG_MODAL
                          | gtk.DIALOG_DESTROY_WITH_PARENT
@@ -748,7 +740,6 @@ class Builder(gtk.Window):
             all_distros = self.parameters.all_distros,
             all_sdk_machines = self.parameters.all_sdk_machines,
             max_threads = self.parameters.max_threads,
-            split_model = self.get_split_model(),
             parent = self,
             flags = gtk.DIALOG_MODAL
                     | gtk.DIALOG_DESTROY_WITH_PARENT
diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index baad7b8..bd27375 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -170,23 +170,20 @@ class AdvancedSettingDialog (CrumbsDialog):
 
         dialog.destroy()
 
-    def gen_entry_widget(self, split_model, content, parent, tooltip=""):
+    def gen_entry_widget(self, content, parent, tooltip=""):
         hbox = gtk.HBox(False, 12)
         entry = gtk.Entry()
         entry.set_text(content)
 
-        if split_model:
-            hbox.pack_start(entry, expand=True, fill=True)
-        else:
-            table = gtk.Table(1, 10, True)
-            hbox.pack_start(table, expand=True, fill=True)
-            table.attach(entry, 0, 9, 0, 1)
-            image = gtk.Image()
-            image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
-            open_button = gtk.Button()
-            open_button.set_image(image)
-            open_button.connect("clicked", self.entry_widget_select_path_cb, parent, entry)
-            table.attach(open_button, 9, 10, 0, 1)
+        table = gtk.Table(1, 10, True)
+        hbox.pack_start(table, expand=True, fill=True)
+        table.attach(entry, 0, 9, 0, 1)
+        image = gtk.Image()
+        image.set_from_stock(gtk.STOCK_OPEN,gtk.ICON_SIZE_BUTTON)
+        open_button = gtk.Button()
+        open_button.set_image(image)
+        open_button.connect("clicked", self.entry_widget_select_path_cb, parent, entry)
+        table.attach(open_button, 9, 10, 0, 1)
 
         info = HobInfoButton(tooltip, self)
         hbox.pack_start(info, expand=False, fill=False)
@@ -421,7 +418,7 @@ class AdvancedSettingDialog (CrumbsDialog):
 
     def __init__(self, title, configuration, all_image_types,
             all_package_formats, all_distros, all_sdk_machines,
-            max_threads, split_model, parent, flags, buttons):
+            max_threads, parent, flags, buttons):
         super(AdvancedSettingDialog, self).__init__(title, parent, flags, buttons)
 
         # class members from other objects
@@ -432,7 +429,6 @@ class AdvancedSettingDialog (CrumbsDialog):
         self.all_distros = all_distros
         self.all_sdk_machines = all_sdk_machines
         self.max_threads = max_threads
-        self.split_model = split_model 
 
         # class members for internal use
         self.pkgfmt_store = None
@@ -586,7 +582,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Set Download Directory:</span>")
         tooltip = "Select a folder that caches the upstream project source code"
-        dldir_widget, self.dldir_text = self.gen_entry_widget(self.split_model, self.configuration.dldir, self, tooltip)
+        dldir_widget, self.dldir_text = self.gen_entry_widget(self.configuration.dldir, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(dldir_widget, expand=False, fill=False)
 
@@ -594,7 +590,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE Directory:</span>")
         tooltip = "Select a folder that caches your prebuilt results"
-        sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.split_model, self.configuration.sstatedir, self, tooltip)
+        sstatedir_widget, self.sstatedir_text = self.gen_entry_widget(self.configuration.sstatedir, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(sstatedir_widget, expand=False, fill=False)
 
@@ -602,7 +598,7 @@ class AdvancedSettingDialog (CrumbsDialog):
         advanced_vbox.pack_start(sub_vbox, expand=False, fill=False)
         label = self.gen_label_widget("<span weight=\"bold\">Select SSTATE Mirror:</span>")
         tooltip = "Select the prebuilt mirror that will fasten your build speed"
-        sstatemirror_widget, self.sstatemirror_text = self.gen_entry_widget(self.split_model, self.configuration.sstatemirror, self, tooltip)
+        sstatemirror_widget, self.sstatemirror_text = self.gen_entry_widget(self.configuration.sstatemirror, self, tooltip)
         sub_vbox.pack_start(label, expand=False, fill=False)
         sub_vbox.pack_start(sstatemirror_widget, expand=False, fill=False)
 
@@ -850,7 +846,7 @@ class LayerSelectionDialog (CrumbsDialog):
             layer_store.remove(iter)
 
 
-    def gen_layer_widget(self, split_model, layers, layers_avail, window, tooltip=""):
+    def gen_layer_widget(self, layers, layers_avail, window, tooltip=""):
         hbox = gtk.HBox(False, 6)
 
         layer_tv = gtk.TreeView()
@@ -874,57 +870,36 @@ class LayerSelectionDialog (CrumbsDialog):
         table_layer = gtk.Table(2, 10, False)
         hbox.pack_start(table_layer, expand=True, fill=True)
 
-        if split_model:
-            table_layer.attach(scroll, 0, 10, 0, 2)
+        table_layer.attach(scroll, 0, 10, 0, 1)
 
-            layer_store = gtk.ListStore(gobject.TYPE_STRING, gobject.TYPE_BOOLEAN)
-            for layer in layers:
-                layer_store.set(layer_store.append(), 0, layer, 1, True)
-            for layer in layers_avail:
-                if layer not in layers:
-                    layer_store.set(layer_store.append(), 0, layer, 1, False)
+        layer_store = gtk.ListStore(gobject.TYPE_STRING)
+        for layer in layers:
+            layer_store.set(layer_store.append(), 0, layer)
 
-            col1 = gtk.TreeViewColumn('Included')
-            layer_tv.append_column(col1)
-
-            cell1 = gtk.CellRendererToggle()
-            cell1.connect("toggled", self.layer_widget_toggled_cb, layer_store)
-            col1.pack_start(cell1, True)
-            col1.set_attributes(cell1, active=1)
-
-        else:
-            table_layer.attach(scroll, 0, 10, 0, 1)
-
-            layer_store = gtk.ListStore(gobject.TYPE_STRING)
-            for layer in layers:
-                layer_store.set(layer_store.append(), 0, layer)
-
-            image = gtk.Image()
-            image.set_from_stock(gtk.STOCK_ADD,gtk.ICON_SIZE_MENU)
-            add_button = gtk.Button()
-            add_button.set_image(image)
-            add_button.connect("clicked", self.layer_widget_add_clicked_cb, layer_store, window)
-            table_layer.attach(add_button, 0, 5, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
-            image = gtk.Image()
-            image.set_from_stock(gtk.STOCK_REMOVE,gtk.ICON_SIZE_MENU)
-            del_button = gtk.Button()
-            del_button.set_image(image)
-            del_button.connect("clicked", self.layer_widget_del_clicked_cb, tree_selection, layer_store)
-            table_layer.attach(del_button, 5, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
+        image = gtk.Image()
+        image.set_from_stock(gtk.STOCK_ADD,gtk.ICON_SIZE_MENU)
+        add_button = gtk.Button()
+        add_button.set_image(image)
+        add_button.connect("clicked", self.layer_widget_add_clicked_cb, layer_store, window)
+        table_layer.attach(add_button, 0, 5, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
+        image = gtk.Image()
+        image.set_from_stock(gtk.STOCK_REMOVE,gtk.ICON_SIZE_MENU)
+        del_button = gtk.Button()
+        del_button.set_image(image)
+        del_button.connect("clicked", self.layer_widget_del_clicked_cb, tree_selection, layer_store)
+        table_layer.attach(del_button, 5, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
         layer_tv.set_model(layer_store)
 
         hbox.show_all()
 
         return hbox, layer_store
 
-    def __init__(self, title, layers, all_layers, split_model,
-            parent, flags, buttons):
+    def __init__(self, title, layers, all_layers, parent, flags, buttons):
         super(LayerSelectionDialog, self).__init__(title, parent, flags, buttons)
 
         # class members from other objects
         self.layers = layers
         self.all_layers = all_layers
-        self.split_model = split_model
         self.layers_changed = False
 
         # class members for internal use
@@ -938,17 +913,14 @@ class LayerSelectionDialog (CrumbsDialog):
         hbox_top = gtk.HBox()
         self.vbox.pack_start(hbox_top, expand=False, fill=False)
 
-        if self.split_model:
-            label = self.gen_label_widget("<b>Select Layers:</b>\n(Available layers under '${COREBASE}/layers/' directory)")
-        else:
-            label = self.gen_label_widget("<b>Select Layers:</b>")
+        label = self.gen_label_widget("<b>Select Layers:</b>")
         hbox_top.pack_start(label, expand=False, fill=False)
 
         tooltip = "Layer is a collection of bb files and conf files"
         info = HobInfoButton(tooltip, self)
         hbox_top.pack_end(info, expand=False, fill=False)
 
-        layer_widget, self.layer_store = self.gen_layer_widget(self.split_model, self.layers, self.all_layers, self, None)
+        layer_widget, self.layer_store = self.gen_layer_widget(self.layers, self.all_layers, self, None)
         layer_widget.set_size_request(-1, 180)
         self.vbox.pack_start(layer_widget, expand=True, fill=True)
 
@@ -963,12 +935,7 @@ class LayerSelectionDialog (CrumbsDialog):
         it = model.get_iter_first()
         layers = []
         while it:
-            if self.split_model:
-                inc = model.get_value(it, 1)
-                if inc:
-                    layers.append(model.get_value(it, 0))
-            else:
-                layers.append(model.get_value(it, 0))
+            layers.append(model.get_value(it, 0))
             it = model.iter_next(it)
 
         self.layers_changed = (self.layers != layers)
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index e24c340..07cc039 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -65,7 +65,7 @@ class HobHandler(gobject.GObject):
     (CFG_AVAIL_LAYERS, CFG_PATH_LAYERS, CFG_FILES_DISTRO, CFG_FILES_MACH, CFG_FILES_SDKMACH, FILES_MATCH_CLASS, PARSE_CONFIG, PARSE_BBFILES, GENERATE_TGTS, GENERATE_PACKAGEINFO, BUILD_TARGET_RECIPES, BUILD_TARGET_IMAGE, CMD_END) = range(13)
     (LAYERS_REFRESH, GENERATE_RECIPES, GENERATE_PACKAGES, GENERATE_IMAGE, POPULATE_PACKAGEINFO) = range(5)
 
-    def __init__(self, server, server_addr, client_addr, recipe_model, package_model):
+    def __init__(self, server, recipe_model, package_model):
         super(HobHandler, self).__init__()
 
         self.build = RunningBuild(sequential=True)
@@ -84,20 +84,11 @@ class HobHandler(gobject.GObject):
         self.error_msg = ""
         self.initcmd = None
 
-        self.split_model = False
-        if server_addr and client_addr:
-            self.split_model = (server_addr != client_addr)
-            self.reset_server() # reset server if server was found just now
-        self.server_addr = server_addr
-
     def kick(self):
         import xmlrpclib
         try:
             # kick the while thing off
-            if self.split_model:
-                self.commands_async.append(self.CFG_AVAIL_LAYERS)
-            else:
-                self.commands_async.append(self.CFG_PATH_LAYERS)
+            self.commands_async.append(self.CFG_PATH_LAYERS)
             self.commands_async.append(self.CFG_FILES_DISTRO)
             self.commands_async.append(self.CFG_FILES_MACH)
             self.commands_async.append(self.CFG_FILES_SDKMACH)
@@ -383,9 +374,6 @@ class HobHandler(gobject.GObject):
             # leave the workdir in a usable state
             self.server.runCommand(["stateShutdown"])
 
-    def reset_server(self):
-        self.server.runCommand(["resetCooker"])
-
     def reset_build(self):
         self.build.reset()
 
@@ -427,10 +415,7 @@ class HobHandler(gobject.GObject):
             pmake = int(pmake.lstrip("-j "))
         params["pmake"] = pmake
 
-        image_addr = self.server.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"]) or ""
-        if self.server_addr:
-            image_addr = "http://" + self.server_addr + ":" + image_addr
-        params["image_addr"] = image_addr
+        params["image_addr"] = self.server.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"]) or ""
 
         image_extra_size = self.server.runCommand(["getVariable", "IMAGE_ROOTFS_EXTRA_SPACE"])
         if not image_extra_size:
diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 429bb75..daa708b 100755
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -47,15 +47,6 @@ def event_handle_idle_func(eventHandler, hobHandler):
     return True
 
 def main (server = None, eventHandler = None):
-    bitbake_server = None
-    client_addr = None
-    server_addr = None
-
-    if not eventHandler:
-        helper = uihelper.BBUIHelper()
-        server, eventHandler, server_addr, client_addr = helper.findServerDetails()
-    bitbake_server = server
-
     gobject.threads_init()
 
     # That indicates whether the Hob and the bitbake server are
@@ -64,7 +55,7 @@ def main (server = None, eventHandler = None):
     recipe_model = RecipeListModel()
     package_model = PackageListModel()
 
-    hobHandler = HobHandler(bitbake_server, server_addr, client_addr, recipe_model, package_model)
+    hobHandler = HobHandler(server, recipe_model, package_model)
     if hobHandler.kick() == False:
         return 1
     builder = Builder(hobHandler, recipe_model, package_model)
-- 
1.7.4.1



