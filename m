Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id EBCFC6B4F7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 11:09:33 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2SB9SgX013727 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 11:09:28 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KKx-pQcwq2Yb for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 11:09:28 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2SB9PNc013720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Mar 2014 11:09:27 GMT
Message-ID: <1396004959.24890.175.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Mar 2014 11:09:19 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] bin/bitbake/cooker: Ensure initial featureset is optimal
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
X-List-Received-Date: Fri, 28 Mar 2014 11:09:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If the featureset didn't match the defaults, we'd pay the price of two
base configuration parses which showed up adversely in the performance
benchmarks. This also passes the feature set into the cooker creation so
in the common case we don't have to reset the server. This speeds up
both knotty and hob startup. If the featureset doesn't match, the system
will reset as before, this just streamlines the common case.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index b173f16..cd01992 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -203,7 +203,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
         return options, targets[1:]
 
 
-def start_server(servermodule, configParams, configuration):
+def start_server(servermodule, configParams, configuration, features):
     server = servermodule.BitBakeServer()
     if configParams.bind:
         (host, port) = configParams.bind.split(':')
@@ -216,7 +216,7 @@ def start_server(servermodule, configParams, configuration):
     try:
         configuration.setServerRegIdleCallback(server.getServerIdleCB())
 
-        cooker = bb.cooker.BBCooker(configuration)
+        cooker = bb.cooker.BBCooker(configuration, features)
 
         server.addcooker(cooker)
         server.saveConnectionDetails()
@@ -296,9 +296,14 @@ def main():
     # Clear away any spurious environment variables while we stoke up the cooker
     cleanedvars = bb.utils.clean_environment()
 
+    featureset = []
+    if not configParams.server_only:
+        # Collect the feature set for the UI
+        featureset = getattr(ui_module, "featureSet", [])
+
     if not configParams.remote_server:
         # we start a server with a given configuration
-        server = start_server(servermodule, configParams, configuration)
+        server = start_server(servermodule, configParams, configuration, featureset)
         bb.event.ui_queue = []
     else:
         # we start a stub server that is actually a XMLRPClient that connects to a real server
@@ -307,9 +312,6 @@ def main():
         server.saveConnectionConfigParams(configParams)
 
     if not configParams.server_only:
-        # Collect the feature set for the UI
-        featureset = getattr(ui_module, "featureSet", [])
-
         if configParams.status_only:
             try:
                 server_connection = server.establishConnection(featureset)
@@ -326,7 +328,7 @@ def main():
             if configParams.kill_server:
                 bb.fatal("Server already killed")
             configParams.bind = configParams.remote_server
-            start_server(servermodule, configParams, configuration)
+            start_server(servermodule, configParams, configuration, featureset)
             bb.event.ui_queue = []
             server_connection = server.establishConnection(featureset)
 
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 5d3ac60..e6916a6 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -111,10 +111,12 @@ class BBCooker:
     Manages one bitbake build run
     """
 
-    def __init__(self, configuration):
+    def __init__(self, configuration, featureSet = []):
         self.recipecache = None
         self.skiplist = {}
         self.featureset = CookerFeatures()
+        for f in featureSet:
+            self.featureset.setFeature(f)
 
         self.configuration = configuration
 



