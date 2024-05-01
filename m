Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A35DC4345F
	for <webhook@archiver.kernel.org>; Wed,  1 May 2024 16:17:05 +0000 (UTC)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
 by mx.groups.io with SMTP id smtpd.web11.462.1714580221982646403
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 May 2024 09:17:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TUHkzkKy;
 spf=pass (domain: gmail.com, ip: 209.85.166.181, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36c546b7d04so11791165ab.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 May 2024 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714580220; x=1715185020; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6RMBHDkJ+Mw/NN6uKb7x0OsdiK3c72/ilLyf61CwdU=;
        b=TUHkzkKy3l+sTjRj8gHJY6MHYM4NiLr6JtwSPqPKzmknYrBZ7oZzJuJ5ySJwc/FTPO
         fiMAeLY0vFkbmIrZlfcTn4maL1rWG+VbrT6x7kKbhco4VLUZHIKQ5Hb2M5LhrqYFXcMF
         v28JsSHI4SDXXHzCcxsKQRQlm+OwcJHjHUv073b04vLd2W9EQRhjgEEwe5H1Uo0VqqAr
         NJ3ujz8YveodC5O8rp0pr88+CdKUXqO9Qr38f7mERN1sjIOdDWFJZuJ+9eYsO7faEsPj
         apGomoypu6em6hmgNalN3xxyKdvTzSNjBKbtgeSfrvLCa+XIBu9ENADo2+nZYHRG5yJZ
         3Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580220; x=1715185020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6RMBHDkJ+Mw/NN6uKb7x0OsdiK3c72/ilLyf61CwdU=;
        b=r23cvyBwM3IFzCj0ISiiiYq+q3kDHBaOT0U0JjY9FXQLN/k7kKvRQtnq0Ykd8IAjgJ
         LwxEH0183rninFhh7pgfPwYjfS2TG0rauv3MqBVXEKFZ2Ms7GOcxGihP72V1glOQI/O5
         n0+SMOyoYkyE/JKaCtbtZbAiH9OBz33KyBzT8Lpt9KNOOFbRS05QcawISV+iMwMykzsx
         jmwt8k1mCdeZnbGEu9C6m7kVQSO16IMO5mPPDIPosPF9+SLJ/nC/s8Adf7FfTKA6wRD/
         ExJEcXLrSfJDztsF/lUmS9upbJwwZuOXKyHNurcJWU2VvQ8i2KUwoi92E9/PRVdSNS0r
         1skA==
X-Gm-Message-State: AOJu0YwFUHkf+uPu+r/tdIZ49tWGduKaQXH6H/ieBFrI7Hr4AmAoQtEC
	nDea93r+KUF1PHMQ2zacvY6ebgraF5103g8hlVqsJpG5NnqqBPQcSLS7Ug==
X-Google-Smtp-Source: AGHT+IE9C9dFUA0EhhIgFaCc9c9jZfxLMnK7N4JiqEOuXIn6wrXJU7qDFsGU9q87NA+neM+/P12rNg==
X-Received: by 2002:a05:6e02:168f:b0:36b:80d:b930 with SMTP id f15-20020a056e02168f00b0036b080db930mr3837080ila.26.1714580220515;
        Wed, 01 May 2024 09:17:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::d802])
        by smtp.gmail.com with ESMTPSA id hc16-20020a0566386c9000b00486e8dcc992sm4869109jab.153.2024.05.01.09.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:16:59 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC] bitbake: Report which dependencies affect the taskhash
Date: Wed,  1 May 2024 10:16:57 -0600
Message-Id: <20240501161657.1945880-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 May 2024 16:17:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16176

Report which task dependencies in BB_TASKDEPDATA are included in the
taskhash. This allows tasks to identify which tasks dependencies may
change without the task re-running. Knowing this information is
important for tasks that want to transfer information from dependencies
(such as SPDX)

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 8 +++++---
 bitbake/lib/bb/siggen.py   | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index bc7e18175dd..6b43f303d5a 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1290,7 +1290,7 @@ class RunQueueData:
         return len(self.runtaskentries)
 
     def prepare_task_hash(self, tid):
-        bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
+        self.runtaskentries[tid].taskhash_deps = bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
         self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
         self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
 
@@ -2445,7 +2445,8 @@ class RunQueueExecute:
             unihash = self.rqdata.runtaskentries[task].unihash
             deps = self.filtermcdeps(task, mc, deps)
             hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn]
-            taskdepdata_cache[task] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn]
+            taskhash_deps = self.rqdata.runtaskentries[task].taskhash_deps
+            taskdepdata_cache[task] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn, taskhash_deps]
 
         self.taskdepdata_cache = taskdepdata_cache
 
@@ -2812,7 +2813,8 @@ class RunQueueExecute:
                 taskhash = self.rqdata.runtaskentries[revdep].hash
                 unihash = self.rqdata.runtaskentries[revdep].unihash
                 hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn]
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn]
+                taskhash_deps = self.rqdata.runtaskentries[revdep].taskhash_deps
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn, taskhash_deps]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 8ab08ec961b..03dfda6f3c4 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -381,7 +381,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             self.taints[tid] = taint
             logger.warning("%s is tainted from a forced run" % tid)
 
-        return
+        return set(dep for _, dep in self.runtaskdeps[tid])
 
     def get_taskhash(self, tid, deps, dataCaches):
 
-- 
2.34.1


