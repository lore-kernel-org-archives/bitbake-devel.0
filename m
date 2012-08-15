Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T1gzD-0003eQ-MD for bitbake-devel@lists.openembedded.org;
	Wed, 15 Aug 2012 19:02:28 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FGoV6P003501
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 17:50:31 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02230-09 for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 17:50:27 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7FGoNUa003494
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 17:50:24 +0100
Message-ID: <1345049422.14667.11.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 Aug 2012 17:50:22 +0100
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] knotty: Fold knotty2 into knotty and make it the default
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
X-List-Received-Date: Wed, 15 Aug 2012 17:02:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There is no good reason knotty2 shouldn't be the default now. If you need
the old behaviour, just pipe the output through cat as non-interactive
terminals get the old output.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 34b5969..304ba29 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -27,6 +27,9 @@ import logging
 import progressbar
 import signal
 import bb.msg
+import fcntl
+import struct
+import copy
 from bb.ui import uihelper
 
 logger = logging.getLogger("BitBake")
@@ -84,39 +87,124 @@ def pluralise(singular, plural, qty):
     else:
         return plural % qty
 
+
+class InteractConsoleLogFilter(logging.Filter):
+    def __init__(self, tf, format):
+        self.tf = tf
+        self.format = format
+
+    def filter(self, record):
+        if record.levelno == self.format.NOTE and (record.msg.startswith("Running") or record.msg.startswith("package ")):
+            return False
+        self.tf.clearFooter()
+        return True
+
 class TerminalFilter(object):
+    columns = 80
+
+    def sigwinch_handle(self, signum, frame):
+        self.columns = self.getTerminalColumns()
+        if self._sigwinch_default:
+            self._sigwinch_default(signum, frame)
+
+    def getTerminalColumns(self):
+        def ioctl_GWINSZ(fd):
+            try:
+                cr = struct.unpack('hh', fcntl.ioctl(fd, self.termios.TIOCGWINSZ, '1234'))
+            except:
+                return None
+            return cr
+        cr = ioctl_GWINSZ(sys.stdout.fileno())
+        if not cr:
+            try:
+                fd = os.open(os.ctermid(), os.O_RDONLY)
+                cr = ioctl_GWINSZ(fd)
+                os.close(fd)
+            except:
+                pass
+        if not cr:
+            try:
+                cr = (env['LINES'], env['COLUMNS'])
+            except:
+                cr = (25, 80)
+        return cr[1]
+
     def __init__(self, main, helper, console, format):
         self.main = main
         self.helper = helper
+        self.cuu = None
+        self.stdinbackup = None
+        self.interactive = sys.stdout.isatty()
+        self.footer_present = False
+        self.lastpids = []
+
+        if not self.interactive:
+            return
+
+        import curses
+        import termios
+        self.curses = curses
+        self.termios = termios
+        try:
+            fd = sys.stdin.fileno()
+            self.stdinbackup = termios.tcgetattr(fd)
+            new = copy.deepcopy(self.stdinbackup)
+            new[3] = new[3] & ~termios.ECHO
+            termios.tcsetattr(fd, termios.TCSADRAIN, new)
+            curses.setupterm()
+            self.ed = curses.tigetstr("ed")
+            if self.ed:
+                self.cuu = curses.tigetstr("cuu")
+            try:
+                self._sigwinch_default = signal.getsignal(signal.SIGWINCH)
+                signal.signal(signal.SIGWINCH, self.sigwinch_handle)
+            except:
+                pass
+            self.columns = self.getTerminalColumns()
+        except:
+            self.cuu = None
+        console.addFilter(InteractConsoleLogFilter(self, format))
 
     def clearFooter(self):
-        return
+        if self.footer_present:
+            lines = self.footer_present
+            sys.stdout.write(self.curses.tparm(self.cuu, lines))
+            sys.stdout.write(self.curses.tparm(self.ed))
+        self.footer_present = False
 
     def updateFooter(self):
-        if not main.shutdown or not self.helper.needUpdate:
+        if not self.cuu:
             return
-
         activetasks = self.helper.running_tasks
+        failedtasks = self.helper.failed_tasks
         runningpids = self.helper.running_pids
-
-        if len(runningpids) == 0:
+        if self.footer_present and (self.lastpids == runningpids):
+            return
+        if self.footer_present:
+            self.clearFooter()
+        if not activetasks:
             return
-
-        self.helper.getTasks()
-
         tasks = []
         for t in runningpids:
             tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
 
-        if main.shutdown:
-            print("Waiting for %s running tasks to finish:" % len(activetasks))
+        if self.main.shutdown:
+            content = "Waiting for %s running tasks to finish:" % len(activetasks)
         else:
-            print("Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total))
+            content = "Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
+        print content
+        lines = 1 + int(len(content) / (self.columns + 1))
         for tasknum, task in enumerate(tasks):
-            print("%s: %s" % (tasknum, task))
+            content = "%s: %s" % (tasknum, task)
+            print content
+            lines = lines + 1 + int(len(content) / (self.columns + 1))
+        self.footer_present = lines
+        self.lastpids = runningpids[:]
 
     def finish(self):
-        return
+        if self.stdinbackup:
+            fd = sys.stdin.fileno()
+            self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
 
 def main(server, eventHandler, tf = TerminalFilter):
 
diff --git a/bitbake/lib/bb/ui/knotty2.py b/bitbake/lib/bb/ui/knotty2.py
deleted file mode 100644
index 57ad67f..0000000
--- a/bitbake/lib/bb/ui/knotty2.py
+++ b/dev/null
@@ -1,149 +0,0 @@
-#
-# BitBake (No)TTY UI Implementation (v2)
-#
-# Handling output to TTYs or files (no TTY)
-#
-# Copyright (C) 2012 Richard Purdie
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License along
-# with this program; if not, write to the Free Software Foundation, Inc.,
-# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-
-from bb.ui import knotty
-import logging
-import sys
-import os
-import fcntl
-import struct
-import copy
-logger = logging.getLogger("BitBake")
-
-class InteractConsoleLogFilter(logging.Filter):
-    def __init__(self, tf, format):
-        self.tf = tf
-        self.format = format
-
-    def filter(self, record):
-        if record.levelno == self.format.NOTE and (record.msg.startswith("Running") or record.msg.startswith("package ")):
-            return False
-        self.tf.clearFooter()
-        return True
-
-class TerminalFilter2(object):
-    columns = 80
-
-    def sigwinch_handle(self, signum, frame):
-        self.columns = self.getTerminalColumns()
-        if self._sigwinch_default:
-            self._sigwinch_default(signum, frame)
-
-    def getTerminalColumns(self):
-        def ioctl_GWINSZ(fd):
-            try:
-                cr = struct.unpack('hh', fcntl.ioctl(fd, self.termios.TIOCGWINSZ, '1234'))
-            except:
-                return None
-            return cr
-        cr = ioctl_GWINSZ(sys.stdout.fileno())
-        if not cr:
-            try:
-                fd = os.open(os.ctermid(), os.O_RDONLY)
-                cr = ioctl_GWINSZ(fd)
-                os.close(fd)
-            except:
-                pass
-        if not cr:
-            try:
-                cr = (env['LINES'], env['COLUMNS'])
-            except:
-                cr = (25, 80)
-        return cr[1]
-
-    def __init__(self, main, helper, console, format):
-        self.main = main
-        self.helper = helper
-        self.cuu = None
-        self.stdinbackup = None
-        self.interactive = sys.stdout.isatty()
-        self.footer_present = False
-        self.lastpids = []
-
-        if not self.interactive:
-            return
-
-        import curses
-        import termios
-        self.curses = curses
-        self.termios = termios
-        try:
-            fd = sys.stdin.fileno()
-            self.stdinbackup = termios.tcgetattr(fd)
-            new = copy.deepcopy(self.stdinbackup)
-            new[3] = new[3] & ~termios.ECHO
-            termios.tcsetattr(fd, termios.TCSADRAIN, new)
-            curses.setupterm()
-            self.ed = curses.tigetstr("ed")
-            if self.ed:
-                self.cuu = curses.tigetstr("cuu")
-            try:
-                self._sigwinch_default = signal.getsignal(signal.SIGWINCH)
-                signal.signal(signal.SIGWINCH, self.sigwinch_handle)
-            except:
-                pass
-            self.columns = self.getTerminalColumns()
-        except:
-            self.cuu = None
-        console.addFilter(InteractConsoleLogFilter(self, format))
-
-    def clearFooter(self):
-        if self.footer_present:
-            lines = self.footer_present
-            sys.stdout.write(self.curses.tparm(self.cuu, lines))
-            sys.stdout.write(self.curses.tparm(self.ed))
-        self.footer_present = False
-
-    def updateFooter(self):
-        if not self.cuu:
-            return
-        activetasks = self.helper.running_tasks
-        failedtasks = self.helper.failed_tasks
-        runningpids = self.helper.running_pids
-        if self.footer_present and (self.lastpids == runningpids):
-            return
-        if self.footer_present:
-            self.clearFooter()
-        if not activetasks:
-            return
-        tasks = []
-        for t in runningpids:
-            tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
-
-        if self.main.shutdown:
-            content = "Waiting for %s running tasks to finish:" % len(activetasks)
-        else:
-            content = "Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
-        print content
-        lines = 1 + int(len(content) / (self.columns + 1))
-        for tasknum, task in enumerate(tasks):
-            content = "%s: %s" % (tasknum, task)
-            print content
-            lines = lines + 1 + int(len(content) / (self.columns + 1))
-        self.footer_present = lines
-        self.lastpids = runningpids[:]
-
-    def finish(self):
-        if self.stdinbackup:
-            fd = sys.stdin.fileno()
-            self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
-
-def main(server, eventHandler):
-    return bb.ui.knotty.main(server, eventHandler, TerminalFilter2)




