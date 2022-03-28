Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE040C433EF
	for <webhook@archiver.kernel.org>; Mon, 28 Mar 2022 10:38:14 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web08.9405.1648463893571745302
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Mar 2022 03:38:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eUUrE6Lq;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id a1so19696946wrh.10
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Mar 2022 03:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4AxBCJ+jBITI/fb17D4jjcQEo9gTXUGh21lVpf7sK5Q=;
        b=eUUrE6LqRyKI4gBlsmhwjFxYmtfJ7ixZLpCWTMciB+4VbHI0txJUVvfuB8agzC67Uz
         t7Yk+Q+tdEgcy9MxBrtxW35sebqEPxM0/GyMb3B3cg0BM66sLDeJ4xkoZodttzOwIXk6
         eWCR3U8i5+7qE4j9AZk+5HiP5GZ3kQFiANQkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4AxBCJ+jBITI/fb17D4jjcQEo9gTXUGh21lVpf7sK5Q=;
        b=k3owE733hD1MDJ13q29cWNajxj6RDGf3HYuG41Ata5LyqphiPfyuDwCf1Z3y9Heauq
         W/CsyxLa+Zjb4bu3CYazBQTKI6ak2U2NYX0tbn5owDG3wj5r0PlK+LBDSwwarwf+qiZt
         flzbMqFuZKlQYhltTdXPBaXXNeo9rqgBrsaEavUOH8ol+xU5k9OiLVCsO9jg9ZVpOjeS
         Th9Bosv/qIB1yK8P6MbDih7n+/8P+8ww/A8eJwYmDHuSp6dTxF3T++gFos2tVEuX9VR3
         BhZggXTTcCxtjBllzEOzBV5neRaM+WENAZVOGk9+OUoawSgCMne5eFtQ7rM1GnxiDSPp
         I7zA==
X-Gm-Message-State: AOAM5306fHmiV7dZgSSRWC8evXZeQsRfoUoUETDiuzTSnvvtnmOXnrxA
	b6WT1NFUXZrmKYukM6KsTjoByRSOZrL3uA3h
X-Google-Smtp-Source: 
 ABdhPJygWJoTq/UslJl8NCcvODP8Z0e7opO12baR1MJZDedPrqd2QnRXuVgHWJbfSGdQc2PgTtXYUw==
X-Received: by 2002:a05:6000:1848:b0:204:e92:5af6 with SMTP id
 c8-20020a056000184800b002040e925af6mr22345293wri.180.1648463891517;
        Mon, 28 Mar 2022 03:38:11 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69e0:aa6:3ee0:1c3c])
        by smtp.gmail.com with ESMTPSA id
 u11-20020a5d6acb000000b002058148822bsm16893823wrw.63.2022.03.28.03.38.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 03:38:10 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/6 v2] server/process: Avoid hanging if a parser process is
 terminated
Date: Mon, 28 Mar 2022 11:38:09 +0100
Message-Id: <20220328103809.1423865-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Mar 2022 10:38:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13523

If a parser process is terminated while holding a write lock, then it
will lead to a deadlock (see
https://docs.python.org/3/library/multiprocessing.html#multiprocessing.Process.terminate).

With SIGTERM, we don't want to terminate holding the lock. We also don't
want a SIGINT to cause a partial write to the event stream.

I tried using signal masks to avoid this but it doesn't work, see
https://bugs.python.org/issue47139

Instead, add a signal handler and catch the calls around the critical section
which is heavier but safe and seems to avoid all the deadlocks I was able to
trigger.

Some ideas from Peter Kjellerstedt <peter.kjellerstedt@axis.com>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index efc3f04b4c..f59a0ed5f6 100644
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
@@ -736,11 +737,25 @@ class ConnectionWriter(object):
         self.wlock = multiprocessing.Lock()
         # Why bb.event needs this I have no idea
         self.event = self
+        self.signal_received = []
+
+    def catch_sig(self, signum, frame):
+        self.signal_received.append(signum)
 
     def send(self, obj):
         obj = multiprocessing.reduction.ForkingPickler.dumps(obj)
+        # We must not terminate holding this lock. For SIGTERM, raising afterwards avoids this.
+        # For SIGINT, we don't want to have written partial data to the pipe.
+        # pthread_sigmask block/unblock would be nice but doesn't work, https://bugs.python.org/issue47139
+        oldsigterm = signal.signal(signal.SIGTERM, self.catch_sig)
+        oldsigint = signal.signal(signal.SIGINT, self.catch_sig)
         with self.wlock:
             self.writer.send_bytes(obj)
+        signal.signal(signal.SIGTERM, oldsigterm)
+        signal.signal(signal.SIGINT, oldsigint)
+        for sig in [signal.SIGTERM, signal.SIGINT]:
+            if sig in self.signal_received:
+                os.kill(os.getpid(), sig)
 
     def fileno(self):
         return self.writer.fileno()
-- 
2.32.0


