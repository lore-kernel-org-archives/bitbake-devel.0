Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A57CFD342
	for <webhook@archiver.kernel.org>; Fri, 11 Oct 2024 10:59:59 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.8730.1728644397732542932
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Oct 2024 03:59:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OZqexdSn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so17338075e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Oct 2024 03:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728644396; x=1729249196; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U6pGlGevFRMma7C86Ysx7/nTKLAfNwKPhaBvdonqf8U=;
        b=OZqexdSnQlFNItwV2KY+66n68frEhpKVvgad6X8nQQIWbzshnJbO2OEx8PwxoDwB43
         sqpjvldS+IDUbQPANCpSOcpq+1q7EVnFZ6roE0yCRx7o6VdnDtpNzA4hJ/d5R+G38pcn
         l/HZHDHzrbe6h6KHWIKxvEVWWl8UmYW7BJpTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728644396; x=1729249196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6pGlGevFRMma7C86Ysx7/nTKLAfNwKPhaBvdonqf8U=;
        b=pYKYsF5Pwm9weyD8LpBKq6jETJKtOgx3lcpfnuxOkUAxGfG+zXw1xkryYzk81/5HlD
         nOoLCpBERaSMoDy5Vh3pUGu1NcuoRcpXBWnYjGPJnU3+Lc+GUcE8jmgGwhjHRfsutWXo
         Jup7WLdzWztAV9100QwApqgXSr3ePHxyqiBj9M3K9jTZsTWPcNZLKW1cwE5ofRGApnlQ
         oaFZTv0aMxsGyb1aQUqd2W2/yw4txbsza4y2NnPn72oywNPY2tP4CYutygCc4fVuYXp0
         3NoZqKBVZUo4vER2uUUt51QAAsKD9ubzHV4livEB5HDcQqVELdwEEmPU8X7/4sBhBuo/
         w7TQ==
X-Gm-Message-State: AOJu0YzPtQNlDvmKgyI3i8N9ez10kGOIn2fc4MF/BXW3aXldo1SmmKEw
	ceEQUr0RdUPoCZfQO/2jIVpSv/AFpXvA4LtdfG+om2Rsu4P73ILK+SvfcEWn+X9xWFE4boRIe09
	M
X-Google-Smtp-Source: AGHT+IG1zlpN2hAzsaNyfngSM6k+jVHnaO8PTWGyplNVwa5XPiMFncvamWtcpsonDrh2/W3XM2QHNw==
X-Received: by 2002:a05:600c:1e18:b0:430:54a4:5ad7 with SMTP id 5b1f17b1804b1-4311deaea26mr18167225e9.1.1728644395782;
        Fri, 11 Oct 2024 03:59:55 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8145:ba6d:a6de:28af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fd43sm3639695f8f.89.2024.10.11.03.59.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:59:55 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: Improve multiple lock handling
Date: Fri, 11 Oct 2024 11:59:54 +0100
Message-ID: <20241011105954.739139-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Oct 2024 10:59:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16668

We should release locks in the opposite order to the order we locked
them in to avoid potentially problematic behaviour. This hasn't been
observed with our current usage and is just a preventative improvement.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index ebee65d3dd..e722f9113d 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -446,6 +446,7 @@ def fileslocked(files, *args, **kwargs):
     try:
         yield
     finally:
+        locks.reverse()
         for lock in locks:
             bb.utils.unlockfile(lock)
 

