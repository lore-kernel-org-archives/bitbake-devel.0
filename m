Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEing-0005fv-6Q
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 17:04:08 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Apr 2012 07:55:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="124501496"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga001.jf.intel.com with ESMTP; 02 Apr 2012 07:55:01 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Apr 2012 23:22:38 +0800
Message-Id: <1b154fde4b6b403c8cea5b473baa029f9f264281.1333379931.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <7ef65b5d1a00fe42d39be41ddd93fc75ade17308.1333379931.git.shane.wang@intel.com>
References: <7ef65b5d1a00fe42d39be41ddd93fc75ade17308.1333379931.git.shane.wang@intel.com>
In-Reply-To: <cover.1333379931.git.shane.wang@intel.com>
References: <cover.1333379931.git.shane.wang@intel.com>
Subject: [PATCH 2/4] Hob: log for Hob and allow users to show logs after successful build
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
X-List-Received-Date: Mon, 02 Apr 2012 15:04:08 -0000

If users build images in Hob, record logs and allow users to retrieve the logs
after successful build.

The logs are generated if and only if:
  - users do "just bake"
  - users do "build image" after "build packages"

Only "build packages" will not write logs because there is no chance for users
to retrieve on the GUI.

[Yocto #1991]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py          |   36 +++++++++++++++--
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py  |    3 +
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   14 ++++++-
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |   53 ++++++++++++++++++++++++++
 4 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 6587734..de4fb29 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -26,6 +26,7 @@ import copy
 import os
 import subprocess
 import shlex
+import logging
 from bb.ui.crumbs.template import TemplateMgr
 from bb.ui.crumbs.imageconfigurationpage import ImageConfigurationPage
 from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
@@ -260,6 +261,11 @@ class Builder(gtk.Window):
 
         self.template = None
 
+        # logger
+        self.logger = logging.getLogger("BitBake")
+        self.consolelog = None
+        self.current_logfile = None
+
         # build step
         self.current_step = None
         self.previous_step = None
@@ -287,6 +293,7 @@ class Builder(gtk.Window):
         self.handler.build.connect("build-failed",       self.handler_build_failed_cb)
         self.handler.build.connect("task-started",       self.handler_task_started_cb)
         self.handler.build.connect("log-error",          self.handler_build_failure_cb)
+        self.handler.build.connect("log",                self.handler_build_log_cb)
         self.handler.connect("generating-data",          self.handler_generating_data_cb)
         self.handler.connect("data-generated",           self.handler_data_generated_cb)
         self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
@@ -396,7 +403,7 @@ class Builder(gtk.Window):
         elif next_step == self.PACKAGE_GENERATING or next_step == self.FAST_IMAGE_GENERATING:
             # both PACKAGE_GENEATING and FAST_IMAGE_GENERATING share the same page
             self.build_details_page.show_page(next_step)
-            self.generate_packages()
+            self.generate_packages(next_step == self.FAST_IMAGE_GENERATING)
 
         elif next_step == self.PACKAGE_GENERATED:
             pass
@@ -405,7 +412,7 @@ class Builder(gtk.Window):
             # after packages are generated, selected_packages need to
             # be updated in package_model per selected_image in recipe_model
             self.build_details_page.show_page(next_step)
-            self.generate_image()
+            self.generate_image(self.current_step == self.FAST_IMAGE_GENERATING)
 
         elif next_step == self.IMAGE_GENERATED:
             self.image_details_page.show_page(next_step)
@@ -454,7 +461,10 @@ class Builder(gtk.Window):
         left = self.package_model.set_selected_packages(selected_packages)
         self.configuration.selected_packages += left
 
-    def generate_packages(self):
+    def generate_packages(self, log = False):
+        if log:
+            self.current_logfile = self.handler.get_logfile()
+            self.do_log(self.current_logfile)
         # Build packages
         _, all_recipes = self.recipe_model.get_selected_recipes()
         self.set_user_config()
@@ -466,7 +476,10 @@ class Builder(gtk.Window):
         self.set_user_config()
         self.handler.generate_recipes()
 
-    def generate_image(self):
+    def generate_image(self, cont = False):
+        if not cont:
+            self.current_logfile = self.handler.get_logfile()
+            self.do_log(self.current_logfile)
         # Build image
         self.set_user_config()
         all_packages = self.package_model.get_selected_packages()
@@ -708,6 +721,10 @@ class Builder(gtk.Window):
     def handler_build_failure_cb(self, running_build):
         self.build_details_page.show_issues()
 
+    def handler_build_log_cb(self, running_build, func, obj):
+        if hasattr(self.logger, func):
+            getattr(self.logger, func)(obj)
+
     def destroy_window_cb(self, widget, event):
         lbl = "<b>Do you really want to exit the Hob image creator?</b>"
         dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
@@ -1033,3 +1050,14 @@ class Builder(gtk.Window):
             self.handler.cancel_build()
         elif response == gtk.RESPONSE_YES:
             self.handler.cancel_build(True)
+
+    def do_log(self, consolelogfile = None):
+        if consolelogfile:
+            if self.consolelog:
+                self.logger.removeHandler(self.consolelog)
+                self.consolelog = None
+            self.consolelog = logging.FileHandler(consolelogfile)
+            bb.msg.addDefaultlogFilter(self.consolelog)
+            format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+            self.consolelog.setFormatter(format)
+            self.logger.addHandler(self.consolelog)
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 61af131..de228d9 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -381,6 +381,9 @@ class HobHandler(gobject.GObject):
     def reset_build(self):
         self.build.reset()
 
+    def get_logfile(self):
+        return self.server.runCommand(["getVariable", "BB_CONSOLELOG"])
+
     def get_parameters(self):
         # retrieve the parameters from bitbake
         params = {}
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index a5d0ad8..39ccfdc 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -159,8 +159,10 @@ class ImageDetailsPage (HobPage):
             machine = self.builder.configuration.curr_mach
             base_image = self.builder.recipe_model.get_selected_image()
             layers = self.builder.configuration.layers
+            log_file = self.builder.current_logfile
             pkg_num = "%s" % len(self.builder.package_model.get_selected_packages())
         else:
+            log_file = None
             pkg_num = "N/A"
 
         self._remove_all_widget()
@@ -204,9 +206,15 @@ class ImageDetailsPage (HobPage):
         image_table = HobViewTable(self.__columns__)
         image_table.set_model(self.image_store)
         image_table.connect("toggled", self.toggled_cb)
+        view_buttons = gtk.VBox(False, 6)
         view_files_button = HobAltButton("View files")
         view_files_button.connect("clicked", self.view_files_clicked_cb, image_addr)
-        self.box_group_area.pack_start(self.DetailBox(widget=image_table, button=view_files_button), expand=True, fill=True)
+        view_buttons.pack_start(view_files_button, expand=True, fill=True)
+        if log_file:
+            view_logs_button = HobAltButton("View logs")
+            view_logs_button.connect("clicked", self.view_logs_clicked_cb, log_file)
+            view_buttons.pack_end(view_logs_button, expand=True, fill=True)
+        self.box_group_area.pack_start(self.DetailBox(widget=image_table, button=view_buttons), expand=True, fill=True)
 
         # Machine, Base image and Layers
         layer_num_limit = 15
@@ -258,6 +266,10 @@ class ImageDetailsPage (HobPage):
     def view_files_clicked_cb(self, button, image_addr):
         os.system("xdg-open /%s" % image_addr)
 
+    def view_logs_clicked_cb(self, button, log_file):
+        if log_file:
+            os.system("xdg-open /%s" % log_file)
+
     def refresh_package_detail_box(self, image_size):
         self.package_detail.update_line_widgets("Total image size: ", image_size)
 
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 042902e..b42f9c8 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -82,6 +82,9 @@ class RunningBuild (gobject.GObject):
           'log-error'       :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                ()),
+          'log'             :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                               (gobject.TYPE_STRING, gobject.TYPE_PYOBJECT,)),
           }
     pids_to_task = {}
     tasks_to_iter = {}
@@ -119,6 +122,8 @@ class RunningBuild (gobject.GObject):
             parent = self.tasks_to_iter[(package, task)]
 
         if(isinstance(event, logging.LogRecord)):
+            if event.taskpid == 0 or event.levelno > logging.INFO:
+                self.emit("log", "handle", event)
             # FIXME: this is a hack! More info in Yocto #1433
             # http://bugzilla.pokylinux.org/show_bug.cgi?id=1433, temporarily
             # mask the error message as it's not informative for the user.
@@ -204,6 +209,7 @@ class RunningBuild (gobject.GObject):
             self.tasks_to_iter[(package, task)] = i
 
         elif isinstance(event, bb.build.TaskBase):
+            self.emit("log", "info", event._message)
             current = self.tasks_to_iter[(package, task)]
             parent = self.tasks_to_iter[(package, None)]
 
@@ -284,6 +290,7 @@ class RunningBuild (gobject.GObject):
                 pbar.set_text(event.msg)
 
         elif isinstance(event, bb.command.CommandFailed):
+            self.emit("log", "error", "Command execution failed: %s" % (event.error))
             if event.error.startswith("Exited with"):
                 # If the command fails with an exit code we're done, emit the
                 # generic signal for the UI to notify the user
@@ -311,7 +318,41 @@ class RunningBuild (gobject.GObject):
         elif isinstance(event, bb.event.ParseCompleted) and pbar:
             pbar.hide()
         #using runqueue events as many as possible to update the progress bar
+        elif isinstance(event, bb.event.MultipleProviders):
+            self.emit("log", "info", "multiple providers are available for %s%s (%s)" \
+                                     % (event._is_runtime and "runtime " or "", event._item, ", ".join(event._candidates)))
+            self.emit("log", "info", "consider defining a PREFERRED_PROVIDER entry to match %s" % (event._item))
+        elif isinstance(event, bb.event.NoProvider):
+            if event._runtime:
+                r = "R"
+            else:
+                r = ""
+            if event._dependees:
+                self.emit("log", "error", "Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)" \
+                                          % (r, event._item, ", ".join(event._dependees), r))
+            else:
+                self.emit("log", "error", "Nothing %sPROVIDES '%s'" % (r, event._item))
+            if event._reasons:
+                for reason in event._reasons:
+                    self.emit("log", "error", "%s" % (reason))
+        elif isinstance(event, bb.runqueue.runQueueTaskFailed):
+            self.emit("log", "error", "Task %s (%s) failed with exit code '%s'" % (event.taskid, event.taskstring, event.exitcode))
+        elif isinstance(event, bb.runqueue.sceneQueueTaskFailed):
+            self.emit("log", "warn", "Setscene task %s (%s) failed with exit code '%s' - real task will be run instead" \
+                                     % (event.taskid, event.taskstring, event.exitcode))
         elif isinstance(event, (bb.runqueue.runQueueTaskStarted, bb.runqueue.sceneQueueTaskStarted)):
+            if isinstance(event, bb.runqueue.sceneQueueTaskStarted):
+                self.emit("log", "info", "Running setscene task %d of %d (%s)" % \
+                                         (event.stats.completed + event.stats.active + event.stats.failed + 1,
+                                          event.stats.total, event.taskstring))
+            else:
+                if event.noexec:
+                    tasktype = 'noexec task'
+                else:
+                    tasktype = 'task'
+                self.emit("log", "info", "Running %s %s of %s (ID: %s, %s)" % \
+                                         (tasktype, event.stats.completed + event.stats.active + event.stats.failed + 1,
+                                          event.stats.total, event.taskid, event.taskstring))
             message = {}
             message["eventname"] = bb.event.getName(event)
             num_of_completed = event.stats.completed + event.stats.failed
@@ -320,6 +361,18 @@ class RunningBuild (gobject.GObject):
             message["title"] = ""
             message["task"] = event.taskstring
             self.emit("task-started", message)
+        else:
+            if not isinstance(event, (bb.event.BuildBase,
+                                      bb.event.StampUpdate,
+                                      bb.event.ConfigParsed,
+                                      bb.event.RecipeParsed,
+                                      bb.event.RecipePreFinalise,
+                                      bb.runqueue.runQueueEvent,
+                                      bb.runqueue.runQueueExitWait,
+                                      bb.event.OperationStarted,
+                                      bb.event.OperationCompleted,
+                                      bb.event.OperationProgress)):
+                self.emit("log", "error", "Unknown event: %s" % (error))
 
         return
 
-- 
1.7.6



