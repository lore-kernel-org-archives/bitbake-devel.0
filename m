Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E03C433FE
	for <webhook@archiver.kernel.org>; Thu, 24 Nov 2022 17:01:21 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.28889.1669309271570731743
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Nov 2022 09:01:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DiLh1YBW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so4377626wma.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 09:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8MIAO5VoxErAM4/qC1tCejSM+x6/xQvUMPNvCwYMjb4=;
        b=DiLh1YBWP6cPWSnfrZ9p1tl4E2uja7vmNVOX9IWdL4n/lw4eTD/WCtLDOgW8jMnt7e
         mivPLT2HuxQFGhj6kUt9Fj+gxnZ6ZtQ2cTbHHMDylkGxnLZWYUhBYqjbPQMAXTmlYLzy
         GJAp07E3aN1/aMWZfGB5B0vzi3Nl8Xhpjvh24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MIAO5VoxErAM4/qC1tCejSM+x6/xQvUMPNvCwYMjb4=;
        b=pyZIFSXzxpXgheWCNNrGictzsorwHVR5DbhxTqvCT2UC7JaNumJUGNya+OeN8jZUnj
         hFt+pmJHWkJXppk645BTCY9LdAsfNbcE0wl0MDzAuSUYq4jFPkbI/1Jfd0gP7ol31UWU
         cqsMq4FKVezbM7yCgcamUxxNfLmq2p3CqrGPpPhrta2gk2ykL8YTc9rIKErjlEdxFEIS
         M2lwo+TfxHcSBOAK0XCr6quYJOzzGcCfxMBFGvtOt5iMvVnIyniJhfwzFvFmJMF+GzQ2
         D9XoTRiOHuJdnuee8pZZqalxWu8MPnoVoHF1dErK1Ytjar+CLBGjQTc7AeFI7FqlatW3
         UCgw==
X-Gm-Message-State: ANoB5plH/aDQx9XWCccfK3Zn9pcuMwBUpYLmxtdo0DpW1FOXqC8tzM1H
	5hQrz7oIgKpVPJPcGILK44hLZWOVlRoPYw==
X-Google-Smtp-Source: AA0mqf4ozXRXk+MjwLVEwL1z1q/2q6Sipzr+ertZS4w3Jengv/incmNUymuZRlBzY9VEu1UjL7evQQ==
X-Received: by 2002:a05:600c:34c5:b0:3cf:b102:c0e8 with SMTP id d5-20020a05600c34c500b003cfb102c0e8mr15943394wmq.169.1669309269281;
        Thu, 24 Nov 2022 09:01:09 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4038:3d32:5f00:5957])
        by smtp.gmail.com with ESMTPSA id q6-20020a1c4306000000b003cf774c31a0sm5749702wma.16.2022.11.24.09.01.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 09:01:08 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] utils: Allow to_boolean to support int values
Date: Thu, 24 Nov 2022 17:01:08 +0000
Message-Id: <20221124170108.3976978-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 17:01:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14110

Some variables may be set as:

X = 1

as well the more usual

X = "1"

so add support to to_boolean to handle this case.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/utils.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 64a004d0d8..f4da356338 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -992,6 +992,9 @@ def to_boolean(string, default=None):
     if not string:
         return default
 
+    if isinstance(string, int):
+        return string != 0
+
     normalized = string.lower()
     if normalized in ("y", "yes", "1", "true"):
         return True
-- 
2.34.1


