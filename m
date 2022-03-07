Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AC5C433EF
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 13:36:38 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web09.26325.1646660195768683597
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 05:36:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=TgVNMTxc;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646660196;
  x=1678196196;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+b4suqMsAQ5cvD+EWNHlKRVOvDWs0Iol8+IPYr377Yw=;
  b=TgVNMTxc6q+k95k/O0nShLQLYKUMaJ/xF5u7r+UBU5TF2q0QqfRdBznE
   JjBmgfHZ1e5io3ZpAraTEKV4CKz0dye3TMkJLQX7wccrGihzJ79U/TAVz
   /FDHMp8NpzJgwk0pCp+/ydkDDH7apHMugC/9jvZmEtZaSMDUu2t7OJ2eY
   Geq7dRT+gdUvNyQCHKuxKGoUNhdOj/5YUdnbj+/JJO1/pF+2syn1YXkYe
   hh458vNoLIkdE76buzQI2EO0t1Z8KnH3uYzFg3O7BxRADnWZHH+5ET+R4
   GphY+G6fVcJHeH5TWJTx9hyYCuhpm5hrGRFyvk1WTutTG4b3StCpO6DzV
   Q==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/3] knotty.py: Give the setscene tasks their own progress bar
Date: Mon, 7 Mar 2022 14:36:19 +0100
Message-ID: <20220307133620.12404-2-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220307133620.12404-1-pkj@axis.com>
References: <20220307133620.12404-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 13:36:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13430

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

In commit 8055ec36 (knotty: Improve setscene task display) the setscene
tasks got their own line in the task output. However, the progress bar
code does not handle newlines in its widgets, so the length of the
setscene line was included when calculating how much space is available
for the progress bar of the running tasks, making it much too short.

Instead of trying to teach the progress bar code to handle newlines,
give the setscene tasks their own progress bar.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/ui/knotty.py | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index a520895da2..179cea43fa 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -204,6 +204,7 @@ class TerminalFilter(object):
         for h in handlers:
             h.addFilter(InteractConsoleLogFilter(self))
 
+        self.setscene_progress = None
         self.main_progress = None
 
     def clearFooter(self):
@@ -278,25 +279,34 @@ class TerminalFilter(object):
                 content += ':'
             print(content)
         else:
-            if self.quiet:
-                content = "Running tasks (%s of %s, %s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
-            elif not len(activetasks):
-                content = "Setscene tasks: %s of %s\nNo currently running tasks (%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
-            else:
-                content = "Setscene tasks: %s of %s\nCurrently %2s running tasks (%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
+            content = ''
+            curtask = self.helper.setscene_current
+            maxtask = self.helper.setscene_total
+            msg = "Setscene tasks (%s of %s)" % (curtask, maxtask)
+            if not self.setscene_progress or self.setscene_progress.maxval != maxtask:
+                widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
+                self.setscene_progress = BBProgress("Setscene tasks", maxtask, widgets=widgets, resize_handler=self.sigwinch_handle)
+                self.setscene_progress.start(False)
+            self.setscene_progress.setmessage(msg)
+            content += self.setscene_progress.update(curtask) + "\n"
+            print('')
+
+            curtask = self.helper.tasknumber_current
             maxtask = self.helper.tasknumber_total
+            if not len(activetasks):
+                msg = "No running tasks (%s of %s)" % (curtask, maxtask)
+            else:
+                msg = "%2s running tasks (%s of %s)" % (len(activetasks), curtask, maxtask)
             if not self.main_progress or self.main_progress.maxval != maxtask:
                 widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
                 self.main_progress = BBProgress("Running tasks", maxtask, widgets=widgets, resize_handler=self.sigwinch_handle)
                 self.main_progress.start(False)
-            self.main_progress.setmessage(content)
-            progress = self.helper.tasknumber_current - 1
-            if progress < 0:
-                progress = 0
-            content = self.main_progress.update(progress)
+            self.main_progress.setmessage(msg)
+            progress = max(0, curtask - 1)
+            content += self.main_progress.update(progress)
             print('')
         lines = self.getlines(content)
-        if self.quiet == 0:
+        if not self.quiet:
             for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
                 if isinstance(task, tuple):
                     pbar, progress, rate, start_time = task

