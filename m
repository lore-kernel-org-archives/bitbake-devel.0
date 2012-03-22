Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SArc7-0001ys-Mi
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 00:40:15 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Mar 2012 16:31:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124076808"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 22 Mar 2012 16:31:16 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 16:31:09 -0700
Message-Id: <a80d48afd6a9c1de728cda1a4375323ebce4f3d2.1332458487.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
In-Reply-To: <cover.1332458487.git.josh@linux.intel.com>
References: <cover.1332458487.git.josh@linux.intel.com>
Subject: [PATCH 4/9] lib/bb/ui/crumbs/hig: tweak 'Add Layer' button per visual design
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
X-List-Received-Date: Thu, 22 Mar 2012 23:40:15 -0000

Use a separate, pre-lit, icon when the button has the cursor over it.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hig.py |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/lib/bb/ui/crumbs/hig.py b/lib/bb/ui/crumbs/hig.py
index 652226c..1db93ea 100644
--- a/lib/bb/ui/crumbs/hig.py
+++ b/lib/bb/ui/crumbs/hig.py
@@ -28,7 +28,7 @@ import re
 import subprocess
 import shlex
 from bb.ui.crumbs.hobcolor import HobColors
-from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobAltButton
+from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton
 from bb.ui.crumbs.progressbar import HobProgressBar
 
 """
@@ -815,23 +815,22 @@ class LayerSelectionDialog (CrumbsDialog):
         col1.pack_start(cell1, True)
         col1.set_cell_data_func(cell1, self.draw_delete_button_cb, layer_tv)
 
-        add_button = HobAltButton()
+        add_button = gtk.Button()
+        add_button.set_relief(gtk.RELIEF_NONE)
         box = gtk.HBox(False, 6)
         box.show()
         add_button.add(box)
-        im = gtk.Image()
-        im.set_from_file(hic.ICON_INDI_ADD)
-        im.show()
-        box.pack_start(im, expand=False, fill=False, padding=6)
+        add_button.connect("enter-notify-event", self.add_hover_cb)
+        add_button.connect("leave-notify-event", self.add_leave_cb)
+        self.im = gtk.Image()
+        self.im.set_from_file(hic.ICON_INDI_ADD_FILE)
+        self.im.show()
+        box.pack_start(self.im, expand=False, fill=False, padding=6)
         lbl = gtk.Label("Add layer")
         lbl.set_alignment(0.0, 0.5)
         lbl.show()
         box.pack_start(lbl, expand=True, fill=True, padding=6)
         add_button.connect("clicked", self.layer_widget_add_clicked_cb, layer_store, window)
-        add_button.set_can_default(True)
-        add_button.grab_default()
-        add_button.set_can_focus(True)
-        add_button.grab_focus()
         table_layer.attach(add_button, 0, 10, 1, 2, gtk.EXPAND | gtk.FILL, 0, 0, 6)
         layer_tv.set_model(layer_store)
 
@@ -839,6 +838,12 @@ class LayerSelectionDialog (CrumbsDialog):
 
         return hbox, layer_store
 
+    def add_hover_cb(self, button, event):
+        self.im.set_from_file(hic.ICON_INDI_ADD_HOVER_FILE)
+
+    def add_leave_cb(self, button, event):
+        self.im.set_from_file(hic.ICON_INDI_ADD_FILE)
+
     def __init__(self, title, layers, all_layers, parent, flags, buttons):
         super(LayerSelectionDialog, self).__init__(title, parent, flags, buttons)
 
@@ -849,7 +854,7 @@ class LayerSelectionDialog (CrumbsDialog):
 
         # icon for remove button in TreeView
         im = gtk.Image()
-        im.set_from_file(hic.ICON_INDI_REMOVE)
+        im.set_from_file(hic.ICON_INDI_REMOVE_FILE)
         self.rem_icon = im.get_pixbuf()
 
         # class members for internal use
-- 
1.7.7.6



