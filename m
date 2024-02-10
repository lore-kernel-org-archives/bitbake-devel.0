Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3A0C4829A
	for <webhook@archiver.kernel.org>; Sat, 10 Feb 2024 15:25:22 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.15643.1707578717699831242
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 10 Feb 2024 07:25:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=R0xQgINd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4109fad99caso1778005e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 10 Feb 2024 07:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707578716; x=1708183516; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3nl5/ijwmed8dXGJujqa49qtPHkeKTz4Kr26su7x+k=;
        b=R0xQgINdyd4HCTCLhGmijVfMXaTMf2VWPayxlWCarZFvmK0kB0TCgcchrDpdgbKGxG
         0HYhJ58/glI0GcseMJh8lQwjguthBNt96u5+TxLXhPnoKnawAh0RbricPrVpwMybDDvg
         oomxINQtO43qT/7H3QY8bUF5iUZDav+/e2Skc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707578716; x=1708183516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3nl5/ijwmed8dXGJujqa49qtPHkeKTz4Kr26su7x+k=;
        b=sM4DYZmOP6XkWTCsskhsXV8xvVBZUO8kQV0qEBIB3ShTlcw/52K7S1LOhM8KYmVy4f
         6fP6enE9k0pPt6eUaSPQJM9VStyiqgNR3s+LroSYB0aNqKs/JzFYW/zN2Q/KpbVe1yTd
         DplPA1UF3bzNEenU1746b9gr7XcBxhywgnqDjYy0G1RoxCstzSkq2Xc/PRK6ifNj2xH0
         Th36i7wKA6YBIFiUiceQW64LixrL03z/dIKUXZXkjCYlSntbcfFZyfaZM8NYm0sYTyJF
         4UYqXOEtsAH904o9ZwboYvJZKWw7C1AoZcBCel876+j5tTN7up8RcGQkh8poJqRSPu8Y
         DpDg==
X-Gm-Message-State: AOJu0YxII2j8oB2LCCOieAm2IDp0b2dSRtJqdCRbk8fw+7WStPwCeQGZ
	znKGNR5FxZZo6z65fL57kTyJPz2jGiwgfY2MJDFVFcgVl07xzb0SyzXdy+j7MFDV6mucPjdaXYI
	O
X-Google-Smtp-Source: AGHT+IFZ5DclQ9Vye8yEn+wKRNRBt+Q8CE98APvXKfOCF29nQ/FfVLO3dgU+UhPotaAJ6AH2IiHJlw==
X-Received: by 2002:a05:600c:4f0e:b0:40f:dd91:2d06 with SMTP id l14-20020a05600c4f0e00b0040fdd912d06mr1797649wmq.32.1707578715910;
        Sat, 10 Feb 2024 07:25:15 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c350:b3c8:3bca:cef1])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00410709fa0d3sm3698170wmq.33.2024.02.10.07.25.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 07:25:15 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Improve performance for executing tasks
Date: Sat, 10 Feb 2024 15:25:14 +0000
Message-Id: <20240210152514.3536363-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 10 Feb 2024 15:25:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15873

Now that runqueue performance profiling works again we can see a lot
of time is lost in build_taskdepdata. Whilst we can't compute that
in advance, we can compute the individual entries.

Therefore put a cache in place to compute those and save overhead in
starting up tasks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index af11e9a8f4..c8392346a8 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1914,6 +1914,8 @@ class RunQueueExecute:
             event = bb.event.StaleSetSceneTasks(found[mc])
             bb.event.fire(event, self.cooker.databuilder.mcdata[mc])
 
+        self.build_taskdepdata_cache()
+
     def runqueue_process_waitpid(self, task, status, fakerootlog=None):
 
         # self.build_stamps[pid] may not exist when use shared work directory.
@@ -2413,6 +2415,22 @@ class RunQueueExecute:
             ret.add(dep)
         return ret
 
+    # Build the individual cache entries in advance once to save time
+    def build_taskdepdata_cache(self):
+        taskdepdata_cache = {}
+        for task in self.rqdata.runtaskentries:
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
+            pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
+            deps = self.rqdata.runtaskentries[task].depends
+            provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
+            taskhash = self.rqdata.runtaskentries[task].hash
+            unihash = self.rqdata.runtaskentries[task].unihash
+            deps = self.filtermcdeps(task, mc, deps)
+            hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn]
+            taskdepdata_cache[task] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn]
+
+        self.taskdepdata_cache = taskdepdata_cache
+
     # We filter out multiconfig dependencies from taskdepdata we pass to the tasks
     # as most code can't handle them
     def build_taskdepdata(self, task):
@@ -2424,16 +2442,9 @@ class RunQueueExecute:
         while next:
             additional = []
             for revdep in next:
-                (mc, fn, taskname, taskfn) = split_tid_mcfn(revdep)
-                pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
-                deps = self.rqdata.runtaskentries[revdep].depends
-                provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
-                taskhash = self.rqdata.runtaskentries[revdep].hash
-                unihash = self.rqdata.runtaskentries[revdep].unihash
-                deps = self.filtermcdeps(task, mc, deps)
-                hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn]
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn]
-                for revdep2 in deps:
+                self.taskdepdata_cache[revdep][6] = self.rqdata.runtaskentries[revdep].unihash
+                taskdepdata[revdep] = self.taskdepdata_cache[revdep]
+                for revdep2 in self.taskdepdata_cache[revdep][3]:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
             next = additional
-- 
2.40.1


