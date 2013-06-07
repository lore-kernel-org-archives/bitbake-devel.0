Return-Path: <ddalex@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 34DAD6A8EB
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Jun 2013 16:03:12 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 07 Jun 2013 09:03:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,822,1363158000"; d="scan'208";a="349756464"
Received: from adamian-desktop.isw.intel.com (HELO
	adamian-desktop.rb.intel.com) ([10.237.224.34])
	by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2013 09:03:05 -0700
Received: by adamian-desktop.rb.intel.com (Postfix, from userid 1000)
	id DD7F556075C; Fri,  7 Jun 2013 17:03:07 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: richard.purdie@linuxfoundation.org,
	bitbake-devel@lists.openembedded.org
Date: Fri,  7 Jun 2013 17:03:06 +0100
Message-Id: <1370620986-23507-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH] xmlrpc: removes the event servers controller
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
X-List-Received-Date: Fri, 07 Jun 2013 16:03:12 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

XMLRPC API ran a XMLRPC server at port+2 in order
to provide endpoints to register an event server
in which to dump the events.

This is no longer used, so we remove it.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/server/xmlrpc.py | 59 -------------------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index 1b3502e..44cea10 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -272,59 +272,6 @@ class BitBakeUIEventServer(threading.Thread):
             if evt:
                 self.connection.event.sendpickle(pickle.dumps(evt))
 
-class BitBakeXMLRPCEventServerController(SimpleXMLRPCServer, threading.Thread):
-    def __init__(self, interface):
-        SimpleXMLRPCServer.__init__(self, interface, logRequests=False, allow_none=True)
-        threading.Thread.__init__(self)
-        self.register_function(self.registerEventHandler, "registerEventHandler")
-        self.register_function(self.unregisterEventHandler, "unregisterEventHandler")
-        self.register_function(self.terminateServer, "terminateServer")
-        #self.register_function(self.runCommand, "runCommand")
-        self.quit = False
-        self.clients = {}
-        self.client_ui_ids = {}
-        self.timeout = 1    # timeout for .handle_request()
-
-    def registerEventHandler(self, host, port):
-        """
-        Register a remote UI Event Handler
-        """
-        connection = xmlrpclib.ServerProxy("http://%s:%d/" % (host, port), allow_none=True)
-        client_hash = "%s:%d" % (host, port)
-        if self.clients.has_key(client_hash):
-            return None
-        client_ui_server = BitBakeUIEventServer(connection)
-        self.client_ui_ids[client_hash] = bb.event.register_UIHhandler(client_ui_server)
-        client_ui_server.start()
-        self.clients[client_hash] = client_ui_server
-        return client_hash
-
-    def unregisterEventHandler(self, client_hash):
-        """
-        Unregister a remote UI Event Handler
-        """
-        client_thread = self.clients[client_hash]
-        if client_thread:
-            bb.event.unregister_UIHhandler(self.clients_ui_ids[client_hash])
-            client_thread.terminateServer()
-            client_thread.join()
-            return True
-        else:
-            return False
-
-    def terminateServer(self):
-        self.quit = True
-
-    def runCommand(self, cmd):
-        return None
-
-    def run(self):
-        self.serve_forever()
-
-    def serve_forever(self):
-        while not self.quit:
-            self.handle_request()
-        self.server_close()
 
 class XMLRPCProxyServer(BaseImplServer):
     """ not a real working server, but a stub for a proxy server connection
@@ -369,9 +316,6 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
 
 
     def serve_forever(self):
-        # Create and run the event server controller in a separate thread
-        self.event_controller_thread = BitBakeXMLRPCEventServerController((self.host, self.port + 2))
-        self.event_controller_thread.start()
         # Start the actual XMLRPC server
         bb.cooker.server_main(self.cooker, self._serve_forever)
 
@@ -414,9 +358,6 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
                 retval = function(self, data, True)
             except:
                 pass
-        # Terminate the event server
-        self.event_controller_thread.terminateServer()
-        self.event_controller_thread.join()
         self.server_close()
         return
 
-- 
1.8.1.2


