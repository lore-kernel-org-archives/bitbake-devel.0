Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E413065EBF
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 10:49:09 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s3DAn5Su008105 for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 11:49:05 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eIxub1u9xwpP for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 11:49:05 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s3DAmxLC008101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 11:49:03 +0100
Message-ID: <1397386133.15843.50.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 13 Apr 2014 11:48:53 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] parse/ast: Optimise data finalisation
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
X-List-Received-Date: Sun, 13 Apr 2014 10:49:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The optimisation where only the data we're interested in was finalised
was good but it turns out we can do better. In the case where a 
class-extension is to be targeted, we can skip the other targets.

This change does that and speeds up parsing at the bitbake-worker 
execution time. Specifically, you can see an improvement in the speed
of bitbake X -n.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index d8c141b..b930370 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -337,8 +337,10 @@ def finalize(fn, d, variant = None):
 
     bb.event.fire(bb.event.RecipeParsed(fn), d)
 
-def _create_variants(datastores, names, function):
+def _create_variants(datastores, names, function, onlyfinalise):
     def create_variant(name, orig_d, arg = None):
+        if onlyfinalise and name not in onlyfinalise:
+            return
         new_d = bb.data.createCopy(orig_d)
         function(arg or name, new_d)
         datastores[name] = new_d
@@ -383,7 +385,8 @@ def multi_finalize(fn, d):
     safe_d = d
     d = bb.data.createCopy(safe_d)
     try:
-        finalize(fn, d)
+        if not onlyfinalise or "default" in onlyfinalise:
+            finalize(fn, d)
     except bb.parse.SkipPackage as e:
         d.setVar("__SKIPPED", e.args[0])
     datastores = {"": safe_d}
@@ -430,7 +433,7 @@ def multi_finalize(fn, d):
             except bb.parse.SkipPackage as e:
                 d.setVar("__SKIPPED", e.args[0])
 
-        _create_variants(datastores, versions, verfunc)
+        _create_variants(datastores, versions, verfunc, onlyfinalise)
 
     extended = d.getVar("BBCLASSEXTEND", True) or ""
     if extended:
@@ -460,7 +463,7 @@ def multi_finalize(fn, d):
             bb.parse.BBHandler.inherit(extendedmap[name], fn, 0, d)
 
         safe_d.setVar("BBCLASSEXTEND", extended)
-        _create_variants(datastores, extendedmap.keys(), extendfunc)
+        _create_variants(datastores, extendedmap.keys(), extendfunc, onlyfinalise)
 
     for variant, variant_d in datastores.iteritems():
         if variant:



