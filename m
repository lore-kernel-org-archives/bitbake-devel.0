Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1A55D60034
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jan 2015 14:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0TEZkNf021470 for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jan 2015 14:35:52 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cn_jEDRWUjMZ for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jan 2015 14:35:52 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0TEZbdK021446
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jan 2015 14:35:49 GMT
Message-ID: <1422542137.5312.6.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 29 Jan 2015 14:35:37 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] data_smart: Don't use mutable objects as default args
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
X-List-Received-Date: Thu, 29 Jan 2015 14:35:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

These only have one instance created which means your subsequent datastores
can contain echos of previous ones. Obviously this is not the behaviour
we want/expect. It doesn't affect bitbake too badly as we only have one
datastore, it does massively potentially break our selftests though.

Thanks to Tim Amsell for pointing out the now obvious problem!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 68d273b..b1ea33f 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -296,9 +296,14 @@ class VariableHistory(object):
                 self.variables[var] = []
 
 class DataSmart(MutableMapping):
-    def __init__(self, special = COWDictBase.copy(), seen = COWDictBase.copy() ):
+    def __init__(self, special = None, seen = None ):
         self.dict = {}
 
+        if special is None:
+            special = COWDictBase.copy()
+        if seen is None:
+            seen = COWDictBase.copy()
+
         self.inchistory = IncludeHistory()
         self.varhistory = VariableHistory(self)
         self._tracking = False



