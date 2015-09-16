Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4C2CE7669F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 20:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8GKw69W011474 for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:58:06 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id foO9pD6wP8K9 for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:58:06 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8GKvtsj011457
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:58:06 +0100
Message-ID: <1442437075.26666.172.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Sep 2015 21:57:55 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Expand overrides cache recursively
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
X-List-Received-Date: Wed, 16 Sep 2015 20:58:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If the values that make up OVERRIDES are themselves overridden, 
we end up into some horrible circular logic. Unfortunately some
metadata does depend on this functionality.

e.g:
DEFAULTTUNE_virtclass-multilib-xxx = Y
which changes TUNE_ARCH 
which changes TARGET_ARCH
which changes OVERRIDES

As a solution, we iterate override expansion until the values don't
change. If we iterate more than 5 times we abort and tell the user to
report the issue.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index f245d99..7651a5e 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -420,9 +420,13 @@ class DataSmart(MutableMapping):
         self.overrides = None
 
     def need_overrides(self):
-        if self.overrides is None:
-            if self.inoverride:
-                return
+        if self.overrides is not None:
+            return
+        changed = True
+        count = 0
+        if self.inoverride:
+            return
+        while changed:
             self.inoverride = True
             # Can end up here recursively so setup dummy values
             self.overrides = []
@@ -431,6 +435,14 @@ class DataSmart(MutableMapping):
             self.overridesset = set(self.overrides)
             self.inoverride = False
             self.expand_cache = {}
+            newoverrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+            if newoverrides == self.overrides:
+                changed = False
+            self.overrides = newoverrides
+            self.overridesset = set(self.overrides)
+            count += 1
+            if count > 5:
+                bb.fatal("Overrides could not be expanded into a stable state after 5 iterations, overrides must be being referenced by other overridden variables in some recursive fashion. Please provide your configuration to bitbake-devel so we can laugh, er, I mean try and understand how to make it work.")
 
     def initVar(self, var):
         self.expand_cache = {}



