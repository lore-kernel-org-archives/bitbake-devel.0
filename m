Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SC7UR-00006p-WD
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 12:49:32 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 26 Mar 2012 03:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="121679626"
Received: from hp.sh.intel.com ([10.239.47.1])
	by orsmga001.jf.intel.com with ESMTP; 26 Mar 2012 03:39:09 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 18:41:11 +0800
Message-Id: <356038d60e6b46c51719cdb6f626ce7b8121cc32.1332752084.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <5812479c5fea3d18618e09521a804a6acd2cefdf.1332752084.git.limingx.l.an@intel.com>
References: <5812479c5fea3d18618e09521a804a6acd2cefdf.1332752084.git.limingx.l.an@intel.com>
In-Reply-To: <cover.1332752084.git.limingx.l.an@intel.com>
References: <cover.1332752084.git.limingx.l.an@intel.com>
Subject: [PATCH 5/5] HOB: Splited configuration info of building log to a independently page from the log page
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
X-List-Received-Date: Mon, 26 Mar 2012 10:49:32 -0000

Make the building log config information to a new page as request

[YOCTO #2144]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   10 ++++++++--
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |   26 ++++++++++++--------------
 2 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index c2f980f..362f63d 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -60,8 +60,6 @@ class BuildDetailsPage (HobPage):
 
         self.notebook = HobNotebook()
         self.config_tv = BuildConfigurationTreeView()
-        self.config_model = self.builder.handler.build.model.config_model()
-        self.config_tv.set_model(self.config_model)
         self.scrolled_view_config = gtk.ScrolledWindow ()
         self.scrolled_view_config.set_policy(gtk.POLICY_NEVER, gtk.POLICY_ALWAYS)
         self.scrolled_view_config.add(self.config_tv)
@@ -82,6 +80,7 @@ class BuildDetailsPage (HobPage):
         self.scrolled_view_build.add(self.build_tv)
         self.notebook.append_page(self.scrolled_view_build, gtk.Label("Log"))
 
+        self.builder.handler.build.model.connect('update-config-info', self.update_config_model_cb)
         self.builder.handler.build.model.connect_after("row-changed", self.scroll_to_present_row, self.scrolled_view_build.get_vadjustment(), self.build_tv)
 
         self.button_box = gtk.HBox(False, 6)
@@ -158,3 +157,10 @@ class BuildDetailsPage (HobPage):
                 self.endpath = path
                 if v_adj.value == (v_adj.upper - v_adj.page_size): # check the gtk.adjustment position is at end boundary or not
                     treeview.scroll_to_cell(path)
+
+    def update_config_model_cb(self, origin, msg):
+        if msg and type(msg) == str:
+            import gobject
+            config_model = gtk.ListStore(gobject.TYPE_STRING)
+            config_model.append([msg])
+            self.config_tv.set_model(config_model)
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index aecfadf..98cba79 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -32,6 +32,11 @@ from bb.ui.crumbs.hobwidget import HobWarpCellRendererText, HobCellRendererPixbu
 class RunningBuildModel (gtk.TreeStore):
     (COL_LOG, COL_PACKAGE, COL_TASK, COL_MESSAGE, COL_ICON, COL_COLOR, COL_NUM_ACTIVE) = range(7)
 
+    __gsignals__ = {
+          'update-config-info' : (gobject.SIGNAL_RUN_LAST,
+                               gobject.TYPE_NONE,
+                               (gobject.TYPE_STRING,)),
+    }
     def __init__ (self):
         gtk.TreeStore.__init__ (self,
                                 gobject.TYPE_STRING,
@@ -42,14 +47,6 @@ class RunningBuildModel (gtk.TreeStore):
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_INT)
 
-    def config_model_filter(self, model, it):
-        msg = model.get(it, self.COL_MESSAGE)[0]
-        if not msg or type(msg) != str:
-            return False
-        if msg.startswith("\nOE Build Configuration:\n"):
-            return True
-        return False
-
     def failure_model_filter(self, model, it):
         color = model.get(it, self.COL_COLOR)[0]
         if not color:
@@ -58,11 +55,6 @@ class RunningBuildModel (gtk.TreeStore):
             return True
         return False
 
-    def config_model(self):
-        model = self.filter_new()
-        model.set_visible_func(self.config_model_filter)
-        return model
-
     def failure_model(self):
         model = self.filter_new()
         model.set_visible_func(self.failure_model_filter)
@@ -75,6 +67,8 @@ class RunningBuildModel (gtk.TreeStore):
     def close_task_refresh(self):
         self.foreach(self.foreach_cell_func, None)
 
+    def update_configuration_info(self, msg):
+        self.emit("update-config-info", msg)
 
 class RunningBuild (gobject.GObject):
     __gsignals__ = {
@@ -138,6 +132,10 @@ class RunningBuild (gobject.GObject):
             # mask the error message as it's not informative for the user.
             if event.msg.startswith("Execution of event handler 'run_buildstats' failed"):
                 return
+            # split the configuration info to a independent view page
+            if event.msg.startswith("\nOE Build Configuration:\n"):
+                self.model.update_configuration_info(event.msg)
+                return
 
             if (event.levelno < logging.INFO or
                 event.msg.startswith("Running task")):
@@ -434,7 +432,7 @@ class BuildConfigurationTreeView(gtk.TreeView):
 
         # The message of the build.
         self.message_renderer = HobWarpCellRendererText (col_number=0)
-        self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=RunningBuildModel.COL_MESSAGE, background=RunningBuildModel.COL_COLOR)
+        self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=0)
         font = self.get_style().font_desc
         font.set_size(pango.SCALE * 13)
         self.message_renderer.set_property('font-desc', font)
-- 
1.7.5.4



