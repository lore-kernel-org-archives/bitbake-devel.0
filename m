Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A3FB1767BD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:38 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564783"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:38 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:19 +0100
Message-Id: <e48e095f07c16a2b8f20c7f4f3b71eaa04fb5340.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 04/13] command: ensure sync commands that read configuration see updates
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
X-List-Received-Date: Mon, 17 Aug 2015 11:12:38 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Add a means of ensuring that synchronous commands that read the results
of the configuration trigger a reparse of the configuration if any
underlying files have changed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py | 13 ++++++++++++-
 lib/bb/cooker.py  | 27 ++++++++++++++++-----------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index a7cac97..398c1d6 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -68,6 +68,8 @@ class Command:
                 if not hasattr(command_method, 'readonly') or False == getattr(command_method, 'readonly'):
                     return None, "Not able to execute not readonly commands in readonly mode"
             try:
+                if getattr(command_method, 'needconfig', False):
+                    self.cooker.updateCacheSync()
                 result = command_method(self, commandline)
             except CommandError as exc:
                 return None, exc.args[0]
@@ -204,6 +206,7 @@ class CommandsSync:
         postfiles = params[1].split()
         command.cooker.configuration.prefile = prefiles
         command.cooker.configuration.postfile = postfiles
+    setPrePostConfFiles.needconfig = False
 
     def getCpuCount(self, command, params):
         """
@@ -211,10 +214,12 @@ class CommandsSync:
         """
         return bb.utils.cpu_count()
     getCpuCount.readonly = True
+    getCpuCount.needconfig = False
 
     def matchFile(self, command, params):
         fMatch = params[0]
         return command.cooker.matchFile(fMatch)
+    matchFile.needconfig = False
 
     def generateNewImage(self, command, params):
         image = params[0]
@@ -228,6 +233,7 @@ class CommandsSync:
     def ensureDir(self, command, params):
         directory = params[0]
         bb.utils.mkdirhier(directory)
+    ensureDir.needconfig = False
 
     def setVarFile(self, command, params):
         """
@@ -238,6 +244,7 @@ class CommandsSync:
         default_file = params[2]
         op = params[3]
         command.cooker.modifyConfigurationVar(var, val, default_file, op)
+    setVarFile.needconfig = False
 
     def removeVarFile(self, command, params):
         """
@@ -245,6 +252,7 @@ class CommandsSync:
         """
         var = params[0]
         command.cooker.removeConfigurationVar(var)
+    removeVarFile.needconfig = False
 
     def createConfigFile(self, command, params):
         """
@@ -252,6 +260,7 @@ class CommandsSync:
         """
         name = params[0]
         command.cooker.createConfigFile(name)
+    createConfigFile.needconfig = False
 
     def setEventMask(self, command, params):
         handlerNum = params[0]
@@ -259,6 +268,7 @@ class CommandsSync:
         debug_domains = params[2]
         mask = params[3]
         return bb.event.set_UIHmask(handlerNum, llevel, debug_domains, mask)
+    setEventMask.needconfig = False
 
     def setFeatures(self, command, params):
         """
@@ -266,7 +276,7 @@ class CommandsSync:
         """
         features = params[0]
         command.cooker.setFeatures(features)
-
+    setFeatures.needconfig = False
     # although we change the internal state of the cooker, this is transparent since
     # we always take and leave the cooker in state.initial
     setFeatures.readonly = True
@@ -275,6 +285,7 @@ class CommandsSync:
         options = params[0]
         environment = params[1]
         command.cooker.updateConfigOpts(options, environment)
+    updateConfig.needconfig = False
 
 class CommandsAsync:
     """
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f0f9c66..fb38289 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1445,6 +1445,21 @@ class BBCooker:
         if timestamp:
             return timestr
 
+    def updateCacheSync(self):
+        if self.state == state.running:
+            return
+
+        # reload files for which we got notifications
+        for p in self.inotify_modified_files:
+            bb.parse.update_cache(p)
+        self.inotify_modified_files = []
+
+        if not self.baseconfig_valid:
+            logger.debug(1, "Reloading base configuration data")
+            self.initConfigurationData()
+            self.baseconfig_valid = True
+            self.parsecache_valid = False
+
     # This is called for all async commands when self.state != running
     def updateCache(self):
         if self.state == state.running:
@@ -1456,17 +1471,7 @@ class BBCooker:
             raise bb.BBHandledException()
 
         if self.state != state.parsing:
-
-            # reload files for which we got notifications
-            for p in self.inotify_modified_files:
-                bb.parse.update_cache(p)
-            self.inotify_modified_files = []
-
-            if not self.baseconfig_valid:
-                logger.debug(1, "Reloading base configuration data")
-                self.initConfigurationData()
-                self.baseconfig_valid = True
-                self.parsecache_valid = False
+            self.updateCacheSync()
 
         if self.state != state.parsing and not self.parsecache_valid:
             self.parseConfiguration ()
-- 
2.1.0


