Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD8CD13570
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 09:29:00 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.47617.1730107737423989656
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Oct 2024 02:28:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cOdUzEGk;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d50fad249so3087891f8f.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Oct 2024 02:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730107736; x=1730712536; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJRCgi4U2hmKAypMGwHxpULaswq7or2/RTMPmKfwmiM=;
        b=cOdUzEGkEnVoETEbXwVWxrWyHYREvgJUuVFlispwapQ8XwSmjXfXYZYn1SLy6KwkGI
         OfZJ4hfOm0ywKyHy2N381ODAPGex7/+q7IqMZmHqjBRXuGU3IZzrcMnLLV7q68QymfBL
         7DtnS7fjFJMg2B5XvFpRb82v2C+JuX92fwKzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730107736; x=1730712536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rJRCgi4U2hmKAypMGwHxpULaswq7or2/RTMPmKfwmiM=;
        b=DX8JziGJO8yAcFohgYW3rcdpH0X0trGdNi3PJghNkbDG3E25m3nv+uW7VHu1Nj/GEC
         cnpWdjny88Bal00rRI78lkI/eUfGN2T8QZpO7T5YIlnDQUYsCg9URMr+vGiQy24dOVqQ
         814g1hj4IwhZrQDQwop2hUdYN4jBeNhQHHIZqMs7ni1wkZKzjvGqwDIrzuOgYFu8WWh6
         TdTBBgUN9x67Z33wmfLOWQt1EjKfsmTMBFhQHHRfV9RlQNBRo0fP0tC97xUrGJouK3UJ
         7wDKFIBVfkjPFAIX0uu4R97m664xTXTmowomyt6XDNF7Wb3+ZWEYOSn22u3V2f7fM/0H
         PU4Q==
X-Gm-Message-State: AOJu0YzdyZRnZD0yNe4Sp7TlVitOlxJUMdlDcRwWFulk6W8Woh9TdR8b
	RY6+S5yz2/PFPllKZH4pJEXeQYLOw9MNtUaZ/6+dqNrkh7CuNFqFs/iF/WUhnSDiVgBmltYF0eq
	8VlY=
X-Google-Smtp-Source: AGHT+IG7QjjsNIATW/732/L/oAqbybRvgiu+AAxS7LvAWYhR0z5v6YyD1Egeo/ZBbUbaU9hZyukLPA==
X-Received: by 2002:a5d:51c1:0:b0:37d:4ab2:9cdc with SMTP id ffacd0b85a97d-38061127ff2mr5299396f8f.13.1730107735340;
        Mon, 28 Oct 2024 02:28:55 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:73ef:5707:ed3d:2605])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b6f838sm8971214f8f.83.2024.10.28.02.28.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 02:28:54 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Use our own mirror of sysprof to decouple from gnome gitlab
Date: Mon, 28 Oct 2024 09:28:54 +0000
Message-ID: <20241028092854.81784-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Oct 2024 09:29:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16735

GNOME gitlab has occasional downtime which impacts bitbake-selftest
and causes autobuilder failures. Switch to our own mirror for test
purposes to avoid those issues.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index efe5479a66..8595d92956 100644
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

