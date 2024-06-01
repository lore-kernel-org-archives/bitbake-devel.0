Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210BFC27C44
	for <webhook@archiver.kernel.org>; Sat,  1 Jun 2024 12:27:47 +0000 (UTC)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
 by mx.groups.io with SMTP id smtpd.web10.36212.1717244859485399346
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Jun 2024 05:27:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=wIASLQew;
 spf=softfail (domain: sakoman.com, ip: 209.85.166.176, mailfrom: steve@sakoman.com)
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-37492089404so2023265ab.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1717244858; x=1717849658; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmLPh5lZGEas9O753DK7UraYdzUmvqvthmtRqxqNArc=;
        b=wIASLQewvMCU+lp7UqphCLgyLe2Hbr+k+41BeECxdDB197zVId1yRJuPPvPOgcf0RS
         xSUzlneHu7PYNKwGX3PO2eftPsqj7R+kHfmoafy4RcwsLPylyqDKArdfAzeNcrWPPtyN
         Va6d77JqeuEbsAu1zhGYZAm4jOR5QWfGo7t1Wq2ymTmSAH1CGf9QRGN6QaHsyqq9sjy+
         Numi+H5RdKE772Vf08JP2iTFT3SmbGuqJySpyoZVAsfPhPcx26jv77Xn2csHkuC6R+Co
         ZXRWkkjjhX6KWOScf+zwPnHaMOf/0QoDYBHS+af57RrB8ZNczAyp+sCi88Up/barWOs9
         V5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717244858; x=1717849658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmLPh5lZGEas9O753DK7UraYdzUmvqvthmtRqxqNArc=;
        b=TLJbYndb5CqlYXmmAjiO2F4PKuVbjNxIBLBDCT90KdpSHWU6WhpxGglw0dq/gr/lkN
         VmtMY1g93P0PbWkFapwVjo6rE4MmsJ1VZPF1wgbNOw8LmFQxq6YojMfM69Uoj3mLe8Wp
         9dBuesoxk6E2UT+KuvD8ETU8A6Yu3lZe4RSsK5wLRMUton/aZbuGyhGapt9ZV6J7UKw0
         oZaRHJTvmLF/GoXbawsGT2pHIMm5pYbhN5qSqmTYZpyXGTHz284zk5shM2hSiT9cra9m
         E4JyN3209bZuASQDxfe94azZ5Q7K3IGBVwl+8IOuzS9GLW0t920yX/8SRMpANH/xaK7G
         QVpg==
X-Gm-Message-State: AOJu0YwoH+hHbMU/Ed9obhOQIGAcLClpqIE8IzFkZf/JwScpnitwoeig
	/c/GfUqbkJ87Hh7jiulBnZmTifmOuom7fqhOjT2MAhTZWPROZvj7npBb8Tx6PgrtmJ4p4HwQHnD
	A
X-Google-Smtp-Source: AGHT+IE7Ft13xcbbTXEzCroLX5SqrRwLxgJO4wFQHdOWIrHCuJ3+isRaX9vQT7PFMiJBiaIC2s+6Xg==
X-Received: by 2002:a05:6602:168d:b0:7d5:c00a:7d30 with SMTP id ca18e2360f4ac-7eaffe8cae7mr558673039f.8.1717244858263;
        Sat, 01 Jun 2024 05:27:38 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b30013sm2809362b3a.211.2024.06.01.05.27.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 05:27:38 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 6/8] bb: Use namedtuple for Task data
Date: Sat,  1 Jun 2024 05:27:21 -0700
Message-Id: <ef32b5dd476c93b4e41c93229d6321eb988180d0.1717244760.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717244760.git.steve@sakoman.com>
References: <cover.1717244760.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 12:27:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16310

From: Joshua Watt <JPEWhacker@gmail.com>

Task dependency data is becoming unwieldy with the number of indices it
contains. Convert it to use a named tuple instead, which allows members
to be indexed by a named property or an index (which allows it to retain
backward compatibility).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py | 12 ++++++++++++
 lib/bb/runqueue.py | 45 +++++++++++++++++++++++++++------------------
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index eef45fe4e..cdec9e4d6 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -36,6 +36,7 @@ class BBHandledException(Exception):
 
 import os
 import logging
+from collections import namedtuple
 
 
 class NullHandler(logging.Handler):
@@ -227,3 +228,14 @@ def deprecate_import(current, modulename, fromlist, renames = None):
 
         setattr(sys.modules[current], newname, newobj)
 
+TaskData = namedtuple("TaskData", [
+    "pn",
+    "taskname",
+    "fn",
+    "deps",
+    "provides",
+    "taskhash",
+    "unihash",
+    "hashfn",
+    "taskhash_deps",
+])
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 47f48304e..93079a977 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2452,15 +2452,17 @@ class RunQueueExecute:
         taskdepdata_cache = {}
         for task in self.rqdata.runtaskentries:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
-            pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
-            deps = self.rqdata.runtaskentries[task].depends
-            provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
-            taskhash = self.rqdata.runtaskentries[task].hash
-            unihash = self.rqdata.runtaskentries[task].unihash
-            deps = self.filtermcdeps(task, mc, deps)
-            hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn]
-            taskhash_deps = self.rqdata.runtaskentries[task].taskhash_deps
-            taskdepdata_cache[task] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn, taskhash_deps]
+            taskdepdata_cache[task] = bb.TaskData(
+                pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn],
+                taskname = taskname,
+                fn = fn,
+                deps = self.filtermcdeps(task, mc, self.rqdata.runtaskentries[task].depends),
+                provides = self.rqdata.dataCaches[mc].fn_provides[taskfn],
+                taskhash = self.rqdata.runtaskentries[task].hash,
+                unihash = self.rqdata.runtaskentries[task].unihash,
+                hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn],
+                taskhash_deps = self.rqdata.runtaskentries[task].taskhash_deps,
+            )
 
         self.taskdepdata_cache = taskdepdata_cache
 
@@ -2475,9 +2477,11 @@ class RunQueueExecute:
         while next:
             additional = []
             for revdep in next:
-                self.taskdepdata_cache[revdep][6] = self.rqdata.runtaskentries[revdep].unihash
+                self.taskdepdata_cache[revdep] = self.taskdepdata_cache[revdep]._replace(
+                    unihash=self.rqdata.runtaskentries[revdep].unihash
+                )
                 taskdepdata[revdep] = self.taskdepdata_cache[revdep]
-                for revdep2 in self.taskdepdata_cache[revdep][3]:
+                for revdep2 in self.taskdepdata_cache[revdep].deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
             next = additional
@@ -2841,14 +2845,19 @@ class RunQueueExecute:
             additional = []
             for revdep in next:
                 (mc, fn, taskname, taskfn) = split_tid_mcfn(revdep)
-                pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
                 deps = getsetscenedeps(revdep)
-                provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
-                taskhash = self.rqdata.runtaskentries[revdep].hash
-                unihash = self.rqdata.runtaskentries[revdep].unihash
-                hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn]
-                taskhash_deps = self.rqdata.runtaskentries[revdep].taskhash_deps
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash, hashfn, taskhash_deps]
+
+                taskdepdata[revdep] = bb.TaskData(
+                    pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn],
+                    taskname = taskname,
+                    fn = fn,
+                    deps = deps,
+                    provides = self.rqdata.dataCaches[mc].fn_provides[taskfn],
+                    taskhash = self.rqdata.runtaskentries[revdep].hash,
+                    unihash = self.rqdata.runtaskentries[revdep].unihash,
+                    hashfn = self.rqdata.dataCaches[mc].hashfn[taskfn],
+                    taskhash_deps = self.rqdata.runtaskentries[revdep].taskhash_deps,
+                )
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
-- 
2.34.1


