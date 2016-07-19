Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id C8F4460589
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 20:44:58 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 19 Jul 2016 13:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,390,1464678000"; d="scan'208";a="736825096"
Received: from linux.intel.com ([10.54.29.200])
	by FMSMGA003.fm.intel.com with ESMTP; 19 Jul 2016 13:44:59 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 9714F6A4006;
	Tue, 19 Jul 2016 13:44:49 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Jul 2016 23:20:34 +0300
Message-Id: <1468959634-28100-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bitbake: implement idle timeout for xmlrpc server
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
X-List-Received-Date: Tue, 19 Jul 2016 20:45:00 -0000

Idle timeout can be specified either by -T/--idle-timeout option or
by sessing BBTIMEOUT environment variable. Bitbake xmlrpc server
will unload itself when timeout exprired, i.e. when server is idle
for more than <idle timeout> seconds.

[YOCTO #5534]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/main.py          |  7 ++++++-
 bitbake/lib/bb/server/xmlrpc.py | 19 ++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 849cade..7f7d87b 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -253,6 +253,10 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         parser.add_option("-B", "--bind", action="store", dest="bind", default=False,
                           help="The name/address for the bitbake server to bind to.")
 
+        parser.add_option("-T", "--idle-timeout", type=int,
+                          default=int(os.environ.get("BBTIMEOUT", "0")),
+                          help="Set timeout to unload bitbake server due to inactivity")
+
         parser.add_option("", "--no-setscene", action="store_true",
                           dest="nosetscene", default=False,
                           help="Do not run any setscene tasks. sstate will be ignored and "
@@ -337,7 +341,8 @@ def start_server(servermodule, configParams, configuration, features):
     single_use = not configParams.server_only and os.getenv('BBSERVER') != 'autostart'
     if configParams.bind:
         (host, port) = configParams.bind.split(':')
-        server.initServer((host, int(port)), single_use=single_use)
+        server.initServer((host, int(port)), single_use=single_use,
+                          idle_timeout=configParams.idle_timeout)
         configuration.interface = [server.serverImpl.host, server.serverImpl.port]
     else:
         server.initServer(single_use=single_use)
diff --git a/bitbake/lib/bb/server/xmlrpc.py b/bitbake/lib/bb/server/xmlrpc.py
index 4131b52..452f14b 100644
--- a/bitbake/lib/bb/server/xmlrpc.py
+++ b/bitbake/lib/bb/server/xmlrpc.py
@@ -205,7 +205,7 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
     # remove this when you're done with debugging
     # allow_reuse_address = True
 
-    def __init__(self, interface, single_use=False):
+    def __init__(self, interface, single_use=False, idle_timeout=0):
         """
         Constructor
         """
@@ -223,6 +223,10 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
         self.commands = BitBakeServerCommands(self)
         self.autoregister_all_functions(self.commands, "")
         self.interface = interface
+        self.time = time.time()
+        self.idle_timeout = idle_timeout
+        if idle_timeout:
+            self.register_idle_function(self.handle_idle_timeout, self)
 
     def addcooker(self, cooker):
         BaseImplServer.addcooker(self, cooker)
@@ -238,6 +242,12 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
             if name.startswith(prefix):
                 self.register_function(method, name[len(prefix):])
 
+    def handle_idle_timeout(self, server, data, abort):
+        if not abort:
+            if time.time() - server.time > server.idle_timeout:
+                server.quit = True
+                print("Server idle timeout expired")
+        return []
 
     def serve_forever(self):
         # Start the actual XMLRPC server
@@ -280,6 +290,8 @@ class XMLRPCServer(SimpleXMLRPCServer, BaseImplServer):
             try:
                 fd_sets = select.select(fds, [], [], socktimeout)
                 if fd_sets[0] and self in fd_sets[0]:
+                    if self.idle_timeout:
+                        self.time = time.time()
                     self._handle_request_noblock()
             except IOError:
                 # we ignore interrupted calls
@@ -351,9 +363,10 @@ class BitBakeXMLRPCServerConnection(BitBakeBaseServerConnection):
             pass
 
 class BitBakeServer(BitBakeBaseServer):
-    def initServer(self, interface = ("localhost", 0), single_use = False):
+    def initServer(self, interface = ("localhost", 0),
+                   single_use = False, idle_timeout=0):
         self.interface = interface
-        self.serverImpl = XMLRPCServer(interface, single_use)
+        self.serverImpl = XMLRPCServer(interface, single_use, idle_timeout)
 
     def detach(self):
         daemonize.createDaemon(self.serverImpl.serve_forever, "bitbake-cookerdaemon.log")
-- 
2.1.4


