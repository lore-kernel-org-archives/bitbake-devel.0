Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SCAlJ-0008Iz-SK
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 16:19:10 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 26 Mar 2012 07:10:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="125200446"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by orsmga002.jf.intel.com with ESMTP; 26 Mar 2012 07:10:08 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 22:33:06 +0800
Message-Id: <f906c534c2b3a4dd4f3cc88cff189a17cb132a2e.1332772309.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <eee2635181e81fe8774fb5e1f2122e83d972b3b9.1332772309.git.shane.wang@intel.com>
References: <eee2635181e81fe8774fb5e1f2122e83d972b3b9.1332772309.git.shane.wang@intel.com>
In-Reply-To: <cover.1332772309.git.shane.wang@intel.com>
References: <cover.1332772309.git.shane.wang@intel.com>
Subject: [PATCH 2/2] Hob: show (package, task) pair which is being executed on the build details screen
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
X-List-Received-Date: Mon, 26 Mar 2012 14:19:10 -0000

This patch is still for bug 2098 to provide clear information about the task and the package in progress.

[Yocto #2098]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   23 ++++++++++++++++-------
 bitbake/lib/bb/ui/crumbs/builder.py          |   12 +++++++++---
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |    7 +++++++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index c2f980f..1031906 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -47,9 +47,12 @@ class BuildDetailsPage (HobPage):
         self.vbox = gtk.VBox(False, 12)
 
         self.progress_box = gtk.VBox(False, 12)
-        self.task_status = gtk.Label()
-        self.task_status.set_alignment(0.0, 0.5)
-        self.progress_box.pack_start(self.task_status, expand=False, fill=False)
+        self.rq_status = gtk.Label()
+        self.rq_status.set_alignment(0.0, 0.5)
+        self.pt_status = gtk.Label()
+        self.pt_status.set_alignment(0.0, 0.5)
+        self.progress_box.pack_start(self.rq_status, expand=False, fill=False)
+        self.progress_box.pack_start(self.pt_status, expand=False, fill=False)
         self.progress_hbox = gtk.HBox(False, 6)
         self.progress_box.pack_end(self.progress_hbox, expand=True, fill=True)
         self.progress_bar = HobProgressBar()
@@ -89,11 +92,17 @@ class BuildDetailsPage (HobPage):
         self.back_button.connect("clicked", self.back_button_clicked_cb)
         self.button_box.pack_start(self.back_button, expand=False, fill=False)
 
-    def update_build_status(self, tsk_msg):
-        self.task_status.set_markup(tsk_msg)
+    def update_runqueue_status(self, msg):
+        self.rq_status.set_markup(msg)
 
-    def reset_build_status(self):
-        self.task_status.set_markup("")
+    def update_package_task_status(self, msg):
+        self.pt_status.set_markup(msg)
+
+    def reset_runqueue_status(self):
+        self.rq_status.set_markup("")
+
+    def reset_package_task_status(self):
+        self.pt_status.set_markup("")
 
     def show_issues(self):
         self.num_of_issues += 1
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index f32a066..245a747 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -218,6 +218,7 @@ class Builder(gtk.Window):
         self.handler.build.connect("build-succeeded",    self.handler_build_succeeded_cb)
         self.handler.build.connect("build-failed",       self.handler_build_failed_cb)
         self.handler.build.connect("task-started",       self.handler_task_started_cb)
+        self.handler.build.connect("task-executing",     self.handler_task_executing_cb)
         self.handler.build.connect("log-error",          self.handler_build_failure_cb)
         self.handler.connect("generating-data",          self.handler_generating_data_cb)
         self.handler.connect("data-generated",           self.handler_data_generated_cb)
@@ -543,7 +544,8 @@ class Builder(gtk.Window):
         elif self.current_step == self.PACKAGE_GENERATING:
             fraction = 0
         self.build_details_page.update_progress_bar("Build Started: ", fraction)
-        self.build_details_page.reset_build_status()
+        self.build_details_page.reset_runqueue_status()
+        self.build_details_page.reset_package_task_status()
         self.build_details_page.reset_issues()
 
     def build_succeeded(self):
@@ -611,8 +613,12 @@ class Builder(gtk.Window):
             elif message["eventname"] == "runQueueTaskStarted":
                 fraction = 0.2 + 0.8 * fraction
         self.build_details_page.update_progress_bar(title + ": ", fraction)
-        self.build_details_page.update_build_status(
-            "<span weight=\'bold\'>Running task %s of %s:</span> %s" % (message["current"], message["total"], message["task"]))
+        self.build_details_page.update_runqueue_status(
+            "<span weight=\'bold\'>Starting task %s of %s:</span> %s" % (message["current"], message["total"], message["task"]))
+
+    def handler_task_executing_cb(self, running_build, message):
+        self.build_details_page.update_package_task_status(
+            "<span weight=\'bold\'>Running task</span> %s <span weight=\'bold\'>on package</span> %s" % (message["task"], message["package"]))
 
     def handler_build_failure_cb(self, running_build):
         self.build_details_page.show_issues()
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 0f58e4e..e9d8070 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -85,6 +85,9 @@ class RunningBuild (gobject.GObject):
           'task-started'    :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                (gobject.TYPE_PYOBJECT,)),
+          'task-executing'  :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                               (gobject.TYPE_PYOBJECT,)),
           'log-error'       :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                ()),
@@ -208,6 +211,10 @@ class RunningBuild (gobject.GObject):
             # Save out the iter so that we can find it when we have a message
             # that we need to attach to a task.
             self.tasks_to_iter[(package, task)] = i
+            message = {}
+            message["task"] = task
+            message["package"] = package
+            self.emit("task-executing", message)
 
         elif isinstance(event, bb.build.TaskBase):
             current = self.tasks_to_iter[(package, task)]
-- 
1.7.6



