Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014AECD5BDE
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 07:57:14 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.10934.1695283023833712149
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Sep 2023 00:57:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=QPPL1nnr;
 spf=pass (domain: snapchat.com, ip: 209.85.208.54, mailfrom: ecordonnier@snapchat.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so640924a12.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 00:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1695283022; x=1695887822; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iSxVL88McJMpcIjfGVlFBTxtsrXPkx2NNYYJoARBI+c=;
        b=QPPL1nnrnFlF2sJotuLoJScHXYhfMKm0UNCJZVAKr9x4qKtQXf1bzstlaHdcnVhy/I
         cpUUsUySDI+a177t792xrmOYCr51dS+L52ANLYvHTHYkUZjNQs132ZIzOw9vNvfjXTGE
         TE9uDJJ5kj1UsRx+vYS4Cd0xIXoGcjUQBZ8H4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695283022; x=1695887822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSxVL88McJMpcIjfGVlFBTxtsrXPkx2NNYYJoARBI+c=;
        b=iDdILorDlkC8/TEQGH/7LMUkylJzfdoxyq3Dlw75qFGTZ1QSkA3gbt54iH4scGyO5t
         Yvps0t3RTur9Z3AvRYj/vnqqygFWwXmYSCl+A0Og56vRz+qsQYKEMmLnvac9YVJT/zwL
         gzg5DeT8O8MBbny/mVw4kKkTsdNAlHKgSnkWNQKfVvUOlALBAJMZ6D2Sdf9oke+KsNEZ
         skGrgDZgh2YGJtEPhuC8L+W7fkHmVHvYx83mz3hBot5qs1K7gwdmDkCu/N/AJ3Q+qWmj
         dTudnpKQlNZ9TxOoQakuFfmvCL0b131O/SVmo00dp9spfqCz0mYGF8a1X8nGHHstVw1e
         bTPg==
X-Gm-Message-State: AOJu0YxKiD1zYsaPjBD/fEfDBIdT+sM7EAbQEZtVeyr85L60xdBoCjnK
	wbwf24rm2IzWw5+DVnVSpyTM3c3Oi/sGdBa3DbIVHw==
X-Google-Smtp-Source: AGHT+IENczgfAoZIhrW0H1VCPstxy6XcSPUDe2ygdrGpMdbmwnsQ2l0Kn1Buc6ndMMvb75uF/MDItw==
X-Received: by 2002:a17:906:2001:b0:9a4:88af:b82 with SMTP id 1-20020a170906200100b009a488af0b82mr3790371ejo.77.1695283021739;
        Thu, 21 Sep 2023 00:57:01 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id lo18-20020a170906fa1200b0099bd1a78ef5sm648202ejb.74.2023.09.21.00.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:57:01 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH] bitbake-worker: add header with length of message
Date: Thu, 21 Sep 2023 09:56:58 +0200
Message-Id: <20230921075658.509846-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Sep 2023 07:57:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15097

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
---
 bin/bitbake-worker | 34 +++++++++++++++++++++++-----------
 lib/bb/runqueue.py | 34 ++++++++++++++++++++++------------
 2 files changed, 45 insertions(+), 23 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 451e6926..a4e78991 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -433,18 +433,30 @@ class BitbakeWorker(object):
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
+
+        index = self.queue.find(b"</" + item + b">")
+        if index != -1:
+            try:
+                func(self.queue[(tag_len + 4):index])
+            except pickle.UnpicklingError:
+                workerlog_write("Unable to unpickle data: %s\n" % ":".join("{:02x}".format(c) for c in self.queue))
+                raise
+            self.queue = self.queue[(index + len(b"</") + len(item) + len(b">")):]
 
     def handle_cookercfg(self, data):
         self.cookercfg = pickle.loads(data)
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c88d7129..9afb899c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1318,6 +1318,16 @@ class RunQueue:
         self.worker = {}
         self.fakeworker = {}
 
+    @staticmethod
+    def send_pickled_data(worker, data, name):
+        msg = bytearray()
+        msg.extend(b"<" + name.encode() + b">")
+        pickled_data = pickle.dumps(data)
+        msg.extend(len(pickled_data).to_bytes(4, 'big'))
+        msg.extend(pickled_data)
+        msg.extend(b"</" + name.encode() + b">")
+        worker.stdin.write(msg)
+
     def _start_worker(self, mc, fakeroot = False, rqexec = None):
         logger.debug("Starting bitbake-worker")
         magic = "decafbad"
@@ -1353,9 +1363,9 @@ class RunQueue:
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
@@ -1365,7 +1375,7 @@ class RunQueue:
             return
         logger.debug("Teardown for bitbake-worker")
         try:
-           worker.process.stdin.write(b"<quit></quit>")
+           RunQueue.send_pickled_data(worker.process, b"", "quit")
            worker.process.stdin.flush()
            worker.process.stdin.close()
         except IOError:
@@ -1892,14 +1902,14 @@ class RunQueueExecute:
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
@@ -2194,10 +2204,10 @@ class RunQueueExecute:
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not mc in self.rq.fakeworker:
                     self.rq.start_fakeworker(self, mc)
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps(runtask) + b"</runtask>")
+                RunQueue.send_pickled_data(self.rq.fakeworker[mc].process, runtask, "runtask")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps(runtask) + b"</runtask>")
+                RunQueue.send_pickled_data(self.rq.worker[mc].process, runtask, "runtask")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
@@ -2295,10 +2305,10 @@ class RunQueueExecute:
                         self.rq.state = runQueueFailed
                         self.stats.taskFailed()
                         return True
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps(runtask) + b"</runtask>")
+                RunQueue.send_pickled_data(self.rq.fakeworker[mc].process, runtask, "runtask")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps(runtask) + b"</runtask>")
+                RunQueue.send_pickled_data(self.rq.worker[mc].process, runtask, "runtask")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.build_stamps[task] = bb.parse.siggen.stampfile_mcfn(taskname, taskfn, extrainfo=False)
@@ -2500,9 +2510,9 @@ class RunQueueExecute:
 
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


