Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1Qd24d-0002xf-5W
	for bitbake-devel@lists.openembedded.org;
	Sat, 02 Jul 2011 17:25:35 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 02 Jul 2011 08:15:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,463,1304319600"; d="scan'208";a="22701239"
Received: from dcui-desktop.sh.intel.com (HELO localhost) ([10.239.36.71])
	by orsmga001.jf.intel.com with ESMTP; 02 Jul 2011 08:15:29 -0700
From: Dexuan Cui <dexuan.cui@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  2 Jul 2011 23:15:30 +0800
Message-Id: <4a14b4fcab45d1768dfc31c9de3f2efb9fe93279.1309619557.git.dexuan.cui@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1309619557.git.dexuan.cui@intel.com>
References: <cover.1309619557.git.dexuan.cui@intel.com>
In-Reply-To: <cover.1309619557.git.dexuan.cui@intel.com>
References: <cover.1309619557.git.dexuan.cui@intel.com>
Subject: [PATCH 1/1][v3] bitbake/cooker, bitbake-layers: show the .bbappend files that matches no existing .bb recipe
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
X-List-Received-Date: Sat, 02 Jul 2011 15:25:35 -0000

This patch moves the logic of show_appends_with_no_recipes from bitbake-layers
into bitbake. By default, a fatal message is printed; we can also define a variable
BB_DANGLINGAPPENDS_WARNONLY to make the message only a warning(the variables
could be defined in conf/local.conf with a value "yes", "true" or "1").

Signed-off-by: Dexuan Cui <dexuan.cui@intel.com>
---
 bitbake/bin/bitbake-layers |   21 +--------------------
 bitbake/lib/bb/cooker.py   |   22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 6b5ad5a..9266eb5 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -54,7 +54,7 @@ class Commands(cmd.Cmd):
 
     def prepare_cooker(self):
         sys.stderr.write("Parsing recipes..")
-        logger.setLevel(logging.ERROR)
+        logger.setLevel(logging.WARNING)
 
         try:
             while self.cooker.state in (state.initial, state.parsing):
@@ -85,8 +85,6 @@ class Commands(cmd.Cmd):
 
         self.show_appends_for_skipped()
 
-        self.show_appends_with_no_recipes()
-
     def show_appends_for_pn(self, pn):
         filenames = self.cooker_data.pkg_pn[pn]
 
@@ -133,23 +131,6 @@ class Commands(cmd.Cmd):
                 notappended.add(basename)
         return appended, notappended
 
-    def show_appends_with_no_recipes(self):
-        recipes = set(os.path.basename(f)
-                      for f in self.cooker_data.pkg_fn.iterkeys())
-        recipes |= set(os.path.basename(f)
-                      for f in self.cooker.skiplist.iterkeys())
-        appended_recipes = self.cooker_data.appends.iterkeys()
-        appends_without_recipes = [self.cooker_data.appends[recipe]
-                                   for recipe in appended_recipes
-                                   if recipe not in recipes]
-        if appends_without_recipes:
-            appendlines = ('  %s' % append
-                           for appends in appends_without_recipes
-                           for append in appends)
-            logger.warn('No recipes available for:\n%s',
-                        '\n'.join(appendlines))
-            self.returncode |= 4
-
     def do_EOF(self, line):
         return True
 
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index ebf963d..3aca8c6 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -471,6 +471,27 @@ class BBCooker:
                 return pri
         return 0
 
+    def show_appends_with_no_recipes( self ):
+        recipes = set(os.path.basename(f)
+                      for f in self.status.pkg_fn.iterkeys())
+        recipes |= set(os.path.basename(f)
+                      for f in self.skiplist.iterkeys())
+        appended_recipes = self.appendlist.iterkeys()
+        appends_without_recipes = [self.appendlist[recipe]
+                                   for recipe in appended_recipes
+                                   if recipe not in recipes]
+        if appends_without_recipes:
+            appendlines = ('  %s' % append
+                           for appends in appends_without_recipes
+                           for append in appends)
+            msg = 'No recipes available for:\n%s' % '\n'.join(appendlines)
+            warn_only = data.getVar("BB_DANGLINGAPPENDS_WARNONLY", \
+                 self.configuration.data, False) or "no"
+            if warn_only.lower() in ("1", "yes", "true"):
+                bb.warn(msg)
+            else:
+                bb.fatal(msg)
+
     def buildDepgraph( self ):
         all_depends = self.status.all_depends
         pn_provides = self.status.pn_provides
@@ -940,6 +961,7 @@ class BBCooker:
 
         if not self.parser.parse_next():
             collectlog.debug(1, "parsing complete")
+            self.show_appends_with_no_recipes()
             self.buildDepgraph()
             self.state = state.running
             return None
-- 
1.7.6



