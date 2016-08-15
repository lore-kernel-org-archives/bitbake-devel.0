Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id E31B3758DB
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 16:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FGwpr0010717 for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:59:59 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 0LSQEwNuj9fD for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:59:59 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7FGxupe010738
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 15 Aug 2016 17:59:57 +0100
Message-ID: <1471280396.20391.95.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 15 Aug 2016 17:59:56 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] cache/ast: Move __VARIANTS handling to parse cache function
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
X-List-Received-Date: Mon, 15 Aug 2016 16:59:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Simple refactoring to allow for multiconfig support.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index c09f929..658f30f 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -401,14 +401,18 @@ class Cache(object):
         infos = []
         datastores = cls.load_bbfile(filename, appends, configdata)
         depends = []
+        variants = []
+        # Process the "real" fn last so we can store variants list
         for variant, data in sorted(datastores.items(),
                                     key=lambda i: i[0],
                                     reverse=True):
             virtualfn = cls.realfn2virtual(filename, variant)
+            variants.append(variant)
             depends = depends + (data.getVar("__depends", False) or [])
             if depends and not variant:
                 data.setVar("__depends", depends)
-
+            if virtualfn == filename:
+                data.setVar("__VARIANTS", " ".join(variants))
             info_array = []
             for cache_class in caches_array:
                 info = cache_class(filename, data)
diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index b407b09..d7185b1 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -502,9 +502,5 @@ def multi_finalize(fn, d):
             except bb.parse.SkipRecipe as e:
                 datastores[variant].setVar("__SKIPPED", e.args[0])
 
-    if len(datastores) > 1:
-        variants = filter(None, datastores.keys())
-        safe_d.setVar("__VARIANTS", " ".join(variants))
-
     datastores[""] = d
     return datastores



