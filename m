Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8k-0003RB-Hn
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:50:06 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbLYQ002003
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:21 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:21 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:36 -0500
Message-ID: <1347921818-60562-7-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
References: <1347921818-60562-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 6/8] knotty.py: Add interactive commands to knotty
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
X-List-Received-Date: Mon, 17 Sep 2012 22:50:06 -0000
Content-Type: text/plain

0 - Linear logging
1 - turn off real time log tail
2 - turn on real time log tail
3 - turn on debug logging
4 - turn on debug logging and real time log tail
t - Display tasks in "top" mode
N - Display all runtime NOTE's that are normally filtered (0 or 1 toggles off)
h - display commands

The knotty 2 functionality can be activated in realtime
by pressing "t" for top mode or reverted with "0" for
normal mode.

(LOCAL REV: NOT UPSTREAM)

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/ui/knotty.py |   75 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 5882c24..df8de0f 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -97,7 +97,7 @@ class InteractConsoleLogFilter(logging.Filter):
         self.format = format
 
     def filter(self, record):
-        if record.levelno == self.format.NOTE and (record.msg.startswith("Running") or record.msg.startswith("recipe ")):
+        if self.tf.filterOn and record.levelno == self.format.NOTE and (record.msg.startswith("Running") or record.msg.startswith("recipe ")):
             return False
         self.tf.clearFooter()
         return True
@@ -136,6 +136,8 @@ class TerminalFilter(object):
         self.main = main
         self.helper = helper
         self.cuu = None
+        self.topMode = False
+        self.filterOn = False
         self.stdinbackup = None
         self.interactive = sys.stdout.isatty()
         self.footer_present = False
@@ -170,9 +172,31 @@ class TerminalFilter(object):
             self.columns = self.getTerminalColumns()
         except:
             self.cuu = None
+        self.topMode = True
+        self.filterOn = True
         console.addFilter(InteractConsoleLogFilter(self, format))
 
+    def setTopMode(self):
+        if self.topMode:
+            return
+        self.topMode = True
+        self.setFilterOn()
+
+    def setNormalMode(self):
+        if not self.topMode:
+            return
+        self.topMode = False
+        self.setFilterOff()
+
+    def setFilterOn(self):
+        self.filterOn = True
+
+    def setFilterOff(self):
+        self.filterOn = False
+
     def clearFooter(self):
+        if not self.topMode:
+            return
         if self.footer_present:
             lines = self.footer_present
             sys.stdout.write(self.curses.tparm(self.cuu, lines))
@@ -184,7 +208,7 @@ class TerminalFilter(object):
         self.updateFooter()
 
     def updateFooter(self):
-        if not self.cuu:
+        if not self.cuu or not self.topMode:
             return
         activetasks = self.helper.running_tasks
         failedtasks = self.helper.failed_tasks
@@ -247,23 +271,29 @@ class StdinMgr:
             self.termios.tcsetattr(self.fd, self.termios.TCSANOW, new)
 
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
+            if isinstance(self.tf, TerminalFilter):
+                if input == "0":
+                    self.tf.setNormalMode()
+                else:
+                    self.tf.setTopMode()
         elif input == "2":
             if verbose:
                 print "NOTE: Turning on real time log tail"
@@ -279,6 +309,29 @@ class RtLogLevel:
                 print "NOTE: Turning on DEBUG logging + real time log tail"
             self.logfilter.setFiltLevel(self.handler, logging.DEBUG)
             self.displaytail = True
+        elif input == "t":
+            if verbose:
+                print "NOTE: Activing task \"top\" mode"
+            if isinstance(self.tf, TerminalFilter):
+                self.tf.setTopMode()
+        elif input == "N":
+            if verbose:
+                print "NOTE: Turning on task notes"
+            if isinstance(self.tf, TerminalFilter):
+                self.tf.setFilterOff()
+        elif input == "h" or input == "?":
+            print "============================================="
+            print "Interaction help commands:"
+            print " 0 - Linear logging"
+            print " 1 - turn off real time log tail"
+            print " 2 - turn on real time log tail"
+            print " 3 - turn on debug logging"
+            print " 4 - turn on debug logging and real time log tail"
+            print " t - Display tasks in \"top\" mode"
+            print " N - Display all runtime NOTE's that are normally filtered (0 or 1 toggles off)"
+            print " h - display commands"
+            return False
+        return True
 
 def main(server, eventHandler, tf = TerminalFilter):
 
@@ -303,10 +356,6 @@ def main(server, eventHandler, tf = TerminalFilter):
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
@@ -344,14 +393,20 @@ def main(server, eventHandler, tf = TerminalFilter):
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
 
             # Always try printing any accumulated log files first
             rtloglevel.displayLogs()
-- 
1.7.1



