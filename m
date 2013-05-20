Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id E682569697
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 May 2013 22:02:10 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4KM5VhH025980; Mon, 20 May 2013 23:05:31 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QVvICtdQazI6; Mon, 20 May 2013 23:05:31 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r4KM5PwN025976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 20 May 2013 23:05:27 +0100
Message-ID: <1369087308.11013.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 May 2013 23:01:48 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: "Damian, Alexandru" <alexandru.damian@intel.com>
Subject: [PATCH] bitbake/cookerdata: Explicitly specify cooker configuration options
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 20 May 2013 22:02:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


As the code stands today its hard to know which configuration variables
are used by which parts of the system. Some are used by the UIs, some
by bin/bitbake itself, some by cooker.

This patch changes the configuration to just contain the variables cooker
uses, and changes bin/bitbake to access the variables it needs directly
which hopefully lets us start to untangle this mess.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index c87e5b3..ac35b94 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -193,8 +193,8 @@ def main():
 
     # Server type can be xmlrpc, process or none currently, if nothing is specified,
     # the default server is process
-    if configuration.servertype:
-        server_type = configuration.servertype
+    if configParams.servertype:
+        server_type = configParams.servertype
     else:
         server_type = 'process'
 
@@ -205,13 +205,13 @@ def main():
         sys.exit("FATAL: Invalid server type '%s' specified.\n"
                  "Valid interfaces: xmlrpc, process [default], none." % servertype)
 
-    if configuration.server_only:
-        if configuration.servertype != "xmlrpc":
+    if configParams.server_only:
+        if configParams.servertype != "xmlrpc":
             sys.exit("FATAL: If '--server-only' is defined, we must set the servertype as 'xmlrpc'.\n")
-        if not configuration.bind:
+        if not configParams.bind:
             sys.exit("FATAL: The '--server-only' option requires a name/address to bind to with the -B option.\n")
 
-    if configuration.bind and configuration.servertype != "xmlrpc":
+    if configParams.bind and configParams.servertype != "xmlrpc":
         sys.exit("FATAL: If '-B' or '--bind' is defined, we must set the servertype as 'xmlrpc'.\n")
 
     if "BBDEBUG" in os.environ:
@@ -219,7 +219,7 @@ def main():
         if level > configuration.debug:
             configuration.debug = level
 
-    bb.msg.init_msgconfig(configuration.verbose, configuration.debug,
+    bb.msg.init_msgconfig(configParams.verbose, configuration.debug,
                          configuration.debug_domains)
 
     # Ensure logging messages get sent to the UI as events
@@ -230,8 +230,8 @@ def main():
     cleanedvars = bb.utils.clean_environment()
 
     server = server.BitBakeServer()
-    if configuration.bind:
-        server.initServer((configuration.bind, 0))
+    if configParams.bind:
+        server.initServer((configParams.bind, 0))
     else:
         server.initServer()
 
@@ -262,7 +262,7 @@ def main():
 
     logger.removeHandler(handler)
 
-    if not configuration.server_only:
+    if not configParams.server_only:
         # Setup a connection to the server (cooker)
         server_connection = server.establishConnection()
 
diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 0b436b3..70e22b4 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -117,11 +117,20 @@ class CookerConfiguration(object):
         self.postfile = []
         self.debug = 0
         self.cmd = None
+        self.abort = True
+        self.force = False
+        self.ui = None
+        self.profile = False
+        self.nosetscene = False
+        self.invalidate_stamp = False
+        self.dump_signatures = False
+        self.dry_run = False
 
     def setConfigParameters(self, parameters):
         self.params = parameters
-        for key, val in parameters.options.__dict__.items():
-            setattr(self, key, val)
+        for key in self.__dict__.keys():
+            if key in parameters.options.__dict__:
+                setattr(self, key, parameters.options.__dict__[key])
 
     def setServerRegIdleCallback(self, srcb):
         self.server_register_idlecallback = srcb




