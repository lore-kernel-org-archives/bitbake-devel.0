Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QnxG9-0001pn-Mw
	for bitbake-devel@lists.openembedded.org;
	Mon, 01 Aug 2011 20:30:37 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,301,1309762800"; d="scan'208";a="34344109"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga001.jf.intel.com with ESMTP; 01 Aug 2011 11:26:12 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Aug 2011 11:30:49 -0700
Message-Id: <2f7eadfdd710f84a299d6fc7be67ddb089f03ecc.1312216779.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
In-Reply-To: <cover.1312216779.git.josh@linux.intel.com>
References: <cover.1312216779.git.josh@linux.intel.com>
Subject: [PATCH 7/8] ui/crumbs/layereditor: if layer adding fails show an explanatory dialog
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
X-List-Received-Date: Mon, 01 Aug 2011 18:30:38 -0000

When adding a layer fails try to explain why to the user.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/layereditor.py |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/layereditor.py b/lib/bb/ui/crumbs/layereditor.py
index 7c581d6..f5394a5 100644
--- a/lib/bb/ui/crumbs/layereditor.py
+++ b/lib/bb/ui/crumbs/layereditor.py
@@ -21,6 +21,7 @@
 import gobject
 import gtk
 from bb.ui.crumbs.configurator import Configurator
+from bb.ui.crumbs.hig import CrumbsDialog
 
 class LayerEditor(gtk.Dialog):
     """
@@ -117,6 +118,12 @@ class LayerEditor(gtk.Dialog):
         self.find_layer(self)
 
     def find_layer(self, parent):
+        def conf_error(parent, lbl):
+            dialog = CrumbsDialog(parent, lbl)
+            dialog.add_button(gtk.STOCK_OK, gtk.RESPONSE_OK)
+            response = dialog.run()
+            dialog.destroy()
+
         dialog = gtk.FileChooserDialog("Add new layer", parent,
                                        gtk.FILE_CHOOSER_ACTION_OPEN,
                                        (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
@@ -128,10 +135,19 @@ class LayerEditor(gtk.Dialog):
         path = dialog.get_filename()
         dialog.destroy()
 
+        lbl = "<b>Error</b>\nUnable to load layer <i>%s</i> because " % path
         if response == gtk.RESPONSE_YES:
             # FIXME: verify we've actually got a layer conf?
-            if path.endswith(".conf"):
+            if path.endswith("layer.conf"):
                 name, layerpath = self.configurator.addLayerConf(path)
-                if name:
+                if name and layerpath:
                     self.newly_added[name] = layerpath
                     self.layer_store.append([name, layerpath, True])
+                    return
+                elif name:
+                    return
+                else:
+                    lbl += "there was a problem parsing the layer.conf."
+            else:
+                lbl += "it is not a layer.conf file."
+            conf_error(parent, lbl)
-- 
1.7.6



