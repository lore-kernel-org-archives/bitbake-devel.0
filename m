Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD99C25B7E
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 20:44:34 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.1866.1716929065678095797
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 May 2024 13:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=R4xIE7Nt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.181, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e95a1eff78so17477201fa.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 13:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716929064; x=1717533864; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Fbv0YTCF0bBEPAQEd+q/Tjc2oKfIvsfQAHHK9orXwk=;
        b=R4xIE7NtIrRSptbmCDUG6aC4Mip4UGAJ7bbi0Lt2ftQ/5voSSSUsyMXBxCMpas1GlW
         CjfobiOmZBoC4joJBwBMZQf5bIrWeoYgOwIql1acEf5yJkr3OA2K92jFvqCo/lqbN7ho
         TxOXUSFCMKv29haKXhZj3bnmNGNIeT0wXS9g8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929064; x=1717533864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Fbv0YTCF0bBEPAQEd+q/Tjc2oKfIvsfQAHHK9orXwk=;
        b=ZE02+im3he7BFOMPMQ2ZAqf25j4yBAiOr8ixqyYZWayS6TcTr4owYEJhXhQkJtRjW9
         PCKXPZR4haKsuIorsiqMpmJR9K6wtAGNyarfpmrfpk9VnzzHcRCLsEQz9MSHm8Yw9h5B
         sXlwW/Bx5opZelsx5xmw9zKu2u4yu4Ah5DTaRSSmARgoZ6wDciXOJ04MolxgXCp1m+Xp
         +kbH0Ckrv3wwtBsK8QNeErvJaV4uVzkW7xswmz1ve9AdHrVPQ1LGrQHi5zetp2TJ8ssf
         cf9Z7N7iba0KpqpxSeGbx4peY7xD/Q5V3XzigD2hVlAN8nCjQOQ6VBgrG6kOWh4mfi1E
         wPDg==
X-Gm-Message-State: AOJu0YxeZd4MdVXiosXtskzwH6aGpGmtaWDeZctEpJzsTCWhM6sgu8x3
	NQR5jXSv+WqsI5j9b+cdED1VZ9bNl0C57abiOwuy3AMduBWP0u1p8GI9+DU5zRpV0SYpJ5CccHT
	+
X-Google-Smtp-Source: AGHT+IFWVuwLXG+emsKFUOQygLXku3E54tTupUZt6trjE3HeYdmbLRgeFtpysAaREl0CtzibdU2lcA==
X-Received: by 2002:a2e:9b97:0:b0:2e7:174b:8c1c with SMTP id 38308e7fff4ca-2e95b256336mr123908501fa.38.1716929063310;
        Tue, 28 May 2024 13:44:23 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b316:c62f:d434:bcd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579f9649esm12635228f8f.29.2024.05.28.13.44.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:44:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/4] runqueue: Allow rehash loop to exit in case of interrupts
Date: Tue, 28 May 2024 21:44:18 +0100
Message-Id: <20240528204420.2845521-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240528204420.2845521-1-richard.purdie@linuxfoundation.org>
References: <20240528204420.2845521-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 May 2024 20:44:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16273

The initial hash serve loop exits in the case where interrupts are present
but probably checks a bit too often. Tweak that and also allow the slow
rehash loop to break on interrupt, improving bitbake Ctrl+C response.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 83e5273449..84a6f4172c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1285,7 +1285,8 @@ class RunQueueData:
                     dealtwith.add(tid)
                     todeal.remove(tid)
                     self.prepare_task_hash(tid)
-                bb.event.check_for_interrupts(self.cooker.data)
+
+            bb.event.check_for_interrupts(self.cooker.data)
 
             if time.time() > (lasttime + 30):
                 lasttime = time.time()
@@ -2602,6 +2603,7 @@ class RunQueueExecute:
                 next |= self.rqdata.runtaskentries[tid].revdeps
                 total.remove(tid)
                 next.intersection_update(total)
+                bb.event.check_for_interrupts(self.cooker.data)
 
                 if time.time() > (lasttime + 30):
                     lasttime = time.time()

