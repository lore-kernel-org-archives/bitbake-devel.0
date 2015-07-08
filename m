Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5643375E28
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExO8P026688; Wed, 8 Jul 2015 15:59:25 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zM1YWyevhVSF; Wed,  8 Jul 2015 15:59:25 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExNuq026610
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:24 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqog-0004T7-3T; Wed, 08 Jul 2015 15:59:18 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:59:07 +0100
Message-Id: <09af08d05fe6b7db033eb4ad3cd5bb888dbec890.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 13/16] data_smart: Fix keys() missing overrides
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
X-List-Received-Date: Wed, 08 Jul 2015 14:59:27 -0000

d.keys() was not returning items which had no base content but the
variable came into existance through overrides. We have to process
self.overridedata to find these other variables.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 941c158..b9c5d1e 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -809,6 +809,7 @@ class DataSmart(MutableMapping):
 
     def __iter__(self):
         deleted = set()
+        overrides = set()
         def keylist(d):        
             klist = set()
             for key in d:
@@ -816,6 +817,8 @@ class DataSmart(MutableMapping):
                     continue
                 if key in deleted:
                     continue
+                if key in overrides:
+                    continue
                 if not d[key]:
                     deleted.add(key)
                     continue
@@ -826,9 +829,21 @@ class DataSmart(MutableMapping):
 
             return klist
 
+        self.need_overrides()
+        for var in self.overridedata:
+            for (r, o) in self.overridedata[var]:
+                if o in self.overridesset:
+                    overrides.add(var)
+                elif "_" in o:
+                    if set(o.split("_")).issubset(self.overridesset):
+                        overrides.add(var)
+
         for k in keylist(self.dict):
              yield k
 
+        for k in overrides:
+             yield k
+
     def __len__(self):
         return len(frozenset(self))
 
-- 
2.1.0


