Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 53BE360249
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jun 2016 02:53:01 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga103.jf.intel.com with ESMTP; 12 Jun 2016 19:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,464,1459839600"; d="scan'208";a="120682909"
Received: from ctan5-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.176.32])
	by fmsmga004.fm.intel.com with ESMTP; 12 Jun 2016 19:53:00 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Jun 2016 14:52:19 +1200
Message-Id: <afd0bfad4ab1b1c13ff289724450edc2f35859a8.1465786269.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1465786269.git.paul.eggleton@linux.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1465786269.git.paul.eggleton@linux.intel.com>
References: <cover.1465786269.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 03/10] lib: implement basic task progress support
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
X-List-Received-Date: Mon, 13 Jun 2016 02:53:01 -0000

For long-running tasks where we have some output from the task that
gives us some idea of the progress of the task (such as a percentage
complete), provide the means to scrape the output for that progress
information and show it to the user in the default knotty terminal
output in the form of a progress bar. This is implemented using a new
TaskProgress event as well as some code we can insert to do output
scanning/filtering.

Any task can fire TaskProgress events; however, if you have a shell task
whose output you wish to scan for progress information, you just need to
set the "progress" varflag on the task. This can be set to:
 * "percent" to just look for a number followed by a % sign
 * "percent:<regex>" to specify your own regex matching a percentage
   value (must have a single group which matches the percentage number)
 * "outof:<regex>" to look for the specified regex matching x out of y
   items completed (must have two groups - first group needs to be x,
   second y).
We can potentially extend this in future but this should be a good
start.

Part of the implementation for [YOCTO #5383].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/build.py                | 34 +++++++++++++++++
 lib/bb/progress.py             | 86 ++++++++++++++++++++++++++++++++++++++++++
 lib/bb/ui/knotty.py            | 74 +++++++++++++++++++++++++++++++-----
 lib/bb/ui/uihelper.py          |  7 +++-
 lib/progressbar/progressbar.py | 16 ++++++--
 lib/progressbar/widgets.py     | 36 ++++++++++++++++++
 6 files changed, 239 insertions(+), 14 deletions(-)
 create mode 100644 lib/bb/progress.py

diff --git a/lib/bb/build.py b/lib/bb/build.py
index e016ae3..04bd580 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -35,6 +35,7 @@ import stat
 import bb
 import bb.msg
 import bb.process
+import bb.progress
 from bb import data, event, utils
 
 bblogger = logging.getLogger('BitBake')
@@ -137,6 +138,25 @@ class TaskInvalid(TaskBase):
         super(TaskInvalid, self).__init__(task, None, metadata)
         self._message = "No such task '%s'" % task
 
+class TaskProgress(event.Event):
+    """
+    Task made some progress that could be reported to the user, usually in
+    the form of a progress bar or similar.
+    NOTE: this class does not inherit from TaskBase since it doesn't need
+    to - it's fired within the task context itself, so we don't have any of
+    the context information that you do in the case of the other events.
+    The event PID can be used to determine which task it came from.
+    The progress value is normally 0-100, but can also be negative
+    indicating that progress has been made but we aren't able to determine
+    how much.
+    The rate is optional, this is simply an extra string to display to the
+    user if specified.
+    """
+    def __init__(self, progress, rate=None):
+        self.progress = progress
+        self.rate = rate
+        event.Event.__init__(self)
+
 
 class LogTee(object):
     def __init__(self, logger, outfile):
@@ -340,6 +360,20 @@ exit $ret
     else:
         logfile = sys.stdout
 
+    progress = d.getVarFlag(func, 'progress', True)
+    if progress:
+        if progress == 'percent':
+            # Use default regex
+            logfile = bb.progress.BasicProgressHandler(d, outfile=logfile)
+        elif progress.startswith('percent:'):
+            # Use specified regex
+            logfile = bb.progress.BasicProgressHandler(d, regex=progress.split(':', 1)[1], outfile=logfile)
+        elif progress.startswith('outof:'):
+            # Use specified regex
+            logfile = bb.progress.OutOfProgressHandler(d, regex=progress.split(':', 1)[1], outfile=logfile)
+        else:
+            bb.warn('%s: invalid task progress varflag value "%s", ignoring' % (func, progress))
+
     def readfifo(data):
         lines = data.split(b'\0')
         for line in lines:
diff --git a/lib/bb/progress.py b/lib/bb/progress.py
new file mode 100644
index 0000000..bab8e94
--- /dev/null
+++ b/lib/bb/progress.py
@@ -0,0 +1,86 @@
+"""
+BitBake progress handling code
+"""
+
+# Copyright (C) 2016 Intel Corporation
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+import sys
+import re
+import time
+import bb.event
+import bb.build
+
+class ProgressHandler(object):
+    """
+    Base class that can pretend to be a file object well enough to be
+    used to build objects to intercept console output and determine the
+    progress of some operation.
+    """
+    def __init__(self, d, outfile=None):
+        self._progress = 0
+        self._data = d
+        self._lastevent = 0
+        if outfile:
+            self._outfile = outfile
+        else:
+            self._outfile = sys.stdout
+
+    def _fire_progress(self, taskprogress, rate=None):
+        """Internal function to fire the progress event"""
+        bb.event.fire(bb.build.TaskProgress(taskprogress, rate), self._data)
+
+    def write(self, string):
+        self._outfile.write(string)
+
+    def flush(self):
+        self._outfile.flush()
+
+    def update(self, progress, rate=None):
+        ts = time.time()
+        if progress > 100:
+            progress = 100
+        if progress != self._progress or self._lastevent + 1 < ts:
+            self._fire_progress(progress, rate)
+            self._lastevent = ts
+            self._progress = progress
+
+class BasicProgressHandler(ProgressHandler):
+    def __init__(self, d, regex=r'(\d+)%', outfile=None):
+        super(BasicProgressHandler, self).__init__(d, outfile)
+        self._regex = re.compile(regex)
+        # Send an initial progress event so the bar gets shown
+        self._fire_progress(0)
+
+    def write(self, string):
+        percs = self._regex.findall(string)
+        if percs:
+            progress = int(percs[-1])
+            self.update(progress)
+        super(BasicProgressHandler, self).write(string)
+
+class OutOfProgressHandler(ProgressHandler):
+    def __init__(self, d, regex, outfile=None):
+        super(OutOfProgressHandler, self).__init__(d, outfile)
+        self._regex = re.compile(regex)
+        # Send an initial progress event so the bar gets shown
+        self._fire_progress(0)
+
+    def write(self, string):
+        nums = self._regex.findall(string)
+        if nums:
+            progress = (float(nums[-1][0]) / float(nums[-1][1])) * 100
+            self.update(progress)
+        super(OutOfProgressHandler, self).write(string)
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 6a6f688..2513501 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -40,10 +40,13 @@ logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
 
 class BBProgress(progressbar.ProgressBar):
-    def __init__(self, msg, maxval):
+    def __init__(self, msg, maxval, widgets=None):
         self.msg = msg
-        widgets = [progressbar.Percentage(), ' ', progressbar.Bar(), ' ',
-           progressbar.ETA()]
+        self.extrapos = -1
+        if not widgets:
+            widgets = [progressbar.Percentage(), ' ', progressbar.Bar(), ' ',
+            progressbar.ETA()]
+            self.extrapos = 4
 
         try:
             self._resize_default = signal.getsignal(signal.SIGWINCH)
@@ -55,11 +58,31 @@ class BBProgress(progressbar.ProgressBar):
         progressbar.ProgressBar._handle_resize(self, signum, frame)
         if self._resize_default:
             self._resize_default(signum, frame)
+
     def finish(self):
         progressbar.ProgressBar.finish(self)
         if self._resize_default:
             signal.signal(signal.SIGWINCH, self._resize_default)
 
+    def setmessage(self, msg):
+        self.msg = msg
+        self.widgets[0] = msg
+
+    def setextra(self, extra):
+        if extra:
+            extrastr = str(extra)
+            if extrastr[0] != ' ':
+                extrastr = ' ' + extrastr
+            if extrastr[-1] != ' ':
+                extrastr += ' '
+        else:
+            extrastr = ' '
+        self.widgets[self.extrapos] = extrastr
+
+    def _need_update(self):
+        # We always want the bar to print when update() is called
+        return True
+
 class NonInteractiveProgress(object):
     fobj = sys.stdout
 
@@ -195,15 +218,31 @@ class TerminalFilter(object):
         activetasks = self.helper.running_tasks
         failedtasks = self.helper.failed_tasks
         runningpids = self.helper.running_pids
-        if self.footer_present and (self.lastcount == self.helper.tasknumber_current) and (self.lastpids == runningpids):
+        if self.footer_present and not self.helper.needUpdate:
             return
+        self.helper.needUpdate = False
         if self.footer_present:
             self.clearFooter()
         if (not self.helper.tasknumber_total or self.helper.tasknumber_current == self.helper.tasknumber_total) and not len(activetasks):
             return
         tasks = []
         for t in runningpids:
-            tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
+            progress = activetasks[t].get("progress", None)
+            if progress is not None:
+                pbar = activetasks[t].get("progressbar", None)
+                rate = activetasks[t].get("rate", None)
+                start_time = activetasks[t].get("starttime", None)
+                if not pbar or pbar.bouncing != (progress < 0):
+                    if progress < 0:
+                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.BouncingSlider()])
+                        pbar.bouncing = True
+                    else:
+                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100)
+                        pbar.bouncing = False
+                    activetasks[t]["progressbar"] = pbar
+                tasks.append((pbar, progress, rate, start_time))
+            else:
+                tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
 
         if self.main.shutdown:
             content = "Waiting for %s running tasks to finish:" % len(activetasks)
@@ -214,8 +253,23 @@ class TerminalFilter(object):
         print(content)
         lines = 1 + int(len(content) / (self.columns + 1))
         for tasknum, task in enumerate(tasks[:(self.rows - 2)]):
-            content = "%s: %s" % (tasknum, task)
-            print(content)
+            if isinstance(task, tuple):
+                pbar, progress, rate, start_time = task
+                if not pbar.start_time:
+                    pbar.start(False)
+                    if start_time:
+                        pbar.start_time = start_time
+                pbar.setmessage('%s:%s' % (tasknum, pbar.msg.split(':', 1)[1]))
+                if progress > -1:
+                    pbar.setextra(rate)
+                    output = pbar.update(progress)
+                else:
+                    output = pbar.update(1)
+                if not output or (len(output) <= pbar.term_width):
+                    print('')
+            else:
+                content = "%s: %s" % (tasknum, task)
+                print(content)
             lines = lines + 1 + int(len(content) / (self.columns + 1))
         self.footer_present = lines
         self.lastpids = runningpids[:]
@@ -249,7 +303,8 @@ _evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.Lo
               "bb.command.CommandExit", "bb.command.CommandCompleted",  "bb.cooker.CookerExit",
               "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.runqueue.sceneQueueTaskStarted",
               "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTaskFailed", "bb.runqueue.sceneQueueTaskFailed",
-              "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent"]
+              "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent",
+              "bb.build.TaskProgress"]
 
 def main(server, eventHandler, params, tf = TerminalFilter):
 
@@ -535,7 +590,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                                   bb.event.OperationStarted,
                                   bb.event.OperationCompleted,
                                   bb.event.OperationProgress,
-                                  bb.event.DiskFull)):
+                                  bb.event.DiskFull,
+                                  bb.build.TaskProgress)):
                 continue
 
             logger.error("Unknown event: %s", event)
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index db70b76..1915e47 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -18,6 +18,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 import bb.build
+import time
 
 class BBUIHelper:
     def __init__(self):
@@ -31,7 +32,7 @@ class BBUIHelper:
 
     def eventHandler(self, event):
         if isinstance(event, bb.build.TaskStarted):
-            self.running_tasks[event.pid] = { 'title' : "%s %s" % (event._package, event._task) }
+            self.running_tasks[event.pid] = { 'title' : "%s %s" % (event._package, event._task), 'starttime' : time.time() }
             self.running_pids.append(event.pid)
             self.needUpdate = True
         if isinstance(event, bb.build.TaskSucceeded):
@@ -52,6 +53,10 @@ class BBUIHelper:
             self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
             self.tasknumber_total = event.stats.total
             self.needUpdate = True
+        if isinstance(event, bb.build.TaskProgress):
+            self.running_tasks[event.pid]['progress'] = event.progress
+            self.running_tasks[event.pid]['rate'] = event.rate
+            self.needUpdate = True
 
     def getTasks(self):
         self.needUpdate = False
diff --git a/lib/progressbar/progressbar.py b/lib/progressbar/progressbar.py
index 0b9dcf7..2873ad6 100644
--- a/lib/progressbar/progressbar.py
+++ b/lib/progressbar/progressbar.py
@@ -3,6 +3,8 @@
 # progressbar  - Text progress bar library for Python.
 # Copyright (c) 2005 Nilton Volpato
 #
+# (With some small changes after importing into BitBake)
+#
 # This library is free software; you can redistribute it and/or
 # modify it under the terms of the GNU Lesser General Public
 # License as published by the Free Software Foundation; either
@@ -261,12 +263,14 @@ class ProgressBar(object):
         now = time.time()
         self.seconds_elapsed = now - self.start_time
         self.next_update = self.currval + self.update_interval
-        self.fd.write(self._format_line() + '\r')
+        output = self._format_line()
+        self.fd.write(output + '\r')
         self.fd.flush()
         self.last_update_time = now
+        return output
 
 
-    def start(self):
+    def start(self, update=True):
         """Starts measuring time, and prints the bar at 0%.
 
         It returns self so you can use it like this:
@@ -289,8 +293,12 @@ class ProgressBar(object):
             self.update_interval = self.maxval / self.num_intervals
 
 
-        self.start_time = self.last_update_time = time.time()
-        self.update(0)
+        self.start_time = time.time()
+        if update:
+            self.last_update_time = self.start_time
+            self.update(0)
+        else:
+            self.last_update_time = 0
 
         return self
 
diff --git a/lib/progressbar/widgets.py b/lib/progressbar/widgets.py
index 6434ad5..77285ca 100644
--- a/lib/progressbar/widgets.py
+++ b/lib/progressbar/widgets.py
@@ -353,3 +353,39 @@ class BouncingBar(Bar):
         if not self.fill_left: rpad, lpad = lpad, rpad
 
         return '%s%s%s%s%s' % (left, lpad, marker, rpad, right)
+
+
+class BouncingSlider(Bar):
+    """
+    A slider that bounces back and forth in response to update() calls
+    without reference to the actual value. Based on a combination of
+    BouncingBar from a newer version of this module and RotatingMarker.
+    """
+    def __init__(self, marker='<=>'):
+        self.curmark = -1
+        self.forward = True
+        Bar.__init__(self, marker=marker)
+    def update(self, pbar, width):
+        left, marker, right = (format_updatable(i, pbar) for i in
+                               (self.left, self.marker, self.right))
+
+        width -= len(left) + len(right)
+        if width < 0:
+            return ''
+
+        if pbar.finished: return '%s%s%s' % (left, width * '=', right)
+
+        self.curmark = self.curmark + 1
+        position = int(self.curmark % (width * 2 - 1))
+        if position + len(marker) > width:
+            self.forward = not self.forward
+            self.curmark = 1
+            position = 1
+        lpad = ' ' * (position - 1)
+        rpad = ' ' * (width - len(marker) - len(lpad))
+
+        if not self.forward:
+            temp = lpad
+            lpad = rpad
+            rpad = temp
+        return '%s%s%s%s%s' % (left, lpad, marker, rpad, right)
-- 
2.5.5


