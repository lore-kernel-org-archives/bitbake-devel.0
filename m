Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97336C61DE2
	for <webhook@archiver.kernel.org>; Mon, 31 Aug 2026 08:40:46 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25326.1788165642238389950
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 31 Aug 2026 01:40:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=NagSKCPK;
 spf=pass (domain: snapchat.com, ip: 209.85.128.53, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b965570d7so29342055e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 31 Aug 2026 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1788165640; x=1788770440; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=849YP7vPYVvpX5cKgN6ffpHw9z4gq7HAck47eeVIf/Q=;
        b=NagSKCPKLqmYPMtjdpWdOW1qfUoTpKhHEBXvsJd5I83SfZGYl37SlqkoBWBt1t1IoF
         YiBpZ4kRjmiD+ysOx83qSlPP8TnT6ae1+AJRmSZBrl5SxPlT5saPIAdKxCvD23TkjSR8
         O99EyVLVC8JlKwaZUqL5C6QfOtlyTfElt6OnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788165640; x=1788770440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=849YP7vPYVvpX5cKgN6ffpHw9z4gq7HAck47eeVIf/Q=;
        b=V5qw0AZec524sucslxz7PZ7azkZvKZbWEteAeI0SSkjuKwfjqobCjOXE/msdxcUrS/
         gcHLAnh1tWtI2ax9PxxLandAsA2YPcfevKxa/Tjsj+z0F4yXlF4fMRXCOvDKz0FiYE4z
         04AD7xCyGa2GVe2fo00nIlBERvQZXgyOOQixXZtQo9ZPTv/JjjQHQa9jA6ud08LBpOjD
         yx/7j/RRrFon6PtEG2/t82Kx91aDboz7glMMBAo2nQppAkOTW+i0somjT0US1iymSUqR
         1CT3yfP+S0EXUpUwgmc49g4r29gaZlK0jxwyKnYz8Z73dpqISnpFhI8ymb32+QPf0Ziq
         FBsQ==
X-Gm-Message-State: AFuF++kIWUoduLPEO0e9gbT7P+pPxQVwxwZYhnfSFSDmaSbxCPnXyaJi
	jQKbTXGNK1Zam1O+2Jh8n3XeiJnN6jgO3TjoFQIgJ8mIsKH2ILsa6g4C75tHCYejIry4Gy3pupE
	7wI/3h+0=
X-Gm-Gg: AR+sD13OjVWlh7Lsb1r5pCRDsDMVoKIpPBH0baCvhMfXqcOjC7/m8gNtBjPOUd/q4y0
	xxqkSWNSkY8ViBJT+1xu1sYlP5Cvvz3OXUtgjuUZ4EGBfFOvdCznqm3vTjhzMNGBj4dp8dLlryI
	LI47/eoES8SP6HcVLdhNkNKi2pV02WanA3whLwUjalKD+rgHkhJY8pj4VL3gYE9c767h/aYRXmI
	sojK6LS4GNDusGXhFvHeDmmsBnL1q/1jwgM+upym9vWmN9AMs9W/Cl6vqkN98uq+uHtLnUy+eRr
	52313RrFMI6HHA1NHF1AmhCJxZ8tuv/PTEYR+pMRvY6t4AOAA3SfnyQ3/zckpWu8E5z9P6RGgmZ
	zr0yx9ioDyxUrKfdd0TxWqykS10dA+WdFNv0xhP8/RkLrzdmQDCpz3qv0f21+s3xhKFj4eMmDIc
	swbOi2s44LXw/4Eq1ZTuQ1EDjDRdXMdfLK/VGhYVl93/TAJ5bN9APdrbmrCb5fRjy5XT9TMeyrA
	xFLYg1WrnMbBoQu9NEn/WTYAT55b6xz
X-Received: by 2002:a05:600c:3103:b0:499:be2d:c290 with SMTP id 5b1f17b1804b1-49b91c4fa9amr354350635e9.9.1788165640362;
        Mon, 31 Aug 2026 01:40:40 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b963c3c0asm486481365e9.10.2026.08.31.01.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:40:39 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Sebastian Muxel <smuxel@snap.com>,
	Etienne Cordonnier <ecordonnier@snap.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.8][PATCH] fetch2/gcp: treat GatewayTimeout as fetch failure
Date: Mon, 31 Aug 2026 10:40:31 +0200
Message-ID: <20260831084031.200351-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Aug 2026 08:40:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20134

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
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry-picked from commit 251f01e9afa1dcb9a49f8a31981e698017a43754)
Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
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
-- 
2.43.0


