Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 03613780FA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Jul 2017 21:37:04 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v6ILb4BI012340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 18 Jul 2017 22:37:05 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dXaAy-0006T7-44; Tue, 18 Jul 2017 22:37:04 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Jul 2017 22:36:56 +0100
Message-Id: <1500413820-24816-2-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1500413820-24816-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 18 Jul 2017 22:37:05 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 2/6] server: Remove base classes and inline code
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
X-List-Received-Date: Tue, 18 Jul 2017 21:37:05 -0000

In preparation for rewriting this code, expand the relatively useless
base classes into the code itself.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/__init__.py | 72 -----------------------------------------------
 lib/bb/server/process.py  | 34 ++++++++++++++++++----
 lib/bb/server/xmlrpc.py   | 60 +++++++++++++++++++++++++++++++++------
 3 files changed, 80 insertions(+), 86 deletions(-)

diff --git a/lib/bb/server/__init__.py b/lib/bb/server/__init__.py
index 538a633..345691e 100644
--- a/lib/bb/server/__init__.py
+++ b/lib/bb/server/__init__.py
@@ -25,75 +25,3 @@ approach to the interface, and minimize risks associated with code duplication.
 
 """
 
-"""  BaseImplServer() the base class for all XXServer() implementations.
-
-    These classes contain the actual code that runs the server side, i.e.
-    listens for the commands and executes them. Although these implementations
-    contain all the data of the original bitbake command, i.e the cooker instance,
-    they may well run on a different process or even machine.
-
-"""
-
-class BaseImplServer():
-    def __init__(self):
-        self._idlefuns = {}
-
-    def addcooker(self, cooker):
-        self.cooker = cooker
-
-    def register_idle_function(self, function, data):
-        """Register a function to be called while the server is idle"""
-        assert hasattr(function, '__call__')
-        self._idlefuns[function] = data
-
-
-
-""" BitBakeBaseServerConnection class is the common ancestor to all
-    BitBakeServerConnection classes.
-
-    These classes control the remote server. The only command currently
-    implemented is the terminate() command.
-
-"""
-
-class BitBakeBaseServerConnection():
-    def __init__(self, serverImpl):
-        pass
-
-    def terminate(self):
-        pass
-
-    def setupEventQueue(self):
-        pass
-
-
-""" BitBakeBaseServer class is the common ancestor to all Bitbake servers
-
-    Derive this class in order to implement a BitBakeServer which is the
-    controlling stub for the actual server implementation
-
-"""
-class BitBakeBaseServer(object):
-    def initServer(self):
-        self.serverImpl = None  # we ensure a runtime crash if not overloaded
-        self.connection = None
-        return
-
-    def addcooker(self, cooker):
-        self.cooker = cooker
-        self.serverImpl.addcooker(cooker)
-
-    def getServerIdleCB(self):
-        return self.serverImpl.register_idle_function
-
-    def saveConnectionDetails(self):
-        return
-
-    def detach(self):
-        return
-
-    def establishConnection(self, featureset):
-        raise   "Must redefine the %s.establishConnection()" % self.__class__.__name__
-
-    def endSession(self):
-        self.connection.terminate()
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index cfcd764..48da7fe 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -33,8 +33,6 @@ import select
 from queue import Empty
 from multiprocessing import Event, Process, util, Queue, Pipe, queues, Manager
 
-from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
-
 logger = logging.getLogger('BitBake')
 
 class ServerCommunicator():
@@ -85,12 +83,12 @@ class EventAdapter():
             print("EventAdapter puked: %s" % str(err))
 
 
-class ProcessServer(Process, BaseImplServer):
+class ProcessServer(Process):
     profile_filename = "profile.log"
     profile_processed_filename = "profile.log.processed"
 
     def __init__(self, command_channel, event_queue, featurelist):
-        BaseImplServer.__init__(self)
+        self._idlefuns = {}
         Process.__init__(self)
         self.command_channel = command_channel
         self.event_queue = event_queue
@@ -208,7 +206,15 @@ class ProcessServer(Process, BaseImplServer):
         self.quitin.send("quit")
         self.quitin.close()
 
-class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
+    def addcooker(self, cooker):
+        self.cooker = cooker
+
+    def register_idle_function(self, function, data):
+        """Register a function to be called while the server is idle"""
+        assert hasattr(function, '__call__')
+        self._idlefuns[function] = data
+
+class BitBakeProcessServerConnection(object):
     def __init__(self, serverImpl, ui_channel, event_queue):
         self.procserver = serverImpl
         self.ui_channel = ui_channel
@@ -247,6 +253,9 @@ class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
         # fd leakage because isn't called on Queue.close()
         self.event_queue._writer.close()
 
+    def setupEventQueue(self):
+        pass
+
 # Wrap Queue to provide API which isn't server implementation specific
 class ProcessEventQueue(multiprocessing.queues.Queue):
     def __init__(self, maxsize):
@@ -279,7 +288,7 @@ class ProcessEventQueue(multiprocessing.queues.Queue):
                 sys.exit(1)
             return None
 
-class BitBakeServer(BitBakeBaseServer):
+class BitBakeServer(object):
     def initServer(self, single_use=True):
         # establish communication channels.  We use bidirectional pipes for
         # ui <--> server command/response pairs
@@ -304,3 +313,16 @@ class BitBakeServer(BitBakeBaseServer):
             raise BaseException(error)
         signal.signal(signal.SIGTERM, lambda i, s: self.connection.sigterm_terminate())
         return self.connection
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
+    def endSession(self):
+        self.connection.terminate()
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 1a475e0..6874765 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -49,7 +49,6 @@ from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 import bb
 from bb import daemonize
 from bb.ui import uievent
-from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
 
 DEBUG = False
 
@@ -193,15 +192,25 @@ class BitBakeXMLRPCRequestHandler(SimpleXMLRPCRequestHandler):
         self.wfile.write(bytes(response, 'utf-8'))
 
 
-class XMLRPCProxyServer(BaseImplServer):
+class XMLRPCProxyServer(object):
     """ not a real working server, but a stub for a proxy server connection
 
     """
     def __init__(self, host, port, use_builtin_types=True):
         self.host = host
         self.port = port
+        self._idlefuns = {}
 
-class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
+    def addcooker(self, cooker):
+        self.cooker = cooker
+
+    def register_idle_function(self, function, data):
+        """Register a function to be called while the server is idle"""
+        assert hasattr(function, '__call__')
+        self._idlefuns[function] = data
+
+
+class XMLRPCServer(SimpleXMLRPCServer):
     # remove this when you're done with debugging
     # allow_reuse_address = True
 
@@ -209,7 +218,7 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         """
         Constructor
         """
-        BaseImplServer.__init__(self)
+        self._idlefuns = {}
         self.single_use = single_use
         # Use auto port configuration
         if (interface[1] == -1):
@@ -231,7 +240,7 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         self.next_heartbeat = time.time()
 
     def addcooker(self, cooker):
-        BaseImplServer.addcooker(self, cooker)
+        self.cooker = cooker
         self.commands.cooker = cooker
 
     def autoregister_all_functions(self, context, prefix):
@@ -335,7 +344,13 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
     def set_connection_token(self, token):
         self.connection_token = token
 
-class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
+    def register_idle_function(self, function, data):
+        """Register a function to be called while the server is idle"""
+        assert hasattr(function, '__call__')
+        self._idlefuns[function] = data
+
+
+class BitBakeXMLRPCServerConnection(object):
     def __init__(self, serverImpl, clientinfo=("localhost", 0), observer_only = False, featureset = None):
         self.connection, self.transport = _create_server(serverImpl.host, serverImpl.port)
         self.clientinfo = clientinfo
@@ -388,7 +403,7 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
         except:
             pass
 
-class BitBakeServer(BitBakeBaseServer):
+class BitBakeServer(object):
     def initServer(self, interface = ("localhost", 0),
                    single_use = False, idle_timeout=0):
         self.interface = interface
@@ -405,7 +420,20 @@ class BitBakeServer(BitBakeBaseServer):
     def set_connection_token(self, token):
         self.connection.transport.set_connection_token(token)
 
-class BitBakeXMLRPCClient(BitBakeBaseServer):
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
+    def endSession(self):
+        self.connection.terminate()
+
+class BitBakeXMLRPCClient(object):
 
     def __init__(self, observer_only = False, token = None):
         self.token = token
@@ -446,3 +474,19 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
 
     def endSession(self):
         self.connection.removeClient()
+
+    def initServer(self):
+        self.serverImpl = None
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
+    def detach(self):
+        return
+
-- 
2.7.4


