Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8r-0003Tw-O1
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:50:14 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbYZa009868
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:34 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:33 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:49 -0500
Message-ID: <1347921831-60604-3-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1347921831-60604-1-git-send-email-jason.wessel@windriver.com>
References: <1347921831-60604-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/4] event.py, knotty.py, ncurses.py, runningbuild.py: Add support for LogExecTTY event
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
X-List-Received-Date: Mon, 17 Sep 2012 22:50:14 -0000
Content-Type: text/plain

The LogExecTTY even is intended to provide the ability to spawn a task
on a the controlling tty, if a tty is availble.  When a controlling
tty is not availble the previous behavior is preserved where a warning
is issued about the action an end user must execute.

All the available UI's were tested against the new event type.

This feature is primarily intended for hooking up a screen client
session automatically on the controlling tty to allow for a more
streamlined end user experience when using a pure command line driven
environment.  The changes that send the LogExecTTY event are in the
oe-core side.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 lib/bb/event.py                  |    9 +++++++++
 lib/bb/ui/crumbs/runningbuild.py |   15 +++++++++++++++
 lib/bb/ui/knotty.py              |   19 +++++++++++++++++++
 lib/bb/ui/ncurses.py             |    2 ++
 4 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index ab62d4d..e62f2f8 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -509,6 +509,15 @@ class MsgFatal(MsgBase):
 class MsgPlain(MsgBase):
     """General output"""
 
+class LogExecTTY(Event):
+    """Send event containing program to spawn on tty of the logger"""
+    def __init__(self, msg, prog, sleep_delay, retries):
+        Event.__init__(self)
+        self.msg = msg
+        self.prog = prog
+        self.sleep_delay = sleep_delay
+        self.retries = retries
+
 class LogHandler(logging.Handler):
     """Dispatch logging messages as bitbake events"""
 
diff --git a/lib/bb/ui/crumbs/runningbuild.py b/lib/bb/ui/crumbs/runningbuild.py
index a57d6db..700fd65 100644
--- a/lib/bb/ui/crumbs/runningbuild.py
+++ b/lib/bb/ui/crumbs/runningbuild.py
@@ -375,6 +375,21 @@ class RunningBuild (gobject.GObject):
                     msg += ("%s\n" % reason)
             self.emit("no-provider", msg)
             self.emit("log", msg)
+        elif isinstance(event, bb.event.LogExecTTY):
+            icon = "dialog-warning"
+            color = HobColors.WARNING
+            if self.sequential or not parent:
+                tree_add = self.model.append
+            else:
+                tree_add = self.model.prepend
+            tree_add(parent,
+                     (None,
+                      package,
+                      task,
+                      event.msg,
+                      icon,
+                      color,
+                      0))
         else:
             if not isinstance(event, (bb.event.BuildBase,
                                       bb.event.StampUpdate,
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 858cacf..d81ad5d 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -27,6 +27,7 @@ import logging
 import progressbar
 import signal
 import bb.msg
+import time
 import fcntl
 import struct
 import copy
@@ -216,6 +217,10 @@ def main(server, eventHandler, tf = TerminalFilter):
     includelogs = server.runCommand(["getVariable", "BBINCLUDELOGS"])
     loglines = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
     consolelogfile = server.runCommand(["getVariable", "BB_CONSOLELOG"])
+    if sys.stdin.isatty() and sys.stdout.isatty():
+        log_exec_tty = True
+    else:
+        log_exec_tty = False
 
     helper = uihelper.BBUIHelper()
 
@@ -271,6 +276,20 @@ def main(server, eventHandler, tf = TerminalFilter):
                 if not main.shutdown:
                     main.shutdown = 1
 
+            if isinstance(event, bb.event.LogExecTTY):
+                if log_exec_tty:
+                    tries = event.retries
+                    while tries:
+                        print "Trying to run: %s" % event.prog
+                        if os.system(event.prog) == 0:
+                            break
+                        time.sleep(event.sleep_delay)
+                        tries -= 1
+                    if tries:
+                        continue
+                logger.warn(event.msg)
+                continue
+
             if isinstance(event, logging.LogRecord):
                 if event.levelno >= format.ERROR:
                     errors = errors + 1
diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index f573b95..f6ea7f9 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -318,6 +318,8 @@ class NCursesUI:
                 if isinstance(event, bb.cooker.CookerExit):
                     exitflag = True
 
+                if isinstance(event, bb.event.LogExecTTY):
+                    mw.appendText('WARN: ' + event.msg + '\n')
                 if helper.needUpdate:
                     activetasks, failedtasks = helper.getTasks()
                     taw.erase()
-- 
1.7.1



