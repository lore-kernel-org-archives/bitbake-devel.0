Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S0ZAW-0000cS-1o
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 14:57:12 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 23 Feb 2012 05:48:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="69497558"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 23 Feb 2012 05:48:49 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2012 21:47:18 +0800
Message-Id: <ac1e1c39b6b57c5e41eefdb7d8a80c2553db2255.1330003017.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1330003017.git.dongxiao.xu@intel.com>
References: <cover.1330003017.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1330003017.git.dongxiao.xu@intel.com>
References: <cover.1330003017.git.dongxiao.xu@intel.com>
Subject: [PATCH 6/9] bitbake: Add client socket info for BitBakeServerConnection
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
X-List-Received-Date: Thu, 23 Feb 2012 13:57:12 -0000

In server/client split model, the client will bind to a specific address
and port. We need to pass the values to BitBakeServerConnection().

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/server/xmlrpc.py |    4 ++--
 lib/bb/ui/uievent.py    |    7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index c53cee4..eff8009 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -247,9 +247,9 @@ class BitbakeServerInfo():
         self.port = port
 
 class BitBakeServerConnection():
-    def __init__(self, serverinfo):
+    def __init__(self, serverinfo, clientinfo=("localhost", 0)):
         self.connection = _create_server(serverinfo.host, serverinfo.port)
-        self.events = uievent.BBUIEventQueue(self.connection)
+        self.events = uievent.BBUIEventQueue(self.connection, clientinfo)
         for event in bb.event.ui_queue:
             self.events.queue_event(event)
 
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index 0e73817..28817a2 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -28,13 +28,14 @@ import socket, threading, pickle
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 
 class BBUIEventQueue:
-    def __init__(self, BBServer):
+    def __init__(self, BBServer, clientinfo=("localhost, 0")):
 
         self.eventQueue = []
         self.eventQueueLock = threading.Lock()
         self.eventQueueNotify = threading.Event()
 
         self.BBServer = BBServer
+        self.clientinfo = clientinfo
 
         self.t = threading.Thread()
         self.t.setDaemon(True)
@@ -72,7 +73,7 @@ class BBUIEventQueue:
 
     def startCallbackHandler(self):
 
-        server = UIXMLRPCServer()
+        server = UIXMLRPCServer(self.clientinfo)
         self.host, self.port = server.socket.getsockname()
 
         server.register_function( self.system_quit, "event.quit" )
@@ -98,7 +99,7 @@ class BBUIEventQueue:
 
 class UIXMLRPCServer (SimpleXMLRPCServer):
 
-    def __init__( self, interface = ("localhost", 0) ):
+    def __init__( self, interface ):
         self.quit = False
         SimpleXMLRPCServer.__init__( self,
                                     interface,
-- 
1.7.4.1



