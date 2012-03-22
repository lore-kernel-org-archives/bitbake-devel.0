Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SAjpu-0003Mf-Fp
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 16:21:58 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 22 Mar 2012 08:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="120493415"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 22 Mar 2012 08:13:00 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 23:38:09 +0800
Message-Id: <4ab4f3836fc6ad8a5ce163d0d6e44cd30d21b8b0.1332430442.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <994a3ff7aec35f01ad019ff455b699c86342945e.1332430442.git.shane.wang@intel.com>
References: <994a3ff7aec35f01ad019ff455b699c86342945e.1332430442.git.shane.wang@intel.com>
In-Reply-To: <cover.1332430442.git.shane.wang@intel.com>
References: <cover.1332430442.git.shane.wang@intel.com>
Subject: [PATCH 7/8] Hob: reset the policy to forbid the horizontal scrolling for building log
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
X-List-Received-Date: Thu, 22 Mar 2012 15:21:59 -0000

From: Liming An <limingx.l.an@intel.com>

This patch is not to show the horizontal scroll bar for building log, and add CellRendererText class to wrap the text.

[Yocto #2091]

Signed-off-by: Liming An <limingx.l.an@intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    6 +++---
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |   24 ++++++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |    7 ++++---
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 3605ee1..92ca176 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -58,7 +58,7 @@ class BuildDetailsPage (HobPage):
         self.config_model = self.builder.handler.build.model.config_model()
         self.config_tv.set_model(self.config_model)
         self.scrolled_view_config = gtk.ScrolledWindow ()
-        self.scrolled_view_config.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+        self.scrolled_view_config.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
         self.scrolled_view_config.add(self.config_tv)
         self.notebook.append_page(self.scrolled_view_config, gtk.Label("Build Configuration"))
 
@@ -66,14 +66,14 @@ class BuildDetailsPage (HobPage):
         self.failure_model = self.builder.handler.build.model.failure_model()
         self.failure_tv.set_model(self.failure_model)
         self.scrolled_view_failure = gtk.ScrolledWindow ()
-        self.scrolled_view_failure.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+        self.scrolled_view_failure.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
         self.scrolled_view_failure.add(self.failure_tv)
         self.notebook.append_page(self.scrolled_view_failure, gtk.Label("Issues"))
 
         self.build_tv = RunningBuildTreeView(readonly=True)
         self.build_tv.set_model(self.builder.handler.build.model)
         self.scrolled_view_build = gtk.ScrolledWindow ()
-        self.scrolled_view_build.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+        self.scrolled_view_build.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
         self.scrolled_view_build.add(self.build_tv)
         self.notebook.append_page(self.scrolled_view_build, gtk.Label("Log"))
 
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 9d00023..c07db6c 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -706,3 +706,27 @@ class HobNotebook(gtk.VBox):
     def set_search_entry_clear_cb(self, search, icon_pos, event):
         self.reset_entry(search)
 
+class HobWarpCellRendererText(gtk.CellRendererText):
+    def __init__(self, col_number):
+        gtk.CellRendererText.__init__(self)
+        self.set_property("wrap-mode", pango.WRAP_WORD_CHAR)
+        self.set_property("wrap-width", 300) # default value wrap width is 300
+        self.col_n = col_number
+
+    def do_render(self, window, widget, background_area, cell_area, expose_area, flags):
+        if widget:
+            self.props.wrap_width = self.get_resized_wrap_width(widget, widget.get_column(self.col_n))
+        return gtk.CellRendererText.do_render(self, window, widget, background_area, cell_area, expose_area, flags)
+
+    def get_resized_wrap_width(self, treeview, column):
+        otherCols = []
+        for col in treeview.get_columns():
+            if col != column:
+                otherCols.append(col)
+        adjwidth = treeview.allocation.width - sum(c.get_width() for c in otherCols)
+        adjwidth -= treeview.style_get_property("horizontal-separator") * 4
+        if self.props.wrap_width == adjwidth or adjwidth <= 0:
+                adjwidth = self.props.wrap_width
+        return adjwidth
+
+gobject.type_register(HobWarpCellRendererText)
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 4c3fe2c..f202a90 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -27,6 +27,7 @@ import urllib
 import urllib2
 import pango
 from bb.ui.crumbs.hobcolor import HobColors
+from bb.ui.crumbs.hobwidget import HobWarpCellRendererText
 
 class RunningBuildModel (gtk.TreeStore):
     (COL_LOG, COL_PACKAGE, COL_TASK, COL_MESSAGE, COL_ICON, COL_COLOR, COL_NUM_ACTIVE) = range(7)
@@ -350,7 +351,7 @@ class RunningBuildTreeView (gtk.TreeView):
         self.append_column (col)
 
         # The message of the build.
-        self.message_renderer = gtk.CellRendererText ()
+        self.message_renderer = HobWarpCellRendererText (col_number=1)
         self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=3)
         self.message_column.add_attribute(self.message_renderer, 'background', 5)
         self.message_renderer.set_property('editable', (not self.readonly))
@@ -419,7 +420,7 @@ class BuildConfigurationTreeView(gtk.TreeView):
         self.get_selection().set_mode(gtk.SELECTION_SINGLE)
 
         # The message of the build.
-        self.message_renderer = gtk.CellRendererText ()
+        self.message_renderer = HobWarpCellRendererText (col_number=0)
         self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=RunningBuildModel.COL_MESSAGE, background=RunningBuildModel.COL_COLOR)
         font = self.get_style().font_desc
         font.set_size(pango.SCALE * 13)
@@ -442,6 +443,6 @@ class BuildFailureTreeView(gtk.TreeView):
         self.append_column (col)
 
         # The message of the build.
-        self.message_renderer = gtk.CellRendererText ()
+        self.message_renderer = HobWarpCellRendererText (col_number=1)
         self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=RunningBuildModel.COL_MESSAGE, background=RunningBuildModel.COL_COLOR)
         self.append_column (self.message_column)
-- 
1.7.6



