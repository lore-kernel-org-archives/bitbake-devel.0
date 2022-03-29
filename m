Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49499C433EF
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 14:28:05 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web09.7297.1648564083975695724
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:28:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TfSJzzdD;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id r7so10430763wmq.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6Qxp89SqDLZp4dijR+R8YJGNs9BkPF09FXA/ws0Ig/c=;
        b=TfSJzzdDGQ2sC0m88ntpoiLc/BW9UtOqjIqMaqAnzevgFMJzOMsAq8hBs4qXKCv7Cv
         SCmCqdJRNWaJL8zS3h3NEpE0LL5DAbrn9Ukhy2qBdoIn4wuqwlVrXmXOPV4JTz026IxP
         DScRCSbB386jQJMg9a8M4zXzJBUPrRDk/hblY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Qxp89SqDLZp4dijR+R8YJGNs9BkPF09FXA/ws0Ig/c=;
        b=QfEJSeXAPFDjP6dJg90AqPaEQ4nxwjkSE/pqinlNbzkKftsAmjYTLyYcQEJ81hOwA0
         meDDnIhTX52tDDW/fg4L8UpLrRcKql7BfqxlYU+fiN7jTece1hFXmlK/No5FXhVe+bOH
         H134anUotAOk8CQyypH6P80Ze9yO4t47DMjfiTHFY+vhCGblZCegtsuuHsN68DBbkbmq
         lYybpmV2JKXsm6iv7eI2Ee4Daft82Ld+scAztcRr4Tg2hbMhbALtIjOakYJXfnkB8Bc0
         Wfm2ikhVDr+5A6PHWLee5BufbtsyOgMez/0qd6wTvD0BkNh2pgP899S9q2/1FPI9CZB4
         d85g==
X-Gm-Message-State: AOAM5318SCFmFG4NngiLix3/fglP0cY5kbw7gA0UQXf4fIvHW38jvSH1
	lNHs9EgqAsojF7I77U18yArEyJ0L8HsHECR7
X-Google-Smtp-Source: 
 ABdhPJwRz5+MA0/tbDffn1jE1iprEzcl0oRjfMPdYitdPED62Tzwc7Jwc1Bw8XnoW48p0PjGzeW9hw==
X-Received: by 2002:a05:600c:4f15:b0:38c:b729:4838 with SMTP id
 l21-20020a05600c4f1500b0038cb7294838mr7302621wmq.132.1648564082105;
        Tue, 29 Mar 2022 07:28:02 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a144:3266:4a07:b254])
        by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b00380deeaae72sm2529043wmb.1.2022.03.29.07.28.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:28:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/6] cooker/process: Fix signal handling lockups
Date: Tue, 29 Mar 2022 15:27:54 +0100
Message-Id: <20220329142755.1473185-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329142755.1473185-1-richard.purdie@linuxfoundation.org>
References: <20220329142755.1473185-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 14:28:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13544

If a parser process is terminated while holding a write lock, then it
will lead to a deadlock (see
https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Process.terminate).

With SIGTERM, we don't want to terminate holding the lock. We also don't
want a SIGINT to cause a partial write to the event stream.

I tried using signal masks to avoid this but it doesn't work, see
https://bugs.python.org/issue47139

Instead, add a signal handler and catch the calls around the critical section.
We also need a thread lock to ensure other threads in the same process don't
handle the signal until all the threads are not in the lock.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         | 28 ++++++++++++++++++++++++++--
 lib/bb/server/process.py | 22 ++++++++++++++++++++--
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d6fcd9e05c..7c0c5d4efa 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2017,6 +2017,22 @@ class Parser(multiprocessing.Process):
         self.context = bb.utils.get_context().copy()
         self.handlers = bb.event.get_class_handlers().copy()
         self.profile = profile
+        self.queue_signals = False
+        self.signal_received = []
+        self.signal_threadlock = threading.Lock()
+
+    def catch_sig(self, signum, frame):
+        if self.queue_signals:
+            self.signal_received.append(signum)
+        else:
+            self.handle_sig(signum, frame)
+
+    def handle_sig(self, signum, frame):
+        if signum == signal.SIGTERM:
+            signal.signal(signal.SIGTERM, signal.SIG_DFL)
+            os.kill(os.getpid(), signal.SIGTERM)
+        elif signum == signal.SIGINT:
+            signal.default_int_handler(signum, frame)
 
     def run(self):
 
@@ -2036,9 +2052,17 @@ class Parser(multiprocessing.Process):
             prof.dump_stats(logfile)
 
     def realrun(self):
-        signal.signal(signal.SIGTERM, signal.SIG_DFL)
+        # Signal handling here is hard. We must not terminate any process or thread holding the write
+        # lock for the event stream as it will not be released, ever, and things will hang.
+        # Python handles signals in the main thread/process but they can be raised from any thread and
+        # we want to defer processing of any SIGTERM/SIGINT signal until we're outside the critical section
+        # and don't hold the lock (see server/process.py). We therefore always catch the signals (so any
+        # new thread should also do so) and we defer handling but we handle with the local thread lock
+        # held (a threading lock, not a multiprocessing one) so that no other thread in the process
+        # can be in the critical section.
+        signal.signal(signal.SIGTERM, self.catch_sig)
         signal.signal(signal.SIGHUP, signal.SIG_DFL)
-        signal.signal(signal.SIGINT, signal.SIG_IGN)
+        signal.signal(signal.SIGINT, self.catch_sig)
         bb.utils.set_process_name(multiprocessing.current_process().name)
         multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, exitpriority=1)
         multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, exitpriority=1)
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 7c587a9110..ce53fdc678 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -20,6 +20,7 @@ import os
 import sys
 import time
 import select
+import signal
 import socket
 import subprocess
 import errno
@@ -737,11 +738,28 @@ class ConnectionWriter(object):
         # Why bb.event needs this I have no idea
         self.event = self
 
-    def send(self, obj):
-        obj = multiprocessing.reduction.ForkingPickler.dumps(obj)
+    def _send(self, obj):
         with self.wlock:
             self.writer.send_bytes(obj)
 
+    def send(self, obj):
+        obj = multiprocessing.reduction.ForkingPickler.dumps(obj)
+        # See notes/code in CookerParser
+        # We must not terminate holding this lock else processes will hang.
+        # For SIGTERM, raising afterwards avoids this.
+        # For SIGINT, we don't want to have written partial data to the pipe.
+        # pthread_sigmask block/unblock would be nice but doesn't work, https://bugs.python.org/issue47139
+        process = multiprocessing.current_process()
+        if process and hasattr(process, "queue_signals"):
+            with process.signal_threadlock:
+                process.queue_signals = True
+                self._send(obj)
+                process.queue_signals = False
+                for sig in process.signal_received.pop():
+                    process.handle_sig(sig, None)
+        else:
+            self._send(obj)
+
     def fileno(self):
         return self.writer.fileno()
 
-- 
2.32.0


