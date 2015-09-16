Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 795C576104
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:00:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8GL00eW011599 for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 22:00:00 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SBiOFg13z67X for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 22:00:00 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t8GKxib9011565
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Sep 2015 21:59:56 +0100
Message-ID: <1442437184.26666.175.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Sep 2015 21:59:44 +0100
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Subject: [PATCH] data_smart: When considering OVERRIDE dependencies, do so recursively
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
X-List-Received-Date: Wed, 16 Sep 2015 21:00:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Sadly its not enough to consider the dependencies of OVERRIDES, we 
need to resolve their dependencies and so on recursively. If we don't
do this, some variable can be changed and the resulting data store is
incorrect.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 7651a5e..dc8632c 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -540,7 +540,13 @@ class DataSmart(MutableMapping):
             self._setvar_update_overridevars(var, value)
 
     def _setvar_update_overridevars(self, var, value):
-        self.overridevars.update(self.expandWithRefs(value, var).references)
+        new = self.expandWithRefs(value, var).references
+        while not new.issubset(self.overridevars):
+            nextnew = set()
+            self.overridevars.update(new)
+            for i in new:
+                nextnew.update(self.expandWithRefs(self.getVar(i, True), i).references)
+            new = nextnew
         self.internal_finalize(True)
 
     def _setvar_update_overrides(self, var, **loginfo):



