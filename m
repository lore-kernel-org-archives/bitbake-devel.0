Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TTAlU-0007EC-TW
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Oct 2012 13:17:53 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 30 Oct 2012 05:03:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,679,1344236400"; d="scan'208";a="212942832"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga001.jf.intel.com with ESMTP; 30 Oct 2012 05:04:15 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Oct 2012 14:06:11 +0200
Message-Id: <1351598771-31041-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: make some layers non removable
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
X-List-Received-Date: Tue, 30 Oct 2012 12:17:53 -0000

- there are some layers which cannot be removed; so ,I have created
a new variable called BBLAYERS_NON_REMOVABLE located in bblayers.conf,
which contains those layers which cannot be deleted
- "meta-hob" layer is added to this variable in hob code, like it's
added to BBLAYERS var

[YOCTO #3176]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py         |    2 ++
 bitbake/lib/bb/ui/crumbs/hig.py             |   15 +++++----------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    3 +++
 meta-yocto/conf/bblayers.conf.sample        |    4 ++++
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index e5222da..add067b 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -172,6 +172,7 @@ class Configuration:
         # self.extra_setting/self.toolchain_build
         # bblayers.conf
         self.layers = params["layer"].split()
+        self.layers_non_removable = params["layers_non_removable"].split()
         self.default_task = params["default_task"]
 
         # proxy settings
@@ -1194,6 +1195,7 @@ class Builder(gtk.Window):
     def show_layer_selection_dialog(self):
         dialog = LayerSelectionDialog(title = "Layers",
                      layers = copy.deepcopy(self.configuration.layers),
+                     layers_non_removable = copy.deepcopy(self.configuration.layers_non_removable),
                      all_layers = self.parameters.all_layers,
                      parent = self,
                      flags = gtk.DIALOG_MODAL
diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index d973086..e56cf2a 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -1665,11 +1665,12 @@ class LayerSelectionDialog (CrumbsDialog):
     def add_leave_cb(self, button, event):
         self.im.set_from_file(hic.ICON_INDI_ADD_FILE)
 
-    def __init__(self, title, layers, all_layers, parent, flags, buttons=None):
+    def __init__(self, title, layers, layers_non_removable, all_layers, parent, flags, buttons=None):
         super(LayerSelectionDialog, self).__init__(title, parent, flags, buttons)
 
         # class members from other objects
         self.layers = layers
+        self.layers_non_removable = layers_non_removable
         self.all_layers = all_layers
         self.layers_changed = False
 
@@ -1709,10 +1710,7 @@ class LayerSelectionDialog (CrumbsDialog):
     """
     def draw_delete_button_cb(self, col, cell, model, it, tv):
         path =  model.get_value(it, 0)
-        # Trailing slashes are uncommon in bblayers.conf but confuse os.path.basename
-        path.rstrip('/')
-        name = os.path.basename(path)
-        if name == "meta" or name == "meta-hob":
+        if path in self.layers_non_removable:
             cell.set_sensitive(False)
             cell.set_property('pixbuf', None)
             cell.set_property('mode', gtk.CELL_RENDERER_MODE_INERT)
@@ -1730,11 +1728,8 @@ class LayerSelectionDialog (CrumbsDialog):
     """
     def draw_layer_path_cb(self, col, cell, model, it):
         path = model.get_value(it, 0)
-        name = os.path.basename(path)
-        if name == "meta":
-            cell.set_property('markup', "<b>Core layer for images: it cannot be removed</b>\n%s" % path)
-        elif name == "meta-hob":
-            cell.set_property('markup', "<b>Core layer for Hob: it cannot be removed</b>\n%s" % path)
+        if path in self.layers_non_removable:
+            cell.set_property('markup', "<b>It cannot be removed</b>\n%s" % path)
         else:
             cell.set_property('text', path)
 
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 7d3af6c..169eeed 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -439,8 +439,11 @@ class HobHandler(gobject.GObject):
         params["core_base"] = self.runCommand(["getVariable", "COREBASE"]) or ""
         hob_layer = params["core_base"] + "/meta-hob"
         params["layer"] = self.runCommand(["getVariable", "BBLAYERS"]) or ""
+        params["layers_non_removable"] = self.runCommand(["getVariable", "BBLAYERS_NON_REMOVABLE"])
         if hob_layer not in params["layer"].split():
             params["layer"] += (" " + hob_layer)
+        if hob_layer not in params["layers_non_removable"].split():
+            params["layers_non_removable"] += (" " + hob_layer)
         params["dldir"] = self.runCommand(["getVariable", "DL_DIR"]) or ""
         params["machine"] = self.runCommand(["getVariable", "MACHINE"]) or ""
         params["distro"] = self.runCommand(["getVariable", "DISTRO"]) or "defaultsetup"
diff --git a/meta-yocto/conf/bblayers.conf.sample b/meta-yocto/conf/bblayers.conf.sample
index 98bfd70..7fd755d 100644
--- a/meta-yocto/conf/bblayers.conf.sample
+++ b/meta-yocto/conf/bblayers.conf.sample
@@ -10,3 +10,7 @@ BBLAYERS ?= " \
   ##COREBASE##/meta-yocto \
   ##COREBASE##/meta-yocto-bsp \
   "
+BBLAYERS_NON_REMOVABLE ?= " \
+  ##COREBASE##/meta \
+  ##COREBASE##/meta-yocto \
+  "
-- 
1.7.9.5



