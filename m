Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web09.14891.1625617234643080659
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jul 2021 17:20:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id 2233040C52
	for <bitbake-devel@lists.openembedded.org>; Wed,  7 Jul 2021 00:20:34 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVtht-nT4Bw7 for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jul 2021 00:20:34 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-86-127.washdc.fios.verizon.net [100.15.86.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id 1707C40A47
	for <bitbake-devel@lists.openembedded.org>; Wed,  7 Jul 2021 00:20:34 +0000 (UTC)
Received: from gimli.denix (unknown [192.168.30.6])
	by mail.denix.org (Postfix) with ESMTP id D010F174619;
	Tue,  6 Jul 2021 20:20:33 -0400 (EDT)
From: "Denys Dmytriyenko" <denis@denix.org>
To: bitbake-devel@lists.openembedded.org
Cc: Denys Dmytriyenko <denis@denix.org>
Subject: [PATCH][1.46/1.48] providers: replace newly added logger.warn() with logger.warning()
Date: Tue,  6 Jul 2021 20:20:27 -0400
Message-Id: <1625617227-7586-1-git-send-email-denis@denix.org>
X-Mailer: git-send-email 2.7.4

Commit https://git.openembedded.org/bitbake/commit/?id=78cd63285713fde59506eb2e71a7b7ee59a594ff
converted logger.info() to logger.warn(), which is deprecated and instead
should use logger.warning():

https://lists.openembedded.org/g/bitbake-devel/topic/82742194#12377

Signed-off-by: Denys Dmytriyenko <denis@denix.org>
---
 lib/bb/providers.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 3f66a3d..484e1ea 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -151,7 +151,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
         if item:
             itemstr = " (for item %s)" % item
         if preferred_file is None:
-            logger.warn("preferred version %s of %s not available%s", pv_str, pn, itemstr)
+            logger.warning("preferred version %s of %s not available%s", pv_str, pn, itemstr)
             available_vers = []
             for file_set in pkg_pn:
                 for f in file_set:
@@ -163,7 +163,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
                         available_vers.append(ver_str)
             if available_vers:
                 available_vers.sort()
-                logger.warn("versions of %s available: %s", pn, ' '.join(available_vers))
+                logger.warning("versions of %s available: %s", pn, ' '.join(available_vers))
         else:
             logger.debug(1, "selecting %s as PREFERRED_VERSION %s of package %s%s", preferred_file, pv_str, pn, itemstr)
 
-- 
2.7.4

