Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJK31-0002Ne-Db
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Apr 2012 09:39:01 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 15 Apr 2012 00:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="132648481"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 15 Apr 2012 00:29:32 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Apr 2012 15:26:37 +0800
Message-Id: <6ac9502d38a6aff87c6d256ceaa2366d7eada6cc.1334474635.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1334474635.git.dongxiao.xu@intel.com>
References: <cover.1334474635.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1334474635.git.dongxiao.xu@intel.com>
References: <cover.1334474635.git.dongxiao.xu@intel.com>
Subject: [PATCH 1/2] Hob: Handle NoProvider event in runningbuild module
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
X-List-Received-Date: Sun, 15 Apr 2012 07:39:01 -0000

If NoProvider event is received, we will handle it in runningbuild
module and send notification to Hob instance, avoiding stepping into the
final page with no image built out.

This fixes [YOCTO #2249]

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py         |   18 ++++++++++++++----
 lib/bb/ui/crumbs/hobeventhandler.py |   21 ---------------------
 lib/bb/ui/crumbs/runningbuild.py    |   17 +++++++++++++++++
 3 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index 48053b3..dd59d59 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -349,6 +349,7 @@ class Builder(gtk.Window):
         self.handler.build.connect("build-failed",       self.handler_build_failed_cb)
         self.handler.build.connect("task-started",       self.handler_task_started_cb)
         self.handler.build.connect("log-error",          self.handler_build_failure_cb)
+        self.handler.build.connect("no-provider",        self.handler_no_provider_cb)
         self.handler.connect("generating-data",          self.handler_generating_data_cb)
         self.handler.connect("data-generated",           self.handler_data_generated_cb)
         self.handler.connect("command-succeeded",        self.handler_command_succeeded_cb)
@@ -624,10 +625,6 @@ class Builder(gtk.Window):
             self.rcppkglist_populated()
             if self.current_step == self.FAST_IMAGE_GENERATING:
                 self.generate_image_async()
-            elif self.current_step == self.PACKAGE_GENERATING:
-                self.switch_page(self.PACKAGE_GENERATED)
-            elif self.current_step == self.IMAGE_GENERATING:
-                self.switch_page(self.IMAGE_GENERATED)
 
     def handler_command_failed_cb(self, handler, msg):
         if msg:
@@ -755,6 +752,11 @@ class Builder(gtk.Window):
         self.handler.build_succeeded_async()
         self.stopping = False
 
+        if self.current_step == self.PACKAGE_GENERATING:
+            self.switch_page(self.PACKAGE_GENERATED)
+        elif self.current_step == self.IMAGE_GENERATING:
+            self.switch_page(self.IMAGE_GENERATED)
+
     def build_failed(self):
         if self.stopping:
             status = "stop"
@@ -785,6 +787,14 @@ class Builder(gtk.Window):
     def handler_build_failed_cb(self, running_build):
         self.build_failed()
 
+    def handler_no_provider_cb(self, running_build, msg):
+        dialog = CrumbsMessageDialog(self, msg, gtk.STOCK_DIALOG_INFO)
+        button = dialog.add_button("Close", gtk.RESPONSE_OK)
+        HobButton.style_button(button)
+        dialog.run()
+        dialog.destroy()
+        self.build_failed()
+
     def handler_task_started_cb(self, running_build, message): 
         fraction = message["current"] * 1.0/message["total"]
         title = "Build packages"
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 7a3cc6b..a61cca0 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -180,27 +180,6 @@ class HobHandler(gobject.GObject):
         elif isinstance(event, bb.command.CommandCompleted):
             self.current_phase = None
             self.run_next_command()
-        # TODO: Currently there are NoProvider issues when generate
-        # universe tree dependency for non-x86 architecture.
-        # Comment the follow code to enable the build of non-x86
-        # architectures in Hob.
-        #elif isinstance(event, bb.event.NoProvider):
-        #    if event._runtime:
-        #        r = "R"
-        #    else:
-        #        r = ""
-        #    if event._dependees:
-        #        self.error_msg += " Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)" % (r, event._item, ", ".join(event._dependees), r)
-        #    else:
-        #        self.error_msg += " Nothing %sPROVIDES '%s'" % (r, event._item)
-        #    if event._reasons:
-        #        for reason in event._reasons:
-        #            self.error_msg += " %s" % reason
-
-        #    self.commands_async = []
-        #    self.emit("command-failed", self.error_msg)
-        #    self.error_msg = ""
-
         elif isinstance(event, bb.command.CommandFailed):
             self.commands_async = []
             self.clear_busy()
diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index 042902e..8cf36ee 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -82,6 +82,9 @@ class RunningBuild (gobject.GObject):
           'log-error'       :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                ()),
+          'no-provider'     :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                               (gobject.TYPE_PYOBJECT,)),
           }
     pids_to_task = {}
     tasks_to_iter = {}
@@ -320,6 +323,20 @@ class RunningBuild (gobject.GObject):
             message["title"] = ""
             message["task"] = event.taskstring
             self.emit("task-started", message)
+        elif isinstance(event, bb.event.NoProvider):
+            msg = ""
+            if event._runtime:
+                r = "R"
+            else:
+                r = ""
+            if event._dependees:
+                msg = "Nothing %sPROVIDES '%s' (but %s %sDEPENDS on or otherwise requires it)\n" % (r, event._item, ", ".join(event._dependees), r)
+            else:
+                msg = "Nothing %sPROVIDES '%s'\n" % (r, event._item)
+            if event._reasons:
+                for reason in event._reasons:
+                    msg += ("%s\n" % reason)
+            self.emit("no-provider", msg)
 
         return
 
-- 
1.7.4.1



