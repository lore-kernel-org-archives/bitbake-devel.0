Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86BBD13588
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 09:30:39 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.47709.1730107834031277507
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Oct 2024 02:30:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IgjL4T09;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so3049954f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Oct 2024 02:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730107832; x=1730712632; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=odmTkkOT4n/USvj/6gpAsxYM9PCyoQkGf8bnqS/o9XI=;
        b=IgjL4T09LNb0ZD5/TzEj+H47d55zdFGudVRN+cN4iDN27fua4SB9H20Mrte5coe5Fj
         xZp8ybRENf5i1oQmZg5+14IxrqQkev6TS4jyJiZq+LUqiL0OgbAZXTFwwb9Ym9yzoiCs
         lZ5ylYmBeNI0p8mLOZmtg8OWMElsNo/Bvnj+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730107832; x=1730712632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odmTkkOT4n/USvj/6gpAsxYM9PCyoQkGf8bnqS/o9XI=;
        b=Wz8g+i5ho4PH9phcBxw4cMf6o9Ca+jTwns699l9hL8P1gojIK26KmqeoWsmpIJBSFz
         DP4cHCLIbIGuek2UMCuFW+4M5D955NMJobQ9/0K5s15ruzn5pAx5haXYJyHGJSToNJba
         sAH9viKNUWKvfR4NeD9ZMzksuIOoY0vp19Zr0bC8CZGoF9Oy24G7xofEzvNy3VEyU0nx
         KENK5+vR4VU8JRlOYEXcjdetXMaqXkNTXwt66jw4Filoum9/I7kWAPPfcLMK6EsMOYVC
         KIg4x1Tka04H/kU1o6+jKq5PHggP0ZvRCSDPL32jDKGwNrOheuYDvplPkVG/b0hPSoAm
         gz0Q==
X-Gm-Message-State: AOJu0YxKzvz/7+FsnZH0i7vuViXcn6c8v4ZV5LrISutCwf0WD6VcWq1p
	2sK4InEkEcQSrbpHNLmy70/JYX/f4nm5W+/AXaRWAhMOdL6wkTFHKPX762geqQCer9kKDtOPpcB
	SaQ4=
X-Google-Smtp-Source: AGHT+IFFdEkpCgGYauuH/1I7sOZJXDWsbWy5b6nDHyuR+dSpTCZ5u8NR/a9LU93WL3TRAbb0S6gOIA==
X-Received: by 2002:a5d:494e:0:b0:37d:4d31:e86c with SMTP id ffacd0b85a97d-380611f51f4mr5219617f8f.44.1730107832099;
        Mon, 28 Oct 2024 02:30:32 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:73ef:5707:ed3d:2605])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5433f2sm134198385e9.1.2024.10.28.02.30.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 02:30:31 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] tests/fetch: Use our own mirror of sysprof to decouple from gnome gitlab
Date: Mon, 28 Oct 2024 09:30:31 +0000
Message-ID: <20241028093031.82139-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Oct 2024 09:30:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16736

GNOME gitlab has occasional downtime which impacts bitbake-selftest
and causes autobuilder failures. Switch to our own mirror for test
purposes to avoid those issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4e26e38811..d9883e12a8 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1427,7 +1427,7 @@ class FetchLatestVersionTest(FetcherTest):
         ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=master;protocol=https", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "", "")
             : "1.4.0",
         # combination version pattern
-        ("sysprof", "git://gitlab.gnome.org/GNOME/sysprof.git;protocol=https;branch=master", "cd44ee6644c3641507fb53b8a2a69137f2971219", "", "")
+        ("sysprof", "git://git.yoctoproject.org/sysprof.git;protocol=https;branch=master", "cd44ee6644c3641507fb53b8a2a69137f2971219", "", "")
             : "1.2.0",
         ("u-boot-mkimage", "git://source.denx.de/u-boot/u-boot.git;branch=master;protocol=https", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "", "")
             : "2014.01",

