Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DD9C433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 14:32:42 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web08.8419.1646749960625333848
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Mar 2022 06:32:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=fW+a25An;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646749961;
  x=1678285961;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=2xHyDblHchN+kgMolHNPDvNUkpBvoVGgxVqxKdDDt0I=;
  b=fW+a25AnRsN3yQp3YJyB754CIUdJBFK7OdNguuUBmO7VfPotPXpnxWFS
   AP6X+guJD7WvPp+Rea/nzWq2MaFXvh13u5AgyRQyiS5+7tQmxi3xBI0GK
   2vF4RtoOXQQ64t5G9nmuOugx67Ze7gTeuzl4HonUHNsWwYUpyfWvld1C7
   beT0LjsgLlYIArcMgA+9IDfwTXrd8+D8w/vK6E37LULFkinbjOwqI7L5J
   o1g2xBdXnUM432r5Sz3c23yTEgh79BsUdPvLX/0ajS8ekAJdz2E4AuP/K
   K1dLIxwGMiWLaebD6eX1+58eFHQd74/OiSXRPGs+3Tp3uaYp0/m2OLdZ/
   Q==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv3 2/4] knotty.py: Correct the width of the progress bar for
 the real tasks
Date: Tue, 8 Mar 2022 15:32:31 +0100
Message-ID: <20220308143233.19972-2-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220308143233.19972-1-pkj@axis.com>
References: <20220308143233.19972-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Mar 2022 14:32:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13447

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
PATCHv3: Extracted two minor code clean ups to a separate patch.

 bitbake/lib/bb/ui/knotty.py | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index a520895da2..52e6eb96fe 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -278,22 +278,31 @@ class TerminalFilter(object):
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
+            self.main_progress.setmessage(msg)
             progress = self.helper.tasknumber_current - 1
             if progress < 0:
                 progress = 0
-            content = self.main_progress.update(progress)
+            content += self.main_progress.update(progress)
             print('')
         lines = self.getlines(content)
         if self.quiet == 0:

