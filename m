Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0A0C05027
	for <webhook@archiver.kernel.org>; Mon, 20 Feb 2023 10:07:39 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.9414.1676887657010137697
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Feb 2023 02:07:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hO/HK+m8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id l6so476905wms.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 02:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGkryUyUduYh3cIdYQhfCeIJTolAndTMVJWiYxwxJ+w=;
        b=hO/HK+m8bu6QIFfyDNpSLwjK1F/2aaTtkRF5zqO3AHgzILxALOgg9Wb3Te8On7ZvIJ
         M8HCbr9bcyvrz2xXXWvIqgCl3TqSTpcqrQK0p1FMEKVmjxzUNJGtZf+xM8vUW/dTkWlk
         y7ViHYeaLxfx+XkLvRy6XzCJDCQMQmCPEqLDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGkryUyUduYh3cIdYQhfCeIJTolAndTMVJWiYxwxJ+w=;
        b=UBbwmHW2/b95Z/lrMcTXd8vGDfkFRunzSruQLaj74BB6C+QgSYvuYlrWqGVdR8XMGT
         zBkfGmOy6x+P4tdEpD9Jl4OHPrKcP09Sf5j98Ui9Q5Tth9GlwFfqXpXoc09tTIOXGrD5
         6BnWL7HctCJz8TPy6v7mSe9q9RYTP7sIk1ZPKoMcY75mMr3U+Qz+uvVX6KhztL/X8Oxe
         IfOt4AVRC2acTOeO8iabCkJv9bzaejxlkfUXiUCqZYz+Hj7g7aIi2uy1cZMr9YlYr3An
         oFLSJKWArJzq23468MwEYPi5VJ7ZEv1kbYlFfpfbYRG4UjE/xacrPQY6pb2OQckPMzgT
         9oyQ==
X-Gm-Message-State: AO0yUKXugaMx+VDDfydIT3jssCWjqTkbAV10Rb7MnZH46lYaqASWpQbQ
	HrB+alkDrKDdRUcio4gbGvX77BMhbSKI9kip
X-Google-Smtp-Source: AK7set+XxpzKITRjPl282B5nmZ0YLFwGVDWxY4HgRMAf602EdfL1o/skhNx9ezRf6BW2aHmm8vpDng==
X-Received: by 2002:a05:600c:4929:b0:3e2:1f63:4beb with SMTP id f41-20020a05600c492900b003e21f634bebmr561693wmp.19.1676887655249;
        Mon, 20 Feb 2023 02:07:35 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3445:b505:b26e:ead9])
        by smtp.gmail.com with ESMTPSA id r5-20020a1c2b05000000b003ddf2865aeasm554544wmr.41.2023.02.20.02.07.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 02:07:35 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] server/process: Improve idle thread exception handling
Date: Mon, 20 Feb 2023 10:07:33 +0000
Message-Id: <20230220100733.453039-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230220100733.453039-1-richard.purdie@linuxfoundation.org>
References: <20230220100733.453039-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 10:07:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14466

If the inotifier code has an exception, bitbake currently hangs. Catch any
exception and exit if seen. Also check the idle thread is alive and exit
if it disappears. This should stop bitbake hanging if such a situation arises
in future such as this example:

3323260 21:48:31.554468 Running command ['getVariable', 'BBINCLUDELOGS']
Exception in thread Thread-1 (idle_thread):
Traceback (most recent call last):
  File "/usr/lib64/python3.10/threading.py", line 1016, in _bootstrap_inner
    self.run()
  File "/usr/lib64/python3.10/threading.py", line 953, in run
    self._target(*self._args, **self._kwargs)
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/server/process.py", line 408, in idle_thread
    self.cooker.process_inotify_updates()
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/bb/cooker.py", line 256, in process_inotify_updates
    n.read_events()
  File "/home/pokybuild/yocto-worker/oe-selftest-fedora/build/bitbake/lib/pyinotify.py", line 1207, in read_events
    if fcntl.ioctl(self._fd, termios.FIONREAD, buf_, 1) == -1:
OSError: [Errno 9] Bad file descriptor
3323260 21:48:32.206995 Command Completed (socket: True)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 916ee0a0e5..db417c8428 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -405,7 +405,11 @@ class ProcessServer():
             nextsleep = 0.1
             fds = []
 
-            self.cooker.process_inotify_updates()
+            try:
+                self.cooker.process_inotify_updates()
+            except Exception as exc:
+                serverlog("Exception %s in inofify updates broke the idle_thread, exiting" % traceback.format_exc())
+                self.quit = True
 
             with bb.utils.lock_timeout(self._idlefuncsLock):
                 items = list(self._idlefuns.items())
@@ -473,6 +477,10 @@ class ProcessServer():
         if not self.idle:
             self.idle = threading.Thread(target=self.idle_thread)
             self.idle.start()
+        elif self.idle and not self.idle.is_alive():
+            serverlog("Idle thread terminated, main thread exiting too")
+            bb.error("Idle thread terminated, main thread exiting too")
+            self.quit = True
 
         if nextsleep is not None:
             if self.xmlrpc:
-- 
2.37.2


