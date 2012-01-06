Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RjCFT-0001J4-J8
	for bitbake-devel@lists.openembedded.org;
	Fri, 06 Jan 2012 17:02:32 +0100
Received: by opal (Postfix, from userid 111)
	id 99AB810339; Fri,  6 Jan 2012 16:02:57 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120106160257.99AB810339@opal>
Date: Fri,  6 Jan 2012 16:02:57 +0000 (UTC)
From: git@git.openembedded.org
Subject: Dongxiao Xu : bitbake: add a new option "--server-only"
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
X-List-Received-Date: Fri, 06 Jan 2012 16:02:34 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 2677254cf9792cee083605267570d93b425cc2db
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=2677254cf9792cee083605267570d93b425cc2db

Author: Dongxiao Xu <dongxiao.xu@intel.com>
Date:   Fri Jan  6 17:02:29 2012 +0800

bitbake: add a new option "--server-only"

Create a new option "--server-only" for bitbake command, which allows
bitbake runs as a server, and let frontend connect the server itself.

"--server-only" should work with "-t xmlrpc", or bitbake will exit.

bitbake --server-only -t xmlrpc will print out the server address and
port information.

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

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
 



