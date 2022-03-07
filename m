Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EEDC433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 13:36:34 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web12.26226.1646660188410132596
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 05:36:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=nARxPqF3;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646660193;
  x=1678196193;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=nrmvtvaNGfENeUret17gsR9AbA4sQ7H3dqQFGVeqAzU=;
  b=nARxPqF3gBojSNfsX4tkJyWHBZ4kOvQD02Ldk5vGWxLnylq9Mh4Lo9q9
   UBmoXNYfBCQ/dObhrc21xSX57o+xJmIp/sKvh5W0g5qDONxgis1jwrLWg
   liuv3NXgad36Yxqj9FizKfWc1Dc/UQxKmbGsDY52TH5h+u0X2QNk+bxxO
   HKelkzQ3ZJoLcfLwklVnSMQJHzaSPX5MIUuUKmyqUQw7+cZptL99N5Xpu
   CmzZorPtDpo437sH41SA6n3iLCNqqvkKO3nG50nj5unNuAxXKJelGaXkz
   BT+eZCXkHh96nuECpic7WZGOJKRkDcndqNKRKCk0siDEyJ8T+IzkOCmMa
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 3/3] knotty.py: Separate the display of main tasks from
 running tasks
Date: Mon, 7 Mar 2022 14:36:20 +0100
Message-ID: <20220307133620.12404-3-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220307133620.12404-1-pkj@axis.com>
References: <20220307133620.12404-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 13:36:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13429

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

It can be confusing that the count of running tasks shown together with
the progress bar for the main tasks also includes any running setscene
tasks.

Separate the display so that the message for the main tasks' progress
bar only includes information on the main tasks, and the display of the
count of currently running tasks gets it own line.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

This should be considered an RFC. With this change, the progress lines
for the setscene tasks and the main tasks (is that a good name for
those tasks?) look the same. The drawback is that it adds a line to
the display.

 bitbake/lib/bb/ui/knotty.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 179cea43fa..947fa73a13 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -293,10 +293,7 @@ class TerminalFilter(object):
 
             curtask = self.helper.tasknumber_current
             maxtask = self.helper.tasknumber_total
-            if not len(activetasks):
-                msg = "No running tasks (%s of %s)" % (curtask, maxtask)
-            else:
-                msg = "%2s running tasks (%s of %s)" % (len(activetasks), curtask, maxtask)
+            msg = "Main tasks (%s of %s)" % (curtask, maxtask)
             if not self.main_progress or self.main_progress.maxval != maxtask:
                 widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
                 self.main_progress = BBProgress("Running tasks", maxtask, widgets=widgets, resize_handler=self.sigwinch_handle)
@@ -307,6 +304,12 @@ class TerminalFilter(object):
             print('')
         lines = self.getlines(content)
         if not self.quiet:
+            if not len(activetasks):
+                content = "No running tasks"
+            else:
+                content = "%2s running tasks:" % len(activetasks)
+            print(content)
+            lines += self.getlines(content)
             for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
                 if isinstance(task, tuple):
                     pbar, progress, rate, start_time = task

