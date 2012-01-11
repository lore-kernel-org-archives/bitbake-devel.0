Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RkoYS-0005Xd-VK
	for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jan 2012 04:08:51 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 10 Jan 2012 19:01:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="96814239"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by orsmga002.jf.intel.com with ESMTP; 10 Jan 2012 19:01:18 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jan 2012 11:03:24 +0800
Message-Id: <2b70816adeae4c278747d52654f3184f5e5a15a3.1326249301.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1326249301.git.dongxiao.xu@intel.com>
References: <cover.1326249301.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1326249301.git.dongxiao.xu@intel.com>
References: <cover.1326249301.git.dongxiao.xu@intel.com>
Subject: [PATCH 5/8] bitbake: add -B option to bind with interface
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
X-List-Received-Date: Wed, 11 Jan 2012 03:08:52 -0000

When start bitbake as a server only process, we need to assign certain
interface to it.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 bin/bitbake             |   15 ++++++++++-----
 lib/bb/server/xmlrpc.py |    6 +++---
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index c2e6822..6e661ce 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -168,6 +168,8 @@ Default BBFILES are the .bb files in the current directory.""")
     parser.add_option("", "--server-only", help = "Run bitbake without UI,  the frontend can connect with bitbake server itself",
                action = "store_true", dest = "server_only", default = False)
 
+    parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
+               action = "store", dest = "bind", default = False)
     options, args = parser.parse_args(sys.argv)
 
     configuration = BBConfiguration(options)
@@ -189,9 +191,6 @@ Default BBFILES are the .bb files in the current directory.""")
         sys.exit("FATAL: Invalid server type '%s' specified.\n"
                  "Valid interfaces: xmlrpc, process [default], none." % servertype)
 
-    if configuration.server_only and configuration.servertype != "xmlrpc":
-        sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
-
     # Save a logfile for cooker into the current working directory. When the
     # server is daemonized this logfile will be truncated.
     cooker_logfile = os.path.join(os.getcwd(), "cooker.log")
@@ -211,9 +210,15 @@ Default BBFILES are the .bb files in the current directory.""")
     # of the UIs (e.g. for DISPLAY, etc.)
     bb.utils.clean_environment()
 
-    server = server.BitBakeServer()
+    if configuration.server_only:
+        if configuration.servertype != "xmlrpc":
+            sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
+        server = server.BitBakeServer()
+        server.initServer((configuration.bind, 0))
+    else:
+        server = server.BitBakeServer()
+        server.initServer()
 
-    server.initServer()
     idle = server.getServerIdleCB()
 
     cooker = bb.cooker.BBCooker(configuration, idle, initialenv)
diff --git a/lib/bb/server/xmlrpc.py b/lib/bb/server/xmlrpc.py
index b5980c6..c53cee4 100644
--- a/lib/bb/server/xmlrpc.py
+++ b/lib/bb/server/xmlrpc.py
@@ -163,7 +163,7 @@ class BitBakeXMLRPCServer(SimpleXMLRPCServer):
     # remove this when you're done with debugging
     # allow_reuse_address = True
 
-    def __init__(self, interface = ("localhost", 0)):
+    def __init__(self, interface):
         """
         Constructor
         """
@@ -267,8 +267,8 @@ class BitBakeServerConnection():
             pass
 
 class BitBakeServer(object):
-    def initServer(self):
-        self.server = BitBakeXMLRPCServer()
+    def initServer(self, interface = ("localhost", 0)):
+        self.server = BitBakeXMLRPCServer(interface)
 
     def addcooker(self, cooker):
         self.cooker = cooker
-- 
1.7.0.4



