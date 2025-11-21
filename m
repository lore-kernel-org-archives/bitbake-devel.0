Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53A2CFA779
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 11:20:25 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9370.1763724019355226236
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Nov 2025 03:20:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QWViqwuQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477770019e4so18221935e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 03:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763724017; x=1764328817; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dA6tvzH4urKTR6ZgJGDOKO4ZP8bvf5mqxgvSQmE+5ZA=;
        b=QWViqwuQPqOzLc33/NfTeb5LUWsJaW6u05bIEMI9yBKV7tGQxwEH2KJiL1QrqG+42W
         ZHNrJw2o+2j81dOG2Vjt5SGbd/rHmPUAxqJYIfIl7dVy0nezLrnfUm7Gc4SsL1JiPnij
         xlYjN0AESe1igAZPlNsEtppOwpU238I4mOGmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724017; x=1764328817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dA6tvzH4urKTR6ZgJGDOKO4ZP8bvf5mqxgvSQmE+5ZA=;
        b=MP8zW8D+H0n2gTtBL8Adjfz0J4uICSvd0L8drT8YXY2Cy/y8m3ww36ECF+Vq/phpkE
         /tSZ4iQV63LsGhgufvXc2lHZPR+bcKihF/6El+kr2XdEEK8zzJu247xAcvNH4luBQian
         zZy+vfJJVAt08GYj8+uIGqKDjtFJ9P+pWaPv/z3Lmra8aheACGY01pefo7lp+kbCLa5g
         UBGnKaTmgz8wLX0toPI8J0H3pULS6Ci9xvTGygZkXk0eXz/I5eg/wtx+/w9j0SrBSQ2u
         gxHGEPf/wld1fPgE/t3cBd20fPlxbO3xFFoCtui8FK+r+JiswToDdZCZBnn2n09Ig9+d
         4MVg==
X-Gm-Message-State: AOJu0YyXMUg8l2n1/C7V+47m+KsaST0j4CBYy3PXUVn2lpzoS/IzjEgu
	4BHL9hWnhIPQyJF8hQWuwuR+7HkAMLiAklVgax8b4+mLYWTJyQokb/v3DFTStBvzLOkEmB0ekmC
	2dLlm
X-Gm-Gg: ASbGncs7BvRK2dguNclCkQJueqs3tR7KnejumiriEG0QCLJZa72hnHSTE3Kt9QYFsHP
	G9nQM8C9CVlA3de7hv+bflzXWC5CFsHB39hskkyMkPle5lI6aLENHz+J11DlfdFbfqgn1iPLX0b
	OPzyr/68rUL1JV3BjIRjr9q299wUIzoR3QgG+BwlGRg8Z1azoehe8YzvDrCFG/UzIhO+/EBoBo3
	9PWer515Pn0vQRV3MVH82oaYoXTYLfuONY3EXkemnZ96EEanLcdp/6VP88daSfkNPCXan5tF5vv
	6mKujBZLqxjRiuz0HqebUFw6wRA4g1ioYDpkkNzsuTOb9Fmfn7GQzfSK6vgdBdYrV1HkY2CTLQe
	0ewilTp2aBooSB4B1vnQEPLQaymIi2979FB0XQYI3Nacwt/MAsj5I4wzTZ8rckOs6QE9BZHYxN9
	4BtZjHBWQCqHJwWQLSYVRSsaRzn9gXcNTjkM5H2A==
X-Google-Smtp-Source: AGHT+IHhIwAVWIbJQlbtarrcMUOIiz8fdR1Y/N9Wd0YSgKc2l29UNXtriq31kzKYs9uZR1ZbhVG8dw==
X-Received: by 2002:a05:600c:4591:b0:477:8b77:155e with SMTP id 5b1f17b1804b1-477c018a016mr26732155e9.15.1763724016999;
        Fri, 21 Nov 2025 03:20:16 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a944:2a75:79dd:caf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3602d1sm39175465e9.5.2025.11.21.03.20.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:20:16 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] toaster: Fix test after styhead removal
Date: Fri, 21 Nov 2025 11:20:15 +0000
Message-ID: <20251121112015.236203-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Nov 2025 11:20:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18474

The styhead removal changed the indexing, update the tests to match. We really
need to remove these hardcoded values.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/toaster/tests/functional/test_create_new_project.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/tests/functional/test_create_new_project.py b/lib/toaster/tests/functional/test_create_new_project.py
index 66213c736ee..51c8c120370 100644
--- a/lib/toaster/tests/functional/test_create_new_project.py
+++ b/lib/toaster/tests/functional/test_create_new_project.py
@@ -53,7 +53,7 @@ class TestCreateNewProject(SeleniumFunctionalTestCase):
           - Release: Yocto Project 4.0 "Kirkstone" (option value: 6)
           - Merge Toaster settings: True
         """
-        release = '7'
+        release = '6'
         release_title = 'Yocto Project 4.0 "Kirkstone"'
         project_name = 'projectkirkstone'
         self.create_new_project(

