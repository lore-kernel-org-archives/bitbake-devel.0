Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6C3CD4F33
	for <webhook@archiver.kernel.org>; Fri, 22 Sep 2023 08:52:05 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.17231.1695372717815476359
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Sep 2023 01:51:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=D1ExkCpQ;
 spf=pass (domain: snapchat.com, ip: 209.85.218.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9adca291f99so220416266b.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 22 Sep 2023 01:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1695372715; x=1695977515; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CC2jZoPuniEJyWdS7CBi38zdrcYTloUNbARamK2DsdM=;
        b=D1ExkCpQzGeljNHgq2VyX4gEvRiE/y46Y4bwMaUupPUkon5R+hCjdp36tiBu0zhr8m
         8t3I4LMT8z5lrNzAkglWh0NtjmXX5rAk2cZenDfpG6yVME+bhG6MVwyz40hR5aZguf4k
         L43T3UfO0nSjooJUDOATAoU2+dlNXf9tZw+C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695372715; x=1695977515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CC2jZoPuniEJyWdS7CBi38zdrcYTloUNbARamK2DsdM=;
        b=r+gy1HpKWe8Vc2R9L1ywRNXE3NR/eapbUQ1Vwj8tkCRBvEsu9nfVn6Yin7F5AJHAWI
         RBOsOPIdfAeBAgfpFQumBLbZs3zHgoLEafPamo5I8zXDPZuQ52DHYP6Ca+weAq1aYtuV
         OrLbOsfRCaUnfmgqjTAbfifMuVjhxiypr4MdKUNcTRCQo9X9gvudWNv0pW/EjcRmOKrk
         ZcDxdfzSqykkDE220qzf1TnSCdHSwgB/qbe6plMRhnMTOutxRsIQ+GFqUTvLXV0LBtoL
         3b3JtLdFtQpmyeWXcAUGoubM9Mvfc+p3ZAsmlzo86XmKfWFEwCLnMTSKd0mhv1XJ4TTT
         2RNw==
X-Gm-Message-State: AOJu0Yz2vNn90cX6h5WEFG+ZjjvEXfDXvpbPHZ4ZxT6ejAN+h36szjlQ
	8SaIJTeIfRzHsTbEqEmQva4TZRlsDWShXUNZQrg=
X-Google-Smtp-Source: AGHT+IFD4ILAxWkyMMQHEBmkykPBiuvEUrYy3abpjnlGyX5C4J2cQuumT7dwUUZhD21FA7axrxYbvw==
X-Received: by 2002:a17:906:8450:b0:9ae:3f7a:f777 with SMTP id e16-20020a170906845000b009ae3f7af777mr6606438ejy.9.1695372715560;
        Fri, 22 Sep 2023 01:51:55 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id jt24-20020a170906ca1800b009929d998abcsm2343497ejb.209.2023.09.22.01.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 01:51:55 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [kirkstone][2.0][PATCH] bitbake-worker/runqueue: Avoid unnecessary bytes object copies
Date: Fri, 22 Sep 2023 10:51:46 +0200
Message-Id: <20230922085146.2997927-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 22 Sep 2023 08:52:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15104

From: Etienne Cordonnier <ecordonnier@snap.com>

declaring queue=b"" creates an object of types bytes().
bytes() is an immutable object, and therefore doing "self.queue = self.queue + r"
creates a new object containing "self.queue" concatenated with "r".

On my test setup, we are passing 180MB of data of "workerdata" to the bitbake-worker,
so those copies significantly slow down the initialization of the bitbake-worker.

Rather use bytearray() which a mutable type, and use extend() to avoid copies.
In my test setup, byterray.extend() is 10.000 times faster than copying the queue,
for a queue size of 180MB.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 14 +++++++-------
 lib/bb/runqueue.py |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 5e62bc20..e02f2532 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -91,19 +91,19 @@ def worker_fire_prepickled(event):
 worker_thread_exit = False
 
 def worker_flush(worker_queue):
-    worker_queue_int = b""
+    worker_queue_int = bytearray()
     global worker_pipe, worker_thread_exit
 
     while True:
         try:
-            worker_queue_int = worker_queue_int + worker_queue.get(True, 1)
+            worker_queue_int.extend(worker_queue.get(True, 1))
         except queue.Empty:
             pass
         while (worker_queue_int or not worker_queue.empty()):
             try:
                 (_, ready, _) = select.select([], [worker_pipe], [], 1)
                 if not worker_queue.empty():
-                    worker_queue_int = worker_queue_int + worker_queue.get()
+                    worker_queue_int.extend(worker_queue.get())
                 written = os.write(worker_pipe, worker_queue_int)
                 worker_queue_int = worker_queue_int[written:]
             except (IOError, OSError) as e:
@@ -338,12 +338,12 @@ class runQueueWorkerPipe():
         if pipeout:
             pipeout.close()
         bb.utils.nonblockingfd(self.input)
-        self.queue = b""
+        self.queue = bytearray()
 
     def read(self):
         start = len(self.queue)
         try:
-            self.queue = self.queue + (self.input.read(102400) or b"")
+            self.queue.extend(self.input.read(102400) or b"")
         except (OSError, IOError) as e:
             if e.errno != errno.EAGAIN:
                 raise
@@ -371,7 +371,7 @@ class BitbakeWorker(object):
     def __init__(self, din):
         self.input = din
         bb.utils.nonblockingfd(self.input)
-        self.queue = b""
+        self.queue = bytearray()
         self.cookercfg = None
         self.databuilder = None
         self.data = None
@@ -405,7 +405,7 @@ class BitbakeWorker(object):
                     if len(r) == 0:
                         # EOF on pipe, server must have terminated
                         self.sigterm_exception(signal.SIGTERM, None)
-                    self.queue = self.queue + r
+                    self.queue.extend(r)
                 except (OSError, IOError):
                     pass
             if len(self.queue):
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 56952070..46ff30a7 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -3101,7 +3101,7 @@ class runQueuePipe():
         if pipeout:
             pipeout.close()
         bb.utils.nonblockingfd(self.input)
-        self.queue = b""
+        self.queue = bytearray()
         self.d = d
         self.rq = rq
         self.rqexec = rqexec
@@ -3120,7 +3120,7 @@ class runQueuePipe():
 
         start = len(self.queue)
         try:
-            self.queue = self.queue + (self.input.read(102400) or b"")
+            self.queue.extend(self.input.read(102400) or b"")
         except (OSError, IOError) as e:
             if e.errno != errno.EAGAIN:
                 raise
-- 
2.36.1.vfs.0.0


