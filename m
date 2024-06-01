Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B0C41513
	for <webhook@archiver.kernel.org>; Sat,  1 Jun 2024 12:27:36 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.36210.1717244853856897433
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Jun 2024 05:27:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=GdV5c3rt;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.176, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7024cd9dd3dso1092280b3a.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1717244853; x=1717849653; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBWIzfMaiAueC2Mb5ysKX3hbHYpeRnoedi3yHA423KA=;
        b=GdV5c3rt5tY5TxZDAj8VWwws5dL752ynKOadHPyaM1hg5CXE/43WyWCmrDa/kxQEKq
         Bp4Xa7mpeJuKHE2U800jUTrR+lllYiIWO3e9vlPScsCjX/zilf2BtSDampDGjfzE0gym
         /27BTm4e6voMJjvGMFqa0tjY8Pdkib+R2Io8p12mozYFEfoHHMYkP2VdNYmtJvUb6oT5
         njAyV8DhB0q1lkn5UOKRGU6rKD9t27N1mj5j7MzOfkFkvrGrpVLnJ3JF4h8DjL7f+Ko2
         /qtFiYy20gftd4Ld2OQ0sD0WKJHEgws2LVIToR9ByjGGzG1y4aFIAJ3obVT6y90WF7Xt
         2Jcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717244853; x=1717849653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBWIzfMaiAueC2Mb5ysKX3hbHYpeRnoedi3yHA423KA=;
        b=ccwGkzwMr8EdbajTVHvkKS/HSeU6MOmUPlZ02eb1DlSCwmBfLN07jGJelsrpHcBKPH
         9Qz1+97sW/ZItBtlxCMtmLx4vEi+1XzvbM9MlwCcciyJczkRdS0IE9ev1AKQ+Y2D8UJb
         6Y4QJGyfEtJjAPBaTkXIuL3aJRU8hC706HXPHUJu09vN547voHS76D9X0yTwEBLCJRVT
         64FdXGbHPMcdVsuADQKiIJC8BcJadVXTVIcjQBMSeMo38RPbraCWcXKusuP0fNrUa4O5
         LuzxQKYl9SDfee72d4ZMq8jal8w6pI7ZqIuYE63VnOSZLlcbpisWI17FO7Za472lSGtA
         GtnQ==
X-Gm-Message-State: AOJu0YxrtWedYpYIbL2OTMRrNYxx9IR2qorweY3bneRp+Bg9FeHHluOm
	ZvTkzY0riA2dETgo/wvanX+5UW1PCS/ZwLWKFgL8PWhWhYmUnTsXeYUfD0ReAXLz/RL/PxIE429
	i
X-Google-Smtp-Source: AGHT+IG8MtVWENjNVD0ekyMCjErTi5cNR8o8f5k4+qdZhOxhJdDPPTJrdJNbagnsxo+456sg/qrIqg==
X-Received: by 2002:a05:6a00:21c4:b0:6ec:faff:ec1f with SMTP id d2e1a72fcca58-702477fd1dcmr4933119b3a.11.1717244853082;
        Sat, 01 Jun 2024 05:27:33 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b30013sm2809362b3a.211.2024.06.01.05.27.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 05:27:32 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/8] runqueue: Allow rehash loop to exit in case of interrupts
Date: Sat,  1 Jun 2024 05:27:17 -0700
Message-Id: <80f5b5a7617e1883d05fc9c9d42b81026fab6c37.1717244760.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717244760.git.steve@sakoman.com>
References: <cover.1717244760.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 12:27:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16306

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The initial hash serve loop exits in the case where interrupts are present
but probably checks a bit too often. Tweak that and also allow the slow
rehash loop to break on interrupt, improving bitbake Ctrl+C response.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index beec1e046..85c3581f9 100644
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
@@ -2601,6 +2602,7 @@ class RunQueueExecute:
                 next |= self.rqdata.runtaskentries[tid].revdeps
                 total.remove(tid)
                 next.intersection_update(total)
+                bb.event.check_for_interrupts(self.cooker.data)
 
                 if time.time() > (lasttime + 30):
                     lasttime = time.time()
-- 
2.34.1


