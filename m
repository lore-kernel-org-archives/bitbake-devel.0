Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A305C46467
	for <webhook@archiver.kernel.org>; Thu, 22 Dec 2022 23:47:34 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.60900.1671752850177943149
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Dec 2022 15:47:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BrgdUntP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso5047511wms.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 15:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjUR8wW045Dmbgzbvu2jqdBO9AgPEXWTs4vUQPlmhSM=;
        b=BrgdUntPSG4nmPkQLFhLvC7LW6I+FpfgpThlVc4aT0Lo7dnrlT2Uxefe+iG08xJqmf
         dPLH3WCmN2DrXKccjSqEs77V7NTBpSaKFXszzJ0ytZl3CdnONKWs/h1TF36lf/jzGXwa
         edrajH/0nOqpM2sYxBArc66ZwyjR6vYzGCrm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjUR8wW045Dmbgzbvu2jqdBO9AgPEXWTs4vUQPlmhSM=;
        b=MOtCRafGkjvUOTRCC5c7jT0QwRfayjj61jlGGZsqgsch0r+pVNrcJjsNXF/ZqQvb9x
         6nqZKl27JfFBI4AFvuVJJ0/AJXPxIW2RhNxoIfEC3Qk4RlDGQrtzfTjf9342s8XnRp1z
         UF2Ov1kLwingtkVjO/jh6hKNk3O4TVjPE89ILyUYWNkLVgGv/97mCutFP4QYN5LbA8LS
         c35u0oUDdxcvUbFoaPt653j7xMdRmJnAlYKA86j4Lm8HlzTQhwRd8krIy359NRUfAqw0
         YHVCAsuvTYekXWeNMjf46Pidoc0IgtXjMTWop4pDzQOFAgSRqx9ImKTRzIjqBdVDU5My
         ib2g==
X-Gm-Message-State: AFqh2kqyEd5G3vtLS+NgBg5sHGDmf8FDBC2JVQCHNNFJwMKy9rXWOUZu
	YPV1L/4ZzrL55Pfu2wtQjMPOfFvPYAGzW38d
X-Google-Smtp-Source: AMrXdXvSzknU4A988DZ0PpI6oXtpE+KXQcSO3rgnNM6US+NzePebuZwy1uSdEyXlZE5nj8ee0vNNhA==
X-Received: by 2002:a05:600c:600a:b0:3d1:ed41:57c0 with SMTP id az10-20020a05600c600a00b003d1ed4157c0mr8406933wmb.30.1671752847802;
        Thu, 22 Dec 2022 15:47:27 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bc21:fec7:83cf:e0c3])
        by smtp.gmail.com with ESMTPSA id bd25-20020a05600c1f1900b003cfd4cf0761sm7322189wmb.1.2022.12.22.15.47.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 15:47:27 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 01/10] knotty: Ping the server/cooker periodically
Date: Thu, 22 Dec 2022 23:47:17 +0000
Message-Id: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 23:47:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14231

We've seeing failures where the UI hangs if the server disappears. Ping
the cooker/server if we've not had any events in the last minute so we can
check if it is still alive.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 61cf0a37f4..ab1a367be0 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -625,7 +625,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
     printintervaldelta = 10 * 60 # 10 minutes
     printinterval = printintervaldelta
-    lastprint = time.time()
+    pinginterval = 1 * 60 # 1 minutes
+    lastevent = lastprint = time.time()
 
     termfilter = tf(main, helper, console_handlers, params.options.quiet)
     atexit.register(termfilter.finish)
@@ -637,6 +638,14 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 printinterval += printintervaldelta
             event = eventHandler.waitEvent(0)
             if event is None:
+                if (lastevent + pinginterval) <= time.time():
+                    ret, error = server.runCommand(["ping"])
+                    if error or not ret:
+                        termfilter.clearFooter()
+                        print("No reply after pinging server (%s, %s), exiting." % (str(error), str(ret)))
+                        return_value = 3
+                        main.shutdown = 2
+                    lastevent = time.time()
                 if main.shutdown > 1:
                     break
                 if not parseprogress:
@@ -644,6 +653,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 event = eventHandler.waitEvent(0.25)
                 if event is None:
                     continue
+            lastevent = time.time()
             helper.eventHandler(event)
             if isinstance(event, bb.runqueue.runQueueExitWait):
                 if not main.shutdown:
-- 
2.37.2


