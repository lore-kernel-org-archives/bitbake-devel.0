Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1QYWGU-0000oP-5n
	for bitbake-devel@lists.openembedded.org;
	Mon, 20 Jun 2011 06:39:10 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 19 Jun 2011 21:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,391,1304319600"; d="scan'208";a="15365166"
Received: from dcui-desktop.sh.intel.com (HELO localhost) ([10.239.13.51])
	by azsmga001.ch.intel.com with ESMTP; 19 Jun 2011 21:34:31 -0700
From: Dexuan Cui <dexuan.cui@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jun 2011 12:34:15 +0800
Message-Id: <f9c4e4502da0fbb1376f987ae8a81073567143f5.1308544082.git.dexuan.cui@intel.com>
X-Mailer: git-send-email 1.7.2
In-Reply-To: <cover.1308544082.git.dexuan.cui@intel.com>
References: <cover.1308544082.git.dexuan.cui@intel.com>
In-Reply-To: <cover.1308544082.git.dexuan.cui@intel.com>
References: <cover.1308544082.git.dexuan.cui@intel.com>
Subject: [PATCH 1/1] die if a .bbappend file matches no existing .bb recipe
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
X-List-Received-Date: Mon, 20 Jun 2011 04:39:11 -0000

This patch moves the logic of show_appends_with_no_recipes from bitbake-layers
into bitbake, and makes the script die with a fatal error message printed.

Signed-off-by: Dexuan Cui <dexuan.cui@intel.com>
---
 bitbake/bin/bitbake-layers |   19 -------------------
 bitbake/lib/bb/cooker.py   |   16 ++++++++++++++++
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 6b5ad5a..6178513 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
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
index ebf963d..5a70ba7 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -471,6 +471,21 @@ class BBCooker:
                 return pri
         return 0
 
+    def die_if_any_appends_with_no_recipes( self ):
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
+            bb.fatal('No recipes available for:\n%s' % '\n'.join(appendlines))
+
     def buildDepgraph( self ):
         all_depends = self.status.all_depends
         pn_provides = self.status.pn_provides
@@ -940,6 +955,7 @@ class BBCooker:
 
         if not self.parser.parse_next():
             collectlog.debug(1, "parsing complete")
+            self.die_if_any_appends_with_no_recipes()
             self.buildDepgraph()
             self.state = state.running
             return None
-- 
1.7.1



