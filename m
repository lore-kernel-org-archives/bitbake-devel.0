Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id C9B37605F3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jun 2013 12:00:52 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5LC7Cae023610 for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jun 2013 13:07:12 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id GSp1-BLxVcL6 for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jun 2013 13:07:12 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5LC75Pw023605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Jun 2013 13:07:06 +0100
Message-ID: <1371816036.20823.301.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 21 Jun 2013 13:00:36 +0100
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Fix bug with overrides and weak default values
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
X-List-Received-Date: Fri, 21 Jun 2013 12:00:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

(aka pay the cookie monster for weak defaults)

If you have code like:

MYVAR = "a"
MYVAR_override ??= "b"

then MYVAR will get the value "a" even when override is in OVERRIDES. The
reason is that the value of ??= is set as a flag not a value and the cookie
monster isn't paid.

The fix is to ensure appropriate payment is made for a defaultval varflag
matching the usual setVar case.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index fa7811e..dfa9afe 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -485,16 +485,20 @@ class DataSmart(MutableMapping):
 
         # more cookies for the cookie monster
         if '_' in var:
-            override = var[var.rfind('_')+1:]
-            if len(override) > 0:
-                if override not in self._seen_overrides:
-                    self._seen_overrides[override] = set()
-                self._seen_overrides[override].add( var )
+            self._setvar_update_overrides(var)
 
         # setting var
         self.dict[var]["_content"] = value
         self.varhistory.record(**loginfo)
 
+    def _setvar_update_overrides(self, var):
+        # aka pay the cookie monster
+        override = var[var.rfind('_')+1:]
+        if len(override) > 0:
+            if override not in self._seen_overrides:
+                self._seen_overrides[override] = set()
+            self._seen_overrides[override].add( var )
+
     def getVar(self, var, expand=False, noweakdefault=False):
         value = self.getVarFlag(var, "_content", False, noweakdefault)
 
@@ -566,6 +570,9 @@ class DataSmart(MutableMapping):
             self._makeShadowCopy(var)
         self.dict[var][flag] = value
 
+        if flag == "defaultval" and '_' in var:
+            self._setvar_update_overrides(var)
+
     def getVarFlag(self, var, flag, expand=False, noweakdefault=False):
         local_var = self._findVar(var)
         value = None



