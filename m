Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8F0C47077
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 14:23:11 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.12435.1704982982010493461
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jan 2024 06:23:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=IDYnpPpD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d5336986cso69009595e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jan 2024 06:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704982980; x=1705587780; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqDEO+5vW9IM9W5opuiQsn2T77VPdM3hiCEP2z0Itog=;
        b=IDYnpPpDGi3B0oZ+O/XTskyNVlCNghxZQ2eSlPB0+ejHiSYWLWUBro0z+/uUC7kfyc
         mH3EUwLmEnoLZVOyuxuFXHuu1Sn68arhv5UQtYddwzfPXvdTgluuKLPiIm2cng2YrTJe
         p2bbBaJ5L9RQJdizLFZCGZ2f21beIKUjbURrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704982980; x=1705587780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqDEO+5vW9IM9W5opuiQsn2T77VPdM3hiCEP2z0Itog=;
        b=Ux4GImtAXF9ySXr+Hp51JfPZhiQRj8ikS7SuSpkmbPSnGHkqZDAWXM5Frpjrmmf5nx
         56M44rirw9KPnLS4tDedjnltb7GGS91ruWyPt68MjYIxoFi71zan2dv/8V+QWUpQL5yg
         XT2izmt4MCKEZMfvpBJusmiXVlULTjHT9HDvThXiU5z285QJvMdnVY65IsEdqH7GZ5ic
         Md4ezq0IcZVmZi+qUz64cRhTzz31W9ysZ9k7mYTqdJIOwvekovb5A4ZMdT9+0J0WT+6U
         iygo07x4Ehi5JRLDJKa5Lgt8ZdXb6fRU1PDnv9LJmu3DnYAWfndh9/C9UU2NF3Ko195M
         4ruw==
X-Gm-Message-State: AOJu0Yx0QPWcmRWIL7gYnogZKTzfSNDXBh0QXwccfYPZ0c0PcxfPSGdk
	bO8XxYb73slDd04fr4GEcq8/ODbDu+X5oJofLgU5KgYp5no=
X-Google-Smtp-Source: AGHT+IE4MPelVVXWRiSHvSTyHwAe+fYHEt2m6TYiJ+kUxDtY2VSEUAL/eTmiKIKL3WTOECSgyDky6A==
X-Received: by 2002:a05:600c:4445:b0:40d:802a:7621 with SMTP id v5-20020a05600c444500b0040d802a7621mr431856wmn.121.1704982980110;
        Thu, 11 Jan 2024 06:23:00 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:4356:b19b:2f4b:a082])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040e3bdff98asm5926489wmn.23.2024.01.11.06.22.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 06:22:59 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Fix runall all bug
Date: Thu, 11 Jan 2024 14:22:58 +0000
Message-Id: <20240111142258.3286717-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jan 2024 14:23:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15782

Where chains of RDEPENDS are multiple levels deep, the runall code was not
accounting for this and recursing deeply enough to gather all dependencies.

Fix this by iterating over the result until no more dependencies are found.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9e3a87c0e8..25bd02b0d0 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1004,26 +1004,31 @@ class RunQueueData:
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
+            added = True
+            while added:
+                added = set(runq_build)
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
+                added = added - set(runq_build)
 
         delcount = set()
         for tid in list(self.runtaskentries.keys()):
-- 
2.39.2


