Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D94FC5B572
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 15:24:40 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9693.1787153073016419463
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 08:24:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=OR1IedFi;
 spf=pass (domain: snapchat.com, ip: 209.85.214.170, mailfrom: ecordonnier@snapchat.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d560775ca2so9347495ad.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1787153072; x=1787757872; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XcRqNmY9MV2sUWTWbIVPwyWVLd6LEbTx1BpEKOsK2eU=;
        b=OR1IedFiwJgSqHpWu8rVBRdcQb2gabTCcj0sT1Q2HckiLq6tDvWWP8XLnAdr8rmycJ
         I4PjYKLT7CtxrJRWDUVKuXCuf7PUuCVzIJWwShH97NR9VfOl+v3C5Y4+AK95Cw4ytvwh
         FlGOBgUcXi5FjJ95FeVCzafcsIObJcjFVa32M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787153072; x=1787757872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XcRqNmY9MV2sUWTWbIVPwyWVLd6LEbTx1BpEKOsK2eU=;
        b=L9BtpExBEd6xnoLpBDS4yS8xt2JrRtED2ewT5PTP4t2CRubPBId4nIehlSqDJeqAsK
         hxoNifYgKU/jKnriorb80gC39rh9ite3sX5cMpezwYojfXv3IKWFnSH3VotyoQLMXxkE
         iGrPqPI+KJ3B0bcH5W6aLZaXrlDHg1ZoKKxq0JXbf63ZTsyaTnJLN1yyiDCZgFxIsqMU
         eEh6OC/1sR+2SEP/xL5kH3/Z3V4Bm9K8JGaoMxHs80nSataJ0YTz6DDrZk3zkGhP1sb4
         0gTtbnP7XpoYqzOk45aRp0XE70WOBOJ+IKY8p+BI2mHcTujNeYiosBIeS3EE9/GA7yw7
         kG+Q==
X-Gm-Message-State: AOJu0Yyaad41q/rs+WB9d9KXENiKpXTjvpdn80GzxW6cB1aHTu7JXJ2r
	5A9+Pjk352uZVtC9JHxj2s1DYIFHRgZmFoHXGEeEAmgl72HVNkhk+BxBVK0ZAAOaee6L+uqPW1N
	syyhmI8U=
X-Gm-Gg: AR+sD13r/xxe0KscQo+tAXUhLo4qQcy1XA4a6zWR7DnCGXKu8lWWh9Xm7+4UbCeluc4
	JnC2XRVGbP8jaKN1rPEmeyVMpgJ15TuA+fT610ojNaT8Ef4HwgZQpl0zdCvwGejJVbNC1LJdxxa
	dMkULWKTxmhEIHZNuBP/RS3G5IyHCnVF4sKg2LMRyMLhKze2sXE9/9p7x2vRoaFbJSecCvFxj4j
	1IkBIWRyqnfSkX5tfAFXOXgxMndMqIf6O1gXGf5qWdVeOrEq4wmTOW82cKa1JHQ8qjBfGK50B+V
	y7J99XZvIjZDyasFu5U0WsGMXFBlBWHz+acWyIfe7AVAZb3zW9MH42BE1BxJsA5/HWr++DuZH0X
	D+vKa2PXEvNpLj384zQa4upWOqDKroFUDlO0o1t8msQpWQzBTs9WAuiClI2Re/SUD0ry1VfLII6
	F1ZaC7JXrYvmpOhBLCBxpaCc12O9drMh3SctjCH8wdsNV+PlGLO5k5aXqof1W8JQBlijDTwjlmH
	DngqCd9HiYlKwahf/zNY2jK/HTJ4AUIKQ==
X-Received: by 2002:a17:903:11c9:b0:2d0:8b28:517c with SMTP id d9443c01a7336-2d5fd5ff2e9mr96286775ad.3.1787153072073;
        Wed, 19 Aug 2026 08:24:32 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3993dsm7354657eec.5.2026.08.19.08.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:24:31 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Sebastian Muxel <smuxel@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH] fetch2/gcp: treat GatewayTimeout as fetch failure
Date: Wed, 19 Aug 2026 17:24:19 +0200
Message-ID: <20260819152419.49266-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 15:24:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20002

From: Sebastian Muxel <smuxel@snap.com>

blob.exists() and blob.download_to_filename() can raise
google.api_core.exceptions.GatewayTimeout after the GCS client's own
retries. Uncaught, that escapes as a hard error instead of a normal
fetch/checkstatus failure (and blocks mirror fallback on download).

Catch GatewayTimeout in checkstatus() and download(), log a warning so
the timeout is visible, and raise FetchError.

AI-Generated: Cursor with Grok 4.5
Signed-off-by: Sebastian Muxel <smuxel@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/fetch2/gcp.py | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
index 86546d40b..462b8e97a 100644
--- a/lib/bb/fetch2/gcp.py
+++ b/lib/bb/fetch2/gcp.py
@@ -57,7 +57,7 @@ class GCP(FetchMethod):
         Fetch urls using the GCP API.
         Assumes localpath was called first.
         """
-        from google.api_core.exceptions import NotFound
+        from google.api_core.exceptions import GatewayTimeout, NotFound
         logger.debug2(f"Trying to download gs://{ud.host}{ud.path} to {ud.localpath}")
         if self.gcp_client is None:
             self.get_gcp_client()
@@ -71,6 +71,13 @@ class GCP(FetchMethod):
             blob.download_to_filename(ud.localpath)
         except NotFound:
             raise FetchError("The GCP API threw a NotFound exception")
+        except GatewayTimeout as e:
+            # The GCS client already retries GatewayTimeout internally.
+            # Raise FetchError so mirror fallback can proceed.
+            logger.warning(
+                f"GCP API GatewayTimeout while downloading gs://{ud.host}{ud.path}: {e}"
+            )
+            raise FetchError(f"Transient GCP API GatewayTimeout for gs://{ud.host}{ud.path}")
 
         # Additional sanity checks copied from the wget class (although there
         # are no known issues which mean these are required, treat the GCP API
@@ -88,6 +95,8 @@ class GCP(FetchMethod):
         """
         Check the status of a URL.
         """
+        from google.api_core.exceptions import GatewayTimeout
+
         logger.debug2(f"Checking status of gs://{ud.host}{ud.path}")
         if self.gcp_client is None:
             self.get_gcp_client()
@@ -96,7 +105,18 @@ class GCP(FetchMethod):
 
         # Path sometimes has leading slash, so strip it
         path = ud.path.lstrip("/")
-        if self.gcp_client.bucket(ud.host).blob(path).exists() == False:
+        try:
+            exists = self.gcp_client.bucket(ud.host).blob(path).exists()
+        except GatewayTimeout as e:
+            # The GCS client already retries GatewayTimeout internally.
+            # Surface a normal checkstatus failure and warn so the timeout
+            # is visible to operators.
+            logger.warning(
+                f"GCP API GatewayTimeout while checking gs://{ud.host}{ud.path}; treating as unavailable: {e}"
+            )
+            raise FetchError(f"Transient GCP API GatewayTimeout for gs://{ud.host}{ud.path}")
+
+        if exists == False:
             raise FetchError(f"The GCP API reported that gs://{ud.host}{ud.path} does not exist")
         else:
             return True
-- 
2.43.0


