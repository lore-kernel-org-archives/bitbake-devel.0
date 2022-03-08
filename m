Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA103C4332F
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 14:32:43 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web08.8420.1646749960887976627
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Mar 2022 06:32:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=fM9DLcpE;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646749962;
  x=1678285962;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=rOTl9gDGxfLHFpfBII7O3cy8acgTO0XfBJ5GEJnggOM=;
  b=fM9DLcpEmXTKcHu1yS+c1E6+zXcdn8+dcSIkl9NozghhtfJwJikF7K6N
   W8I3I5BiA2PGIW1vVf6z5tTJHlQ2LMpszb0IIObGebrgqh0AJTldEniGT
   yfEqjuWvRXjsmxI84p7w6ZVCMs5P4tPHGcrYkTu4uQYf4qfJ8yPbKo//I
   jnQrWEst1A5DcM9+rk2yJVBcrV3Eqyw+egT+RO+KO21190fy0OWScLIgh
   0YJjIwiNBJsYdrMtMtGibqAg/defrnLzZTocqgOONwwxeGORpKY1mYcfY
   NhwcICT7gsyxK0oueWiBV+1ppDL4pXAsFTynxibGzA16/898XJiMNoe1m
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv3 3/4] knotty.py: A little clean up of
 TerminalFilter::updateFooter()
Date: Tue, 8 Mar 2022 15:32:32 +0100
Message-ID: <20220308143233.19972-3-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220308143233.19972-1-pkj@axis.com>
References: <20220308143233.19972-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Mar 2022 14:32:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13448

* Use max() to clamp progress to >= 0.
* Be consistent when evaluating self.quiet (treat it as a boolean).

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv3: New. This was previously part of the preceding patch.

 bitbake/lib/bb/ui/knotty.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 52e6eb96fe..78888f8bdd 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -299,13 +299,11 @@ class TerminalFilter(object):
                 self.main_progress = BBProgress("Running tasks", maxtask, widgets=widgets, resize_handler=self.sigwinch_handle)
                 self.main_progress.start(False)
             self.main_progress.setmessage(msg)
-            progress = self.helper.tasknumber_current - 1
-            if progress < 0:
-                progress = 0
+            progress = max(0, self.helper.tasknumber_current - 1)
             content += self.main_progress.update(progress)
             print('')
         lines = self.getlines(content)
-        if self.quiet == 0:
+        if not self.quiet:
             for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
                 if isinstance(task, tuple):
                     pbar, progress, rate, start_time = task

