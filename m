Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253CBC3DA7A
	for <webhook@archiver.kernel.org>; Tue, 20 Dec 2022 15:16:14 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.52655.1671549367456309891
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Dec 2022 07:16:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LB0Q0SSZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id h11so11998441wrw.13
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 07:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjUR8wW045Dmbgzbvu2jqdBO9AgPEXWTs4vUQPlmhSM=;
        b=LB0Q0SSZIxOTtCOF8k/6VGrReA0FQTCD4zzClpIMAKHrmjVTnMO8PeVS9x35y7dbP3
         ziZHL6Lt/OnEgY2SZahfKTwSesMcXJoBLdSmrU8dW++t5oWKQEL9Fbv0C6cp6P7H+ch8
         SOCzSddXGu+6AQiVneO6xZge/hy2lgWL4+CqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjUR8wW045Dmbgzbvu2jqdBO9AgPEXWTs4vUQPlmhSM=;
        b=CML3i7vbwyotnv0YmLllf9Ws9O+mnr0LcHEo1Eh4VDze0RpX7/FLgiheL7u9G17eDe
         ZkvG0B9jkpCr/FTRVV7jgZYp4xnW6wdROUKYRofzPBn+z4TDILXKSZCDJLOPoH6JwlAd
         E1U83rjJNor/ePPvXVLlKAOPF/m9QMF841UqyshpflCh1Hrib/AK+8h63mOG8VbzXGGO
         sTN4sLaXa3lWQCiB6xLPoZ+tuAtbga1a+tCxu5MfZzedHOqEJ7vMiMnY3D5rI17WoJCI
         8eAq0QH+6NU2PCR82n37ehW2/0ApOQr0oLuSnUt4sYbpXBJfDUZroIMpXzRsPQ2Mb9VR
         pTKQ==
X-Gm-Message-State: ANoB5pmVln8clCj4OYdokj3jtQv8DDMcKAVg4dXic5C0VKvoLHblrfWn
	x6J1x4MCgDHLxAvC54q9femMUqc3Ww63IVxi
X-Google-Smtp-Source: AA0mqf62pvfH5XVoRTVA72H4lmmp43BqeNdRWQpiHEBdVvsB26uuTi2QlOOqGZox5pYGidXO2PFsdA==
X-Received: by 2002:a5d:4e04:0:b0:242:4f41:2efc with SMTP id p4-20020a5d4e04000000b002424f412efcmr44880009wrt.35.1671549365173;
        Tue, 20 Dec 2022 07:16:05 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1273:dbb7:632c:a9de])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm14896439wro.99.2022.12.20.07.16.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 07:16:04 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/6] knotty: Ping the server/cooker periodically
Date: Tue, 20 Dec 2022 15:15:59 +0000
Message-Id: <20221220151604.415637-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Dec 2022 15:16:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14210

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


