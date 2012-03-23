Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SB6jJ-0006lA-3y
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 16:48:41 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 23 Mar 2012 08:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="132441733"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2012 08:39:43 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 24 Mar 2012 00:05:13 +0800
Message-Id: <443751d93b8974e89404d4b0eed045f8c9884cc9.1332518429.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1332518429.git.shane.wang@intel.com>
References: <cover.1332518429.git.shane.wang@intel.com>
Subject: [PATCH 1/1] Hob: add build status labels in the build details screen to make it more close to the visual design
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
X-List-Received-Date: Fri, 23 Mar 2012 15:48:41 -0000

This patch is to add build status (incl. "Running task XX of XX: XXXXXX") in the build details screen,
in order to provide clear information about task in progress and make the GUI close to the visual design.

[Yocto #2098]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   17 +++++++++++--
 bitbake/lib/bb/ui/crumbs/builder.py          |    3 ++
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |   33 +++++++++++++------------
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 3605ee1..e82ccf3 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -46,12 +46,17 @@ class BuildDetailsPage (HobPage):
         # create visual elements
         self.vbox = gtk.VBox(False, 12)
 
-        self.progress_box = gtk.HBox(False, 6)
+        self.progress_box = gtk.VBox(False, 12)
+        self.task_status = gtk.Label()
+        self.task_status.set_alignment(0.0, 0.5)
+        self.progress_box.pack_start(self.task_status, expand=False, fill=False)
+        self.progress_hbox = gtk.HBox(False, 6)
+        self.progress_box.pack_end(self.progress_hbox, expand=True, fill=True)
         self.progress_bar = HobProgressBar()
-        self.progress_box.pack_start(self.progress_bar, expand=True, fill=True)
+        self.progress_hbox.pack_start(self.progress_bar, expand=True, fill=True)
         self.stop_button = HobAltButton("Stop")
         self.stop_button.connect("clicked", self.stop_button_clicked_cb)
-        self.progress_box.pack_end(self.stop_button, expand=False, fill=False)
+        self.progress_hbox.pack_end(self.stop_button, expand=False, fill=False)
 
         self.notebook = HobNotebook()
         self.config_tv = BuildConfigurationTreeView()
@@ -82,6 +87,12 @@ class BuildDetailsPage (HobPage):
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         self.button_box.pack_start(self.back_button, expand=False, fill=False)
 
+    def update_build_status(self, tsk_msg):
+        self.task_status.set_markup(tsk_msg)
+
+    def reset_build_status(self):
+        self.task_status.set_markup("")
+
     def show_issues(self):
         self.num_of_issues += 1
         self.notebook.show_indicator_icon("Issues", self.num_of_issues)
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 5a292e7..8fb9fa0 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -533,6 +533,7 @@ class Builder(gtk.Window):
         elif self.current_step == self.PACKAGE_GENERATING:
             fraction = 0
         self.build_details_page.update_progress_bar("Build Started: ", fraction)
+        self.build_details_page.reset_build_status()
         self.build_details_page.reset_issues()
 
     def build_succeeded(self):
@@ -600,6 +601,8 @@ class Builder(gtk.Window):
             elif message["eventname"] == "runQueueTaskStarted":
                 fraction = 0.2 + 0.8 * fraction
         self.build_details_page.update_progress_bar(title + ": ", fraction)
+        self.build_details_page.update_build_status(
+            "<span weight=\'bold\'>Running task %s of %s:</span> %s" % (message["current"], message["total"], message["task"]))
 
     def handler_build_failure_cb(self, running_build):
         self.build_details_page.show_issues()
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 4c3fe2c..f38e9d4 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -69,24 +69,24 @@ class RunningBuildModel (gtk.TreeStore):
 
 class RunningBuild (gobject.GObject):
     __gsignals__ = {
-          'build-started' : (gobject.SIGNAL_RUN_LAST,
-                               gobject.TYPE_NONE,
+          'build-started'   :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
                                ()),
-          'build-succeeded' : (gobject.SIGNAL_RUN_LAST,
-                               gobject.TYPE_NONE,
+          'build-succeeded' :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                               ()),
+          'build-failed'    :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                               ()),
+          'build-complete'  :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                               ()),
+          'task-started'    :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                               (gobject.TYPE_PYOBJECT,)),
+          'log-error'       :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
                                ()),
-          'build-failed' : (gobject.SIGNAL_RUN_LAST,
-                            gobject.TYPE_NONE,
-                            ()),
-          'build-complete' : (gobject.SIGNAL_RUN_LAST,
-                              gobject.TYPE_NONE,
-                              ()),
-          'task-started'   : (gobject.SIGNAL_RUN_LAST,
-                              gobject.TYPE_NONE,
-                              (gobject.TYPE_PYOBJECT,)),
-          'log-error'      : (gobject.SIGNAL_RUN_LAST,
-                              gobject.TYPE_NONE,
-                              ()),
           }
     pids_to_task = {}
     tasks_to_iter = {}
@@ -319,6 +319,7 @@ class RunningBuild (gobject.GObject):
             message["current"] = num_of_completed
             message["total"] = event.stats.total
             message["title"] = ""
+            message["task"] = event.taskstring
             self.emit("task-started", message)
 
         return
-- 
1.7.6



