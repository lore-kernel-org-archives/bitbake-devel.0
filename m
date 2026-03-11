Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA86104C001
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:44:28 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18246.1773225858521224684
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Mar 2026 03:44:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VIWCceC4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c4a93841so5817654f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Mar 2026 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1773225856; x=1773830656; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ndre7JXEgb6f8xAX9fnKBWhtuzCiRuC4BZorpSVmo9Y=;
        b=VIWCceC4l2cNx2EW8qbBe7Ky18+qKHihuq7yVIkEH+AXiGkVqnUYH5oqnKHJg60k3S
         fvOfq1EdYRclRRUz+fo1cwgNBPZ/Cs6cPROFx9p8lBs1Jw8C8/clcwgynrqoiDrVv6oN
         IdjZ/GmQX2vkNSr6bcveJxrnOc/pEG5IfP7ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225856; x=1773830656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ndre7JXEgb6f8xAX9fnKBWhtuzCiRuC4BZorpSVmo9Y=;
        b=oq+4m6cpMGY3r1mBNIby0Wsfv3ApMQs2RMVp2tV8zv1kO1mYemr0P+FWK/drDq+YvR
         e24gUzQLwSwUGCfD0PpDrx1MUEPbBhcUkigD7CiZaZGWk4RSO22HBtnx82iuNjnS23KF
         gk4jUlBpxkR384t9crWgdW3XoxHhWQvcGV0vAbe3sdR4gz610frR+ME5JaFDpsWCpW+H
         K6IYiexmmH2YYcm3z/j7h33w7ftUi+zJwZzplVyAIMGgTL1TUGChK2IQ47V1FkOglVkP
         bxftikzwyGjxocnBKSIpVZjWie/Tzkj2bVs+X95aLXcDk1O8oTPFcywoR6+Avni2tSxL
         0zWw==
X-Gm-Message-State: AOJu0YzKSKBDvvVt9GyLLCd1QPErjfGyUl0jWQ71sTp2Wy+6I6cjET9v
	0u+qwKOXShdmJVcGv4bJNyI/zfmLYPtTnf05LZa2HGRGMe3gbHCNuYQJIyIXe9fvs7cLraHadAs
	Oim3GF2w=
X-Gm-Gg: ATEYQzwWrKoJd0Qyx+qvG65+CIvDY0aWCBRafpLaUpDC/GOCR70MkPIWbgWue/al/IO
	dOmlyjwXnljizMNtFi5E4fL2nBsZvGVP7iZM40KUul5eW1VXUV8USnuyLDeYVJuQ9VTVMvS5eB4
	zFOLt/c9SQZsXpmBDGJa/xY/WD7FeZqu8uU4WfOHnEePZoMtT0ac5x/CnjIHISw6OniweiCdtJY
	P/enHLwB1RB3Y0IhRGw8+O3bv1lW+ghumhcw6jhpXBoVwksSM2UiHH7dKrjhPZmxAY004MEMNZk
	iCN8XSSfrWxAXQgAmYQwlBh2155k4zCVU3pSTrmAywRUc3v/1nr7VmdDeVro5QVncikdBib9Dhf
	A1TOkHBpR1tAzvSaHTHx2QfwR1TYT3xkw3gjgZG04y1p9yp1v5LTOgh3UmTZVb6087/YEanjr/B
	sbR3oKOy+oeA+63u90iAuBbeDsJwe4ij9qG8WuHHt5AE32Qx6qNVqbhVs0H9z3ew==
X-Received: by 2002:a05:600c:1f8e:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-4854b0ca217mr34604075e9.11.1773225856356;
        Wed, 11 Mar 2026 03:44:16 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7fc5:b1af:c486:ad0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f8200606sm4701027f8f.27.2026.03.11.03.44.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:44:15 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Drop github url from testing
Date: Wed, 11 Mar 2026 10:44:15 +0000
Message-ID: <20260311104415.3415401-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Mar 2026 10:44:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19145

This was introduced as a test for the fix in 6ec70d5d2e330b41b932b0a655b838a5f37df01e
however the way github works has changed in the decade since and this
test is no longer testing what was intended.

The test is failing intermittently on our infrastructure thanks to spam
and IP block throttling restrictions which lead to occasional failures.

At this point it is probably simplest just to drop the url from testing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 74eb7347242..7b8297a7827 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1579,8 +1579,6 @@ class FetchCheckStatusTest(FetcherTest):
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "https://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
                       "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
-                      # GitHub releases are hosted on Amazon S3, which doesn't support HEAD
-                      "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
                       ]
 
     @skipIfNoNetwork()

