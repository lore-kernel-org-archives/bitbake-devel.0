Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F12AC433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 13:30:10 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.44703.1636378209274575267
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 05:30:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=g1Uv7L/1;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id t30so26892115wra.10
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 05:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcBKxydyNrmnfI60xrxJvqU9mBe8ZvwHauM405S7yTU=;
        b=g1Uv7L/1lMD4M6z9FKtTwVEMxAX4NgPPu+vfqexekiOInShtDg1ExqzcrH8HpkFUXa
         wDk6L2+EJ25RILduWjEgG7eo+PHSZRZzuvJ/oYyTM1s4d32M+9Ov6TsZ05ABmRb4hG5n
         KY8patsZvF1emmTlVURn025lV83kXYpaSpylo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcBKxydyNrmnfI60xrxJvqU9mBe8ZvwHauM405S7yTU=;
        b=0Tugt8vXV4EKODJyKX6L9G3OCQFZYpXo/ErEjby89w4co14dxSDXrkTfYntgumraYJ
         W8m7dKUtUrDJE9u9xwYu2I8U3VrAgPNxZNQUXBv/9u5yG7pFmOcFK729we7cDzMIEyGj
         hRnxqOx6SV6BZzu+WDrnAreUgMM2XyUzIu3v2Y0GtLP49SPI4pDe6eX1ldHoiyI+ijyA
         w21zlaWKIGUcmUgWxuIUL8mzc3lTr1vb69j0E/a+5wayIHcplvA7nUeGCVXcYgngZudd
         BUlxEU9uNUW928lkTZUtmXCQPv1g9/5OyEIaHk596f1pFbZFDDOAKMZH+wozptxQet0w
         0F7A==
X-Gm-Message-State: AOAM530nlGFHbDBUMJsxa335Lkb9VNZp0urbegKZKfjla+e4ZEQvF+wY
	wXL46hzakPgQ4DimA6bD/3LQt6wnIfAzlg==
X-Google-Smtp-Source: 
 ABdhPJyPXMhxktLY7traE8SLgEKi2WyAhuI9a83mKMeZHP+p0tO5ddRLskzydDDqNyXDjfnCBbJyZw==
X-Received: by 2002:adf:b604:: with SMTP id
 f4mr101268264wre.111.1636378207435;
        Mon, 08 Nov 2021 05:30:07 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:5c39:dba0:779a:3673])
        by smtp.gmail.com with ESMTPSA id
 h27sm22021140wmc.43.2021.11.08.05.30.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:30:07 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Handle parse threads disappearing to avoid hangs
Date: Mon,  8 Nov 2021 13:30:06 +0000
Message-Id: <20211108133006.3729652-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 13:30:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12941

If one of the parse threads disappears during parsing for some reason, bitbake
currently hangs. Avoid this (and zombie threads hanging around) by joining()
threads which have exited.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2b92744998..f0cea2b256 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2040,6 +2040,7 @@ class Parser(multiprocessing.Process):
                 result = pending.pop()
             else:
                 try:
+                    time.sleep(0.25)
                     job = self.jobs.pop()
                 except IndexError:
                     self.results.close()
@@ -2218,7 +2219,7 @@ class CookerParser(object):
             yield not cached, mc, infos
 
     def parse_generator(self):
-        while True:
+        while self.processes:
             if self.parsed >= self.toparse:
                 break
 
@@ -2232,6 +2233,14 @@ class CookerParser(object):
                     raise value
                 else:
                     yield result
+            for process in self.processes.copy():
+                if not process.is_alive():
+                    process.join()
+                    self.processes.remove(process)
+
+        if not (self.parsed >= self.toparse):
+            raise bb.parse.ParseError("Not all recipes parsed, parser thread killed/died? Exiting.", None)
+
 
     def parse_next(self):
         result = []
-- 
2.32.0


