Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 0FF1F795C6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Aug 2018 04:18:07 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Aug 2018 21:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,280,1531810800"; d="scan'208";a="64810887"
Received: from pradhand-mobl.gar.corp.intel.com (HELO localhost.localdomain)
	([10.255.140.136])
	by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2018 21:18:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Aug 2018 16:17:54 +1200
Message-Id: <7372b68b2cb53e68073c29709952a98d7f77eeb8.1535084244.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535084244.git.paul.eggleton@linux.intel.com>
References: <cover.1535084244.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] parse/ast: ensure saved event handlers really do get restored
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
X-List-Received-Date: Fri, 24 Aug 2018 04:18:07 -0000

In finalize() we save event handlers, register the ones relevant to the
recipe being finalised, trigger events, and then restore the handlers so
that one recipe's custom handlers (actually implemented within a class
inherited by the recipe) do not affect other recipes. However, if an
exception occurs during parsing, the saved handlers were not being
restored. Use a try...finally block to ensure that the handlers are
always restored.

This issue became apparent since in OpenEmbedded-Core we have recently
introduced a find_intercepts() handler for the
bb.event.RecipePreFinalise event in image-postinst-intercepts.bbclass
that images and old-style SDK recipes will end up inheriting. So far it
doesn't seem that the the error has manifested itself in normal builds,
but when parsing OE-Core recipes in the OE layer index it has:
core-image-rt-* image recipes were parsed which in the default
configuration raise SkipRecipe. The next non-image recipe that is parsed
will trigger a real exception, because the find_intercepts() handler is
still registered and gets fired, but in the context of the new recipe
the POSTINST_INTERCEPTS_PATHS variable is not set, and the code in
find_intercepts() is written with the reasonable assumption that that
isn't possible given that the class itself sets a default, and thus it
fails.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/parse/ast.py | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 6690dc51..9d20c323 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -343,30 +343,31 @@ def runAnonFuncs(d):
 
 def finalize(fn, d, variant = None):
     saved_handlers = bb.event.get_handlers().copy()
+    try:
+        for var in d.getVar('__BBHANDLERS', False) or []:
+            # try to add the handler
+            handlerfn = d.getVarFlag(var, "filename", False)
+            if not handlerfn:
+                bb.fatal("Undefined event handler function '%s'" % var)
+            handlerln = int(d.getVarFlag(var, "lineno", False))
+            bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
 
-    for var in d.getVar('__BBHANDLERS', False) or []:
-        # try to add the handler
-        handlerfn = d.getVarFlag(var, "filename", False)
-        if not handlerfn:
-            bb.fatal("Undefined event handler function '%s'" % var)
-        handlerln = int(d.getVarFlag(var, "lineno", False))
-        bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
-
-    bb.event.fire(bb.event.RecipePreFinalise(fn), d)
+        bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
-    bb.data.expandKeys(d)
-    runAnonFuncs(d)
+        bb.data.expandKeys(d)
+        runAnonFuncs(d)
 
-    tasklist = d.getVar('__BBTASKS', False) or []
-    bb.event.fire(bb.event.RecipeTaskPreProcess(fn, list(tasklist)), d)
-    bb.build.add_tasks(tasklist, d)
+        tasklist = d.getVar('__BBTASKS', False) or []
+        bb.event.fire(bb.event.RecipeTaskPreProcess(fn, list(tasklist)), d)
+        bb.build.add_tasks(tasklist, d)
 
-    bb.parse.siggen.finalise(fn, d, variant)
+        bb.parse.siggen.finalise(fn, d, variant)
 
-    d.setVar('BBINCLUDED', bb.parse.get_file_depends(d))
+        d.setVar('BBINCLUDED', bb.parse.get_file_depends(d))
 
-    bb.event.fire(bb.event.RecipeParsed(fn), d)
-    bb.event.set_handlers(saved_handlers)
+        bb.event.fire(bb.event.RecipeParsed(fn), d)
+    finally:
+        bb.event.set_handlers(saved_handlers)
 
 def _create_variants(datastores, names, function, onlyfinalise):
     def create_variant(name, orig_d, arg = None):
-- 
2.17.1


