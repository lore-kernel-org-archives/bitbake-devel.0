Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95169C3F2D4
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 14:17:41 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.13240.1654611459212812539
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jun 2022 07:17:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=A4w9ZDRV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id p10so24379768wrg.12
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jun 2022 07:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NUid9dP0T4FX5pvY1hUyiPifnB0fg6D4dpOqDoj+O2M=;
        b=A4w9ZDRVIzwnM4A39i0GL603NdDirRUY0nz2sJ+BoNb/As3tf8oMtQZQDd4DmdOSbW
         sb8Wo5UNfpGkPXHVAkkHt+2C4UKOFnEWnc44IVXtpWvzdm/YPIsAfp56XO4wqTnxrmmu
         Ho4wpLMkfyp2aD9cjiZwYdZT1q9C0OqOEWCwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NUid9dP0T4FX5pvY1hUyiPifnB0fg6D4dpOqDoj+O2M=;
        b=tod7++LQDxvwfNHyICN8IJMcgDAlbQH6DkiEdTy0CiozWvz78lsK1UrA/n1fGEONl1
         cq7Ydfps1uvkqYGkm/uSHxspL2Ioep5DI6QbR0qaJwpGV5oWxAq71/o/MbWkdu0164R3
         qpKNZb+CHZe2mBi1jPCNEGkRjE0BBKKr1CePWplIsoY1hixpno7PvOT/mOY1Ct6uQ2vJ
         MIM6NKN5MpEvYsr05ibV5/qgJJ4I+VNya4B4UEg/rYPb7yx2FUwW7xRTQyfus8z04odN
         cwp5RjxK9UdFULaqRs2H54/mKDVVO/6G1EONjMIZTvvqf411RNkqJFK+jQuZXDdHbgAW
         xaTQ==
X-Gm-Message-State: AOAM5328VepN4hlEXorX26+WWs0OVQHHoapmOQSq8wf/c8jzOYYpyOK/
	GlADWAKcMWCFlygXeZzoge0ib5iKKePsuQ==
X-Google-Smtp-Source: 
 ABdhPJw3eG59zNoBoc+Ahhx4uZF6/NPflAA0+qsBotcQUnqLtnWqs4v6rrla6hDKtCm93//0kDHegQ==
X-Received: by 2002:adf:e8cd:0:b0:210:2b10:ab22 with SMTP id
 k13-20020adfe8cd000000b002102b10ab22mr26863755wrn.476.1654611457420;
        Tue, 07 Jun 2022 07:17:37 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e835:fc94:6c5b:fc12])
        by smtp.gmail.com with ESMTPSA id
 bd9-20020a05600c1f0900b0039c47767e23sm10483182wmb.33.2022.06.07.07.17.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 07:17:36 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] server/process: Avoid risk of exception deadlocks
Date: Tue,  7 Jun 2022 15:17:34 +0100
Message-Id: <20220607141735.341158-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607141735.341158-1-richard.purdie@linuxfoundation.org>
References: <20220607141735.341158-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jun 2022 14:17:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13737

The open coded lock acquire/release in the UI event handler doesn't
cover the case an exception occurs and if one did, it could deadlock
the code. Switch to use 'with' statements which would handle this
possibility.

We have seen deadlocks in the UI at exit this so this removes a
possible cause.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 613956f30f..74b74dc39b 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -667,18 +667,14 @@ class BBUIEventQueue:
         self.t.start()
 
     def getEvent(self):
-        self.eventQueueLock.acquire()
-
-        if len(self.eventQueue) == 0:
-            self.eventQueueLock.release()
-            return None
-
-        item = self.eventQueue.pop(0)
+        with self.eventQueueLock:
+            if len(self.eventQueue) == 0:
+                return None
 
-        if len(self.eventQueue) == 0:
-            self.eventQueueNotify.clear()
+            item = self.eventQueue.pop(0)
+            if len(self.eventQueue) == 0:
+                self.eventQueueNotify.clear()
 
-        self.eventQueueLock.release()
         return item
 
     def waitEvent(self, delay):
@@ -686,10 +682,9 @@ class BBUIEventQueue:
         return self.getEvent()
 
     def queue_event(self, event):
-        self.eventQueueLock.acquire()
-        self.eventQueue.append(event)
-        self.eventQueueNotify.set()
-        self.eventQueueLock.release()
+        with self.eventQueueLock:
+            self.eventQueue.append(event)
+            self.eventQueueNotify.set()
 
     def send_event(self, event):
         self.queue_event(pickle.loads(event))
-- 
2.34.1


