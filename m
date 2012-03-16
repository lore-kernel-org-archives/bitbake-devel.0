Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S8Ybk-0006Iq-Jd
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 15:58:20 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 16 Mar 2012 07:49:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="129770309"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 16 Mar 2012 07:49:31 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Mar 2012 23:10:09 +0800
Message-Id: <fecae981bde6d526f61722542f1c6265ac60e83e.1331910234.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
In-Reply-To: <cover.1331910234.git.shane.wang@intel.com>
References: <cover.1331910234.git.shane.wang@intel.com>
Subject: [PATCH 04/12] Hob: change the code style to enumerate a list in a for-loop
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
X-List-Received-Date: Fri, 16 Mar 2012 14:58:20 -0000

We use the more common style to enumerate a list in a for-loop
(http://docs.python.org/library/functions.html#enumerate), that is:

try to use
for item in mylist,

and try to use
for i, item in enumerate(list)
rather than
for i in range(len(mylist))

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |   30 +++++++++++-----------
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   10 +++---
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py  |   10 +++---
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 2c3d831..247bbd1 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -109,38 +109,38 @@ class HobViewTable (gtk.VBox):
         self.toggle_columns = []
         self.table_tree.connect("row-activated", self.row_activated_cb)
 
-        for i in range(len(columns)):
-            col = gtk.TreeViewColumn(columns[i]['col_name'])
+        for i, column in enumerate(columns):
+            col = gtk.TreeViewColumn(column['col_name'])
             col.set_clickable(True)
             col.set_resizable(True)
-            col.set_sort_column_id(columns[i]['col_id'])
-            if 'col_min' in columns[i].keys():
-                col.set_min_width(columns[i]['col_min'])
-            if 'col_max' in columns[i].keys():
-                col.set_max_width(columns[i]['col_max'])
+            col.set_sort_column_id(column['col_id'])
+            if 'col_min' in column.keys():
+                col.set_min_width(column['col_min'])
+            if 'col_max' in column.keys():
+                col.set_max_width(column['col_max'])
             self.table_tree.append_column(col)
 
-            if (not 'col_style' in columns[i].keys()) or columns[i]['col_style'] == 'text':
+            if (not 'col_style' in column.keys()) or column['col_style'] == 'text':
                 cell = gtk.CellRendererText()
                 col.pack_start(cell, True)
-                col.set_attributes(cell, text=columns[i]['col_id'])
-            elif columns[i]['col_style'] == 'check toggle':
+                col.set_attributes(cell, text=column['col_id'])
+            elif column['col_style'] == 'check toggle':
                 cell = gtk.CellRendererToggle()
                 cell.set_property('activatable', True)
                 cell.connect("toggled", self.toggled_cb, i, self.table_tree)
                 self.toggle_id = i
                 col.pack_end(cell, True)
-                col.set_attributes(cell, active=columns[i]['col_id'])
-                self.toggle_columns.append(columns[i]['col_name'])
-            elif columns[i]['col_style'] == 'radio toggle':
+                col.set_attributes(cell, active=column['col_id'])
+                self.toggle_columns.append(column['col_name'])
+            elif column['col_style'] == 'radio toggle':
                 cell = gtk.CellRendererToggle()
                 cell.set_property('activatable', True)
                 cell.set_radio(True)
                 cell.connect("toggled", self.toggled_cb, i, self.table_tree)
                 self.toggle_id = i
                 col.pack_end(cell, True)
-                col.set_attributes(cell, active=columns[i]['col_id'])
-                self.toggle_columns.append(columns[i]['col_name'])
+                col.set_attributes(cell, active=column['col_id'])
+                self.toggle_columns.append(column['col_name'])
 
         scroll = gtk.ScrolledWindow()
         scroll.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 3cd1c5e..23e460c 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -105,16 +105,16 @@ class PackageSelectionPage (HobPage):
         self.ins = HobNotebook()
         self.tables = [] # we need to modify table when the dialog is shown
         # append the tab
-        for i in range(len(self.pages)):
-            columns = self.pages[i]['columns']
+        for page in self.pages:
+            columns = page['columns']
             tab = HobViewTable(columns)
-            filter = self.pages[i]['filter']
+            filter = page['filter']
             tab.set_model(self.package_model.tree_model(filter))
             tab.connect("toggled", self.table_toggled_cb)
-            if self.pages[i]['name'] == "Included":
+            if page['name'] == "Included":
                 tab.connect("row-activated", self.tree_row_activated_cb)
 
-            label = gtk.Label(self.pages[i]['name'])
+            label = gtk.Label(page['name'])
             self.ins.append_page(tab, label)
             self.tables.append(tab)
 
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index db873b6..6dd7c1e 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -127,16 +127,16 @@ class RecipeSelectionPage (HobPage):
         self.ins = HobNotebook()
         self.tables = [] # we need modify table when the dialog is shown
         # append the tabs in order
-        for i in range(len(self.pages)):
-            columns = self.pages[i]['columns']
+        for page in self.pages:
+            columns = page['columns']
             tab = HobViewTable(columns)
-            filter = self.pages[i]['filter']
+            filter = page['filter']
             tab.set_model(self.recipe_model.tree_model(filter))
             tab.connect("toggled", self.table_toggled_cb)
-            if self.pages[i]['name'] == "Included":
+            if page['name'] == "Included":
                 tab.connect("row-activated", self.tree_row_activated_cb)
 
-            label = gtk.Label(self.pages[i]['name'])
+            label = gtk.Label(page['name'])
             self.ins.append_page(tab, label)
             self.tables.append(tab)
 
-- 
1.7.6



