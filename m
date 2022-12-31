Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F28C54EBE
	for <webhook@archiver.kernel.org>; Sat, 31 Dec 2022 16:59:02 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.45611.1672505933112061040
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 31 Dec 2022 08:58:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TyjU3+vx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so15480797wms.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I8OzwOY1eyomQtXLHt7a5zwI4hGjNsSkPlz0lOUSUKk=;
        b=TyjU3+vx7KUrawu9UEH5/jl36sZw1NQt/7t3c8cAzawRsmT5KWp64nOhtxxbLX7SxL
         wiYPOvPPSKjKm8uJftYea5vyrgIfOxNWbUEM8J9WeCdgQRlXJqAcDq4BQgECIKBHqrE8
         qiiMvKAtbv2/MPFaphba7zvuU/d17IUxf74Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8OzwOY1eyomQtXLHt7a5zwI4hGjNsSkPlz0lOUSUKk=;
        b=c2t+IBNjRk+ckYBVcFTLh/7zBeStPb+wuKM4dCeQTW6dfo+p1AeTWsYdB9vkXdEnFK
         9Skb83on6eAbvCqPwrYRNcc9cbilicHipYLvIRWtkfpIA2GmQfsujSZWKGb5ZHUZvmj1
         TJotCk+SwVIt+2Un0ajG+f8Up966IB48RMh5rbH60NlnS2Q11YUS2D+B9kuch1WMxXj1
         cF5TW5LzX9zZX0HyeWucIGfvzFsgWfl7a52II/MPfSkYtUcSdmm6/4+rxTMVPEIlHdNU
         RDS0DW3FHxMv/9cBB5TRm0zJWZ5bIIwPexWYeI0InbkKKPEOf5AbJjpxjf6DEchUcZPR
         J9dg==
X-Gm-Message-State: AFqh2kqIs/xPNW+u/hxMTc8AzbGtQotDxOWSXKf4b2NpcHhk4liWb328
	dN2IJYJ0ui7P9aeVIA2DZz+CjXptypTOJwsw
X-Google-Smtp-Source: AMrXdXu74B8arCwBzbxJS8dunIfnTdkFi3p7curPPzl9bpdV6wo9+EK5R44UO3/Xf1JiAp73C6MNeQ==
X-Received: by 2002:a05:600c:5c8:b0:3d1:4145:b3b with SMTP id p8-20020a05600c05c800b003d141450b3bmr25892342wmd.9.1672505931434;
        Sat, 31 Dec 2022 08:58:51 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a1f:74ee:21ca:3bb])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm36582812wmq.42.2022.12.31.08.58.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:58:51 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 01/11] knotty: Avoid looping with tracebacks
Date: Sat, 31 Dec 2022 16:58:39 +0000
Message-Id: <20221231165849.964169-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
References: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 16:59:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14262

If there are events queued and there is an exception in the main loop
of the UI code, it will print tracebacks on the console indefinitely.
Avoid that by improving the loop exit conditions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 61cf0a37f4..761c2dddaf 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -630,15 +630,13 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     termfilter = tf(main, helper, console_handlers, params.options.quiet)
     atexit.register(termfilter.finish)
 
-    while True:
+    while main.shutdown < 2:
         try:
             if (lastprint + printinterval) <= time.time():
                 termfilter.keepAlive(printinterval)
                 printinterval += printintervaldelta
             event = eventHandler.waitEvent(0)
             if event is None:
-                if main.shutdown > 1:
-                    break
                 if not parseprogress:
                     termfilter.updateFooter()
                 event = eventHandler.waitEvent(0.25)
-- 
2.37.2


