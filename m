Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 6184175D1E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 14:59:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExMv8026633; Wed, 8 Jul 2015 15:59:26 +0100
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xsa8ukNI5VNO; Wed,  8 Jul 2015 15:59:26 +0100 (BST)
Received: from ted (5751f4a1.skybroadband.com [87.81.244.161])
	(authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t68ExN8S026609
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 8 Jul 2015 15:59:24 +0100
Received: from richard by ted with local (Exim 4.84_RC1)
	(envelope-from <richard@dan.rpsys.net>)
	id 1ZCqog-0004T2-0l; Wed, 08 Jul 2015 15:59:18 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 15:59:06 +0100
Message-Id: <a81b1789474e171c021bbc57efbb3eb8dd0e03c2.1436367362.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
References: <f838666705583fb6c9bb9b39623e24b0e5ea2de7.1436367362.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
References: <cover.1436367362.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 12/16] data_smart: Cache set(self.overrides)
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

This performs better than continually regeneratiing the set().

Also only use set comparisions when its necessary to save some overhead
as issubset() is slower in the single item case.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data_smart.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index c91b51f..941c158 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -369,7 +369,9 @@ class DataSmart(MutableMapping):
             self.inoverride = True
             # Can end up here recursively so setup dummy values
             self.overrides = []
+            self.overridesset = set()
             self.overrides = (self.getVar("OVERRIDES", True) or "").split(":") or []
+            self.overridesset = set(self.overrides)
             self.inoverride = False
             self.expand_cache = {}
 
@@ -450,10 +452,10 @@ class DataSmart(MutableMapping):
                 active = []
                 self.need_overrides()
                 for (r, o) in self.overridedata[var]:
-                    if o in self.overrides:
+                    if o in self.overridesset:
                         active.append(r)
                     elif "_" in o:
-                        if set(o.split("_")).issubset(set(self.overrides)):
+                        if set(o.split("_")).issubset(self.overridesset):
                             active.append(r)
                 for a in active:
                     self.delVar(a)
@@ -600,10 +602,12 @@ class DataSmart(MutableMapping):
             self.need_overrides()
             for (r, o) in self.overridedata[var]:
                 # What about double overrides both with "_" in the name?
-                if o in self.overrides:
-                    active[o] = r
-                elif set(o.split("_")).issubset(set(self.overrides)):
+                if o in self.overridesset:
                     active[o] = r
+                elif "_" in o:
+                    if set(o.split("_")).issubset(self.overridesset):
+                        active[o] = r
+
             mod = True
             while mod:
                 mod = False
-- 
2.1.0


