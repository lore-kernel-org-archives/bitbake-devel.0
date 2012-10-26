Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TRkiC-0007kp-LJ
	for bitbake-devel@lists.openembedded.org;
	Fri, 26 Oct 2012 16:16:36 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 26 Oct 2012 07:03:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,654,1344236400"; d="scan'208";a="238776249"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2012 06:52:58 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 26 Oct 2012 16:54:47 +0300
Message-Id: <1351259688-11696-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: reordering the layers in the Hob Layers dialog
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
X-List-Received-Date: Fri, 26 Oct 2012 14:16:36 -0000

-since the order of the layers can potentially impact
the build outcome, users should be able to reorder
the layers within the layers dialog;
-used TreeView Drag and Drop

[YOCTO #3270]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   42 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 4f4fecb..ee44117 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -1516,6 +1516,13 @@ class CellRendererPixbufActivatable(gtk.CellRendererPixbuf):
 #
 class LayerSelectionDialog (CrumbsDialog):
 
+    TARGETS = [
+        ("MY_TREE_MODEL_ROW", gtk.TARGET_SAME_WIDGET, 0),
+        ("text/plain", 0, 1),
+        ("TEXT", 0, 2),
+        ("STRING", 0, 3),
+        ]
+
     def gen_label_widget(self, content):
         label = gtk.Label()
         label.set_alignment(0, 0)
@@ -1579,7 +1586,17 @@ class LayerSelectionDialog (CrumbsDialog):
         layer_tv.set_rules_hint(True)
         layer_tv.set_headers_visible(False)
         tree_selection = layer_tv.get_selection()
-        tree_selection.set_mode(gtk.SELECTION_NONE)
+        tree_selection.set_mode(gtk.SELECTION_SINGLE)
+
+        # Allow enable drag and drop of rows including row move
+        layer_tv.enable_model_drag_source( gtk.gdk.BUTTON1_MASK,
+            self.TARGETS,
+            gtk.gdk.ACTION_DEFAULT|
+            gtk.gdk.ACTION_MOVE)
+        layer_tv.enable_model_drag_dest(self.TARGETS,
+            gtk.gdk.ACTION_DEFAULT)
+        layer_tv.connect("drag_data_get", self.drag_data_get_cb)
+        layer_tv.connect("drag_data_received", self.drag_data_received_cb)
 
         col0= gtk.TreeViewColumn('Path')
         cell0 = gtk.CellRendererText()
@@ -1634,6 +1651,29 @@ class LayerSelectionDialog (CrumbsDialog):
 
         return hbox, layer_store
 
+    def drag_data_get_cb(self, treeview, context, selection, target_id, etime):
+        treeselection = treeview.get_selection()
+        model, iter = treeselection.get_selected()
+        data = model.get_value(iter, 0)
+        selection.set(selection.target, 8, data)
+
+    def drag_data_received_cb(self, treeview, context, x, y, selection, info, etime):
+        model = treeview.get_model()
+        data = selection.data
+        drop_info = treeview.get_dest_row_at_pos(x, y)
+        if drop_info:
+            path, position = drop_info
+            iter = model.get_iter(path)
+            if (position == gtk.TREE_VIEW_DROP_BEFORE or position == gtk.TREE_VIEW_DROP_INTO_OR_BEFORE):
+                model.insert_before(iter, [data])
+            else:
+                model.insert_after(iter, [data])
+        else:
+            model.append([data])
+        if context.action == gtk.gdk.ACTION_MOVE:
+            context.finish(True, True, etime)
+        return
+
     def add_hover_cb(self, button, event):
         self.im.set_from_file(hic.ICON_INDI_ADD_HOVER_FILE)
 
-- 
1.7.9.5



