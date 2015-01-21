Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id ADAD972BCE
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Jan 2015 16:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LG8HZf000741; Wed, 21 Jan 2015 16:08:17 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id blyD_TlAe9Tr; Wed, 21 Jan 2015 16:08:17 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t0LG86KM000712
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Jan 2015 16:08:17 GMT
Message-ID: <1421856486.19798.1.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 21 Jan 2015 16:08:06 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Cc: Philip Balister <philip@balister.org>
Subject: [PATCH] cooker: Use expanded_data for ASSUME_PROVIDED
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
X-List-Received-Date: Wed, 21 Jan 2015 16:08:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Users expect operators like _remove to work on this variable. We need
to use expanded_data to ensure this happens correctly.

[YOCTO #7135]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index a7560a1..f77c6c0 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -564,7 +564,7 @@ class BBCooker:
             fn = self.matchFile(fn)
             fn = bb.cache.Cache.realfn2virtual(fn, cls)
         elif len(pkgs_to_build) == 1:
-            ignore = self.data.getVar("ASSUME_PROVIDED", True) or ""
+            ignore = self.expanded_data.getVar("ASSUME_PROVIDED", True) or ""
             if pkgs_to_build[0] in set(ignore.split()):
                 bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
 
@@ -1484,7 +1484,7 @@ class BBCooker:
         if len(pkgs_to_build) == 0:
             raise NothingToBuild
 
-        ignore = (self.data.getVar("ASSUME_PROVIDED", True) or "").split()
+        ignore = (self.expanded_data.getVar("ASSUME_PROVIDED", True) or "").split()
         for pkg in pkgs_to_build:
             if pkg in ignore:
                 parselog.warn("Explicit target \"%s\" is in ASSUME_PROVIDED, ignoring" % pkg)



