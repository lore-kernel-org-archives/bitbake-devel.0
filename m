Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4741C433EF
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 12:55:34 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web08.11216.1633611333147895983
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 05:55:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=M2icP02o;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id i12so6198638wrb.7
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Oct 2021 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Up0qXJHvvKfdvM3ooVmg8cx9dGP3+lxK2LPBaoeLaBQ=;
        b=M2icP02ojrDs4shDWKtH/9fcifS/5Gg6sCsAv+k38FTRqZujEN1qhtNVki7iAVOF/s
         1XLR/KVwAreygYaflHba7Fc4O7Sl18sGb2rHDjKVyXoOIcOKKI1yU4SrTP0P9tPC/Uiw
         1X9vN6jV5TZqT8636qLiLc489oTpVK0AeFUxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Up0qXJHvvKfdvM3ooVmg8cx9dGP3+lxK2LPBaoeLaBQ=;
        b=2w8+bPaJDBQ8uzwAtfxo28S0y00sOB9fcS/P9FZYAELrQyEd1VdyLt3cJnSDPiCXNl
         rNTL+tGah/b9U4zLMO9PPYLyXlMTpm+OAG15+hRWd0pOX+8v3rREKq59gzdjdtO+4XZm
         79dPaOOgOTFf2tY21ntS33YxclgkaPGlHZgWZE53ADR84qdIZSUxOg+dn+Q5434mCpfT
         kIuQl23XJdtRUQUHOX5t3ycPA6mRC/ZPdgHEm3BTHsmSK7f8Hhpl6FE9Wb9Z7LyeqgJv
         kyDCn1UQYAFxqsAqibseP+ogzuODHDZwKtAW7FeREPwxSuXbo1bvPssEI89/lVOFu45C
         VV3w==
X-Gm-Message-State: AOAM533okUReLvI0RIMq1RnOWIixKvr7uqNx/w09d6bAHFNzN+67CNW4
	jJmSDCpKZQMhUtBQvIhmHg/yVdxxdS6aBg==
X-Google-Smtp-Source: 
 ABdhPJxoX2CsSWJQ32JvkBgoZPJSUtoRku+V3yDyfrMXlza9ky0alJfM/P8KYEtyN6yIWwxBv3863g==
X-Received: by 2002:a1c:208:: with SMTP id 8mr16319247wmc.114.1633611331440;
        Thu, 07 Oct 2021 05:55:31 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4ef0:3e29:718c:a98a])
        by smtp.gmail.com with ESMTPSA id
 c185sm8759653wma.8.2021.10.07.05.55.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:55:31 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] knotty/uihelper: Show setscene task progress in summary
 output
Date: Thu,  7 Oct 2021 13:55:29 +0100
Message-Id: <20211007125530.2414480-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Oct 2021 12:55:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12739

With the changes to task accounting, bitbake doesn't show progress
when executing setscene tasks on the summary console output.

Change to show a progress within the setscene tasks and a progress
within the main tasks. I can't see any way to display this more easily
without confusing users.

[YOCTO #14586]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py   | 6 +++---
 lib/bb/ui/uihelper.py | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 8df745d130..484545a684 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -276,11 +276,11 @@ class TerminalFilter(object):
             print(content)
         else:
             if self.quiet:
-                content = "Running tasks (%s of %s)" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "Running tasks (%s of %s/%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             elif not len(activetasks):
-                content = "No currently running tasks (%s of %s)" % (self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "No currently running tasks (%s of %s/%s of %s)" % (self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             else:
-                content = "Currently %2s running tasks (%s of %s)" % (len(activetasks), self.helper.tasknumber_current, self.helper.tasknumber_total)
+                content = "Currently %2s running tasks (%s of %s/%s of %s)" % (len(activetasks), self.helper.setscene_current, self.helper.setscene_total, self.helper.tasknumber_current, self.helper.tasknumber_total)
             maxtask = self.helper.tasknumber_total
             if not self.main_progress or self.main_progress.maxval != maxtask:
                 widgets = [' ', progressbar.Percentage(), ' ', progressbar.Bar()]
diff --git a/lib/bb/ui/uihelper.py b/lib/bb/ui/uihelper.py
index 52fdae3fec..82913e0da8 100644
--- a/lib/bb/ui/uihelper.py
+++ b/lib/bb/ui/uihelper.py
@@ -50,8 +50,10 @@ class BBUIHelper:
             removetid(event.pid, tid)
             self.failed_tasks.append( { 'title' : "%s %s" % (event._package, event._task)})
         elif isinstance(event, bb.runqueue.runQueueTaskStarted) or isinstance(event, bb.runqueue.sceneQueueTaskStarted):
-            self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed + event.stats.setscene_active + 1
+            self.tasknumber_current = event.stats.completed + event.stats.active + event.stats.failed
             self.tasknumber_total = event.stats.total
+            self.setscene_current = event.stats.setscene_active + event.stats.setscene_covered + event.stats.setscene_notcovered
+            self.setscene_total = event.stats.setscene_total
             self.needUpdate = True
         elif isinstance(event, bb.build.TaskProgress):
             if event.pid > 0 and event.pid in self.pidmap:
-- 
2.32.0


