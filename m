Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1Tcvst-0007cR-1J
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Nov 2012 11:25:51 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 25 Nov 2012 23:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.83,318,1352102400"; d="scan'208";a="247079191"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga002.jf.intel.com with ESMTP; 25 Nov 2012 23:39:51 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Nov 2012 09:42:36 +0200
Message-Id: <1353915756-29256-1-git-send-email-cristiana.voicu@intel.com>
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
X-List-Received-Date: Mon, 26 Nov 2012 10:25:51 -0000

- there are some layers which cannot be removed; so ,I have used
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
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index ecf5371..c746164 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -172,6 +172,7 @@ class Configuration:
         # self.extra_setting/self.toolchain_build
         # bblayers.conf
         self.layers = params["layer"].split()
+        self.layers_non_removable = params["layers_non_removable"].split()
         self.default_task = params["default_task"]
 
         # proxy settings
@@ -1189,6 +1190,7 @@ class Builder(gtk.Window):
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
index 4b908f9..ae1cefc 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -435,8 +435,11 @@ class HobHandler(gobject.GObject):
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
-- 
1.7.9.5



