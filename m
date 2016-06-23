Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 6DCBF73219
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Jun 2016 10:59:56 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 23 Jun 2016 03:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,516,1459839600"; d="scan'208";a="723878791"
Received: from clim19-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.149.148])
	by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2016 03:59:55 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Jun 2016 22:59:06 +1200
Message-Id: <edb8ce8181a820456b47a5803b5004dcfe35d61e.1466679280.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1466679280.git.paul.eggleton@linux.intel.com>
References: <cover.1466679280.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 04/10] lib/bb/progress: add MultiStageProgressReporter
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
X-List-Received-Date: Thu, 23 Jun 2016 10:59:56 -0000

Add a class to help report progress in a task that consists of multiple
stages, some of which may have internal progress (do_rootfs within
OpenEmbedded is one example). Each stage is weighted to try to give
a reasonable representation of progress over time.

Part of the implementation for [YOCTO #5383].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/progress.py | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/lib/bb/progress.py b/lib/bb/progress.py
index bab8e94..93e42df 100644
--- a/lib/bb/progress.py
+++ b/lib/bb/progress.py
@@ -20,6 +20,7 @@ BitBake progress handling code
 import sys
 import re
 import time
+import inspect
 import bb.event
 import bb.build
 
@@ -84,3 +85,113 @@ class OutOfProgressHandler(ProgressHandler):
             progress = (float(nums[-1][0]) / float(nums[-1][1])) * 100
             self.update(progress)
         super(OutOfProgressHandler, self).write(string)
+
+class MultiStageProgressReporter(object):
+    """
+    Class which allows reporting progress without the caller
+    having to know where they are in the overall sequence. Useful
+    for tasks made up of python code spread across multiple
+    classes / functions - the progress reporter object can
+    be passed around or stored at the object level and calls
+    to next_stage() and update() made whereever needed.
+    """
+    def __init__(self, d, stage_weights, debug=False):
+        """
+        Initialise the progress reporter.
+
+        Parameters:
+        * d: the datastore (needed for firing the events)
+        * stage_weights: a list of weight values, one for each stage.
+          The value is scaled internally so you only need to specify
+          values relative to other values in the list, so if there
+          are two stages and the first takes 2s and the second takes
+          10s you would specify [2, 10] (or [1, 5], it doesn't matter).
+        * debug: specify True (and ensure you call finish() at the end)
+          in order to show a printout of the calculated stage weights
+          based on timing each stage. Use this to determine what the
+          weights should be when you're not sure.
+        """
+        self._data = d
+        total = sum(stage_weights)
+        self._stage_weights = [float(x)/total for x in stage_weights]
+        self._stage = -1
+        self._base_progress = 0
+        # Send an initial progress event so the bar gets shown
+        self._fire_progress(0)
+        self._debug = debug
+        self._finished = False
+        if self._debug:
+            self._last_time = time.time()
+            self._stage_times = []
+            self._stage_total = None
+            self._callers = []
+
+    def _fire_progress(self, taskprogress):
+        bb.event.fire(bb.build.TaskProgress(taskprogress), self._data)
+
+    def next_stage(self, stage_total=None):
+        """
+        Move to the next stage.
+        Parameters:
+        * stage_total: optional total for progress within the stage,
+          see update() for details
+        NOTE: you need to call this before the first stage.
+        """
+        self._stage += 1
+        self._stage_total = stage_total
+        if self._stage == 0:
+            # First stage
+            if self._debug:
+                self._last_time = time.time()
+        else:
+            if self._stage < len(self._stage_weights):
+                self._base_progress = sum(self._stage_weights[:self._stage]) * 100
+                if self._debug:
+                    currtime = time.time()
+                    self._stage_times.append(currtime - self._last_time)
+                    self._last_time = currtime
+                    self._callers.append(inspect.getouterframes(inspect.currentframe())[1])
+            elif not self._debug:
+                bb.warn('ProgressReporter: current stage beyond declared number of stages')
+                self._base_progress = 100
+            self._fire_progress(self._base_progress)
+
+    def update(self, stage_progress):
+        """
+        Update progress within the current stage.
+        Parameters:
+        * stage_progress: progress value within the stage. If stage_total
+          was specified when next_stage() was last called, then this
+          value is considered to be out of stage_total, otherwise it should
+          be a percentage value from 0 to 100.
+        """
+        if self._stage_total:
+            stage_progress = (float(stage_progress) / self._stage_total) * 100
+        if self._stage < 0:
+            bb.warn('ProgressReporter: update called before first call to next_stage()')
+        elif self._stage < len(self._stage_weights):
+            progress = self._base_progress + (stage_progress * self._stage_weights[self._stage])
+        else:
+            progress = self._base_progress
+        if progress > 100:
+            progress = 100
+        self._fire_progress(progress)
+
+    def finish(self):
+        if self._finished:
+            return
+        self._finished = True
+        if self._debug:
+            import math
+            self._stage_times.append(time.time() - self._last_time)
+            mintime = max(min(self._stage_times), 0.01)
+            self._callers.append(None)
+            stage_weights = [int(math.ceil(x / mintime)) for x in self._stage_times]
+            bb.warn('Stage weights: %s' % stage_weights)
+            out = []
+            for stage_weight, caller in zip(stage_weights, self._callers):
+                if caller:
+                    out.append('Up to %s:%d: %d' % (caller[1], caller[2], stage_weight))
+                else:
+                    out.append('Up to finish: %d' % stage_weight)
+            bb.warn('Stage times:\n  %s' % '\n  '.join(out))
-- 
2.5.5


