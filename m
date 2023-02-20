Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1C0C6379F
	for <webhook@archiver.kernel.org>; Mon, 20 Feb 2023 10:07:39 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.9645.1676887656981919558
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Feb 2023 02:07:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cDi4rGjK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id bg25-20020a05600c3c9900b003e21af96703so1445275wmb.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 02:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1csesZzkBOgfihmSTGYOduc52rK0z4I5tHsv77RwXX4=;
        b=cDi4rGjKAkZy+gKeCmEguK3OLl+GUUfexeMC9pBZ68ww2mSEHuaMWJaBsOjhjlsDvY
         2rcraJkfG4tUuv5JdMih25nImhm+yaJKM3M8Ql/ilfGAJLGXUvxvfKEW9PNsXB7KG8rx
         kAP1TKdUL8fjknxy9B2/OuPStgwWI6rOeKZ3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1csesZzkBOgfihmSTGYOduc52rK0z4I5tHsv77RwXX4=;
        b=p8FA4diS1kvbY/2lkJcFaRjwj2GqvNDOGJeQYVRj5bPMFFNNlxC1WvrAvuqymmzzxL
         iQCgT9H2nGApoe5qHZ6n4e6QJcBCD8sjx944lFlMpd6pvgS5kiQnhs4hOokwJ3ylO7p0
         4M3Az0RWgVcWzUW4HiKhTapbtKTyORFK9biAb86VRbTCY8bhmSSQ1ePara9Q9jIKJZcH
         Bkpz5kYUopwfQFgAcuqr1PEzGqu+UHH6Tberzhf5tygQor/MM1xJ+AZiKle6DRl/l5WU
         xcIlFQkbL+ujiu91/uedkKSOZNxESK+a2IaZFkHuHRHMZFZx9vJXJe4M9uptZJPneZBO
         jTTg==
X-Gm-Message-State: AO0yUKU+sgYGFQM03L+f+SNp5GWoOX34iZ7dKKJN4RIz/Kn95cZSx6Iq
	UHQHg8rlRzSJKQxtlZLfoPUtMsWpGwEqhw8w
X-Google-Smtp-Source: AK7set+0zswpxsVzAbSkl7QXWefYPi12rA23OrcHFA53yh0ViZ0aSgvxpameDo4I1j1p9x1j/bsgQw==
X-Received: by 2002:a05:600c:198e:b0:3df:9858:c037 with SMTP id t14-20020a05600c198e00b003df9858c037mr183266wmq.12.1676887654766;
        Mon, 20 Feb 2023 02:07:34 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3445:b505:b26e:ead9])
        by smtp.gmail.com with ESMTPSA id r5-20020a1c2b05000000b003ddf2865aeasm554544wmr.41.2023.02.20.02.07.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 02:07:34 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker: Ensure lock is held with changing notifier
Date: Mon, 20 Feb 2023 10:07:32 +0000
Message-Id: <20230220100733.453039-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 10:07:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14465

We've seen a couple of cases which bitbake hangs due to an inotifer exception
such as:

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

Ensure we don't destory the inotifier when the idle thread is reading is
by holding the lock during setup/teardown.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c5e9fa2941..b673fe10ee 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -229,24 +229,26 @@ class BBCooker:
             self.handlePRServ()
 
     def setupConfigWatcher(self):
-        if self.configwatcher:
-            self.configwatcher.close()
-            self.confignotifier = None
-            self.configwatcher = None
-        self.configwatcher = pyinotify.WatchManager()
-        self.configwatcher.bbseen = set()
-        self.configwatcher.bbwatchedfiles = set()
-        self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
+        with bb.utils.lock_timeout(self.inotify_threadlock):
+            if self.configwatcher:
+                self.configwatcher.close()
+                self.confignotifier = None
+                self.configwatcher = None
+            self.configwatcher = pyinotify.WatchManager()
+            self.configwatcher.bbseen = set()
+            self.configwatcher.bbwatchedfiles = set()
+            self.confignotifier = pyinotify.Notifier(self.configwatcher, self.config_notifications)
 
     def setupParserWatcher(self):
-        if self.watcher:
-            self.watcher.close()
-            self.notifier = None
-            self.watcher = None
-        self.watcher = pyinotify.WatchManager()
-        self.watcher.bbseen = set()
-        self.watcher.bbwatchedfiles = set()
-        self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
+        with bb.utils.lock_timeout(self.inotify_threadlock):
+            if self.watcher:
+                self.watcher.close()
+                self.notifier = None
+                self.watcher = None
+            self.watcher = pyinotify.WatchManager()
+            self.watcher.bbseen = set()
+            self.watcher.bbwatchedfiles = set()
+            self.notifier = pyinotify.Notifier(self.watcher, self.notifications)
 
     def process_inotify_updates(self):
         with bb.utils.lock_timeout(self.inotify_threadlock):
-- 
2.37.2


