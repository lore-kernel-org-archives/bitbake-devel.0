Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C787ED6B6C8
	for <webhook@archiver.kernel.org>; Wed, 30 Oct 2024 19:12:30 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.23854.1730315546829945934
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Oct 2024 12:12:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=tUQrvkuy;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.53, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so112083a91.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 12:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730315546; x=1730920346; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ua1Y8MYlBYy7eUQW32ZaxvYjIa9Ulhp55RZb+m4VjLg=;
        b=tUQrvkuyWXsvtGXfCj+OAvbVOo45PCGUfNmpevm9kXnv4L1AXkABZIePHz4/0DjPzG
         WJZfVwqGVAS8IM1yUITJkamJ9aIfG4wU1ReW7SJ8uuXYrH75Q/0QJMxA6adJrTDC/PZN
         A0dRKAK7/Mm4CQlfuOS4vUlb4kvgjrMESsVLWBntSmXHrReoX3/8sH6jhcz3vv7oOUrx
         zg5fgLmM8cSwdeEzJThSrMacm88/29cQw8bzxgk+bVeyRHnSi0FAncopOnt+3xMpzCha
         jhFg1u30GkPCMEaqBOlWdUZ1oAnVpkzLENc34FUQaklevhQGuJFkFTKY+xV7nU401UvW
         oQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730315546; x=1730920346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ua1Y8MYlBYy7eUQW32ZaxvYjIa9Ulhp55RZb+m4VjLg=;
        b=TkJ4qqn4CcV6JV4VrAsbIV2S5EKH305KXqCoe/xUEjHMqmFDyBXAg96MJ6w6wDT0Z7
         vx2l9ein9l2MrB2MUhEvDpdP4L1L0WVI8rQj75zXGgVLCIYRC62IH0aCaNBI+5/vrQLq
         SqC1Bdb6kLtUgVOMRVvSSkfmVQB7UbLIraruhlXXTXO4lLfI/vdDvENP3BtFSCIeHnFO
         X4CmvXVI+bdkxhjUpZCOR5Pko0GVKf6eaFeZ0I8BHCky78WRz7YDHZz9lqXqsIHaM7lV
         1akJBnbnVh5sMRPDNSuoz09Rai8o60y/HVerlc8SYb8W9Jrvn8Ii4HACgA872MdbZ/5f
         gevQ==
X-Gm-Message-State: AOJu0Yx1iQC1q9dVnvDYchPOdDNVQhWIuRK0rQTHmjk3vgsr1fFp03fs
	B2zmXlL/U0V1OHYm/89T4X3h0EDVsH7n4Vhk6wgo17O/mDGmUFcqClM2qUhgUO96KoSKyySD0b4
	u
X-Google-Smtp-Source: AGHT+IFBEqXjK6yb/L8NJQNTnuwVJRkhDMrgjAu3mufPprGIHOwj18TFptLlGxHR+9IXD4hm7ZPKDw==
X-Received: by 2002:a17:90a:4e0a:b0:2e2:c6b9:fd4a with SMTP id 98e67ed59e1d1-2e8f1072087mr19616630a91.18.1730315546076;
        Wed, 30 Oct 2024 12:12:26 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa36672sm2248203a91.14.2024.10.30.12.12.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:12:25 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 3/4] tests/fetch: Use our own mirror of sysprof to decouple from gnome gitlab
Date: Wed, 30 Oct 2024 12:12:07 -0700
Message-Id: <7f98c7db475b7f805c8c5be5964e84c82caf1903.1730315315.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730315315.git.steve@sakoman.com>
References: <cover.1730315315.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Oct 2024 19:12:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16759

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
index 33cc9bcac..70494693a 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1419,7 +1419,7 @@ class FetchLatestVersionTest(FetcherTest):
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


