Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SA032-0000oR-90
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:28:28 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 20 Mar 2012 07:19:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="119556451"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 20 Mar 2012 07:19:34 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 20 Mar 2012 22:41:04 +0800
Message-Id: <2e08a8e6818b8f1df7eaac499ebc3a5854efe7be.1332254194.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <e4ebac226cc5e4589bcecd8bada9fde462e925cc.1332254194.git.shane.wang@intel.com>
References: <e4ebac226cc5e4589bcecd8bada9fde462e925cc.1332254194.git.shane.wang@intel.com>
In-Reply-To: <cover.1332254194.git.shane.wang@intel.com>
References: <cover.1332254194.git.shane.wang@intel.com>
Subject: [PATCH 03/11] Hob: show indicators on the tabs of the Hob notebook
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
X-List-Received-Date: Tue, 20 Mar 2012 14:28:28 -0000

This patch is to show the indicators (e.g., the number of the issues) in the build details page to highlight.

Signed-off-by: Liming An <limingx.l.an@intel.com>
Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   10 ++++++++++
 bitbake/lib/bb/ui/crumbs/builder.py          |    5 +++++
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |   14 ++++++++++++++
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |    4 ++++
 4 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 63d2c7b..7a5cfe6 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -37,6 +37,8 @@ class BuildDetailsPage (HobPage):
     def __init__(self, builder):
         super(BuildDetailsPage, self).__init__(builder, "Building ...")
 
+        self.num_of_issues = 0
+
         # create visual elements
         self.create_visual_elements()
 
@@ -80,6 +82,14 @@ class BuildDetailsPage (HobPage):
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
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 1d255ac..318bcbf 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -212,6 +212,7 @@ class Builder(gtk.Window):
         self.handler.build.connect("build-succeeded",    self.handler_build_succeeded_cb)
         self.handler.build.connect("build-failed",       self.handler_build_failed_cb)
         self.handler.build.connect("task-started",       self.handler_task_started_cb)
+        self.handler.build.connect("log-error",          self.handler_build_failure_cb)
         self.handler.connect("generating-data",          self.handler_generating_data_cb)
         self.handler.connect("data-generated",           self.handler_data_generated_cb)
         self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
@@ -533,6 +534,7 @@ class Builder(gtk.Window):
         elif self.current_step == self.PACKAGE_GENERATING:
             fraction = 0
         self.build_details_page.update_progress_bar("Build Started: ", fraction)
+        self.build_details_page.reset_issues()
 
     def build_succeeded(self):
         if self.current_step == self.FAST_IMAGE_GENERATING:
@@ -600,6 +602,9 @@ class Builder(gtk.Window):
                 fraction = 0.2 + 0.8 * fraction
         self.build_details_page.update_progress_bar(title + ": ", fraction)
 
+    def handler_build_failure_cb(self, running_build):
+        self.build_details_page.show_issues()
+
     def destroy_window_cb(self, widget, event):
         lbl = "<b>Do you really want to exit the Hob image creator?</b>"
         dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 8fa663c..2c3d831 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -619,6 +619,20 @@ class HobNotebook(gtk.VBox):
  
         self.tb.show()
 
+    def show_indicator_icon(self, title, number):
+        for i, child in enumerate(self.tabbar.children):
+            if child["toggled_page"] == -1:
+                continue
+            if child["title"] == title:
+                self.tabbar.show_indicator_icon(i, number)
+
+    def hide_indicator_icon(self, title):
+        for i, child in enumerate(self.tabbar.children):
+            if child["toggled_page"] == -1:
+                continue
+            if child["title"] == title:
+                self.tabbar.hide_indicator_icon(i)
+
     def tab_switched_cb(self, widget, page):
         self.notebook.set_current_page(page)
 
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index eedd8d9..ddac232 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -84,6 +84,9 @@ class RunningBuild (gobject.GObject):
           'task-started'   : (gobject.SIGNAL_RUN_LAST,
                               gobject.TYPE_NONE,
                               (gobject.TYPE_PYOBJECT,)),
+          'log-error'      : (gobject.SIGNAL_RUN_LAST,
+                              gobject.TYPE_NONE,
+                              ()),
           }
     pids_to_task = {}
     tasks_to_iter = {}
@@ -134,6 +137,7 @@ class RunningBuild (gobject.GObject):
             if event.levelno >= logging.ERROR:
                 icon = "dialog-error"
                 color = HobColors.ERROR
+                self.emit("log-error")
             elif event.levelno >= logging.WARNING:
                 icon = "dialog-warning"
                 color = HobColors.WARNING
-- 
1.7.6



