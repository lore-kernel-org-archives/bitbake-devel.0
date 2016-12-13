Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 1712771B5F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:08:48 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:08:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961478"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:08:47 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:08 +1300
Message-Id: <f220a8955353f37a5e0d9635fb7950c419fe0f74.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 09/15] tinfoil: implement server-side recipe parsing
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
X-List-Received-Date: Tue, 13 Dec 2016 07:08:48 -0000

It's not really practical for us to parse recipes on the client side, we
need to do it on the server because that's where we have the full python
environment (including any "pure" python functions defined in classes).
Thus, add some functions to tinfoil do this including a few shortcut
functions.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py | 44 ++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/tinfoil.py | 54 +++++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 81 insertions(+), 17 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index d5be86d..b296b8c 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -493,6 +493,50 @@ class CommandsSync:
         varparse = bb.data_smart.VariableParse(varname, datastore)
         return varparse.python_sub(expr)
 
+    def dataStoreConnectorRelease(self, command, params):
+        dsindex = params[0]
+        if dsindex <= 0:
+            raise CommandError('dataStoreConnectorRelease: invalid index %d' % dsindex)
+        command.remotedatastores.release(dsindex)
+
+    def parseRecipeFile(self, command, params):
+        """
+        Parse the specified recipe file (with or without bbappends)
+        and return a datastore object representing the environment
+        for the recipe.
+        """
+        fn = params[0]
+        appends = params[1]
+        appendlist = params[2]
+        if len(params) > 3:
+            config_data_dict = params[3]
+            config_data = command.remotedatastores.receive_datastore(config_data_dict)
+        else:
+            config_data = None
+
+        if appends:
+            if appendlist is not None:
+                appendfiles = appendlist
+            else:
+                appendfiles = command.cooker.collection.get_file_appends(fn)
+        else:
+            appendfiles = []
+        # We are calling bb.cache locally here rather than on the server,
+        # but that's OK because it doesn't actually need anything from
+        # the server barring the global datastore (which we have a remote
+        # version of)
+        if config_data:
+            # We have to use a different function here if we're passing in a datastore
+            # NOTE: we took a copy above, so we don't do it here again
+            envdata = bb.cache.parse_recipe(config_data, fn, appendfiles)['']
+        else:
+            # Use the standard path
+            parser = bb.cache.NoCache(command.cooker.databuilder)
+            envdata = parser.loadDataFull(fn, appendfiles)
+        idx = command.remotedatastores.store(envdata)
+        return DataStoreConnectionHandle(idx)
+    parseRecipeFile.readonly = True
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 459f6c1..c551a9f 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -26,6 +26,7 @@ from collections import OrderedDict, defaultdict
 import bb.cache
 import bb.cooker
 import bb.providers
+import bb.taskdata
 import bb.utils
 import bb.command
 from bb.cookerdata import CookerConfiguration, ConfigParameters
@@ -90,7 +91,7 @@ class TinfoilCookerAdapter:
         def __init__(self, tinfoil):
             self.tinfoil = tinfoil
         def get_file_appends(self, fn):
-            return self.tinfoil.run_command('getFileAppends', fn)
+            return self.tinfoil.get_file_appends(fn)
         def __getattr__(self, name):
             if name == 'overlayed':
                 return self.tinfoil.get_overlayed_recipes()
@@ -305,6 +306,34 @@ class Tinfoil:
     def get_runtime_providers(self, rdep):
         return self.run_command('getRuntimeProviders', rdep)
 
+    def get_recipe_file(self, pn):
+        """
+        Get the file name for the specified recipe/target. Raises
+        bb.providers.NoProvider if there is no match or the recipe was
+        skipped.
+        """
+        best = self.find_best_provider(pn)
+        if not best:
+            skiplist = self.get_skipped_recipes()
+            taskdata = bb.taskdata.TaskData(None, skiplist=skiplist)
+            skipreasons = taskdata.get_reasons(pn)
+            if skipreasons:
+                raise bb.providers.NoProvider(skipreasons)
+            else:
+                raise bb.providers.NoProvider('Unable to find any recipe file matching %s' % pn)
+        return best[3]
+
+    def get_file_appends(self, fn):
+        return self.run_command('getFileAppends', fn)
+
+    def parse_recipe(self, pn):
+        """
+        Parse the specified recipe and return a datastore object
+        representing the environment for the recipe.
+        """
+        fn = self.get_recipe_file(pn)
+        return self.parse_recipe_file(fn)
+
     def parse_recipe_file(self, fn, appends=True, appendlist=None, config_data=None):
         """
         Parse the specified recipe file (with or without bbappends)
@@ -322,24 +351,15 @@ class Tinfoil:
         """
         if appends and appendlist == []:
             appends = False
-        if appends:
-            if appendlist:
-                appendfiles = appendlist
-            else:
-                if not hasattr(self.cooker, 'collection'):
-                    raise Exception('You must call tinfoil.prepare() with config_only=False in order to get bbappends')
-                appendfiles = self.cooker.collection.get_file_appends(fn)
-        else:
-            appendfiles = None
         if config_data:
-            # We have to use a different function here if we're passing in a datastore
-            localdata = bb.data.createCopy(config_data)
-            envdata = bb.cache.parse_recipe(localdata, fn, appendfiles)['']
+            dctr = bb.remotedata.RemoteDatastores.transmit_datastore(config_data)
+            dscon = self.run_command('parseRecipeFile', fn, appends, appendlist, dctr)
+        else:
+            dscon = self.run_command('parseRecipeFile', fn, appends, appendlist)
+        if dscon:
+            return self._reconvert_type(dscon, 'DataStoreConnectionHandle')
         else:
-            # Use the standard path
-            parser = bb.cache.NoCache(self.cooker.databuilder)
-            envdata = parser.loadDataFull(fn, appendfiles)
-        return envdata
+            return None
 
     def build_file(self, buildfile, task):
         """
-- 
2.5.5


