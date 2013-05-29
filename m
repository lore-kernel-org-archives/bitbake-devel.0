Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id EBACF6A57A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 May 2013 03:53:00 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r4T3r4kM001294
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 May 2013 20:53:04 -0700 (PDT)
Received: from msp-mhatle-lx2.wrs.com (172.25.34.61) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.2.342.3; Tue, 28 May 2013 20:53:02 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 28 May 2013 22:59:09 -0500
Message-ID: <1369799955-1488-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.8.1.2.545.g2f19ada
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 1/7] knotty.py: Extend knotty to support "real time" log tail for tasks
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 29 May 2013 03:53:01 -0000
Content-Type: text/plain

From: Jason Wessel <jason.wessel@windriver.com>

This patch provides the capability to knotty to have a higher log
level where the individual tasks logs can be multiplexed to stdio.
This is highly desirable for several different use cases.

1) You can visually spot "hot spots" in building parallel tasks

2) The relative order an sequence of events can be determined in
   difficult to diagnose inter-related library problems.

3) It provides a nice way to see what all is actually going on and
   getting logged by various tasks such as a kernel compile where you
   might want to actually look at the output in a build over build
   scenario.

4) There are most certainly other aspects where this is useful.

The primary control is to set the BB_RT_LOGLEVEL = "2" in your
local.conf.  Additional capabilities will follow in successive
patches.  When parallel tasks are enabled, the logs will be
multiplexed and prefixed with the PID of the task.  In the
non-parallel case there is no PID prefix as everything is linear.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/build.py                  |   4 ++
 lib/bb/ui/crumbs/multilogtail.py | 135 +++++++++++++++++++++++++++++++++++++++
 lib/bb/ui/knotty.py              |  44 +++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 lib/bb/ui/crumbs/multilogtail.py

diff --git a/lib/bb/build.py b/lib/bb/build.py
index bfc176d..725eb02 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -89,6 +89,10 @@ class TaskBase(event.Event):
 class TaskStarted(TaskBase):
     """Task execution started"""
 
+    def __init__(self, t, d):
+        self.logfile = d.getVar("BB_LOGFILE", True) or "";
+        super(TaskStarted, self).__init__(t, d)
+
 class TaskSucceeded(TaskBase):
     """Task execution completed"""
 
diff --git a/lib/bb/ui/crumbs/multilogtail.py b/lib/bb/ui/crumbs/multilogtail.py
new file mode 100644
index 0000000..da8ae68
--- /dev/null
+++ b/lib/bb/ui/crumbs/multilogtail.py
@@ -0,0 +1,135 @@
+#
+# Multipile Log Tail for real time logging
+#
+# Copyright (C) 2012 Wind River Systems, Inc.
+#
+# Authored by Jason Wessel <jason.wessel@windriver.com>
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
+import re
+import time
+import sys
+
+class LogTail(object):
+    """Tail a single log file"""
+
+    def __init__(self):
+        self.file = None
+        self.offset = 0
+        self.filterLines = True
+        self.limit = 8192
+        self.cnt = 0
+        self.storedLine = ""
+
+    def openLog(self, filename, filterLines=True, limit=8192):
+        try:
+            self.file = open(filename, 'rb')
+            self.limit = limit
+            self.filterLines = filterLines
+        except:
+            return False
+        return True
+
+    def getLeftLine(self):
+        (left, right) = self.storedLine.split('\r',1)
+        self.storedLine = right
+        self.cnt = len(right)
+        return left
+
+    def getLine(self):
+        if self.cnt > 0 and '\r' in self.storedLine:
+            return self.getLeftLine()
+        while 1:
+            self.offset = self.file.tell()
+            line = self.file.readline()
+            if line:
+                if self.filterLines:
+                    line = line.replace('\r\n','\r');
+                    line = line.replace('\n','\r');
+                    self.storedLine += line
+                    self.cnt = len(self.storedLine)
+                    if (self.cnt > self.limit):
+                        if not '\r' in self.storedLine:
+                            self.storedLine += '\r'
+                        return self.getLeftLine()
+                    if '\r' in self.storedLine:
+                        return self.getLeftLine()
+                    continue
+                else:
+                    return line
+            self.file.seek(self.offset)
+            return None
+
+    def closeLog(self):
+        if self.file:
+            self.file.close()
+            self.file = None
+
+    def __del__(self):
+        self.closeLog()
+
+class MultiLogTail(object):
+    """Tail mulitple log files"""
+
+    def __init__(self, printPid=True):
+        self.filelist = []
+        self.trackPid = []
+        self.printPid = printPid
+
+    def openLog(self, filename, pid=0, limit=8192):
+        logtail = LogTail()
+        if logtail.openLog(filename, True, limit):
+            self.filelist.append((logtail, filename, pid))
+        else:
+            if pid > 0:
+                self.trackPid.append(pid)
+
+    def displayLogs(self):
+        for (logtail, filename, pid) in self.filelist:
+            while 1:
+                output = logtail.getLine()
+                if output == None:
+                    break
+                if self.printPid:
+                    print " " + str(pid) + ":" + output
+                else:
+                    print output
+
+    def closeLogs(self):
+        while 1:
+            try:
+                (logtail, filename, pid) = self.filelist.pop()
+                logtail.closeLog()
+            except:
+                break
+
+    def closeLog(self, rm_filename):
+        for (logtail, filename, pid) in self.filelist:
+            if filename == rm_filename:
+                self.filelist.remove((logtail, filename, pid))
+                logtail.closeLog()
+                return
+        raise Exception("File %s not in the list" % rm_filename)
+
+    def closeLogPid(self, rm_pid):
+        for (logtail, filename, pid) in self.filelist:
+            if pid == rm_pid:
+                self.filelist.remove((logtail, filename, pid))
+                logtail.closeLog()
+                return
+        if rm_pid in self.trackPid:
+            self.trackPid.remove(rm_pid)
+            return
+        print "ERROR: PID %s not in the list" % rm_pid
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 389c3cc..34ca678 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -22,6 +22,7 @@ from __future__ import division
 
 import os
 import sys
+import select
 import xmlrpclib
 import logging
 import progressbar
@@ -32,6 +33,7 @@ import fcntl
 import struct
 import copy
 from bb.ui import uihelper
+from bb.ui.crumbs.multilogtail import MultiLogTail
 
 logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
@@ -216,6 +218,25 @@ class TerminalFilter(object):
             fd = sys.stdin.fileno()
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
 
+class RtLogLevel:
+    def __init__(self, mlt):
+        self.displaytail = False
+        self.mlt = mlt
+
+    def displayLogs(self):
+        if self.displaytail:
+            self.mlt.displayLogs()
+
+    def setLevel(self, input, verbose):
+        if input == "1":
+            if verbose:
+                print "NOTE: Turning off real time log tail"
+            self.displaytail = False
+        elif input == "2":
+            if verbose:
+                print "NOTE: Turning on real time log tail"
+            self.displaytail = True
+
 def main(server, eventHandler, params, tf = TerminalFilter):
 
     # Get values of variables which control our output
@@ -237,12 +258,23 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     else:
         log_exec_tty = False
 
+    # MultiTail affected varialbles
+    numthreads = server.runCommand(["getVariable", "BB_NUMBER_THREADS"])
+    if numthreads is None or numthreads == "1":
+        mlt = MultiLogTail(False)
+    else:
+        mlt = MultiLogTail(True)
+
     helper = uihelper.BBUIHelper()
 
     console = logging.StreamHandler(sys.stdout)
     format_str = "%(levelname)s: %(message)s"
     format = bb.msg.BBLogFormatter(format_str)
     bb.msg.addDefaultlogFilter(console)
+    rtloglevel = RtLogLevel(mlt)
+    bb_rt_loglevel = server.runCommand(["getVariable", "BB_RT_LOGLEVEL"])
+    if bb_rt_loglevel and bb_rt_loglevel != "":
+        rtloglevel.setLevel(bb_rt_loglevel, False)
     console.setFormatter(format)
     logger.addHandler(console)
 
@@ -290,11 +322,23 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         try:
             termfilter.updateFooter()
             event = eventHandler.waitEvent(0.25)
+            # Always try printing any accumulated log files first
+            rtloglevel.displayLogs()
             if event is None:
                 if main.shutdown > 1:
                     break
                 continue
             helper.eventHandler(event)
+            if isinstance(event, bb.build.TaskStarted):
+                mlt.openLog(event.logfile, event.pid)
+                rtloglevel.displayLogs()
+
+            if isinstance(event, bb.build.TaskSucceeded):
+                mlt.closeLogPid(event.pid)
+
+            if isinstance(event, bb.build.TaskFailed):
+                mlt.closeLogPid(event.pid)
+
             if isinstance(event, bb.runqueue.runQueueExitWait):
                 if not main.shutdown:
                     main.shutdown = 1
-- 
1.8.1.2.545.g2f19ada


