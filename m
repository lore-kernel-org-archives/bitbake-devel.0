Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SHF5j-0007t8-I8
	for bitbake-devel@lists.openembedded.org;
	Mon, 09 Apr 2012 15:57:11 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 09 Apr 2012 06:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="151484391"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 09 Apr 2012 06:47:53 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Apr 2012 22:13:34 +0800
Message-Id: <adf3209686753f3e963311b7febfbaffa97eaa36.1333980504.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
References: <0858ca0732e2d6a66b84e97150a750714ae806c9.1333980504.git.shane.wang@intel.com>
In-Reply-To: <cover.1333980504.git.shane.wang@intel.com>
References: <cover.1333980504.git.shane.wang@intel.com>
Subject: [PATCH 04/21] Hob: Add the tooltips for recipe view page as request
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
X-List-Received-Date: Mon, 09 Apr 2012 13:57:11 -0000

From: Liming An <limingx.l.an@intel.com>

[YOCTO #2229]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py           |   22 ++++++++++++++++++++--
 bitbake/lib/bb/ui/crumbs/recipeselectionpage.py |    8 ++++++++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 21836f7..b79edce 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -410,6 +410,7 @@ class HobTabBar(gtk.DrawingArea):
         self.connect("expose-event", self.on_draw)
         self.connect("button-press-event", self.button_pressed_cb)
         self.connect("button-release-event", self.button_released_cb)
+        self.connect("query-tooltip", self.query_tooltip_cb)
         self.show_all()
 
     def button_released_cb(self, widget, event):
@@ -473,7 +474,7 @@ class HobTabBar(gtk.DrawingArea):
             child["g"] = color.green
             child["b"] = color.blue
 
-    def append_tab_child(self, title, page):
+    def append_tab_child(self, title, page, tooltip=""):
         num = len(self.children) + 1
         self.tab_width = self.tab_width * len(self.children) / num
 
@@ -498,8 +499,11 @@ class HobTabBar(gtk.DrawingArea):
             "title"        : title,
             "indicator_show"   : False,
             "indicator_number" : 0,
+            "tooltip_markup"   : tooltip,
         }
         self.children.append(new_one)
+        if tooltip and (not self.props.has_tooltip):
+            self.props.has_tooltip = True
         # set the default current child
         if not self.current_child:
             self.current_child = new_one
@@ -668,6 +672,18 @@ class HobTabBar(gtk.DrawingArea):
 
         return gtk.gdk.Rectangle(x, y, w, h)
 
+    def query_tooltip_cb(self, widget, x, y, keyboardtip, tooltip):
+        if keyboardtip or (not tooltip):
+            return False
+        # check which tab be clicked
+        for child in self.children:
+           if      (child["x"] < x) and (x < child["x"] + self.tab_width) \
+               and (child["y"] < y) and (y < child["y"] + self.tab_height):
+               tooltip.set_markup(child["tooltip_markup"])
+               return True
+
+        return False
+
 class HobNotebook(gtk.VBox):
 
     def __init__(self):
@@ -752,13 +768,15 @@ class HobNotebook(gtk.VBox):
         if not notebook:
             return
         title = notebook.get_tab_label_text(notebook_child)
+        label = notebook.get_tab_label(notebook_child)
+        tooltip_markup = label.get_tooltip_markup()
         if not title:
             return
         for child in self.tabbar.children:
             if child["title"] == title:
                 child["toggled_page"] = page
                 return
-        self.tabbar.append_tab_child(title, page)
+        self.tabbar.append_tab_child(title, page, tooltip_markup)
 
     def page_removed_cb(self, notebook, notebook_child, page, title=""):
         for child in self.tabbar.children:
diff --git a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
index a2f7982..ea32fb0 100755
--- a/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/recipeselectionpage.py
@@ -34,6 +34,7 @@ class RecipeSelectionPage (HobPage):
     pages = [
         {
          'name'    : 'Included',
+         'tooltip' : 'The recipes currently included for your image',
          'filter'  : { RecipeListModel.COL_INC  : [True],
                        RecipeListModel.COL_TYPE : ['recipe', 'task'] },
          'columns' : [{
@@ -57,6 +58,7 @@ class RecipeSelectionPage (HobPage):
                       }]
         }, {
          'name'    : 'All recipes',
+         'tooltip' : 'All recipes available in the Yocto Project',
          'filter'  : { RecipeListModel.COL_TYPE : ['recipe'] },
          'columns' : [{
                        'col_name' : 'Recipe name',
@@ -85,6 +87,7 @@ class RecipeSelectionPage (HobPage):
                       }]
         }, {
          'name'    : 'Tasks',
+         'tooltip' : 'All tasks availabel in the Yocto Project',
          'filter'  : { RecipeListModel.COL_TYPE : ['task'] },
          'columns' : [{
                        'col_name' : 'Task name',
@@ -137,12 +140,17 @@ class RecipeSelectionPage (HobPage):
                 tab.connect("row-activated", self.tree_row_activated_cb)
                 tab.connect("cell-fadeinout-stopped", self.after_fadeout_checkin_include)
             label = gtk.Label(page['name'])
+            label.set_selectable(False)
+            label.set_tooltip_text(page['tooltip'])
             self.ins.append_page(tab, label)
             self.tables.append(tab)
 
         self.ins.set_entry("Search recipes:")
         # set the search entry for each table
         for tab in self.tables:
+            search_tip = "Enter a recipe's or task's name to find it"
+            self.ins.search.set_tooltip_text(search_tip)
+            self.ins.search.props.has_tooltip = True
             tab.set_search_entry(0, self.ins.search)
 
         # add all into the window
-- 
1.7.6



