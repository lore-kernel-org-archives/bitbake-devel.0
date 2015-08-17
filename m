Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 8988D767E5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:45 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564812"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:45 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:26 +0100
Message-Id: <a6d209e9795d73d0959396672552d39fa9a344b1.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 11/13] bitbake-layers: refactor show-appends to stop using cooker bbappends list
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
X-List-Received-Date: Mon, 17 Aug 2015 11:12:45 -0000

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 62b51b0..8cf7196 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -719,18 +719,21 @@ build results (as the layer priority order has effectively changed).
 Lists recipes with the bbappends that apply to them as subitems.
 """
         self.init_bbhandler()
-        if not self.bbhandler.cooker.collection.bbappends:
-            logger.plain('No append files found')
-            return 0
 
         logger.plain('=== Appended recipes ===')
 
         pnlist = list(self.bbhandler.cooker_data.pkg_pn.keys())
         pnlist.sort()
+        appends = False
         for pn in pnlist:
-            self.show_appends_for_pn(pn)
+            if self.show_appends_for_pn(pn):
+                appends = True
+
+        if self.show_appends_for_skipped():
+            appends = True
 
-        self.show_appends_for_skipped()
+        if not appends:
+            logger.plain('No append files found')
 
     def show_appends_for_pn(self, pn):
         filenames = self.bbhandler.cooker_data.pkg_pn[pn]
@@ -741,12 +744,12 @@ Lists recipes with the bbappends that apply to them as subitems.
                                              self.bbhandler.cooker_data.pkg_pn)
         best_filename = os.path.basename(best[3])
 
-        self.show_appends_output(filenames, best_filename)
+        return self.show_appends_output(filenames, best_filename)
 
     def show_appends_for_skipped(self):
         filenames = [os.path.basename(f)
                     for f in self.bbhandler.cooker.skiplist.iterkeys()]
-        self.show_appends_output(filenames, None, " (skipped)")
+        return self.show_appends_output(filenames, None, " (skipped)")
 
     def show_appends_output(self, filenames, best_filename, name_suffix = ''):
         appended, missing = self.get_appends_for_files(filenames)
@@ -760,7 +763,9 @@ Lists recipes with the bbappends that apply to them as subitems.
                 if best_filename in missing:
                     logger.warn('%s: missing append for preferred version',
                                 best_filename)
-
+            return True
+        else:
+            return False
 
     def get_appends_for_files(self, filenames):
         appended, notappended = [], []
-- 
2.1.0


