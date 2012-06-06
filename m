Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1ScN0g-0006ch-M9
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 22:39:19 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q56KSovQ014056
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jun 2012 13:28:50 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 6 Jun 2012 13:28:50 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 6 Jun 2012 15:28:35 -0500
Message-ID: <1339014519-9972-12-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339014519-9972-1-git-send-email-jason.wessel@windriver.com>
References: <1339014519-9972-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v3 11/15] knotty: Merge knotty2 functionality into knotty
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
X-List-Received-Date: Wed, 06 Jun 2012 20:39:19 -0000
Content-Type: text/plain

The knotty 2 functionality can be activated in realtime
by pressing "t" for top mode or reverted with "0" for
normal mode.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py |  172 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 150 insertions(+), 22 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 58fb8f1..765ad27 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -74,50 +74,156 @@ def pluralise(singular, plural, qty):
     else:
         return plural % qty
 
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
     def __init__(self, main, helper, console, format):
+        import curses
         self.main = main
+        self.console = console
         self.helper = helper
+        self.topMode = False
+        self.cuu = None
+        self.interactive = sys.stdout.isatty()
+        self.footer_present = False
+        self.lastpids = []
+        self.curses = curses
+        self.confilter = InteractConsoleLogFilter(self, format)
+        self.curses_init = False
+        self.columns = 80
+
+    def cursesInit(self):
+        if self.curses_init:
+            return
+        self.curses_init = True
+        if self.interactive:
+            try:
+                self.curses.setupterm()
+                self.ed = self.curses.tigetstr("ed")
+                if self.ed:
+                    self.cuu = self.curses.tigetstr("cuu")
+                self.columns = self.getTerminalColumns()
+                self.sigUpdate()
+            except Exception as e:
+                self.cuu = None
+
+    def setTopMode(self):
+        if self.topMode:
+            return
+        self.cursesInit()
+        self.topMode = True
+        self.console.addFilter(self.confilter)
+
+    def setNormalMode(self):
+        if not self.topMode:
+            return
+        self.topMode = False
+        try:
+            self.console.removeFilter(self.confilter)
+        except:
+            pass
 
     def clearFooter(self):
-        return
+        if not self.topMode:
+            return
+        if self.footer_present:
+            lines = self.footer_present
+            sys.stdout.write(self.curses.tparm(self.cuu, lines))
+            sys.stdout.write(self.curses.tparm(self.ed))
+        self.footer_present = False
 
-    def sigUpdate(self):
-        return
 
     def updateFooterForce(self):
+        self.footer_present = False
         self.printFooter(True)
 
     def updateFooter(self):
         self.printFooter(False)
 
     def printFooter(self, force_update):
-        if not force_update:
-            if not main.shutdown or not self.helper.needUpdate:
-                return
-
         activetasks = self.helper.running_tasks
+        failedtasks = self.helper.failed_tasks
         runningpids = self.helper.running_pids
+        if self.topMode:
+            if not self.cuu:
+                return
+            if self.footer_present and (self.lastpids == runningpids):
+                return
+            if self.footer_present:
+                self.clearFooter()
+        else:
+            if not force_update:
+                if not main.shutdown or not self.helper.needUpdate:
+                    return
+            if len(runningpids) == 0:
+                return
+            self.helper.getTasks()
 
-        if len(runningpids) == 0:
+        if not activetasks:
             return
-
-        self.helper.getTasks()
-
+        lines = 1
         tasks = []
         for t in runningpids:
             tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
 
-        if main.shutdown:
+        if self.main.shutdown:
             print("Waiting for %s running tasks to finish:" % len(activetasks))
         else:
-            print("Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total))
+            if self.helper.tasknumber_current == 0:
+                print("Currently %s running SetScene tasks (%s of %s):" % (len(activetasks), self.helper.sc_tasknumber_current, self.helper.sc_tasknumber_total))
+            else:
+                print("Currently %s running tasks (%s of %s):" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total))
         for tasknum, task in enumerate(tasks):
-            print("%s: %s" % (tasknum, task))
+            content = "%s: %s" % (tasknum, task)
+            print content
+            lines = lines + 1 + int(len(content) / (self.columns + 1))
+        self.footer_present = lines
+        self.lastpids = runningpids[:]
 
     def finish(self):
         return
 
+    def sigwinch_handle(self, sig, data):
+        self.columns = self.getTerminalColumns()
+
+    def sigUpdate(self):
+        import signal
+        if self.interactive and self.cuu:
+            signal.signal(signal.SIGWINCH, self.sigwinch_handle)
+
+    def getTerminalColumns(self):
+        def ioctl_GWINSZ(fd):
+            try:
+                import fcntl, termios, struct, os
+                cr = struct.unpack('hh', fcntl.ioctl(fd, termios.TIOCGWINSZ, '1234'))
+            except:
+                return None
+            return cr
+        cr = ioctl_GWINSZ(0) or ioctl_GWINSZ(1) or ioctl_GWINSZ(2)
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
+
 class StdinMgr:
     def __init__(self):
         self.stdinbackup = None
@@ -145,23 +251,26 @@ class StdinMgr:
             termios.tcsetattr(self.fd, termios.TCSANOW, new)
 
 class RtLogLevel:
-    def __init__(self, handler, logfilter, mlt):
+    def __init__(self, handler, logfilter, mlt, tf):
         self.displaytail = False
         self.handler = handler
         self.logfilter = logfilter
         self.defaultLevel = logfilter.getFiltLevel()
         self.mlt = mlt
+        self.tf = tf
 
     def displayLogs(self):
         if self.displaytail:
             self.mlt.displayLogs()
 
     def setLevel(self, input, verbose):
-        if input == "1":
+        if input == "1" or input == "0":
             if verbose:
                 print "NOTE: Turning off real time log tail"
             self.logfilter.setFiltLevel(self.handler, self.defaultLevel)
             self.displaytail = False
+            if input == "0" and isinstance(self.tf, TerminalFilter):
+                self.tf.setNormalMode()
         elif input == "2":
             if verbose:
                 print "NOTE: Turning on real time log tail"
@@ -177,6 +286,23 @@ class RtLogLevel:
                 print "NOTE: Turning on DEBUG logging + real time log tail"
             self.logfilter.setFiltLevel(self.handler, logging.DEBUG)
             self.displaytail = True
+        elif input == "t":
+            if verbose:
+                print "NOTE: Activing task \"top\" mode"
+            if isinstance(self.tf, TerminalFilter):
+                self.tf.setTopMode()
+        elif input == "h":
+            print "============================================="
+            print "Interaction help commands:"
+            print " 0 - default with default logs"
+            print " 1 - turn off real time log tail"
+            print " 2 - turn on real time log tail"
+            print " 3 - turn on debug logging"
+            print " 4 - turn on debug logging and real time log tail"
+            print " t - Display tasks in \"top\" mode (formerly knotty2 mode)"
+            print " h - display commands"
+            return False
+        return True
 
 def main(server, eventHandler, tf = TerminalFilter):
 
@@ -201,10 +327,6 @@ def main(server, eventHandler, tf = TerminalFilter):
     console = logging.StreamHandler(sys.stdout)
     format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
     logfilter = bb.msg.addDefaultlogFilter(console)
-    rtloglevel = RtLogLevel(console, logfilter, mlt)
-    bb_rt_loglevel = server.runCommand(["getVariable", "BB_RT_LOGLEVEL"])
-    if bb_rt_loglevel and bb_rt_loglevel != "":
-        rtloglevel.setLevel(bb_rt_loglevel, False)
     console.setFormatter(format)
     logger.addHandler(console)
     if consolelogfile:
@@ -241,14 +363,20 @@ def main(server, eventHandler, tf = TerminalFilter):
     termfilter = tf(main, helper, console, format)
     stdin_mgr = StdinMgr()
 
+    rtloglevel = RtLogLevel(console, logfilter, mlt, termfilter)
+    bb_rt_loglevel = server.runCommand(["getVariable", "BB_RT_LOGLEVEL"])
+    if bb_rt_loglevel and bb_rt_loglevel != "":
+        for inputkey in bb_rt_loglevel:
+            rtloglevel.setLevel(inputkey, False)
     while True:
         try:
             termfilter.updateFooter()
             event = eventHandler.waitEvent(0.25)
             if stdin_mgr.poll():
                 keyinput = sys.stdin.read(1)
-                rtloglevel.setLevel(keyinput, True)
-                termfilter.updateFooterForce()
+                termfilter.clearFooter()
+                if (rtloglevel.setLevel(keyinput, True)):
+                    termfilter.updateFooterForce()
                 sys.stdout.flush()
 
             # Always try printing any accumulated log files first
-- 
1.7.10



