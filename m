Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA145C433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 11:00:55 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.6959.1646737252645540735
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Mar 2022 03:00:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com
 header.s=axis-central1 header.b=Q/nu7Upp;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646737253;
  x=1678273253;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=cXPy+/5/zeLHg59ZyeQJZxOmocpPE4UnEW0A6O05AHE=;
  b=Q/nu7UppBNaOc5yfyRTCHqKuPtqhEJQ1JgmFFWyVFdN5r4P70gi1uW9O
   lrKgJVP6B13Mx+3RM8HnazRtGSAo6KIsB4Nr7m+ZyZNTDtyxRF/23fnSe
   LLDhr+qEKBcZhI7a/xZQZZLBJfBMtZrE+jFWkoIdzov7MqcTtG1jvUpwv
   ZcjThXXDr2gNknqfC20ltFoD3u9m1MqK4RWM8BSiglE8P0QOaLV08Zt2L
   VULq3NnOQqx1L4PlFPaWFijZplmSa+ywJHDk/wE84MX3ohkE43mo0HkRE
   slWI9K8L0u+ltI6EpU+Xc5tl1EIqGEHjqjPt1LWhBuXnIfC0KWlhKAzv1
   Q==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 2/3] knotty.py: Correct the width of the progress bar for
 the real tasks
Date: Tue, 8 Mar 2022 12:00:43 +0100
Message-ID: <20220308110044.2825-2-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220308110044.2825-1-pkj@axis.com>
References: <20220308110044.2825-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Mar 2022 11:00:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13445

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

In commit 8055ec36 (knotty: Improve setscene task display) the setscene
tasks got their own line in the task output. However, the progress bar
code does not handle newlines in its widgets, so the length of the
setscene line was included when calculating how much space is available
for the progress bar of the running tasks, making it much too short.

Instead of trying to teach the progress bar code to handle newlines,
separate the output of the setscene tasks from the progress bar for the
real tasks.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: Corrected so that there are no changes to the output except
         that the progress bar now fills the width of the terminal as
         expected.

 bitbake/lib/bb/ui/knotty.py | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index a520895da2..78888f8bdd 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -278,25 +278,32 @@ class TerminalFilter(object):
                 content += ':'
             print(content)
         else:
+            scene_tasks = "%s of %s" % (self.helper.setscene_current, self.helper.setscene_total)
+            cur_tasks = "%s of %s" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
+
+            content = ''
+            if not self.quiet:
+                msg = "Setscene tasks: %s" % scene_tasks
+                content += msg + "\n"
+                print(msg)
+
             if self.quiet:
-                content = "Running tasks (%s of %s, %s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
+                msg = "Running tasks (%s, %s)" % (scene_tasks, cur_tasks)
             elif not len(activetasks):
-                content = "Setscene tasks: %s of %s\nNo currently running tasks (%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
+                msg = "No currently running tasks (%s)" % cur_tasks
             else:
-                content = "Setscene tasks: %s of %s\nCurrently %2s running tasks (%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
+                msg = "Currently %2s running tasks (%s)" % (len(activetasks), cur_tasks)
             maxtask = self.helper.tasknumber_total
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
+            progress = max(0, self.helper.tasknumber_current - 1)
+            content += self.main_progress.update(progress)
             print('')
         lines = self.getlines(content)
-        if self.quiet == 0:
+        if not self.quiet:
             for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
                 if isinstance(task, tuple):
                     pbar, progress, rate, start_time = task

