Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6345BC54EBE
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:43 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.208595.1672333653668637530
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=f6ANp/rE;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id y16so17910366wrm.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjUR8wW045Dmbgzbvu2jqdBO9AgPEXWTs4vUQPlmhSM=;
        b=f6ANp/rEi7kjAaHx6AG3G4sHtD1LTN7NKZwtJvpTbkDkhmFieYtEN7pbaufcd3vnnG
         3fSSQHGkIQyM+HsJQhFfZRxND6g+ieO2+aUANNDy3qH0bjtnfhsF/0LmVGZ9Nf+PnZ8I
         tjP7QiQEwfgGAb1tIcRteLNS1dI3VJUcJ/rp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjUR8wW045Dmbgzbvu2jqdBO9AgPEXWTs4vUQPlmhSM=;
        b=xZpe2+UT8X0TF9qmmYEzY64q+g4G1KIWhl0dlgZry0eJ+cVTBaxZ4P5lVkj7S0a57z
         M6dmwXH5WTni4sjM6Jc7UgnWSgrNdi5x+iyXZvbn/vNwyk9TUdexuJYUDLFZCO28V5wJ
         t4/UE0gAZ1qMyjh6EHv+/UVBmRgSeJWX4N8ZIRAGYAUNCCrMKMgjRVUZoYCgbFsvEVv1
         zDR0r11Bx/jVNfQ/fy68b6L2CmD3Z0EdYl0rVMTP6wYllmvhYK6g63aoPeCiSAgpulvo
         trxkrHRzlNf/+S+h3ByTujGHj3nxLcHFpXajMkMfCpRfrd4efV6f4ha1vQ1EZc07O05d
         uOtQ==
X-Gm-Message-State: AFqh2kqgyxsfaBfvZG9kJL6fuLJC9/XOm/AoB93gYgIy2XgPwz54U0Uw
	S0OVf9nnYNRJ10V4YPOlm02CZCKHpN6TVEh/
X-Google-Smtp-Source: AMrXdXvR54038f6lC2XX6/G2XX72PLOzQr0LRB6FWcPAU4zA3GyL7uNXNV5ZFCZ9tJh+IlABhhUNIw==
X-Received: by 2002:a5d:6a43:0:b0:26a:298:f067 with SMTP id t3-20020a5d6a43000000b0026a0298f067mr18651677wrw.43.1672333652000;
        Thu, 29 Dec 2022 09:07:32 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:31 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 03/15] knotty: Ping the server/cooker periodically
Date: Thu, 29 Dec 2022 17:07:16 +0000
Message-Id: <20221229170728.880367-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14246

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


