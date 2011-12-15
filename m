Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rb5eF-0001Ne-Ux
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Dec 2011 08:22:36 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 14 Dec 2011 23:14:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="102431910"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.108])
	by fmsmga002.fm.intel.com with ESMTP; 14 Dec 2011 23:14:29 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Dec 2011 15:15:01 +0800
Message-Id: <6c0d893a1dd1615fa3ef22d8e5115bfc4c975773.1323933009.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1323933009.git.dongxiao.xu@intel.com>
References: <cover.1323933009.git.dongxiao.xu@intel.com>
Subject: [PATCH 10/10] bitbake: add a new option "--server-only"
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
X-List-Received-Date: Thu, 15 Dec 2011 07:22:36 -0000

Create a new option "--server-only" for bitbake command, which allows
bitbake runs as a server, and let frontend connect the server itself.

"--server-only" should work with "-t xmlrpc", or bitbake will exit.

bitbake --server-only -t xmlrpc will print out the server address and
port information.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 bin/bitbake |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 9eb558b..c2e6822 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -165,6 +165,9 @@ Default BBFILES are the .bb files in the current directory.""")
     parser.add_option("", "--revisions-changed", help = "Set the exit code depending on whether upstream floating revisions have changed or not",
                action = "store_true", dest = "revisions_changed", default = False)
 
+    parser.add_option("", "--server-only", help = "Run bitbake without UI,  the frontend can connect with bitbake server itself",
+               action = "store_true", dest = "server_only", default = False)
+
     options, args = parser.parse_args(sys.argv)
 
     configuration = BBConfiguration(options)
@@ -186,6 +189,9 @@ Default BBFILES are the .bb files in the current directory.""")
         sys.exit("FATAL: Invalid server type '%s' specified.\n"
                  "Valid interfaces: xmlrpc, process [default], none." % servertype)
 
+    if configuration.server_only and configuration.servertype != "xmlrpc":
+        sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
+
     # Save a logfile for cooker into the current working directory. When the
     # server is daemonized this logfile will be truncated.
     cooker_logfile = os.path.join(os.getcwd(), "cooker.log")
@@ -222,14 +228,17 @@ Default BBFILES are the .bb files in the current directory.""")
 
     logger.removeHandler(handler)
 
-    # Setup a connection to the server (cooker)
-    server_connection = server.establishConnection()
+    if not configuration.server_only:
+        # Setup a connection to the server (cooker)
+        server_connection = server.establishConnection()
 
-    try:
-        return server.launchUI(ui_main, server_connection.connection, server_connection.events)
-    finally:
-        bb.event.ui_queue = []
-        server_connection.terminate()
+        try:
+            return server.launchUI(ui_main, server_connection.connection, server_connection.events)
+        finally:
+            bb.event.ui_queue = []
+            server_connection.terminate()
+    else:
+        print("server address: %s, server port: %s" % (server.serverinfo.host, server.serverinfo.port))
 
     return 1
 
-- 
1.7.0.4



