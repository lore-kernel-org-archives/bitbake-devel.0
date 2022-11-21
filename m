Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B358C433FE
	for <webhook@archiver.kernel.org>; Mon, 21 Nov 2022 13:58:57 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.38795.1669039130339265490
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Nov 2022 05:58:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DMTmdGR2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 84-20020a1c0257000000b003cfe48519a6so6568481wmc.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 21 Nov 2022 05:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fL0NUPoj2ZlWaQWApVA/A8KnYyvOAs8dF3GTfopZDpk=;
        b=DMTmdGR2p20p1zdp1KN9Fi1NA9IFLBmfUSpAmgvXDwONlEM5mrKLGv4R5NtahbVwci
         ZdvTXvnCnm1byGPBDy5Q3W68w6gZk305OOaUaPCUrfoOjEWuPu/6WQALxTP3/Lv/6IHV
         O7IGIgnXY3r49cClyvE0le30EcPvhMLBrgx9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fL0NUPoj2ZlWaQWApVA/A8KnYyvOAs8dF3GTfopZDpk=;
        b=Lp0geI1jxw4kYm8UP1UQT11mVpUu+pxxsexhvrMCkoBPowOGEpTvdkehV51RVzblsB
         UAQAt5rPb1DtTKd3eWoC5HkrWQKa7goza1vSzvoyHHlcwM9BI+mkDwwhfliMKu9WLNDF
         lepUiPyq/9ItrYltzq65vt1Y7pytFQIP2FT3tUPHYhM4yTlBoBRs9yn2cxpUaeyNrSXO
         v8153wSTjxqhPK9vTofi4X/QMjEXl1915e722sT2oyXe4ZWL6UGBENoCABVbENWi6PYo
         uZHoCLKQuys9Vkt6dLRLwVkSCQWoTroQ3N4mVALHLf/8d1ArYpkd7tsFyOUDTZn8yvuA
         Ho0A==
X-Gm-Message-State: ANoB5pkOK4kIHwlK1g/s/eU19R+3XDotejI2xuiAWjSYj8GDtOn7G3Xi
	WAR9YeKCYHFX2AARpTqQSldX74nAOpM7FQ==
X-Google-Smtp-Source: AA0mqf7tkc+D2fSa3VjEy0vZEAihePjiFYF1IPziPV2nLmMx/kCt5COTSql3nlSFtaZwz4SVqu1tLw==
X-Received: by 2002:a05:600c:a3a2:b0:3cf:7267:5b40 with SMTP id hn34-20020a05600ca3a200b003cf72675b40mr12934821wmb.164.1669039127944;
        Mon, 21 Nov 2022 05:58:47 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fff0:8f62:27ca:adb5])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bc04a000000b003c6bd12ac27sm13480083wmc.37.2022.11.21.05.58.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:58:47 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] runqueue: Add further debug for sstate reuse issues
Date: Mon, 21 Nov 2022 13:58:44 +0000
Message-Id: <20221121135845.3428466-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Nov 2022 13:58:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14095

Even after enabling all our debugging, we had a reproducible test case
where sstate wasn't being reused and it was unclear from the logs why.

This patch adds debugging on the possible codepaths that were breaking
and allowed the issue to be debugged and fixed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 595a58883e..bcaaf70abd 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2555,6 +2555,7 @@ class RunQueueExecute:
             if tid in self.sqdata.valid and not origvalid:
                 hashequiv_logger.verbose("Setscene task %s became valid" % tid)
             if harddepfail:
+                logger.debug2("%s has an unavailable hard dependency so skipping" % (tid))
                 self.sq_task_failoutright(tid)
 
         if changed:
@@ -2954,11 +2955,13 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
         if noexec:
             sqdata.noexec.add(tid)
             sqrq.sq_task_skip(tid)
+            logger.debug2("%s is noexec so skipping setscene" % (tid))
             continue
 
         if stamppresent:
             sqdata.stamppresent.add(tid)
             sqrq.sq_task_skip(tid)
+            logger.debug2("%s has a valid stamp, skipping" % (tid))
             continue
 
         tocheck.add(tid)
@@ -2979,6 +2982,7 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
         if tid in sqrq.sq_deferred:
             continue
         sqdata.outrightfail.add(tid)
+        logger.debug2("%s already handled (fallthrough), skipping" % (tid))
 
 class TaskFailure(Exception):
     """
-- 
2.34.1


