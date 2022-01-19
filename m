Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B6DC433EF
	for <webhook@archiver.kernel.org>; Wed, 19 Jan 2022 17:43:49 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.1073.1642614228696110973
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 09:43:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YTtjfQ2Y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id w26so6744037wmi.0
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 09:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vY4mDVeIo+R5RP3BZeX42T1dvuEZ2l5z39sXf79Rc9g=;
        b=YTtjfQ2YzS3DSfhSXt21VHDXx9s1vJgoggJ/tfEeaULho4ksy9KV0n05w7D+en+uKb
         zMp2Mw0O/0/k7XervNw4fuX73Jz5GiuXCDQWHtIa7upRiTdq1u0NXvWyJwSeHqC0O5+x
         z83ohuKAVZ5Ea55ClfbyVOBHl+4AUGub1sNTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vY4mDVeIo+R5RP3BZeX42T1dvuEZ2l5z39sXf79Rc9g=;
        b=WOEPvAdNqNo7lJJ+WHuodWz8gJpDT9kOVoi9UWHSq6y4/dhn7dLnv0DMeDVq3vfLxY
         SHUPNnHnEfdstMJZDFTQIlg8s5wIP6aZDpPVxWMpNYYuoJhxY7PldetbKVFQ05xlNhiu
         M7aDBI5txaQVHNoZlqzAeBhiqioMGOF8JpwD6vsBydcK7PpdvYDwmvyRnVusQBUJV/oU
         B/r4EZp2gdxuzDhAa+mJTuLvbq6oVHSYkHEnuPS/3LJApCwYeka3Yv4a7JH/hEc2TgRG
         zhrSBHqpV5/8+Txn4Pghw+mb0Q7YCEPV37VyUj4lcDpJeT6Cf6luiFxtx3v3yFu/1EaJ
         pDjQ==
X-Gm-Message-State: AOAM532qlG+nu3OYa6cePdLuJUgH1o1nIfDHcFzgA/592vMhpMpwC+cf
	U1xp67AeOQBke1b//DN3/hRGLVJR5TX0JQ==
X-Google-Smtp-Source: 
 ABdhPJzz+1/O4DMH0WaBScSfsXPJA3wcskZWGGs/WB3QDpnH8C79QTeEj75mBFi1t01PaG37endkSQ==
X-Received: by 2002:a05:600c:4e8a:: with SMTP id
 f10mr4638117wmq.195.1642614226808;
        Wed, 19 Jan 2022 09:43:46 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:4e1a:65bf:4ced:cc2d])
        by smtp.gmail.com with ESMTPSA id y8sm824889wrd.8.2022.01.19.09.43.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 09:43:46 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] build: Tweak exception handling for setscene tasks
Date: Wed, 19 Jan 2022 17:43:45 +0000
Message-Id: <20220119174345.1931067-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 17:43:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13246

If an unexpected exception occurs in a setscene task, it is currently hidden
from the user and not recorded in any logs. This isn't helpful to debug
such failures.

Change the code so that even in the "silent" or "quiet" task case (setscene
tasks), a warning is shown with the traceback unless it was an "handled"
exception. This means the failing function can show it's own warning/error
instead if it wants to and then raise a handled event.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/build.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/bb/build.py b/lib/bb/build.py
index d6418e40b3..65b7fc000d 100644
--- a/lib/bb/build.py
+++ b/lib/bb/build.py
@@ -714,19 +714,23 @@ def _exec_task(fn, task, d, quieterr):
                 logger.debug2("Zero size logfn %s, removing", logfn)
                 bb.utils.remove(logfn)
                 bb.utils.remove(loglink)
-    except bb.BBHandledException:
-        event.fire(TaskFailed(task, fn, logfn, localdata, True), localdata)
-        return 1
     except (Exception, SystemExit) as exc:
+        handled = False
+        if isinstance(exc, bb.BBHandledException):
+            handled = True
+
         if quieterr:
+            if not handled:
+                logger.warning(repr(exc))
             event.fire(TaskFailedSilent(task, fn, logfn, localdata), localdata)
         else:
             errprinted = errchk.triggered
             # If the output is already on stdout, we've printed the information in the
             # logs once already so don't duplicate
-            if verboseStdoutLogging:
+            if verboseStdoutLogging or handled:
                 errprinted = True
-            logger.error(repr(exc))
+            if not handled:
+                logger.error(repr(exc))
             event.fire(TaskFailed(task, fn, logfn, localdata, errprinted), localdata)
         return 1
 
-- 
2.32.0


