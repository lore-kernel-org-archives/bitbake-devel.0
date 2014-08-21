Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 29E5E65D56
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 09:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7L9RD0F028222 for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 10:27:13 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FPy5ol9C3vYI for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 10:27:13 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s7L9R9Jq028218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Aug 2014 10:27:11 +0100
Message-ID: <1408613230.1669.111.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 21 Aug 2014 10:27:10 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] process: Further improve robustness against server shutdown
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
X-List-Received-Date: Thu, 21 Aug 2014 09:27:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, if an exception occurs in an event handler, the server shuts
down but the UI simply hangs. This happens in two places, firstly waiting
for events and secondly, sending events to a server which no longer exists.

The latter does time out, the former does not. These patches improve
both code sections to check if the main server process is alive and if not,
trigger things to shut down gracefully. This avoids the timeout in the
command sending case too.

This resolves various cases where the UI would simply hang indefintely.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index 7fdf964..cb2a56a 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -38,14 +38,18 @@ from . import BitBakeBaseServer, BitBakeBaseServerConnection, BaseImplServer
 logger = logging.getLogger('BitBake')
 
 class ServerCommunicator():
-    def __init__(self, connection, event_handle):
+    def __init__(self, connection, event_handle, server):
         self.connection = connection
         self.event_handle = event_handle
+        self.server = server
 
     def runCommand(self, command):
         # @todo try/except
         self.connection.send(command)
 
+        if not self.server.is_alive():
+            raise SystemExit
+
         while True:
             # don't let the user ctrl-c while we're waiting for a response
             try:
@@ -160,7 +164,7 @@ class BitBakeProcessServerConnection(BitBakeBaseServerConnection):
         self.procserver = serverImpl
         self.ui_channel = ui_channel
         self.event_queue = event_queue
-        self.connection = ServerCommunicator(self.ui_channel, self.procserver.event_handle)
+        self.connection = ServerCommunicator(self.ui_channel, self.procserver.event_handle, self.procserver)
         self.events = self.event_queue
 
     def sigterm_terminate(self):
@@ -199,14 +203,20 @@ class ProcessEventQueue(multiprocessing.queues.Queue):
 
     def waitEvent(self, timeout):
         if self.exit:
-            raise KeyboardInterrupt()
+            raise SystemExit
         try:
+            if not self.server.is_alive():
+                self.setexit()
+                return None
             return self.get(True, timeout)
         except Empty:
             return None
 
     def getEvent(self):
         try:
+            if not self.server.is_alive():
+                self.setexit()
+                return None
             return self.get(False)
         except Empty:
             return None
@@ -221,6 +231,7 @@ class BitBakeServer(BitBakeBaseServer):
         self.ui_channel, self.server_channel = Pipe()
         self.event_queue = ProcessEventQueue(0)
         self.serverImpl = ProcessServer(self.server_channel, self.event_queue, None)
+        self.event_queue.server = self.serverImpl
 
     def detach(self):
         self.serverImpl.start()



