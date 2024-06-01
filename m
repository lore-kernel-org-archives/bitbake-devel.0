Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA295C27C4F
	for <webhook@archiver.kernel.org>; Sat,  1 Jun 2024 12:27:36 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.36151.1717244855655188340
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Jun 2024 05:27:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=vh/K8I8D;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.177, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-701ae8698d8so2335629b3a.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1717244855; x=1717849655; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bx+Yn2wOks02Dj9JWTkNVpwMnTd8zjR0QVVk50YnPco=;
        b=vh/K8I8Del8xyCARs6inyBBoLpSwT99+wnAFBPFgoh+gZdzJ03ESJK6lkCycvtJXbN
         TonGncAguAXvf1UIovo82QQn6SgtUhF7wnlCjvqs46T/ZABZc+2+xMMYZJ2O7n7X+8fh
         a/a6hOjB+gxW2a79aXeqYfh+F4E9akrXQVs+7Irzbp5HK0Qp3HZmeeKj5PZlEWoeSL/J
         8W1MT7NwrC3G/cEZOwlx/U2RokDes890U7QEEDIWFLqSsjmZPmpuXrv02h6+cNNyg28n
         07qiDAwQCkKxGE1v3GfiBDGRN/0BasjABmNVclK/tAsVdiKfMKWK88mHSxWMqCH0vXlu
         LvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717244855; x=1717849655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx+Yn2wOks02Dj9JWTkNVpwMnTd8zjR0QVVk50YnPco=;
        b=EV1JWsT7YJRlypGnBALD8WOfzbX1unZ+ppgaf/637z2gzj2HA9KleH3TvufSC/0HNq
         cphktxdQcB/0Az1Y8Jxmtzzfl+31kYssvesOHYm3eM+QoWCFHgFUs5W3trZ4xUoxtetV
         xhweUgvzWSxorb9gi9QFeiuiXyzK4BL5jmZcrBF09S5+SWApnvkj88+7mg6JDd8R1k4e
         Oa0jX4KJb5qthBK1sJ32HaNPFO5as7qsHLA6zU2T6oeWA1IIyKP4NBWdZ/Pjc33DP7UQ
         7UzsEqr4Qn8OaWVhuUossL44ouSYa2vrd1oTecTNvnCChLgu29qyQ+Aqnbe8hAjamfie
         U7hw==
X-Gm-Message-State: AOJu0YxFnwyLYrcXZ5V1c0ZKC388e/wKJ8xbf/CHHZWOvuh22/gUv/YI
	/t3lsVc57wJy9CYkY4jMLfi6Y09Oc7XoiUynbSBxSSMS12NWpYPVxHzH4bRmBRO53Q7//QyzRFc
	S
X-Google-Smtp-Source: AGHT+IGHVRiO3xhQWveJl3F9Hj1rO6YaOmFuqETmo3pf9RCHi66uW7ttO+EW0tvHD4h0TMPC9OmreQ==
X-Received: by 2002:a05:6a00:10cc:b0:6f3:ea8a:f974 with SMTP id d2e1a72fcca58-702477be39amr4787770b3a.1.1717244854383;
        Sat, 01 Jun 2024 05:27:34 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b30013sm2809362b3a.211.2024.06.01.05.27.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 05:27:34 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 3/8] siggen/runqueue: Report which dependencies affect the taskhash
Date: Sat,  1 Jun 2024 05:27:18 -0700
Message-Id: <4d4998ac7719945a69544bbef343978db80da305.1717244760.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717244760.git.steve@sakoman.com>
References: <cover.1717244760.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 12:27:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16307

From: joshua Watt <JPEWhacker@gmail.com>

Report which task dependencies in BB_TASKDEPDATA are included in the
taskhash. This allows tasks to identify which tasks dependencies may
change without the task re-running. Knowing this information is
important for tasks that want to transfer information from dependencies
(such as SPDX)

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 8 +++++---
 lib/bb/siggen.py   | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 85c3581f9..84a6f4172 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1302,7 +1302,7 @@ class RunQueueData:
         return len(self.runtaskentries)
 
     def prepare_task_hash(self, tid):
-        bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
+        self.runtaskentries[tid].taskhash_deps = bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
         self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
         self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
 
@@ -2457,7 +2457,8 @@ class RunQueueExecute:
             unihash = self.rqdata.runtaskentries[task].unihash
             deps = self.filtermcdeps(task, mc, deps)
             hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn]
-            taskdepdata_cache[task] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn]
+            taskhash_deps = self.rqdata.runtaskentries[task].taskhash_deps
+            taskdepdata_cache[task] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn, taskhash_deps]
 
         self.taskdepdata_cache = taskdepdata_cache
 
@@ -2836,7 +2837,8 @@ class RunQueueExecute:
                 taskhash = self.rqdata.runtaskentries[revdep].hash
                 unihash = self.rqdata.runtaskentries[revdep].unihash
                 hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn]
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn]
+                taskhash_deps = self.rqdata.runtaskentries[revdep].taskhash_deps
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn, taskhash_deps]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 8ab08ec96..03dfda6f3 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -381,7 +381,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             self.taints[tid] = taint
             logger.warning("%s is tainted from a forced run" % tid)
 
-        return
+        return set(dep for _, dep in self.runtaskdeps[tid])
 
     def get_taskhash(self, tid, deps, dataCaches):
 
-- 
2.34.1


