Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 9612E60589
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 20:19:00 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga102.fm.intel.com with ESMTP; 19 Jul 2016 13:19:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,390,1464678000"; d="scan'208";a="142097541"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2016 13:19:01 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 255AF6A4006;
	Tue, 19 Jul 2016 13:18:49 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Jul 2016 22:54:38 +0300
Message-Id: <1468958078-27587-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] bitbake: implement --foreground command line option
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
X-List-Received-Date: Tue, 19 Jul 2016 20:19:02 -0000

This option makes bitbake xmlrpc server to run in foreground.
It should be useful for debugging purposes.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/main.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 3fc3ff5..09aeb9a 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -247,6 +247,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           help="Run bitbake without a UI, only starting a server "
                                "(cooker) process.")
 
+        parser.add_option("", "--foreground", action="store_true",
+                          help="Run bitbake server in foreground.")
+
         parser.add_option("-B", "--bind", action="store", dest="bind", default=False,
                           help="The name/address for the bitbake server to bind to.")
 
@@ -354,7 +357,8 @@ def start_server(servermodule, configParams, configuration, features):
             if isinstance(event, logging.LogRecord):
                 logger.handle(event)
         raise
-    server.detach()
+    if not configParams.foreground:
+        server.detach()
     cooker.lock.close()
     return server
 
@@ -395,6 +399,10 @@ def bitbake_main(configParams, configuration):
                                   ("the BBSERVER environment variable" if "BBSERVER" in os.environ \
                                    else "the '--remote-server' option"))
 
+    elif configParams.foreground:
+        raise BBMainException("FATAL: The '--foreground' option can only be used "
+                              "with --server-only.\n")
+
     if configParams.bind and configParams.servertype != "xmlrpc":
         raise BBMainException("FATAL: If '-B' or '--bind' is defined, we must "
                               "set the servertype as 'xmlrpc'.\n")
@@ -484,6 +492,8 @@ def bitbake_main(configParams, configuration):
     else:
         print("Bitbake server address: %s, server port: %s" % (server.serverImpl.host,
                                                                server.serverImpl.port))
+        if configParams.foreground:
+            server.serverImpl.serve_forever()
         return 0
 
     return 1
-- 
2.1.4


