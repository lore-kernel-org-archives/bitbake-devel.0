Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E9FC4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 13:34:15 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web11.27341.1699623247623126476
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Nov 2023 05:34:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=ElegnGy3;
 spf=pass (domain: snapchat.com, ip: 209.85.218.45, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9dd3f4a0f5aso339654566b.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 05:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1699623245; x=1700228045; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=88/TDV8UPqVfgNctwbAQVqeKoGVbd8n30KOlz25nvyU=;
        b=ElegnGy3JqipynQcYbuJxaE6/KLK9a5qSilGPFUOayyyz/fKLCgkjO4OhiGUOcOUMQ
         y4MerU5qO9IcjnG3iPB9h4eORnLp3OoWGc4blx42gP9S8jBvSW7+jbUqJVPCwBysxLEn
         2t1a9Gbvedj0WkE9H1DU0UApi/MmG7klRElJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699623245; x=1700228045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88/TDV8UPqVfgNctwbAQVqeKoGVbd8n30KOlz25nvyU=;
        b=qqWeuI3zVDM3cAL3DfZoRKxSLubl8fWYGAoMGX3RjgZarQk4z83ESqlYn5nTMhkEVn
         f4QUAGMxCF1mvGtWCRy7w4XEyJ/+dqccPFQa1tAakKWfehiY3mK4GHkYcstqkxvVaCh4
         Fw1jshWNMmzA1livZEGP3BrDfQ6kG4VwVHUm/9w2K2B14a2simJLSCnb3rH2H7tAu+p6
         WiZJpSao2lyIL4F3xryj5ty68U7sALkng7+ZEe6crHuai4fkIc3kxxXVOb0Ha8az4Od/
         bjpMiTRixviVnIdHTOq19wc38uOQNJ2k7IjYYW6AwVCsfBBUf4L6RmjJ3qiL6tjAh7rK
         /jOg==
X-Gm-Message-State: AOJu0YzDki9UupSbhW0RIDPAPVTvo5WFr1XUuiDm3GajdPJh48H1T/Rr
	JHGTUHrQ6zGXKbqmenOnxjOewM3D0FYIIQufj0WKi5H8
X-Google-Smtp-Source: AGHT+IHnA1gXaPauW7/eSPB6to1Y7l2E+EIlrhrxnMMz3szp+fP2RYbLKAIFc7P5Mf6/r1VBWgb6hw==
X-Received: by 2002:a17:907:320d:b0:9df:4232:5276 with SMTP id xg13-20020a170907320d00b009df42325276mr5715590ejb.76.1699623245297;
        Fri, 10 Nov 2023 05:34:05 -0800 (PST)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id g1-20020a1709063b0100b009ad8796a6aesm3934195ejf.56.2023.11.10.05.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 05:34:05 -0800 (PST)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][kirkstone][PATCH] bitbake-worker: add header with length of message
Date: Fri, 10 Nov 2023 14:33:24 +0100
Message-Id: <20231110133324.3168418-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Nov 2023 13:34:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15492

From: Etienne Cordonnier <ecordonnier@snap.com>

The IPC mechanism between runqueue.py and bitbake-worker is currently
not scalable:

The data is sent with the format <tag>pickled-data</tag>, and bitbake-worker
has no information about the size of the message. Therefore, the bitbake-worker
is calling select() and read() in a loop, and then calling "self.queue.find(b"</" + item + b">")"
for each chunk received.

This does not scale, because queue.find has a linear complexity relative to the size of the queue,
and workerdata messages get very big e.g. for builds which reference a lot of files in SRC_URI.
The number of chunks varies, but on my test system a lot of chunks of 65536 bytes are sent, and each
iteration takes 0.1 seconds, making the transfer of the "workerdata" data very slow (on my test setup
35 seconds before this fix, and 1.5 seconds after this fix).

This commit adds a 4 bytes header after <tag>, so that bitbake-worker knows how many bytes need to be
received, and does not need to constantly search the whole queue for </tag>.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 33 ++++++++++++++++++++++-----------
 lib/bb/runqueue.py | 34 ++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 23 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index e02f2532..f8be973d 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -425,18 +425,29 @@ class BitbakeWorker(object):
                 while self.process_waitpid():
                     continue
 
-
     def handle_item(self, item, func):
-        if self.queue.startswith(b"<" + item + b">"):
-            index = self.queue.find(b"</" + item + b">")
-            while index != -1:
-                try:
-                    func(self.queue[(len(item) + 2):index])
-                except pickle.UnpicklingError:
-                    workerlog_write("Unable to unpickle data: %s\n" % ":".join("{:02x}".format(c) for c in self.queue))
-                    raise
-                self.queue = self.queue[(index + len(item) + 3):]
-                index = self.queue.find(b"</" + item + b">")
+        opening_tag = b"<" + item + b">"
+        if not self.queue.startswith(opening_tag):
+            return
+
+        tag_len = len(opening_tag)
+        if len(self.queue) < tag_len + 4:
+            # we need to receive more data
+            return
+        header = self.queue[tag_len:tag_len + 4]
+        payload_len = int.from_bytes(header, 'big')
+        # closing tag has length (tag_len + 1)
+        if len(self.queue) < tag_len * 2 + 1 + payload_len:
+            # we need to receive more data
+            return
+        index = self.queue.find(b"</" + item + b">")
+        if index != -1:
+            try:
+                func(self.queue[(len(item) + 2 + 4):index])
+            except pickle.UnpicklingError:
+                workerlog_write("Unable to unpickle data: %s\n" % ":".join("{:02x}".format(c) for c in self.queue))
+                raise
+            self.queue = self.queue[(index + len(b"</") + len(item) + len(b">")):]
 
     def handle_cookercfg(self, data):
         self.cookercfg = pickle.loads(data)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 8605c46c..4e48c944 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1289,6 +1289,16 @@ class RunQueue:
         self.worker = {}
         self.fakeworker = {}
 
+    @staticmethod
+    def send_pickled_data(worker, data, name):
+        msg = bytearray()
+        pickled_data = pickle.dumps(data)
+        msg.extend(b"<" + name.encode() + b">")
+        msg.extend(len(pickled_data).to_bytes(4, 'big'))
+        msg.extend(pickled_data)
+        msg.extend(b"</" + name.encode() + b">")
+        worker.stdin.write(msg) 
+
     def _start_worker(self, mc, fakeroot = False, rqexec = None):
         logger.debug("Starting bitbake-worker")
         magic = "decafbad"
@@ -1328,9 +1338,9 @@ class RunQueue:
             "umask" : self.cfgData.getVar("BB_DEFAULT_UMASK"),
         }
 
-        worker.stdin.write(b"<cookerconfig>" + pickle.dumps(self.cooker.configuration) + b"</cookerconfig>")
-        worker.stdin.write(b"<extraconfigdata>" + pickle.dumps(self.cooker.extraconfigdata) + b"</extraconfigdata>")
-        worker.stdin.write(b"<workerdata>" + pickle.dumps(workerdata) + b"</workerdata>")
+        RunQueue.send_pickled_data(worker, self.cooker.configuration, "cookerconfig")
+        RunQueue.send_pickled_data(worker, self.cooker.extraconfigdata, "extraconfigdata")
+        RunQueue.send_pickled_data(worker, workerdata, "workerdata")
         worker.stdin.flush()
 
         return RunQueueWorker(worker, workerpipe)
@@ -1340,7 +1350,7 @@ class RunQueue:
             return
         logger.debug("Teardown for bitbake-worker")
         try:
-           worker.process.stdin.write(b"<quit></quit>")
+           RunQueue.send_pickled_data(worker.process, b"", "quit")
            worker.process.stdin.flush()
            worker.process.stdin.close()
         except IOError:
@@ -1867,14 +1877,14 @@ class RunQueueExecute:
     def finish_now(self):
         for mc in self.rq.worker:
             try:
-                self.rq.worker[mc].process.stdin.write(b"<finishnow></finishnow>")
+                RunQueue.send_pickled_data(self.rq.worker[mc].process, b"", "finishnow")
                 self.rq.worker[mc].process.stdin.flush()
             except IOError:
                 # worker must have died?
                 pass
         for mc in self.rq.fakeworker:
             try:
-                self.rq.fakeworker[mc].process.stdin.write(b"<finishnow></finishnow>")
+                RunQueue.send_pickled_data(self.rq.fakeworker[mc].process, b"", "finishnow")
                 self.rq.fakeworker[mc].process.stdin.flush()
             except IOError:
                 # worker must have died?
@@ -2156,10 +2166,10 @@ class RunQueueExecute:
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not mc in self.rq.fakeworker:
                     self.rq.start_fakeworker(self, mc)
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                RunQueue.send_pickled_data(self.rq.fakeworker[mc].process, (taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, False), "runtask")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
+                RunQueue.send_pickled_data(self.rq.worker[mc].process, (taskfn, task, taskname, taskhash, unihash, True, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, False), "runtask")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
@@ -2243,10 +2253,10 @@ class RunQueueExecute:
                         self.rq.state = runQueueFailed
                         self.stats.taskFailed()
                         return True
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                RunQueue.send_pickled_data(self.rq.fakeworker[mc].process, (taskfn, task, taskname, taskhash, unihash, False, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce), "runtask")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, taskhash, unihash, False, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce)) + b"</runtask>")
+                RunQueue.send_pickled_data(self.rq.worker[mc].process, (taskfn, task, taskname, taskhash, unihash, False, self.cooker.collections[mc].get_file_appends(taskfn), taskdepdata, self.rqdata.setscene_enforce), "runtask")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
@@ -2448,9 +2458,9 @@ class RunQueueExecute:
 
         if changed:
             for mc in self.rq.worker:
-                self.rq.worker[mc].process.stdin.write(b"<newtaskhashes>" + pickle.dumps(bb.parse.siggen.get_taskhashes()) + b"</newtaskhashes>")
+                RunQueue.send_pickled_data(self.rq.worker[mc].process, bb.parse.siggen.get_taskhashes(), "newtaskhashes")
             for mc in self.rq.fakeworker:
-                self.rq.fakeworker[mc].process.stdin.write(b"<newtaskhashes>" + pickle.dumps(bb.parse.siggen.get_taskhashes()) + b"</newtaskhashes>")
+                RunQueue.send_pickled_data(self.rq.fakeworker[mc].process, bb.parse.siggen.get_taskhashes(), "newtaskhashes")
 
             hashequiv_logger.debug(pprint.pformat("Tasks changed:\n%s" % (changed)))
 
-- 
2.36.1.vfs.0.0


