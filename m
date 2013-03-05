Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UCuCH-0003ih-Tx
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Mar 2013 16:54:36 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 05 Mar 2013 07:36:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,787,1355126400"; d="scan'208";a="271343725"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.45])
	by orsmga001.jf.intel.com with ESMTP; 05 Mar 2013 07:36:27 -0800
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Mar 2013 17:36:30 +0200
Message-Id: <1362497791-30020-11-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1362497791-30020-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 10/11] added event for the "All packages" tab
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
X-List-Received-Date: Tue, 05 Mar 2013 15:54:40 -0000

and passing the information needed to the function created in the builder.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 4544543..6f9a4e2 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -142,6 +142,9 @@ class PackageSelectionPage (HobPage):
             if page['name'] == "Included packages":
                 tab.connect("button-release-event", self.button_click_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
+            if page['name'] == "All packages":
+                tab.connect("button-release-event", self.button_click_cb)
+                tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
             self.ins.append_page(tab, page['name'], page['tooltip'])
             self.tables.append(tab)
 
@@ -175,9 +178,13 @@ class PackageSelectionPage (HobPage):
         path, col = widget.table_tree.get_cursor()
         tree_model = widget.table_tree.get_model()
         if path: # else activation is likely a removal
-            binb = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_BINB)
-            if binb:
-                self.builder.show_binb_dialog(binb)
+            properties = {'binb': '' , 'name': '', 'size':'', 'recipe':''}
+            properties['binb'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_BINB)
+            properties['name'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_NAME)
+            properties['size'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_SIZE)
+            properties['recipe'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_RCP)
+
+            self.builder.show_recipe_property_dialog(properties)
 
     def open_log_clicked_cb(self, button, log_file):
         if log_file:
-- 
1.7.9.5



