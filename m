Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4804D6ED12
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 12:13:02 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.9338.1732191174783629226
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Nov 2024 04:12:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CPMosdtc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53da209492cso970286e87.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Nov 2024 04:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732191172; x=1732795972; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Htm8NP0FhNM0/LSyHeJENe1y21iJJnAXp3VPZgEQw7M=;
        b=CPMosdtcSxPrdyxpaAgDytC/Qrs5XjGHtJZp6fYMZ4h2Dy7ncEYeZcjTXjZOBz0W9/
         WF84mO5Heca+LlAowiHsXKneKKrFuDUCAFxmepqd+cwx6kfOccXoVcGROarA02MAc2WJ
         zRmPzqmZFxetszUalU6Wv569afvbr1QKhXARA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732191172; x=1732795972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Htm8NP0FhNM0/LSyHeJENe1y21iJJnAXp3VPZgEQw7M=;
        b=tR3y9Ae9561XUWyY0gRtlnz3o2g6v7ngNaQ9oinsY/IJgMDfQYqKCj5Vw+OTPX+DIE
         WTmUyZNgVedd5oE49eN+l6c6lKgnieMaM0h5JMy0asKMTQVyHLmTnSE9ftafs4gG41Of
         SuKRVZpd433KIdBGbyxB6JTLR89jlzr/duFkz8M3e1dLmz22mlRXuW0WeXSTO/z1XTJj
         V3UiqDRgFY0m7J1fSJ7T6zVpilsmH7XCN3GAiYeJTnXweIbqu4YzxtPZ1GlXbRTy4DeH
         YsaclICGyzhvI9DJ1LSkufk0Jehb0IIqMXH6IDF0HiKz3HqTX+a4zF6zrUDBYFGFp0UQ
         Ajxg==
X-Gm-Message-State: AOJu0YyyvCFrgxGvkQ9VL0cIwab/BhzsTNb3PMlEPQL9C8s3dsFKoPc0
	ec3PWCzLdO53BG4GYMITuFoZuJEuJfn5+fYHjizRAdW2LSIv2FZn/1Dqd4PuVOrwVWiLC3QtZ3z
	X/Y8=
X-Google-Smtp-Source: AGHT+IEAR5z/Pn1gtg6GstWeqpRkuy8b21wdi1DH2gbnm1KHqIZvZjd54pja8zfkPuVQPtFhUYaBHQ==
X-Received: by 2002:a05:6512:3b24:b0:53d:c062:b5b7 with SMTP id 2adb3069b0e04-53dc136739dmr3296660e87.42.1732191171765;
        Thu, 21 Nov 2024 04:12:51 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a4ee:c091:1f03:6404])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490c682sm4883126f8f.31.2024.11.21.04.12.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 04:12:51 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3] bitbake-worker/cooker: Increase default pipe size
Date: Thu, 21 Nov 2024 12:12:49 +0000
Message-ID: <20241121121249.2574880-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Nov 2024 12:13:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16822

The default pipe size is 64kb on builds, which can be inefficient
for larger log files from workers. Increase the pipe size to 512kb
since build systems have decent amounts of memory and this is a more
efficient way of batching the data.

Tweak the default read sizes to match the pipe size for efficiency.

Since the contstant is only present in python 3.10 onwards, add
some compatibility code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 14 ++++++++++++--
 lib/bb/runqueue.py |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index a8a9660c5f..88217182fb 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -21,9 +21,14 @@ import traceback
 import queue
 import shlex
 import subprocess
+import fcntl
 from multiprocessing import Lock
 from threading import Thread
 
+# Remove when we have a minimum of python 3.10
+if not hasattr(fcntl, 'F_SETPIPE_SZ'):
+    fcntl.F_SETPIPE_SZ = 1031
+
 bb.utils.check_system_locale()
 
 # Users shouldn't be running this code directly
@@ -44,7 +49,6 @@ if sys.argv[1].startswith("decafbadbad"):
 # updates to log files for use with tail
 try:
     if sys.stdout.name == '<stdout>':
-        import fcntl
         fl = fcntl.fcntl(sys.stdout.fileno(), fcntl.F_GETFL)
         fl |= os.O_SYNC 
         fcntl.fcntl(sys.stdout.fileno(), fcntl.F_SETFL, fl)
@@ -56,6 +60,12 @@ logger = logging.getLogger("BitBake")
 
 worker_pipe = sys.stdout.fileno()
 bb.utils.nonblockingfd(worker_pipe)
+# Try to make the pipe buffers larger as it is much more efficient. If we can't
+# e.g. out of buffer space (/proc/sys/fs/pipe-user-pages-soft) then just pass over.
+try:
+    fcntl.fcntl(worker_pipe, fcntl.F_SETPIPE_SZ, 512 * 1024)
+except:
+    pass
 # Need to guard against multiprocessing being used in child processes
 # and multiple processes trying to write to the parent at the same time
 worker_pipe_lock = None
@@ -357,7 +367,7 @@ class runQueueWorkerPipe():
     def read(self):
         start = len(self.queue)
         try:
-            self.queue.extend(self.input.read(102400) or b"")
+            self.queue.extend(self.input.read(512*1024) or b"")
         except (OSError, IOError) as e:
             if e.errno != errno.EAGAIN:
                 raise
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 1b5b58f352..61608ac603 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -3318,7 +3318,7 @@ class runQueuePipe():
 
         start = len(self.queue)
         try:
-            self.queue.extend(self.input.read(102400) or b"")
+            self.queue.extend(self.input.read(512 * 1024) or b"")
         except (OSError, IOError) as e:
             if e.errno != errno.EAGAIN:
                 raise

