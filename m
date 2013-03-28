Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1ULBUx-0001tY-Un
	for bitbake-devel@lists.openembedded.org;
	Thu, 28 Mar 2013 13:00:36 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 28 Mar 2013 04:42:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,925,1355126400"; d="scan'208";a="308596792"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.146])
	by orsmga002.jf.intel.com with ESMTP; 28 Mar 2013 04:42:40 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 Mar 2013 13:43:33 +0200
Message-Id: <1364471013-6273-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] Removed popup when including a package
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
X-List-Received-Date: Thu, 28 Mar 2013 12:00:41 -0000

Fixed the functionality which made an information
dialog pop up when including any package.

[HOB #4138]

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    2 +-
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index ce2deab..70d45ef 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -202,7 +202,7 @@ class PackageSelectionPage (HobPage):
     def button_click_cb(self, widget, event):
         path, col = widget.table_tree.get_cursor()
         tree_model = widget.table_tree.get_model()
-        if path: # else activation is likely a removal
+        if path and col.get_title() != 'Included': # else activation is likely a removal
             properties = {'binb': '' , 'name': '', 'size':'', 'recipe':''}
             properties['binb'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_BINB)
             properties['name'] = tree_model.get_value(tree_model.get_iter(path), PackageListModel.COL_NAME)
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index aa0cd60..e102b29 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -217,7 +217,7 @@ class RecipeSelectionPage (HobPage):
     def button_click_cb(self, widget, event):
         path, col = widget.table_tree.get_cursor()
         tree_model = widget.table_tree.get_model()
-        if path: # else activation is likely a removal
+        if path and col.get_title() != 'Included': # else activation is likely a removal
             properties = {'summary': '', 'name': '', 'version': '', 'revision': '', 'binb': '', 'group': '', 'license': '', 'homepage': '', 'bugtracker': '', 'description': ''}
             properties['summary'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_SUMMARY)
             properties['name'] = tree_model.get_value(tree_model.get_iter(path), RecipeListModel.COL_NAME)
-- 
1.7.9.5



