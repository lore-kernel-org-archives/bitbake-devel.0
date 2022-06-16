Return-Path: <Martin.Jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6642CCA47A
	for <webhook@archiver.kernel.org>; Thu, 16 Jun 2022 13:49:13 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web09.18166.1655387349566663526
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jun 2022 06:49:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=q3gDWFTk;
 spf=pass (domain: gmail.com, ip: 209.85.128.52,
 mailfrom: martin.jansa@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id z9so809896wmf.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jun 2022 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ofrl6iRRWZ07K8HObjlrKvIGGakVB3gHx50TBprsnuE=;
        b=q3gDWFTkPNsvqYkt6E50P6CoVqlS9aZ1OzSxdOIjoCmzjrSdgekXurHCc56EdsD6b/
         XuZqZuLzGMmOe0bv3xJ6dR5raGSV2e0GvLoKQEYf0sO75bpXmv7FNfur5wZW1NTus5cF
         GREVVlJSZmK2syNwTdVeQqvMMQUjwnq+PGW4whFrOIR/Nx3k2V5JXKDe32AWPEmmCnkd
         LK9RgBRObdHewEuHivu4DqC/vAzbJi6h8NhebWdGxMLw3nnr/toRbfh8gcKFMmfJH2Kr
         Y7VbMDUfzePh87lhEuW5BAJ2oqVYe4yiSe4DZVQk7MoLcFiL8xxVuyHqsF1Jeg5kdc/H
         SK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ofrl6iRRWZ07K8HObjlrKvIGGakVB3gHx50TBprsnuE=;
        b=LZ6ZKevXYo/Z1tGXak6DbCjAl+eTL0z7oOcdMQzUsc+y7nU/OgdvjA7ccPfkv5W83Y
         ft+vbGoHHlC9dp2aA8VdOqQq77yHjit35m7bDCd+inLPg7XtXsue3b4yo9xKI/3UPUKD
         YTxkun59LpfK5YARf0MSTae6FajMlijXx7B38qT5qsqUvxocBlJh4wJ7J3bCWdy1htMi
         /GluKHtxTUwpDInDCTcuGbByXEjWmVwoYojkVb/8qCdwj0dxh6fmH/Zbvz82fkfHHKnl
         +Bb6CshoJP+FaJFsGiRbYqLVowHSAeE2rWchemfHh6j6oX1K4rCjpLa4B1jy0rmj2Xvl
         7EIA==
X-Gm-Message-State: AJIora9JgrojfzX2+R/028QBMfPaAijdJfCxAAuDRFzqkrmy1rccpZa7
	Pi74/UpibSS3UP4Jfr+XPVvSREmdQlM=
X-Google-Smtp-Source: 
 AGRyM1udRVjlq9/K1nl3lejx0LKlsh6vghsHlx88Cat/TQjBDVNsrc/LhPPYYyjA7mP82FyF5s2wQQ==
X-Received: by 2002:a05:600c:1d1c:b0:39c:7ac8:1faa with SMTP id
 l28-20020a05600c1d1c00b0039c7ac81faamr5195113wms.202.1655387348178;
        Thu, 16 Jun 2022 06:49:08 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id
 by13-20020a056000098d00b0021a39a56a73sm1347299wrb.106.2022.06.16.06.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:49:07 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
X-Google-Original-From: Martin Jansa <Martin.Jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Ross Burton <ross@burtonini.com>,
	Ross Burton <ross.burton@arm.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Anuj Mittal <anuj.mittal@intel.com>
Subject: [1.46][PATCH 4/4] knotty: reduce keep-alive timeout from 5000s (83
 minutes) to 10 minutes
Date: Thu, 16 Jun 2022 15:48:50 +0200
Message-Id: <20220616134850.3471187-4-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616134850.3471187-1-Martin.Jansa@gmail.com>
References: <20220616134850.3471187-1-Martin.Jansa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Jun 2022 13:49:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13771

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
2.35.1


