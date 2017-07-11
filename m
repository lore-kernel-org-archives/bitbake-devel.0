Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 5D03B77FFE
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 10:27:49 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v6BARpih009205
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Jul 2017 03:27:51 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Tue, 11 Jul 2017 03:27:50 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 11 Jul 2017 03:27:47 -0700
Message-ID: <6ac9d7284582c24980f15872af5ab65c07302e8b.1499768495.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1499768495.git.liezhi.yang@windriver.com>
References: <cover.1499768495.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [RFC PATCH 2/3] bitbake: lib: fix --observe-only
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
X-List-Received-Date: Tue, 11 Jul 2017 10:27:50 -0000
Content-Type: text/plain

Fixed:
$ . ../poky/oe-init-build-env-memres .
$ bitbake world
In another terminal
$ . ../poky/oe-init-build-env-memres .
$ bitbake --observe-only
Traceback (most recent call last):
  File "/buildarea/lyang1/poky/bitbake/bin/bitbake", line 48, in <module>
    cookerdata.CookerConfiguration()))
  File "/buildarea/lyang1/poky/bitbake/lib/bb/main.py", line 456, in bitbake_main
    server, server_connection, ui_module = setup_bitbake(configParams, configuration)
  File "/buildarea/lyang1/poky/bitbake/lib/bb/main.py", line 544, in setup_bitbake
    server_connection.setupEventQueue()
  File "/buildarea/lyang1/poky/bitbake/lib/bb/server/xmlrpc.py", line 363, in setupEventQueue
    self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo)
  File "/buildarea/lyang1/poky/bitbake/lib/bb/ui/uievent.py", line 72, in __init__
    raise Exception(errmsg)
Exception: Could not register UI event handler. Error: Cooker is busy: running, host 127.0.0.1, port 36350
WARNING: Could not register UI event handler. Error: Cooker is busy: running, host 127.0.0.1, port 36350, retry
[snip]

This was becuase xmlrpc doesn't allow connections when cooker is running, but
--observe-only doesn't do any builds, so allow it to connect is safe.

[YOCTO #10731]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/main.py          |  2 +-
 bitbake/lib/bb/server/xmlrpc.py | 13 ++++++++-----
 bitbake/lib/bb/ui/uievent.py    |  5 +++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 29e391162e6..f998e9dfef4 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -541,7 +541,7 @@ def setup_bitbake(configParams, configuration, extrafeatures=None, setup_logging
             bb.event.ui_queue = []
             return None, None, None
 
-        server_connection.setupEventQueue()
+        server_connection.setupEventQueue(configParams.observe_only)
 
         # Restore the environment in case the UI needs it
         for k in cleanedvars:
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 1a475e04ba5..bbc37d72f9b 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -108,14 +108,14 @@ class BitBakeServerCommands():
         self.server = server
         self.has_client = False
 
-    def registerEventHandler(self, host, port):
+    def registerEventHandler(self, host, port, observe_only=False):
         """
         Register a remote UI Event Handler
         """
         s, t = _create_server(host, port)
 
-        # we don't allow connections if the cooker is running
-        if (self.cooker.state in [bb.cooker.state.parsing, bb.cooker.state.running]):
+        # Only allow observe_only connections if the cooker is running
+        if (self.cooker.state in [bb.cooker.state.parsing, bb.cooker.state.running]) and not observe_only:
             return None, "Cooker is busy: %s" % bb.cooker.state.get_name(self.cooker.state)
 
         self.event_handle = bb.event.register_UIHhandler(s, True)
@@ -359,11 +359,14 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
         self.transport.set_connection_token(token)
         return self
 
-    def setupEventQueue(self):
-        self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo)
+    def setupEventQueue(self, observe_only=False):
+        self.events = uievent.BBUIEventQueue(self.connection, self.clientinfo, observe_only)
         for event in bb.event.ui_queue:
             self.events.queue_event(event)
 
+        if observe_only:
+            return
+
         _, error = self.connection.runCommand(["setFeatures", self.featureset])
         if error:
             # disconnect the client, we can't make the setFeature work
diff --git a/bitbake/lib/bb/ui/uievent.py b/bitbake/lib/bb/ui/uievent.py
index 9542b911ca0..7dfe02c6c97 100644
--- a/bitbake/lib/bb/ui/uievent.py
+++ b/bitbake/lib/bb/ui/uievent.py
@@ -28,7 +28,7 @@ import socket, threading, pickle, collections
 from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
 
 class BBUIEventQueue:
-    def __init__(self, BBServer, clientinfo=("localhost, 0")):
+    def __init__(self, BBServer, clientinfo=("localhost, 0"), observe_only=False):
 
         self.eventQueue = []
         self.eventQueueLock = threading.Lock()
@@ -36,6 +36,7 @@ class BBUIEventQueue:
 
         self.BBServer = BBServer
         self.clientinfo = clientinfo
+        self.observe_only = observe_only
 
         server = UIXMLRPCServer(self.clientinfo)
         self.host, self.port = server.socket.getsockname()
@@ -51,7 +52,7 @@ class BBUIEventQueue:
         # giving up
 
         for count_tries in range(5):
-            ret = self.BBServer.registerEventHandler(self.host, self.port)
+            ret = self.BBServer.registerEventHandler(self.host, self.port, self.observe_only)
 
             if isinstance(ret, collections.Iterable):
                 self.EventHandle, error = ret
-- 
2.11.0


