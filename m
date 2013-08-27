Return-Path: <kergoth@gmail.com>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
	[209.85.192.177])
	by mail.openembedded.org (Postfix) with ESMTP id F0D5D6BBAF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Aug 2013 23:27:48 +0000 (UTC)
Received: by mail-pd0-f177.google.com with SMTP id y10so5456124pdj.8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Aug 2013 16:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=2IUtvLWeZxwhQ/0DVr9rzdu9qAv0/8ncIrFnnkkMTr8=;
	b=vqTSWzDSn0OqOoPPO6pnT6iKtEqM/FX2xq7kL/agjSzYGY8ptajCNhhBBPdxmSh6Kr
	xLJzQciDuBH7nEX1Z+S4RyiZnlJV+7ar2QLHHd3Z0a994sZuFeGAoqciZudGGbtygiTJ
	1/0EVTQg8LsHd5E+ZB9HREho4v8IHqEt1oQc4/64L42HA19d9RaECGm4y/1J2qlZWCm7
	NK3N6ddkIqtFYdiZz5frDG2xhevYzZ1vF4CAbucuWKwITolwV0uXK1CeYvUyUlCNzBhg
	EX+VNLLZN3FbdCVE7xSieVzZUExmBQxIiK5ah+G/qahaQm9F4yF9s2omx+mNhQ87Y8Xj
	JkAQ==
X-Received: by 10.68.139.201 with SMTP id ra9mr24037156pbb.46.1377646069983;
	Tue, 27 Aug 2013 16:27:49 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPSA id
	mz5sm27126503pbc.18.1969.12.31.16.00.00
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 27 Aug 2013 16:27:48 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 27 Aug 2013 16:27:40 -0700
Message-Id: <1377646061-24208-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 1.8.3.4
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 1/2] data_smart: use a split/filter/rejoin for _remove
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
X-List-Received-Date: Tue, 27 Aug 2013 23:27:49 -0000

From: Christopher Larson <chris_larson@mentor.com>

This is more idiomatic, and from the limited performance testing I did, is
faster as well. See https://gist.github.com/kergoth/6360248 for the naive
benchmark.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/data_smart.py | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 3fb88a9..6229fbf 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -589,13 +589,9 @@ class DataSmart(MutableMapping):
         if expand and value:
             value = self.expand(value, None)
         if value and flag == "_content" and local_var and "_removeactive" in local_var:
-            for i in local_var["_removeactive"]:
-                if " " + i + " " in value:
-                    value = value.replace(" " + i + " ", " ")
-                if value.startswith(i + " "):
-                    value = value[len(i + " "):]
-                if value.endswith(" " + i):
-                    value = value[:-len(" " + i)]
+            filtered = filter(lambda v: v not in local_var["_removeactive"],
+                              value.split(" "))
+            value = " ".join(filtered)
         return value
 
     def delVarFlag(self, var, flag, **loginfo):
-- 
1.8.3.4


