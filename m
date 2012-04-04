Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jessica.zhang@intel.com>) id 1SFSmW-0002c1-BE
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 18:10:00 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 04 Apr 2012 08:59:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="127041494"
Received: from orsmsx605.amr.corp.intel.com ([10.22.226.10])
	by azsmga001.ch.intel.com with ESMTP; 04 Apr 2012 08:59:38 -0700
Received: from orsmsx103.amr.corp.intel.com (10.22.225.130) by
	orsmsx605.amr.corp.intel.com (10.22.226.10) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 4 Apr 2012 08:59:38 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.154]) by
	ORSMSX103.amr.corp.intel.com ([169.254.2.10]) with mapi id
	14.01.0355.002; Wed, 4 Apr 2012 08:59:37 -0700
From: "Zhang, Jessica" <jessica.zhang@intel.com>
To: "Barros Pena, Belen" <belen.barros.pena@intel.com>, "Wang, Shane"
	<shane.wang@intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/4] Hob: log for Hob and allow users
	to show logs after successful build
Thread-Index: AQHNEXurPYSHh08qBEWiTfWjA30Zn5aK1Iuw
Date: Wed, 4 Apr 2012 15:59:37 +0000
Message-ID: <C6510F6D410BB64A8C15398EDC6B847C451B6B7C@ORSMSX101.amr.corp.intel.com>
References: <1b154fde4b6b403c8cea5b473baa029f9f264281.1333379931.git.shane.wang@intel.com>
	<CBA07EE5.C28E%belen.barros.pena@intel.com>
In-Reply-To: <CBA07EE5.C28E%belen.barros.pena@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
Cc: Giulia Piu <giulia@closertag.com>
Subject: Re: [PATCH 2/4] Hob: log for Hob and allow users to show logs after successful build
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
X-List-Received-Date: Wed, 04 Apr 2012 16:10:01 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Belen,

I'd expect user to be able to retrieve all logs, image or package.

Thanks,
Jessica

-----Original Message-----
From: Barros Pena, Belen
Sent: Tuesday, April 03, 2012 2:25 AM
To: Wang, Shane; bitbake-devel@lists.openembedded.org
Cc: Zhang, Jessica; Giulia Piu
Subject: Re: [bitbake-devel] [PATCH 2/4] Hob: log for Hob and allow users t=
o show logs after successful build

Sorry: this was an omission on the design side. If deemed appropriate, we c=
an incorporate an option to retrieve the packages build log in the Packages=
 screen. I'll leave it to Jessica, who reported 1991, to decide if this is =
something we should provide.

Cheers

Belen


On 02/04/2012 16:22, "Shane Wang" <shane.wang@intel.com> wrote:

>If users build images in Hob, record logs and allow users to retrieve
>the logs after successful build.
>
>The logs are generated if and only if:
>  - users do "just bake"
>  - users do "build image" after "build packages"
>
>Only "build packages" will not write logs because there is no chance
>for users to retrieve on the GUI.
>
>[Yocto #1991]
>
>Signed-off-by: Shane Wang <shane.wang@intel.com>
>---
> bitbake/lib/bb/ui/crumbs/builder.py          |   36 +++++++++++++++--
> bitbake/lib/bb/ui/crumbs/hobeventhandler.py  |    3 +
> bitbake/lib/bb/ui/crumbs/imagedetailspage.py |   14 ++++++-
> bitbake/lib/bb/ui/crumbs/runningbuild.py     |   53
>++++++++++++++++++++++++++
> 4 files changed, 101 insertions(+), 5 deletions(-)
>
>diff --git a/bitbake/lib/bb/ui/crumbs/builder.py
>b/bitbake/lib/bb/ui/crumbs/builder.py
>index 6587734..de4fb29 100755
>--- a/bitbake/lib/bb/ui/crumbs/builder.py
>+++ b/bitbake/lib/bb/ui/crumbs/builder.py
>@@ -26,6 +26,7 @@ import copy
> import os
> import subprocess
> import shlex
>+import logging
> from bb.ui.crumbs.template import TemplateMgr  from
>bb.ui.crumbs.imageconfigurationpage import ImageConfigurationPage  from
>bb.ui.crumbs.recipeselectionpage import RecipeSelectionPage @@ -260,6
>+261,11 @@ class Builder(gtk.Window):
>
>         self.template =3D None
>
>+        # logger
>+        self.logger =3D logging.getLogger("BitBake")
>+        self.consolelog =3D None
>+        self.current_logfile =3D None
>+
>         # build step
>         self.current_step =3D None
>         self.previous_step =3D None
>@@ -287,6 +293,7 @@ class Builder(gtk.Window):
>         self.handler.build.connect("build-failed",
>self.handler_build_failed_cb)
>         self.handler.build.connect("task-started",
>self.handler_task_started_cb)
>         self.handler.build.connect("log-error",
>self.handler_build_failure_cb)
>+        self.handler.build.connect("log",
>self.handler_build_log_cb)
>         self.handler.connect("generating-data",
>self.handler_generating_data_cb)
>         self.handler.connect("data-generated",
>self.handler_data_generated_cb)
>         self.handler.connect("command-succeeded",
>self.handler_command_succeeded_cb)
>@@ -396,7 +403,7 @@ class Builder(gtk.Window):
>         elif next_step =3D=3D self.PACKAGE_GENERATING or next_step =3D=3D
>self.FAST_IMAGE_GENERATING:
>             # both PACKAGE_GENEATING and FAST_IMAGE_GENERATING share
>the same page
>             self.build_details_page.show_page(next_step)
>-            self.generate_packages()
>+            self.generate_packages(next_step =3D=3D
>self.FAST_IMAGE_GENERATING)
>
>         elif next_step =3D=3D self.PACKAGE_GENERATED:
>             pass
>@@ -405,7 +412,7 @@ class Builder(gtk.Window):
>             # after packages are generated, selected_packages need to
>             # be updated in package_model per selected_image in
>recipe_model
>             self.build_details_page.show_page(next_step)
>-            self.generate_image()
>+            self.generate_image(self.current_step =3D=3D
>self.FAST_IMAGE_GENERATING)
>
>         elif next_step =3D=3D self.IMAGE_GENERATED:
>             self.image_details_page.show_page(next_step)
>@@ -454,7 +461,10 @@ class Builder(gtk.Window):
>         left =3D
>self.package_model.set_selected_packages(selected_packages)
>         self.configuration.selected_packages +=3D left
>
>-    def generate_packages(self):
>+    def generate_packages(self, log =3D False):
>+        if log:
>+            self.current_logfile =3D self.handler.get_logfile()
>+            self.do_log(self.current_logfile)
>         # Build packages
>         _, all_recipes =3D self.recipe_model.get_selected_recipes()
>         self.set_user_config()
>@@ -466,7 +476,10 @@ class Builder(gtk.Window):
>         self.set_user_config()
>         self.handler.generate_recipes()
>
>-    def generate_image(self):
>+    def generate_image(self, cont =3D False):
>+        if not cont:
>+            self.current_logfile =3D self.handler.get_logfile()
>+            self.do_log(self.current_logfile)
>         # Build image
>         self.set_user_config()
>         all_packages =3D self.package_model.get_selected_packages()
>@@ -708,6 +721,10 @@ class Builder(gtk.Window):
>     def handler_build_failure_cb(self, running_build):
>         self.build_details_page.show_issues()
>
>+    def handler_build_log_cb(self, running_build, func, obj):
>+        if hasattr(self.logger, func):
>+            getattr(self.logger, func)(obj)
>+
>     def destroy_window_cb(self, widget, event):
>         lbl =3D "<b>Do you really want to exit the Hob image creator?</b>=
"
>         dialog =3D CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
>@@ -1033,3 +1050,14 @@ class Builder(gtk.Window):
>             self.handler.cancel_build()
>         elif response =3D=3D gtk.RESPONSE_YES:
>             self.handler.cancel_build(True)
>+
>+    def do_log(self, consolelogfile =3D None):
>+        if consolelogfile:
>+            if self.consolelog:
>+                self.logger.removeHandler(self.consolelog)
>+                self.consolelog =3D None
>+            self.consolelog =3D logging.FileHandler(consolelogfile)
>+            bb.msg.addDefaultlogFilter(self.consolelog)
>+            format =3D bb.msg.BBLogFormatter("%(levelname)s: %(message)s"=
)
>+            self.consolelog.setFormatter(format)
>+            self.logger.addHandler(self.consolelog)
>diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
>b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
>index 61af131..de228d9 100644
>--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
>+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
>@@ -381,6 +381,9 @@ class HobHandler(gobject.GObject):
>     def reset_build(self):
>         self.build.reset()
>
>+    def get_logfile(self):
>+        return self.server.runCommand(["getVariable",
>+ "BB_CONSOLELOG"])
>+
>     def get_parameters(self):
>         # retrieve the parameters from bitbake
>         params =3D {}
>diff --git a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
>b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
>index a5d0ad8..39ccfdc 100755
>--- a/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
>+++ b/bitbake/lib/bb/ui/crumbs/imagedetailspage.py
>@@ -159,8 +159,10 @@ class ImageDetailsPage (HobPage):
>             machine =3D self.builder.configuration.curr_mach
>             base_image =3D self.builder.recipe_model.get_selected_image()
>             layers =3D self.builder.configuration.layers
>+            log_file =3D self.builder.current_logfile
>             pkg_num =3D "%s" %
>len(self.builder.package_model.get_selected_packages())
>         else:
>+            log_file =3D None
>             pkg_num =3D "N/A"
>
>         self._remove_all_widget()
>@@ -204,9 +206,15 @@ class ImageDetailsPage (HobPage):
>         image_table =3D HobViewTable(self.__columns__)
>         image_table.set_model(self.image_store)
>         image_table.connect("toggled", self.toggled_cb)
>+        view_buttons =3D gtk.VBox(False, 6)
>         view_files_button =3D HobAltButton("View files")
>         view_files_button.connect("clicked",
>self.view_files_clicked_cb,
>image_addr)
>-
>self.box_group_area.pack_start(self.DetailBox(widget=3Dimage_table,
>button=3Dview_files_button), expand=3DTrue, fill=3DTrue)
>+        view_buttons.pack_start(view_files_button, expand=3DTrue,
>fill=3DTrue)
>+        if log_file:
>+            view_logs_button =3D HobAltButton("View logs")
>+            view_logs_button.connect("clicked",
>self.view_logs_clicked_cb, log_file)
>+            view_buttons.pack_end(view_logs_button, expand=3DTrue,
>fill=3DTrue)
>+
>self.box_group_area.pack_start(self.DetailBox(widget=3Dimage_table,
>button=3Dview_buttons), expand=3DTrue, fill=3DTrue)
>
>         # Machine, Base image and Layers
>         layer_num_limit =3D 15
>@@ -258,6 +266,10 @@ class ImageDetailsPage (HobPage):
>     def view_files_clicked_cb(self, button, image_addr):
>         os.system("xdg-open /%s" % image_addr)
>
>+    def view_logs_clicked_cb(self, button, log_file):
>+        if log_file:
>+            os.system("xdg-open /%s" % log_file)
>+
>     def refresh_package_detail_box(self, image_size):
>         self.package_detail.update_line_widgets("Total image size: ",
>image_size)
>
>diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py
>b/bitbake/lib/bb/ui/crumbs/runningbuild.py
>index 042902e..b42f9c8 100644
>--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
>+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
>@@ -82,6 +82,9 @@ class RunningBuild (gobject.GObject):
>           'log-error'       :  (gobject.SIGNAL_RUN_LAST,
>                                 gobject.TYPE_NONE,
>                                ()),
>+          'log'             :  (gobject.SIGNAL_RUN_LAST,
>+                                gobject.TYPE_NONE,
>+                               (gobject.TYPE_STRING,
>gobject.TYPE_PYOBJECT,)),
>           }
>     pids_to_task =3D {}
>     tasks_to_iter =3D {}
>@@ -119,6 +122,8 @@ class RunningBuild (gobject.GObject):
>             parent =3D self.tasks_to_iter[(package, task)]
>
>         if(isinstance(event, logging.LogRecord)):
>+            if event.taskpid =3D=3D 0 or event.levelno > logging.INFO:
>+                self.emit("log", "handle", event)
>             # FIXME: this is a hack! More info in Yocto #1433
>             # http://bugzilla.pokylinux.org/show_bug.cgi?id=3D1433,
>temporarily
>             # mask the error message as it's not informative for the
>user.
>@@ -204,6 +209,7 @@ class RunningBuild (gobject.GObject):
>             self.tasks_to_iter[(package, task)] =3D i
>
>         elif isinstance(event, bb.build.TaskBase):
>+            self.emit("log", "info", event._message)
>             current =3D self.tasks_to_iter[(package, task)]
>             parent =3D self.tasks_to_iter[(package, None)]
>
>@@ -284,6 +290,7 @@ class RunningBuild (gobject.GObject):
>                 pbar.set_text(event.msg)
>
>         elif isinstance(event, bb.command.CommandFailed):
>+            self.emit("log", "error", "Command execution failed: %s" %
>(event.error))
>             if event.error.startswith("Exited with"):
>                 # If the command fails with an exit code we're done,
>emit the
>                 # generic signal for the UI to notify the user @@
>-311,7 +318,41 @@ class RunningBuild (gobject.GObject):
>         elif isinstance(event, bb.event.ParseCompleted) and pbar:
>             pbar.hide()
>         #using runqueue events as many as possible to update the
>progress bar
>+        elif isinstance(event, bb.event.MultipleProviders):
>+            self.emit("log", "info", "multiple providers are available
>for %s%s (%s)" \
>+                                     % (event._is_runtime and "runtime "
>or "", event._item, ", ".join(event._candidates)))
>+            self.emit("log", "info", "consider defining a
>PREFERRED_PROVIDER entry to match %s" % (event._item))
>+        elif isinstance(event, bb.event.NoProvider):
>+            if event._runtime:
>+                r =3D "R"
>+            else:
>+                r =3D ""
>+            if event._dependees:
>+                self.emit("log", "error", "Nothing %sPROVIDES '%s'
>+ (but
>%s %sDEPENDS on or otherwise requires it)" \
>+                                          % (r, event._item, ",
>".join(event._dependees), r))
>+            else:
>+                self.emit("log", "error", "Nothing %sPROVIDES '%s'" %
>(r, event._item))
>+            if event._reasons:
>+                for reason in event._reasons:
>+                    self.emit("log", "error", "%s" % (reason))
>+        elif isinstance(event, bb.runqueue.runQueueTaskFailed):
>+            self.emit("log", "error", "Task %s (%s) failed with exit
>code '%s'" % (event.taskid, event.taskstring, event.exitcode))
>+        elif isinstance(event, bb.runqueue.sceneQueueTaskFailed):
>+            self.emit("log", "warn", "Setscene task %s (%s) failed
>+ with
>exit code '%s' - real task will be run instead" \
>+                                     % (event.taskid,
>+ event.taskstring,
>event.exitcode))
>         elif isinstance(event, (bb.runqueue.runQueueTaskStarted,
>bb.runqueue.sceneQueueTaskStarted)):
>+            if isinstance(event, bb.runqueue.sceneQueueTaskStarted):
>+                self.emit("log", "info", "Running setscene task %d of
>+ %d
>(%s)" % \
>+                                         (event.stats.completed +
>event.stats.active + event.stats.failed + 1,
>+                                          event.stats.total,
>event.taskstring))
>+            else:
>+                if event.noexec:
>+                    tasktype =3D 'noexec task'
>+                else:
>+                    tasktype =3D 'task'
>+                self.emit("log", "info", "Running %s %s of %s (ID: %s,
>%s)" % \
>+                                         (tasktype,
>event.stats.completed + event.stats.active + event.stats.failed + 1,
>+                                          event.stats.total,
>event.taskid, event.taskstring))
>             message =3D {}
>             message["eventname"] =3D bb.event.getName(event)
>             num_of_completed =3D event.stats.completed +
>event.stats.failed @@ -320,6 +361,18 @@ class RunningBuild (gobject.GObjec=
t):
>             message["title"] =3D ""
>             message["task"] =3D event.taskstring
>             self.emit("task-started", message)
>+        else:
>+            if not isinstance(event, (bb.event.BuildBase,
>+                                      bb.event.StampUpdate,
>+                                      bb.event.ConfigParsed,
>+                                      bb.event.RecipeParsed,
>+                                      bb.event.RecipePreFinalise,
>+                                      bb.runqueue.runQueueEvent,
>+                                      bb.runqueue.runQueueExitWait,
>+                                      bb.event.OperationStarted,
>+                                      bb.event.OperationCompleted,
>+                                      bb.event.OperationProgress)):
>+                self.emit("log", "error", "Unknown event: %s" %
>+ (error))
>
>         return
>
>--
>1.7.6
>
>
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



