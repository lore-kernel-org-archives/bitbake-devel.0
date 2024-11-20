Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459CED63925
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 10:43:23 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.10637.1732099396566445361
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Nov 2024 02:43:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QqTi252K;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38246333e12so3299702f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 02:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732099394; x=1732704194; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWB2gMQYzMxTz/OpArbHHC+j7SQYQ9gd6ECpp5FRLLM=;
        b=QqTi252KdpwaOAPMwO+k5EOfzvetXSPL9fPzyMV2LHo/D3Xea8UzdUZ4yUftb5A0nL
         yMAmFHEiZZePnbjdtNhKPSJyME5AttJBV1fgzoSKFUTn31bshSmWb0cul1pOGFj4+gbP
         kdDgmHJsp8ICXavwJW19BUDo5SDMFhdyQNQ44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099394; x=1732704194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWB2gMQYzMxTz/OpArbHHC+j7SQYQ9gd6ECpp5FRLLM=;
        b=KlqB3DWXfbKg/bQQaDw3oBhVkGd30AKQphUaiyM69FJHrmdQEncXlvwoeVzTIbQzFs
         +/5rA2gy2rDLhCKw36UpJcoh++fFaO8gaNLBxq2lCTxnaNmkwK9escUR6Wd7rpyxIhwZ
         /fCT2mWUBqf53I89GG7w2lpFgMR2LcC2/81oegD25ckQ8J/CaYJCAEI8n3kdUKMjA9Tp
         jdugplkJWlErhzVpW91rFf48dl/ntPwQmOqNERGnMBBB/dpVHhtrUROzrmwWVHSCl9HX
         bxMwBkeHAmaHk4Uf4BPi3nH21e8wieX5RwZNkS+59m2vcrP/mwMIL5bYr/2/De+XuEN9
         wk9g==
X-Gm-Message-State: AOJu0YyeZh4fFyQ+oA6zo5cB2YxGoMRY28D9oTv41TzqNE17Dy1zidIQ
	sozM+rZXv41A9BbgiOBPIhZ92oMV+a+TAKxMnCXudImEpCM5WGlPs3y9HsqoaA71o5bL7iEZ9uH
	3xJU=
X-Google-Smtp-Source: AGHT+IG0EV9ySZckl09AFM5KVuOWdaHewCGFJz3IX28cXi6t2Yb+XxbqKpbnWldZK99XFbKRpqdoJQ==
X-Received: by 2002:a5d:588f:0:b0:382:3d04:9646 with SMTP id ffacd0b85a97d-38254ade367mr2332489f8f.11.1732099394540;
        Wed, 20 Nov 2024 02:43:14 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:6fe0:5119:2eb:57b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254910796sm1720673f8f.47.2024.11.20.02.43.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 02:43:13 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] bitbake-worker/cooker: Increase default pipe size
Date: Wed, 20 Nov 2024 10:43:11 +0000
Message-ID: <20241120104311.2365179-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241120104311.2365179-1-richard.purdie@linuxfoundation.org>
References: <20241120104311.2365179-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 10:43:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16817

The default pipe size is 64kb on builds, which can be inefficient
for larger log files from workers. Increase the pipe size to 512kb
since build systems have decent amounts of memory and this is a more
efficient way of batching the data.

Tweak the default read sizes to match the pipe size for efficiency.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 4 +++-
 lib/bb/runqueue.py | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index a8a9660c5f..af4fb0ed1b 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -21,6 +21,7 @@ import traceback
 import queue
 import shlex
 import subprocess
+import fcntl
 from multiprocessing import Lock
 from threading import Thread
 
@@ -56,6 +57,7 @@ logger = logging.getLogger("BitBake")
 
 worker_pipe = sys.stdout.fileno()
 bb.utils.nonblockingfd(worker_pipe)
+fcntl.fcntl(worker_pipe, fcntl.F_SETPIPE_SZ, 512 * 1024)
 # Need to guard against multiprocessing being used in child processes
 # and multiple processes trying to write to the parent at the same time
 worker_pipe_lock = None
@@ -357,7 +359,7 @@ class runQueueWorkerPipe():
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

