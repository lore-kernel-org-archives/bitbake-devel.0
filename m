Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C936C47077
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 17:28:13 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.17500.1704994089857192349
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jan 2024 09:28:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WGrQ0+v8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3374eb61cbcso4979792f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jan 2024 09:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704994088; x=1705598888; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilNG3fBJBZOqKgulzP1UOy9cpiU1bK10FFmRvnrEu+U=;
        b=WGrQ0+v8ehLJ+whovVC6lmBUQYNRd24xyGqMHa6GJvNEvkrx4T2dnbp1FlgmM8ltp1
         9Bnp4BrBJU8CBln+4cju72PuYqkHfH9av9C+5Tea/HpTaiuXSyDOMUIDBYhTe0zjN4kw
         JF9d8l8HOVkZJB9Voa30NSEt7KqAL01egbGGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704994088; x=1705598888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilNG3fBJBZOqKgulzP1UOy9cpiU1bK10FFmRvnrEu+U=;
        b=aoYoUiTDmY9rJZDUWY7EWedkfCCDriGElcR1tk6JcI8esyfPWi/9gANGYmFJfDHkM7
         vUK5oSL3d5dsQmyofizVxAAE6vo8V0MOUV6k8eq+cQoodiKOL8Ai9F6Hy/p5nSj5pvm3
         gYy1Osf7zAVPLQ4xQwoAFJ5PFCzmQv/BkTkxvRMrUjb5fK5h1Vg9WTddCB4pWReNNfIQ
         QDkY9sHobGkAmQZD2wxNt2MxOpO6/Ktp9xmpwmgVfv8l26LUcMAiQ6k51y2Ccw+rG+C4
         rpNm0jNCeHLem9A+cgp3ryS6b3yTWV2UFlvOKbR9RvfWlhcX29RODrXySqtyuaCC5vQ+
         oceg==
X-Gm-Message-State: AOJu0Yx8mxzOiZpLq/T6nnVFVsXfPkerZ7D3Dpao4xLiogoB9lzh4Ddm
	3Jx5XppVoP92x165We60dmO9er65kzKGAJdiKdazyUfM3Qg=
X-Google-Smtp-Source: AGHT+IFcf8CJf3bj/7+/1dL5z9AYsokrfbtdqexBBeMFbaJq1bdZYjHfe2IUBeF7L+Zht/902efVdg==
X-Received: by 2002:a05:6000:dc3:b0:336:74e0:b99b with SMTP id dw3-20020a0560000dc300b0033674e0b99bmr38772wrb.132.1704994087907;
        Thu, 11 Jan 2024 09:28:07 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4356:b19b:2f4b:a082])
        by smtp.gmail.com with ESMTPSA id f18-20020adffcd2000000b0033642a9a1eesm1691249wrs.21.2024.01.11.09.28.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 09:28:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] runqueue: Fix runall all bug
Date: Thu, 11 Jan 2024 17:28:06 +0000
Message-Id: <20240111172806.3311690-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jan 2024 17:28:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15783

Where chains of RDEPENDS are multiple levels deep, the runall code was not
accounting for this and recursing deeply enough to gather all dependencies.

Fix this by iterating over the result until no more dependencies are found.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9e3a87c0e8..af11e9a8f4 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1004,26 +1004,32 @@ class RunQueueData:
         # Handle --runall
         if self.cooker.configuration.runall:
             # re-run the mark_active and then drop unused tasks from new list
-            reduced_tasklist = set(self.runtaskentries.keys())
-            for tid in list(self.runtaskentries.keys()):
-                if tid not in runq_build:
-                   reduced_tasklist.remove(tid)
-            runq_build = {}
 
-            for task in self.cooker.configuration.runall:
-                if not task.startswith("do_"):
-                    task = "do_{0}".format(task)
-                runall_tids = set()
-                for tid in reduced_tasklist:
-                    wanttid = "{0}:{1}".format(fn_from_tid(tid), task)
-                    if wanttid in self.runtaskentries:
-                        runall_tids.add(wanttid)
+            runall_tids = set()
+            added = True
+            while added:
+                reduced_tasklist = set(self.runtaskentries.keys())
+                for tid in list(self.runtaskentries.keys()):
+                    if tid not in runq_build:
+                       reduced_tasklist.remove(tid)
+                runq_build = {}
 
-                for tid in list(runall_tids):
-                    mark_active(tid, 1)
-                    self.target_tids.append(tid)
-                    if self.cooker.configuration.force:
-                        invalidate_task(tid, False)
+                orig = runall_tids
+                runall_tids = set()
+                for task in self.cooker.configuration.runall:
+                    if not task.startswith("do_"):
+                        task = "do_{0}".format(task)
+                    for tid in reduced_tasklist:
+                        wanttid = "{0}:{1}".format(fn_from_tid(tid), task)
+                        if wanttid in self.runtaskentries:
+                            runall_tids.add(wanttid)
+
+                    for tid in list(runall_tids):
+                        mark_active(tid, 1)
+                        self.target_tids.append(tid)
+                        if self.cooker.configuration.force:
+                            invalidate_task(tid, False)
+                added = runall_tids - orig
 
         delcount = set()
         for tid in list(self.runtaskentries.keys()):
-- 
2.39.2


