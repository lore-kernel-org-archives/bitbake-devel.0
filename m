Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 0B6EE60FDF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 16:32:06 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DGjwDM005024 for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:45:58 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iDxpoDNa1ghZ for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:45:58 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DGjrr8005019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:45:55 +0100
Message-ID: <1379089914.3484.273.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 13 Sep 2013 17:31:54 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Rename confusing 'stop' state to 'forceshutdown'
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
X-List-Received-Date: Fri, 13 Sep 2013 16:32:07 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The shutdown state causes the server to finish what its doing, stop was
them meant to completely stop it. It doesn't mean the server is stopped
though. Renaming the current stop event for forceshutdown gives more
meaning to what it actually does. The stopped namespace then becomes
available to indicate a completely stopped server.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 3527ad0..641cc70 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -137,13 +137,13 @@ class CommandsSync:
         """
         Trigger cooker 'shutdown' mode
         """
-        command.cooker.shutdown()
+        command.cooker.shutdown(False)
 
-    def stateStop(self, command, params):
+    def stateForceShutdown(self, command, params):
         """
         Stop the cooker
         """
-        command.cooker.stop()
+        command.cooker.shutdown(True)
 
     def getVariable(self, command, params):
         """
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 7034f1d..4b2e5bf 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -61,7 +61,7 @@ class CollectionError(bb.BBHandledException):
     """
 
 class state:
-    initial, parsing, running, shutdown, stop = range(5)
+    initial, parsing, running, shutdown, forceshutdown, stopped = range(6)
 
 
 class SkippedPackage:
@@ -1044,7 +1044,7 @@ class BBCooker:
 
         def buildFileIdle(server, rq, abort):
 
-            if abort or self.state == state.stop:
+            if abort or self.state == state.forceshutdown:
                 rq.finish_runqueue(True)
             elif self.state == state.shutdown:
                 rq.finish_runqueue(False)
@@ -1081,7 +1081,7 @@ class BBCooker:
         targets = self.checkPackages(targets)
 
         def buildTargetsIdle(server, rq, abort):
-            if abort or self.state == state.stop:
+            if abort or self.state == state.forceshutdown:
                 rq.finish_runqueue(True)
             elif self.state == state.shutdown:
                 rq.finish_runqueue(False)
@@ -1170,7 +1170,7 @@ class BBCooker:
         if self.state == state.running:
             return
 
-        if self.state in (state.shutdown, state.stop):
+        if self.state in (state.shutdown, state.forceshutdown):
             self.parser.shutdown(clean=False, force = True)
             sys.exit(1)
 
@@ -1240,11 +1240,11 @@ class BBCooker:
         prserv.serv.auto_shutdown(self.data)
         bb.event.fire(CookerExit(), self.event_data)
 
-    def shutdown(self):
-        self.state = state.shutdown
-
-    def stop(self):
-        self.state = state.stop
+    def shutdown(self, force = False):
+        if force:
+            self.state = state.forceshutdown
+        else:
+            self.state = state.shutdown
 
     def initialize(self):
         self.initConfigurationData()
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index c0af052..e45e0c2 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -113,7 +113,7 @@ class ProcessServer(Process, BaseImplServer):
         self.event_queue.close()
         bb.event.unregister_UIHhandler(self.event_handle.value)
         self.command_channel.close()
-        self.cooker.stop()
+        self.cooker.shutdown(True)
         self.idle_commands(.1)
 
     def idle_commands(self, delay, fds = []):
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index d0ac6bd..ef74e56 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -440,12 +440,12 @@ class HobHandler(gobject.GObject):
         self.building = False
 
     def cancel_parse(self):
-        self.runCommand(["stateStop"])
+        self.runCommand(["stateForceShutdown"])
 
     def cancel_build(self, force=False):
         if force:
             # Force the cooker to stop as quickly as possible
-            self.runCommand(["stateStop"])
+            self.runCommand(["stateForceShutdown"])
         else:
             # Wait for tasks to complete before shutting down, this helps
             # leave the workdir in a usable state
diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index cbda6d5..0b160e2 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -314,7 +314,7 @@ def main(server, eventHandler, params):
                 break
             if shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
-                _, error = server.runCommand(["stateStop"])
+                _, error = server.runCommand(["stateForceShutdown"])
                 if error:
                     print('Unable to cleanly stop: %s' % error)
             if shutdown == 0:
diff --git a/bitbake/lib/bb/ui/goggle.py b/bitbake/lib/bb/ui/goggle.py
index 16faba4..f4ee7b4 100644
--- a/bitbake/lib/bb/ui/goggle.py
+++ b/bitbake/lib/bb/ui/goggle.py
@@ -117,5 +117,5 @@ def main (server, eventHandler, params):
     except KeyboardInterrupt:
         pass
     finally:
-        server.runCommand(["stateStop"])
+        server.runCommand(["stateForceShutdown"])
 
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 4520046..f706b97 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -499,7 +499,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 main.shutdown = 2
             if not params.observe_only and main.shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
-                _, error = server.runCommand(["stateStop"])
+                _, error = server.runCommand(["stateForceShutdown"])
                 if error:
                     logger.error("Unable to cleanly stop: %s" % error)
             if not params.observe_only and main.shutdown == 0:
diff --git a/bitbake/lib/bb/ui/ncurses.py b/bitbake/lib/bb/ui/ncurses.py
index c45ffd6..b6c20ec 100644
--- a/bitbake/lib/bb/ui/ncurses.py
+++ b/bitbake/lib/bb/ui/ncurses.py
@@ -350,7 +350,7 @@ class NCursesUI:
                     exitflag = True
                 if shutdown == 1:
                     mw.appendText("Second Keyboard Interrupt, stopping...\n")
-                    _, error = server.runCommand(["stateStop"])
+                    _, error = server.runCommand(["stateForceShutdown"])
                     if error:
                         print("Unable to cleanly stop: %s" % error)
                 if shutdown == 0:



