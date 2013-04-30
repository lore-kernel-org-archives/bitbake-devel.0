Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ddalex@intel.com>) id 1UXAR6-0004Hx-S3
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Apr 2013 15:17:39 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 30 Apr 2013 05:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,582,1363158000"; d="scan'208";a="326528706"
Received: from adamian-desktop.rb.intel.com ([10.237.224.34])
	by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2013 05:57:54 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id DC402560262; Tue, 30 Apr 2013 13:57:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org,
	paul.eggleton@linux.intel.com, andrei.adrianx.dinu@intel.com,
	bogdan.a.marinescu@intel.com
Date: Tue, 30 Apr 2013 13:57:55 +0100
Message-Id: <1367326675-18037-3-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1367326675-18037-1-git-send-email-alexandru.damian@intel.com>
References: <1367326675-18037-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/2] bitbake servers: use common server infrastructure
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
X-List-Received-Date: Tue, 30 Apr 2013 13:17:49 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Modifies all the server implementations so that it uses
and follows the common server infrastructure.

Also clears up convoluted code and adds usage of defined
interfaces.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/lib/bb/server/none.py    |   38 ++++++++-------------------
 bitbake/lib/bb/server/process.py |   54 +++++++++++++++-----------------------
 bitbake/lib/bb/server/xmlrpc.py  |   40 +++++++++-------------------
 3 files changed, 44 insertions(+), 88 deletions(-)

diff --git a/bitbake/lib/bb/server/none.py b/bitbake/lib/bb/server/none.py
index f5fd4d4..83198d0 100644
--- a/bitbake/lib/bb/server/none.py
+++ b/bitbake/lib/bb/server/none.py
@@ -34,6 +34,8 @@ DEBUG = False
 
 import inspect, select
 
+from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
+
 class BitBakeServerCommands():
     def __init__(self, server):
         self.server = server
@@ -104,23 +106,18 @@ class BBUIEventQueue:
 def chldhandler(signum, stackframe):
     pass
 
-class BitBakeNoneServer():
+class NoneServer(BaseImplServer):
     # remove this when you're done with debugging
     # allow_reuse_address = True
 
     def __init__(self):
-        self._idlefuns = {}
+        BaseImplServer.__init__(self)
         self.commands = BitBakeServerCommands(self)
 
     def addcooker(self, cooker):
-        self.cooker = cooker
+        BaseImplServer.addcooker(cooker)
         self.commands.cooker = cooker
 
-    def register_idle_function(self, function, data):
-        """Register a function to be called while the server is idle"""
-        assert hasattr(function, '__call__')
-        self._idlefuns[function] = data
-
     def idle_commands(self, delay):
         #print "Idle queue length %s" % len(self._idlefuns)
         #print "Idle timeout, running idle functions"
@@ -159,9 +156,9 @@ class BitBakeNoneServer():
             except:
                 pass
 
-class BitBakeServerConnection():
-    def __init__(self, server):
-        self.server = server.server
+class BitBakeNoneServerConnection(BitBakeBaseServerConnection):
+    def __init__(self, serverImpl):
+        self.server = serverImpl
         self.connection = self.server.commands
         self.events = bb.server.none.BBUIEventQueue(self.server)
         for event in bb.event.ui_queue:
@@ -177,25 +174,12 @@ class BitBakeServerConnection():
         except:
             pass
 
-class BitBakeServer(object):
+class BitBakeServer(BitBakeBaseServer):
     def initServer(self):
-        self.server = BitBakeNoneServer()
-
-    def addcooker(self, cooker):
-        self.cooker = cooker
-        self.server.addcooker(cooker)
-
-    def getServerIdleCB(self):
-        return self.server.register_idle_function
-
-    def saveConnectionDetails(self):
-        return
-
-    def detach(self):
-        return
+        self.serverImpl = NoneServer()
 
     def establishConnection(self):
-        self.connection = BitBakeServerConnection(self)
+        self.connection = BitBakeNoneServerConnection(self.serverImpl)
         return self.connection
 
     def launchUI(self, uifunc, *args):
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 5e2cade..bfd9e97 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -32,6 +32,8 @@ import time
 from Queue import Empty
 from multiprocessing import Event, Process, util, Queue, Pipe, queues
 
+from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
+
 logger = logging.getLogger('BitBake')
 
 class ServerCommunicator():
@@ -68,26 +70,21 @@ class EventAdapter():
             print("EventAdapter puked: %s" % str(err))
 
 
-class ProcessServer(Process):
+class ProcessServer(Process, BaseImplServer):
     profile_filename = "profile.log"
     profile_processed_filename = "profile.log.processed"
 
     def __init__(self, command_channel, event_queue):
+        BaseImplServer.__init__(self)
         Process.__init__(self)
         self.command_channel = command_channel
         self.event_queue = event_queue
         self.event = EventAdapter(event_queue)
-        self._idlefunctions = {}
         self.quit = False
 
         self.keep_running = Event()
         self.keep_running.set()
 
-    def register_idle_function(self, function, data):
-        """Register a function to be called while the server is idle"""
-        assert hasattr(function, '__call__')
-        self._idlefunctions[function] = data
-
     def run(self):
         for event in bb.event.ui_queue:
             self.event_queue.put(event)
@@ -117,11 +114,11 @@ class ProcessServer(Process):
     def idle_commands(self, delay):
         nextsleep = delay
 
-        for function, data in self._idlefunctions.items():
+        for function, data in self._idlefuns.items():
             try:
                 retval = function(self, data, False)
                 if retval is False:
-                    del self._idlefunctions[function]
+                    del self._idlefuns[function]
                 elif retval is True:
                     nextsleep = None
                 elif nextsleep is None:
@@ -191,12 +188,13 @@ class ProcessServer(Process):
     if (2, 6, 0) <= sys.version_info < (2, 6, 3):
         _bootstrap = bootstrap_2_6_6
 
-class BitBakeServerConnection():
-    def __init__(self, server):
-        self.server = server
-        self.procserver = server.server
-        self.connection = ServerCommunicator(server.ui_channel)
-        self.events = server.event_queue
+class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
+    def __init__(self, serverImpl, ui_channel, event_queue):
+        self.procserver = serverImpl
+        self.ui_channel = ui_channel
+        self.event_queue = event_queue
+        self.connection = ServerCommunicator(self.ui_channel)
+        self.events = self.event_queue
 
     def terminate(self, force = False):
         signal.signal(signal.SIGINT, signal.SIG_IGN)
@@ -210,13 +208,14 @@ class BitBakeServerConnection():
             self.procserver.join()
         while True:
             try:
-                event = self.server.event_queue.get(block=False)
+                event = self.event_queue.get(block=False)
             except (Empty, IOError):
                 break
             if isinstance(event, logging.LogRecord):
                 logger.handle(event)
-        self.server.ui_channel.close()
-        self.server.event_queue.close()
+        # TODO: adamian: figure out who should actually cleanup these resources
+        self.ui_channel.close()
+        self.event_queue.close()
         if force:
             sys.exit(1)
 
@@ -235,7 +234,7 @@ class ProcessEventQueue(multiprocessing.queues.Queue):
             return None
 
 
-class BitBakeServer(object):
+class BitBakeServer(BitBakeBaseServer):
     def initServer(self):
         # establish communication channels.  We use bidirectional pipes for
         # ui <--> server command/response pairs
@@ -243,25 +242,14 @@ class BitBakeServer(object):
         #
         self.ui_channel, self.server_channel = Pipe()
         self.event_queue = ProcessEventQueue(0)
-
-        self.server = ProcessServer(self.server_channel, self.event_queue)
-
-    def addcooker(self, cooker):
-        self.cooker = cooker
-        self.server.cooker = cooker
-
-    def getServerIdleCB(self):
-        return self.server.register_idle_function
-
-    def saveConnectionDetails(self):
-        return
+        self.serverImpl = ProcessServer(self.server_channel, self.event_queue)
 
     def detach(self):
-        self.server.start() 
+        self.serverImpl.start() 
         return
 
     def establishConnection(self):
-        self.connection = BitBakeServerConnection(self)
+        self.connection = BitBakeProcessServerConnection(self.serverImpl, self.ui_channel, self.event_queue)
         signal.signal(signal.SIGTERM, lambda i, s: self.connection.terminate(force=True))
         return self.connection
 
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 61bd57a..9028c39 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -41,6 +41,8 @@ DEBUG = False
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 import inspect, select
 
+from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
+
 if sys.hexversion < 0x020600F0:
     print("Sorry, python 2.6 or later is required for bitbake's XMLRPC mode")
     sys.exit(1)
@@ -159,7 +161,7 @@ class BitBakeServerCommands():
         """
         return True
 
-class BitBakeXMLRPCServer(SimpleXMLRPCServer):
+class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
     # remove this when you're done with debugging
     # allow_reuse_address = True
 
@@ -167,17 +169,17 @@ class BitBakeXMLRPCServer(SimpleXMLRPCServer):
         """
         Constructor
         """
+        BaseImplServer.__init__(self)
         SimpleXMLRPCServer.__init__(self, interface,
                                     requestHandler=SimpleXMLRPCRequestHandler,
                                     logRequests=False, allow_none=True)
-        self._idlefuns = {}
         self.host, self.port = self.socket.getsockname()
         #self.register_introspection_functions()
         self.commands = BitBakeServerCommands(self)
         self.autoregister_all_functions(self.commands, "")
 
     def addcooker(self, cooker):
-        self.cooker = cooker
+        BaseImplServer.addcooker(cooker)
         self.commands.cooker = cooker
 
     def autoregister_all_functions(self, context, prefix):
@@ -190,10 +192,6 @@ class BitBakeXMLRPCServer(SimpleXMLRPCServer):
             if name.startswith(prefix):
                 self.register_function(method, name[len(prefix):])
 
-    def register_idle_function(self, function, data):
-        """Register a function to be called while the server is idle"""
-        assert hasattr(function, '__call__')
-        self._idlefuns[function] = data
 
     def serve_forever(self):
         bb.cooker.server_main(self.cooker, self._serve_forever)
@@ -241,14 +239,10 @@ class BitBakeXMLRPCServer(SimpleXMLRPCServer):
         self.server_close()
         return
 
-class BitbakeServerInfo():
-    def __init__(self, host, port):
-        self.host = host
-        self.port = port
 
-class BitBakeServerConnection():
-    def __init__(self, serverinfo, clientinfo=("localhost", 0)):
-        self.connection = _create_server(serverinfo.host, serverinfo.port)
+class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
+    def __init__(self, serverImpl, clientinfo=("localhost", 0)):
+        self.connection = _create_server(serverImpl.host, serverImpl.port)
         self.events = uievent.BBUIEventQueue(self.connection, clientinfo)
         for event in bb.event.ui_queue:
             self.events.queue_event(event)
@@ -266,27 +260,17 @@ class BitBakeServerConnection():
         except:
             pass
 
-class BitBakeServer(object):
+class BitBakeServer(BitBakeBaseServer):
     def initServer(self, interface = ("localhost", 0)):
-        self.server = BitBakeXMLRPCServer(interface)
-
-    def addcooker(self, cooker):
-        self.cooker = cooker
-        self.server.addcooker(cooker)
-
-    def getServerIdleCB(self):
-        return self.server.register_idle_function
-
-    def saveConnectionDetails(self): 
-        self.serverinfo = BitbakeServerInfo(self.server.host, self.server.port)
+        self.serverImpl = XMLRPCServer(interface)
 
     def detach(self):
         daemonize.createDaemon(self.server.serve_forever, "bitbake-cookerdaemon.log")
         del self.cooker
-        del self.server
+        del self.serverImpl
 
     def establishConnection(self):
-        self.connection = BitBakeServerConnection(self.serverinfo)
+        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl)
         return self.connection
 
     def launchUI(self, uifunc, *args):
-- 
1.7.10.4



