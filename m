Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76172C4167B
	for <webhook@archiver.kernel.org>; Sat, 31 Dec 2022 16:59:02 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.45612.1672505933951647862
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 31 Dec 2022 08:58:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LiVP7RuG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso11121491wms.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 08:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEXcLKOHfSMHOKaafg/oqFGDbhEob0mfkv3eOhYT4aw=;
        b=LiVP7RuGQCGymamFzy3neIyDdbKqxFJWvlbiRVAOAx5akDfEtTB/9Wty+IAunYFABO
         QtAHvPYC1YwXBSFRbLiQCHa6D6AvTxTKgec5VhREBuqxfDiAZdSWU774WFW89/+nKYyu
         95y7ecFVRXDLf/uADegjQrvx3fsmE+0l+z5gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEXcLKOHfSMHOKaafg/oqFGDbhEob0mfkv3eOhYT4aw=;
        b=otrYOkROUlv/fs+yvk1Vf8PX5cV/apjJ721GlwBXM+hVNGEY8yL2qhjdVRfZX1Gqt2
         0SD51lamqqbn0uKi1klZYMHXalVylDOTAiyGdDvE5pJi1pb07iq65wA1u/aIhVhJzcyL
         IIjrKqXrYAAIYhoMxfIKi1fMdV0EnlWE9FxJ4mxdPW3lEpKoZkoMrbLdwrFm4gdMQb3a
         uScOqtWNv20oF1DoK4xkyMQmcC7sdCHP/TFXO11qeelHCqdV7i+1Ns71vwZfYE7V2xue
         1oTMOkbGdbLklMSJ9OIRu9Q4tjTX41tkdaJ+iwdnA/vfGT7tdIsgUyPj+j7APRGFOLCF
         DDRA==
X-Gm-Message-State: AFqh2kr0wBG5rSxRXr7YYWclymps1I71ULKVC7vgzSYIFR3J0YFST00a
	KfizdxKFQdyXBZZuE74e78X+uCvbJ6OhSyuO
X-Google-Smtp-Source: AMrXdXsAqbeGjj/u6bfLGc3d9fSAmn900TFF54YaV8qZv6pLNOTnSSkoDsJiYbhGsuI6Kdwyd1VALg==
X-Received: by 2002:a05:600c:3644:b0:3d2:39dc:4ab9 with SMTP id y4-20020a05600c364400b003d239dc4ab9mr28437408wmq.13.1672505937620;
        Sat, 31 Dec 2022 08:58:57 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a1f:74ee:21ca:3bb])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm36582812wmq.42.2022.12.31.08.58.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:58:57 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 11/11] knotty: Ping the server/cooker periodically
Date: Sat, 31 Dec 2022 16:58:49 +0000
Message-Id: <20221231165849.964169-12-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
References: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 16:59:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14271

We're seeing failures where the UI hangs if the server disappears. Ping
the cooker/server if we've not had any events in the last minute so we can
check if it is still alive.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 761c2dddaf..7370a1adfd 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -625,7 +625,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
     printintervaldelta = 10 * 60 # 10 minutes
     printinterval = printintervaldelta
-    lastprint = time.time()
+    pinginterval = 1 * 60 # 1 minute
+    lastevent = lastprint = time.time()
 
     termfilter = tf(main, helper, console_handlers, params.options.quiet)
     atexit.register(termfilter.finish)
@@ -637,11 +638,20 @@ def main(server, eventHandler, params, tf = TerminalFilter):
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
                 if not parseprogress:
                     termfilter.updateFooter()
                 event = eventHandler.waitEvent(0.25)
                 if event is None:
                     continue
+            lastevent = time.time()
             helper.eventHandler(event)
             if isinstance(event, bb.runqueue.runQueueExitWait):
                 if not main.shutdown:
-- 
2.37.2


