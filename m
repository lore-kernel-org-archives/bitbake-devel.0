Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id D188860249
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 02:53:08 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga103.jf.intel.com with ESMTP; 12 Jun 2016 19:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,464,1459839600"; d="scan'208";a="120682980"
Received: from ctan5-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.176.32])
	by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2016 19:53:07 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Jun 2016 14:52:22 +1200
Message-Id: <86e4782bde9cd0e1baf1e68cdae9fa09bc33537f.1465786269.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1465786269.git.paul.eggleton@linux.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1465786269.git.paul.eggleton@linux.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 06/10] knotty: add code to support showing progress for sstate object querying
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
X-List-Received-Date: Mon, 13 Jun 2016 02:53:08 -0000

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
index 6fb3712..3485d73 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -640,6 +640,33 @@ class MetadataEvent(Event):
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


