Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C7CC0218B
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 03:08:57 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.34294.1737515334300278078
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 19:08:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=ydwOr52J;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.53, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee51f8c47dso8795358a91.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 19:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1737515333; x=1738120133; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H486vvnorr6bxwsZppQ2f0nzVitzKVVzE7mVytY0OYA=;
        b=ydwOr52J7wWL/WswAPl/acts1pAQWxDhihDvjmmN7lCb+NQsxfRAuGKeFNshUKxYsK
         uaVnHG6euz/guFKgzLa4+qh5fVxc/OfUKSRjupEdBJz/D+0vaJ7yZ71RRvbL9qiqJ5Y2
         xGc6HVueT+MgX5IUCRQiUay1PL+fuOl+ienkIDs3euukgWm2ACLIP9GG4d4Wdw5tF0G7
         PJ7KiWP4rzQop9ccH2FTvvyJxz7NkT9DwC4w7sUfxSFvHW4VnLPXAnZuK/ALNCMI4kvm
         7aLvAS+8nWknvzv0rlLxpZ7+UeAkOGzUspHhNGefja5X25O+6rNcICK4Y7jJxSz6IMSh
         1kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737515333; x=1738120133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H486vvnorr6bxwsZppQ2f0nzVitzKVVzE7mVytY0OYA=;
        b=uBpEXOB2ckCGxe66VeVymOdnUN5mJDZeb+3Zi4qW9LP42rhO2CmXUP5lVqDCYuO6NO
         XBs81PCesyKeKAWZXx5fJsusvGCwCW0HBVKYncc/eFhb8yDzmGqHgIjHsdbUstQGljx0
         n2kxH2oCujHq+Pm7m+NjgNNm0eHyM4ixAz6U+S1Du78ae9eZeZTfBhMNOs1976QzxgTF
         Ey83Up5CHsvfjFd6RaHtzzloidPM1DSkvnSVuk6olPDkLU2upU8+OC2Qx1ANUZ4T+x96
         NutAi6D4V6B7SzsZpzDsxFnBa+eheLAweQ4LzHc/vqoboiv+DJiZ2AiFYfPF2dIJLR1m
         38LA==
X-Gm-Message-State: AOJu0Ywb7hCQbQbrVkL5e+/Wxyr1k9l2aa7NnmnYWuG1Yr22Pkhy5p78
	XRl3X7u/RRmTEk3EUr8dBmIsHHbDxAnSPX/MtpPViu1aZ8wNQfW1jTnXBqkLnTpLksyD5JIjG6U
	s82c=
X-Gm-Gg: ASbGnctos1Ept578BHNxb2L/7BjcypvMXlnZw8arFSORlHykKxy+5Z27Wfn9QVg1gSI
	0aZkCTCUr1QGAdUZ17TK/PEtBMBqgDzyy4GalyJhFiZwmYCWclT+3AG2/EPWjnyYBmZIcIMOwsa
	Xz/A2dxyAKCRbzTaHVeIDUwvfY7uhJzAV5iCJh2XtgL8ZLhqKL7JZ1N0iEnnlAZ8sJzLqiKq753
	s0IyWCRtPq5lR6cDpSKlIEIy22juMvCtRKgJ5tEDxNq/Em0bF193urpl3s=
X-Google-Smtp-Source: AGHT+IHgjHlk35E9EYlTtgs+98GHVc0R4EWkqq7hOhFs73lfi3JhTueTenVmvMS/IcPb6eLeehaOCA==
X-Received: by 2002:a05:6a00:c8d:b0:727:3ac3:7f9c with SMTP id d2e1a72fcca58-72dafa03101mr26367633b3a.10.1737515333509;
        Tue, 21 Jan 2025 19:08:53 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab816412sm10050820b3a.66.2025.01.21.19.08.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 19:08:53 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/3] ui/knotty: print log paths for failed tasks in summary
Date: Tue, 21 Jan 2025 19:08:44 -0800
Message-ID: <9c020cc314bfd0702bb1d457d94925c6e9613268.1737515198.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737515198.git.steve@sakoman.com>
References: <cover.1737515198.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 03:08:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17053

From: Chris Laplante <chris.laplante@agilent.com>

When tasks fail, it's very frustrating to have to scroll up to find the
log path(s). Many of us have the muscle memory to navigate to the 'temp'
directories under tmp/work/, but new users do not.

This change enhances the final summary to include log paths (reported
via bb.build.TaskFailed events). Here's an example:

NOTE: Tasks Summary: Attempted 856 tasks of which 853 didn't need to be rerun and 3 failed.

Summary: 3 tasks failed:
  virtual:native:/home/chris/repos/poky/meta/recipes-core/ncurses/ncurses_6.5.bb:do_fetch
    log: /home/chris/repos/poky/build/tmp/work/x86_64-linux/ncurses-native/6.5/temp/log.do_fetch.1253462
  /home/chris/repos/poky/meta/recipes-core/ncurses/ncurses_6.5.bb:do_fetch
    log: /home/chris/repos/poky/build/tmp/work/core2-64-poky-linux/ncurses/6.5/temp/log.do_fetch.1253466
  virtual:nativesdk:/home/chris/repos/poky/meta/recipes-core/ncurses/ncurses_6.5.bb:do_fetch
    log: /home/chris/repos/poky/build/tmp/work/x86_64-nativesdk-pokysdk-linux/nativesdk-ncurses/6.5/temp/log.do_fetch.1253467
Summary: There were 3 WARNING messages.
Summary: There were 6 ERROR messages, returning a non-zero exit code.

Each log is rendered as a clickable hyperlink in the terminal. See
https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/knotty.py | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index f86999bb0..5956ab177 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -640,7 +640,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     return_value = 0
     errors = 0
     warnings = 0
-    taskfailures = []
+    taskfailures = {}
 
     printintervaldelta = 10 * 60 # 10 minutes
     printinterval = printintervaldelta
@@ -726,6 +726,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
             if isinstance(event, bb.build.TaskFailed):
                 return_value = 1
                 print_event_log(event, includelogs, loglines, termfilter)
+                k = "{}:{}".format(event._fn, event._task)
+                taskfailures[k] = event.logfile
             if isinstance(event, bb.build.TaskBase):
                 logger.info(event._message)
                 continue
@@ -821,7 +823,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
             if isinstance(event, bb.runqueue.runQueueTaskFailed):
                 return_value = 1
-                taskfailures.append(event.taskstring)
+                taskfailures.setdefault(event.taskstring)
                 logger.error(str(event))
                 continue
 
@@ -942,11 +944,19 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     try:
         termfilter.clearFooter()
         summary = ""
+        def print_hyperlink(url, link_text):
+            start = f'\033]8;;{url}\033\\'
+            end = '\033]8;;\033\\'
+            return f'{start}{link_text}{end}'
+
         if taskfailures:
             summary += pluralise("\nSummary: %s task failed:",
                                  "\nSummary: %s tasks failed:", len(taskfailures))
-            for failure in taskfailures:
+            for (failure, log_file) in taskfailures.items():
                 summary += "\n  %s" % failure
+                if log_file:
+                    hyperlink = print_hyperlink(f"file://{log_file}", log_file)
+                    summary += "\n    log: {}".format(hyperlink)
         if warnings:
             summary += pluralise("\nSummary: There was %s WARNING message.",
                                  "\nSummary: There were %s WARNING messages.", warnings)
-- 
2.43.0


