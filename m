Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]
	helo=tx2outboundpool.messaging.microsoft.com)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <B29882@freescale.com>) id 1TUMRx-00046T-Vx
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Nov 2012 19:58:38 +0100
Received: from mail123-tx2-R.bigfish.com (10.9.14.235) by
	TX2EHSOBE003.bigfish.com (10.9.40.23) with Microsoft SMTP Server id
	14.1.225.23; Fri, 2 Nov 2012 17:59:42 +0000
Received: from mail123-tx2 (localhost [127.0.0.1])	by
	mail123-tx2-R.bigfish.com (Postfix) with ESMTP id 0AC884E0374	for
	<bitbake-devel@lists.openembedded.org>;
	Fri,  2 Nov 2012 17:59:42 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:70.37.183.190; KIP:(null); UIP:(null); IPV:NLI;
	H:mail.freescale.net; RD:none; EFVD:NLI
X-SpamScore: 3
X-BigFish: VS3(zzzz1de0h1202h1d1ah1d2ah1082kzz8275bh8275dhz2dh2a8h668h839hd24he5bhf0ah1288h12a5h12a9h12bdh12e5h137ah139eh13b6h1441h1504h1537h1155h)
Received: from mail123-tx2 (localhost.localdomain [127.0.0.1]) by mail123-tx2
	(MessageSwitch) id 1351879179785454_21730;
	Fri,  2 Nov 2012 17:59:39 +0000 (UTC)
Received: from TX2EHSMHS024.bigfish.com (unknown [10.9.14.249])	by
	mail123-tx2.bigfish.com (Postfix) with ESMTP id BB6044A0088	for
	<bitbake-devel@lists.openembedded.org>;
	Fri,  2 Nov 2012 17:59:39 +0000 (UTC)
Received: from mail.freescale.net (70.37.183.190) by TX2EHSMHS024.bigfish.com
	(10.9.99.124) with Microsoft SMTP Server (TLS) id 14.1.225.23;
	Fri, 2 Nov 2012 17:59:39 +0000
Received: from tx30smr01.am.freescale.net (10.81.153.31) by
	039-SN1MMR1-005.039d.mgd.msft.net (10.84.1.17) with Microsoft SMTP
	Server (TLS) id 14.2.318.3; Fri, 2 Nov 2012 17:59:38 +0000
Received: from right.am.freescale.net (right.am.freescale.net [10.82.176.228])
	by tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id
	qA2HxZmb023666 for <bitbake-devel@lists.openembedded.org>;
	Fri, 2 Nov 2012 10:59:38 -0700
From: Matthew McClintock <msm@freescale.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 2 Nov 2012 12:59:34 -0500
Message-ID: <1351879174-28423-1-git-send-email-msm@freescale.com>
X-Mailer: git-send-email 1.7.9.7
MIME-Version: 1.0
X-OriginatorOrg: freescale.com
Subject: [for-1.16] command: add error to return of runCommand
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
X-List-Received-Date: Fri, 02 Nov 2012 18:58:38 -0000
Content-Type: text/plain

From: Christopher Larson <chris_larson@mentor.com>

Currently, command.py can return an error message from runCommand, due to
being unable to run the command, yet few of our UIs (just hob) can handle it
today. This can result in seeing a TypeError with traceback in certain rare
circumstances.

To resolve this, we need a clean way to get errors back from runCommand,
without having to isinstance() the return value. This implements such a thing
by making runCommand also return an error (or None if no error occurred).

As runCommand now has a method of returning errors, we can also alter the
getCmdLineAction bits such that the returned value is just the action, not an
additional message. If a sync command wants to return an error, it raises
CommandError(message), and the message will be passed to the caller
appropriately.

Example Usage:

    result, error = server.runCommand(...)
    if error:
        log.error('Unable to run command: %s' % error)
        return 1

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py                   |   43 ++++++++++++++++++++------------
 lib/bb/server/process.py            |    2 +-
 lib/bb/ui/crumbs/hobeventhandler.py |   10 +++-----
 lib/bb/ui/depexp.py                 |   38 +++++++++++++++++++----------
 lib/bb/ui/goggle.py                 |   17 +++++++------
 lib/bb/ui/knotty.py                 |   46 ++++++++++++++++++++++++-----------
 lib/bb/ui/ncurses.py                |   21 ++++++++++------
 7 files changed, 112 insertions(+), 65 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 27b5171..3f28bca 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -44,6 +44,9 @@ class CommandFailed(CommandExit):
         self.error = message
         CommandExit.__init__(self, 1)
 
+class CommandError(Exception):
+    pass
+
 class Command:
     """
     A queue of asynchronous commands for bitbake
@@ -57,21 +60,25 @@ class Command:
         self.currentAsyncCommand = None
 
     def runCommand(self, commandline):
-        try:
-            command = commandline.pop(0)
-            if command in CommandsSync.__dict__:
-                # Can run synchronous commands straight away
-                return getattr(CommandsSync, command)(self.cmds_sync, self, commandline)
-            if self.currentAsyncCommand is not None:
-                return "Busy (%s in progress)" % self.currentAsyncCommand[0]
-            if command not in CommandsAsync.__dict__:
-                return "No such command"
-            self.currentAsyncCommand = (command, commandline)
-            self.cooker.server_registration_cb(self.cooker.runCommands, self.cooker)
-            return True
-        except:
-            import traceback
-            return traceback.format_exc()
+        command = commandline.pop(0)
+        if hasattr(CommandsSync, command):
+            # Can run synchronous commands straight away
+            command_method = getattr(self.cmds_sync, command)
+            try:
+                result = command_method(self, commandline)
+            except CommandError as exc:
+                return None, exc.args[0]
+            except Exception:
+                return None, traceback.format_exc()
+            else:
+                return result, None
+        if self.currentAsyncCommand is not None:
+            return None, "Busy (%s in progress)" % self.currentAsyncCommand[0]
+        if command not in CommandsAsync.__dict__:
+            return None, "No such command"
+        self.currentAsyncCommand = (command, commandline)
+        self.cooker.server_registration_cb(self.cooker.runCommands, self.cooker)
+        return True, None
 
     def runAsyncCommand(self):
         try:
@@ -139,7 +146,11 @@ class CommandsSync:
         """
         Get any command parsed from the commandline
         """
-        return command.cooker.commandlineAction
+        cmd_action = command.cooker.commandlineAction
+        if cmd_action['msg']:
+            raise CommandError(msg)
+        else:
+            return cmd_action['action']
 
     def getVariable(self, command, params):
         """
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index ba91336..3ae9ede 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -48,7 +48,7 @@ class ServerCommunicator():
                 if self.connection.poll(.5):
                     return self.connection.recv()
                 else:
-                    return None
+                    return None, "Timeout while attempting to communicate with bitbake server"
             except KeyboardInterrupt:
                 pass
 
diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 5d038f4..82ebc7d 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -101,13 +101,9 @@ class HobHandler(gobject.GObject):
 
     def runCommand(self, commandline):
         try:
-            result = self.server.runCommand(commandline)
-            result_str = str(result)
-            if (result_str.startswith("Busy (") or
-                    result_str == "No such command"):
-                raise Exception('%s has failed with output "%s". ' %
-                        (str(commandline), result_str) +
-                        "We recommend that you restart Hob.")
+            result, error = self.server.runCommand(commandline)
+            if error:
+                raise Exception("Error running command '%s': %s" % (commandline, error))
             return result
         except Exception as e:
             self.commands_async = []
diff --git a/lib/bb/ui/depexp.py b/lib/bb/ui/depexp.py
index 1a716a8..85910f6 100644
--- a/lib/bb/ui/depexp.py
+++ b/lib/bb/ui/depexp.py
@@ -198,17 +198,23 @@ class gtkthread(threading.Thread):
 
 def main(server, eventHandler):
     try:
-        cmdline = server.runCommand(["getCmdLineAction"])
-        if cmdline and not cmdline['action']:
-            print(cmdline['msg'])
-            return
-        elif not cmdline or (cmdline['action'] and cmdline['action'][0] != "generateDotGraph"):
+        cmdline, error = server.runCommand(["getCmdLineAction"])
+        if error:
+            print("Error getting bitbake commandline: %s" % error)
+            return 1
+        elif not cmdline:
+            print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
+            return 1
+        elif not cmdline or cmdline[0] != "generateDotGraph":
             print("This UI is only compatible with the -g option")
-            return
-        ret = server.runCommand(["generateDepTreeEvent", cmdline['action'][1], cmdline['action'][2]])
-        if ret != True:
-            print("Couldn't run command! %s" % ret)
-            return
+            return 1
+        ret, error = server.runCommand(["generateDepTreeEvent", cmdline[1], cmdline[2]])
+        if error:
+            print("Error running command '%s': %s" % (cmdline, error))
+            return 1
+        elif ret != True:
+            print("Error running command '%s': returned %s" % (cmdline, ret))
+            return 1
     except xmlrpclib.Fault as x:
         print("XMLRPC Fault getting commandline:\n %s" % x)
         return
@@ -234,7 +240,9 @@ def main(server, eventHandler):
         try:
             event = eventHandler.waitEvent(0.25)
             if gtkthread.quit.isSet():
-                server.runCommand(["stateStop"])
+                _, error = server.runCommand(["stateStop"])
+                if error:
+                    print('Unable to cleanly stop: %s' % error)
                 break
 
             if event is None:
@@ -310,9 +318,13 @@ def main(server, eventHandler):
                 break
             if shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
-                server.runCommand(["stateStop"])
+                _, error = server.runCommand(["stateStop"])
+                if error:
+                    print('Unable to cleanly stop: %s' % error)
             if shutdown == 0:
                 print("\nKeyboard Interrupt, closing down...\n")
-                server.runCommand(["stateShutdown"])
+                _, error = server.runCommand(["stateShutdown"])
+                if error:
+                    print('Unable to cleanly shutdown: %s' % error)
             shutdown = shutdown + 1
             pass
diff --git a/lib/bb/ui/goggle.py b/lib/bb/ui/goggle.py
index b2fd274..c0785b7 100644
--- a/lib/bb/ui/goggle.py
+++ b/lib/bb/ui/goggle.py
@@ -80,16 +80,19 @@ def main (server, eventHandler):
     running_build.connect ("build-failed", running_build_failed_cb)
 
     try:
-        cmdline = server.runCommand(["getCmdLineAction"])
-        if not cmdline:
+        cmdline, error = server.runCommand(["getCmdLineAction"])
+        if err:
+            print("Error getting bitbake commandline: %s" % error)
+            return 1
+        elif not cmdline:
             print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
             return 1
-        elif not cmdline['action']:
-            print(cmdline['msg'])
+        ret, error = server.runCommand(cmdline)
+        if error:
+            print("Error running command '%s': %s" % (cmdline, error))
             return 1
-        ret = server.runCommand(cmdline['action'])
-        if ret != True:
-            print("Couldn't get default commandline! %s" % ret)
+        elif ret != True:
+            print("Error running command '%s': returned %s" % (cmdline, ret))
             return 1
     except xmlrpclib.Fault as x:
         print("XMLRPC Fault getting commandline:\n %s" % x)
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 3799018..8c63d74 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -217,9 +217,19 @@ class TerminalFilter(object):
 def main(server, eventHandler, tf = TerminalFilter):
 
     # Get values of variables which control our output
-    includelogs = server.runCommand(["getVariable", "BBINCLUDELOGS"])
-    loglines = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
-    consolelogfile = server.runCommand(["getVariable", "BB_CONSOLELOG"])
+    includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
+    if error:
+        logger.error("Unable to get the value of BBINCLUDELOGS variable: %s" % error)
+        return 1
+    loglines, error = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
+    if error:
+        logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
+        return 1
+    consolelogfile, error = server.runCommand(["getVariable", "BB_CONSOLELOG"])
+    if error:
+        logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
+        return 1
+
     if sys.stdin.isatty() and sys.stdout.isatty():
         log_exec_tty = True
     else:
@@ -240,19 +250,22 @@ def main(server, eventHandler, tf = TerminalFilter):
         logger.addHandler(consolelog)
 
     try:
-        cmdline = server.runCommand(["getCmdLineAction"])
-        if not cmdline:
+        cmdline, error = server.runCommand(["getCmdLineAction"])
+        if error:
+            logger.error("Unable to get bitbake commandline arguments: %s" % error)
+            return 1
+        elif not cmdline:
             print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
             return 1
-        elif not cmdline['action']:
-            print(cmdline['msg'])
+        ret, error = server.runCommand(cmdline)
+        if error:
+            logger.error("Command '%s' failed: %s" % (cmdline, error))
             return 1
-        ret = server.runCommand(cmdline['action'])
-        if ret != True:
-            print("Couldn't get default commandline! %s" % ret)
+        elif ret != True:
+            logger.error("Command '%s' failed: returned %s" % (cmdline, ret))
             return 1
     except xmlrpclib.Fault as x:
-        print("XMLRPC Fault getting commandline:\n %s" % x)
+        logger.error("XMLRPC Fault getting commandline:\n %s" % x)
         return 1
 
     parseprogress = None
@@ -447,14 +460,19 @@ def main(server, eventHandler, tf = TerminalFilter):
             if ioerror.args[0] == 4:
                 pass
         except KeyboardInterrupt:
+            import time
             termfilter.clearFooter()
             if main.shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
-                server.runCommand(["stateStop"])
+                _, error = server.runCommand(["stateStop"])
+                if error:
+                    logger.error("Unable to cleanly stop: %s" % error)
             if main.shutdown == 0:
-                interrupted = True
                 print("\nKeyboard Interrupt, closing down...\n")
-                server.runCommand(["stateShutdown"])
+                interrupted = True
+                _, error = server.runCommand(["stateShutdown"])
+                if error:
+                    logger.error("Unable to cleanly shutdown: %s" % error)
             main.shutdown = main.shutdown + 1
             pass
 
diff --git a/lib/bb/ui/ncurses.py b/lib/bb/ui/ncurses.py
index f6ea7f9..98647fc 100644
--- a/lib/bb/ui/ncurses.py
+++ b/lib/bb/ui/ncurses.py
@@ -236,15 +236,18 @@ class NCursesUI:
         shutdown = 0
 
         try:
-            cmdline = server.runCommand(["getCmdLineAction"])
+            cmdline, error = server.runCommand(["getCmdLineAction"])
             if not cmdline:
                 print("Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.")
                 return
-            elif not cmdline['action']:
-                print(cmdline['msg'])
+            elif error:
+                print("Error getting bitbake commandline: %s" % error)
                 return
-            ret = server.runCommand(cmdline['action'])
-            if ret != True:
+            ret, error = server.runCommand(cmdline)
+            if error:
+                print("Error running command '%s': %s" % (cmdline, error))
+                return
+            elif ret != True:
                 print("Couldn't get default commandlind! %s" % ret)
                 return
         except xmlrpclib.Fault as x:
@@ -345,10 +348,14 @@ class NCursesUI:
                     exitflag = True
                 if shutdown == 1:
                     mw.appendText("Second Keyboard Interrupt, stopping...\n")
-                    server.runCommand(["stateStop"])
+                    _, error = server.runCommand(["stateStop"])
+                    if error:
+                        print("Unable to cleanly stop: %s" % error)
                 if shutdown == 0:
                     mw.appendText("Keyboard Interrupt, closing down...\n")
-                    server.runCommand(["stateShutdown"])
+                    _, error = server.runCommand(["stateShutdown"])
+                    if error:
+                        print("Unable to cleanly shutdown: %s" % error)
                 shutdown = shutdown + 1
                 pass
 
-- 
1.7.9.7




