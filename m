Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QlQJs-0005y1-76
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 20:56:00 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 25 Jul 2011 11:51:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,264,1309762800"; d="scan'208";a="29903200"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 25 Jul 2011 11:51:41 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jul 2011 11:56:11 -0700
Message-Id: <0ebe0d3e44546100d5b9824bdfc81154c827d716.1311620081.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311620081.git.josh@linux.intel.com>
References: <cover.1311620081.git.josh@linux.intel.com>
In-Reply-To: <cover.1311620081.git.josh@linux.intel.com>
References: <cover.1311620081.git.josh@linux.intel.com>
Subject: [PATCH 3/4] command|cooker: Add reparseFiles command
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
X-List-Received-Date: Mon, 25 Jul 2011 18:56:00 -0000

Add command reparseFiles to reparse bb files in a running cooker instance.

Fixes [YOCTO #1249]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/command.py |    8 ++++++++
 lib/bb/cooker.py  |   48 +++++++++++++++++++++++++++++-------------------
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index a902da2..893a6d9 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -311,6 +311,14 @@ class CommandsAsync:
         command.finishAsyncCommand()
     parseFiles.needcache = True
 
+    def reparseFiles(self, command, params):
+        """
+        Reparse .bb files
+        """
+        command.cooker.reparseFiles()
+        command.finishAsyncCommand()
+    reparseFiles.needcache = True
+
     def compareRevisions(self, command, params):
         """
         Parse the .bb files
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1b5101d..94e8d09 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -130,21 +130,8 @@ class BBCooker:
                 logger.critical("Unable to import extra RecipeInfo '%s' from '%s': %s" % (cache_name, module_name, exc))
                 sys.exit("FATAL: Failed to import extra cache class '%s'." % cache_name)
 
-        self.configuration.data = bb.data.init()
-
-        bb.data.inheritFromOS(self.configuration.data, self.savedenv)
-
-        try:
-            self.parseConfigurationFiles(self.configuration.prefile,
-                                         self.configuration.postfile)
-        except SyntaxError:
-            sys.exit(1)
-        except Exception:
-            logger.exception("Error parsing configuration files")
-            sys.exit(1)
-
-        if not self.configuration.cmd:
-            self.configuration.cmd = bb.data.getVar("BB_DEFAULT_TASK", self.configuration.data, True) or "build"
+        self.configuration.data = None
+        self.loadConfigurationData()
 
         bbpkgs = bb.data.getVar('BBPKGS', self.configuration.data, True)
         if bbpkgs and len(self.configuration.pkgs_to_build) == 0:
@@ -171,6 +158,23 @@ class BBCooker:
 
         self.parser = None
 
+    def loadConfigurationData(self):
+        self.configuration.data = bb.data.init()
+
+        bb.data.inheritFromOS(self.configuration.data, self.savedenv)
+
+        try:
+            self.parseConfigurationFiles(self.configuration.prefile,
+                                         self.configuration.postfile)
+        except SyntaxError:
+            sys.exit(1)
+        except Exception:
+            logger.exception("Error parsing configuration files")
+            sys.exit(1)
+
+        if not self.configuration.cmd:
+            self.configuration.cmd = bb.data.getVar("BB_DEFAULT_TASK", self.configuration.data, True) or "build"
+
     def parseConfiguration(self):
 
 
@@ -563,7 +567,7 @@ class BBCooker:
         bb.data.expandKeys(localdata)
 
         # Handle PREFERRED_PROVIDERS
-        for p in (bb.data.getVar('PREFERRED_PROVIDERS', localdata, 1) or "").split():
+        for p in (bb.data.getVar('PREFERRED_PROVIDERS', localdata, True) or "").split():
             try:
                 (providee, provider) = p.split(':')
             except:
@@ -1058,8 +1062,8 @@ class BBCooker:
 
         self.server_registration_cb(buildTargetsIdle, rq)
 
-    def updateCache(self):
-        if self.state == state.running:
+    def updateCache(self, force=False):
+        if self.state == state.running and not force:
             return
 
         if self.state in (state.shutdown, state.stop):
@@ -1069,6 +1073,8 @@ class BBCooker:
         if self.state != state.parsing:
             self.parseConfiguration ()
 
+            if self.status:
+                del self.status
             self.status = bb.cache.CacheData(self.caches_array)
 
             ignore = bb.data.getVar("ASSUME_PROVIDED", self.configuration.data, 1) or ""
@@ -1142,7 +1148,7 @@ class BBCooker:
 
         collectlog.debug(1, "collecting .bb files")
 
-        files = (data.getVar( "BBFILES", self.configuration.data, 1 ) or "").split()
+        files = (data.getVar( "BBFILES", self.configuration.data, True) or "").split()
         data.setVar("BBFILES", " ".join(files), self.configuration.data)
 
         # Sort files by priority
@@ -1240,6 +1246,10 @@ class BBCooker:
     def stop(self):
         self.state = state.stop
 
+    def reparseFiles(self):
+        self.loadConfigurationData()
+        self.updateCache(force=True)
+
 def server_main(cooker, func, *args):
     cooker.pre_serve()
 
-- 
1.7.6



