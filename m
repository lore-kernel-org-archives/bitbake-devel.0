Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SugEx-0007rZ-KB
	for bitbake-devel@lists.openembedded.org;
	Fri, 27 Jul 2012 10:49:43 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6R8cAKJ000590
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 27 Jul 2012 01:38:10 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Fri, 27 Jul 2012 01:38:10 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Fri, 27 Jul 2012 16:38:03 +0800
Message-ID: <a962a88e17da8eaf8fc0bb98d83ba7db506526ee.1343378110.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1343378110.git.kai.kang@windriver.com>
References: <cover.1343378110.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 2/2] hob: deal event DiskFull
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
X-List-Received-Date: Fri, 27 Jul 2012 08:49:44 -0000
Content-Type: text/plain

Part of [Yocto #2168]

When bitbake runqueue is teminated by disk monitor, it will send event
DiskFull. Update to handle it.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py      |    4 ++++
 bitbake/lib/bb/ui/crumbs/runningbuild.py |   11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 123608e..c2e7068 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -430,6 +430,7 @@ class Builder(gtk.Window):
         self.handler.build.connect("build-started",      self.handler_build_started_cb)
         self.handler.build.connect("build-succeeded",    self.handler_build_succeeded_cb)
         self.handler.build.connect("build-failed",       self.handler_build_failed_cb)
+        self.handler.build.connect("build-aborted",      self.handler_build_aborted_cb)
         self.handler.build.connect("task-started",       self.handler_task_started_cb)
         self.handler.build.connect("log-error",          self.handler_build_failure_cb)
         self.handler.build.connect("no-provider",        self.handler_no_provider_cb)
@@ -920,6 +921,9 @@ class Builder(gtk.Window):
     def handler_build_failed_cb(self, running_build):
         self.build_failed()
 
+    def handler_build_aborted_cb(self, running_build):
+        self.build_failed()
+
     def handler_no_provider_cb(self, running_build, msg):
         dialog = CrumbsMessageDialog(self, Builder.interpret_markup(msg), gtk.STOCK_DIALOG_INFO)
         button = dialog.add_button("Close", gtk.RESPONSE_OK)
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index 8cf36ee..0347058 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -76,6 +76,9 @@ class RunningBuild (gobject.GObject):
           'build-complete'  :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                ()),
+          'build-aborted'     :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                               ()),
           'task-started'    :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                (gobject.TYPE_PYOBJECT,)),
@@ -93,6 +96,7 @@ class RunningBuild (gobject.GObject):
         gobject.GObject.__init__ (self)
         self.model = RunningBuildModel()
         self.sequential = sequential
+        self.buildaborted = False
 
     def reset (self):
         self.pids_to_task.clear()
@@ -274,7 +278,9 @@ class RunningBuild (gobject.GObject):
                                       0))
 
             # Emit the appropriate signal depending on the number of failures
-            if (failures >= 1):
+            if self.buildaborted:
+                self.emit ("build-aborted")
+            elif (failures >= 1):
                 self.emit ("build-failed")
             else:
                 self.emit ("build-succeeded")
@@ -286,6 +292,9 @@ class RunningBuild (gobject.GObject):
             if pbar:
                 pbar.set_text(event.msg)
 
+        elif isinstance(event, bb.event.DiskFull):
+            self.buildaborted = True
+
         elif isinstance(event, bb.command.CommandFailed):
             if event.error.startswith("Exited with"):
                 # If the command fails with an exit code we're done, emit the
-- 
1.7.5.4



