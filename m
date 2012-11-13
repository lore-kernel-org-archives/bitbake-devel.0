Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TYHyR-0003Ss-NL
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Nov 2012 16:00:23 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 13 Nov 2012 06:46:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,767,1344236400"; d="scan'208";a="217118437"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by azsmga001.ch.intel.com with ESMTP; 13 Nov 2012 06:46:27 -0800
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Nov 2012 16:48:46 +0200
Message-Id: <1352818126-11334-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: warnings during the build should be displayed in the Issues tab
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
X-List-Received-Date: Tue, 13 Nov 2012 15:00:24 -0000

Any issues encountered during the build (fatal or not) is displayed
in the Issues tab, and the total number of issues is changed.

[YOCTO #3376]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py      |    1 +
 bitbake/lib/bb/ui/crumbs/runningbuild.py |    8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index ecf5371..25741fe 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -457,6 +457,7 @@ class Builder(gtk.Window):
         self.handler.build.connect("build-aborted",      self.handler_build_aborted_cb)
         self.handler.build.connect("task-started",       self.handler_task_started_cb)
         self.handler.build.connect("log-error",          self.handler_build_failure_cb)
+        self.handler.build.connect("log-warning",        self.handler_build_failure_cb)
         self.handler.build.connect("log",                self.handler_build_log_cb)
         self.handler.build.connect("no-provider",        self.handler_no_provider_cb)
         self.handler.connect("generating-data",          self.handler_generating_data_cb)
diff --git a/bitbake/lib/bb/ui/crumbs/runningbuild.py b/bitbake/lib/bb/ui/crumbs/runningbuild.py
index b4d19b6..f6848fd 100644
--- a/bitbake/lib/bb/ui/crumbs/runningbuild.py
+++ b/bitbake/lib/bb/ui/crumbs/runningbuild.py
@@ -46,7 +46,7 @@ class RunningBuildModel (gtk.TreeStore):
         color = model.get(it, self.COL_COLOR)[0]
         if not color:
             return False
-        if color == HobColors.ERROR:
+        if color == HobColors.ERROR or color == HobColors.WARNING:
             return True
         return False
 
@@ -76,7 +76,7 @@ class RunningBuild (gobject.GObject):
           'build-complete'  :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                ()),
-          'build-aborted'     :  (gobject.SIGNAL_RUN_LAST,
+          'build-aborted'   :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                ()),
           'task-started'    :  (gobject.SIGNAL_RUN_LAST,
@@ -85,6 +85,9 @@ class RunningBuild (gobject.GObject):
           'log-error'       :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                ()),
+          'log-warning'     :  (gobject.SIGNAL_RUN_LAST,
+                                gobject.TYPE_NONE,
+                               ()),
           'no-provider'     :  (gobject.SIGNAL_RUN_LAST,
                                 gobject.TYPE_NONE,
                                (gobject.TYPE_PYOBJECT,)),
@@ -148,6 +151,7 @@ class RunningBuild (gobject.GObject):
             elif event.levelno >= logging.WARNING:
                 icon = "dialog-warning"
                 color = HobColors.WARNING
+                self.emit("log-warning")
             else:
                 icon = None
                 color = HobColors.OK
-- 
1.7.9.5



