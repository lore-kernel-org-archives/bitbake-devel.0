Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 06ED775D1E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMv2026633; Wed, 8 Jul 2015 15:59:24 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id T7WaSUoak2rl; Wed,  8 Jul 2015 15:59:24 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMaw026601
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:23 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqof-0004SO-CV; Wed, 08 Jul 2015 15:59:17 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:58:58 +0100
Message-Id: <6cb692584faf1c03f6b175dcc7eac8b46be8a635.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 04/16] data_smart: Fix cache clearance problems
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:26 -0000

These write operations should clear the expand cache since they can
influence returned variable values but currently do not. Fix this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index aefc0b9..eee5827 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -536,6 +536,7 @@ class DataSmart(MutableMapping):
                 self._seen_overrides[override].remove(var)
 
     def setVarFlag(self, var, flag, value, **loginfo):
+        self.expand_cache = {}
         if 'op' not in loginfo:
             loginfo['op'] = "set"
         loginfo['flag'] = flag
@@ -624,6 +625,7 @@ class DataSmart(MutableMapping):
         return value
 
     def delVarFlag(self, var, flag, **loginfo):
+        self.expand_cache = {}
         local_var = self._findVar(var)
         if not local_var:
             return
@@ -653,6 +655,7 @@ class DataSmart(MutableMapping):
         self.setVarFlag(var, flag, newvalue, ignore=True)
 
     def setVarFlags(self, var, flags, **loginfo):
+        self.expand_cache = {}
         infer_caller_details(loginfo)
         if not var in self.dict:
             self._makeShadowCopy(var)
@@ -682,6 +685,7 @@ class DataSmart(MutableMapping):
 
 
     def delVarFlags(self, var, **loginfo):
+        self.expand_cache = {}
         if not var in self.dict:
             self._makeShadowCopy(var)
 
-- 
2.1.0


