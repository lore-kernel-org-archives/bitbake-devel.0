Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397BEC43334
	for <webhook@archiver.kernel.org>; Fri, 24 Jun 2022 21:56:20 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.13532.1656107777721932577
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jun 2022 14:56:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=evcMwmc9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id i10so4871167wrc.0
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jun 2022 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWJTuF5f9/FuzNgSmCVs0y4a5eBZqYtMWJwnHQXZSW4=;
        b=evcMwmc9f73hk8hNoCmnYdUZQyGyFxzNbCyupItuLIcxUQyYR9H/XwWC6iepSTZ1Cs
         xnMANSGthT7zlb6rgGByxTsUZkCSPSjHCRrJO5PbRrhi/E/bC8IeT3t+NJcq5k355jNA
         tmLFWwvHv0NoedGfxEOGRJvfv0cRtqtURzRys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWJTuF5f9/FuzNgSmCVs0y4a5eBZqYtMWJwnHQXZSW4=;
        b=foC2B+1GgW4z1q9hDBNYVdY3dKrB+mbgjNvwvF3T9MKBpCed8MmrYXQXisLlqMgwI7
         Q0c28HcNntZ1TN1mnfj71L4jwWYPnVlEKl/RPvRJYpED5Lzxd5Pm+KZ86Eo0rGTY3CXO
         I2YL4dp2BauYbFZDCPGWaVQzxEYFkeMwJF/HivtQcawipgkI6eskJffvyV/DIxpjBOVu
         +RSbSSqidyR2v+nMNNbIRqeAKMOCR2xmiBlGlddZbVTPFOIdGHxAUhKFDAJBcbK4c7yc
         x4DQmPM9a9CEL4eEnDrjvuLlZKd1McwiuIxBl7u4HgNzrt+IYUNCakOuZp7duHgAWMFU
         o/YQ==
X-Gm-Message-State: AJIora9dJ8VEhBUBBVxZ9XddqKO0LpTNQMvsyL8/xqlCSDWbQFsPrDht
	pe3yRC7GqnvAIMhKo+zS0mhah9LLRlkIWA==
X-Google-Smtp-Source: 
 AGRyM1vDP/v5SfqjV5vlD1vkLb94no+0NnQ+lx+TvFh81EicLrXgUdx5El1Ofc8wD/VLjWpAzyzaOw==
X-Received: by 2002:a5d:568b:0:b0:21b:995c:eb4e with SMTP id
 f11-20020a5d568b000000b0021b995ceb4emr1064524wrv.325.1656107775705;
        Fri, 24 Jun 2022 14:56:15 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:94fb:7e7b:31cf:be7f])
        by smtp.gmail.com with ESMTPSA id
 m2-20020a7bcb82000000b0039744bd664esm8166539wmi.13.2022.06.24.14.56.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 14:56:15 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] server/process: Fix logging issues where only the first
 message was displayed
Date: Fri, 24 Jun 2022 22:56:14 +0100
Message-Id: <20220624215614.276988-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jun 2022 21:56:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13789

I realised only the first logging message was being displayed in a given
parsing process. The reason turned out to be the UI handler failing
with a "pop from empty list". The default handler was then lost and
no further messages were processed.

Fix this by catching the exception correctly in the connection writer code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 43790b6631..5d02c0b9f5 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -756,8 +756,11 @@ class ConnectionWriter(object):
                 process.queue_signals = True
                 self._send(obj)
                 process.queue_signals = False
-                for sig in process.signal_received.pop():
-                    process.handle_sig(sig, None)
+                try:
+                    for sig in process.signal_received.pop():
+                        process.handle_sig(sig, None)
+                except IndexError:
+                    pass
         else:
             self._send(obj)
 
-- 
2.34.1


