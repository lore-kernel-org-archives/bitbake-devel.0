Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FA8C25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 18:18:10 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
 by mx.groups.io with SMTP id smtpd.web11.1061.1716488282392393165
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 May 2024 11:18:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TyLfiSx4;
 spf=pass (domain: gmail.com, ip: 209.85.161.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b2e942171cso3599186eaf.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 May 2024 11:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716488281; x=1717093081; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H+jREt3tuVwczxmo0KuA7vdrldH4LxS/YcJL4ovqrfA=;
        b=TyLfiSx4heKq2Evn1VxCaCkMvBitUxjFCNzw81ZTlb+80i/tWmR782iUUOVPWNebBP
         b7XQ2jdDjd+RIwoubi9KJv72LmFKwYBOtOEhR3T3qhP+jsQufygKxXOC7oKzbM1UqBgL
         8ETOYOYIeU40QwOVyC4x3NuBuBf9dOW7YJ12tynIpzNOG1vHVjnEDnT3R4s1NFMNUdMD
         y9FIvpOOh0WT9cHtPlZc5KMONNeyuUacjstRBkQhJaZ675Jfer0B8WLjQ94b+diSEq2k
         qhGWm4IT8ZLAKhW587E4WacbMlEoRFf9LNMeDRbaPacPUMntyoysAG6O5ZC3dDiU4SAu
         aYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716488281; x=1717093081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+jREt3tuVwczxmo0KuA7vdrldH4LxS/YcJL4ovqrfA=;
        b=fNUKZEfiaayfGBIPE9ArhyS3yuEh762N+Npw4J1ExCn1G0jtgn2MBOeB30Hx1td6MM
         tODPqX+GWGVi7YBv8MQ2HQOCyX8venLNcB7LhEgyFfg1rJy8WgJ+mKTZJH9Av56Xwkxc
         ugc+bOwTZhZZ0Be57/DSDHsS7bn8I4v2rHtfLhzkeZff0dmjmRSUFbDc3Xm2xHBWFe72
         60U9C2RC2vjGG9Yt3t6nZlsWife97+fIsZzUIqsNjdzHEz1P+MMSPLtT5ts4q8+T6VLd
         5sIY63+13yi1gFUqTPMFUMgDUjNZGqXx3m7qKBqej88qe/NBpx3wN6hnPrVdUBadNzsq
         Sgxw==
X-Gm-Message-State: AOJu0YzfXjKEiJ+/20PyuugGUVyiyLzGsCNzPtY79A2AvfUzKhVNSguN
	F4Pv0jJcrC3O2/v0H/rUYDmU9O6N7bkTCYxebMXTdGQu2FKFTr3NEmOibw==
X-Google-Smtp-Source: AGHT+IHtVmhOGZxuGZl/f6CrzhDYGj66CV4MrDFuotv0Jm8mqUfkdoDhc08Rz7sROOfQp5YVKU0AIQ==
X-Received: by 2002:a05:6820:160a:b0:5b2:3782:7843 with SMTP id 006d021491bc7-5b96166a316mr280584eaf.4.1716488281084;
        Thu, 23 May 2024 11:18:01 -0700 (PDT)
Received: from localhost.localdomain ([204.77.163.55])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b27521351dsm6589824eaf.10.2024.05.23.11.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 11:18:00 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bb: Use namedtuple for Task data
Date: Thu, 23 May 2024 12:17:58 -0600
Message-ID: <20240523181758.2252667-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 May 2024 18:18:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16248

Task dependency data is becoming unwieldy with the number of indices it
contains. Convert it to use a named tuple instead, which allows members
to be indexed by a named property or an index (which allows it to retain
backward compatibility).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/__init__.py | 12 ++++++++++
 bitbake/lib/bb/runqueue.py | 45 +++++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/bitbake/lib/bb/__init__.py b/bitbake/lib/bb/__init__.py
index 8b6ea2d8ed0..b04d4c8a831 100644
--- a/bitbake/lib/bb/__init__.py
+++ b/bitbake/lib/bb/__init__.py
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
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 6b43f303d5a..5d0bf5ab4d3 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2438,15 +2438,17 @@ class RunQueueExecute:
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
 
@@ -2461,9 +2463,11 @@ class RunQueueExecute:
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
@@ -2807,14 +2811,19 @@ class RunQueueExecute:
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
2.43.2


