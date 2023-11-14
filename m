Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C03C4332F
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 23:34:55 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.872.1700004892827678584
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Nov 2023 15:34:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NIGp23j5;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-32dc918d454so3707961f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 15:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1700004891; x=1700609691; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TtRcrBCPvcFLp6ZPuuluGCE2FwWn71aatab+VAcIZas=;
        b=NIGp23j5KwNQlX9WUt77RJHrL+L6YALLEUFLOHjuSaS1Ojc4PCY/jz6olHaPeBBgQf
         VSshmONIo4QlHY8KJwEmdfqfb+EIjNT25TyW1Z7MiDKLns+RDqQdK2xPY1906pCKhcSi
         V3v+ZjKc/TcZkmo8/HEsUIoddz3Oy8OEQsBUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700004891; x=1700609691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtRcrBCPvcFLp6ZPuuluGCE2FwWn71aatab+VAcIZas=;
        b=w6wHCHUq1Ij/+fP1BfJgC1k9U46p9AaYIknlzKL5i+kE1xLUPtEcUeILOPfmJeEZUE
         huevDAd8DyjW3tpKqeOXIMEjNmH3rlHVfytCfMxoYUmkQ5N2JUzdhINt4S4L3gzUfkoD
         aSacOc4bizpTsq14i4UaJQjMAtD7y64zN5RlvPAfaVgZjZBCyqY51c7/SPnx5ofMA7ul
         uRHBlxoe4LiUM52YmaDIVdW9DvbEyQmbE3ahc116rgehUIv8xcLtJh+sX0EUUGRff+Ie
         Zg6hHyU7EaUNxVjQRI6hHPiPyTNCJewWD1N6BZ5T1SOJvn+KDm8MJtUlpcG2cnBvMf8z
         MquQ==
X-Gm-Message-State: AOJu0YzYqqK051nzxsTzG/1TWHXe9pBwah10RiUNzzU2bqkrGThf4D6F
	6Bvco6DDJk2HKvdwqWaQTpUOcWbOBgnOrgj796I=
X-Google-Smtp-Source: AGHT+IEwUm1b0KXnLV+DREruiLV7gd7c7A6vPTaFvjNbUI9L8ZjmuE9v28/Dw9YBbOLWubTA10N4XQ==
X-Received: by 2002:a5d:5888:0:b0:32f:7d50:62ef with SMTP id n8-20020a5d5888000000b0032f7d5062efmr8749505wrf.13.1700004890489;
        Tue, 14 Nov 2023 15:34:50 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bbf9:c35a:2291:eb7c])
        by smtp.gmail.com with ESMTPSA id f15-20020a5d50cf000000b0032f78feb826sm8930203wrt.104.2023.11.14.15.34.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 15:34:50 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] runqueue: Move 'cantskip' into sqdata
Date: Tue, 14 Nov 2023 23:34:47 +0000
Message-Id: <20231114233449.2567899-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 23:34:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15526

Conceptually, this belongs in sqdata so this is the next step in refactoring
this code, continuing what was started a while ago.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 475c3c5052..2a8b89b264 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1862,11 +1862,6 @@ class RunQueueExecute:
         self.tasks_notcovered = set()
         self.scenequeue_notneeded = set()
 
-        # We can't skip specified target tasks which aren't setscene tasks
-        self.cantskip = set(self.rqdata.target_tids)
-        self.cantskip.difference_update(self.rqdata.runq_setscene_tids)
-        self.cantskip.intersection_update(self.rqdata.runtaskentries)
-
         schedulers = self.get_schedulers()
         for scheduler in schedulers:
             if self.scheduler == scheduler.name:
@@ -2399,7 +2394,7 @@ class RunQueueExecute:
             return
 
         notcovered = set(self.scenequeue_notcovered)
-        notcovered |= self.cantskip
+        notcovered |= self.sqdata.cantskip
         for tid in self.scenequeue_notcovered:
             notcovered |= self.sqdata.sq_covered_tasks[tid]
         notcovered |= self.sqdata.unskippable.difference(self.rqdata.runq_setscene_tids)
@@ -2784,6 +2779,11 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     sq_revdeps_squash = {}
     sq_collated_deps = {}
 
+    # We can't skip specified target tasks which aren't setscene tasks
+    sqdata.cantskip = set(rqdata.target_tids)
+    sqdata.cantskip.difference_update(rqdata.runq_setscene_tids)
+    sqdata.cantskip.intersection_update(rqdata.runtaskentries)
+
     # We need to construct a dependency graph for the setscene functions. Intermediate
     # dependencies between the setscene tasks only complicate the code. This code
     # therefore aims to collapse the huge runqueue dependency tree into a smaller one
@@ -2852,7 +2852,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     for tid in rqdata.runtaskentries:
         if not rqdata.runtaskentries[tid].revdeps:
             sqdata.unskippable.add(tid)
-    sqdata.unskippable |= sqrq.cantskip
+    sqdata.unskippable |= sqdata.cantskip
     while new:
         new = False
         orig = sqdata.unskippable.copy()
-- 
2.39.2


