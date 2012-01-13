Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RlccC-0002PY-Rc
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Jan 2012 09:36:01 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 13 Jan 2012 00:28:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="95425177"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by azsmga001.ch.intel.com with ESMTP; 13 Jan 2012 00:28:27 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2012 16:30:39 +0800
Message-Id: <4bfbde39d247225b88d43793b1ded75ccbd157c7.1326442655.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1326442655.git.dongxiao.xu@intel.com>
References: <cover.1326442655.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1326442655.git.dongxiao.xu@intel.com>
References: <cover.1326442655.git.dongxiao.xu@intel.com>
Subject: [PATCH 5/9] bitbake: add -B option to bind with interface
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
X-List-Received-Date: Fri, 13 Jan 2012 08:36:01 -0000

When start bitbake as a server only process, we need to assign certain
interface to it.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 bin/bitbake             |   17 ++++++++++++++---
 lib/bb/server/xmlrpc.py |    6 +++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index c2e6822..a180373 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -168,6 +168,8 @@ Default BBFILES are the .bb files in the current directory.""")
     parser.add_option("", "--server-only", help = "Run bitbake without UI,  the frontend can connect with bitbake server itself",
                action = "store_true", dest = "server_only", default = False)
 
+    parser.add_option("-B", "--bind", help = "The name/address for the bitbake server to bind to",
+               action = "store", dest = "bind", default = False)
     options, args = parser.parse_args(sys.argv)
 
     configuration = BBConfiguration(options)
@@ -189,8 +191,14 @@ Default BBFILES are the .bb files in the current directory.""")
         sys.exit("FATAL: Invalid server type '%s' specified.\n"
                  "Valid interfaces: xmlrpc, process [default], none." % servertype)
 
-    if configuration.server_only and configuration.servertype != "xmlrpc":
-        sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
+    if configuration.server_only:
+        if configuration.servertype != "xmlrpc":
+            sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
+        if not configuration.bind:
+            sys.exit("FATAL: The '--server-only' option requires a name/address to bind to with the -B option.\n")
+
+    if configuration.bind and configuration.servertype != "xmlrpc":
+        sys.exit("FATAL: If '-B' or '--bind' is defined, we must set the servertype as 'xmlrpc'.\n")
 
     # Save a logfile for cooker into the current working directory. When the
     # server is daemonized this logfile will be truncated.
@@ -212,8 +220,11 @@ Default BBFILES are the .bb files in the current directory.""")
     bb.utils.clean_environment()
 
     server = server.BitBakeServer()
+    if configuration.bind:
+        server.initServer((configuration.bind, 0))
+    else:
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



