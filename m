Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 8F0D061013
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Aug 2013 14:35:13 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7OEj3es018977; Sat, 24 Aug 2013 15:47:08 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id X75wRdjmrG3W; Sat, 24 Aug 2013 15:47:08 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7OEl3TM019009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sat, 24 Aug 2013 15:47:05 +0100
Message-ID: <1377354891.6762.192.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Sat, 24 Aug 2013 15:34:51 +0100
In-Reply-To: <1377278007-979-1-git-send-email-cristiana.voicu@intel.com>
References: <1377278007-979-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH_V3] bitbake: add ui event handlers filtering
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
X-List-Received-Date: Sat, 24 Aug 2013 14:35:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Add functionality to allow UIs to update and change the types of events they
recieve. To do this we need to add a new command and also need to be able
to obtain the current event hander ID. In the case of xmlrpc, this is
straightforward, in the case of the process server we need to save the result
in a multiprocessing.Value() so we can retrive it. An excplit command
was added to the server API to facilitate this.

The same function can also be used to mask or unmask specific log messages,
allowing the UI to optionally differ from the standard set of message
filtering.

Based upon work by Cristiana Voicu <cristiana.voicu@intel.com>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
Cristiana: Since we're running out of time on this, I've altered your
patch a bit to do what I believe it needs to and ensure we have strong
APIs going forward.

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 33a2440..bdf1c36 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -240,6 +240,13 @@ class CommandsSync:
         name = params[0]
         command.cooker.createConfigFile(name)
 
+    def setEventMask(self, command, params):
+        handlerNum = params[0]
+        llevel = params[1]
+        debug_domains = params[2]
+        mask = params[3]
+        return bb.event.set_UIHmask(handlerNum, llevel, debug_domains, mask)
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index 8ffd2c3..1169cbf 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
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
 
@@ -236,9 +236,20 @@ class UIEventFilter(object):
             if event.name in self.debug_domains and event.levelno >= self.debug_domains[event.name]:
                 return True
             return False
-        # Implement other event masking here on self.eventmask
+        eid = str(event.__class__)[8:-2]
+        if eid not in self.eventmask:
+            return False
         return True
 
+def set_UIHmask(handlerNum, level, debug_domains, mask):
+    if not handlerNum in _ui_handlers:
+        return False
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
index 99a6bf5..e2cec49 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -37,8 +37,9 @@ from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
 logger = logging.getLogger('BitBake')
 
 class ServerCommunicator():
-    def __init__(self, connection):
+    def __init__(self, connection, event_handle):
         self.connection = connection
+        self.event_handle = event_handle
 
     def runCommand(self, command):
         # @todo try/except
@@ -54,6 +55,8 @@ class ServerCommunicator():
             except KeyboardInterrupt:
                 pass
 
+    def getEventHandle(self):
+        return self.event_handle.value
 
 class EventAdapter():
     """
@@ -84,11 +87,12 @@ class ProcessServer(Process, BaseImplServer):
 
         self.keep_running = Event()
         self.keep_running.set()
+        self.event_handle = multiprocessing.Value("i")
 
     def run(self):
         for event in bb.event.ui_queue:
             self.event_queue.put(event)
-        self.event_handle = bb.event.register_UIHhandler(self)
+        self.event_handle.value = bb.event.register_UIHhandler(self)
         bb.cooker.server_main(self.cooker, self.main)
 
     def main(self):
@@ -106,7 +110,7 @@ class ProcessServer(Process, BaseImplServer):
                 logger.exception('Running command %s', command)
 
         self.event_queue.close()
-        bb.event.unregister_UIHhandler(self.event_handle)
+        bb.event.unregister_UIHhandler(self.event_handle.value)
         self.command_channel.close()
         self.cooker.stop()
         self.idle_commands(.1)
@@ -147,7 +151,7 @@ class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
         self.procserver = serverImpl
         self.ui_channel = ui_channel
         self.event_queue = event_queue
-        self.connection = ServerCommunicator(self.ui_channel)
+        self.connection = ServerCommunicator(self.ui_channel, self.procserver.event_handle)
         self.events = self.event_queue
 
     def terminate(self):
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index d290550..4dee5d9 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -95,7 +95,8 @@ class BitBakeServerCommands():
         """
         s, t = _create_server(host, port)
 
-        return bb.event.register_UIHhandler(s)
+        self.event_handle = bb.event.register_UIHhandler(s)
+        return self.event_handle
 
     def unregisterEventHandler(self, handlerNum):
         """
@@ -109,6 +110,9 @@ class BitBakeServerCommands():
         """
         return self.cooker.command.runCommand(command, self.server.readonly)
 
+    def getEventHandle(self):
+        return self.event_handle
+
     def terminateServer(self):
         """
         Trigger the server to quit
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 09ad99e..1692e32 100644
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
@@ -262,6 +271,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         consolelog.setFormatter(conlogformat)
         logger.addHandler(consolelog)
 
+    llevel, debug_domains = bb.msg.constructLogOptions()
+    server.runCommand(["setEventMask", server.getEventHandle(), llevel, debug_domains, _evt_list])
+
     if not params.observe_only:
         params.updateFromServer(server)
         cmdline = params.parseActions()



