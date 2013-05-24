Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 408126223C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 May 2013 10:09:26 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 May 2013 03:09:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,734,1363158000"; d="scan'208";a="307292997"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.195])
	by azsmga001.ch.intel.com with ESMTP; 24 May 2013 03:09:15 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 May 2013 11:09:13 +0100
Message-Id: <1369390153-25823-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH] bitbake-layers: fix show-layers and flatten for recent cooker changes
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
X-List-Received-Date: Fri, 24 May 2013 10:09:26 -0000

Fixes the show-layers and flatten subcommands for recent refactoring in
cooker.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 86a17a5..ae61239 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -371,8 +371,8 @@ build results (as the layer priority order has effectively changed).
         appended_recipes = []
         for layer in layers:
             overlayed = []
-            for f in self.bbhandler.cooker.overlayed.iterkeys():
-                for of in self.bbhandler.cooker.overlayed[f]:
+            for f in self.bbhandler.cooker.collection.overlayed.iterkeys():
+                for of in self.bbhandler.cooker.collection.overlayed[f]:
                     if of.startswith(layer):
                         overlayed.append(of)
 
@@ -396,8 +396,8 @@ build results (as the layer priority order has effectively changed).
                                     logger.warn('Overwriting file %s', fdest)
                             bb.utils.copyfile(f1full, fdest)
                             if ext == '.bb':
-                                if f1 in self.bbhandler.cooker.appendlist:
-                                    appends = self.bbhandler.cooker.appendlist[f1]
+                                if f1 in self.bbhandler.cooker.collection.appendlist:
+                                    appends = self.bbhandler.cooker.collection.appendlist[f1]
                                     if appends:
                                         logger.plain('  Applying appends to %s' % fdest )
                                         for appendname in appends:
@@ -406,9 +406,9 @@ build results (as the layer priority order has effectively changed).
                                     appended_recipes.append(f1)
 
         # Take care of when some layers are excluded and yet we have included bbappends for those recipes
-        for recipename in self.bbhandler.cooker.appendlist.iterkeys():
+        for recipename in self.bbhandler.cooker.collection.appendlist.iterkeys():
             if recipename not in appended_recipes:
-                appends = self.bbhandler.cooker.appendlist[recipename]
+                appends = self.bbhandler.cooker.collection.appendlist[recipename]
                 first_append = None
                 for appendname in appends:
                     layer = layer_path_match(appendname)
@@ -498,7 +498,7 @@ usage: show-appends
 Recipes are listed with the bbappends that apply to them as subitems.
 """
         self.bbhandler.prepare()
-        if not self.bbhandler.cooker.appendlist:
+        if not self.bbhandler.cooker.collection.appendlist:
             logger.plain('No append files found')
             return
 
@@ -550,7 +550,7 @@ Recipes are listed with the bbappends that apply to them as subitems.
                 continue
 
             basename = os.path.basename(filename)
-            appends = self.bbhandler.cooker.appendlist.get(basename)
+            appends = self.bbhandler.cooker.collection.appendlist.get(basename)
             if appends:
                 appended.append((basename, list(appends)))
             else:
-- 
1.8.1.2


