Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2777CC433EF
	for <webhook@archiver.kernel.org>; Wed,  9 Feb 2022 21:40:24 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web08.1658.1644442822606007526
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Feb 2022 13:40:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=cwBlCqqW;
 spf=pass (domain: gmail.com, ip: 209.85.208.53,
 mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f53.google.com with SMTP id u18so7720416edt.6
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Feb 2022 13:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ySe6B7CM0dnCLF4ItpAqpIhRMnphmv43RHp6VptNVKs=;
        b=cwBlCqqWgKvFtl3Yr5U7GlRnJaqn9atEkY1K8I0bmzjKU8i97+Ewh2jdvGAqsf7LX7
         S+rmJpHu9NWYCOtDf1TB4cbsRirbyPuJrYSA+kFgIIMxuDVFPOYDA6GQbfBIydr8IDxV
         WFwzw2KeQXZVTs/bte0owT38lE/dHhHsXwmJ2QEQpVJYWTAtw5fO2nvS5hBps3nzcChz
         3kS2EVVNwBG32sRV6q//9cbOf12ySW3rhLB8XB+5uCHLhbU01c2uPByE3lkGH1YuA+sB
         LDnyvdAP7x88VUMopS7NII+9/uaAESbA9RWVn1tk2YqJu4KoA605yAb6MP9uD/7AQxzI
         Crow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ySe6B7CM0dnCLF4ItpAqpIhRMnphmv43RHp6VptNVKs=;
        b=UjcN9aZju579bIGMubFXY0bkXWoKqDQJYFCyXzt94Pp4/FXoB/XTHLbjYcbNyZlSOB
         kXSq40stx1hfEla5XFaL5csPawldnMUgwSG9u/WKCp5aN5YXFvjhRHSich+PAIn//oKQ
         HvgOYd7URDN0xfrcNkb6vULsswblQ2Qx0cU+6Nyt5khYjPFlA5yBhOcp9PfnVFLCBSGz
         lS8uZzgTknuFD9R22lN1bRMHta1RVF7wtZoHFBrSkWvtelUTT0F7f1Z4FON/WUXiHbz/
         pZohjmsmHo5s11OhL4oKK/b2EJQ+YNmVcPo2einXm0YtwNgVitH/pxveS97cfR2FjHKz
         79Jw==
X-Gm-Message-State: AOAM530lLND6eKer7zwT14S0rZ1boXaVIg7vvCpXgTYjj/l6gkQWfxH4
	Os9GdNvGGa3r5R6+7RIfEj2zExgostY=
X-Google-Smtp-Source: 
 ABdhPJw6ONn4siqQn8J8LBDhnFfNb7TFVLiqXF/1T9WskFjFnnRzyt9AS6eKpbglMztdim13q2gW3g==
X-Received: by 2002:a05:6402:11d2:: with SMTP id
 j18mr4923564edw.349.1644442821045;
        Wed, 09 Feb 2022 13:40:21 -0800 (PST)
Received: from nereus.lab.linutronix.de.
 (ip-109-090-143-203.um36.pools.vodafone-ip.de. [109.90.143.203])
        by smtp.gmail.com with ESMTPSA id
 v19sm6651000edw.39.2022.02.09.13.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:40:20 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] wget.py: use a longer timeout in checkstatus()
Date: Wed,  9 Feb 2022 22:40:18 +0100
Message-Id: <20220209214018.363691-1-alex@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Feb 2022 21:40:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13323

The addition of 30 second timeout is recent [1], and has
proved not long enough with the AB server when mass-checking
for sstate item availability, resulting in timeout errors with
extensible SDKs[2].

[1]
https://git.yoctoproject.org/poky/commit/?id=2c46245f449d2716566ef668da0bf48f2109643a
[2]
https://autobuilder.yoctoproject.org/typhoon/#/builders/53/builds/4710/steps/16/logs/stdio

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/fetch2/wget.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 253cabce75..2a7592ae5f 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -366,7 +366,7 @@ class Wget(FetchMethod):
                 except (TypeError, ImportError, IOError, netrc.NetrcParseError):
                     pass
 
-                with opener.open(r, timeout=30) as response:
+                with opener.open(r, timeout=300) as response:
                     pass
             except urllib.error.URLError as e:
                 if try_again:
-- 
2.20.1


