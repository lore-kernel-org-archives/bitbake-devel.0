Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F5ACAC5A8
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 14:07:30 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.53063.1758550045500707853
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Sep 2025 07:07:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Td0E7crQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee155e0c08so2752907f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758550043; x=1759154843; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfJfvixZQyqlD9ekc4Siqu7pgsGL0xci7F1j38GTWOc=;
        b=Td0E7crQXG86nMBHyQ2M0XsQ33+Hueh5poHm61cFNsxXSaWbAVpfUTB/wKoYqk18H0
         bdpk0DyvYhLJZqpKgSrgDjuSd6LtcZQaUNftJIZfrZKHxMTQlkIq2ujY3+2FzpmJjH4b
         qlJaNJiH+PV12Rwb2sHEE2o3Zu90o6uafuP48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550043; x=1759154843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfJfvixZQyqlD9ekc4Siqu7pgsGL0xci7F1j38GTWOc=;
        b=PDAR1vtbUMpviwF2NkHr2JHK9P9WYnNw+6/sGeW6/rC1fVZfAYdONl11+Nwh67lEL3
         8D+2Ac966z9/te9MnY10g1UKv+ip1dKowcY/bIi8GZ3KmY0SerSZ1euv06yZlfDG49tW
         x0VLEzIVC4nH6M/WyGQg9C9nm+AvtNeBnBNIhqyUtPmQLZq73lmHgJPy1l3VQmMbryTs
         X7yuiZg7Y2Eh+GvRrLhBltg28PdohKNdmu3+YxD7/H0prgXk1QOW0M9G4rquZtUjQbxV
         mUV07AojtV+FInTzCM7NuDA8uR8GaOPnMYKoDD0egwBvKujKataDQWmeTFiKKpjMjGPI
         ikHQ==
X-Gm-Message-State: AOJu0YxvnaGZbiU1KsRxFcyzbVoSMPs3HSb1V/LMj/Fgd59B6Y5ruVlo
	dbIRfbEtIayixVfaaZIiyp7AZ+gyfKV/pQopQ+5+z1uiJachM1pHVpr0V9d38/YebQxjshKQF/P
	OHD7M
X-Gm-Gg: ASbGncuIAAfScvth0+2EXigFhPQW8ZDYz6HzCQibjsIvFRlw7yAwYdleOzf8wxOlJJA
	wH7TxEWR+K7M4AGcmbiJzo+OZr0wk965DjJzQxaze65Hq1bVat3zVph5RbHa7NH3Y23CKtP/cGV
	a1f3pb8OKNRQnEq67OKglrF9sFdz9zQCZ+cD8fNabs6Oxo179Kbexz5NSNZaLSRAubsbthN/Pi1
	k8/2PW8XftegCE8sBYYuXhrMiQRVfTs3gFKADKRBco9u9cEQuidWfyxb8uwISuMC2DsxT4i4vFg
	32B+rIlPC9YBHFcmX0ocSk0gLeo1kZpUaWAzG+2bVnYYX8p7GpCg0eKR2juaGCzCZHpDo75wF30
	3rtVdclyQII6CBq5GkK4d//QzvQCDFMcDzetARkUJy6Gf5qL48cs=
X-Google-Smtp-Source: AGHT+IE+mWd8S8E7O61z7RENiIZWaqDuytDKXGd9dPOi/0Ek0NKgx46GrWwbXlQiB7/yXB2xJgM7Ew==
X-Received: by 2002:a5d:5f89:0:b0:3ee:11d1:29e5 with SMTP id ffacd0b85a97d-3ee8481fdf2mr10510574f8f.33.1758550043264;
        Mon, 22 Sep 2025 07:07:23 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2639:6647:8a82:45d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7107sm20939516f8f.30.2025.09.22.07.07.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:07:22 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] bitbake-setup: Allow local registry paths
Date: Mon, 22 Sep 2025 15:07:19 +0100
Message-ID: <20250922140721.2266610-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 14:07:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18070

It is useful for bitbake-setup to support local paths without access through
the fetcher so that internal data to the bitbake repository can be used as
a default.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-setup | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index d6509500d86..b07bf2eb7c8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -509,10 +509,15 @@ def do_fetch(fetcher, dir):
 
 def update_registry(registry, cachedir, d):
     registrydir = 'configurations'
-    full_registrydir = os.path.join(cachedir, registrydir)
-    print("Fetching configuration registry\n    {}\ninto\n    {}".format(registry, full_registrydir))
-    fetcher = bb.fetch.Fetch(["{};destsuffix={}".format(registry, registrydir)], d)
-    do_fetch(fetcher, cachedir)
+    if registry.startswith("."):
+        full_registrydir = os.path.join(os.getcwd(), registry, registrydir)
+    elif registry.startswith("/"):
+        full_registrydir = os.path.join(registry, registrydir)
+    else:
+        full_registrydir = os.path.join(cachedir, registrydir)
+        print("Fetching configuration registry\n    {}\ninto\n    {}".format(registry, full_registrydir))
+        fetcher = bb.fetch.Fetch(["{};destsuffix={}".format(registry, registrydir)], d)
+        do_fetch(fetcher, cachedir)
     return full_registrydir
 
 def has_expired(expiry_date):

