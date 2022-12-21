Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DB9C4167B
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 14:15:54 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.19683.1671632149630816611
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Dec 2022 06:15:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=KlnGJVFg;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id f18so15087055wrj.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 06:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nvlhv/xI3RCqmomtv1v37EcS/G6BUEAe5DWKoRCliPo=;
        b=KlnGJVFgtk5zhv8jQLQSHxVjgf7JVPdIzD0l78fyw/x1rLQui+/m0QCCCbhdEfJzlI
         LoS/KzwB/IVkBXPzwxuO3DZiD4sGZO5y0+oFxhAaatJVP+JyImfK1jDvL0qoTSjSmkws
         tgd6A+drqUn9QboxSmeaxQB2MP6z/jVnN0g/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvlhv/xI3RCqmomtv1v37EcS/G6BUEAe5DWKoRCliPo=;
        b=B0Es5MtOpDulCuAQX9igpXOrCgzG3NnVaN1z3VSizyPwdR9LzVi5NpQpgCDc4wgZAs
         aWuk4+IFPo/vTFRtI2aLvU6CykoLZZoOVW3BTs5YQE9AIjQJFzYxTqnIhUQTiMacc4H2
         MdrYy969MOEG7i9OZHHIpgol2mbuA7nOjMBJdQpbfrhi8T92LjUmkx0UYYScj6YiUdW5
         PDfPIJrkcCMIobrPdVMXbn0/+p7rFMEcSVMCXHu4nXawPjKNpi6xKRXqQufyehVWppwH
         iYb9pKfUNIUEVwXRPtfEyDyQm91V1TQc6z5Hu+Tj3O+WmfChEhT1aGhxNTSLiEMbLbtX
         PyYg==
X-Gm-Message-State: AFqh2kr+XiW79uWAu5rzAum0DPadpuYrnVSkybULBN47eSu/cIWHCiZl
	95MZzVpF2PMlwkv9l3MNWrl88MIN193KaRi1
X-Google-Smtp-Source: AMrXdXsDg/aOa/bNlxEWMzTCdIeZMxEUfnpKdUSHcAhkGYoG3DEfb7pqfxF89i3OHu0Eu6Q9NkDs0A==
X-Received: by 2002:a5d:5511:0:b0:269:e5d7:e11f with SMTP id b17-20020a5d5511000000b00269e5d7e11fmr1443019wrv.38.1671632147999;
        Wed, 21 Dec 2022 06:15:47 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e749:b020:2cdb:af31])
        by smtp.gmail.com with ESMTPSA id k12-20020adff28c000000b0022e57e66824sm17839412wro.99.2022.12.21.06.15.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 06:15:47 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 7/7] knotty: Avoid looping with tracebacks
Date: Wed, 21 Dec 2022 14:15:43 +0000
Message-Id: <20221221141543.497904-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221221141543.497904-1-richard.purdie@linuxfoundation.org>
References: <20221221141543.497904-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 14:15:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14224

If there are events queued and there is an exception in the main loop
of the UI code, it will print tracebacks on the console indefinitely.
Avoid that by improving the loop exit conditions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index ab1a367be0..c398f591e8 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -631,7 +631,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     termfilter = tf(main, helper, console_handlers, params.options.quiet)
     atexit.register(termfilter.finish)
 
-    while True:
+    while main.shutdown < 2:
         try:
             if (lastprint + printinterval) <= time.time():
                 termfilter.keepAlive(printinterval)
@@ -646,8 +646,6 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         return_value = 3
                         main.shutdown = 2
                     lastevent = time.time()
-                if main.shutdown > 1:
-                    break
                 if not parseprogress:
                     termfilter.updateFooter()
                 event = eventHandler.waitEvent(0.25)
-- 
2.37.2


