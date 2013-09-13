Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 0E6EA60FDF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 16:31:20 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DGjBEP004983 for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:45:12 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id NFZjeIRprmWW for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:45:11 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8DGj8r8004979
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Sep 2013 17:45:09 +0100
Message-ID: <1379089869.3484.272.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 13 Sep 2013 17:31:09 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker: Clean up init/reset configuration code
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
X-List-Received-Date: Fri, 13 Sep 2013 16:31:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently the cooker event data isn't rebuilt upon reset and the cache
configuration cannot be changed after init. These are both bad things
and this patch refactors the init/reset code so that it is possible
to reconfigure the server.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index daa00a4..7034f1d 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -93,22 +93,6 @@ class BBCooker:
 
         self.configuration = configuration
 
-        self.caches_array = []
-
-        caches_name_array = ['bb.cache:CoreRecipeInfo'] + configuration.extra_caches
-
-        # At least CoreRecipeInfo will be loaded, so caches_array will never be empty!
-        # This is the entry point, no further check needed!
-        for var in caches_name_array:
-            try:
-                module_name, cache_name = var.split(':')
-                module = __import__(module_name, fromlist=(cache_name,))
-                self.caches_array.append(getattr(module, cache_name)) 
-            except ImportError as exc:
-                logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
-                sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
-
-        self.data = None
         self.loadConfigurationData()
 
         # Take a lock so only one copy of bitbake can run against a given build
@@ -118,13 +102,6 @@ class BBCooker:
         if not self.lock:
             bb.fatal("Only one copy of bitbake should be run against a build directory")
 
-        #
-        # Special updated configuration we use for firing events
-        #
-        self.event_data = bb.data.createCopy(self.data)
-        bb.data.update_data(self.event_data)
-        bb.parse.init_parser(self.event_data)
-
         # TOSTOP must not be set or our children will hang when they output
         fd = sys.stdout.fileno()
         if os.isatty(fd):
@@ -141,6 +118,23 @@ class BBCooker:
         self.parser = None
 
     def initConfigurationData(self):
+
+        self.state = state.initial
+
+        self.caches_array = []
+        caches_name_array = ['bb.cache:CoreRecipeInfo'] + self.configuration.extra_caches
+
+        # At least CoreRecipeInfo will be loaded, so caches_array will never be empty!
+        # This is the entry point, no further check needed!
+        for var in caches_name_array:
+            try:
+                module_name, cache_name = var.split(':')
+                module = __import__(module_name, fromlist=(cache_name,))
+                self.caches_array.append(getattr(module, cache_name)) 
+            except ImportError as exc:
+                logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
+                sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
+
         self.databuilder = bb.cookerdata.CookerDataBuilder(self.configuration, False)
         self.data = self.databuilder.data
 
@@ -158,6 +152,13 @@ class BBCooker:
         self.data = self.databuilder.data
         self.data_hash = self.databuilder.data_hash
 
+        #
+        # Special updated configuration we use for firing events
+        #
+        self.event_data = bb.data.createCopy(self.data)
+        bb.data.update_data(self.event_data)
+        bb.parse.init_parser(self.event_data)
+
     def modifyConfigurationVar(self, var, val, default_file, op):
         if op == "append":
             self.appendConfigurationVar(var, val, default_file)
@@ -1246,11 +1247,9 @@ class BBCooker:
         self.state = state.stop
 
     def initialize(self):
-        self.state = state.initial
         self.initConfigurationData()
 
     def reset(self):
-        self.state = state.initial
         self.loadConfigurationData()
 
 def server_main(cooker, func, *args):


