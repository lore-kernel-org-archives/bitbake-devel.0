Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QUiOi-0005Bx-2G
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Jun 2011 18:47:56 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Jun 2011 09:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,342,1304319600"; d="scan'208";a="11418004"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.13.6])
	by orsmga002.jf.intel.com with ESMTP; 09 Jun 2011 09:44:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Jun 2011 17:42:38 +0100
Message-Id: <39d72ecf6bc1da85aefb11e6481719185f0cb953.1307636663.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1307636663.git.paul.eggleton@linux.intel.com>
References: <cover.1307636663.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1307636663.git.paul.eggleton@linux.intel.com>
References: <cover.1307636663.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] bitbake-layers: handle skipped recipes
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
X-List-Received-Date: Thu, 09 Jun 2011 16:47:56 -0000

Report bbappends correctly for skipped recipes instead of reporting the
bbappends as not having any matching recipe.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index d2ed5d4..6b5ad5a 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -83,6 +83,8 @@ class Commands(cmd.Cmd):
         for pn in self.cooker_data.pkg_pn:
             self.show_appends_for_pn(pn)
 
+        self.show_appends_for_skipped()
+
         self.show_appends_with_no_recipes()
 
     def show_appends_for_pn(self, pn):
@@ -94,17 +96,27 @@ class Commands(cmd.Cmd):
                                              self.cooker_data.pkg_pn)
         best_filename = os.path.basename(best[3])
 
+        self.show_appends_output(filenames, best_filename)
+
+    def show_appends_for_skipped(self):
+        filenames = [os.path.basename(f)
+                    for f in self.cooker.skiplist.iterkeys()]
+        self.show_appends_output(filenames, None, " (skipped)")
+
+    def show_appends_output(self, filenames, best_filename, name_suffix = ''):
         appended, missing = self.get_appends_for_files(filenames)
         if appended:
             for basename, appends in appended:
-                logger.info('%s:', basename)
+                logger.info('%s%s:', basename, name_suffix)
                 for append in appends:
                     logger.info('  %s', append)
 
-            if best_filename in missing:
-                logger.warn('%s: missing append for preferred version',
-                            best_filename)
-                self.returncode |= 1
+            if best_filename:
+                if best_filename in missing:
+                    logger.warn('%s: missing append for preferred version',
+                                best_filename)
+                    self.returncode |= 1
+
 
     def get_appends_for_files(self, filenames):
         appended, notappended = set(), set()
@@ -124,6 +136,8 @@ class Commands(cmd.Cmd):
     def show_appends_with_no_recipes(self):
         recipes = set(os.path.basename(f)
                       for f in self.cooker_data.pkg_fn.iterkeys())
+        recipes |= set(os.path.basename(f)
+                      for f in self.cooker.skiplist.iterkeys())
         appended_recipes = self.cooker_data.appends.iterkeys()
         appends_without_recipes = [self.cooker_data.appends[recipe]
                                    for recipe in appended_recipes
-- 
1.7.4.1



