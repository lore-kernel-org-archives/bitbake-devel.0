Received: from mailout4.zoneedit.com (mailout4.zoneedit.com [64.68.198.64])
 by mx.groups.io with SMTP id smtpd.web12.14864.1625617223193844514
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jul 2021 17:20:23 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: denix.org, ip: 64.68.198.64, mailfrom: denis@denix.org)
Received: from localhost (localhost [127.0.0.1])
	by mailout4.zoneedit.com (Postfix) with ESMTP id 32F1640C52
	for <bitbake-devel@lists.openembedded.org>; Wed,  7 Jul 2021 00:20:18 +0000 (UTC)
Received: from mailout4.zoneedit.com ([127.0.0.1])
	by localhost (zmo14-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyfW13ndtEcb for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Jul 2021 00:20:18 +0000 (UTC)
Received: from mail.denix.org (pool-100-15-86-127.washdc.fios.verizon.net [100.15.86.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailout4.zoneedit.com (Postfix) with ESMTPSA id 2474A40A47
	for <bitbake-devel@lists.openembedded.org>; Wed,  7 Jul 2021 00:20:18 +0000 (UTC)
Received: from gimli.denix (unknown [192.168.30.6])
	by mail.denix.org (Postfix) with ESMTP id 3E622174619;
	Tue,  6 Jul 2021 20:20:17 -0400 (EDT)
From: "Denys Dmytriyenko" <denis@denix.org>
To: bitbake-devel@lists.openembedded.org
Cc: Denys Dmytriyenko <denis@denix.org>
Subject: [PATCH] providers: replace newly added logger.warn() with logger.warning()
Date: Tue,  6 Jul 2021 20:20:02 -0400
Message-Id: <1625617202-7491-1-git-send-email-denis@denix.org>
X-Mailer: git-send-email 2.7.4

Commits https://git.openembedded.org/bitbake/commit/?id=78cd63285713fde59506eb2e71a7b7ee59a594ff
and https://git.openembedded.org/bitbake/commit/?id=5cbf6d95fc1009e78e7d0745a49e0bf418b37abb
added few calls to logger.warn(), which is deprecated and instead
should use logger.warning():

https://lists.openembedded.org/g/bitbake-devel/topic/82742194#12377

Signed-off-by: Denys Dmytriyenko <denis@denix.org>
---
 lib/bb/providers.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/providers.py b/lib/bb/providers.py
index 3ec11a4..516d45e 100644
--- a/lib/bb/providers.py
+++ b/lib/bb/providers.py
@@ -133,7 +133,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
 
     if required_v is not None:
         if preferred_v is not None:
-            logger.warn("REQUIRED_VERSION and PREFERRED_VERSION for package %s%s are both set using REQUIRED_VERSION %s", pn, itemstr, required_v)
+            logger.warning("REQUIRED_VERSION and PREFERRED_VERSION for package %s%s are both set using REQUIRED_VERSION %s", pn, itemstr, required_v)
         else:
             logger.debug("REQUIRED_VERSION is set for package %s%s", pn, itemstr)
         # REQUIRED_VERSION always takes precedence over PREFERRED_VERSION
@@ -173,7 +173,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
             pv_str = '%s:%s' % (preferred_e, pv_str)
         if preferred_file is None:
             if not required:
-                logger.warn("preferred version %s of %s not available%s", pv_str, pn, itemstr)
+                logger.warning("preferred version %s of %s not available%s", pv_str, pn, itemstr)
             available_vers = []
             for file_set in pkg_pn:
                 for f in file_set:
@@ -185,7 +185,7 @@ def findPreferredProvider(pn, cfgData, dataCache, pkg_pn = None, item = None):
                         available_vers.append(ver_str)
             if available_vers:
                 available_vers.sort()
-                logger.warn("versions of %s available: %s", pn, ' '.join(available_vers))
+                logger.warning("versions of %s available: %s", pn, ' '.join(available_vers))
             if required:
                 logger.error("required version %s of %s not available%s", pv_str, pn, itemstr)
         else:
-- 
2.7.4

