Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id E919D7F68F
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  4 Dec 2019 11:53:06 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id y17so8230240wrh.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 04 Dec 2019 03:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=/X1RHVhTg6uO+Crf0wnZTnmsLO5vB5I3Wb/tcot1KB8=;
	b=SQ2QsItIK8x1QMV1DkcNJkSmfxcESw36NyrGxDxIW5BtC4fVoksHZZaX6fIA+8ZU9J
	SUTAGYOyVjokidXo3d/af+xVWVf6r3oMSO45cJd8f2sPHOo6grQWGsrXfZsZzn6b+T8X
	qIVAZv7Mk7gW942/UwwgnFRW/u1deJ76KSKFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/X1RHVhTg6uO+Crf0wnZTnmsLO5vB5I3Wb/tcot1KB8=;
	b=T5+my4WwaLmJua99+4V0oxUlURnTJfahmATLnY2E1KyKt0PlXBojJyWdSyDplH+dgP
	EW9aAdGnjSRdG8WO2Lfgoxd/t3k8b/+WF0R8qu9ax7uWoAO4WtBIVZJblM0tx3a93obS
	c3N7g8bXIRwZ0Day573ElJjuBQoVgRajb/2WE6v8uMdZ571oSK0Ww/yx8Zc10R5jKK8p
	A9roSEO2p4PpFRatwmLf+hBwX9oD0q80zsAeVGw5TNr0NuSYJ+VME0Im8SX+MF8wRtcb
	TzGwwDNWn0l+K+FNjctDDRJ/yTvImDJD8WcMk2EvGXBpyPq3drpDasJDPaH8VjIFGZnp
	YOTQ==
X-Gm-Message-State: APjAAAWI1W6rTNGVUfAUX7PLodNQwQZo9HXbD3AbgNK33AgM80zaxLuo
	MMvHHAF2MVD2yucuMrH597l6w7Mq2t0=
X-Google-Smtp-Source: APXvYqxPhNFmG88UcttlU7O08FrCghpkuUoHi23SxZMD/FLV8Z/zOmQ5w8JMcY7xdiB9ibuQXocgQw==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr3809949wrr.265.1575460387161; 
	Wed, 04 Dec 2019 03:53:07 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o4sm7813059wrw.97.2019.12.04.03.53.06
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 04 Dec 2019 03:53:06 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  4 Dec 2019 11:53:02 +0000
Message-Id: <20191204115302.24692-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204115302.24692-1-richard.purdie@linuxfoundation.org>
References: <20191204115302.24692-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 4/4] knotty/uihelper: Switch from pids to tids for Task event management
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
X-List-Received-Date: Wed, 04 Dec 2019 11:53:07 -0000
Content-Transfer-Encoding: 8bit

We've seen cases where a task can execute with a given pid, complete
and a new task can start using the same pid before the UI handler has
had time to adapt.

This means using pids to match up events on the UI side is a bad
idea. Change the code to use task ids instead. There is a small
amount of fuzzy matching for the progress information since there
is no task information there and we don't want the overhead of a task
ID in every event, however since pid reuse is unlikely, we can live
with a progress bar not quite working properly in a corner case like
this.

[YOCTO #13667]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py       | 25 +++++++++++++------------
 lib/bb/ui/knotty.py   |  8 ++++----
 lib/bb/ui/uihelper.py | 39 ++++++++++++++++++++++++---------------
 3 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 30a2ba236f..3d9cc10c8c 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -57,8 +57,9 @@ builtins['os'] = os
 class TaskBase(event.Event):
     """Base class for task events"""
 
-    def __init__(self, t, logfile, d):
+    def __init__(self, t, fn, logfile, d):
         self._task = t
+        self._fn = fn
         self._package = d.getVar("PF")
         self._mc = d.getVar("BB_CURRENT_MC")
         self.taskfile = d.getVar("FILE")
@@ -81,8 +82,8 @@ class TaskBase(event.Event):
 
 class TaskStarted(TaskBase):
     """Task execution started"""
-    def __init__(self, t, logfile, taskflags, d):
-        super(TaskStarted, self).__init__(t, logfile, d)
+    def __init__(self, t, fn, logfile, taskflags, d):
+        super(TaskStarted, self).__init__(t, fn, logfile, d)
         self.taskflags = taskflags
 
 class TaskSucceeded(TaskBase):
@@ -91,9 +92,9 @@ class TaskSucceeded(TaskBase):
 class TaskFailed(TaskBase):
     """Task execution failed"""
 
-    def __init__(self, task, logfile, metadata, errprinted = False):
+    def __init__(self, task, fn, logfile, metadata, errprinted = False):
         self.errprinted = errprinted
-        super(TaskFailed, self).__init__(task, logfile, metadata)
+        super(TaskFailed, self).__init__(task, fn, logfile, metadata)
 
 class TaskFailedSilent(TaskBase):
     """Task execution failed (silently)"""
@@ -103,8 +104,8 @@ class TaskFailedSilent(TaskBase):
 
 class TaskInvalid(TaskBase):
 
-    def __init__(self, task, metadata):
-        super(TaskInvalid, self).__init__(task, None, metadata)
+    def __init__(self, task, fn, metadata):
+        super(TaskInvalid, self).__init__(task, fn, None, metadata)
         self._message = "No such task '%s'" % task
 
 class TaskProgress(event.Event):
@@ -572,7 +573,7 @@ def _exec_task(fn, task, d, quieterr):
 
     try:
         try:
-            event.fire(TaskStarted(task, logfn, flags, localdata), localdata)
+            event.fire(TaskStarted(task, fn, logfn, flags, localdata), localdata)
         except (bb.BBHandledException, SystemExit):
             return 1
 
@@ -583,15 +584,15 @@ def _exec_task(fn, task, d, quieterr):
             for func in (postfuncs or '').split():
                 exec_func(func, localdata)
         except bb.BBHandledException:
-            event.fire(TaskFailed(task, logfn, localdata, True), localdata)
+            event.fire(TaskFailed(task, fn, logfn, localdata, True), localdata)
             return 1
         except Exception as exc:
             if quieterr:
-                event.fire(TaskFailedSilent(task, logfn, localdata), localdata)
+                event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
             else:
                 errprinted = errchk.triggered
                 logger.error(str(exc))
-                event.fire(TaskFailed(task, logfn, localdata, errprinted), localdata)
+                event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
             return 1
     finally:
         sys.stdout.flush()
@@ -614,7 +615,7 @@ def _exec_task(fn, task, d, quieterr):
             logger.debug(2, "Zero size logfn %s, removing", logfn)
             bb.utils.remove(logfn)
             bb.utils.remove(loglink)
-    event.fire(TaskSucceeded(task, logfn, localdata), localdata)
+    event.fire(TaskSucceeded(task, fn, logfn, localdata), localdata)
 
     if not localdata.getVarFlag(task, 'nostamp', False) and not localdata.getVarFlag(task, 'selfstamp', False):
         make_stamp(task, localdata)
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 35736ade03..3bbebfe722 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -255,19 +255,19 @@ class TerminalFilter(object):
                 start_time = activetasks[t].get("starttime", None)
                 if not pbar or pbar.bouncing != (progress < 0):
                     if progress < 0:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[progressbar.BouncingSlider(), ''], extrapos=2, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = True
                     else:
-                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], t), 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s (pid %s) " % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=4, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = False
                     activetasks[t]["progressbar"] = pbar
                 tasks.append((pbar, progress, rate, start_time))
             else:
                 start_time = activetasks[t].get("starttime", None)
                 if start_time:
-                    tasks.append("%s - %s (pid %s)" % (activetasks[t]["title"], self.elapsed(currenttime - start_time), t))
+                    tasks.append("%s - %s (pid %s)" % (activetasks[t]["title"], self.elapsed(currenttime - start_time), activetasks[t]["pid"]))
                 else:
-                    tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
+                    tasks.append("%s (pid %s)" % (activetasks[t]["title"], activetasks[t]["pid"]))
 
         if self.main.shutdown:
             content = "Waiting for %s running tasks to finish:" % len(activetasks)
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index c8dd7df087..74e9e1958d 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -15,39 +15,48 @@ class BBUIHelper:
         # Running PIDs preserves the order tasks were executed in
         self.running_pids = []
         self.failed_tasks = []
+        self.pidmap = {}
         self.tasknumber_current = 0
         self.tasknumber_total = 0
 
     def eventHandler(self, event):
+        # PIDs are a bad idea as they can be reused before we process all UI events.
+        # We maintain a 'fuzzy' match for TaskProgress since there is no other way to match
+        def removetid(pid, tid):
+            self.running_pids.remove(tid)
+            del self.running_tasks[tid]
+            if self.pidmap[pid] == tid:
+                del self.pidmap[pid]
+            self.needUpdate = True
+
         if isinstance(event, bb.build.TaskStarted):
+            tid = event._fn + ":" + event._task
             if event._mc != "default":
-                self.running_tasks[event.pid] = { 'title' : "mc:%s:%s %s" % (event._mc, event._package, event._task), 'starttime' : time.time() }
+                self.running_tasks[tid] = { 'title' : "mc:%s:%s %s" % (event._mc, event._package, event._task), 'starttime' : time.time(), 'pid' : event.pid }
             else:
-                self.running_tasks[event.pid] = { 'title' : "%s %s" % (event._package, event._task), 'starttime' : time.time() }
-            self.running_pids.append(event.pid)
+                self.running_tasks[tid] = { 'title' : "%s %s" % (event._package, event._task), 'starttime' : time.time(), 'pid' : event.pid }
+            self.running_pids.append(tid)
+            self.pidmap[event.pid] = tid
             self.needUpdate = True
         elif isinstance(event, bb.build.TaskSucceeded):
-            del self.running_tasks[event.pid]
-            self.running_pids.remove(event.pid)
-            self.needUpdate = True
+            tid = event._fn + ":" + event._task
+            removetid(event.pid, tid)
         elif isinstance(event, bb.build.TaskFailedSilent):
-            del self.running_tasks[event.pid]
-            self.running_pids.remove(event.pid)
+            tid = event._fn + ":" + event._task
+            removetid(event.pid, tid)
             # Don't add to the failed tasks list since this is e.g. a setscene task failure
-            self.needUpdate = True
         elif isinstance(event, bb.build.TaskFailed):
-            del self.running_tasks[event.pid]
-            self.running_pids.remove(event.pid)
+            tid = event._fn + ":" + event._task
+            removetid(sevent.pid, tid)
             self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
-            self.needUpdate = True
         elif isinstance(event, bb.runqueue.runQueueTaskStarted):
             self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + 1
             self.tasknumber_total = event.stats.total
             self.needUpdate = True
         elif isinstance(event, bb.build.TaskProgress):
-            if event.pid > 0:
-                self.running_tasks[event.pid]['progress'] = event.progress
-                self.running_tasks[event.pid]['rate'] = event.rate
+            if event.pid > 0 and event.pid in self.pidmap:
+                self.running_tasks[self.pidmap[event.pid]]['progress'] = event.progress
+                self.running_tasks[self.pidmap[event.pid]]['rate'] = event.rate
                 self.needUpdate = True
         else:
             return False
-- 
2.20.1


