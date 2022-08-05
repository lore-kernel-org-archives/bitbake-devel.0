Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D22C00140
	for <webhook@archiver.kernel.org>; Fri,  5 Aug 2022 10:32:39 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.5519.1659695556928293962
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Aug 2022 03:32:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eNfhIbnQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id l4so2718856wrm.13
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Aug 2022 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=GYFe283MHiR69w8+jOB1hXP7ILkG9qoTUTErGESO098=;
        b=eNfhIbnQeQzr9XGWxC56sJzG+uC8agiQXZsTcWGB+q8FlPpwH+7tH9uZks5Iqewobl
         igsJiRWTVy86ssyq8RaVOSYLA65tZCKJZ1BgG4wrofVVyuvBJqetjoVo6PxoeU8VFf8T
         wF7DRxkzGE4v8E7AUAG3qB0/UjyCw6+R8BQRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=GYFe283MHiR69w8+jOB1hXP7ILkG9qoTUTErGESO098=;
        b=yJMajLjpSr+95G0pi6oHfR/TdvuYqgMoJWpB2TInQELIMED5qyvQP30+QJG46om6pE
         6sezi4OYj9T1uyeACv0uPszbebWydrmHMGXeoJouww8x2aAWzefmsPNQ+MuUzimBw4I6
         JvSVzC9nypnrxRBQPl5J+fFljiof/U07N9b2EFlknUI1KKuXaOafFPJZc5ElcqSIoWhs
         OBSfX6Jt5cY7aich3BNC5ryeXfYRf2TGXnaZX5LCOVAbDkyxAxgqBsoJx2kaj0DalXLJ
         hd3wsea1iMOI6rdGOOyw8T3UPQabxQbkZsvR35/3QZnnoj2kHhSl2wcak8fZf4G2+deQ
         3Lcw==
X-Gm-Message-State: ACgBeo1PzRuy/LUvidMiqzkGolM671EDiisID5MVd8ZcbYUg5N6yQXZ/
	LEyWTNgTHbJJC3e0HCUX+Z8hqvYhJRPWGw==
X-Google-Smtp-Source: 
 AA6agR6hLYDJxheu3hU8Lg5fWNxi9o9sKx89QFONlllKuhygqqChgxHPigPRTTVJZH8AkvxLX+OZnw==
X-Received: by 2002:adf:fa4a:0:b0:221:61d0:c79c with SMTP id
 y10-20020adffa4a000000b0022161d0c79cmr2386234wrr.444.1659695554718;
        Fri, 05 Aug 2022 03:32:34 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:f483:fcb0:1452:5a5a])
        by smtp.gmail.com with ESMTPSA id
 e12-20020a5d65cc000000b002207a8773b7sm4501401wrw.27.2022.08.05.03.32.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 03:32:34 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] runqueue: Ensure deferred tasks are sorted by multiconfig
Date: Fri,  5 Aug 2022 11:32:30 +0100
Message-Id: <20220805103232.3674163-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Aug 2022 10:32:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13873

We have to prefer one multiconfig over another when deferring tasks, else
we'll have cross-linked build trees and nothing will be able to build.

In the original population code, we sort like this but we don't after
rehashing. Ensure we have the same sorting after rehashing toa void
deadlocks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 359b503297..4d4ac3b991 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2506,11 +2506,14 @@ class RunQueueExecute:
 
         if update_tasks:
             self.sqdone = False
-            for tid in [t[0] for t in update_tasks]:
-                h = pending_hash_index(tid, self.rqdata)
-                if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
-                    self.sq_deferred[tid] = self.sqdata.hashes[h]
-                    bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
+            for mc in sorted(sqdata.multiconfigs):
+                for tid in sorted([t[0] for t in update_tasks]):
+                    if mc_from_tid(tid) != mc:
+                        continue
+                    h = pending_hash_index(tid, self.rqdata)
+                    if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
+                        self.sq_deferred[tid] = self.sqdata.hashes[h]
+                        bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
             update_scenequeue_data([t[0] for t in update_tasks], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
 
         for (tid, harddepfail, origvalid) in update_tasks:
-- 
2.34.1


