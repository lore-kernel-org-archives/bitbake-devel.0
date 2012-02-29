Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1S2kC3-0005ES-N9
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Feb 2012 15:07:48 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Feb 2012 05:59:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113065004"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 29 Feb 2012 05:58:18 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Feb 2012 22:15:04 +0800
Message-Id: <1239984c43d315bad4de8834690222e06c951977.1330523904.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
In-Reply-To: <cover.1330523904.git.shane.wang@intel.com>
References: <cover.1330523904.git.shane.wang@intel.com>
Subject: [PATCH 07/32] Hob: use HobNotebook to enable a notebook in build details page
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
X-List-Received-Date: Wed, 29 Feb 2012 14:07:48 -0000

This patch is to use HobNotebook we defined to implement the notebook in the build details page.
And more the "build configuration" tab and the "issues" tab use more tree views which we implemented in runningbuild.py.

Signed-off-by: Liming An <limingx.l.an@intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   40 +++++++++++++--
 bitbake/lib/bb/ui/crumbs/builder.py          |    5 ++
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |   14 +++++
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |   69 ++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 941f1e3..4a9f658 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -22,8 +22,10 @@
 
 import gtk
 from bb.ui.crumbs.progressbar import HobProgressBar
-from bb.ui.crumbs.hobwidget import hic
+from bb.ui.crumbs.hobwidget import hic, HobNotebook
 from bb.ui.crumbs.runningbuild import RunningBuildTreeView
+from bb.ui.crumbs.runningbuild import BuildConfigurationTreeView
+from bb.ui.crumbs.runningbuild import BuildFailureTreeView
 from bb.ui.crumbs.hobpages import HobPage
 
 #
@@ -35,6 +37,8 @@ class BuildDetailsPage (HobPage):
     def __init__(self, builder):
         super(BuildDetailsPage, self).__init__(builder, "Building ...")
 
+        self.num_of_issues = 0
+
         # create visual elements
         self.create_visual_elements()
 
@@ -49,17 +53,43 @@ class BuildDetailsPage (HobPage):
         self.stop_button.connect("clicked", self.stop_button_clicked_cb)
         self.progress_box.pack_end(self.stop_button, expand=False, fill=False)
 
+        self.notebook = HobNotebook()
+        self.config_tv = BuildConfigurationTreeView()
+        self.config_model = self.builder.handler.build.model.config_model()
+        self.config_tv.set_model(self.config_model)
+        self.scrolled_view_config = gtk.ScrolledWindow ()
+        self.scrolled_view_config.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+        self.scrolled_view_config.add(self.config_tv)
+        self.notebook.append_page(self.scrolled_view_config, gtk.Label("Build Configuration"))
+
+        self.failure_tv = BuildFailureTreeView()
+        self.failure_model = self.builder.handler.build.model.failure_model()
+        self.failure_tv.set_model(self.failure_model)
+        self.scrolled_view_failure = gtk.ScrolledWindow ()
+        self.scrolled_view_failure.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+        self.scrolled_view_failure.add(self.failure_tv)
+        self.notebook.append_page(self.scrolled_view_failure, gtk.Label("Issues"))
+
         self.build_tv = RunningBuildTreeView(readonly=True)
         self.build_tv.set_model(self.builder.handler.build.model)
-        self.scrolled_view = gtk.ScrolledWindow ()
-        self.scrolled_view.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
-        self.scrolled_view.add(self.build_tv)
+        self.scrolled_view_build = gtk.ScrolledWindow ()
+        self.scrolled_view_build.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+        self.scrolled_view_build.add(self.build_tv)
+        self.notebook.append_page(self.scrolled_view_build, gtk.Label("Log"))
 
         self.button_box = gtk.HBox(False, 5)
         self.back_button = gtk.LinkButton("Go back to Image Configuration screen", "<< Back to image configuration")
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         self.button_box.pack_start(self.back_button, expand=False, fill=False)
 
+    def show_issues(self):
+        self.num_of_issues += 1
+        self.notebook.show_indicator_icon("Issues", self.num_of_issues)
+
+    def reset_issues(self):
+        self.num_of_issues = 0
+        self.notebook.hide_indicator_icon("Issues")
+
     def _remove_all_widget(self):
         children = self.vbox.get_children() or []
         for child in children:
@@ -86,7 +116,7 @@ class BuildDetailsPage (HobPage):
         self.progress_bar.reset()
         self.vbox.pack_start(self.progress_box, expand=False, fill=False)
 
-        self.vbox.pack_start(self.scrolled_view, expand=True, fill=True)
+        self.vbox.pack_start(self.notebook, expand=True, fill=True)
 
         self.box_group_area.pack_end(self.button_box, expand=False, fill=False)
         self.show_all()
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index eb38819..819b79f 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -214,6 +214,7 @@ class Builder(gtk.Window):
         self.handler.build.connect("build-succeeded",    self.handler_build_succeeded_cb)
         self.handler.build.connect("build-failed",       self.handler_build_failed_cb)
         self.handler.build.connect("task-started",       self.handler_task_started_cb)
+        self.handler.build.connect("log-error",          self.handler_build_failure_cb)
         self.handler.connect("generating-data",          self.handler_generating_data_cb)
         self.handler.connect("data-generated",           self.handler_data_generated_cb)
         self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
@@ -528,6 +529,7 @@ class Builder(gtk.Window):
         elif self.current_step == self.PACKAGE_GENERATING:
             fraction = 0
         self.build_details_page.update_progress_bar("Build Started: ", fraction)
+        self.build_details_page.reset_issues()
 
     def handler_build_succeeded_cb(self, running_build):
         self.build_succeeded = True
@@ -586,6 +588,9 @@ class Builder(gtk.Window):
                 fraction = 0.2 + 0.8 * fraction
         self.build_details_page.update_progress_bar(title + ": ", fraction)
 
+    def handler_build_failure_cb(self, running_build):
+        self.build_details_page.show_issues()
+
     def destroy_window_cb(self, widget, event):
         lbl = "<b>Do you really want to exit the Hob image creator?</b>"
         dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index a2d99a2..c4a0513 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -569,6 +569,20 @@ class HobNotebook(gtk.VBox):
  
         self.tb.show()
 
+    def show_indicator_icon(self, title, number):
+        for i in range(len(self.tabbar.children)):
+            if self.tabbar.children[i]["toggled_page"] == -1:
+                continue
+            if self.tabbar.children[i]["title"] == title:
+                self.tabbar.show_indicator_icon(i, number)
+
+    def hide_indicator_icon(self, title):
+        for i in range(len(self.tabbar.children)):
+            if self.tabbar.children[i]["toggled_page"] == -1:
+                continue
+            if self.tabbar.children[i]["title"] == title:
+                self.tabbar.hide_indicator_icon(i)
+
     def tab_switched_cb(self, widget, page):
         self.notebook.set_current_page(page)
 
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 718f692..ddac232 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -25,6 +25,7 @@ import logging
 import time
 import urllib
 import urllib2
+import pango
 from bb.ui.crumbs.hobcolor import HobColors
 
 class RunningBuildModel (gtk.TreeStore):
@@ -40,6 +41,32 @@ class RunningBuildModel (gtk.TreeStore):
                                 gobject.TYPE_STRING,
                                 gobject.TYPE_INT)
 
+    def config_model_filter(self, model, it):
+        msg = model.get(it, self.COL_MESSAGE)[0]
+        if msg == None or type(msg) != str:
+            return False
+        if msg.startswith("\nOE Build Configuration:\n"):
+            return True
+        return False
+
+    def failure_model_filter(self, model, it):
+        color = model.get(it, self.COL_COLOR)[0]
+        if color == None:
+            return False
+        if color == HobColors.ERROR:
+            return True
+        return False
+
+    def config_model(self):
+        model = self.filter_new()
+        model.set_visible_func(self.config_model_filter)
+        return model
+
+    def failure_model(self):
+        model = self.filter_new()
+        model.set_visible_func(self.failure_model_filter)
+        return model
+
 class RunningBuild (gobject.GObject):
     __gsignals__ = {
           'build-started' : (gobject.SIGNAL_RUN_LAST,
@@ -57,6 +84,9 @@ class RunningBuild (gobject.GObject):
           'task-started'   : (gobject.SIGNAL_RUN_LAST,
                               gobject.TYPE_NONE,
                               (gobject.TYPE_PYOBJECT,)),
+          'log-error'      : (gobject.SIGNAL_RUN_LAST,
+                              gobject.TYPE_NONE,
+                              ()),
           }
     pids_to_task = {}
     tasks_to_iter = {}
@@ -107,6 +137,7 @@ class RunningBuild (gobject.GObject):
             if event.levelno >= logging.ERROR:
                 icon = "dialog-error"
                 color = HobColors.ERROR
+                self.emit("log-error")
             elif event.levelno >= logging.WARNING:
                 icon = "dialog-warning"
                 color = HobColors.WARNING
@@ -376,3 +407,41 @@ class RunningBuildTreeView (gtk.TreeView):
         message = model.get(it, model.COL_MESSAGE)[0]
 
         self._add_to_clipboard(message)
+
+
+class BuildConfigurationTreeView(gtk.TreeView):
+
+    def __init__ (self):
+        gtk.TreeView.__init__(self)
+        self.set_rules_hint(False)
+        self.set_headers_visible(False)
+        self.set_property("hover-expand", True)
+        self.get_selection().set_mode(gtk.SELECTION_SINGLE)
+
+        # The message of the build.
+        self.message_renderer = gtk.CellRendererText ()
+        self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=RunningBuildModel.COL_MESSAGE, background=RunningBuildModel.COL_COLOR)
+        font = self.get_style().font_desc
+        font.set_size(pango.SCALE * 13)
+        self.message_renderer.set_property('font-desc', font)
+        self.append_column (self.message_column)
+
+
+class BuildFailureTreeView(gtk.TreeView):
+
+    def __init__ (self):
+        gtk.TreeView.__init__(self)
+        self.set_rules_hint(False)
+        self.set_headers_visible(False)
+        self.get_selection().set_mode(gtk.SELECTION_SINGLE)
+
+        # The icon that indicates whether we're building or failed.
+        renderer = gtk.CellRendererPixbuf ()
+        col = gtk.TreeViewColumn ("Status", renderer)
+        col.add_attribute (renderer, "icon-name", RunningBuildModel.COL_ICON)
+        self.append_column (col)
+
+        # The message of the build.
+        self.message_renderer = gtk.CellRendererText ()
+        self.message_column = gtk.TreeViewColumn ("Message", self.message_renderer, text=RunningBuildModel.COL_MESSAGE, background=RunningBuildModel.COL_COLOR)
+        self.append_column (self.message_column)
-- 
1.7.6



