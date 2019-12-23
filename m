Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
	[209.85.215.182])
	by mail.openembedded.org (Postfix) with ESMTP id 4AAC07F849
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:49 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id x7so8180776pgl.11
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=BkLs2H2CSf4CS2ErMW2nOhuaZWG0RMDiU/WvOm2D2xk=;
	b=JSN42d8lc8Yo6oA7/rV7hdidTfULI3CQCYuuw/tq4BJIoopeyku31zS8S71Uu0qwUu
	ph+SQr1EYLn6QMSSa1VPsz0fc2tEJDLtiA1SqMxw/D3BELGRek4ZcKq2vNdvYHeE6C6y
	9UbcyeyJf4FFR4zJ9UjQImqs9w/wF4L0hHXiy9imF5hE/52MRC2eHKc8HAP/YIogNm4O
	jrC6GYPQOmN60p6g7yjr5Mf/5mphudbdvJGy69iXvlxmAfYtk5f70WcwQpu3Jnj4qdUf
	EwI94w9RJkXt6IkeZvlnTcbY5eih/zUCMn9MIKwF5H/+oFbaK5e//LceCphDxG6/KX1T
	iIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=BkLs2H2CSf4CS2ErMW2nOhuaZWG0RMDiU/WvOm2D2xk=;
	b=fHB4pd+MbbVdlEaXNf+chqQ7VvObgSw3lXuCTjKAmD8kkwB6jDXc/ATO0XZ8BPK3l+
	PFniJpVX7GDnDU8khD4PH63CW6EDJV9DOQ19rKhAq8MXbQOF9Zjoh/x0sWDhY7QfunhH
	gNWWzzGjLG7Jv5SkI9bnhxh9oqPDWoXjFdcA0guzRoOY3HFZpq0KGbw2pcr6HEp1vuTA
	84Gpn2F9PyJkF/10/QLBiXPTbldshgQg2dEIMUcZT0XeZ/wpoWum0mMrgRjE09Dh23XX
	BhTvQk+N4JKrsnmhG1tW39lvNvSIbtsxx0DKnTbfqTyENbczcdwQcO7j7O5xANOgqq4d
	WsGw==
X-Gm-Message-State: APjAAAW/mgFn8nMnPMs0VrE/w2kOypsQvaZY9TMCoDR9LbjKyhWIuVjY
	+0OmOvtAEQuzGDi68L/G5dG0UNmc36Q=
X-Google-Smtp-Source: APXvYqziaumVUSbmrtAISq8nx3vMSCYdz4yKymhCGfYPwvTzPV4B94mRQrJ9TK31k70fka/hCnFjeA==
X-Received: by 2002:a63:184d:: with SMTP id 13mr29122294pgy.132.1577076650115; 
	Sun, 22 Dec 2019 20:50:50 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.49
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:49 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:28 -0800
Message-Id: <a109d034cf4fc059fd5a1e1d03246dac65522dd6.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 04/18] knotty/uihelper: Switch from pids to tids for Task event management
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:49 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We've seen cases where a task can execute with a given pid, complete
and a new task can start using the same pid before the UI handler has
had time to adapt.

Traceback (most recent call last):
  File "/home/pokybuild/yocto-worker/qemux86-alt/build/bitbake/lib/bb/ui/knotty.py", line 484, in main
    helper.eventHandler(event)
  File "/home/pokybuild/yocto-worker/qemux86-alt/build/bitbake/lib/bb/ui/uihelper.py", line 30, in eventHandler
    del self.running_tasks[event.pid]
KeyError: 13490

This means using pids to match up events on the UI side is a bad
idea. Change the code to use task ids instead. There is a small
amount of fuzzy matching for the progress information since there
is no task information there and we don't want the overhead of a task
ID in every event, however since pid reuse is unlikely, we can live
with a progress bar not quite working properly in a corner case like
this.

[YOCTO #13667]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e427eafa1bb04008d12100ccc5c862122bba53e0)
---
 lib/bb/build.py       | 25 +++++++++++++------------
 lib/bb/ui/knotty.py   | 12 ++++++------
 lib/bb/ui/uihelper.py | 39 ++++++++++++++++++++++++---------------
 3 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index 30a2ba2..3d9cc10 100644
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
index 35736ad..bd9911c 100644
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
@@ -517,8 +517,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         continue
 
                     # Prefix task messages with recipe/task
-                    if event.taskpid in helper.running_tasks and event.levelno != format.PLAIN:
-                        taskinfo = helper.running_tasks[event.taskpid]
+                    if event.taskpid in helper.pidmap and event.levelno != format.PLAIN:
+                        taskinfo = helper.running_tasks[helper.pidmap[event.taskpid]]
                         event.msg = taskinfo['title'] + ': ' + event.msg
                 if hasattr(event, 'fn'):
                     event.msg = event.fn + ': ' + event.msg
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index c8dd7df..48d808a 100644
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
+            removetid(event.pid, tid)
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
2.7.4


