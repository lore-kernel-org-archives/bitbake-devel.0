Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C315C4332F
	for <webhook@archiver.kernel.org>; Thu, 22 Dec 2022 23:47:34 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.60847.1671752853128537071
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Dec 2022 15:47:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=I2A5J2aM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so2461409wms.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 15:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nvlhv/xI3RCqmomtv1v37EcS/G6BUEAe5DWKoRCliPo=;
        b=I2A5J2aMncT1Bke+X6J1nnYK2idBqXxQ3g6rdiWeFG9OURnisEz2sk/etc2bWFU1cW
         zKi8QUq2Oes/Y/RnStxKv5fZ7PzdS8r8mHiA9YPZnw3HzSKuCjIQQqddtBBXBN99MQdl
         nYR1l7EWw+t0V5UvcUQJbSyHeJdQ9SxhL5djU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvlhv/xI3RCqmomtv1v37EcS/G6BUEAe5DWKoRCliPo=;
        b=LP5RiKstbYcbH8OPKwlTzWh334Dcwt/4bquj/+Qzx7rkY0g9nAJV7I9ROD/mEBDFzB
         MFkao1/Mg2GRDeVbZ+/9xRiKjn+3UBCGijd+Afw4HD9vqyAVGVTChpUDkA5QszSX0O6m
         GaH9OiVodOw6hbq8aQKw1pGJsxm9BnsesUqJlaCN4Eqmbq9WTk0RH9Ow+K0osOwHBggB
         Stkz8ObYFZB49LFcznYRlo5t6cPfcCPhcO0XSA4yEETOTy18IVatq+GhOLZNB+gWOHA1
         YbiLMnSfuT4PSulyJhyirKCujt2LAvsXg3o0oCIPpT2J3FM6L+T3GW2TpjTHCCu+cAhS
         sQFQ==
X-Gm-Message-State: AFqh2kpAHQTV0gLEDfTUyP+WDBcqiDtm3BuRV0t/t+xIKlQLqCWqJtAk
	UQtK5E0oXwRBJFKpe+LnM5eTZMyuWj2Voq6Y
X-Google-Smtp-Source: AMrXdXtt4on4bpDN/Z24dL4RdnRsw3SBtdoccxlI5ihRP2TWCE4ByVSoePvsjyH03a8/jEsFdEvXMg==
X-Received: by 2002:a05:600c:4d24:b0:3c6:e63e:23d4 with SMTP id u36-20020a05600c4d2400b003c6e63e23d4mr5736608wmp.3.1671752851484;
        Thu, 22 Dec 2022 15:47:31 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bc21:fec7:83cf:e0c3])
        by smtp.gmail.com with ESMTPSA id bd25-20020a05600c1f1900b003cfd4cf0761sm7322189wmb.1.2022.12.22.15.47.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 15:47:31 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 07/10] knotty: Avoid looping with tracebacks
Date: Thu, 22 Dec 2022 23:47:23 +0000
Message-Id: <20221222234726.579702-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
References: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 23:47:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14236

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


