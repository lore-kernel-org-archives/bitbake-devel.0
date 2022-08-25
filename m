Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F332ECAAA0
	for <webhook@archiver.kernel.org>; Thu, 25 Aug 2022 20:35:41 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web08.29380.1661459736315570088
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Aug 2022 13:35:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ENA99ouB;
 spf=pass (domain: gmail.com, ip: 209.85.221.47,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id a4so26052071wrq.1
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Aug 2022 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=drgC7WZYbal1e2xCCgjpsITVLUjCmzMZOEfSqQFouww=;
        b=ENA99ouBygroykUrJQ5M7J8BEcnNscyxHKo0RjllR+rsEzG2q7d+vpY1DZdY05qgK5
         G8Hht3NpziIRRvALyI0QcVZ1kdNGocLCG51qr3mDdKDDgvN4KOO/AcPceiMfovqjya+2
         lAzoz/jIbqZH7dT/AWIYRRLB2ezurr+vRPKU8Cf/5WkBpf0SsbgV11yhfTOAbdCVqc3p
         aWkwc5fPV7UNI+LxpvjJcEdGan+UpQC85wHW16TuMzO39VkpIDNCHXeULZ3Q63ULJ9SM
         sMfWJej46KJKCUau+NnJOSktiuTD4lDGFOCPFeobMZE8ctPtrdOU7//1/wtBgfDO8ueB
         cGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=drgC7WZYbal1e2xCCgjpsITVLUjCmzMZOEfSqQFouww=;
        b=kcqwwdn2m1r+OXdEB1HxKdxwtRnylmmTgP9O0GiI2WEJEEDGxAU8Dn27249Zmvvlv6
         Tv6XfH5159w0/M4wjnnr661zJcyXXNTrdBr9Md9/4ovc5CN3wOenYmekaPYdeKSdxF41
         s4dtOyXIlJEILadWyFdAjAmEDZpUjvzAA4tqSYKwql8nQoI/UFprEGhmZGxn3wjF6eq9
         7rKSi2xPeSfMrWwFwSwWBCSI/0Q5WmFbRDOF0CJL67pbe+kk8TCU0R3uDWxL0c2xaAlQ
         TkOfxegv2miXUxLd1il6w2a0MVFl8h+TJp5ga5SFjKsJaLAaKeZ7Q2OL8COjzbheoedZ
         KvDg==
X-Gm-Message-State: ACgBeo2VRz7s4tzUKoos0EYqKyaL72ws1XLcFIvukaTpisrrGjtlwf0t
	/a94mG/5226L5UlcjbbK+vtRudaLpvw=
X-Google-Smtp-Source: 
 AA6agR6IPxIPcQsRNMSgTO8EUXfIkyxxROx6P0kWyw7I3kdCYuIK9YtF9DW3ae4oXoD0gYuw8VQzeA==
X-Received: by 2002:adf:cd86:0:b0:225:1a3a:d984 with SMTP id
 q6-20020adfcd86000000b002251a3ad984mr3358587wrj.212.1661459734812;
        Thu, 25 Aug 2022 13:35:34 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de.
 [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id
 d18-20020a056000115200b0022582e811c2sm172040wrx.35.2022.08.25.13.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 13:35:33 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-layers: initialize tinfoil before registering command
 line arguments
Date: Thu, 25 Aug 2022 22:35:31 +0200
Message-Id: <20220825203531.2074157-1-alex@linutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Aug 2022 20:35:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13933

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


