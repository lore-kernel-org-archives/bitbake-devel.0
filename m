Return-Path: <cristiana.voicu@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id C22B96065F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Aug 2013 17:04:16 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 23 Aug 2013 10:01:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,943,1367996400"; d="scan'208";a="367485798"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.72])
	by orsmga001.jf.intel.com with ESMTP; 23 Aug 2013 10:03:56 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Aug 2013 20:07:09 +0300
Message-Id: <1377277629-767-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] bitbake: add ui event handlers filtering
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
X-List-Received-Date: Fri, 23 Aug 2013 17:04:16 -0000

Implement the filtering of the ui handlers in event.py.
Created a command to set a mask for filtering and called it from
knotty. In the future this will be called from other UIs too.

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/command.py        |    5 +++++
 bitbake/lib/bb/event.py          |   22 +++++++++++++++++-----
 bitbake/lib/bb/server/process.py |    5 ++++-
 bitbake/lib/bb/server/xmlrpc.py  |    8 ++++++--
 bitbake/lib/bb/ui/knotty.py      |   11 +++++++++++
 5 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 33a2440..19a08bc 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -240,6 +240,11 @@ class CommandsSync:
         name = params[0]
         command.cooker.createConfigFile(name)
 
+    def setEventMask(self, command, params):
+        handlerNum = params[0]
+        mask = params[1]
+        return bb.event.set_UIHmask(handlerNum, mask)
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 8ffd2c3..eda937a 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -142,9 +142,9 @@ def fire_ui_handlers(event, d):
              # which xmlrpc's marshaller does not. Events *must* be serializable
              # by pickle.
              if hasattr(_ui_handlers[h].event, "sendpickle"):
-                _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
+                 _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
              else:
-                _ui_handlers[h].event.send(event)
+                 _ui_handlers[h].event.send(event)
         except:
             errors.append(h)
     for h in errors:
@@ -193,7 +193,7 @@ def register(name, handler, mask=[]):
         else:
             _handlers[name] = handler
 
-        if not mask:
+        if not mask or '*' in mask:
             _catchall_handlers[name] = True
         else:
             for m in mask:
@@ -225,7 +225,7 @@ class UIEventFilter(object):
         self.update(None, level, debug_domains)
 
     def update(self, eventmask, level, debug_domains):
-        self.eventmask = None
+        self.eventmask = eventmask
         self.stdlevel = level
         self.debug_domains = debug_domains
 
@@ -236,9 +236,21 @@ class UIEventFilter(object):
             if event.name in self.debug_domains and event.levelno >= self.debug_domains[event.name]:
                 return True
             return False
-        # Implement other event masking here on self.eventmask
+        eid = str(event.__class__)[8:-2]
+        if eid not in self.eventmask:
+            return False
         return True
 
+def set_UIHmask(handlerNum, mask):
+    if not handlerNum in _ui_handlers:
+        return False
+    level, debug_domains = bb.msg.constructLogOptions()
+    if '*' in mask:
+        _ui_logfilters[handlerNum].update(None, level, debug_domains)
+    else:
+        _ui_logfilters[handlerNum].update(mask, level, debug_domains)
+    return True
+
 def getName(e):
     """Returns the name of a class or class instance"""
     if getattr(e, "__name__", None) == None:
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 0d4a26c..4e584fc 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -137,7 +137,10 @@ class ProcessServer(Process, BaseImplServer):
         """
         Run a cooker command on the server
         """
-        self.command_channel.send(self.cooker.command.runCommand(command))
+        if command[0] == "setEventMask":
+            self.command_channel.send(self.cooker.command.runCommand(["setEventMask", self.event_handle, command[1]]))
+        else:
+            self.command_channel.send(self.cooker.command.runCommand(command))
 
     def stop(self):
         self.keep_running.clear()
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 026415e..2ae562b 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -81,7 +81,8 @@ class BitBakeServerCommands():
         """
         s, t = _create_server(host, port)
 
-        return bb.event.register_UIHhandler(s)
+        self.event_handle = bb.event.register_UIHhandler(s)
+        return self.event_handle
 
     def unregisterEventHandler(self, handlerNum):
         """
@@ -93,7 +94,10 @@ class BitBakeServerCommands():
         """
         Run a cooker command on the server
         """
-        return self.cooker.command.runCommand(command, self.server.readonly)
+        if command[0] == "setEventMask":
+            return self.cooker.command.runCommand(["setEventMask", self.event_handle, command[1]], self.server.readonly)
+        else:
+            return self.cooker.command.runCommand(command, self.server.readonly)
 
     def terminateServer(self):
         """
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 09ad99e..94f9f10 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -232,6 +232,15 @@ def _log_settings_from_server(server):
         raise BaseException(error)
     return includelogs, loglines, consolelogfile
 
+_evt_list = [ "bb.runqueue.runQueueExitWait", "bb.event.LogExecTTY", "logging.LogRecord",
+              "bb.build.TaskFailed", "bb.build.TaskBase", "bb.event.ParseStarted",
+              "bb.event.ParseProgress", "bb.event.ParseCompleted", "bb.event.CacheLoadStarted",
+              "bb.event.CacheLoadProgress", "bb.event.CacheLoadCompleted", "bb.command.CommandFailed",
+              "bb.command.CommandExit", "bb.command.CommandCompleted",  "bb.cooker.CookerExit",
+              "bb.event.MultipleProviders", "bb.event.NoProvider", "bb.runqueue.sceneQueueTaskStarted",
+              "bb.runqueue.runQueueTaskStarted", "bb.runqueue.runQueueTaskFailed", "bb.runqueue.sceneQueueTaskFailed",
+              "bb.event.BuildBase", "bb.build.TaskStarted", "bb.build.TaskSucceeded", "bb.build.TaskFailedSilent"]
+
 def main(server, eventHandler, params, tf = TerminalFilter):
 
     includelogs, loglines, consolelogfile = _log_settings_from_server(server)
@@ -262,6 +271,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         consolelog.setFormatter(conlogformat)
         logger.addHandler(consolelog)
 
+    server.runCommand(["setEventMask", _evt_list])
+
     if not params.observe_only:
         params.updateFromServer(server)
         cmdline = params.parseActions()
-- 
1.7.9.5


