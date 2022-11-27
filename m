Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8628DC4332F
	for <webhook@archiver.kernel.org>; Sun, 27 Nov 2022 21:22:45 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.101707.1669584157086806323
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Nov 2022 13:22:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gfTfIG/6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id b12so14043738wrn.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Nov 2022 13:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWx4P0SSbYjDag+0D57qbSFdnidWCcC4Br39wm2GCcc=;
        b=gfTfIG/6UUQIC5frPVnBLSEsZ1T1ZoCy62yDhSOdTrvNBR+3QKqftf/wR/G4MdYwGr
         NO3Zm1++QhkDTb72OHTaUAWBJNLYOwdzhKBQiRjpJGTSRIQXa/mYaT8oCjFUnECqpnQq
         eeeANrpX+jnlN6Htvjly5nAmOtQiGdHKekcy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWx4P0SSbYjDag+0D57qbSFdnidWCcC4Br39wm2GCcc=;
        b=WVRlbsKywC+8DIjngJxsK6TljgdURIfhfT0SV3+zWTZz2omkY47oBVTRsn5kkJAYc2
         v0ipTA2cYSe/dcj6YvqBdxA1PIO6aaCTbMLC8TGw7YpzoSrL9NUC2ao+IhBI4LT0SUMa
         HPiH54ScYGEucO7Qib0/bq36Yn+8LeV/Ae5FaiLGPKy0O/eZcVJw9VF5iB29hKKg7YZ1
         VCO2MK5oapYXt7PI4r/E4pIAh/ki4WhV2I1W8r8hGDduM3Ute0XBspDg3yB9Q9B41MY1
         boyNy/eAED1U1FMp+dxMBY5cVasVBj7sZ0GJ3XIeDF2ncdKwXyd/9BCDY5nSwvyat5MH
         BzEw==
X-Gm-Message-State: ANoB5pkj6h1eLq1eim+cJMT93TCrNioNrSS3uZNPd8ZZyYNJ4ZZ5peZa
	d4zmq+xuT2ZhyDCUuYfOLumg7GDqoWqsVQ==
X-Google-Smtp-Source: AA0mqf4oWZFESntg0y0v7uUY8FAyrwOg1HGWiNJm8H/YL5H6NgTSq2w8Tk2XljHwjztVV9JOI71H0Q==
X-Received: by 2002:adf:d4cd:0:b0:241:fc9e:fb90 with SMTP id w13-20020adfd4cd000000b00241fc9efb90mr10772056wrk.430.1669584155063;
        Sun, 27 Nov 2022 13:22:35 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:aafe:fe4:d699:e1e9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b003c6c182bef9sm21933787wmq.36.2022.11.27.13.22.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 13:22:34 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] data: Drop obsolete pydoc/path code
Date: Sun, 27 Nov 2022 21:22:31 +0000
Message-Id: <20221127212232.538210-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Nov 2022 21:22:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14113

This code looks like it is from a time when the data module was executable.
Nobody does that now and this usage of pydoc is long since obsolete/broken
so clean up the code which doesn't do anything useful.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 430d444203..22d314d6c2 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -28,11 +28,6 @@ the speed is more critical here.
 
 import sys, os, re
 import hashlib
-if sys.argv[0][-5:] == "pydoc":
-    path = os.path.dirname(os.path.dirname(sys.argv[1]))
-else:
-    path = os.path.dirname(os.path.dirname(sys.argv[0]))
-sys.path.insert(0, path)
 from itertools import groupby
 
 from bb import data_smart
-- 
2.34.1


