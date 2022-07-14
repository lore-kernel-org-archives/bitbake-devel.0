Return-Path: <ptsneves@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6997CC43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 10:40:21 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.5992.1657795215615564416
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Jul 2022 03:40:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=cM48dkzh;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: ptsneves@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id
 8-20020a05600c024800b003a2fe343db1so957880wmj.1
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Jul 2022 03:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qlzzv0P+CyFS4d+gW7xsbjb3/ktZmOJMhFEQszQuS7A=;
        b=cM48dkzhbHWTLX9loyx3rGVGVYOYGTmvlU07vgF7EvS2a4wnrwxZP2Dzv7Pg/6BjNo
         F1lQIreMvhHD99HL+VvZRD7fwwoWC/ZVU8TORHCE3X3Z+WdpSsp0XljHoYVX+xiMlz4c
         Ug8tDEUpnhk8ZzSvnROVyRu+W/WHtcaNt1mC4EalUvLDpKztSReCJJRsVJ8qooh86rOL
         fJuLSMl/7FTNPs1hwaayBT0hajpnVGwJYDdySOgFleoTuuens/6nTuERpn0nm2V2kWvS
         1ALgQBc8p2lRmhxJpB9NtiXuxlRPdDs6OKg/FNEtp8gbCrHQRY94v8cmolmf8BXp98F5
         O3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qlzzv0P+CyFS4d+gW7xsbjb3/ktZmOJMhFEQszQuS7A=;
        b=7AFtiePVANjPnwZPdf4nSFQzLvUkGMq4qZHItMRGDxuOO5a5N2DXJMUyBuUVXoED8E
         CudkSTISHrs1LW6crwH3F4MpqBoecLPojM0BzvHgYBqwxJ9JxYyTgXBpESoZBuezc2gK
         ADB+rkL0hg05LmeXVcv6nQ4enQXudvLC1yvdR10ui7vJS7MC60123R7ql70qhp2BXZvD
         UHcl8hatYe9Iaraz8jYqbcxrvKjjbh9V5gwH69eO1UyRFyEi28pGoSfPzkZNFD8dNDrc
         I8Oi+0nEzjm8VgJek8V2r/8MwVqbNtYXFKJ3Hm+rVDA49i11gT0QWBdGP9G8GVq9Ollo
         L/ZA==
X-Gm-Message-State: AJIora/7aFLsJ4/6SmH/y4rjXxxjT6KFjPSnnveRULqgKaiUqs9ld4dF
	g5CeJnEUdpIL50w9JMZiv5IMusXH4LiT
X-Google-Smtp-Source: 
 AGRyM1vJUNL3BJLE0MEzqUx0FLUwxDitJGl3Siwg7jOMFTMLVEHJPzu69w8Ai8DFLHC5p9g6+k/L9g==
X-Received: by 2002:a05:600c:a18a:b0:3a2:e5ad:d786 with SMTP id
 id10-20020a05600ca18a00b003a2e5add786mr8107916wmb.180.1657795214028;
        Thu, 14 Jul 2022 03:40:14 -0700 (PDT)
Received: from localhost.localdomain (83.11.65.125.ipv4.supernova.orange.pl.
 [83.11.65.125])
        by smtp.gmail.com with ESMTPSA id
 z16-20020adff1d0000000b0021d65675583sm1125913wro.52.2022.07.14.03.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:40:13 -0700 (PDT)
From: Paulo Neves <ptsneves@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Paulo Neves <ptsneves@gmail.com>
Subject: [PATCH] oeqa: test_invalid_recipe_src_uri expect parse time error
Date: Thu, 14 Jul 2022 12:40:03 +0200
Message-Id: <20220714104003.24966-1-ptsneves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Jul 2022 10:40:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13825

Before this commit the test expected a runtime error but the logic of
the fetcher changed so that files not found for checksumming cause a
fatal interruption of the parse, thuse never reaching the runtime error
this test expected. This commit aligns with the bitbake changes to the
fetcher.
---
 meta/lib/oeqa/selftest/cases/bbtests.py | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/meta/lib/oeqa/selftest/cases/bbtests.py b/meta/lib/oeqa/selftest/cases/bbtests.py
index b42bbb651d..89267c7145 100644
--- a/meta/lib/oeqa/selftest/cases/bbtests.py
+++ b/meta/lib/oeqa/selftest/cases/bbtests.py
@@ -145,12 +145,10 @@ INHERIT:remove = \"report-error\"
 """)
         self.track_for_cleanup(os.path.join(self.builddir, "download-selftest"))
 
-        bitbake('-ccleanall man-db')
         result = bitbake('-c fetch man-db', ignore_status=True)
-        bitbake('-ccleanall man-db')
         self.delete_recipeinc('man-db')
         self.assertEqual(result.status, 1, msg="Command succeded when it should have failed. bitbake output: %s" % result.output)
-        self.assertIn('Fetcher failure: Unable to find file file://invalid anywhere. The paths that were searched were:', result.output)
+        self.assertIn('Unable to get checksum for man-db SRC_URI entry invalid: file could not be found', result.output)
 
     def test_rename_downloaded_file(self):
         # TODO unique dldir instead of using cleanall
-- 
2.25.1


