Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C10C4332F
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 14:15:53 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.19439.1671632146372771116
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Dec 2022 06:15:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ektT0hel;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id m14so15066097wrh.7
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 06:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjUR8wW045Dmbgzbvu2jqdBO9AgPEXWTs4vUQPlmhSM=;
        b=ektT0helOLdNMDCdjlwm507oqAfShS9m7xQpQ2PBd4jSKHqMU8sltPUPtOJiwx52CE
         65uwgOH3KRvEPV5ZLJVHtFZFapkd0R+eEXXhvduAOGf7rgqtUND7ZPITJ5n8TtL/eEJs
         Bg66phaiqIsJXImQAyVgtYz2BXdbjbdZNlzdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjUR8wW045Dmbgzbvu2jqdBO9AgPEXWTs4vUQPlmhSM=;
        b=NIIvsbEcrU6FtOr/DCZKXwwygTeL9jvhFRsLwGyFN92y2+1yx2vcXPCwqIhmwqdJce
         NtbmBaSGI5XuStwumTooJXJm7QVo3I3x4OfE23kNtBNbkMmKda5lWmdbPBRdZUq5kXWJ
         DfWs2rf1scxIIM31HrJsRM4zmVu1gMfpxDU9KPdeMZRCVKFHoeDjgqTHMR9LMk/XZtg9
         85xL/uRcmI8Yy2rUP4xiCh1r5VsNkGhP+Zs1zjH9r2LDx9Cptfpo32LhbQiI0BKUwVvB
         YtNhuAefL1zX7RkRJTDsz7UmcgTZZ/oB1JlovKOjxgUMYtW54HaEDTxTo4GnL//q2ZC9
         djdA==
X-Gm-Message-State: AFqh2kpJFwOQDJFREtmdVVyFPyotbPQuLBi+9fCHzQ3Wdukz9AjrsyN8
	c1KUp7EhwWgJU5RN3GLmhjZRKIBG0lz42gni
X-Google-Smtp-Source: AMrXdXsdrZTU/2POaO/dzRYHZ6VSDdFGuMa9VJi7ZW2LWIBL3wBF9QGHB2dFJycsPKi0yBHznHqLyQ==
X-Received: by 2002:a5d:4cd2:0:b0:242:2445:4a42 with SMTP id c18-20020a5d4cd2000000b0024224454a42mr1195957wrt.9.1671632144458;
        Wed, 21 Dec 2022 06:15:44 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e749:b020:2cdb:af31])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm17839412wro.99.2022.12.21.06.15.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:15:43 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/7] knotty: Ping the server/cooker periodically
Date: Wed, 21 Dec 2022 14:15:37 +0000
Message-Id: <20221221141543.497904-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 14:15:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14218

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


