Return-Path: <debrabander@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC0BC4332F
	for <webhook@archiver.kernel.org>; Mon, 12 Dec 2022 16:27:01 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.47790.1670862411729533226
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Dec 2022 08:26:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=GfcSU798;
 spf=pass (domain: gmail.com, ip: 209.85.218.44, mailfrom: debrabander@gmail.com)
Received: by mail-ej1-f44.google.com with SMTP id vv4so29444553ejc.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Uuko46xmuZ71Ebr+wGgLCRVYGx6ckxMqVWOssCSZFo=;
        b=GfcSU798cM95wLcb6UeZGp7AFIN6Sb78U/2qmlOCgSt1EnFerhvnsxzOTnY9k1hFyk
         1QOP1kSuZUtj5eZRGsGzdky3GZE+m+Zd3HUAd4uXkT4FUBViCBLxkD9QLIhwF8Y8wkYr
         n7G73TQlv0os1XQpNbT/N48C1xcAtqOXhmpJ2PnMI0qkV+r0ZFk/56nafG61CMlHF5+E
         FVRS/PxAgHOrWyqojRlDvai09gKfK5BWwcF/udmzdBkqq/DvZ9IO3/atQJG470zreHKd
         FoKx0bbVHdzwaSh5cAZ/J1v3fx19Dxab134N92mK1FluCzGxGpag7wiqMsdbArbbU/md
         JyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Uuko46xmuZ71Ebr+wGgLCRVYGx6ckxMqVWOssCSZFo=;
        b=MTRsT0WDQKI8C2dZ5MxDeRWK2Bia/kfKjFczkf0+XqRbU93Dstmn0HLvBpr3t2nXVC
         porutmD8ZjzUpU6fZMzByPW5uyZ7mCzK7ZSP6J2JQD8rNgalFVIXqh1RnVvZsfR2Em+w
         PKTej9CiJDkJp1iB5rB+bkXzqs4YoD9/Dw5RZvCBpi5bU7g42wz6kz+2JFsQ1kJ4WjHy
         BSq8vNvIm5tB+rSXncvwqM28KwWN3wBW1vs+aSeazL18213eDoCwDVvSOK7y2Lnd8IR2
         b6FukGL3mHHW4hQ5USUMBeRWrkCneaNEicVZ0azdyBJoIrQpgcTJd6LeHvuT/U3vJZ83
         xIDQ==
X-Gm-Message-State: ANoB5pnxO8mfSbJIJdOicuvfo303/1jbbxF7tewYXC54amnoxLABVAcm
	szeTresv9+fcULQ4R0T0HI4GUu9MKJmKfA==
X-Google-Smtp-Source: AA0mqf7YFU/J3KQLsex5I58iq97u6ZETV1905sFuiTveNNGGEKhrrcbn7VkNHztlefSTE760+OFeuQ==
X-Received: by 2002:a17:906:57c9:b0:7c0:e0da:10b9 with SMTP id u9-20020a17090657c900b007c0e0da10b9mr15433341ejr.44.1670862410129;
        Mon, 12 Dec 2022 08:26:50 -0800 (PST)
Received: from polar.foobar.local (186-153-172-081.dynamic.caiway.nl. [81.172.153.186])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709064e8b00b007c0d6b34d54sm3420973eju.129.2022.12.12.08.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:26:49 -0800 (PST)
From: Frank de Brabander <debrabander@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Frank de Brabander <debrabander@gmail.com>
Subject: [PATCH] README: add required python version for bitbake
Date: Mon, 12 Dec 2022 17:26:16 +0100
Message-Id: <20221212162616.16189-1-debrabander@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 16:27:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14183

Signed-off-by: Frank de Brabander <debrabander@gmail.com>
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index af23c9af..377d0032 100644
--- a/README
+++ b/README
@@ -13,6 +13,8 @@ Bitbake plain documentation can be found under the doc directory or its integrat
 html version at the Yocto Project website:
     https://docs.yoctoproject.org
 
+Bitbake requires Python version 3.8 or newer.
+
 Contributing
 ------------
 
-- 
2.20.1


