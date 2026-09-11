Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F516C88E50
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 22:18:12 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.50926.1789165091507943916
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Sep 2026 15:18:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=U8NX83xv;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49e6bad7b79so2060405e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789165090; x=1789769890; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=axi61h0WHCdVUY9vUSJp256LW2U73rjmepsQYD4aJX8=;
        b=U8NX83xvZ8HoMy1gAzooi4jtNENCiEpg4+rua+kaDYI5G8d/Q8ClLkpvQmr3+sKnnL
         rncBcgdLD9HMT8Oyj0mpyeNU3wPOGfSRvBiIxR72FNAGGqDcP7o+vvAl4calvh08Q7B6
         NVwYD011NcUR166W5jbN3CldKQBgpiENg64Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789165090; x=1789769890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=axi61h0WHCdVUY9vUSJp256LW2U73rjmepsQYD4aJX8=;
        b=NU+4yY7oSQuG+C0kbkkCglCfckDOO9790W4fJ1dLBN7A4isUDda411R/XS/4WkwOt8
         GxhAZtlyfSL2Vo2imXInSEmF4ohmVEahMLBqjOcQD+1T2onxv1JeKj+NiE12zD8TjePx
         gBPQ/gaofPQ/kwvm6dT0gvXf7pR46yBuzwiH/hRtSKbKGsGiAMARwFNIJQaHZILfRqaU
         jrMiwtvlebnVp6BqcHU+zYuXd0R44z/qnjUyUTsXL32qmRnPWc90p8wegzOlWyo+hNFa
         +NaVD8GFgVU+Es/X7LXn+nY852SBh/8pcZ/IOuElGEmoc+Ym0Fe9kXD5aPJDDI5iKiio
         Ctlg==
X-Gm-Message-State: AFuF++ljDp8hU7urtxg1NrZtnQ9j6Z5QIIj7Wk0v8XXbx2aGX+Bv147T
	qYTOOVgREECEYYOFPDcrnxDCJKbrf0SIyEAS84amcTC7jD8kXGUdNb7ND8/OXMUwurKHw9t13Mj
	6W71R7dQ=
X-Gm-Gg: AYBFou3tZQoeiPgjbumidg51Bn+esS2Z03WBrFTiPQ8Gd4cgy6FF8XPFSxG1viqGxal
	AaPQXqObhhywTsgPcHfhPWbRLSV2AFy/TFG4p6z5zAgwoULXzg2l8coKWBIvx5/SJGwj2NxfXyy
	299hzcjI6JOtyeOR23kAO2qWyvvdlIEWOQQBqcEEZ3ZndKR0eTpIXNI+oqF1ylIsoW1QSrfQgMl
	5XcEFlRcR0tFSaxQytabNKvC3L0ue8Pi0+nKkWQoxa7xoPqLF8GPfHD5R9IR4v5/RW0q9xJKmRH
	paxCC78yNcdQlbFMxcQ7puks3J4J+AfQVDJ1NDlVXA4pAThty1+Te7RxigvI8SGtu38l3dp1Jq3
	f695mPP9AE0Eig1VdI0Elfw6iM1+HV+1QHSmQRK563+zElFjOL4wjVQ1yh5r0sibXyaKuT+i+Zk
	gQ/7RZhlwCaMh1xtMrPgTQU7JdGs35VjDGTLtbOoW4IS5bXiwTHf3hDtT/C0BAahovnJbeg9frk
	pSYX59Jrowg5msIJDE6hhQb2ntWhjLbvU3C1Py7/vp07CM0pSOOt5gbcg/xrTZgpLICyTI4AOI=
X-Received: by 2002:a05:600d:8485:20b0:49d:1e3d:3b3f with SMTP id 5b1f17b1804b1-49e6198bd27mr19422855e9.8.1789165089709;
        Fri, 11 Sep 2026 15:18:09 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a33e34sm78235165e9.0.2026.09.11.15.18.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:18:09 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/4] fetch2/gcp: treat GatewayTimeout as fetch failure
Date: Sat, 12 Sep 2026 00:18:03 +0200
Message-ID: <c085e5e2a91cda2b10f14b72d6f5fac8b8c209b6.1789165002.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789165002.git.yoann.congal@smile.fr>
References: <cover.1789165002.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 22:18:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20184

From: Sebastian Muxel <smuxel@snap.com>

blob.exists() and blob.download_to_filename() can raise
google.api_core.exceptions.GatewayTimeout after the GCS client's own
retries. Uncaught, that escapes as a hard error instead of a normal
fetch/checkstatus failure (and blocks mirror fallback on download).

Catch GatewayTimeout in checkstatus() and download(), log a warning so
the timeout is visible, and raise FetchError.

(cherry-picked from commit 251f01e9afa1dcb9a49f8a31981e698017a43754)

AI-Generated: Cursor with Grok 4.5
Signed-off-by: Sebastian Muxel <smuxel@snap.com>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/gcp.py | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
index 2ee9ed219..c3cbc948f 100644
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

