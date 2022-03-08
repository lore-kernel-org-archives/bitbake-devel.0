Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C490DC433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Mar 2022 11:00:53 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web12.6926.1646737247990140564
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Mar 2022 03:00:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=EXMskZCa;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646737251;
  x=1678273251;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=S7yFPh52gLni6aLQQKycrDb43VUqrf/u9QxJIdMsKBg=;
  b=EXMskZCaNfJRBcyu6Ff0ZyVKp74n+hN26ZqIgWIf7snk8FfKEuD8c9Ch
   gDCbgZh3uryHqP2/aVnL6cxSxWr+f+np4GSR1wldWVpklM7pxXdzEpCM3
   XCveC476WJvjYIlO5ENpmuxVDTDIdL2hKz3DR7kZ1i6GYArnNn5winOo9
   p9vEb6nH9/K4IR8Ka9TgKpovRLgAG2fyOelOf1GyoXtZHcXKp6yi1xWRf
   luG6/rNxJwM17a6tjT9PhoN0du0Nlo9KML0kBtJhWQYJ4xl+b/yqRma5V
   GqNHty0jliSSauSqsK3NcmR8eSl/e34DyR5yI0jw/xbXrwcrMfVGbeCcE
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCHv2 3/3] knotty.py: Unify quiet and non-quiet output for the
 running tasks
Date: Tue, 8 Mar 2022 12:00:44 +0100
Message-ID: <20220308110044.2825-3-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220308110044.2825-1-pkj@axis.com>
References: <20220308110044.2825-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Mar 2022 11:00:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13444

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

This adds the number of currently running tasks to the output in quiet
mode, and removes the word "currently" from the output for the non-quiet
output. Removing "currently" avoids having the text "jump around"
depending on whether any tasks are running or not, and it also gives a
little bit more space to the progress bar.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---

PATCHv2: New.

 bitbake/lib/bb/ui/knotty.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index 78888f8bdd..704e688f48 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -287,12 +287,11 @@ class TerminalFilter(object):
                 content += msg + "\n"
                 print(msg)
 
+            msg = "%2s running tasks" % (len(activetasks) or "No")
             if self.quiet:
-                msg = "Running tasks (%s, %s)" % (scene_tasks, cur_tasks)
-            elif not len(activetasks):
-                msg = "No currently running tasks (%s)" % cur_tasks
+                msg += " (%s, %s)" % (scene_tasks, cur_tasks)
             else:
-                msg = "Currently %2s running tasks (%s)" % (len(activetasks), cur_tasks)
+                msg += " (%s)" % cur_tasks
             maxtask = self.helper.tasknumber_total
             if not self.main_progress or self.main_progress.maxval != maxtask:
                 widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]

