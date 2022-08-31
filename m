Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6823ECAAD1
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 11:14:50 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web09.24227.1661944489083432391
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Aug 2022 04:14:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Qcno3EOZ;
 spf=pass (domain: gmail.com, ip: 209.85.221.46,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id bu22so17457745wrb.3
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 31 Aug 2022 04:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=drgC7WZYbal1e2xCCgjpsITVLUjCmzMZOEfSqQFouww=;
        b=Qcno3EOZt2ZARRuo8Yfct4sHsKfG1hG4f3BGGmsjwNu1RA7/pzZDurj2RsCh3JR45h
         cJC9CgdbmuAYF35PJgSoPP5G8m8aFs2t+MOyn1O15Nq7r17MOQejZhX6mTfMVORTxikA
         YZf78hCJL/h7sl4+dKRxrSnLBmB+n75+mdiZB3ztXeFt8nP0FzYJJ1S30ix//XfwRZwI
         DfhDYepNWz8FJjpQQfk0EHSyqPFr5B+rYriySRGUQck2Q5RYE+ALG/LzJAWJXslGXhIm
         AmBNlltoErqOq9CfFy8UFcTRTc9tNykQBkqdL5Ff7q3NMcylaraoebMneOl17sHVrZ+j
         XEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=drgC7WZYbal1e2xCCgjpsITVLUjCmzMZOEfSqQFouww=;
        b=YLFxh8tih3HyqyABulTSQvQYHPs1RTJv71nJNujQ/9yFBMRO2zxU2kW/nC9DQoktod
         DK7NllgQ6PXR1lpllqRFbomv5+GDDtvKiRyjS5BRHM+YgYGlR7PT0zUhgkQsGtZT0sg6
         UOzLsSBhVI3dTsO+Z3aMG/2CFXek7ck2kUkjQ+VHbnZ4LtimF9Jobx6NRWoGxMizaaH2
         yIdPmVqIKMuTq+PCEv1WOU/BnnyD/aX5n40AmzTmw49TmybNRi5AXGLlhwLNd9Hq8wFO
         eRIv46kTiYaET09bdQt9E/MUkIQmBnF0hZZApXrjKG6S/tazxEkmcWGxm/Q57cRlY9Q1
         ChEA==
X-Gm-Message-State: ACgBeo1E163U/bdpNYCnRzAtKGv4GU7rFz4YmAim/+mEWdK6pb6ZvMDX
	521pIvkm49l+SNjF56b5ped4t23eTpM=
X-Google-Smtp-Source: 
 AA6agR6XabURjHb+sm3bkxboBS8eOkm2dyuZEI6ImJwf+q6OGVoUnCpHxlip2oMcN8BrGb9c6L8B0Q==
X-Received: by 2002:adf:fc83:0:b0:226:d2d4:bc27 with SMTP id
 g3-20020adffc83000000b00226d2d4bc27mr9795764wrr.606.1661944487542;
        Wed, 31 Aug 2022 04:14:47 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de.
 [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id
 ay21-20020a05600c1e1500b003a536d5aa2esm1908647wmb.11.2022.08.31.04.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 04:14:46 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-layers: initialize tinfoil before registering command
 line arguments
Date: Wed, 31 Aug 2022 13:14:44 +0200
Message-Id: <20220831111444.3330400-1-alex@linutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Aug 2022 11:14:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13948

Plugins may want to use it (e.g. the layers-setup plugin that would
want to discover writer sub-plugins with it), and so it makes sense
to make tinfoil available a bit eariler.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/bin/bitbake-layers | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 449434d468..d4b1d1aaf2 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -68,11 +68,11 @@ def main():
 
         registered = False
         for plugin in plugins:
+            if hasattr(plugin, 'tinfoil_init'):
+                plugin.tinfoil_init(tinfoil)
             if hasattr(plugin, 'register_commands'):
                 registered = True
                 plugin.register_commands(subparsers)
-            if hasattr(plugin, 'tinfoil_init'):
-                plugin.tinfoil_init(tinfoil)
 
         if not registered:
             logger.error("No commands registered - missing plugins?")
-- 
2.30.2


