Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SuKiV-0004Le-FK
	for bitbake-devel@lists.openembedded.org;
	Thu, 26 Jul 2012 11:50:47 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6Q9dF0Y026050
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 26 Jul 2012 02:39:15 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Thu, 26 Jul 2012 02:39:15 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <richard.purdie@linuxfoundation.org>
Date: Thu, 26 Jul 2012 17:39:08 +0800
Message-ID: <31bb014339e82f1c17129fd1e7ab3b8448fc2a3d.1343295453.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1343295453.git.kai.kang@windriver.com>
References: <cover.1343295453.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: [PATCH 3/3] hob: deal event DiskFull
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
X-List-Received-Date: Thu, 26 Jul 2012 09:50:47 -0000
Content-Type: text/plain

When bitbake runqueue is teminated by disk monitor, it will send event
DiskFull. Update to handle it.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py      |    4 ++++
 bitbake/lib/bb/ui/crumbs/runningbuild.py |   11 +++++++++++
 2 files changed, 15 insertions(+), 0 deletions(-)

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
index 8cf36ee..7bb4982 100644
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
@@ -286,6 +289,14 @@ class RunningBuild (gobject.GObject):
             if pbar:
                 pbar.set_text(event.msg)
 
+        elif isinstance(event, bb.event.DiskFull):
+            self.emit("build-aborted")
+            self.emit("build-complete")
+            self.model.close_task_refresh()
+            print(pbar)
+            if pbar:
+                pbar.set_text(event.msg)
+
         elif isinstance(event, bb.command.CommandFailed):
             if event.error.startswith("Exited with"):
                 # If the command fails with an exit code we're done, emit the
-- 
1.7.5.4



