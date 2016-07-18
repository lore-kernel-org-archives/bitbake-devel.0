Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 298126FFD4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jul 2016 16:32:27 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 18 Jul 2016 09:32:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,384,1464678000"; d="scan'208";a="848550729"
Received: from linux.intel.com ([10.54.29.200])
	by orsmga003.jf.intel.com with ESMTP; 18 Jul 2016 09:32:28 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id 39D4D6A4080
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jul 2016 09:32:19 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jul 2016 19:07:18 +0300
Message-Id: <b9277d7a104783685f196b5a34621299bd808a31.1468857803.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1468857803.git.ed.bartosh@linux.intel.com>
References: <cover.1468857803.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1468857803.git.ed.bartosh@linux.intel.com>
References: <cover.1468857803.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 3/3] bitbake: main: implement server autostart feature
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
X-List-Received-Date: Mon, 18 Jul 2016 16:32:29 -0000

If environment variable BBSERVER == 'autostart' bitbake will
automatically load server if it's not running yet.

If host and port are in bitbake.lock then bitbake tries to check
if server is running and responses to commands and starts new
server only if this check fails.

[YOCTO #5534]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/main.py | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 3fc3ff5..1c32e93 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -303,8 +303,10 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
 
         # if BBSERVER says to autodetect, let's do that
         if options.remote_server:
-            [host, port] = options.remote_server.split(":", 2)
-            port = int(port)
+            port = -1
+            if options.remote_server != 'autostart':
+                host, port = options.remote_server.split(":", 2)
+                port = int(port)
             # use automatic port if port set to -1, means read it from
             # the bitbake.lock file; this is a bit tricky, but we always expect
             # to be in the base of the build directory if we need to have a
@@ -321,17 +323,18 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                     lf.close()
                     options.remote_server = remotedef
                 except Exception as e:
-                    raise BBMainException("Failed to read bitbake.lock (%s), invalid port" % str(e))
+                    if options.remote_server != 'autostart':
+                        raise BBMainException("Failed to read bitbake.lock (%s), invalid port" % str(e))
 
         return options, targets[1:]
 
 
 def start_server(servermodule, configParams, configuration, features):
     server = servermodule.BitBakeServer()
-    single_use = not configParams.server_only
+    single_use = not configParams.server_only and os.getenv('BBSERVER') != 'autostart'
     if configParams.bind:
         (host, port) = configParams.bind.split(':')
-        server.initServer((host, int(port)), single_use)
+        server.initServer((host, int(port)), single_use=single_use)
         configuration.interface = [server.serverImpl.host, server.serverImpl.port]
     else:
         server.initServer(single_use=single_use)
@@ -445,6 +448,14 @@ def bitbake_main(configParams, configuration):
         server = start_server(servermodule, configParams, configuration, featureset)
         bb.event.ui_queue = []
     else:
+        if os.getenv('BBSERVER') == 'autostart':
+            if configParams.remote_server == 'autostart' or \
+               not servermodule.check_connection(configParams.remote_server, timeout=2):
+                configParams.bind = 'localhost:0'
+                srv = start_server(servermodule, configParams, configuration, featureset)
+                configParams.remote_server = '%s:%d' % tuple(configuration.interface)
+                bb.event.ui_queue = []
+
         # we start a stub server that is actually a XMLRPClient that connects to a real server
         server = servermodule.BitBakeXMLRPCClient(configParams.observe_only,
                                                   configParams.xmlrpctoken)
-- 
2.1.4


