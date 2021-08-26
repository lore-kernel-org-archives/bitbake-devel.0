Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.34426.1629999425256017927
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Aug 2021 10:37:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com header.s=axis-central1 header.b=EcrAbMQC;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1629999425;
  x=1661535425;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5GeDNkGCyzCnKQSybPyfiFlkNr4iIa0elQWhUKVV1aI=;
  b=EcrAbMQCx19BKPquJ9d8HOxDUuJyDo/y6cuq83D3yRborBF03AxZ2mAr
   gLnwOo/a790ApOggxNCi9DEMjVrRnq3TOLSz5dYdkLOp+ZgkRQJJENVM0
   OgYamx9kEuRJSR0xV3m89nvVTpDKG1tMQIaBUnD8VO+GVx5vik4BBkApz
   CNPlkkEd4owxmd+Yn5/vdMDj2XICO1nZDXbuY+TOSMZlA0vOT4pkRztop
   sLcA6+oDkiFVQF8qI6BxiWsST1Z7GPWOCzo22EYlA/m2in7MaoXMzqyOt
   4QVpxVksqFeTDJRx1ra4Nn6imFMIHaKkxjOQJYlSy3KkBL/Mw9VhcaxsN
   Q==;
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] providers: Use new override syntax when handling pn- "override"
Date: Thu, 26 Aug 2021 19:37:01 +0200
Message-ID: <20210826173701.3555-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Return-Path: pkj@axis.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Make versionVariableMatch() support pn-foo overrides using the new
override syntax.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/providers.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/providers.py b/bitbake/lib/bb/providers.py
index 516d45e4aa..8c1c31a5c5 100644
--- a/bitbake/lib/bb/providers.py
+++ b/bitbake/lib/bb/providers.py
@@ -94,7 +94,7 @@ def versionVariableMatch(cfgData, keyword, pn):
 
     # pn can contain '_', e.g. gcc-cross-x86_64 and an override cannot
     # hence we do this manually rather than use OVERRIDES
-    ver = cfgData.getVar("%s_VERSION_pn-%s" % (keyword, pn))
+    ver = cfgData.getVar("%s_VERSION:pn-%s" % (keyword, pn))
     if not ver:
         ver = cfgData.getVar("%s_VERSION_%s" % (keyword, pn))
     if not ver:
