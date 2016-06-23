Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 9F06073281
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jun 2016 11:00:01 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 23 Jun 2016 04:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,516,1459839600"; d="scan'208";a="723878808"
Received: from clim19-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.149.148])
	by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2016 04:00:00 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jun 2016 22:59:08 +1200
Message-Id: <894654b08f7306627a4f2054787afd2a201a9a03.1466679280.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 06/10] knotty: add code to support showing progress for sstate object querying
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 23 Jun 2016 11:00:01 -0000

Add support code on the BitBake side to allow sstate.bbclass in
OpenEmbedded to report progress when it is checking for availability of
artifacts from shared state mirrors.

Part of the implementation for [YOCTO #5853].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/event.py     | 27 +++++++++++++++++++++++++++
 lib/bb/ui/knotty.py | 15 +++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 9b4a4f9..a5f026e 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -647,6 +647,33 @@ class MetadataEvent(Event):
         self.type = eventtype
         self._localdata = eventdata
 
+class ProcessStarted(Event):
+    """
+    Generic process started event (usually part of the initial startup)
+    where further progress events will be delivered
+    """
+    def __init__(self, processname, total):
+        Event.__init__(self)
+        self.processname = processname
+        self.total = total
+
+class ProcessProgress(Event):
+    """
+    Generic process progress event (usually part of the initial startup)
+    """
+    def __init__(self, processname, progress):
+        Event.__init__(self)
+        self.processname = processname
+        self.progress = progress
+
+class ProcessFinished(Event):
+    """
+    Generic process finished event (usually part of the initial startup)
+    """
+    def __init__(self, processname):
+        Event.__init__(self)
+        self.processname = processname
+
 class SanityCheck(Event):
     """
     Event to run sanity checks, either raise errors or generate events as return status.
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 2513501..6fdaafe 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -90,7 +90,7 @@ class NonInteractiveProgress(object):
         self.msg = msg
         self.maxval = maxval
 
-    def start(self):
+    def start(self, update=True):
         self.fobj.write("%s..." % self.msg)
         self.fobj.flush()
         return self
@@ -304,7 +304,7 @@ _evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.Lo
               "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.runqueue.sceneQueueTaskStarted",
               "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTaskFailed", "bb.runqueue.sceneQueueTaskFailed",
               "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent",
-              "bb.build.TaskProgress"]
+              "bb.build.TaskProgress", "bb.event.ProcessStarted", "bb.event.ProcessProgress", "bb.event.ProcessFinished"]
 
 def main(server, eventHandler, params, tf = TerminalFilter):
 
@@ -579,6 +579,17 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.event.DepTreeGenerated):
                 continue
 
+            if isinstance(event, bb.event.ProcessStarted):
+                parseprogress = new_progress(event.processname, event.total)
+                parseprogress.start(False)
+                continue
+            if isinstance(event, bb.event.ProcessProgress):
+                parseprogress.update(event.progress)
+                continue
+            if isinstance(event, bb.event.ProcessFinished):
+                parseprogress.finish()
+                continue
+
             # ignore
             if isinstance(event, (bb.event.BuildBase,
                                   bb.event.MetadataEvent,
-- 
2.5.5


