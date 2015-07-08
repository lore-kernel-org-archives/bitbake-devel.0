Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 12C5B75E42
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMv7026633; Wed, 8 Jul 2015 15:59:26 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BT3y8pAEyMhd; Wed,  8 Jul 2015 15:59:26 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExNBS026608
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:24 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqof-0004Sx-U1; Wed, 08 Jul 2015 15:59:17 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:59:05 +0100
Message-Id: <2f115211535270af102d6d117e693728981ddf1d.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 11/16] data_smart: Improve override recursion handling
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:28 -0000

When expanding OVERRIDES, its possible someone might try and override a variable
that is used in OVERRIDES. This could lead to infinite recursion. Add in
guards against this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c800a9a..c91b51f 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -313,6 +313,7 @@ class DataSmart(MutableMapping):
         self.overridedata = {}
         self.overrides = None
         self.overridevars = set(["OVERRIDES", "FILE"])
+        self.inoverride = False
 
     def enableTracking(self):
         self._tracking = True
@@ -363,8 +364,13 @@ class DataSmart(MutableMapping):
 
     def need_overrides(self):
         if self.overrides is None:
+            if self.inoverride:
+                return
+            self.inoverride = True
+            # Can end up here recursively so setup dummy values
             self.overrides = []
             self.overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+            self.inoverride = False
             self.expand_cache = {}
 
     def initVar(self, var):
-- 
2.1.0


