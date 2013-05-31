Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 1834662222
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 11:06:51 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 31 May 2013 04:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,778,1363158000"; d="scan'208";a="346127013"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by fmsmga002.fm.intel.com with ESMTP; 31 May 2013 04:06:50 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id 295FF5607B0; Fri, 31 May 2013 12:06:51 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Fri, 31 May 2013 12:06:49 +0100
Message-Id: <1369998409-16560-4-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1369998409-16560-1-git-send-email-alexandru.damian@intel.com>
References: <1369998409-16560-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/4] xmlrpc: add support for event-observer-only connection
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 31 May 2013 11:06:51 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch adds support for multiple UI clients acting only as event syncs.
Summary of changes:

bitbake: adds support for --observe-only command line parameter

xmlrpc server: create a Observer-only connection type, and small changes
to accomodate new incoming parameters

event queue: add exclusive access to structures for multithreaded
operation; this is needed by accepting new UI handlers on a different thread

knotty: support for observer-only connections

Other minor cosmetic changes to support new parameters to functions were made

Based on original patch by Bogdan Marinescu <bogdan.a.marinescu@intel.com>

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/bitbake             |  8 ++++++-
 lib/bb/event.py         | 63 ++++++++++++++++++++++++++++++++++---------------
 lib/bb/server/xmlrpc.py | 57 +++++++++++++++++++++++++++++++++++++-------
 lib/bb/ui/knotty.py     | 29 +++++++++++++----------
 lib/bb/ui/uievent.py    |  4 ++--
 5 files changed, 119 insertions(+), 42 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index d263cbd..ef0c5d8 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -197,6 +197,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("", "--remote-server", help = "Connect to the specified server",
                    action = "store", dest = "remote_server", default = False)
 
+        parser.add_option("", "--observe-only", help = "Connect to a server as an observing-only client",
+                   action = "store_true", dest = "observe_only", default = False)
+
         options, targets = parser.parse_args(sys.argv)
         return options, targets[1:]
 
@@ -269,6 +272,9 @@ def main():
     if configParams.remote_server and configParams.servertype != "xmlrpc":
         sys.exit("FATAL: If '--remote-server' is defined, we must set the servertype as 'xmlrpc'.\n")
 
+    if configParams.observe_only and (not configParams.remote_server or configParams.bind):
+        sys.exit("FATAL: '--observe-only' can only be used by UI clients connecting to a server.\n")
+
     if "BBDEBUG" in os.environ:
         level = int(os.environ["BBDEBUG"])
         if level > configuration.debug:
@@ -295,7 +301,7 @@ def main():
         server = start_server(servermodule, configParams, configuration)
     else:
         # we start a stub server that is actually a XMLRPClient to
-        server = servermodule.BitBakeXMLRPCClient()
+        server = servermodule.BitBakeXMLRPCClient(configParams.observe_only)
         server.saveConnectionDetails(configParams.remote_server)
 
     logger.removeHandler(handler)
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 2826e35..726d074 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -33,12 +33,15 @@ import atexit
 import traceback
 import bb.utils
 import bb.compat
+import threading
 
 # This is the pid for which we should generate the event. This is set when
 # the runqueue forks off.
 worker_pid = 0
 worker_pipe = None
 
+_ui_handlers_lock = threading.Lock()
+
 logger = logging.getLogger('BitBake.Event')
 
 class Event(object):
@@ -93,6 +96,8 @@ def fire_class_handlers(event, d):
             continue
 
 ui_queue = []
+_ui_event_history = []
+_ui_event_history_lock = threading.Lock()
 @atexit.register
 def print_ui_queue():
     """If we're exiting before a UI has been spawned, display any queued
@@ -124,22 +129,34 @@ def fire_ui_handlers(event, d):
         # No UI handlers registered yet, queue up the messages
         ui_queue.append(event)
         return
-
+    _ui_event_history_lock.acquire()
+    _ui_event_history.append(event)
+    _ui_event_history_lock.release()
     errors = []
-    for h in _ui_handlers:
-        #print "Sending event %s" % event
-        try:
-             # We use pickle here since it better handles object instances
-             # which xmlrpc's marshaller does not. Events *must* be serializable
-             # by pickle.
-             if hasattr(_ui_handlers[h].event, "sendpickle"):
-                _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
-             else:
-                _ui_handlers[h].event.send(event)
-        except:
-            errors.append(h)
-    for h in errors:
-        del _ui_handlers[h]
+    _ui_handlers_lock.acquire()
+    try:
+        for h in _ui_handlers:
+            #print "Sending event %s" % event
+            try:
+                 # We use pickle here since it better handles object instances
+                 # which xmlrpc's marshaller does not. Events *must* be serializable
+                 # by pickle.
+                 if hasattr(_ui_handlers[h].event, "sendpickle"):
+                    _ui_handlers[h].event.sendpickle((pickle.dumps(event)))
+                 else:
+                    _ui_handlers[h].event.send(event)
+            except:
+                errors.append(h)
+        for h in errors:
+            del _ui_handlers[h]
+    finally:
+        _ui_handlers_lock.release()
+
+def get_event_history():
+    _ui_event_history_lock.acquire()
+    evt_copy = _ui_event_history[:]
+    _ui_event_history_lock.release()
+    return evt_copy
 
 def fire(event, d):
     """Fire off an Event"""
@@ -199,13 +216,21 @@ def remove(name, handler):
     _handlers.pop(name)
 
 def register_UIHhandler(handler):
-    bb.event._ui_handler_seq = bb.event._ui_handler_seq + 1
-    _ui_handlers[_ui_handler_seq] = handler
+    _ui_handlers_lock.acquire()
+    try:
+        bb.event._ui_handler_seq = bb.event._ui_handler_seq + 1
+        _ui_handlers[_ui_handler_seq] = handler
+    finally:
+        _ui_handlers_lock.release()
     return _ui_handler_seq
 
 def unregister_UIHhandler(handlerNum):
-    if handlerNum in _ui_handlers:
-        del _ui_handlers[handlerNum]
+    _ui_handlers_lock.acquire()
+    try:
+        if handlerNum in _ui_handlers:
+            del _ui_handlers[handlerNum]
+    finally:
+        _ui_handlers_lock.release()
     return
 
 def getName(e):
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 0b51ebd..0178bef 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -157,7 +157,7 @@ class BitBakeServerCommands():
         self.server = server
         self.has_client = False
 
-    def registerEventHandler(self, host, port):
+    def registerEventHandler(self, host, port, replay = False):
         """
         Register a remote UI Event Handler
         """
@@ -255,17 +255,25 @@ class BitBakeUIEventServer(threading.Thread):
             self.qlock.release()
             return e
 
-    def __init__(self, connection):
+    def __init__(self, connection, replay):
         self.connection = connection
         self.notify = threading.Event()
         self.event = BitBakeUIEventServer.EventAdapter(self.notify)
         self.quit = False
+        self.replay = replay
         threading.Thread.__init__(self)
 
     def terminateServer(self):
         self.quit = True
 
     def run(self):
+        # First send all events in the event history if requested
+        # by the client
+        if self.replay:
+           event_history = bb.event.get_event_history()
+           for evt in event_history:
+               self.connection.event.sendpickle(pickle.dumps(evt))
+           del event_history
         while not self.quit:
             self.notify.wait(0.1)
             evt = self.event.get()
@@ -278,14 +286,14 @@ class BitBakeXMLRPCEventServerController(SimpleXMLRPCServer, threading.Thread):
         threading.Thread.__init__(self)
         self.register_function(self.registerEventHandler, "registerEventHandler")
         self.register_function(self.unregisterEventHandler, "unregisterEventHandler")
-        self.register_function(self.terminateServer, "terminateServer")
+        #self.register_function(self.terminateServer, "terminateServer")
         #self.register_function(self.runCommand, "runCommand")
         self.quit = False
         self.clients = {}
         self.client_ui_ids = {}
         self.timeout = 1    # timeout for .handle_request()
 
-    def registerEventHandler(self, host, port):
+    def registerEventHandler(self, host, port, replay = False):
         """
         Register a remote UI Event Handler
         """
@@ -293,7 +301,7 @@ class BitBakeXMLRPCEventServerController(SimpleXMLRPCServer, threading.Thread):
         client_hash = "%s:%d" % (host, port)
         if self.clients.has_key(client_hash):
             return None
-        client_ui_server = BitBakeUIEventServer(connection)
+        client_ui_server = BitBakeUIEventServer(connection, replay)
         self.client_ui_ids[client_hash] = bb.event.register_UIHhandler(client_ui_server)
         client_ui_server.start()
         self.clients[client_hash] = client_ui_server
@@ -423,6 +431,33 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
     def set_connection_token(self, token):
         self.connection_token = token
 
+
+class BitBakeObserverConnection(BitBakeBaseServerConnection):
+    def __init__(self, serverImpl, clientinfo , replay):
+        self.connection = xmlrpclib.ServerProxy("http://%s:%d/" % (serverImpl.host, serverImpl.port + 2), allow_none=True)
+        self.clientinfo = clientinfo
+        self.replay = replay
+
+    def connect(self):
+        self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo, self.replay)
+        return self
+
+    def removeClient(self):
+        pass
+
+    def terminate(self):
+        # Don't wait for server indefinitely
+        import socket
+        socket.setdefaulttimeout(2)
+        try:
+            self.events.system_quit()
+        except:
+            pass
+        try:
+            self.connection.terminateServer()
+        except:
+            pass
+
 class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
     def __init__(self, serverImpl, clientinfo=("localhost", 0)):
         self.connection, self.transport = _create_server(serverImpl.host, serverImpl.port)
@@ -471,9 +506,12 @@ class BitBakeServer(BitBakeBaseServer):
         self.connection.transport.set_connection_token(token)
 
 class BitBakeXMLRPCClient(BitBakeBaseServer):
+    """ a BitBakeServer controller that just connects to a remote server
 
-    def __init__(self):
-        pass
+    """
+    def __init__(self, observer_only = False, replay = False):
+        self.observer_only = observer_only
+        self.replay = replay
 
     def saveConnectionDetails(self, remote):
         self.remote = remote
@@ -495,7 +533,10 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
         except:
             return None
         self.serverImpl = XMLRPCProxyServer(host, port)
-        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0))
+        if self.observer_only:
+            self.connection = BitBakeObserverConnection(self.serverImpl, (ip, 0), self.replay)
+        else:
+            self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0))
         return self.connection.connect()
 
     def endSession(self):
diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 389c3cc..465203f 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -216,21 +216,28 @@ class TerminalFilter(object):
             fd = sys.stdin.fileno()
             self.termios.tcsetattr(fd, self.termios.TCSADRAIN, self.stdinbackup)
 
-def main(server, eventHandler, params, tf = TerminalFilter):
-
+def _log_settings_from_server(server):
     # Get values of variables which control our output
     includelogs, error = server.runCommand(["getVariable", "BBINCLUDELOGS"])
     if error:
         logger.error("Unable to get the value of BBINCLUDELOGS variable: %s" % error)
-        return 1
+        raise error
     loglines, error = server.runCommand(["getVariable", "BBINCLUDELOGS_LINES"])
     if error:
         logger.error("Unable to get the value of BBINCLUDELOGS_LINES variable: %s" % error)
-        return 1
+        raise error
     consolelogfile, error = server.runCommand(["getVariable", "BB_CONSOLELOG"])
     if error:
         logger.error("Unable to get the value of BB_CONSOLELOG variable: %s" % error)
-        return 1
+        raise error
+    return includelogs, loglines, consolelogfile
+
+def main(server, eventHandler, params, tf = TerminalFilter):
+
+    if params.observe_only:
+        includelogs, loglines, consolelogfile = None, None, None
+    else:
+        includelogs, loglines, consolelogfile = _log_settings_from_server(server)
 
     if sys.stdin.isatty() and sys.stdout.isatty():
         log_exec_tty = True
@@ -254,7 +261,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         consolelog.setFormatter(conlogformat)
         logger.addHandler(consolelog)
 
-    try:
+    if not params.observe_only:
         params.updateFromServer(server)
         cmdline = params.parseActions()
         if not cmdline:
@@ -271,9 +278,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         elif ret != True:
             logger.error("Command '%s' failed: returned %s" % (cmdline, ret))
             return 1
-    except xmlrpclib.Fault as x:
-        logger.error("XMLRPC Fault getting commandline:\n %s" % x)
-        return 1
+
 
     parseprogress = None
     cacheprogress = None
@@ -320,7 +325,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 elif event.levelno == format.WARNING:
                     warnings = warnings + 1
                 # For "normal" logging conditions, don't show note logs from tasks
-                # but do show them if the user has changed the default log level to 
+                # but do show them if the user has changed the default log level to
                 # include verbose/debug messages
                 if event.taskpid != 0 and event.levelno <= format.NOTE:
                     continue
@@ -469,12 +474,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 pass
         except KeyboardInterrupt:
             termfilter.clearFooter()
-            if main.shutdown == 1:
+            if not params.observe_only and main.shutdown == 1:
                 print("\nSecond Keyboard Interrupt, stopping...\n")
                 _, error = server.runCommand(["stateStop"])
                 if error:
                     logger.error("Unable to cleanly stop: %s" % error)
-            if main.shutdown == 0:
+            if not params.observe_only and main.shutdown == 0:
                 print("\nKeyboard Interrupt, closing down...\n")
                 interrupted = True
                 _, error = server.runCommand(["stateShutdown"])
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index 0b9a836..53a5f63 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -28,7 +28,7 @@ import socket, threading, pickle
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 
 class BBUIEventQueue:
-    def __init__(self, BBServer, clientinfo=("localhost, 0")):
+    def __init__(self, BBServer, clientinfo=("localhost, 0"), replay = False):
 
         self.eventQueue = []
         self.eventQueueLock = threading.Lock()
@@ -44,7 +44,7 @@ class BBUIEventQueue:
         server.register_function( self.send_event, "event.sendpickle" )
         server.socket.settimeout(1)
 
-        self.EventHandle = self.BBServer.registerEventHandler(self.host, self.port)
+        self.EventHandle = self.BBServer.registerEventHandler(self.host, self.port, replay)
 
         self.server = server
 
-- 
1.8.1.2


