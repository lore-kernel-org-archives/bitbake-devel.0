Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6203FC4332F
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 16:02:25 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.66348.1702656137150930103
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 15 Dec 2023 08:02:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UBHMjzOR;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c2c5a8150so7800305e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 08:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702656135; x=1703260935; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2fqQweXG65Zt4nyz9kDWShtamSuvWHg66nxeszUOg=;
        b=UBHMjzORo2cj5UA6ZVg7x/CmlLzpOYVni/QGnsESen7g/Owx4KSk2fdZb48TeUh1TO
         w1EPtyASugmCUrPsfcfDonLj9X6uQoAiqzJXLmVJ/yyXBmwV/KQJ7obadr34nHhijgl6
         q2PkMxFWcibkrIEPDKyTYdoryLgoj6foYLkQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702656135; x=1703260935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2fqQweXG65Zt4nyz9kDWShtamSuvWHg66nxeszUOg=;
        b=jg5kIFjckQXWbAQNwRa4BlboOx5UP1T3b8rj0l2YA7XDDinIKqvOSwStywandXzPBz
         4T4RX0cMcGKTwrik7XNXKNRT+or9tbWilgCVQMBh/P8fzPu/yf4KH6q5xCqVP8K4j4fa
         A/efUS/1uLmmAtMiIFvjiHwKkSVbV26Vbci1ZXHXybQFuI7dCuH6292gC9vIG7ma0ReF
         +KFyNXY06Py5f6RRGTtrlVXmDWeh4mqWvcH3fJVKvUVe/b1pJ0K0/Rc7z4uZpjxz++sJ
         s7k49gy0ARiiOYtjaKBtvu3cEDFoDUQC8+j3qyE5GOXcHB0LJSwo22vk1iGBGjd2Cm2Y
         zDtg==
X-Gm-Message-State: AOJu0YzyEDcTZfiI9UKvUp1hRw2TDK8bCy2niuaaNUg1p/yh4XvAmx0p
	UWjrpT2KVi1P/1gfR1qaBdgAfbgZySiycQi040M=
X-Google-Smtp-Source: AGHT+IFBe94sdGMaVeisisYHS/LHlINjvuu0Fl75yleuJr3o++U8hHCmKH8XZqKRzmCeCoscfFDaaQ==
X-Received: by 2002:a7b:ce88:0:b0:40c:343b:fead with SMTP id q8-20020a7bce88000000b0040c343bfeadmr6235041wmj.79.1702656134447;
        Fri, 15 Dec 2023 08:02:14 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a04:9eb3:3437:42f8])
        by smtp.gmail.com with ESMTPSA id ay12-20020a05600c1e0c00b0040c6e48a5f0sm1012193wmb.3.2023.12.15.08.02.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 08:02:13 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Remove tie between rqexe and starts_worker
Date: Fri, 15 Dec 2023 16:02:13 +0000
Message-Id: <20231215160213.2918419-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Dec 2023 16:02:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15691

We've been moving to try and separate several pieces of runqueue. Allow
start_worker to operate separately to rqexe since they don't need to be
tied. This allows rqexe to be available to print_diff for future
improvements.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 864708ee4a..24497c5c17 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1390,12 +1390,12 @@ class RunQueue:
             continue
         worker.pipe.close()
 
-    def start_worker(self):
+    def start_worker(self, rqexec):
         if self.worker:
             self.teardown_workers()
         self.teardown = False
         for mc in self.rqdata.dataCaches:
-            self.worker[mc] = self._start_worker(mc)
+            self.worker[mc] = self._start_worker(mc, False, rqexec)
 
     def start_fakeworker(self, rqexec, mc):
         if not mc in self.fakeworker:
@@ -1555,6 +1555,9 @@ class RunQueue:
                                          ('bb.event.HeartbeatEvent',), data=self.cfgData)
                  self.dm_event_handler_registered = True
 
+            self.rqdata.init_progress_reporter.next_stage()
+            self.rqexe = RunQueueExecute(self)
+
             dump = self.cooker.configuration.dump_signatures
             if dump:
                 self.rqdata.init_progress_reporter.finish()
@@ -1566,10 +1569,8 @@ class RunQueue:
                 self.state = runQueueComplete
 
         if self.state is runQueueSceneInit:
-            self.rqdata.init_progress_reporter.next_stage()
-            self.start_worker()
-            self.rqdata.init_progress_reporter.next_stage()
-            self.rqexe = RunQueueExecute(self)
+            self.start_worker(self.rqexe)
+            self.rqdata.init_progress_reporter.finish()
 
             # If we don't have any setscene functions, skip execution
             if not self.rqdata.runq_setscene_tids:
@@ -1823,11 +1824,6 @@ class RunQueueExecute:
 
         self.stats = RunQueueStats(len(self.rqdata.runtaskentries), len(self.rqdata.runq_setscene_tids))
 
-        for mc in rq.worker:
-            rq.worker[mc].pipe.setrunqueueexec(self)
-        for mc in rq.fakeworker:
-            rq.fakeworker[mc].pipe.setrunqueueexec(self)
-
         if self.number_tasks <= 0:
              bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
 
@@ -2974,7 +2970,7 @@ def build_scenequeue_data(sqdata, rqdata, sqrq):
         if not sqdata.sq_revdeps[tid]:
             sqrq.sq_buildable.add(tid)
 
-    rqdata.init_progress_reporter.finish()
+    rqdata.init_progress_reporter.next_stage()
 
     sqdata.noexec = set()
     sqdata.stamppresent = set()
@@ -3193,9 +3189,6 @@ class runQueuePipe():
         self.rqexec = rqexec
         self.fakerootlogs = fakerootlogs
 
-    def setrunqueueexec(self, rqexec):
-        self.rqexec = rqexec
-
     def read(self):
         for workers, name in [(self.rq.worker, "Worker"), (self.rq.fakeworker, "Fakeroot")]:
             for worker in workers.values():
-- 
2.39.2


