Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F02D6B6B5
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 16:49:50 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.20165.1730306982087335142
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 09:49:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Uqs3x9pU;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.175, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71ec997ad06so5305b3a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730306981; x=1730911781; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7PHbBdzJxLOxFPTBsqL3GfBfhNNa9lpRlDXqEvpVGU=;
        b=Uqs3x9pUz5W7w22qQWHl+WbdJq1cb+kup2n6W04bPVYri17lQbvsGmW4x7l2RckSTz
         VkRddCG5tMYuQwEzcts4s06Kd0byMI+bfHpNac8y8yODBy1jWEmQs4JGcEslDBWz0ZJf
         T3Vdxnr1gRqVSNlTuM8Q8npWlPAZbfXarTLMjZVSL0a6SQUw7jlVuiJkXZI0FM/gaMaP
         XiRb6wlw+g5pf2/SMemBhHaUSmdOob5l+rp7L56xxDX0PEVoqQ+ZTurehlsBnjj5Bxai
         12S5GD4nyfWEUiQKyb9YSoJ+B/BXgyjAzrR7ilbAaDEO+dgFBr1vz4WQlHo9grbDLOz5
         ZDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306981; x=1730911781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i7PHbBdzJxLOxFPTBsqL3GfBfhNNa9lpRlDXqEvpVGU=;
        b=eBE2Gk4x0UjBMdc4vVtV0RvS1vnllcgQ0QYRLXh6A7/PB1TN4bcJNcVCNT+PmT4IFd
         kdwvMwwgjp1OWN6Lbz5/FjeTDUo8iUd7MbejSxh9r+ElAZe1INPq9cduLkKPmn6OMtxP
         rrr0U6cAX4Bk6REAoNPR5DyvOjzYhdE/A4RJm0DxW1H2K2WYUIUl4qLMV57za5p4SDBH
         etFORuoF96MrtSO6qWyB9QrfbVqIVf6x2yqq5dFRz/tO6G83EewRj+1Ny27WA8IBq0cb
         P4LI5+KJ+zwyq4ra9HhtXzEbasbY252F5uQAi2dTQFvr0wCsgFk3vSVHX1eY4QN5kAJO
         L1ZQ==
X-Gm-Message-State: AOJu0Yx9lNxuW+3xJiQCMvbi1quS0d782ONe/1X7UeEtRqxfX1xpmnEm
	lphXvtvYiML9yZ05d1/ClNJzx7uaQc8p/vFsLwkpaTDKwtiO4y82X5n839QONGFGJN1ZWtBbh3f
	Z
X-Google-Smtp-Source: AGHT+IH4ZoSR8KGtL4YDbajUDks+FCVTVP7fSe8zki9CGDE/70d4XuhkMWhEQE04r6IF+WGrj9utKg==
X-Received: by 2002:a05:6a00:3986:b0:71e:7174:3ae with SMTP id d2e1a72fcca58-720ab3bdf21mr4989846b3a.11.1730306981058;
        Wed, 30 Oct 2024 09:49:41 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e49asm9466200b3a.32.2024.10.30.09.49.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:49:40 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 3/5] tests/fetch: Use our own mirror of sysprof to decouple from gnome gitlab
Date: Wed, 30 Oct 2024 09:49:27 -0700
Message-Id: <e8844ce340cd6a25b5ff1b9223868c2c1359b76d.1730306845.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730306845.git.steve@sakoman.com>
References: <cover.1730306845.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 16:49:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16753

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
index efe5479a6..8595d9295 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1333,7 +1333,7 @@ class FetchLatestVersionTest(FetcherTest):
         ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=master", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "")
             : "1.4.0",
         # combination version pattern
-        ("sysprof", "git://gitlab.gnome.org/GNOME/sysprof.git;protocol=https;branch=master", "cd44ee6644c3641507fb53b8a2a69137f2971219", "")
+        ("sysprof", "git://git.yoctoproject.org/sysprof.git;protocol=https;branch=master", "cd44ee6644c3641507fb53b8a2a69137f2971219", "")
             : "1.2.0",
         ("u-boot-mkimage", "git://source.denx.de/u-boot/u-boot.git;branch=master;protocol=https", "62c175fbb8a0f9a926c88294ea9f7e88eb898f6c", "")
             : "2014.01",
-- 
2.34.1


