Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UCuBV-0003eQ-Ey
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Mar 2013 16:53:46 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Mar 2013 07:34:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,787,1355126400"; d="scan'208";a="271343607"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.45])
	by orsmga001.jf.intel.com with ESMTP; 05 Mar 2013 07:36:09 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Mar 2013 17:36:23 +0200
Message-Id: <1362497791-30020-4-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 03/11] replaced the function that displayed tooltips
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
X-List-Received-Date: Tue, 05 Mar 2013 15:53:49 -0000

replaced in the builder.py the function that displayed the tooltips
with two functions that display property windows for recipes and packages
pages.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |   35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index f6adabe..2a0ceba 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -47,6 +47,7 @@ from bb.ui.crumbs.hig.deployimagedialog import DeployImageDialog
 from bb.ui.crumbs.hig.layerselectiondialog import LayerSelectionDialog
 from bb.ui.crumbs.hig.imageselectiondialog import ImageSelectionDialog
 from bb.ui.crumbs.hig.parsingwarningsdialog import ParsingWarningsDialog
+from bb.ui.crumbs.hig.propertydialog import PropertyDialog
 
 hobVer = 20120808
 
@@ -1202,11 +1203,37 @@ class Builder(gtk.Window):
 
         self.fast_generate_image_async(True)
 
-    def show_binb_dialog(self, binb):
-        markup = "<b>Brought in by:</b>\n%s" % binb
-        ptip = PersistentTooltip(markup, self)
+    def show_recipe_property_dialog(self, properties):
+        information = {}
+        dialog = PropertyDialog(title = properties["name"] +' '+ "properties",
+                      parent = self,
+                      information = properties,
+                      flags = gtk.DIALOG_DESTROY_WITH_PARENT
+                          | gtk.DIALOG_NO_SEPARATOR)
 
-        ptip.show()
+        dialog.set_modal(False)
+
+        button = dialog.add_button("Close", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button.connect("clicked", lambda w: dialog.destroy())
+
+        dialog.run()
+
+    def show_packages_property_dialog(self, properties):
+        information = {}
+        dialog = PropertyDialog(title = properties["name"] +' '+ "properties",
+                      parent = self,
+                      information = properties,
+                      flags = gtk.DIALOG_DESTROY_WITH_PARENT
+                          | gtk.DIALOG_NO_SEPARATOR)
+
+        dialog.set_modal(False)
+
+        button = dialog.add_button("Close", gtk.RESPONSE_NO)
+        HobAltButton.style_button(button)
+        button.connect("clicked", lambda w: dialog.destroy())
+
+        dialog.run()
 
     def show_layer_selection_dialog(self):
         dialog = LayerSelectionDialog(title = "Layers",
-- 
1.7.9.5



