Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SGIZP-0003Lc-RK
	for bitbake-devel@lists.openembedded.org;
	Sat, 07 Apr 2012 01:27:56 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 06 Apr 2012 16:18:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="129596287"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.176])
	by orsmga002.jf.intel.com with ESMTP; 06 Apr 2012 16:18:39 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Apr 2012 16:18:36 -0700
Message-Id: <c53abebb1b91b43268abf7cf82122ffa34e8a9b9.1333754145.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333754145.git.josh@linux.intel.com>
References: <cover.1333754145.git.josh@linux.intel.com>
In-Reply-To: <cover.1333754145.git.josh@linux.intel.com>
References: <cover.1333754145.git.josh@linux.intel.com>
Subject: [PATCH 4/4] selectionpage: show persistent tooltips on click
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
X-List-Received-Date: Fri, 06 Apr 2012 23:27:56 -0000

Requiring a double click to show the tooltips isn't very intuitive, add
a callback to show the persistent tooltips on button release.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/packageselectionpage.py |   13 ++++++++-----
 lib/bb/ui/crumbs/recipeselectionpage.py  |   13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index b1a199c..81ff76d 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -117,7 +117,7 @@ class PackageSelectionPage (HobPage):
             tab.set_model(self.package_model.tree_model(filter))
             tab.connect("toggled", self.table_toggled_cb)
             if page['name'] == "Included":
-                tab.connect("row-activated", self.tree_row_activated_cb)
+                tab.connect("button-release-event", self.button_click_cb)
 
             label = gtk.Label(page['name'])
             self.ins.append_page(tab, label)
@@ -146,10 +146,13 @@ class PackageSelectionPage (HobPage):
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         button_box.pack_start(self.back_button, expand=False, fill=False)
 
-    def tree_row_activated_cb(self, table, tree_model, path):
-        binb = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_BINB)
-        if binb:
-            self.builder.show_binb_dialog(binb)
+    def button_click_cb(self, widget, event):
+        path, col = widget.table_tree.get_cursor()
+        tree_model = widget.table_tree.get_model()
+        if path: # else activation is likely a removal
+            binb = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_BINB)
+            if binb:
+                self.builder.show_binb_dialog(binb)
 
     def build_image_clicked_cb(self, button):
         self.builder.build_image()
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index d70fe52..019f9f3 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -148,7 +148,7 @@ class RecipeSelectionPage (HobPage):
             tab.set_model(self.recipe_model.tree_model(filter))
             tab.connect("toggled", self.table_toggled_cb)
             if page['name'] == "Included":
-                tab.connect("row-activated", self.tree_row_activated_cb)
+                tab.connect("button-release-event", self.button_click_cb)
 
             label = gtk.Label(page['name'])
             self.ins.append_page(tab, label)
@@ -177,10 +177,13 @@ class RecipeSelectionPage (HobPage):
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         button_box.pack_start(self.back_button, expand=False, fill=False)
 
-    def tree_row_activated_cb(self, table, tree_model, path):
-        binb = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_BINB)
-        if binb:
-            self.builder.show_binb_dialog(binb)
+    def button_click_cb(self, widget, event):
+        path, col = widget.table_tree.get_cursor()
+        tree_model = widget.table_tree.get_model()
+        if path: # else activation is likely a removal
+            binb = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_BINB)
+            if binb:
+                self.builder.show_binb_dialog(binb)
 
     def build_packages_clicked_cb(self, button):
         self.builder.build_packages()
-- 
1.7.7.6



