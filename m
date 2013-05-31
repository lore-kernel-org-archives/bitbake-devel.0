Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 2929860991
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 May 2013 11:07:08 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 31 May 2013 04:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,778,1363158000"; d="scan'208";a="322400567"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by orsmga001.jf.intel.com with ESMTP; 31 May 2013 04:06:50 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id 21C745607A1; Fri, 31 May 2013 12:06:51 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Fri, 31 May 2013 12:06:47 +0100
Message-Id: <1369998409-16560-2-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1369998409-16560-1-git-send-email-alexandru.damian@intel.com>
References: <1369998409-16560-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 2/4] xmlrpc: fixes for bitbake resident server
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
X-List-Received-Date: Fri, 31 May 2013 11:07:08 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch enables the XMLRPC server to remain
resident in memory after a task is run, and to accept
a new controlling client. To check the server after
task completion, do

lsof bitbake.lock

in the build directory. Kill the server with kill.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/server/xmlrpc.py | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 2747ed8..0b51ebd 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -227,7 +227,6 @@ class BitBakeXMLRPCRequestHandler(SimpleXMLRPCRequestHandler):
         self.end_headers()
         self.wfile.write(response)
 
-
 class BitBakeUIEventServer(threading.Thread):
     class EventAdapter():
         """
@@ -273,9 +272,10 @@ class BitBakeUIEventServer(threading.Thread):
             if evt:
                 self.connection.event.sendpickle(pickle.dumps(evt))
 
-class BitBakeXMLRPCEventServerController(SimpleXMLRPCServer):
+class BitBakeXMLRPCEventServerController(SimpleXMLRPCServer, threading.Thread):
     def __init__(self, interface):
         SimpleXMLRPCServer.__init__(self, interface, logRequests=False, allow_none=True)
+        threading.Thread.__init__(self)
         self.register_function(self.registerEventHandler, "registerEventHandler")
         self.register_function(self.unregisterEventHandler, "unregisterEventHandler")
         self.register_function(self.terminateServer, "terminateServer")
@@ -283,6 +283,7 @@ class BitBakeXMLRPCEventServerController(SimpleXMLRPCServer):
         self.quit = False
         self.clients = {}
         self.client_ui_ids = {}
+        self.timeout = 1    # timeout for .handle_request()
 
     def registerEventHandler(self, host, port):
         """
@@ -317,13 +318,14 @@ class BitBakeXMLRPCEventServerController(SimpleXMLRPCServer):
     def runCommand(self, cmd):
         return None
 
-    def serve_forever(self, main_server):
-        self.main_server = main_server
+    def run(self):
+        self.serve_forever()
+
+    def serve_forever(self):
         while not self.quit:
             self.handle_request()
         self.server_close()
 
-
 class XMLRPCProxyServer(BaseImplServer):
     """ not a real working server, but a stub for a proxy server connection
 
@@ -368,15 +370,11 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
 
     def serve_forever(self):
         # Create and run the event server controller in a separate thread
-        evt_server_ctrl = BitBakeXMLRPCEventServerController((self.host, self.port + 2))
-        self.event_controller_thread = threading.Thread(target = evt_server_ctrl.serve_forever, args = (self,))
+        self.event_controller_thread = BitBakeXMLRPCEventServerController((self.host, self.port + 2))
         self.event_controller_thread.start()
         # Start the actual XMLRPC server
         bb.cooker.server_main(self.cooker, self._serve_forever)
 
-    def removeClient(self):
-        self.commands.removeClient()
-
     def _serve_forever(self):
         """
         Serve Requests. Overloaded to honor a quit command
@@ -453,7 +451,7 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
         except:
             pass
         try:
-            self.connection.terminateServer()
+            self.connection.removeClient()
         except:
             pass
 
-- 
1.8.1.2


