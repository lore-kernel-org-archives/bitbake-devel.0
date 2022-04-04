Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECD0C5518D
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:45 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.34150.1649074314770045297
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Apr 2022 05:11:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=IbZubFex;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1649074315;
  x=1680610315;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O8bEoJo418qcQ1nCRTGreIF5N0izP6JDdCXiwiE5xpg=;
  b=IbZubFexOexGIP7pKzOdF7so8ibzdNctbwcdAh+UMUVfRmGk0mPO7Fid
   xvTFU0LbkhuMZpdc9yn4P5po2rQGuqMftKavziPlwtzODizQrLtsxRA4i
   4xR7JN30nrXRX0Wlo5x5yeXFb/Ja7kUCcMaLW1F0Vuh1Ft3HneRnmZneM
   5s2s7XZoPRwip4p4kGnHcHl7Z2KC31Sg5Yp/lLiFLUOgchCU1KQZfTI5A
   t2a56YgNEwZi1h68JHYuvLmA8BL/wwpGDMMshYkZVum9qApe7spytJoY5
   Jr4lVWh60Ihhtq8W0vwLEg9+LI1ENWiWLwNpoaqTbRcZ9ZxLIC5liMruX
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] knotty.py: Show elapsed time also for tasks with progress
 bars
Date: Mon, 4 Apr 2022 14:11:51 +0200
Message-ID: <20220404121151.10729-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13577

While the progress bar is good at conveying information about how much
of a task has executed, the elapsed time of the task is still very
much relevant to show.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/ui/knotty.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index b2e7520ee7..3f410fd525 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -252,26 +252,26 @@ class TerminalFilter(object):
             return
         tasks = []
         for t in runningpids:
+            start_time = activetasks[t].get("starttime", None)
+            if start_time:
+                msg = "%s - %s (pid %s)" % (activetasks[t]["title"], self.elapsed(currenttime - start_time), activetasks[t]["pid"])
+            else:
+                msg = "%s (pid %s)" % (activetasks[t]["title"], activetasks[t]["pid"])
             progress = activetasks[t].get("progress", None)
             if progress is not None:
                 pbar = activetasks[t].get("progressbar", None)
                 rate = activetasks[t].get("rate", None)
-                start_time = activetasks[t].get("starttime", None)
                 if not pbar or pbar.bouncing != (progress < 0):
                     if progress < 0:
-                        pbar = BBProgress("0: %s (pid %s)" % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[' ', progressbar.BouncingSlider(), ''], extrapos=3, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s" % msg, 100, widgets=[' ', progressbar.BouncingSlider(), ''], extrapos=3, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = True
                     else:
-                        pbar = BBProgress("0: %s (pid %s)" % (activetasks[t]["title"], activetasks[t]["pid"]), 100, widgets=[' ', progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=5, resize_handler=self.sigwinch_handle)
+                        pbar = BBProgress("0: %s" % msg, 100, widgets=[' ', progressbar.Percentage(), ' ', progressbar.Bar(), ''], extrapos=5, resize_handler=self.sigwinch_handle)
                         pbar.bouncing = False
                     activetasks[t]["progressbar"] = pbar
-                tasks.append((pbar, progress, rate, start_time))
+                tasks.append((pbar, msg, progress, rate, start_time))
             else:
-                start_time = activetasks[t].get("starttime", None)
-                if start_time:
-                    tasks.append("%s - %s (pid %s)" % (activetasks[t]["title"], self.elapsed(currenttime - start_time), activetasks[t]["pid"]))
-                else:
-                    tasks.append("%s (pid %s)" % (activetasks[t]["title"], activetasks[t]["pid"]))
+                tasks.append(msg)
 
         if self.main.shutdown:
             content = pluralise("Waiting for %s running task to finish",
@@ -308,12 +308,12 @@ class TerminalFilter(object):
         if not self.quiet:
             for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
                 if isinstance(task, tuple):
-                    pbar, progress, rate, start_time = task
+                    pbar, msg, progress, rate, start_time = task
                     if not pbar.start_time:
                         pbar.start(False)
                         if start_time:
                             pbar.start_time = start_time
-                    pbar.setmessage('%s:%s' % (tasknum, pbar.msg.split(':', 1)[1]))
+                    pbar.setmessage('%s: %s' % (tasknum, msg))
                     pbar.setextra(rate)
                     if progress > -1:
                         content = pbar.update(progress)

