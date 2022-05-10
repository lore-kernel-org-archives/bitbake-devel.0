Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAD9C433EF
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:23 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web08.643.1652205966583722690
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=pyujqRBQ;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.177,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f177.google.com with SMTP id i24so15571342pfa.7
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ze0FpdJqm5D8cXtb+fCiZkxINHI4YOPUg51oGeeRUG8=;
        b=pyujqRBQV2dcY3cOXgMSJyK4LzxpwZooxOuq+W3BXktELmunbCRTBZFgjSdselga/y
         fC3hLEKMjAdV1gtVJI9xls4N9pvk13oxFcVTy/wTu8RatdpYfctVlWubfY+H5os7YgYS
         TwjAStEB9Ms1ViLec78TbuvJFKLnRcNk3DwhFJO731UUDU9/Z2s70+FXJ8tnizs6G58j
         FAsiWAnfyUOiS75+Vselv3q8iu712bJGX05WVDyEfwQLiJaf5LoyuWgxkNL2ZdXq3jIZ
         uOZVWA+p3pgJaN9skkalyZv1W+/trj5jFQ1/TybdL4qnEXtis58udzAtHQQsPs4jFGFx
         ZWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ze0FpdJqm5D8cXtb+fCiZkxINHI4YOPUg51oGeeRUG8=;
        b=cVmEdkusutssaJ1gyseBeNY5PtjzzUywL3LfsbGIQKrp2WtidifPbjC81bL05oVyHN
         YSzqxrFNKORtWJyd1Kmm/ckZWC39S5u5QyRVnpPNKy5oFgRPYbSiNw34rKEtVrk9GHGw
         dhgiCmxHOu6oC5Ji6deszhuwrhY8E2ICx6aO4DqvFMJAZES1dMzKtd4qjCvU9D071tHT
         oVzRPjXBCIJG2gqAdNCrcTAbejbQUrlXXGEyXlcCh6hcrcOGWLPleDnyRB8b4n+Thxni
         4viT4ao5ob+3MscdKZw7Oko6f2+sx6IVW0E2m1UvUY05f7wvcC80Vk/3a8fODGljoX2W
         IBcQ==
X-Gm-Message-State: AOAM533Zgl9K591eT34muQOa8C4nSH0A91eUAVyCoZxBsrxESEGR0IN1
	V5gljSG4Gxk82ETYW6V9vCOnXdkKo1GC5b5r
X-Google-Smtp-Source: 
 ABdhPJw+bO/1/ihlIquhjg2mJ5bleTe9CWA8MrG7RGEE+TwxjhFXS6LgOmdBsRST1zm3uNKCP4wRbQ==
X-Received: by 2002:aa7:848a:0:b0:510:44da:223d with SMTP id
 u10-20020aa7848a000000b0051044da223dmr21672541pfn.66.1652205965349;
        Tue, 10 May 2022 11:06:05 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:04 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 02/18] tests/parse: Fix one test
 overwriting another
Date: Tue, 10 May 2022 08:05:27 -1000
Message-Id: 
 <1a06e13dfbf43a4d2ed5e8246676095dc3b697b3.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13682

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Fix an issue where two tests have the same name with one overwriting the
other.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit da812d938fd79e2cc7bdf355ccf5b0f9ead684c4)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/parse.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 4d17f82e..2898f9bb 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -119,7 +119,7 @@ EXTRA_OECONF:class-target = "b"
 EXTRA_OECONF:append = " c"
 """
 
-    def test_parse_overrides(self):
+    def test_parse_overrides2(self):
         f = self.parsehelper(self.overridetest2)
         d = bb.parse.handle(f.name, self.d)['']
         d.appendVar("EXTRA_OECONF", " d")
-- 
2.25.1


