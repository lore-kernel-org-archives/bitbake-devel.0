Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 431F1767E5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Aug 2015 11:12:44 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 17 Aug 2015 04:12:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,694,1432623600"; d="scan'208";a="785564810"
Received: from jwanrooi-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.11.216])
	by orsmga002.jf.intel.com with ESMTP; 17 Aug 2015 04:12:44 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 17 Aug 2015 12:12:25 +0100
Message-Id: <83fd54b5abb3db38a5527b65d41b5899485eca5d.1439809654.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1439809654.git.paul.eggleton@linux.intel.com>
References: <cover.1439809654.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 10/13] bitbake-layers: Convert flatten to use collections.bbappends
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
X-List-Received-Date: Mon, 17 Aug 2015 11:12:44 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

flatten support currently looks broken since it doesn't appear to
deal with handling "%" support in bbappend file names.

This patch converts it to use collections.get_file_appends() which
correctly handles "%" support.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-layers | 44 ++++++++++++++++++++------------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 5116e59..62b51b0 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -595,7 +595,7 @@ build results (as the layer priority order has effectively changed).
                     return layerdir
             return None
 
-        appended_recipes = []
+        applied_appends = []
         for layer in layers:
             overlayed = []
             for f in self.bbhandler.cooker.collection.overlayed.iterkeys():
@@ -623,31 +623,27 @@ build results (as the layer priority order has effectively changed).
                                     logger.warn('Overwriting file %s', fdest)
                             bb.utils.copyfile(f1full, fdest)
                             if ext == '.bb':
-                                if f1 in self.bbhandler.cooker.collection.appendlist:
-                                    appends = self.bbhandler.cooker.collection.appendlist[f1]
-                                    if appends:
-                                        logger.plain('  Applying appends to %s' % fdest )
-                                        for appendname in appends:
-                                            if layer_path_match(appendname):
-                                                self.apply_append(appendname, fdest)
-                                    appended_recipes.append(f1)
+                                for append in self.bbhandler.cooker.collection.get_file_appends(f1full):
+                                    if layer_path_match(append):
+                                        logger.plain('  Applying append %s to %s' % (append, fdest))
+                                        self.apply_append(append, fdest)
+                                        applied_appends.append(append)
 
         # Take care of when some layers are excluded and yet we have included bbappends for those recipes
-        for recipename in self.bbhandler.cooker.collection.appendlist.iterkeys():
-            if recipename not in appended_recipes:
-                appends = self.bbhandler.cooker.collection.appendlist[recipename]
+        for b in self.bbhandler.cooker.collection.bbappends:
+            (recipename, appendname) = b
+            if appendname not in applied_appends:
                 first_append = None
-                for appendname in appends:
-                    layer = layer_path_match(appendname)
-                    if layer:
-                        if first_append:
-                            self.apply_append(appendname, first_append)
-                        else:
-                            fdest = appendname[len(layer):]
-                            fdest = os.path.normpath(os.sep.join([outputdir,fdest]))
-                            bb.utils.mkdirhier(os.path.dirname(fdest))
-                            bb.utils.copyfile(appendname, fdest)
-                            first_append = fdest
+                layer = layer_path_match(appendname)
+                if layer:
+                    if first_append:
+                        self.apply_append(appendname, first_append)
+                    else:
+                        fdest = appendname[len(layer):]
+                        fdest = os.path.normpath(os.sep.join([outputdir,fdest]))
+                        bb.utils.mkdirhier(os.path.dirname(fdest))
+                        bb.utils.copyfile(appendname, fdest)
+                        first_append = fdest
 
         # Get the regex for the first layer in our list (which is where the conf/layer.conf file will
         # have come from)
@@ -723,7 +719,7 @@ build results (as the layer priority order has effectively changed).
 Lists recipes with the bbappends that apply to them as subitems.
 """
         self.init_bbhandler()
-        if not self.bbhandler.cooker.collection.appendlist:
+        if not self.bbhandler.cooker.collection.bbappends:
             logger.plain('No append files found')
             return 0
 
-- 
2.1.0


