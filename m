Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 98E536E268
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Mar 2016 11:34:26 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 17 Mar 2016 04:34:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,349,1455004800"; d="scan'208";a="935930659"
Received: from wmalikow-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.20.136])
	by orsmga002.jf.intel.com with ESMTP; 17 Mar 2016 04:34:26 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Mar 2016 11:34:23 +0000
Message-Id: <1458214463-16103-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH] bitbake: xmlrpc: set single use mode differently
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
X-List-Received-Date: Thu, 17 Mar 2016 11:34:28 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Currently xmlrpc server implicitly sets itself into single use mode
when bitbake server is started with anonymous port (0) or no port is
provided in command line. In this mode bitbake shuts down xmlrpc server
after build is done. This assumption is incorrect in some cases.
For example Toaster uses bitbake in this mode and expects xmlrpc server
to stay in memory.

Till recent changes single use mode was always unset due to the bug.
When the bug was fixed it broke toaster builds as Toaster couldn't
communicate with bitbake server in single use mode.

Reimplemented logic of setting single use mode. The mode is explicity
set when --server-only command line parameter is not provided to bitbake.
It doesn't depend on the port number anymore.

[YOCTO #9275]
[YOCTO #9240]
[YOCTO #9252]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/lib/bb/main.py           | 5 +++--
 bitbake/lib/bb/server/process.py | 2 +-
 bitbake/lib/bb/server/xmlrpc.py  | 8 ++++----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index bf59793..a28c751 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -282,12 +282,13 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
 def start_server(servermodule, configParams, configuration, features):
     server = servermodule.BitBakeServer()
+    single_use = not configParams.server_only
     if configParams.bind:
         (host, port) = configParams.bind.split(':')
-        server.initServer((host, int(port)))
+        server.initServer((host, int(port)), single_use)
         configuration.interface = [ server.serverImpl.host, server.serverImpl.port ]
     else:
-        server.initServer()
+        server.initServer(single_use=single_use)
         configuration.interface = []
 
     try:
diff --git a/bitbake/lib/bb/server/process.py b/bitbake/lib/bb/server/process.py
index e387b30..a3078a8 100644
--- a/bitbake/lib/bb/server/process.py
+++ b/bitbake/lib/bb/server/process.py
@@ -242,7 +242,7 @@ class ProcessEventQueue(multiprocessing.queues.Queue):
 
 
 class BitBakeServer(BitBakeBaseServer):
-    def initServer(self):
+    def initServer(self, single_use=True):
         # establish communication channels.  We use bidirectional pipes for
         # ui <--> server command/response pairs
         # and a queue for server -> ui event notifications
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index a79b490..48d45d8 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -189,12 +189,12 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
     # remove this when you're done with debugging
     # allow_reuse_address = True
 
-    def __init__(self, interface):
+    def __init__(self, interface, single_use=False):
         """
         Constructor
         """
         BaseImplServer.__init__(self)
-        self.single_use = interface[1] == 0 # anonymous port, not getting reused
+        self.single_use = single_use
         # Use auto port configuration
         if (interface[1] == -1):
             interface = (interface[0], 0)
@@ -335,9 +335,9 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
             pass
 
 class BitBakeServer(BitBakeBaseServer):
-    def initServer(self, interface = ("localhost", 0)):
+    def initServer(self, interface = ("localhost", 0), single_use = False):
         self.interface = interface
-        self.serverImpl = XMLRPCServer(interface)
+        self.serverImpl = XMLRPCServer(interface, single_use)
 
     def detach(self):
         daemonize.createDaemon(self.serverImpl.serve_forever, "bitbake-cookerdaemon.log")
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


