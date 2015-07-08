Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B75B175D8A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExKSi026617; Wed, 8 Jul 2015 15:59:20 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8esM13Zv_yx2; Wed,  8 Jul 2015 15:59:20 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExJrs026589
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:20 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqoc-0004S9-I7; Wed, 08 Jul 2015 15:59:14 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:58:55 +0100
Message-Id: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 01/16] data_smart: Defer append/prepend handling
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:25 -0000

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 7bb7b4a..b433489 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -429,12 +429,13 @@ class DataSmart(MutableMapping):
                             continue
 
                         if op == "_append":
-                            sval = self.getVar(append, False) or ""
-                            sval += a
-                            self.setVar(append, sval)
+                            apps = self.getVarFlag(append, "_appendactive", False) or []
+                            apps.extend([a])
+                            self.setVarFlag(append, "_appendactive", apps, ignore=True)
                         elif op == "_prepend":
-                            sval = a + (self.getVar(append, False) or "")
-                            self.setVar(append, sval)
+                            prepends = self.getVarFlag(append, "_prependactive", False) or []
+                            prepends.extend([a])
+                            self.setVarFlag(append, "_prependactive", prepends, ignore=True)
                         elif op == "_remove":
                             removes = self.getVarFlag(append, "_removeactive", False) or []
                             removes.extend(a.split())
@@ -507,6 +508,11 @@ class DataSmart(MutableMapping):
         if not var in self.dict:
             self._makeShadowCopy(var)
 
+        if "_appendactive" in self.dict[var]:
+            del self.dict[var]["_appendactive"]
+        if "_prependactive" in self.dict[var]:
+            del self.dict[var]["_prependactive"]
+
         # more cookies for the cookie monster
         if '_' in var:
             self._setvar_update_overrides(var)
@@ -612,6 +618,17 @@ class DataSmart(MutableMapping):
                 value = copy.copy(local_var[flag])
             elif flag == "_content" and "_defaultval" in local_var and not noweakdefault:
                 value = copy.copy(local_var["_defaultval"])
+
+        if flag == "_content" and local_var is not None and "_appendactive" in local_var:
+            if not value:
+                value = ""
+            for r in local_var["_appendactive"]:
+                value = value + r
+        if flag == "_content" and local_var is not None and "_prependactive" in local_var:
+            if not value:
+                value = ""
+            for r in local_var["_prependactive"]:
+                value = r + value
         if expand and value:
             # Only getvar (flag == _content) hits the expand cache
             cachename = None
-- 
2.1.0


