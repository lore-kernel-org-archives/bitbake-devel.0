Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC247C433F5
	for <webhook@archiver.kernel.org>; Sun,  6 Mar 2022 13:35:30 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web08.15308.1646573729553261088
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Mar 2022 05:35:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=h+5LfUse;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id n15so5281332wra.6
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 06 Mar 2022 05:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbDWCFrDavQB68/TrAXuc8QvNq2QuJ+4u1/X3FCGKUg=;
        b=h+5LfUseAa0Ne7MyBlF0QJzngpEuxYBSV1sDdcOC6UhyMFYHAPLFYaHw6ziPv8RncE
         RMFxXtsGZihrreUaCtrSVjqoJYpyBFDpXTmucS/w0Q2Zwiu004ENFZY3whInPUTuzPyD
         PUTsHzWdAmdp+KQLx2+OMpMXgYbCTa0CyVibQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbDWCFrDavQB68/TrAXuc8QvNq2QuJ+4u1/X3FCGKUg=;
        b=cZPlnDqzbaLq0R+yMKK8UUkxpfQ/M0sAXD+3kEIliqP0lq+dXYHkVX8c7Is8KA3pnd
         viFLqM+9OUftm2skJMeh3zgh8dVgeQSqojcizqquTbHzmXE2XeVf2qpgtI2liCEPmUk7
         PqrIMGWKZRlGjwbz6vUPn/SuFogCfkUSbpQufU0P7DMqAymqJLsS/O0f+8KnlXoOmIs0
         mqmXinUUhAMXfQBbSLmBLNNhEx85hCu3Xgs1pyTK/qi5+wyvCNhjw7ue/d76KR6Rk2Ku
         wj98Xfe29EwqoQ5JnxiZ8b/3CX8ecm29jRjZiFWZcVRQGU2TTOWXnsHnJXq5+JBJ3bIz
         VA5A==
X-Gm-Message-State: AOAM530G4tPyuJ5KDTZ2wFKG9lqshU4uck2JVVTQVQi09bgnTrheGV0Z
	rp5cl8uzT/BFFqa+7DsuFNFUFnyRT8lFMohG
X-Google-Smtp-Source: 
 ABdhPJx8JO15goUafWj8/Jz1pqj7sQk+mG+6Z4OueXO+kPR4KEEd8zuhbrjnGqLIzG7d7rzh/cptDg==
X-Received: by 2002:a5d:56cd:0:b0:1ee:3248:525b with SMTP id
 m13-20020a5d56cd000000b001ee3248525bmr5025443wrw.124.1646573727702;
        Sun, 06 Mar 2022 05:35:27 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:455b:9320:b5a2:495a])
        by smtp.gmail.com with ESMTPSA id
 i9-20020adffdc9000000b001f046861795sm8734890wrs.19.2022.03.06.05.35.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 05:35:27 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] knotty: Correctly handle multiple line items
Date: Sun,  6 Mar 2022 13:35:25 +0000
Message-Id: <20220306133526.442843-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 06 Mar 2022 13:35:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13416

Currently the footer code doesn't quite handle multiline items correct.
Fix this to do so.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 528b8a0760..1bcdc0023a 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -292,9 +292,9 @@ class TerminalFilter(object):
                 progress = 0
             content = self.main_progress.update(progress)
             print('')
-        lines = 1 + int(len(content) / (self.columns + 1))
+        lines = self.getlines(content)
         if self.quiet == 0:
-            for tasknum, task in enumerate(tasks[:(self.rows - 2)]):
+            for tasknum, task in enumerate(tasks[:(self.rows - 1 - lines)]):
                 if isinstance(task, tuple):
                     pbar, progress, rate, start_time = task
                     if not pbar.start_time:
@@ -311,11 +311,17 @@ class TerminalFilter(object):
                 else:
                     content = "%s: %s" % (tasknum, task)
                     print(content)
-                lines = lines + 1 + int(len(content) / (self.columns + 1))
+                lines = lines + self.getlines(content)
         self.footer_present = lines
         self.lastpids = runningpids[:]
         self.lastcount = self.helper.tasknumber_current
 
+    def getlines(self, content):
+        lines = 0
+        for line in content.split("\n"):
+            lines = lines + 1 + int(len(line) / (self.columns + 1))
+        return lines
+
     def finish(self):
         if self.stdinbackup:
             fd = sys.stdin.fileno()
-- 
2.32.0


