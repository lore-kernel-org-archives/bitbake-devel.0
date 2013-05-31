Return-Path: <ddalex@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id B0B8862222
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 11:06:51 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 31 May 2013 04:06:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,778,1363158000"; d="scan'208";a="310504531"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by azsmga001.ch.intel.com with ESMTP; 31 May 2013 04:06:50 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id 1F2CC560796; Fri, 31 May 2013 12:06:51 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Fri, 31 May 2013 12:06:46 +0100
Message-Id: <1369998409-16560-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/4] bitbake server: create common server infrastructure
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
X-List-Received-Date: Fri, 31 May 2013 11:06:52 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In an attempt to minimize code duplication, create
clear interfaces, and maximize code reuse through OOP,
bb.server adds base classes for the BitBakeServer,
BitBakeServerConnection and actual server implementations
instructed in particular server types.

These classes document the minimum interfaces that the
derived classes must implement, and provide boilerplate code.

Changes to None, Process and XMLRPC servers as to use
the common server infrastructure.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/__init__.py | 96 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/server/process.py  | 54 +++++++++++---------------
 lib/bb/server/xmlrpc.py   | 64 ++++++++++++-------------------
 3 files changed, 142 insertions(+), 72 deletions(-)

diff --git a/lib/bb/server/__init__.py b/lib/bb/server/__init__.py
index e69de29..2e1c619 100644
--- a/lib/bb/server/__init__.py
+++ b/lib/bb/server/__init__.py
@@ -0,0 +1,96 @@
+#
+# BitBake Base Server Code
+#
+# Copyright (C) 2006 - 2007  Michael 'Mickey' Lauer
+# Copyright (C) 2006 - 2008  Richard Purdie
+# Copyright (C) 2013         Alexandru Damian
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+
+""" Base code for Bitbake server process
+
+Have a common base for that all Bitbake server classes ensures a consistent
+approach to the interface, and minimize risks associated with code duplication.
+
+"""
+
+"""  BaseImplServer() the base class for all XXServer() implementations.
+
+    These classes contain the actual code that runs the server side, i.e.
+    listens for the commands and executes them. Although these implementations
+    contain all the data of the original bitbake command, i.e the cooker instance,
+    they may well run on a different process or even machine.
+
+"""
+
+class BaseImplServer():
+    def __init__(self):
+        self._idlefuns = {}
+
+    def addcooker(self, cooker):
+        self.cooker = cooker
+
+    def register_idle_function(self, function, data):
+        """Register a function to be called while the server is idle"""
+        assert hasattr(function, '__call__')
+        self._idlefuns[function] = data
+
+
+
+""" BitBakeBaseServerConnection class is the common ancestor to all
+    BitBakeServerConnection classes.
+
+    These classes control the remote server. The only command currently
+    implemented is the terminate() command.
+
+"""
+
+class BitBakeBaseServerConnection():
+    def __init__(self, serverImpl):
+        pass
+
+    def terminate(self):
+        pass
+
+
+""" BitBakeBaseServer class is the common ancestor to all Bitbake servers
+
+    Derive this class in order to implement a BitBakeServer which is the
+    controlling stub for the actual server implementation
+
+"""
+class BitBakeBaseServer(object):
+    def initServer(self):
+        self.serverImpl = None  # we ensure a runtime crash if not overloaded
+        self.connection = None
+        return
+
+    def addcooker(self, cooker):
+        self.cooker = cooker
+        self.serverImpl.addcooker(cooker)
+
+    def getServerIdleCB(self):
+        return self.serverImpl.register_idle_function
+
+    def saveConnectionDetails(self):
+        return
+
+    def detach(self):
+        return
+
+    def establishConnection(self):
+        raise   "Must redefine the %s.establishConnection()" % self.__class__.__name__
+
+    def endSession(self):
+        self.connection.terminate()
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 163dbbb..900c377 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
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
@@ -243,24 +242,13 @@ class BitBakeServer(object):
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
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 56a643c..2747ed8 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -49,6 +49,8 @@ DEBUG = False
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 import inspect, select
 
+from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
+
 if sys.hexversion < 0x020600F0:
     print("Sorry, python 2.6 or later is required for bitbake's XMLRPC mode")
     sys.exit(1)
@@ -286,7 +288,6 @@ class BitBakeXMLRPCEventServerController(SimpleXMLRPCServer):
         """
         Register a remote UI Event Handler
         """
-        print "registering handler %s:%s" % (host,port) 
         connection = xmlrpclib.ServerProxy("http://%s:%d/" % (host, port), allow_none=True)
         client_hash = "%s:%d" % (host, port)
         if self.clients.has_key(client_hash):
@@ -301,7 +302,6 @@ class BitBakeXMLRPCEventServerController(SimpleXMLRPCServer):
         """
         Unregister a remote UI Event Handler
         """
-        print "unregistering handler %s:%s" % (host,port)
         client_thread = self.clients[client_hash]
         if client_thread:
             bb.event.unregister_UIHhandler(self.clients_ui_ids[client_hash])
@@ -323,7 +323,16 @@ class BitBakeXMLRPCEventServerController(SimpleXMLRPCServer):
             self.handle_request()
         self.server_close()
 
-class BitBakeXMLRPCServer(SimpleXMLRPCServer):
+
+class XMLRPCProxyServer(BaseImplServer):
+    """ not a real working server, but a stub for a proxy server connection
+
+    """
+    def __init__(self, host, port):
+        self.host = host
+        self.port = port
+
+class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
     # remove this when you're done with debugging
     # allow_reuse_address = True
 
@@ -331,10 +340,10 @@ class BitBakeXMLRPCServer(SimpleXMLRPCServer):
         """
         Constructor
         """
+        BaseImplServer.__init__(self)
         SimpleXMLRPCServer.__init__(self, interface,
                                     requestHandler=BitBakeXMLRPCRequestHandler,
                                     logRequests=False, allow_none=True)
-        self._idlefuns = {}
         self.host, self.port = self.socket.getsockname()
         self.connection_token = None
         #self.register_introspection_functions()
@@ -343,7 +352,7 @@ class BitBakeXMLRPCServer(SimpleXMLRPCServer):
         self.interface = interface
 
     def addcooker(self, cooker):
-        self.cooker = cooker
+        BaseImplServer.addcooker(self, cooker)
         self.commands.cooker = cooker
 
     def autoregister_all_functions(self, context, prefix):
@@ -356,10 +365,6 @@ class BitBakeXMLRPCServer(SimpleXMLRPCServer):
             if name.startswith(prefix):
                 self.register_function(method, name[len(prefix):])
 
-    def register_idle_function(self, function, data):
-        """Register a function to be called while the server is idle"""
-        assert hasattr(function, '__call__')
-        self._idlefuns[function] = data
 
     def serve_forever(self):
         # Create and run the event server controller in a separate thread
@@ -420,16 +425,11 @@ class BitBakeXMLRPCServer(SimpleXMLRPCServer):
     def set_connection_token(self, token):
         self.connection_token = token
 
-class BitbakeServerInfo():
-    def __init__(self, host, port):
-        self.host = host
-        self.port = port
-
-class BitBakeServerConnection():
-    def __init__(self, serverinfo, clientinfo=("localhost", 0)):
-        self.connection, self.transport = _create_server(serverinfo.host, serverinfo.port)
+class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
+    def __init__(self, serverImpl, clientinfo=("localhost", 0)):
+        self.connection, self.transport = _create_server(serverImpl.host, serverImpl.port)
         self.clientinfo = clientinfo
-        self.serverinfo = serverinfo
+        self.serverImpl = serverImpl
 
     def connect(self):
         token = self.connection.addClient()
@@ -457,36 +457,22 @@ class BitBakeServerConnection():
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
-        daemonize.createDaemon(self.server.serve_forever, "bitbake-cookerdaemon.log")
+        daemonize.createDaemon(self.serverImpl.serve_forever, "bitbake-cookerdaemon.log")
         del self.cooker
-        del self.server
 
     def establishConnection(self):
-        self.connection = BitBakeServerConnection(self.serverinfo)
+        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl)
         return self.connection.connect()
 
     def set_connection_token(self, token):
         self.connection.transport.set_connection_token(token)
 
-    def endSession(self):
-        self.connection.terminate()
-
-class BitBakeXMLRPCClient(object):
+class BitBakeXMLRPCClient(BitBakeBaseServer):
 
     def __init__(self):
         pass
@@ -510,8 +496,8 @@ class BitBakeXMLRPCClient(object):
             s.close()
         except:
             return None
-        self.serverinfo = BitbakeServerInfo(host, port)
-        self.connection = BitBakeServerConnection(self.serverinfo, (ip, 0))
+        self.serverImpl = XMLRPCProxyServer(host, port)
+        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0))
         return self.connection.connect()
 
     def endSession(self):
-- 
1.8.1.2


