Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id DD54B700FD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Apr 2016 10:37:40 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP; 25 Apr 2016 03:37:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,532,1455004800"; d="scan'208";a="962137182"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 25 Apr 2016 03:37:22 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id B69706A4006;
	Mon, 25 Apr 2016 04:24:57 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Apr 2016 11:16:30 +0300
Message-Id: <1461572190-17421-4-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1461572190-17421-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1461572190-17421-1-git-send-email-ed.bartosh@linux.intel.com>
Subject: [PATCH 4/4] bitbake: main: fix invalid variable names
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
X-List-Received-Date: Mon, 25 Apr 2016 10:37:41 -0000

Fixed the follwoing pylint warnings:
  C:118, 8: Invalid variable name "s" (invalid-name)
  C:307,20: Invalid variable name "lf" (invalid-name)
  C:313,36: Invalid variable name "e" (invalid-name)
  C:319, 0: Invalid argument name "configParams" (invalid-name)
  C:337,24: Invalid variable name "e" (invalid-name)
  C:356, 0: Invalid argument name "configParams" (invalid-name)
  C:447,28: Invalid variable name "e" (invalid-name)

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/main.py | 81 +++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 40 deletions(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 60c7da3..0f5635b 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -115,8 +115,8 @@ def _showwarning(message, category, filename, lineno, file=None, line=None):
         if _warnings_showwarning is not None:
             _warnings_showwarning(message, category, filename, lineno, file, line)
     else:
-        s = warnings.formatwarning(message, category, filename, lineno)
-        warnlog.warn(s)
+        warning = warnings.formatwarning(message, category, filename, lineno)
+        warnlog.warn(warning)
 
 warnings.showwarning = _showwarning
 warnings.filterwarnings("ignore")
@@ -304,23 +304,24 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                 # we try to read the address at all times; if the server is not started,
                 # we'll try to start it after the first connect fails, below
                 try:
-                    lf = open(lock_location, 'r')
-                    remotedef = lf.readline()
+                    lockf = open(lock_location, 'r')
+                    remotedef = lockf.readline()
                     [host, port] = remotedef.split(":")
                     port = int(port)
-                    lf.close()
+                    lockf.close()
                     options.remote_server = remotedef
-                except Exception as e:
-                    raise BBMainException("Failed to read bitbake.lock (%s), invalid port" % str(e))
+                except Exception as err:
+                    raise BBMainException("Failed to read bitbake.lock (%s), "
+                                          "invalid port" % str(err))
 
         return options, targets[1:]
 
 
-def start_server(servermodule, configParams, configuration, features):
+def start_server(servermodule, configparams, configuration, features):
     server = servermodule.BitBakeServer()
-    single_use = not configParams.server_only
-    if configParams.bind:
-        (host, port) = configParams.bind.split(':')
+    single_use = not configparams.server_only
+    if configparams.bind:
+        (host, port) = configparams.bind.split(':')
         server.initServer((host, int(port)), single_use)
         configuration.interface = [server.serverImpl.host, server.serverImpl.port]
     else:
@@ -334,7 +335,7 @@ def start_server(servermodule, configParams, configuration, features):
 
         server.addcooker(cooker)
         server.saveConnectionDetails()
-    except Exception as e:
+    except Exception:
         exc_info = sys.exc_info()
         while hasattr(server, "event_queue"):
             try:
@@ -353,7 +354,7 @@ def start_server(servermodule, configParams, configuration, features):
     return server
 
 
-def bitbake_main(configParams, configuration):
+def bitbake_main(configparams, configuration):
 
     # Python multiprocessing requires /dev/shm on Linux
     if sys.platform.startswith('linux') and not os.access('/dev/shm', os.W_OK | os.X_OK):
@@ -369,36 +370,36 @@ def bitbake_main(configParams, configuration):
         pass
 
 
-    configuration.setConfigParameters(configParams)
+    configuration.setConfigParameters(configparams)
 
-    ui_module = import_extension_module(bb.ui, configParams.ui, 'main')
-    servermodule = import_extension_module(bb.server, configParams.servertype, 'BitBakeServer')
+    ui_module = import_extension_module(bb.ui, configparams.ui, 'main')
+    servermodule = import_extension_module(bb.server, configparams.servertype, 'BitBakeServer')
 
-    if configParams.server_only:
-        if configParams.servertype != "xmlrpc":
+    if configparams.server_only:
+        if configparams.servertype != "xmlrpc":
             raise BBMainException("FATAL: If '--server-only' is defined, we must set the "
                                   "servertype as 'xmlrpc'.\n")
-        if not configParams.bind:
+        if not configparams.bind:
             raise BBMainException("FATAL: The '--server-only' option requires a name/address "
                                   "to bind to with the -B option.\n")
-        if configParams.remote_server:
+        if configparams.remote_server:
             raise BBMainException("FATAL: The '--server-only' option conflicts with %s.\n" %
                                   ("the BBSERVER environment variable" if "BBSERVER" in os.environ \
                                    else "the '--remote-server' option"))
 
-    if configParams.bind and configParams.servertype != "xmlrpc":
+    if configparams.bind and configparams.servertype != "xmlrpc":
         raise BBMainException("FATAL: If '-B' or '--bind' is defined, we must "
                               "set the servertype as 'xmlrpc'.\n")
 
-    if configParams.remote_server and configParams.servertype != "xmlrpc":
+    if configparams.remote_server and configparams.servertype != "xmlrpc":
         raise BBMainException("FATAL: If '--remote-server' is defined, we must "
                               "set the servertype as 'xmlrpc'.\n")
 
-    if configParams.observe_only and (not configParams.remote_server or configParams.bind):
+    if configparams.observe_only and (not configparams.remote_server or configparams.bind):
         raise BBMainException("FATAL: '--observe-only' can only be used by UI clients "
                               "connecting to a server.\n")
 
-    if configParams.kill_server and not configParams.remote_server:
+    if configparams.kill_server and not configparams.remote_server:
         raise BBMainException("FATAL: '--kill-server' can only be used to "
                               "terminate a remote server")
 
@@ -407,12 +408,12 @@ def bitbake_main(configParams, configuration):
         if level > configuration.debug:
             configuration.debug = level
 
-    bb.msg.init_msgconfig(configParams.verbose, configuration.debug,
+    bb.msg.init_msgconfig(configparams.verbose, configuration.debug,
                           configuration.debug_domains)
 
     # Ensure logging messages get sent to the UI as events
     handler = bb.event.LogHandler()
-    if not configParams.status_only:
+    if not configparams.status_only:
         # In status only mode there are no logs and no UI
         logger.addHandler(handler)
 
@@ -420,35 +421,35 @@ def bitbake_main(configParams, configuration):
     cleanedvars = bb.utils.clean_environment()
 
     featureset = []
-    if not configParams.server_only:
+    if not configparams.server_only:
         # Collect the feature set for the UI
         featureset = getattr(ui_module, "featureSet", [])
 
-    if configParams.server_only:
+    if configparams.server_only:
         for param in ('prefile', 'postfile'):
-            value = getattr(configParams, param)
+            value = getattr(configparams, param)
             if value:
                 setattr(configuration, "%s_server" % param, value)
                 param = "%s_server" % param
 
-    if not configParams.remote_server:
+    if not configparams.remote_server:
         # we start a server with a given configuration
-        server = start_server(servermodule, configParams, configuration, featureset)
+        server = start_server(servermodule, configparams, configuration, featureset)
         bb.event.ui_queue = []
     else:
         # we start a stub server that is actually a XMLRPClient that connects to a real server
-        server = servermodule.BitBakeXMLRPCClient(configParams.observe_only,
-                                                  configParams.xmlrpctoken)
-        server.saveConnectionDetails(configParams.remote_server)
+        server = servermodule.BitBakeXMLRPCClient(configparams.observe_only,
+                                                  configparams.xmlrpctoken)
+        server.saveConnectionDetails(configparams.remote_server)
 
 
-    if not configParams.server_only:
+    if not configparams.server_only:
         try:
             server_connection = server.establishConnection(featureset)
-        except Exception as e:
-            bb.fatal("Could not connect to server %s: %s" % (configParams.remote_server, str(e)))
+        except Exception as err:
+            bb.fatal("Could not connect to server %s: %s" % (configparams.remote_server, str(err)))
 
-        if configParams.kill_server:
+        if configparams.kill_server:
             server_connection.connection.terminateServer()
             bb.event.ui_queue = []
             return 0
@@ -462,13 +463,13 @@ def bitbake_main(configParams, configuration):
         logger.removeHandler(handler)
 
 
-        if configParams.status_only:
+        if configparams.status_only:
             server_connection.terminate()
             return 0
 
         try:
             return ui_module.main(server_connection.connection, server_connection.events,
-                                  configParams)
+                                  configparams)
         finally:
             bb.event.ui_queue = []
             server_connection.terminate()
-- 
2.1.4


