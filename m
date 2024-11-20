Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0169D63938
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 12:56:23 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.12595.1732107382284189897
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Nov 2024 04:56:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YlUbLStF;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431616c23b5so5101145e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 04:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732107380; x=1732712180; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8bW8RBnV2lhePtig3SBpfgASSrTb1+a1Of+6Kq97+Ps=;
        b=YlUbLStF584eD3U4rymfmYwjRwFre35H2TKnhJ+0lVi5cmsINwDFBTe7d1HViZYUnS
         L/MMyqRieH3mhvELR03nTBAixqQorqnUR0m1lnXcHoJIv/u2odcrGg6WiJUR0LiT3Zna
         vF2n7vmeW7lDfJCu9zsiVQIJc6lls98H6auj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732107380; x=1732712180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bW8RBnV2lhePtig3SBpfgASSrTb1+a1Of+6Kq97+Ps=;
        b=DmYpFvGFR3dcZqCMlPjsYKKcG8yBkEe/T+atoFNoAk7TMEYwwn1GZvwYZTTFkcLlV5
         WfReVjiVk8DQxhONGc6LP7Hv2UH7Dt/LGbDT098kYMJMWgdNrWUuE3iFPCGSJgHcM6IR
         RKvK19OwwaCrWXB6GEI4kx/mO9OvSN8QlAjrhtJD0SdOZzmTYsvi4TetD6lFPqYkIzEF
         sUoLcuc1Lf9hTwpKAX0dNP4/LSVGdA8U4dZI78NYAed2Yq7fpNf436lfTQvtPhPhlkMI
         AFKaR9+QWG6pfNsozFm7ykdBrtAHVw2Z/s5b0tSM8V4upEWbCQ9baCveDOinRo+RKzrv
         VPSA==
X-Gm-Message-State: AOJu0YydBmFeyaPRG1Sx3VnVickr+MVwNN5+OMOxt0EBJoNZRPzHE4Rt
	oJkJvC6Y9pJjVCb6mo8hYW4R3rW0tBMBbf6wtgNX5L9Km5OcHsXPUnvzd0HLRlC0bRfWyCzFMtz
	o3sU=
X-Google-Smtp-Source: AGHT+IF/Z1XM/1fK2/+6pVO7lCLtrlovgjTVF+zbKlXkvj2Iy6KuGQKUXzRVW96mZVx3YkxbRilM3A==
X-Received: by 2002:a05:600d:3:b0:433:c463:62d7 with SMTP id 5b1f17b1804b1-433c4636562mr5759475e9.4.1732107380140;
        Wed, 20 Nov 2024 04:56:20 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:5abf:50dd:d6fd:8415])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b46189besm18160765e9.26.2024.11.20.04.56.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 04:56:19 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] bitbake-worker/cooker: Increase default pipe size
Date: Wed, 20 Nov 2024 12:56:18 +0000
Message-ID: <20241120125618.2383472-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 12:56:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16818

The default pipe size is 64kb on builds, which can be inefficient
for larger log files from workers. Increase the pipe size to 512kb
since build systems have decent amounts of memory and this is a more
efficient way of batching the data.

Tweak the default read sizes to match the pipe size for efficiency.

Since the contstant is only present in python 3.10 onwards, add
some compatibility code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 11 +++++++++--
 lib/bb/runqueue.py |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index a8a9660c5f..7e3510a638 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -21,9 +21,16 @@ import traceback
 import queue
 import shlex
 import subprocess
+import fcntl
 from multiprocessing import Lock
 from threading import Thread
 
+# Remove when we have a minimum of python 3.10
+if not hasattr(fcntl, 'F_SETPIPE_SZ'):
+    import platform
+    if platform.system() == 'Linux':
+        fcntl.F_SETPIPE_SZ = 1031
+
 bb.utils.check_system_locale()
 
 # Users shouldn't be running this code directly
@@ -44,7 +51,6 @@ if sys.argv[1].startswith("decafbadbad"):
 # updates to log files for use with tail
 try:
     if sys.stdout.name == '<stdout>':
-        import fcntl
         fl = fcntl.fcntl(sys.stdout.fileno(), fcntl.F_GETFL)
         fl |= os.O_SYNC 
         fcntl.fcntl(sys.stdout.fileno(), fcntl.F_SETFL, fl)
@@ -56,6 +62,7 @@ logger = logging.getLogger("BitBake")
 
 worker_pipe = sys.stdout.fileno()
 bb.utils.nonblockingfd(worker_pipe)
+fcntl.fcntl(worker_pipe, fcntl.F_SETPIPE_SZ, 512 * 1024)
 # Need to guard against multiprocessing being used in child processes
 # and multiple processes trying to write to the parent at the same time
 worker_pipe_lock = None
@@ -357,7 +364,7 @@ class runQueueWorkerPipe():
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

