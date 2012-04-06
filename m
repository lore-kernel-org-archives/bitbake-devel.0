Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SGIZN-0003Lc-At
	for bitbake-devel@lists.openembedded.org;
	Sat, 07 Apr 2012 01:27:53 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 06 Apr 2012 16:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="129596281"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.176])
	by orsmga002.jf.intel.com with ESMTP; 06 Apr 2012 16:18:38 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Apr 2012 16:18:33 -0700
Message-Id: <3125c808fa15e394e01c4f03b1bf916f6ee75eca.1333754145.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
In-Reply-To: <cover.1333754145.git.josh@linux.intel.com>
References: <cover.1333754145.git.josh@linux.intel.com>
In-Reply-To: <cover.1333754145.git.josh@linux.intel.com>
References: <cover.1333754145.git.josh@linux.intel.com>
Subject: [PATCH 1/4] lib/bb/ui/crumbs: only display one 'Brought in by' item in Hob trees
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
X-List-Received-Date: Fri, 06 Apr 2012 23:27:53 -0000

The design calls for a single 'Brought in by' item to be shown in the
tree views with any extra items to be shown in the tooltip.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py            |   13 +++++++++++++
 lib/bb/ui/crumbs/packageselectionpage.py |    2 +-
 lib/bb/ui/crumbs/recipeselectionpage.py  |    2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index edb85db..3f6dd34 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -150,6 +150,10 @@ class HobViewTable (gtk.VBox):
                 col.pack_end(cell, True)
                 col.set_attributes(cell, active=column['col_id'])
                 self.toggle_columns.append(column['col_name'])
+            elif column['col_style'] == 'binb':
+                cell = gtk.CellRendererText()
+                col.pack_start(cell, True)
+                col.set_cell_data_func(cell, self.display_binb_cb, column['col_id'])
 
         scroll = gtk.ScrolledWindow()
         scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
@@ -157,6 +161,15 @@ class HobViewTable (gtk.VBox):
         scroll.add(self.table_tree)
         self.pack_start(scroll, True, True, 0)
 
+    def display_binb_cb(self, col, cell, model, it, col_id):
+        binb =  model.get_value(it, col_id)
+        # Just display the first item
+        if binb:
+            bin = binb.split(', ')
+            cell.set_property('text', bin[0])
+
+        return True
+
     def set_model(self, tree_model):
         self.table_tree.set_model(tree_model)
 
diff --git a/lib/bb/ui/crumbs/packageselectionpage.py b/lib/bb/ui/crumbs/packageselectionpage.py
index 7926636..78963f6 100755
--- a/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/lib/bb/ui/crumbs/packageselectionpage.py
@@ -45,7 +45,7 @@ class PackageSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Brought in by',
                        'col_id'   : PackageListModel.COL_BINB,
-                       'col_style': 'text',
+                       'col_style': 'binb',
                        'col_min'  : 100,
                        'col_max'  : 350
                       }, {
diff --git a/lib/bb/ui/crumbs/recipeselectionpage.py b/lib/bb/ui/crumbs/recipeselectionpage.py
index e4616a8..956b02d 100755
--- a/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -45,7 +45,7 @@ class RecipeSelectionPage (HobPage):
                       }, {
                        'col_name' : 'Brought in by',
                        'col_id'   : RecipeListModel.COL_BINB,
-                       'col_style': 'text',
+                       'col_style': 'binb',
                        'col_min'  : 100,
                        'col_max'  : 500
                       }, {
-- 
1.7.7.6



