Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545BECE79AC
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 07:41:22 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web10.31670.1695195678035418331
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Sep 2023 00:41:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Yr/Mavql;
 spf=pass (domain: snapchat.com, ip: 209.85.208.178, mailfrom: ecordonnier@snapchat.com)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c02e232c48so22507651fa.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 00:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1695195676; x=1695800476; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nI1wRwLArerz0eE1/8QFwnCKBuZb0fs6yFtQQE9QcTg=;
        b=Yr/Mavql+kZXtqpqbyoIe9UtF2J0S4XKRPjYkAWoysYv+65QhHBvh+5fGCQjtOPJah
         ksbYcskpNT1Rb2Eyz+EahTmuDbyFY7eD5z2dwBTAEvNB9RXpJ9YS2rste7H6ea8Gw2m/
         4cj2gi/ZvG0r6n1sS7WSNtHHHRffK4yGBTJBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195676; x=1695800476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nI1wRwLArerz0eE1/8QFwnCKBuZb0fs6yFtQQE9QcTg=;
        b=OtSld1bOc95KQoWuvApKA2ObFaoIfIKAm3AWZZdSSsJP+ronu5kjj20tXQekeomfcE
         E3VVvEO49HpdS08prxMTHd+vPWQMVnVZwH7cTpX3ONWsBuOQxmbl5ltX0Ws/ForHyKDk
         9dn2Fsb4qvtxmdKabt14Z3Wk6H/48A/2MVq0eJ8+9WaEKOCp3L0UarIeMdLfeFS/xJT7
         aKi3LXWZb8BIrQP8r5Yuo9QcX5mGAYYjiXFaICosxjOFsE+5/SvoqDUxVChDtaKyK8RE
         LhNCoYTGTCxl9dIqiuRD0nMDNLszmxUfL8RHiMK6YHGPelVtrUxNrThDq30K1rzeA+2v
         lMJw==
X-Gm-Message-State: AOJu0YwFQCbd/0eG0R6ByR8lozph9eszKzr7LFNhXNsQdOznPsktY3bs
	gcuAxR13bqebWosM54nEVl54+e4bUE1uXPuSLe0=
X-Google-Smtp-Source: AGHT+IGZHTCBBkaLdwayd3jUPcdGmEIelK9YAaqZ99z4FApMz96jiYRjiVKR3yssirw20YhC5Dk+5w==
X-Received: by 2002:a2e:998c:0:b0:2c0:2ef8:9716 with SMTP id w12-20020a2e998c000000b002c02ef89716mr1479983lji.1.1695195675593;
        Wed, 20 Sep 2023 00:41:15 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709061b4800b0099c53c44083sm8902610ejg.79.2023.09.20.00.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:41:15 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [bitbake-devel][PATCH v2] avoid some unnecessary copies
Date: Wed, 20 Sep 2023 09:41:09 +0200
Message-Id: <20230920074109.4047252-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 07:41:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15087

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
---
 bin/bitbake-worker | 14 +++++++-------
 lib/bb/runqueue.py |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 451e6926..609e276f 100755
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
@@ -346,12 +346,12 @@ class runQueueWorkerPipe():
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
@@ -379,7 +379,7 @@ class BitbakeWorker(object):
     def __init__(self, din):
         self.input = din
         bb.utils.nonblockingfd(self.input)
-        self.queue = b""
+        self.queue = bytearray()
         self.cookercfg = None
         self.databuilder = None
         self.data = None
@@ -413,7 +413,7 @@ class BitbakeWorker(object):
                     if len(r) == 0:
                         # EOF on pipe, server must have terminated
                         self.sigterm_exception(signal.SIGTERM, None)
-                    self.queue = self.queue + r
+                    self.queue.extend(r)
                 except (OSError, IOError):
                     pass
             if len(self.queue):
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c88d7129..fde6e4e9 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -3159,7 +3159,7 @@ class runQueuePipe():
         if pipeout:
             pipeout.close()
         bb.utils.nonblockingfd(self.input)
-        self.queue = b""
+        self.queue = bytearray()
         self.d = d
         self.rq = rq
         self.rqexec = rqexec
@@ -3178,7 +3178,7 @@ class runQueuePipe():
 
         start = len(self.queue)
         try:
-            self.queue = self.queue + (self.input.read(102400) or b"")
+            self.queue.extend((self.input.read(102400) or b""))
         except (OSError, IOError) as e:
             if e.errno != errno.EAGAIN:
                 raise
-- 
2.36.1.vfs.0.0


