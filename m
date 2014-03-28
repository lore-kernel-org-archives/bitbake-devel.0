Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 0B4C96CE74
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 17:06:57 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2SH6qVj028292 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 17:06:52 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SmYGQHy7Ttjn for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 17:06:52 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2SH6mvV028289
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 17:06:49 GMT
Message-ID: <1396026403.14790.7.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Mar 2014 17:06:43 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] server/xmlrpc: Simlify featureset handling
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
X-List-Received-Date: Fri, 28 Mar 2014 17:06:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Rather than passing featureset around various places where the data doesn't
really belong, run a command at connection time to set the appropriate
features. This is similar to what the process server does.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 46d074a..bf867b5 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -89,7 +89,7 @@ class BitBakeServerCommands():
         self.server = server
         self.has_client = False
 
-    def registerEventHandler(self, host, port, featureset = []):
+    def registerEventHandler(self, host, port):
         """
         Register a remote UI Event Handler
         """
@@ -99,13 +99,6 @@ class BitBakeServerCommands():
         if (self.cooker.state in [bb.cooker.state.parsing, bb.cooker.state.running]):
             return None
 
-        original_featureset = list(self.cooker.featureset)
-        for f in featureset:
-            self.cooker.featureset.setFeature(f)
-
-        if (original_featureset != list(self.cooker.featureset)):
-            self.cooker.reset()
-
         self.event_handle = bb.event.register_UIHhandler(s)
         return self.event_handle
 
@@ -293,9 +286,15 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
             return None
         self.transport.set_connection_token(token)
 
-        self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo, self.featureset)
+        self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo)
         for event in bb.event.ui_queue:
             self.events.queue_event(event)
+
+        _, error = self.connection.runCommand(["setFeatures", self.featureset])
+        if error:
+            logger.error("Unable to set the cooker to the correct featureset: %s" % error)
+            raise BaseException(error)
+
         return self
 
     def removeClient(self):
diff --git a/bitbake/lib/bb/ui/uievent.py b/bitbake/lib/bb/ui/uievent.py
index 2133b44..98658f6 100644
--- a/bitbake/lib/bb/ui/uievent.py
+++ b/bitbake/lib/bb/ui/uievent.py
@@ -28,7 +28,7 @@ import socket, threading, pickle
 from SimpleXMLRPCServer import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 
 class BBUIEventQueue:
-    def __init__(self, BBServer, clientinfo=("localhost, 0"), featureset=[]):
+    def __init__(self, BBServer, clientinfo=("localhost, 0")):
 
         self.eventQueue = []
         self.eventQueueLock = threading.Lock()
@@ -44,7 +44,7 @@ class BBUIEventQueue:
         server.register_function( self.send_event, "event.sendpickle" )
         server.socket.settimeout(1)
 
-        self.EventHandle = self.BBServer.registerEventHandler(self.host, self.port, featureset)
+        self.EventHandle = self.BBServer.registerEventHandler(self.host, self.port)
 
         if (self.EventHandle == None):
             bb.fatal("Could not register UI event handler")



