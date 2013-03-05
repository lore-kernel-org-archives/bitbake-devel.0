Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UCuCP-0003ih-7R
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Mar 2013 16:54:42 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 05 Mar 2013 07:36:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,787,1355126400"; d="scan'208";a="271343761"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.45])
	by orsmga001.jf.intel.com with ESMTP; 05 Mar 2013 07:36:32 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Mar 2013 17:36:31 +0200
Message-Id: <1362497791-30020-12-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 11/11] added events for the "Package Groups" "All recipes
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
X-List-Received-Date: Tue, 05 Mar 2013 15:54:47 -0000

" tabs and passing the information needed to the function created
in the builder.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index fea92b5..636762e 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -152,6 +152,12 @@ class RecipeSelectionPage (HobPage):
             if page['name'] == "Included recipes":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
+            if page['name'] == "Package Groups":
+                tab.connect("button-release-event", self.button_click_cb)
+                tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
+            if page['name'] == "All recipes":
+                tab.connect("button-release-event", self.button_click_cb)
+                tab.connect("cell-fadeinout-stopped", self.button_click_cb)
             self.ins.append_page(tab, page['name'], page['tooltip'])
             self.tables.append(tab)
 
@@ -185,9 +191,19 @@ class RecipeSelectionPage (HobPage):
         path, col = widget.table_tree.get_cursor()
         tree_model = widget.table_tree.get_model()
         if path: # else activation is likely a removal
-            binb = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_BINB)
-            if binb:
-                self.builder.show_binb_dialog(binb)
+            properties = {'summary': '', 'name': '', 'version': '', 'revision': '', 'binb': '', 'group': '', 'license': '', 'homepage': '', 'bugtracker': '', 'description': ''}
+            properties['summary'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_SUMMARY)
+            properties['name'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_NAME)
+            properties['version'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_VERSION)
+            properties['revision'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_REVISION)
+            properties['binb'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_BINB)
+            properties['group'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_GROUP)
+            properties['license'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_LIC)
+            properties['homepage'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_HOMEPAGE)
+            properties['bugtracker'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_BUGTRACKER)
+            properties['description'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_DESC)
+            self.builder.show_recipe_property_dialog(properties)
+
 
     def build_packages_clicked_cb(self, button):
         self.builder.build_packages()
-- 
1.7.9.5



