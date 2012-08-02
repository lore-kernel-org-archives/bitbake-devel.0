Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SwtKu-0005LD-Pa
	for bitbake-devel@lists.openembedded.org;
	Thu, 02 Aug 2012 13:13:01 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 02 Aug 2012 04:01:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="176129799"
Received: from hp.sh.intel.com ([10.239.47.150])
	by azsmga001.ch.intel.com with ESMTP; 02 Aug 2012 04:01:19 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Aug 2012 19:06:01 +0800
Message-Id: <ec0c5d8bfb088d18270bec6157542545810e1d90.1343905168.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1343905168.git.limingx.l.an@intel.com>
References: <cover.1343905168.git.limingx.l.an@intel.com>
Subject: [PATCH 1/2] Hob: log for Hob and allow users to show logs after successful build
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
X-List-Received-Date: Thu, 02 Aug 2012 11:13:01 -0000

If users build images in Hob, record logs and allow users to retrieve the lo
after successful build.

The logs are generated if and only if:
      - users do "just bake"
      - users do "build image" after "build packages"
      - users do "build packages" only

[YOCTO #1991]

Signed-off-by: Shane Wang <shane.wang@intel.com>
Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py              |   52 +++++++++++++++++----
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py      |    3 +
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |   24 ++++++++--
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |   27 ++++++++++--
 bitbake/lib/bb/ui/crumbs/runningbuild.py         |   41 +++++++++++++++++
 5 files changed, 129 insertions(+), 18 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 123608e..6e5e532 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -27,6 +27,7 @@ import os
 import subprocess
 import shlex
 import re
+import logging
 from bb.ui.crumbs.template import TemplateMgr
 from bb.ui.crumbs.imageconfigurationpage import ImageConfigurationPage
 from bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage
@@ -395,6 +396,11 @@ class Builder(gtk.Window):
 
         self.template = None
 
+        # logger
+        self.logger = logging.getLogger("BitBake")
+        self.consolelog = None
+        self.current_logfile = None
+
         # configuration and parameters
         self.configuration = Configuration()
         self.parameters = Parameters()
@@ -432,6 +438,7 @@ class Builder(gtk.Window):
         self.handler.build.connect("build-failed",       self.handler_build_failed_cb)
         self.handler.build.connect("task-started",       self.handler_task_started_cb)
         self.handler.build.connect("log-error",          self.handler_build_failure_cb)
+        self.handler.build.connect("log",                self.handler_build_log_cb)
         self.handler.build.connect("no-provider",        self.handler_no_provider_cb)
         self.handler.connect("generating-data",          self.handler_generating_data_cb)
         self.handler.connect("data-generated",           self.handler_data_generated_cb)
@@ -500,25 +507,34 @@ class Builder(gtk.Window):
         self.set_user_config()
         self.handler.generate_recipes()
 
-    def generate_packages_async(self):
+    def generate_packages_async(self, log = False):
         self.switch_page(self.PACKAGE_GENERATING)
+        if log:
+            self.current_logfile = self.handler.get_logfile()
+            self.do_log(self.current_logfile)
         # Build packages
         _, all_recipes = self.recipe_model.get_selected_recipes()
         self.set_user_config()
         self.handler.reset_build()
         self.handler.generate_packages(all_recipes, self.configuration.default_task)
 
-    def fast_generate_image_async(self):
+    def fast_generate_image_async(self, log = False):
         self.switch_page(self.FAST_IMAGE_GENERATING)
+        if log:
+            self.current_logfile = self.handler.get_logfile()
+            self.do_log(self.current_logfile)
         # Build packages
         _, all_recipes = self.recipe_model.get_selected_recipes()
         self.set_user_config()
         self.handler.reset_build()
         self.handler.generate_packages(all_recipes, self.configuration.default_task)
 
-    def generate_image_async(self):
+    def generate_image_async(self, cont = False):
         self.switch_page(self.IMAGE_GENERATING)
         self.handler.reset_build()
+        if not cont:
+            self.current_logfile = self.handler.get_logfile()
+            self.do_log(self.current_logfile)
         # Build image
         self.set_user_config()
         toolchain_packages = []
@@ -626,14 +642,14 @@ class Builder(gtk.Window):
             pass
 
         elif next_step == self.PACKAGE_SELECTION:
-            pass
+            self.package_details_page.show_page(self.current_logfile)
 
         elif next_step == self.PACKAGE_GENERATING or next_step == self.FAST_IMAGE_GENERATING:
             # both PACKAGE_GENEATING and FAST_IMAGE_GENERATING share the same page
             self.build_details_page.show_page(next_step)
 
         elif next_step == self.PACKAGE_GENERATED:
-            pass
+            self.package_details_page.show_page(self.current_logfile)
 
         elif next_step == self.IMAGE_GENERATING:
             # after packages are generated, selected_packages need to
@@ -735,7 +751,7 @@ class Builder(gtk.Window):
 
             self.rcppkglist_populated()
             if self.current_step == self.FAST_IMAGE_GENERATING:
-                self.generate_image_async()
+                self.generate_image_async(True)
 
     def show_error_dialog(self, msg):
         lbl = "<b>Error</b>\n"
@@ -959,6 +975,10 @@ class Builder(gtk.Window):
     def handler_build_failure_cb(self, running_build):
         self.build_details_page.show_issues()
 
+    def handler_build_log_cb(self, running_build, func, obj):
+        if hasattr(self.logger, func):
+            getattr(self.logger, func)(obj)
+
     def destroy_window_cb(self, widget, event):
         if not self.sensitive:
             return True
@@ -988,7 +1008,7 @@ class Builder(gtk.Window):
             dialog.run()
             dialog.destroy()
             return
-        self.generate_packages_async()
+        self.generate_packages_async(True)
 
     def build_image(self):
         selected_packages = self.package_model.get_selected_packages()
@@ -1001,7 +1021,7 @@ class Builder(gtk.Window):
             dialog.run()
             dialog.destroy()
             return
-        self.generate_image_async()
+        self.generate_image_async(True)
 
     def just_bake(self):
         selected_image = self.recipe_model.get_selected_image()
@@ -1018,7 +1038,7 @@ class Builder(gtk.Window):
             dialog.destroy()
             return
 
-        self.fast_generate_image_async()
+        self.fast_generate_image_async(True)
 
     def show_binb_dialog(self, binb):
         markup = "<b>Brought in by:</b>\n%s" % binb
@@ -1237,7 +1257,7 @@ class Builder(gtk.Window):
             response = dialog.run()
             dialog.destroy()
             if response == gtk.RESPONSE_YES:
-                self.generate_packages_async()
+                self.generate_packages_async(True)
             else:
                 self.switch_page(self.PACKAGE_SELECTION)
         else:
@@ -1285,3 +1305,15 @@ class Builder(gtk.Window):
             self.cancel_build_sync()
         elif response == gtk.RESPONSE_YES:
             self.cancel_build_sync(True)
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
+
+            self.logger.addHandler(self.consolelog)
\ No newline at end of file
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index a00fcd8..540dde0 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -390,6 +390,9 @@ class HobHandler(gobject.GObject):
     def reset_build(self):
         self.build.reset()
 
+    def get_logfile(self):
+        return self.server.runCommand(["getVariable", "BB_CONSOLELOG"])
+
     def _remove_redundant(self, string):
         ret = []
         for i in string.split():
diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
index 596fb85..40eb7a4 100755
--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
@@ -33,7 +33,7 @@ from bb.ui.crumbs.hig import CrumbsDialog
 class ImageDetailsPage (HobPage):
 
     class DetailBox (gtk.EventBox):
-        def __init__(self, widget = None, varlist = None, vallist = None, icon = None, button = None, color = HobColors.LIGHT_GRAY):
+        def __init__(self, widget = None, varlist = None, vallist = None, icon = None, button = None, button2=None, color = HobColors.LIGHT_GRAY):
             gtk.EventBox.__init__(self)
 
             # set color
@@ -72,7 +72,11 @@ class ImageDetailsPage (HobPage):
                     self.table.attach(self.line_widgets[varlist[index]], colid, 20, row, row + 1)
             # pack the button on the right
             if button:
-                self.hbox.pack_end(button, expand=False, fill=False)
+                self.bbox = gtk.VBox()
+                self.bbox.pack_start(button, expand=True, fill=True)
+                if button2:
+                    self.bbox.pack_start(button2, expand=True, fill=True)
+                self.hbox.pack_end(self.bbox, expand=False, fill=False)
 
         def update_line_widgets(self, variable, value):
             if len(self.line_widgets) == 0:
@@ -164,8 +168,10 @@ class ImageDetailsPage (HobPage):
             base_image = self.builder.recipe_model.get_selected_image()
             layers = self.builder.configuration.layers
             pkg_num = "%s" % len(self.builder.package_model.get_selected_packages())
+            log_file = self.builder.current_logfile
         else:
             pkg_num = "N/A"
+            log_file = None
 
         # remove
         for button_id, button in self.button_ids.items():
@@ -243,11 +249,17 @@ class ImageDetailsPage (HobPage):
         view_files_button = HobAltButton("View files")
         view_files_button.connect("clicked", self.view_files_clicked_cb, image_addr)
         view_files_button.set_tooltip_text("Open the directory containing the image files")
-        self.image_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=view_files_button)
+        view_log_button = None
+        if log_file:
+            view_log_button = HobAltButton("View log")
+            view_log_button.connect("clicked", self.view_log_clicked_cb, log_file)
+            view_log_button.set_tooltip_text("Open the building log files")
+        self.image_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=view_files_button, button2=view_log_button)
         self.box_group_area.pack_start(self.image_detail, expand=False, fill=True)
 
         # The default kernel box for the qemu images
         self.sel_kernel = ""
+        self.kernel_detail = None
         if 'qemu' in image_name:
             self.sel_kernel = self.get_kernel_file_name()
 
@@ -315,12 +327,16 @@ class ImageDetailsPage (HobPage):
             self.box_group_area.pack_start(self.details_bottom_buttons, expand=False, fill=False)
 
         self.show_all()
-        if not is_runnable:
+        if self.kernel_detail and (not is_runnable):
             self.kernel_detail.hide()
 
     def view_files_clicked_cb(self, button, image_addr):
         subprocess.call("xdg-open /%s" % image_addr, shell=True)
 
+    def view_log_clicked_cb(self, button, log_file):
+        if log_file:
+            os.system("xdg-open /%s" % log_file)
+
     def refresh_package_detail_box(self, image_size):
         self.package_detail.update_line_widgets("Total image size: ", image_size)
 
diff --git a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
index 1b832eb..d101535 100755
--- a/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
+++ b/bitbake/lib/bb/ui/crumbs/packageselectionpage.py
@@ -143,8 +143,8 @@ class PackageSelectionPage (HobPage):
         # add all into the dialog
         self.box_group_area.pack_start(self.ins, expand=True, fill=True)
 
-        button_box = gtk.HBox(False, 6)
-        self.box_group_area.pack_start(button_box, expand=False, fill=False)
+        self.button_box = gtk.HBox(False, 6)
+        self.box_group_area.pack_start(self.button_box, expand=False, fill=False)
 
         self.build_image_button = HobButton('Build image')
         self.build_image_button.set_size_request(205, 49)
@@ -152,11 +152,11 @@ class PackageSelectionPage (HobPage):
         self.build_image_button.set_flags(gtk.CAN_DEFAULT)
         self.build_image_button.grab_default()
         self.build_image_button.connect("clicked", self.build_image_clicked_cb)
-        button_box.pack_end(self.build_image_button, expand=False, fill=False)
+        self.button_box.pack_end(self.build_image_button, expand=False, fill=False)
 
         self.back_button = HobAltButton("<< Back to image configuration")
         self.back_button.connect("clicked", self.back_button_clicked_cb)
-        button_box.pack_start(self.back_button, expand=False, fill=False)
+        self.button_box.pack_start(self.back_button, expand=False, fill=False)
 
     def button_click_cb(self, widget, event):
         path, col = widget.table_tree.get_cursor()
@@ -166,6 +166,25 @@ class PackageSelectionPage (HobPage):
             if binb:
                 self.builder.show_binb_dialog(binb)
 
+    def view_log_clicked_cb(self, button, log_file):
+        if log_file:
+            os.system("xdg-open /%s" % log_file)
+
+    def show_page(self, log_file):
+        children = self.button_box.get_children() or []
+        for child in children:
+            self.button_box.remove(child)
+        # re-packed the buttons as request, add the 'view log' button if build success
+        self.button_box.pack_start(self.back_button, expand=False, fill=False)
+        self.button_box.pack_end(self.build_image_button, expand=False, fill=False)
+        if log_file:
+            view_log_button = HobAltButton("View log")
+            view_log_button.connect("clicked", self.view_log_clicked_cb, log_file)
+            view_log_button.set_tooltip_text("Open the building log files")
+            self.button_box.pack_end(view_log_button, expand=False, fill=False)
+
+        self.show_all()
+
     def build_image_clicked_cb(self, button):
         self.builder.build_image()
 
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 8cf36ee..e814830 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -85,6 +85,9 @@ class RunningBuild (gobject.GObject):
           'no-provider'     :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                (gobject.TYPE_PYOBJECT,)),
+          'log'             :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                               (gobject.TYPE_STRING, gobject.TYPE_PYOBJECT,)),
           }
     pids_to_task = {}
     tasks_to_iter = {}
@@ -122,6 +125,8 @@ class RunningBuild (gobject.GObject):
             parent = self.tasks_to_iter[(package, task)]
 
         if(isinstance(event, logging.LogRecord)):
+            if event.taskpid == 0 or event.levelno > logging.INFO:
+                self.emit("log", "handle", event)
             # FIXME: this is a hack! More info in Yocto #1433
             # http://bugzilla.pokylinux.org/show_bug.cgi?id=1433, temporarily
             # mask the error message as it's not informative for the user.
@@ -207,6 +212,7 @@ class RunningBuild (gobject.GObject):
             self.tasks_to_iter[(package, task)] = i
 
         elif isinstance(event, bb.build.TaskBase):
+            self.emit("log", "info", event._message)
             current = self.tasks_to_iter[(package, task)]
             parent = self.tasks_to_iter[(package, None)]
 
@@ -287,6 +293,7 @@ class RunningBuild (gobject.GObject):
                 pbar.set_text(event.msg)
 
         elif isinstance(event, bb.command.CommandFailed):
+            self.emit("log", "error", "Command execution failed: %s" % (event.error))
             if event.error.startswith("Exited with"):
                 # If the command fails with an exit code we're done, emit the
                 # generic signal for the UI to notify the user
@@ -314,7 +321,24 @@ class RunningBuild (gobject.GObject):
         elif isinstance(event, bb.event.ParseCompleted) and pbar:
             pbar.hide()
         #using runqueue events as many as possible to update the progress bar
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
@@ -323,6 +347,10 @@ class RunningBuild (gobject.GObject):
             message["title"] = ""
             message["task"] = event.taskstring
             self.emit("task-started", message)
+        elif isinstance(event, bb.event.MultipleProviders):
+            self.emit("log", "info", "multiple providers are available for %s%s (%s)" \
+                                     % (event._is_runtime and "runtime " or "", event._item, ", ".join(event._candidates)))
+            self.emit("log", "info", "consider defining a PREFERRED_PROVIDER entry to match %s" % (event._item))
         elif isinstance(event, bb.event.NoProvider):
             msg = ""
             if event._runtime:
@@ -337,6 +365,19 @@ class RunningBuild (gobject.GObject):
                 for reason in event._reasons:
                     msg += ("%s\n" % reason)
             self.emit("no-provider", msg)
+            self.emit("log", msg)
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
+                self.emit("log", "error", "Unknown event: %s" % (event.error if hasattr(event, 'error') else 'error'))
 
         return
 
-- 
1.7.5.4



