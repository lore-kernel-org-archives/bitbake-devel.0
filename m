Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5171BC433F5
	for <webhook@archiver.kernel.org>; Thu, 17 Feb 2022 16:58:59 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by mx.groups.io with SMTP id smtpd.web11.2616.1645117138754596787
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 08:58:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=CLDvegrX;
 spf=pass (domain: gmail.com, ip: 209.85.161.47,
 mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f47.google.com with SMTP id
 e19-20020a4ab993000000b0031a98fe3a9dso277290oop.6
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 08:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ge67O8eHBEI4zztPjOlI5GtfheHszZuTgtC5yuc9+U8=;
        b=CLDvegrXJ7MHMOyU81KpVzhEXHFT3e+8v+NHJSdMNrww0vmvmP42JVe9UJK6L4UCrj
         OcsWG2hpenmKaQNqBHIveWNxAidL4Bi8PuoSdBxkqsgKNTJ1ZI+mFvDqq0yQjYVfs42x
         Lh3Bpo2OpG5pmg8IQFAJy4gsiJzstKUkCwadwtuXWGk8pH1FshGkkaULgTyNY1QVmAH2
         FW0T4+Q78WxhG53XA/5nvLb8kf/qVKFI3r02O59IlIflWK1uu9sjd4eKdCzWdm/CApCe
         qYh8440Ck87pY/h2REVW3sOYnVPHg1+AwJP7P7rUywRxc77hMNMqniBfV8gEuhHqjtfP
         bzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ge67O8eHBEI4zztPjOlI5GtfheHszZuTgtC5yuc9+U8=;
        b=5sExBWndJrdSwTxoizY6Ocmhs0qH7PV8C+HZWeolAkBUOb2AvBk2CpuYZ3y4AWNyFn
         B/2KHfM9WT0AN00tGnOz3xsnwQJfifQl2/ZV/EOn8IZRUFrbgv0ZA229evcwZcCX2ait
         0GbZQr3NidW6quqbztxc5WTIJbshQDheMzs4XN+rTNobte3Gx4/Y3oAbTdhGDZQgzB37
         HpEY409VLGbFk4CEV6FRcT5y6oN2dLMOm1XEfG6d5GWrFTCIKrsYr9AYtXkhWex8+6Wh
         X7U0IsenbuLoILyMW5M4VqVz2t9vbinceB/oNDrcGrltpV96BG5+VxZuRMxHkoBWmzv5
         mVQQ==
X-Gm-Message-State: AOAM533u4AvF5q7gl8VOk3g16tsc0EPgs6WWD7Gc9CFTBnyzKsLHMELT
	z5NZEjr8Qp/4BbCqMGPpVcltl/r26Ms=
X-Google-Smtp-Source: 
 ABdhPJwOWtRY8trvQ6yPULFhvufFAf6DEqeGmSLAxYEWt2vBGVpMauSeZ/DvSF3aA9xK9L4b8n0uJg==
X-Received: by 2002:a4a:7601:0:b0:2e0:3c62:4787 with SMTP id
 t1-20020a4a7601000000b002e03c624787mr1039391ooc.11.1645117137795;
        Thu, 17 Feb 2022 08:58:57 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id k19sm82218oot.41.2022.02.17.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:58:57 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: Ensure manually created loggers have
 the once filter
Date: Thu, 17 Feb 2022 10:58:53 -0600
Message-Id: <20220217165853.69695-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Feb 2022 16:58:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13359

Loggers created with a logging configuration file automatically get the
once filter applied to ensure that warnonce()/erroronce() only appear a
single time. The same filter needs to also be added to
bb.msg.logger_create() to ensure that manually created loggers have the
same behavior

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/msg.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/msg.py b/bitbake/lib/bb/msg.py
index 512ec1f5c1..c95a874beb 100644
--- a/bitbake/lib/bb/msg.py
+++ b/bitbake/lib/bb/msg.py
@@ -229,6 +229,7 @@ def logger_create(name, output=sys.stderr, level=logging.INFO, preserve_handlers
     """Standalone logger creation function"""
     logger = logging.getLogger(name)
     console = logging.StreamHandler(output)
+    console.addFilter(bb.msg.LogFilterShowOnce())
     format = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
     if color == 'always' or (color == 'auto' and output.isatty()):
         format.enable_color()
-- 
2.33.0


