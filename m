Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38F7C47073
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 14:03:20 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.17233.1704808990628655730
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 06:03:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PQJIE61n;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e43e48a16so25769655e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704808989; x=1705413789; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yd+ozBflBMAWaTQXpjINITpvNWvUcSUzM+l8OMkinto=;
        b=PQJIE61n4q2nLl1UmYKtS4P/abUksDXImk9k9tcVllYTxgVx++uQXYjQQmiJfKHJek
         J5lSyGdsCFz1eC36d94LVupiH2PeYlw/qA8fxADdeLFLhIalBq1NNp/WzAkYrU4wikTa
         qHMZo5Fmmqu+qb4KXLLsaEI8NgtveFivLIzMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704808989; x=1705413789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yd+ozBflBMAWaTQXpjINITpvNWvUcSUzM+l8OMkinto=;
        b=vcYEGzSIQ/zeEJ8q2wwFGhDvRoxEUpliUwwV6DYm2p/mrLrWX+suo9LkDctVWsQfMA
         Cp4zwJbxkiNe2UVHzCCF9UbWPLluDGxWB1oee/l/iQn1Bp0OtP37duFyQeq1V2pSdAHP
         bEg4u91iZQPJnw20rgYQDoqPKdnQDJSAnDbThp/rPc2J/wXa5EY1GAaUe9id+gpGHX6h
         6UOHvUvGfG/kg7mMsqHkI2YgunObcQr5SvAC1Pb38cZnCnp3da4a6pWHYHM9xyt7Svq0
         3ab4SX9Mwf4H50kvhFXiLcH5sBOVNr2YprV+a71x4QTUwa4Qn/womBdsWz4HLhobxavi
         D3ew==
X-Gm-Message-State: AOJu0YycqK+O5WTPzQzTHnRtl97IPI/aRXz6Hbi7cmr7xR1/VCgEeT9a
	pq60vJhP7bwcQ1gjt0N5g994/ge08z0XMITifW09C7uJz6I=
X-Google-Smtp-Source: AGHT+IGFDr0D74k/ZbAWkkAoQ9CKm59peS/i2OcYK0BV7xBWY5FxODMVg4crzOB3yhOdW5y1on+AoA==
X-Received: by 2002:a1c:7208:0:b0:40e:4832:9fab with SMTP id n8-20020a1c7208000000b0040e48329fabmr1473154wmc.143.1704808988506;
        Tue, 09 Jan 2024 06:03:08 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:494c:2c49:a717:e3aa])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b0040e4733aecbsm3728086wmo.15.2024.01.09.06.03.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 06:03:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] ast: Fix EXPORT_FUNCTIONS bug
Date: Tue,  9 Jan 2024 14:03:06 +0000
Message-Id: <20240109140306.3012740-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 14:03:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15761

If you have two classes, both of which set EXPORT_FUNCTIONS for the same funciton
and a standard funciton definition for the function that is exported, the export
function can sometimes overwrite the standard one.

The issue is that the internal flag the code uses isn't ovweritten if the variable
is giving a new value. Fix the issue by using a comment in the code that is injected
so that we know if it is ours or not.

Also add some testing for EXPORT_FUNCTIONS, not perfect but a start.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py   |  9 ++--
 lib/bb/tests/parse.py | 98 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 09dacbc44c..7581d003fd 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -211,10 +211,12 @@ class ExportFuncsNode(AstNode):
 
     def eval(self, data):
 
+        sentinel = "    # Export function set\n"
         for func in self.n:
             calledfunc = self.classname + "_" + func
 
-            if data.getVar(func, False) and not data.getVarFlag(func, 'export_func', False):
+            basevar = data.getVar(func, False)
+            if basevar and sentinel not in basevar:
                 continue
 
             if data.getVar(func, False):
@@ -231,12 +233,11 @@ class ExportFuncsNode(AstNode):
             data.setVarFlag(func, "lineno", 1)
 
             if data.getVarFlag(calledfunc, "python", False):
-                data.setVar(func, "    bb.build.exec_func('" + calledfunc + "', d)\n", parsing=True)
+                data.setVar(func, sentinel + "    bb.build.exec_func('" + calledfunc + "', d)\n", parsing=True)
             else:
                 if "-" in self.classname:
                    bb.fatal("The classname %s contains a dash character and is calling an sh function %s using EXPORT_FUNCTIONS. Since a dash is illegal in sh function names, this cannot work, please rename the class or don't use EXPORT_FUNCTIONS." % (self.classname, calledfunc))
-                data.setVar(func, "    " + calledfunc + "\n", parsing=True)
-            data.setVarFlag(func, 'export_func', '1')
+                data.setVar(func, sentinel + "    " + calledfunc + "\n", parsing=True)
 
 class AddTaskNode(AstNode):
     def __init__(self, filename, lineno, func, before, after):
diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 304bbbe222..72d1962e7e 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -243,3 +243,101 @@ unset A[flag@.service]
         with self.assertRaises(bb.parse.ParseError):
             d = bb.parse.handle(f.name, self.d)['']
 
+    export_function_recipe = """
+inherit someclass
+"""
+
+    export_function_recipe2 = """
+inherit someclass
+
+do_compile () {
+    false
+}
+
+python do_compilepython () {
+    bb.note("Something else")
+}
+
+"""
+    export_function_class = """
+someclass_do_compile() {
+    true
+}
+
+python someclass_do_compilepython () {
+    bb.note("Something")
+}
+
+EXPORT_FUNCTIONS do_compile do_compilepython
+"""
+
+    export_function_class2 = """
+secondclass_do_compile() {
+    true
+}
+
+python secondclass_do_compilepython () {
+    bb.note("Something")
+}
+
+EXPORT_FUNCTIONS do_compile do_compilepython
+"""
+
+    def test_parse_export_functions(self):
+        def check_function_flags(d):
+            self.assertEqual(d.getVarFlag("do_compile", "func"), 1)
+            self.assertEqual(d.getVarFlag("do_compilepython", "func"), 1)
+            self.assertEqual(d.getVarFlag("do_compile", "python"), None)
+            self.assertEqual(d.getVarFlag("do_compilepython", "python"), "1")
+
+        with tempfile.TemporaryDirectory() as tempdir:
+            self.d.setVar("__bbclasstype", "recipe")
+            recipename = tempdir + "/recipe.bb"
+            os.makedirs(tempdir + "/classes")
+            with open(tempdir + "/classes/someclass.bbclass", "w") as f:
+                f.write(self.export_function_class)
+                f.flush()
+            with open(tempdir + "/classes/secondclass.bbclass", "w") as f:
+                f.write(self.export_function_class2)
+                f.flush()
+
+            with open(recipename, "w") as f:
+                f.write(self.export_function_recipe)
+                f.flush()
+            os.chdir(tempdir)
+            d = bb.parse.handle(recipename, bb.data.createCopy(self.d))['']
+            self.assertIn("someclass_do_compile", d.getVar("do_compile"))
+            self.assertIn("someclass_do_compilepython", d.getVar("do_compilepython"))
+            check_function_flags(d)
+
+            recipename2 = tempdir + "/recipe2.bb"
+            with open(recipename2, "w") as f:
+                f.write(self.export_function_recipe2)
+                f.flush()
+
+            d = bb.parse.handle(recipename2, bb.data.createCopy(self.d))['']
+            self.assertNotIn("someclass_do_compile", d.getVar("do_compile"))
+            self.assertNotIn("someclass_do_compilepython", d.getVar("do_compilepython"))
+            self.assertIn("false", d.getVar("do_compile"))
+            self.assertIn("else", d.getVar("do_compilepython"))
+            check_function_flags(d)
+
+            with open(recipename, "a+") as f:
+                f.write("\ninherit secondclass\n")
+                f.flush()
+            with open(recipename2, "a+") as f:
+                f.write("\ninherit secondclass\n")
+                f.flush()
+
+            d = bb.parse.handle(recipename, bb.data.createCopy(self.d))['']
+            self.assertIn("secondclass_do_compile", d.getVar("do_compile"))
+            self.assertIn("secondclass_do_compilepython", d.getVar("do_compilepython"))
+            check_function_flags(d)
+
+            d = bb.parse.handle(recipename2, bb.data.createCopy(self.d))['']
+            self.assertNotIn("someclass_do_compile", d.getVar("do_compile"))
+            self.assertNotIn("someclass_do_compilepython", d.getVar("do_compilepython"))
+            self.assertIn("false", d.getVar("do_compile"))
+            self.assertIn("else", d.getVar("do_compilepython"))
+            check_function_flags(d)
+
-- 
2.39.2


