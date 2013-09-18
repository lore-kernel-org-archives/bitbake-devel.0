Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id B408D61DDD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2013 12:15:54 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 18 Sep 2013 05:15:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,929,1371106800"; d="scan'208";a="403549389"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 18 Sep 2013 05:15:55 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 9B7465606CA; Wed, 18 Sep 2013 13:15:56 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Wed, 18 Sep 2013 13:15:47 +0100
Message-Id: <89c7b50367088573fecc0114c94f5fa9b5e761d7.1379505533.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1379505533.git.alexandru.damian@intel.com>
References: <cover.1379505533.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/7] bitbake: cooker, xmlrpc, servers: implement CookerFeatures
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
X-List-Received-Date: Wed, 18 Sep 2013 12:15:54 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Implementing feature set selection that allows a client
to enable specific features in the server at connection time.

Only enabling of features is supported, as there is
no way to safely remove data loaded into the cooker.
Once enabled, a feature will remain enabled for the
life of the cooker.

Client-server connection now supports specifying the feature
set required by the client. This is implemented in the Process
server using a managed proxy list, so the server cooker
will now load dynamically needed features based on what client
connects to it.

In the XMLRPC server the feature set is requested by
using a parameter for registerUIHandler function.
This allows observer-only clients to also specify features
for the server.

The server code configuration now is completly separated
from the client code. All hardcoding of client knowledge is
removed from the server.

The extra_caches is removed as the client can now specify
the caches it needs using the feature. The UI modules
now need to specify the desired featureSet. HOB is modified
to conform to the featureSet specification.

The only feature available is CookerFeatures.HOB_EXTRA_CACHES
which forces loading the bb.cache_extra:HobRecipeInfo class.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/bin/bitbake               | 25 +++++--------------------
 bitbake/lib/bb/cooker.py          | 34 ++++++++++++++++++++++++++++++++--
 bitbake/lib/bb/cookerdata.py      |  1 -
 bitbake/lib/bb/server/__init__.py |  2 +-
 bitbake/lib/bb/server/process.py  | 23 ++++++++++++++++++-----
 bitbake/lib/bb/server/xmlrpc.py   | 29 ++++++++++++++++++++++-------
 bitbake/lib/bb/ui/hob.py          |  2 +-
 bitbake/lib/bb/ui/knotty.py       |  3 +++
 bitbake/lib/bb/ui/uievent.py      |  7 +++++--
 9 files changed, 87 insertions(+), 39 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 60c4b96..b4506ef 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -75,18 +75,6 @@ def get_ui(config):
         sys.exit("FATAL: Invalid user interface '%s' specified.\n"
                  "Valid interfaces: depexp, goggle, ncurses, hob, knotty [default]." % interface)
 
-def gather_extra_cache_data():
-    extra = []
-    interfaces = ['depexp', 'goggle', 'ncurses', 'hob', 'knotty']
-    for i in interfaces:
-        try:
-            ui = __import__("bb.ui." + i, fromlist = [i])
-            if hasattr(ui, "extraCaches"):
-                extra = extra + ui.extraCaches
-            del ui
-        except:
-            pass
-    return extra
 
 # Display bitbake/OE warnings via the BitBake.Warnings logger, ignoring others"""
 warnlog = logging.getLogger("BitBake.Warnings")
@@ -302,25 +290,22 @@ def main():
     # Clear away any spurious environment variables while we stoke up the cooker
     cleanedvars = bb.utils.clean_environment()
 
-    # Collect all the caches we need
-    if configParams.server_only:
-        configuration.extra_caches = gather_extra_cache_data()
-    else:
-        configuration.extra_caches = getattr(ui_module, "extraCaches", [])
-
     if not configParams.remote_server:
         # we start a server with a given configuration
         server = start_server(servermodule, configParams, configuration)
     else:
-        # we start a stub server that is actually a XMLRPClient to
+        # we start a stub server that is actually a XMLRPClient that connects to a real server
         server = servermodule.BitBakeXMLRPCClient(configParams.observe_only)
         server.saveConnectionDetails(configParams.remote_server)
 
     logger.removeHandler(handler)
 
     if not configParams.server_only:
+        # Collect the feature set for the UI
+        featureset = getattr(ui_module, "featureSet", [])
+
         # Setup a connection to the server (cooker)
-        server_connection = server.establishConnection()
+        server_connection = server.establishConnection(featureset)
 
         # Restore the environment in case the UI needs it
         for k in cleanedvars:
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 1d5e5f6..8776e18 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -79,6 +79,29 @@ class SkippedPackage:
         elif reason:
             self.skipreason = reason
 
+
+class CookerFeatures(object):
+    _feature_list = [HOB_EXTRA_CACHES] = range(1)
+
+    def __init__(self):
+        self._features=set()
+
+    def setFeature(self, f):
+        # validate we got a request for a feature we support
+        if f not in CookerFeatures._feature_list:
+            return
+        self._features.add(f)
+
+    def __contains__(self, f):
+        return f in self._features
+
+    def __iter__(self):
+        return self._features.__iter__()
+
+    def next(self):
+        return self._features.next()
+
+
 #============================================================================#
 # BBCooker
 #============================================================================#
@@ -90,6 +113,7 @@ class BBCooker:
     def __init__(self, configuration):
         self.recipecache = None
         self.skiplist = {}
+        self.featureset = CookerFeatures()
 
         self.configuration = configuration
 
@@ -122,7 +146,13 @@ class BBCooker:
         self.state = state.initial
 
         self.caches_array = []
-        caches_name_array = ['bb.cache:CoreRecipeInfo'] + self.configuration.extra_caches
+
+        all_extra_cache_names = []
+        # We hardcode all known cache types in a single place, here.
+        if CookerFeatures.HOB_EXTRA_CACHES in self.featureset:
+            all_extra_cache_names.append("bb.cache_extra:HobRecipeInfo")
+
+        caches_name_array = ['bb.cache:CoreRecipeInfo'] + all_extra_cache_names
 
         # At least CoreRecipeInfo will be loaded, so caches_array will never be empty!
         # This is the entry point, no further check needed!
@@ -130,7 +160,7 @@ class BBCooker:
             try:
                 module_name, cache_name = var.split(':')
                 module = __import__(module_name, fromlist=(cache_name,))
-                self.caches_array.append(getattr(module, cache_name)) 
+                self.caches_array.append(getattr(module, cache_name))
             except ImportError as exc:
                 logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
                 sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 0b278b1..e640ed0 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -127,7 +127,6 @@ class CookerConfiguration(object):
         self.dump_signatures = False
         self.dry_run = False
         self.tracking = False
-        self.extra_caches = []
 
         self.env = {}
 
diff --git a/bitbake/lib/bb/server/__init__.py b/bitbake/lib/bb/server/__init__.py
index 2e1c619..da5e480 100644
--- a/bitbake/lib/bb/server/__init__.py
+++ b/bitbake/lib/bb/server/__init__.py
@@ -89,7 +89,7 @@ class BitBakeBaseServer(object):
     def detach(self):
         return
 
-    def establishConnection(self):
+    def establishConnection(self, featureset):
         raise   "Must redefine the %s.establishConnection()" % self.__class__.__name__
 
     def endSession(self):
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index e45e0c2..aa07202 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -31,7 +31,7 @@ import sys
 import time
 import select
 from Queue import Empty
-from multiprocessing import Event, Process, util, Queue, Pipe, queues
+from multiprocessing import Event, Process, util, Queue, Pipe, queues, Manager
 
 from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
 
@@ -78,12 +78,13 @@ class ProcessServer(Process, BaseImplServer):
     profile_filename = "profile.log"
     profile_processed_filename = "profile.log.processed"
 
-    def __init__(self, command_channel, event_queue):
+    def __init__(self, command_channel, event_queue, featurelist):
         BaseImplServer.__init__(self)
-        Process.__init__(self)
+        Process.__init__(self, args=(featurelist))
         self.command_channel = command_channel
         self.event_queue = event_queue
         self.event = EventAdapter(event_queue)
+        self.featurelist = featurelist
         self.quit = False
 
         self.keep_running = Event()
@@ -94,6 +95,14 @@ class ProcessServer(Process, BaseImplServer):
         for event in bb.event.ui_queue:
             self.event_queue.put(event)
         self.event_handle.value = bb.event.register_UIHhandler(self)
+
+        # process any feature changes based on what UI requested
+        original_featureset = list(self.cooker.featureset)
+        while len(self.featurelist)> 0:
+            self.cooker.featureset.setFeature(self.featurelist.pop())
+        if (original_featureset != list(self.cooker.featureset)):
+            self.cooker.reset()
+
         bb.cooker.server_main(self.cooker, self.main)
 
     def main(self):
@@ -198,13 +207,17 @@ class BitBakeServer(BitBakeBaseServer):
         #
         self.ui_channel, self.server_channel = Pipe()
         self.event_queue = ProcessEventQueue(0)
-        self.serverImpl = ProcessServer(self.server_channel, self.event_queue)
+        manager = Manager()
+        self.featurelist = manager.list()
+        self.serverImpl = ProcessServer(self.server_channel, self.event_queue, self.featurelist)
 
     def detach(self):
         self.serverImpl.start()
         return
 
-    def establishConnection(self):
+    def establishConnection(self, featureset):
+        for f in featureset:
+            self.featurelist.append(f)
         self.connection = BitBakeProcessServerConnection(self.serverImpl, self.ui_channel, self.event_queue)
         signal.signal(signal.SIGTERM, lambda i, s: self.connection.terminate())
         return self.connection
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 8326623..389327a 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -89,12 +89,23 @@ class BitBakeServerCommands():
         self.server = server
         self.has_client = False
 
-    def registerEventHandler(self, host, port):
+    def registerEventHandler(self, host, port, featureset = []):
         """
         Register a remote UI Event Handler
         """
         s, t = _create_server(host, port)
 
+        # we don't allow connections if the cooker is running
+        if (self.cooker.state in [bb.cooker.state.parsing, bb.cooker.state.running]):
+            return None
+
+        original_featureset = list(self.cooker.featureset)
+        for f in featureset:
+            self.cooker.featureset.setFeature(f)
+
+        if (original_featureset != list(self.cooker.featureset)):
+            self.cooker.reset()
+
         self.event_handle = bb.event.register_UIHhandler(s)
         return self.event_handle
 
@@ -263,11 +274,12 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         self.connection_token = token
 
 class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
-    def __init__(self, serverImpl, clientinfo=("localhost", 0), observer_only = False):
+    def __init__(self, serverImpl, clientinfo=("localhost", 0), observer_only = False, featureset = []):
         self.connection, self.transport = _create_server(serverImpl.host, serverImpl.port)
         self.clientinfo = clientinfo
         self.serverImpl = serverImpl
         self.observer_only = observer_only
+        self.featureset = featureset
 
     def connect(self):
         if not self.observer_only:
@@ -277,7 +289,8 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
         if token is None:
             return None
         self.transport.set_connection_token(token)
-        self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo)
+
+        self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo, self.featureset)
         for event in bb.event.ui_queue:
             self.events.queue_event(event)
         return self
@@ -301,14 +314,15 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
 
 class BitBakeServer(BitBakeBaseServer):
     def initServer(self, interface = ("localhost", 0)):
+        self.interface = interface
         self.serverImpl = XMLRPCServer(interface)
 
     def detach(self):
         daemonize.createDaemon(self.serverImpl.serve_forever, "bitbake-cookerdaemon.log")
         del self.cooker
 
-    def establishConnection(self):
-        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl)
+    def establishConnection(self, featureset):
+        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, self.interface, False, featureset)
         return self.connection.connect()
 
     def set_connection_token(self, token):
@@ -318,12 +332,13 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
 
     def __init__(self, observer_only = False):
         self.observer_only = observer_only
+        # if we need extra caches, just tell the server to load them all
         pass
 
     def saveConnectionDetails(self, remote):
         self.remote = remote
 
-    def establishConnection(self):
+    def establishConnection(self, featureset):
         # The format of "remote" must be "server:port"
         try:
             [host, port] = self.remote.split(":")
@@ -340,7 +355,7 @@ class BitBakeXMLRPCClient(BitBakeBaseServer):
         except:
             return None
         self.serverImpl = XMLRPCProxyServer(host, port)
-        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only)
+        self.connection = BitBakeXMLRPCServerConnection(self.serverImpl, (ip, 0), self.observer_only, featureset)
         return self.connection.connect()
 
     def endSession(self):
diff --git a/bitbake/lib/bb/ui/hob.py b/bitbake/lib/bb/ui/hob.py
index bc5ee14..154a3b3 100755
--- a/bitbake/lib/bb/ui/hob.py
+++ b/bitbake/lib/bb/ui/hob.py
@@ -46,7 +46,7 @@ from bb.ui.crumbs.hoblistmodel import RecipeListModel, PackageListModel
 from bb.ui.crumbs.hobeventhandler import HobHandler
 from bb.ui.crumbs.builder import Builder
 
-extraCaches = ['bb.cache_extra:HobRecipeInfo']
+featureSet = [bb.cooker.CookerFeatures.HOB_EXTRA_CACHES]
 
 def event_handle_idle_func(eventHandler, hobHandler):
     # Consume as many messages as we can in the time available to us
diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 35590a2..0211b50 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -472,6 +472,9 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                              event.taskid, event.taskstring, event.exitcode)
                 continue
 
+            if isinstance(event, bb.event.DepTreeGenerated):
+                continue
+
             # ignore
             if isinstance(event, (bb.event.BuildBase,
                                   bb.event.StampUpdate,
diff --git a/bitbake/lib/bb/ui/uievent.py b/bitbake/lib/bb/ui/uievent.py
index 038029f..2133b44 100644
--- a/bitbake/lib/bb/ui/uievent.py
+++ b/bitbake/lib/bb/ui/uievent.py
@@ -28,7 +28,7 @@ import socket, threading, pickle
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 
 class BBUIEventQueue:
-    def __init__(self, BBServer, clientinfo=("localhost, 0")):
+    def __init__(self, BBServer, clientinfo=("localhost, 0"), featureset=[]):
 
         self.eventQueue = []
         self.eventQueueLock = threading.Lock()
@@ -44,7 +44,10 @@ class BBUIEventQueue:
         server.register_function( self.send_event, "event.sendpickle" )
         server.socket.settimeout(1)
 
-        self.EventHandle = self.BBServer.registerEventHandler(self.host, self.port)
+        self.EventHandle = self.BBServer.registerEventHandler(self.host, self.port, featureset)
+
+        if (self.EventHandle == None):
+            bb.fatal("Could not register UI event handler")
 
         self.server = server
 
-- 
1.8.1.2


