Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50B5CE79AD
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 06:52:01 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
 by mx.groups.io with SMTP id smtpd.web11.31311.1695192715772526607
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Sep 2023 23:51:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=DFTBi/UX;
 spf=pass (domain: snapchat.com, ip: 209.85.218.41, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso851612466b.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Sep 2023 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1695192714; x=1695797514; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nI1wRwLArerz0eE1/8QFwnCKBuZb0fs6yFtQQE9QcTg=;
        b=DFTBi/UXnIybMer4vIizpI2fsFe4gf1ESLyL8frx6+W/omTwSEpNCoS8651KQ4maUo
         b5DRzZzDuZGzuJcMAymom2thhWnFpxil+c6Gt2/GNMT3qmlO9mbEPHoegGX0eeo/ceP+
         msKRMhGRbe8yUBOQ2/dBmu4zXZ99eoAOWw5XE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695192714; x=1695797514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nI1wRwLArerz0eE1/8QFwnCKBuZb0fs6yFtQQE9QcTg=;
        b=MMyr9PM1jvxwsYOWVvrHpTRKWPtAMxf/zUNluLtrxOY/bBrpF+OGJQMMZfZnIPvSob
         0lJIipIXDbhX42Qf0UMnjANWBC5ZXu/Gc1BZh5AJvMPTT1OFSmhHFoTJIguW5sjUy6Vg
         dxktm8iELTL6omAbyQyjNct9q385PtnrQigcGZZIA2UBCekKoRVeflRyWcWgD64WLH1c
         yW7TBLma3ERgDuZmKc+/kmkrJx5bWY+gez0/ZPy158pcxR37Uer9MF9hlk+IAfnpMJL1
         Ur2ZvOXTAwtWok4wZocHbouiJX7WcegKBf+x+N7ut6ULWqk84Q1sOGnl18VX6kxeOPgb
         NZgQ==
X-Gm-Message-State: AOJu0Yz8+ppmcc0rkY/obuQdZZ2mjGBD97vBDwx1aLaii1I3QbwsyL7R
	gvnYgElhJ3PVig3B7c1XxD0UOT2UJtv6hn3Y0N8=
X-Google-Smtp-Source: AGHT+IFjwV0N/dpKQc5I2CsJhbg7fXbNYoGT2KnPdARkpGJS6QywsITS8YziHLxQg7ydfHTMbjor8Q==
X-Received: by 2002:a17:906:1091:b0:9ad:fb49:4eda with SMTP id u17-20020a170906109100b009adfb494edamr1306749eju.3.1695192713841;
        Tue, 19 Sep 2023 23:51:53 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906248a00b00993928e4d1bsm8757771ejb.24.2023.09.19.23.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:51:53 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH] avoid some unnecessary copies
Date: Wed, 20 Sep 2023 08:51:46 +0200
Message-Id: <20230920065146.3753615-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Sep 2023 06:52:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15086

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


