Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 79DCC73D27
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 20:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8GKssxd011170 for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:54:54 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id aKtK4gkBXG-i for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:54:54 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8GKsgs4011153
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:54:53 +0100
Message-ID: <1442436882.26666.169.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Sep 2015 21:54:42 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Separate out update_overridevars into separate function
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
X-List-Received-Date: Wed, 16 Sep 2015 20:54:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

No code changes, just refactoring to allow for functionality 
changes by moving things to a separate function.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 6754e7d..f245d99 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -491,10 +491,8 @@ class DataSmart(MutableMapping):
             if '_' in var:
                 self._setvar_update_overrides(base, **loginfo)
 
-
             if base in self.overridevars:
-                self.overridevars.update(self.expandWithRefs(value, var).references)
-                self.internal_finalize(True)
+                self._setvar_update_overridevars(var, value)
             return
 
         if not var in self.dict:
@@ -527,8 +525,11 @@ class DataSmart(MutableMapping):
         self.varhistory.record(**loginfo)
 
         if var in self.overridevars:
-            self.overridevars.update(self.expandWithRefs(value, var).references)
-            self.internal_finalize(True)
+            self._setvar_update_overridevars(var, value)
+
+    def _setvar_update_overridevars(self, var, value):
+        self.overridevars.update(self.expandWithRefs(value, var).references)
+        self.internal_finalize(True)
 
     def _setvar_update_overrides(self, var, **loginfo):
         # aka pay the cookie monster



