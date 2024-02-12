Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E9C4829E
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 23:14:56 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.1580.1707779695397976254
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Feb 2024 15:14:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QCJr4/Pe;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso29861315e9.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Feb 2024 15:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707779693; x=1708384493; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l98LoTTJ/nypFM/foaFwXiGfQSY/F6aGvAem4gZQn+U=;
        b=QCJr4/Peex8rbFa8DTfjYRkZRghxazZSNkq//Wbu5VVu5xSNqTueomPcw6SstR0zQ7
         KLLqyAtdyomEAP91C+32W8ciDMmmU3jVlKm3I4UoC1zleGq/KZH9O47bHH7N2rBBeXYU
         LrQcgQW4X+jwUybzWMVIv1Ynztuq+G1ZL8qbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707779693; x=1708384493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l98LoTTJ/nypFM/foaFwXiGfQSY/F6aGvAem4gZQn+U=;
        b=JyD6v6xs9mT2w8hbnuow8gm7pHXkY8fNXQbDLmQbw91Pl3pnsO4ntOCTv+1DRs+6mo
         5zL8m3xckS8OczHXRTXn5w/hn/CTi2WZRpFSPGjDu+6hwXn38HvEC1ZsqEVxGKIr3urN
         CA0PZSWqdSITyHJgvICFBS19uj1OFYFw5wjnwH77nQw71TCssr/RYvAnDTmHhCM9hMiI
         OY5YbOsZC0WQzUYpHXvpc9GSww6qam35J6vuk+3yPaAjV0V4zpqdEI74oGLFeCjZEbCa
         xiuphu16q2Kg7U8g2j8VkTi8VXTRIVc7kZvRjIickfiw2SAl604RhckS3u3DOj4Qu/nz
         H3uw==
X-Gm-Message-State: AOJu0Yy1rNMoPn+iHaDymn3Icj4+3+cm3hIGwN1ZTsrKzmWntmSpEn2M
	LZH8hjtmJfoyuzB2dE65xMKP3zdjDuFJbKSyxVJqXqLJniyHbpf9X6471MH0YSl/4CCsgipwyZL
	o
X-Google-Smtp-Source: AGHT+IEaMM8urXsjDUitx61PnqXMy3gojmDXr3ofiZgm2ypECbpYgyUxaGmW3SB+5t0KY0vjeOaR5Q==
X-Received: by 2002:a05:600c:a004:b0:410:84b9:b9fc with SMTP id jg4-20020a05600ca00400b0041084b9b9fcmr6417103wmb.15.1707779693292;
        Mon, 12 Feb 2024 15:14:53 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:61a5:11c7:4181:c4a3])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b004107219c664sm10007953wmq.32.2024.02.12.15.14.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 15:14:52 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Improve setcene performance when encoutering many 'hard' dependencies
Date: Mon, 12 Feb 2024 23:14:51 +0000
Message-Id: <20240212231451.3882863-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Feb 2024 23:14:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15881

"bitbake world -n --setscene-only" shows poor performance as the numbers of tasks
increases. Analysys shows this is due to the "deferred" hard dependencies being
repeatedly processed which doesn't allow much forward progress in overall task
execution.

To avoid this, mark when it has been done and don't reprocess until dependencies
are updated. We have to be careful as we've seen bugs where these dependencies
aren't processed at the right time. They also have to be reproceseed during task
migration/rehashing so the code has to "self heal" the data structures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 95cab5132f..e86ccd8c61 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1840,6 +1840,7 @@ class RunQueueExecute:
         self.failed_tids = []
         self.sq_deferred = {}
         self.sq_needed_harddeps = set()
+        self.sq_harddep_deferred = set()
 
         self.stampcache = {}
 
@@ -2163,7 +2164,7 @@ class RunQueueExecute:
         if not self.sqdone and self.can_start_task():
             # Find the next setscene to run
             for nexttask in self.sorted_setscene_tids:
-                if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
+                if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values() and nexttask not in self.sq_harddep_deferred:
                     if nexttask not in self.sqdata.unskippable and self.sqdata.sq_revdeps[nexttask] and \
                             nexttask not in self.sq_needed_harddeps and \
                             self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and \
@@ -2184,6 +2185,7 @@ class RunQueueExecute:
                                 self.sq_buildable.add(dep)
                                 self.sq_needed_harddeps.add(dep)
                                 updated = True
+                        self.sq_harddep_deferred.add(nexttask)
                         if updated:
                             return True
                         continue
@@ -2678,6 +2680,7 @@ class RunQueueExecute:
         if changed:
             self.stats.updateCovered(len(self.scenequeue_covered), len(self.scenequeue_notcovered))
             self.sq_needed_harddeps = set()
+            self.sq_harddep_deferred = set()
             self.holdoff_need_update = True
 
     def scenequeue_updatecounters(self, task, fail=False):
@@ -2712,6 +2715,13 @@ class RunQueueExecute:
                         new.add(dep)
             next = new
 
+        # If this task was one which other setscene tasks have a hard dependency upon, we need
+        # to walk through the hard dependencies and allow execution of those which have completed dependencies.
+        if task in self.sqdata.sq_harddeps:
+            for dep in self.sq_harddep_deferred.copy():
+                if self.sqdata.sq_harddeps_rev[dep].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
+                    self.sq_harddep_deferred.remove(dep)
+
         self.stats.updateCovered(len(self.scenequeue_covered), len(self.scenequeue_notcovered))
         self.holdoff_need_update = True
 
-- 
2.40.1


