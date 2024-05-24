Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A18AC25B7D
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 15:12:12 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.18338.1716563524818420007
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 08:12:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fwHRuSy+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so4989365e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 08:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716563523; x=1717168323; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3ZVElsGXsdf6vPD0TMfEomM31zlR7YLwEb8z9YXX3Q=;
        b=fwHRuSy+/d2RboEmWPgbLxLIWpBCzGBWCzyojoqqSTue2AZ9gr0oMV6/jA/bTESJN3
         +/a9xm4QwpS3XJOpvf2SW4f027+NeSLYUXh69mytPSuqPTyA48uk/xpBepaO4f9ruYyQ
         mFEp5JFwn/0mjSDuQbBV9taaXlaqprlTaiFSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563523; x=1717168323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3ZVElsGXsdf6vPD0TMfEomM31zlR7YLwEb8z9YXX3Q=;
        b=K9DDnNZ99t9f4wnTBL1EuJJR05PkqedE5lIv4QD4Q09GJM2bRnPrPFcCKT8u8WLAwz
         MfANim7YBnL4PabSarnCqUjlsKSflFvijioKZDbcdzSO4m7kPRrdkVmb6jYhP3JuAPN2
         Xgt8ceqVs0mKb+7DqrYjV4b/IS6PpVOJH4EHGVP2COYFgJoHMA/LPaEzeGaDDnR/T38D
         BFlcEngkKqI8wP42H+RI01x7BMBl4vm20aeNZ4HtDe70q+tuSJDYj2/malQ6hOEEdFM2
         Kiczu0bn/xvF99dFbPR2MHo7AnrnuTxd+Y4J94JV1vnt+quARhsdXL9GfR54kdsTiHBF
         5gfQ==
X-Gm-Message-State: AOJu0YwXdE0+V+VbtYRaiiwbgNaS1+o4Qgs5a2AR0YERfdW3K8A+JQqy
	sIwX/Uboq6PaqneqvwScoUA4pkteZcXB6qCVns+xj2RvPx6GO+6FLYIjT/mMRrnyE9sG8yzrFBU
	0
X-Google-Smtp-Source: AGHT+IG8po/zyI0OccQr5TZbH0+9Ialkh3wKUrMmeXBnvZxi4ig8iWcaPoFnP6UJxEYwokTSwRCB4g==
X-Received: by 2002:a5d:6084:0:b0:355:448:f18e with SMTP id ffacd0b85a97d-3552fde0574mr1838909f8f.43.1716563523163;
        Fri, 24 May 2024 08:12:03 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9ca4:3686:8521:57da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db23sm1841759f8f.23.2024.05.24.08.12.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:12:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/6] runqueue: Allow rehash loop to exit in case of interrupts
Date: Fri, 24 May 2024 16:11:57 +0100
Message-Id: <20240524151200.2449512-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524151200.2449512-1-richard.purdie@linuxfoundation.org>
References: <20240524151200.2449512-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 15:12:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16257

The initial hash serve loop exits in the case where interrupts are present
but probably checks a bit too often. Tweak that and also allow the slow
rehash loop to break on interrupt, improving bitbake Ctrl+C response.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b0375fcb36..586b11da2d 100644
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
-- 
2.40.1


