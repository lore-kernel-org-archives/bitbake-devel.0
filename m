Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S8Jj8-0007Qu-5j; Fri, 16 Mar 2012 00:04:58 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2FMuB05029135;
	Thu, 15 Mar 2012 22:56:11 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 28249-08; Thu, 15 Mar 2012 22:56:07 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2FMu4dv029129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Mar 2012 22:56:05 GMT
Message-ID: <1331852164.18586.166.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>, openembedded-core
	<openembedded-core@lists.openembedded.org>
Date: Thu, 15 Mar 2012 22:56:04 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] ui/knotty: Add a footer to the build output for interactive terminals
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
X-List-Received-Date: Thu, 15 Mar 2012 23:04:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I've sent this before, this is an updated version with several bugfixes
and improvements. Its a major change but one I think people will like
overall as I hear a lot of complaints about the verbose console
messages. v0 never got complaints so I will merge this fairly quickly
unless there are objections.

---
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

Improvements since v0:

* The tasks are ordered in execution order.
* The display is only updated when the list of tasks changes or there
  is output above the footer.
* Errors early in the init process don't corrupt the terminal
* Running task x of y and package messages are suppressed from the console

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 14989d4..4a7e6b9 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -72,6 +72,26 @@ def pluralise(singular, plural, qty):
 
 def main(server, eventHandler):
 
+    cuu = None
+    stdinbackup = None
+
+    if interactive:
+        import curses
+        import termios
+        import copy
+        try:
+            fd = sys.stdin.fileno()
+            stdinbackup = termios.tcgetattr(fd)
+            new = copy.deepcopy(stdinbackup)
+            new[3] = new[3] & ~termios.ECHO
+            termios.tcsetattr(fd, termios.TCSADRAIN, new)
+            curses.setupterm()
+            ed = curses.tigetstr("ed")
+            if ed:
+                cuu = curses.tigetstr("cuu")
+        except:
+            cuu = None
+
     # Get values of variables which control our output
     includelogs = server.runCommand(["getVariable", "BBINCLUDELOGS"])
     loglines = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
@@ -115,8 +135,56 @@ def main(server, eventHandler):
     errors = 0
     warnings = 0
     taskfailures = []
+    main.footer_present = False
+    main.lastpids = []
+
+    def updateFooter():
+        if not cuu:
+            return
+        activetasks = helper.running_tasks
+        failedtasks = helper.failed_tasks
+        runningpids = helper.running_pids
+        if main.footer_present and (main.lastpids == runningpids):
+            return
+        if main.footer_present:
+            clearFooter()
+        if not activetasks:
+            return
+        lines = 1
+        tasks = []
+        for t in runningpids:
+            tasks.append("%s (pid %s)" % (activetasks[t]["title"], t))
+
+        if shutdown:
+            print("Waiting for %s running tasks to finish:" % len(activetasks))
+        else:
+            print("Currently %s running tasks (%s of %s):" % (len(activetasks), helper.tasknumber_current, helper.tasknumber_total))
+        for tasknum, task in enumerate(tasks):
+            print("%s: %s" % (tasknum, task))
+            lines = lines + 1
+        main.footer_present = lines
+        main.lastpids = runningpids[:]
+
+    def clearFooter():
+        if main.footer_present:
+            lines = main.footer_present
+            sys.stdout.write(curses.tparm(cuu, lines))
+            sys.stdout.write(curses.tparm(ed))
+        main.footer_present = False
+
+    class InteractConsoleLogFilter(logging.Filter):
+        def filter(self, record):
+            if record.levelno == format.NOTE and (record.msg.startswith("Running") or record.msg.startswith("package ")):
+                return False
+            clearFooter()
+            return True
+
+    if interactive:
+        console.addFilter(InteractConsoleLogFilter())
+
     while True:
         try:
+            updateFooter()
             event = eventHandler.waitEvent(0.25)
             if event is None:
                 if shutdown > 1:
@@ -126,12 +194,6 @@ def main(server, eventHandler):
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
@@ -151,6 +213,7 @@ def main(server, eventHandler):
                 return_value = 1
                 logfile = event.logfile
                 if logfile and os.path.exists(logfile):
+                    clearFooter()
                     print("ERROR: Logfile of failure stored in: %s" % logfile)
                     if includelogs and not event.errprinted:
                         print("Log data follows:")
@@ -281,10 +344,12 @@ def main(server, eventHandler):
             logger.error("Unknown event: %s", event)
 
         except EnvironmentError as ioerror:
+            clearFooter()
             # ignore interrupted io
             if ioerror.args[0] == 4:
                 pass
         except KeyboardInterrupt:
+            clearFooter()
             if shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
                 server.runCommand(["stateStop"])
@@ -315,4 +380,6 @@ def main(server, eventHandler):
         if return_value == 0:
             return_value = 1
 
+    if stdinbackup:
+        termios.tcsetattr(fd, termios.TCSADRAIN, stdinbackup)
     return return_value
diff --git a/bitbake/lib/bb/ui/uihelper.py b/bitbake/lib/bb/ui/uihelper.py
index c96f381..2c78695 100644
--- a/bitbake/lib/bb/ui/uihelper.py
+++ b/bitbake/lib/bb/ui/uihelper.py
@@ -23,6 +23,8 @@ class BBUIHelper:
     def __init__(self):
         self.needUpdate = False
         self.running_tasks = {}
+        # Running PIDs preserves the order tasks were executed in
+        self.running_pids = []
         self.failed_tasks = []
         self.tasknumber_current = 0
         self.tasknumber_total = 0
@@ -30,16 +32,20 @@ class BBUIHelper:
     def eventHandler(self, event):
         if isinstance(event, bb.build.TaskStarted):
             self.running_tasks[event.pid] = { 'title' : "%s %s" % (event._package, event._task) }
+            self.running_pids.append(event.pid)
             self.needUpdate = True
         if isinstance(event, bb.build.TaskSucceeded):
             del self.running_tasks[event.pid]
+            self.running_pids.remove(event.pid)
             self.needUpdate = True
         if isinstance(event, bb.build.TaskFailedSilent):
             del self.running_tasks[event.pid]
+            self.running_pids.remove(event.pid)
             # Don't add to the failed tasks list since this is e.g. a setscene task failure
             self.needUpdate = True
         if isinstance(event, bb.build.TaskFailed):
             del self.running_tasks[event.pid]
+            self.running_pids.remove(event.pid)
             self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
             self.needUpdate = True
         if isinstance(event, bb.runqueue.runQueueTaskStarted):




