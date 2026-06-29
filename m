Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B762EC43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 12:52:34 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36867.1782737552113278932
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2026 05:52:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Jq0zLE70;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so29038795e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 05:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782737550; x=1783342350; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J266ZeTUpVUelN2GR70w1xEsw8YRXu++JZIBF0GQmHs=;
        b=Jq0zLE706ue8225Tv90LATkjxBih5YKmzKKNX8za0UZlgm77tmpKxzt+LjJqfseGcI
         fBAuUbUrGmtGHTnNRflK9pFx62LyuMXywFpfnzesPSORjjYVY+mT/qJXVGj+hQoPYcIU
         JnSU3G7d04julnBJig2vuAZRI0f91DEJpOuUz++vMyip6bPT0YIJBctG2VP0V+QuCO1M
         LlE90uyugmn132T7jCk+2dOXFCGpVmOZq1fMroDUCZSh0EcG8BiLmgBmT18yzHAyvK2p
         1FvcQKG0qdaxGHEpDnpqdj36788+u2P4I0Y0QIl9izEA2sksoilZaW6uJ5ttsnc5Zqkl
         3ajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782737550; x=1783342350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J266ZeTUpVUelN2GR70w1xEsw8YRXu++JZIBF0GQmHs=;
        b=gHpAPXyLU+e9lSIozge1tyUgWnEJrJ7EO4GdJ1N1qZQK8yW7mgz4xYiKMvSTeGiV52
         S3tEoIn6Ey4bR0gU0qcsyrUrxC1owXg2MeKySWGxUthsAeEM65BqNDq5EwqcFA8rcG31
         LZ6K7qbFq4h2pmeo7p5kpz/wrPG+dIWw+Uj3YZKvIDf/26N1NE6EQP6U+XMoyI6mtKe0
         TMDdo57XaxUTvCR6n8uSZM1INrDxy8OJkrqY5BoMTq06W9YI3d8f0UVhyklv09P8l8X8
         3/10QG+5SjkQPMkNAuhQJ864knnljg4RAUOb+ADK5U9PFANRv+VHb+rWNradiUet3kuK
         gCaw==
X-Gm-Message-State: AOJu0YzAbkXg2km0cf2+Dya0KDrOF+Xc+RCzav3j8r6dKk8eAXbKpCMX
	HaMtCbqkUKexPN/WU2ATy2OL71b/0tj7k1DxnWOAf9D7CZagI8heKkXFsCJfNOCp3Q4=
X-Gm-Gg: AfdE7ckYEdnRfTvaII5/2Spa0FtS1ATMiJRjeUf+KFNkox926sRcVce04/jXKAaOpS1
	u3VoceSfdPrxuCplLqE/K2gFDnX6xdC3gDYGjScdqgvijJDS8A+oq6l1MVKNeF/ZgemSR9pIhu7
	pMEcJ6TQpAp37/SM8wJzvkbIXfI+DsvnHbVI6X/nRSGTpAnc7MNxaIYqQaudvjYlSALTCMfcNi0
	sdcyRTYA/2mjD33uCEwfQLd0nx4+DxY76g7P9wJfzKlOrInlUnRmmMgotYyU1K5r3l4CZT2A7Sr
	aoQr0cl1PixEJAzqPPLFpqa/8G63JKGhgSsp9c0yRGGQkUmdQ0RD3o2EdQIofcT91zKjewRFwYo
	6t2Myj6ib3cZfk1UbF/uA+QYEaJJPNHayvp9iQmh+qR+WjTqen/OI8EPcCvZQchTGOjhg6SQxaF
	aDrlLl2uurX4m4t/hw9xdLH5DXPw5ipSZ1TVkFu1b0kcPCjWTD
X-Received: by 2002:a05:600c:1f91:b0:490:abef:dae6 with SMTP id 5b1f17b1804b1-492668857d3mr243066495e9.19.1782737550108;
        Mon, 29 Jun 2026 05:52:30 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268f700c0sm359459215e9.0.2026.06.29.05.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:52:29 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] fetch/wget/_check_latest_version_by_dir: correct iterative check of versioned directories
Date: Mon, 29 Jun 2026 14:52:26 +0200
Message-ID: <20260629125226.3931549-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 12:52:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19805

From: Alexander Kanavin <alex@linutronix.de>

The versioned directories check runs a loop, only considering a directory
if it is bigger or equal to the biggest directory found so far. The
criteria for 'biggest directory found so far' wasn't entirely correct:
it was set even if no valid tarballs were found in it.

This broke libadwaita's version check, when upstream released
1.10.apha (not a valid version) and made a separate directory for it.
1.10 comes ahead of 1.9, and so 1.9 would not be looked into, resulting
in the overall check failing to find any valid versions:

https://download.gnome.org/sources/libadwaita/

This corrects the 'biggest directory' criteria to also include
'contains valid versions'.

I have confirmed that overall oe-core check for latest versions still works
and reports the same versions, except libadwait check which is no longer broken.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/fetch2/wget.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 71667dd2b..141c2d062 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -610,8 +610,7 @@ class Wget(FetchMethod):
                             package, package_regex, current_version, ud, d, filter_regex)
                     if pupver:
                         version[1] = pupver
-
-                    version_dir = version_dir_new
+                        version_dir = version_dir_new
 
         return version[1]
 
-- 
2.47.3


