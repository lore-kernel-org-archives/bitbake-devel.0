Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RUIhP-0004rT-3V for bitbake-devel@lists.openembedded.org;
	Sat, 26 Nov 2011 14:53:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAQDlCrM013493
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Nov 2011 13:47:12 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 13310-04 for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Nov 2011 13:47:07 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pAQDl2h5013487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 26 Nov 2011 13:47:03 GMT
Message-ID: <1322315230.25382.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sat, 26 Nov 2011 13:47:10 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [RFC PATCH] ui/knotty: Add a footer to the build output for interactive terminals
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
X-List-Received-Date: Sat, 26 Nov 2011 13:53:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On terminals which support it, add summary information to the end of the
build output about the number of tasks currently running and how many tasks
we've run so far.

This provides a summary at a glace of what the current state of the build is
and what the build is currently doing which is lacking in the current UI.

Also disable echo of characters on stdin since this corrupts the disable,
particularly Crtl+C.

The "waiting for X tasks" code can be merged into this code too since
that is only useful on interactive terminals and this improves the
readability of that output too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---

This is something I've been experimenting with. I'd appreciate feedback
on whether people feel this is an improvement over the current terminal
output. Currently the existing output continues to scroll above the
footer. We could cut down on the number of log messages going there
though so warnings and errors would become more visible. Full logs would
remain in the BB_CONSOLELOG file on disk for reference.

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 7c645ad..0f50ce4 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -31,6 +31,25 @@ from bb.ui import uihelper
 logger = logging.getLogger("BitBake")
 interactive = sys.stdout.isatty()
 
+cuu = None
+stdinbackup = None
+if interactive:
+    import curses
+    import termios
+    import copy
+    try:
+        fd = sys.stdin.fileno()
+        stdinbackup = termios.tcgetattr(fd)
+        new = copy.deepcopy(stdinbackup)
+        new[3] = new[3] & ~termios.ECHO
+        termios.tcsetattr(fd, termios.TCSADRAIN, new)
+        curses.setupterm()
+        ed = curses.tigetstr("ed")
+        if ed:
+            cuu = curses.tigetstr("cuu")
+    except:
+        cuu = None
+
 class BBProgress(progressbar.ProgressBar):
     def __init__(self, msg, maxval):
         self.msg = msg
@@ -99,21 +124,49 @@ def main(server, eventHandler):
     cacheprogress = None
     shutdown = 0
     return_value = 0
+    main.footer_present = False
+    main.footer_update = True
+
+    def updateFooter():
+        if not main.footer_update:
+            return
+        if main.footer_present:
+            clearFooter()
+        if not cuu:
+            return
+        activetasks = helper.running_tasks
+        failedtasks = helper.failed_tasks
+        if not activetasks:
+            return
+        lines = 1
+        if shutdown:
+            print("Waiting for %s running tasks to finish:" % len(activetasks))
+        else:
+            print("Currently %s running tasks (%s of %s):" % (len(activetasks), helper.tasknumber_current, helper.tasknumber_total))
+        for tasknum, task in enumerate(activetasks):
+            print("%s: %s (pid %s)" % (tasknum, activetasks[task]["title"], task))
+            lines = lines + 1
+        main.footer_present = lines
+
+    def clearFooter():
+        if main.footer_present:
+            lines = main.footer_present
+            sys.stdout.write(curses.tparm(cuu, lines))
+            sys.stdout.write(curses.tparm(ed))
+        main.footer_present = False
+        main.footer_update = True
+
     while True:
         try:
+            updateFooter()
             event = eventHandler.waitEvent(0.25)
             if event is None:
                 continue
+            clearFooter()
             helper.eventHandler(event)
             if isinstance(event, bb.runqueue.runQueueExitWait):
                 if not shutdown:
                     shutdown = 1
-            if shutdown and helper.needUpdate:
-                activetasks, failedtasks = helper.getTasks()
-                if activetasks:
-                    print("Waiting for %s active tasks to finish:" % len(activetasks))
-                    for tasknum, task in enumerate(activetasks):
-                        print("%s: %s (pid %s)" % (tasknum, activetasks[task]["title"], task))
 
             if isinstance(event, logging.LogRecord):
                 if event.levelno >= format.ERROR:
@@ -246,10 +299,12 @@ def main(server, eventHandler):
             logger.error("Unknown event: %s", event)
 
         except EnvironmentError as ioerror:
+            clearFooter()
             # ignore interrupted io
             if ioerror.args[0] == 4:
                 pass
         except KeyboardInterrupt:
+            clearFooter()
             if shutdown == 2:
                 print("\nThird Keyboard Interrupt, exit.\n")
                 break
@@ -261,4 +316,6 @@ def main(server, eventHandler):
                 server.runCommand(["stateShutdown"])
             shutdown = shutdown + 1
             pass
+    if stdinbackup:
+        termios.tcsetattr(fd, termios.TCSADRAIN, stdinbackup)
     return return_value




