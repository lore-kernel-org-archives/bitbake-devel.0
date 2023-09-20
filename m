Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBCDCE79AB
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 07:42:02 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.31770.1695195712725734365
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Sep 2023 00:41:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=fQawGujM;
 spf=pass (domain: snapchat.com, ip: 209.85.208.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-52c4d3ff424so8131174a12.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 00:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1695195711; x=1695800511; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNYiUB3JGZgoJExQVQ//SFov5ioJzfwPeHmopZZMDqk=;
        b=fQawGujMpeIfBW8FcRUuX2xHrTpCoeu0Kb3VDvorxF5VSILjpqFNma/3fznFk/I1K6
         /y6y+ewDzPdBHsVJBzniFdamkdQRRQVwLHepMHWqWas1frF9wJJCmLZJL5DnuUa9Zisv
         IfBRuv0GNvml/q4W+Tv5kE4cFWYj7gjdXOKV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195711; x=1695800511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNYiUB3JGZgoJExQVQ//SFov5ioJzfwPeHmopZZMDqk=;
        b=TWWajG7es1Si2VybEEtcW6mFwvkY98YoxyNrEi2Qxb6eF5IRRSuBB73bKHlYAZvbZo
         4/fH2ZPn4TirQwrddT8fFaN4aD2uqBOBoD+FppiLy/ZsWAUwbWuvqVhYegY6ozPN6LsJ
         yTCA02V0xm2NxmVaUh/jbRQuhq7OeiOzQbEYYDJo1QVp8zkQU3Sv4VYGD0A7uvhnEzX5
         UVPewqbFkRzcrpUDsey+VQP6yT7lAXUjfMBYQOPdiu/BB4TicYKtYJHS4Fm0NoJwPJCr
         V5wYe/uksYVk+lKyrTChPSZjxVOiXWpM3U6KR0qF3QJUObzIo77ECEgJrp16jyM9+Qlg
         0UBw==
X-Gm-Message-State: AOJu0YzJDEGtZJgCWZZo/12u2ipLSINm/LuF6aiSxoTSHdBY4QHKWy2D
	JUELWpB9DSEDtdGkI9qAo23OcmxYOcgfSgrpxN8=
X-Google-Smtp-Source: AGHT+IEm5wh2+375dbHwrElGHvAX9qV/x4cruOMoA0SPEh95mIghwo0Nby1OmT9RdcWPbJDBAUXOZw==
X-Received: by 2002:a50:e717:0:b0:530:8a59:a01d with SMTP id a23-20020a50e717000000b005308a59a01dmr1543632edn.27.1695195710834;
        Wed, 20 Sep 2023 00:41:50 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id g16-20020a056402321000b00530cf354746sm5563430eda.48.2023.09.20.00.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:41:50 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [bitbake-devel][PATCH v3] avoid some unnecessary copies
Date: Wed, 20 Sep 2023 09:41:48 +0200
Message-Id: <20230920074148.4047337-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 07:42:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15088

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
index c88d7129..c40a3be2 100644
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
+            self.queue.extend(self.input.read(102400) or b"")
         except (OSError, IOError) as e:
             if e.errno != errno.EAGAIN:
                 raise
-- 
2.36.1.vfs.0.0


