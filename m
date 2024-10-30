Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C01D6B6A0
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:01:49 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.18610.1730304099712437731
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 09:01:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=kU3qSI7g;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.46, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e34a089cd3so5552262a91.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730304099; x=1730908899; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VuKpA2p+TArnJ8URJib22XlYhSwwKCDMRq0EPPoJdJQ=;
        b=kU3qSI7gxYvODglnxhQ3hyZqu3fIS+Ms9FUb/AMLiQReyjllvxWN3wefCuC6umngI9
         ic9hexhYa9u75nO/yjWGwxu6I3z6U3DKZoNnPGpVTkmACU34tzh7bZr+i8emjWANPshV
         /YclnpUEKDD6NV8lyKf2q2DG5JysnQ+G4PZpE7ihTgrdTNesigv0SCrSEnbaNkUPNwwy
         SrI6iReXy5YbVM787Rjw/oZ5r+l6lcsL28iQ6VGwpg4HWgR4D9Ft38dDtZTUdxQWP452
         EHLlH/PJJgYUs8qOUqo58gjv8pM/F6HvQYTgj8GwIBPJhvXKKg9RXspSbMrXu9hpu32S
         qHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730304099; x=1730908899;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuKpA2p+TArnJ8URJib22XlYhSwwKCDMRq0EPPoJdJQ=;
        b=U3xFZw/t9lpSUpzkwMf+rQA7/EPCcej6aGQPe2ogmPUAhuasujEL1X9ZbRLGZfzQVl
         SJC3z2CO9yKoNhPesnEL317ttAH1QxVdLKO86uhWLm/cvCeWiJMeSPIPvmxEhqj43QUe
         I/5UaqSH4euxcLC5QxQQyxcQnbfOtlF4Bjuu0am/7ZMi1wqE8KIbNa/kwaNODe974Ba1
         4Qu1XzqQADqIOqDEI2HDO8bCdex1F1od6nn0+r4i/J78ZzW6N9VbHWtT+f+WYUuEhSKp
         buoRAEmzvoNagQmuhNNqqxzkjhdqLVLkjQjVDQOYA6G4lQ+b6oe98EuI6zYpioCGeYgJ
         VmvQ==
X-Gm-Message-State: AOJu0YyeHKt1uIKZTKdyruijGFUQusXW1wUCq/o2P79LJfBbTvPA85Gx
	v9rFHGL7BzF4WQ0pLz62IO9oPB3/B70HJDTnOHh4KieSoZuSK6SBJ5ACnebZHxa7PT1hFTs/mTw
	t
X-Google-Smtp-Source: AGHT+IFDtQCwPODI+O3kMrwc5sX7ls4beWUpGDkPJboDxZEpToH67rpF9wg+6J4yprPOF4ZjFm8L0A==
X-Received: by 2002:a17:90a:7847:b0:2e2:c69b:669 with SMTP id 98e67ed59e1d1-2e8f10a6f5bmr18077086a91.27.1730304098923;
        Wed, 30 Oct 2024 09:01:38 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa26a4fsm1911814a91.23.2024.10.30.09.01.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:01:38 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 3/4] tests/fetch: Use our own mirror of sysprof to decouple from gnome gitlab
Date: Wed, 30 Oct 2024 09:01:23 -0700
Message-Id: <18bb5e9387a4d80fced48b898827f280b9d1cbbe.1730303370.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730303370.git.steve@sakoman.com>
References: <cover.1730303370.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 16:01:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16748

From: Richard Purdie <richard.purdie@linuxfoundation.org>

GNOME gitlab has occasional downtime which impacts bitbake-selftest
and causes autobuilder failures. Switch to our own mirror for test
purposes to avoid those issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 008808755ed6cfeb6c41273e69ce718f0833c26c)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4e26e3881..d9883e12a 100644
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
-- 
2.34.1


