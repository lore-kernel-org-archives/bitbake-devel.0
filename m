Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id B3BA86D86B
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Dec 2013 17:48:55 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rB2Hmn6N000390
	for <bitbake-devel@lists.openembedded.org>; Mon, 2 Dec 2013 17:48:49 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VfauurGjX9rO for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Dec 2013 17:48:49 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rB2Hmht0000387
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 2 Dec 2013 17:48:45 GMT
Message-ID: <1386006520.11222.111.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 02 Dec 2013 17:48:40 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cooker/command/hob: Cleanup configuration init/reset functions and commands
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
X-List-Received-Date: Mon, 02 Dec 2013 17:48:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

initConfigurationData and loadConfigurationData are similar functions, the only
reason for them appears to be to be able to reset the pre/post configuration
files. The current code is confusing and unmaintainable.

Instead this patch creates a new Sync command which allows these to be explicitly
set. The init and load functions can then be merged into one. There is then no
need for a parseConfiguration command, we can simply reset the server to have the
settings take effect.

The reset fuction is not an instant value return and triggers an event so it should
be an Async command, not a sync one.

The number of calls for the set pre/post command is probably higher than it
need be but someone with more familiarity with the hob code base can probably
figure out the right places its needed (maybe just init_cooker?).

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index a2795ce..e30d21d 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -196,18 +196,11 @@ class CommandsSync:
         """
         command.cooker.disableDataTracking()
 
-    def initCooker(self, command, params):
-        """
-        Init the cooker to initial state with nothing parsed
-        """
-        command.cooker.initialize()
-
-    def resetCooker(self, command, params):
-        """
-        Reset the cooker to its initial state, thus forcing a reparse for
-        any async command that has the needcache property set to True
-        """
-        command.cooker.reset()
+    def setPrePostConfFiles(self, command, params):
+        prefiles = params[0].split()
+        postfiles = params[1].split()
+        command.cooker.configuration.prefile = prefiles
+        command.cooker.configuration.postfile = postfiles
 
     def getCpuCount(self, command, params):
         """
@@ -420,18 +413,6 @@ class CommandsAsync:
             command.finishAsyncCommand()
     compareRevisions.needcache = True
 
-    def parseConfigurationFiles(self, command, params):
-        """
-        Parse the configuration files
-        """
-        prefiles = params[0].split()
-        postfiles = params[1].split()
-        command.cooker.configuration.prefile = prefiles
-        command.cooker.configuration.postfile = postfiles
-        command.cooker.loadConfigurationData()
-        command.finishAsyncCommand()
-    parseConfigurationFiles.needcache = False
-
     def triggerEvent(self, command, params):
         """
         Trigger a certain event
@@ -441,3 +422,12 @@ class CommandsAsync:
         command.currentAsyncCommand = None
     triggerEvent.needcache = False
 
+    def resetCooker(self, command, params):
+        """
+        Reset the cooker to its initial state, thus forcing a reparse for
+        any async command that has the needcache property set to True
+        """
+        command.cooker.reset()
+        command.finishAsyncCommand()
+    resetCooker.needcache = False
+
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index b36ed6f..57e2156 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -117,7 +117,7 @@ class BBCooker:
 
         self.configuration = configuration
 
-        self.loadConfigurationData()
+        self.initConfigurationData()
 
         # Take a lock so only one copy of bitbake can run against a given build
         # directory at a time
@@ -144,9 +144,11 @@ class BBCooker:
     def initConfigurationData(self):
 
         self.state = state.initial
-
         self.caches_array = []
 
+        if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
+            self.enableDataTracking()
+
         all_extra_cache_names = []
         # We hardcode all known cache types in a single place, here.
         if CookerFeatures.HOB_EXTRA_CACHES in self.featureset:
@@ -168,19 +170,6 @@ class BBCooker:
         self.databuilder = bb.cookerdata.CookerDataBuilder(self.configuration, False)
         self.data = self.databuilder.data
 
-    def enableDataTracking(self):
-        self.configuration.tracking = True
-        self.data.enableTracking()
-
-    def disableDataTracking(self):
-        self.configuration.tracking = False
-        self.data.disableTracking()
-
-    def loadConfigurationData(self):
-        if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
-            self.enableDataTracking()
-
-        self.initConfigurationData()
         self.databuilder.parseBaseConfiguration()
         self.data = self.databuilder.data
         self.data_hash = self.databuilder.data_hash
@@ -195,6 +184,13 @@ class BBCooker:
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.disableDataTracking()
 
+    def enableDataTracking(self):
+        self.configuration.tracking = True
+        self.data.enableTracking()
+
+    def disableDataTracking(self):
+        self.configuration.tracking = False
+        self.data.disableTracking()
 
     def modifyConfigurationVar(self, var, val, default_file, op):
         if op == "append":
@@ -1325,11 +1321,8 @@ class BBCooker:
     def finishcommand(self):
         self.state = state.initial
 
-    def initialize(self):
-        self.initConfigurationData()
-
     def reset(self):
-        self.loadConfigurationData()
+        self.initConfigurationData()
 
 def server_main(cooker, func, *args):
     cooker.pre_serve()
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 1ace5cf..e0fc0d1 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -704,7 +704,6 @@ class Builder(gtk.Window):
         self.set_user_config_proxies()
 
     def set_user_config(self):
-        self.handler.reset_cooker()
         # set bb layers
         self.handler.set_bblayers(self.configuration.layers)
         # set local configuration
diff --git a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
index 06a05b6..ce8584d 100644
--- a/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/bitbake/lib/bb/ui/crumbs/hobeventhandler.py
@@ -149,9 +149,7 @@ class HobHandler(gobject.GObject):
         elif next_command == self.SUB_MATCH_CLASS:
             self.runCommand(["findFilesMatchingInDir", "rootfs_", "classes"])
         elif next_command == self.SUB_PARSE_CONFIG:
-            self.runCommand(["enableDataTracking"])
-            self.runCommand(["parseConfigurationFiles", "conf/.hob.conf", ""])
-            self.runCommand(["disableDataTracking"])
+            self.runCommand(["resetCooker"])
         elif next_command == self.SUB_GNERATE_TGTS:
             self.runCommand(["generateTargetsTree", "classes/image.bbclass", []])
         elif next_command == self.SUB_GENERATE_PKGINFO:
@@ -206,7 +204,8 @@ class HobHandler(gobject.GObject):
             reparse = self.runCommand(["getVariable", "BB_INVALIDCONF"]) or None
             if reparse is True:
                 self.set_var_in_file("BB_INVALIDCONF", False, "local.conf")
-                self.runCommand(["parseConfigurationFiles", "conf/.hob.conf", ""])
+                self.runCommand(["setPrePostConfFiles", "conf/.hob.conf", ""])
+                self.commands_async.prepend(self.SUB_PARSE_CONFIG)
             self.run_next_command()
 
         elif isinstance(event, bb.event.SanityCheckFailed):
@@ -304,12 +303,8 @@ class HobHandler(gobject.GObject):
         return
 
     def init_cooker(self):
-        self.runCommand(["initCooker"])
         self.runCommand(["createConfigFile", ".hob.conf"])
 
-    def reset_cooker(self):
-        self.runCommand(["resetCooker"])
-
     def set_extra_inherit(self, bbclass):
         inherits = self.runCommand(["getVariable", "INHERIT"]) or ""
         inherits = inherits + " " + bbclass
@@ -409,15 +404,17 @@ class HobHandler(gobject.GObject):
         self.run_next_command(self.NETWORK_TEST)
 
     def generate_configuration(self):
-        self.commands_async.append(self.SUB_PARSE_CONFIG)
+        self.runCommand(["setPrePostConfFiles", "conf/.hob.conf", ""])
         self.commands_async.append(self.SUB_PATH_LAYERS)
         self.commands_async.append(self.SUB_FILES_DISTRO)
         self.commands_async.append(self.SUB_FILES_MACH)
         self.commands_async.append(self.SUB_FILES_SDKMACH)
         self.commands_async.append(self.SUB_MATCH_CLASS)
+        self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.run_next_command(self.GENERATE_CONFIGURATION)
 
     def generate_recipes(self):
+        self.runCommand(["setPrePostConfFiles", "conf/.hob.conf", ""])
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_GNERATE_TGTS)
         self.run_next_command(self.GENERATE_RECIPES)
@@ -427,6 +424,7 @@ class HobHandler(gobject.GObject):
         targets.extend(tgts)
         self.recipe_queue = targets
         self.default_task = default_task
+        self.runCommand(["setPrePostConfFiles", "conf/.hob.conf", ""])
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_BUILD_RECIPES)
         self.run_next_command(self.GENERATE_PACKAGES)
@@ -438,6 +436,7 @@ class HobHandler(gobject.GObject):
         self.package_queue = image_packages
         self.toolchain_packages = toolchain_packages
         self.default_task = default_task
+        self.runCommand(["setPrePostConfFiles", "conf/.hob.conf", ""])
         self.commands_async.append(self.SUB_PARSE_CONFIG)
         self.commands_async.append(self.SUB_BUILD_IMAGE)
         self.run_next_command(self.GENERATE_IMAGE)



