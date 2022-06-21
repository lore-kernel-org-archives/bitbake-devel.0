Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06003C433EF
	for <webhook@archiver.kernel.org>; Tue, 21 Jun 2022 18:22:56 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.36553.1655835768871663066
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:22:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=qalKlHhd;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.172,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f172.google.com with SMTP id k7so13259269plg.7
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jun 2022 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PEyq7LNyz7JntBDQn9aUhPG4pYZkRAR/BiMR78ZNWQU=;
        b=qalKlHhdHV4rUmhb7fdH4uLZlN64h48U+WLF2YxrlZO8olCd8C6xlet0jWy8KAFv3m
         vTWlsH3BicY76uaUwd2UQ9/g0wOAxLoC3IY970sBU2Sw/9WfjzhBPyb23u8Lo2qGLuYd
         ZxbdXeZwGuzJT/uF5P/ziaw97q5T/nRFDBI1Oc6FDS1ik5rjln7YYQDn+leGuKBdgo2K
         CJvh7vmSHo3TUdsXvcJvMaSieNefqVqz/0F0d4eJW4+bMsx0FHaIbJ3HLbVkb4BdBDwq
         WcMnrrki73OTaE9Qji40HIG2KPRXSMF0zXZ3KIZGN3fnOgCLoTZa9nizzongspcymjja
         /G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PEyq7LNyz7JntBDQn9aUhPG4pYZkRAR/BiMR78ZNWQU=;
        b=LsdMpxa1mnq6jEu5Y8KRxSB0PRmGdBbD+8nhV3Uz50XhiNgiWv5cmxu5b0p9mO34t6
         DcfkrNlHMIfA63tC9QLEZQvid8ieOEMFQNjndQFWtumeB/xTGbxnmM9WCApaSrTqecSJ
         LlW1NKAfDpCEwT7qTflXZrLj3Qu6ZvylZVAu49dtBwBO+HsZadJ/HHQX+7IUB7RVHEIV
         x9CRKCyFuNSseeg7rktM4A9fLoi2ECrtrQNjyxKTm53eQincZH7czf9MKOjo6WPkOjJH
         X/qVeR93frn6868MBIFuRzOfUBbVM1Sv9813RXyJnWZ0XPHW0ODsTp0azbq9YERTrkwB
         ka6A==
X-Gm-Message-State: AJIora8kSK0CKwRmxEnd3pE7CJxVOMWpLst7tKr9Q1Avt+dyZ93Tcu2X
	2foQspEwPg15jYz6Ke2rGWANWuUO2deQqYrL
X-Google-Smtp-Source: 
 AGRyM1uEWB/fSSY6upQU0eNmh2VwRSYO+7LThlk37thEBG9nk+wfVG35vhp/YtN4bq9CCEyh0zur8Q==
X-Received: by 2002:a17:90a:e013:b0:1ec:7b12:e326 with SMTP id
 u19-20020a17090ae01300b001ec7b12e326mr25619585pjy.13.1655835767824;
        Tue, 21 Jun 2022 11:22:47 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 t13-20020a1709027fcd00b0016392bd5060sm9755503plb.142.2022.06.21.11.22.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:22:47 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 5/5] knotty: reduce keep-alive timeout
 from 5000s (83 minutes) to 10 minutes
Date: Tue, 21 Jun 2022 08:21:01 -1000
Message-Id: 
 <a496a8952d8542ce814b13f460811d8849d25a3c.1655835530.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655835530.git.steve@sakoman.com>
References: <cover.1655835530.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jun 2022 18:22:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13783

From: Ross Burton <ross@burtonini.com>

The keep alive timeout is excessively long at 83 minutes (5000 seconds),
reduce this to 10 minutes: this should be long enough that it rarely
triggers in normal builds, but when it does it has useful information.

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit dcf52157d3635925491783be656c6b76d1efe1a4)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/knotty.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 71c5a3e9..d1f74389 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -599,7 +599,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     warnings = 0
     taskfailures = []
 
-    printinterval = 5000
+    printintervaldelta = 10 * 60 # 10 minutes
+    printinterval = printintervaldelta
     lastprint = time.time()
 
     termfilter = tf(main, helper, console_handlers, params.options.quiet)
@@ -609,7 +610,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
         try:
             if (lastprint + printinterval) <= time.time():
                 termfilter.keepAlive(printinterval)
-                printinterval += 5000
+                printinterval += printintervaldelta
             event = eventHandler.waitEvent(0)
             if event is None:
                 if main.shutdown > 1:
@@ -640,7 +641,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
 
             if isinstance(event, logging.LogRecord):
                 lastprint = time.time()
-                printinterval = 5000
+                printinterval = printintervaldelta
                 if event.levelno >= bb.msg.BBLogFormatter.ERROR:
                     errors = errors + 1
                     return_value = 1
-- 
2.25.1


