Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86279C77B73
	for <webhook@archiver.kernel.org>; Mon,  1 May 2023 15:34:09 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web11.97258.1682955245876926225
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 May 2023 08:34:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20221208.gappssmtp.com header.s=20221208 header.b=Jb5QBTDi;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.170, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-63b87d23729so1821319b3a.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 May 2023 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20221208.gappssmtp.com; s=20221208; t=1682955245; x=1685547245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8l6hTh6Y0pFTEwJ7tV1+UymACa0ryGrCAIGFBiaxAK0=;
        b=Jb5QBTDiofFC4P741qT9xaF/pNGzf0Xc6Sc0+YyyKTDTEVf3LALhj6HI18besG8umT
         lCXaVkvZDZTC5P3qIEueKBAfI7BTCR4csb2Dfg8Bcac9P+lCJUU2nchoPnr5FMP+Izsd
         lhaZsIQ96LC84ZN5nxJskVouxit09rvxZJRsaEy2Co2SjwNnmT+Br9+YJg5ThwBLXszB
         C7IXRFR2DCWFPh+w5USv5oOxzExGt5ZcYtfSGqEA8mY7ZJO3K1+GTG5BrN51PqK3wuYy
         uGg+o2OErwCAfXaylhWT8ACQuiFG2bkgVp+6TKSGEhkPdqEAEy2myi3pBhdxUTvW4xZX
         3cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682955245; x=1685547245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8l6hTh6Y0pFTEwJ7tV1+UymACa0ryGrCAIGFBiaxAK0=;
        b=JywpRI+1eENAUMKY6WQ8BaMd+84hlqaUQUOyjDDvo8WiXhbu4JzlDXcrJebvADhzKZ
         0E+KK3ENCIti+MJ1pULxxu4+1RwHAZQQVgDHZGKJxEBDcBOGkDVWIU22P2BBZ42Jqw8b
         MFyMZteFz3Xu1YmlmAA3Twc4T/Af8ABRguJQForQbFeAY/7sNsUJFbqGllhRRSufKHod
         97s90mdFC7ZqxAUo/YbC3fyuHqXzMaBrJiyjmyyCUCpLciGkoKtZUojKNEWMXaIvbiTW
         7tHhGYYzBgmqkgTHSQwF6Dldl5FMtF5mzgsVoi7ZK0yfcAefWl+IZOrTvwGFeXmDHw6m
         IqEA==
X-Gm-Message-State: AC+VfDxtZQi6zygFE9DPFwLw1CErN+CZ+1VjJQPxWvrLSWqbjNe1xoUc
	ahcsyKx/Ich8cavIszc5cjIC1Nlc2ZiAdiwsHqI=
X-Google-Smtp-Source: ACHHUZ6VG552PBsM7kBABoSBLk4yagLFrtaHzUGVZYvRJsfDzzVwbn0vlF4Oa2ubwt/wbAFJD8SAkQ==
X-Received: by 2002:a05:6a00:15c4:b0:63f:1eb3:824b with SMTP id o4-20020a056a0015c400b0063f1eb3824bmr21481409pfu.17.1682955244690;
        Mon, 01 May 2023 08:34:04 -0700 (PDT)
Received: from hexa.lan (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id p8-20020a62ab08000000b0062e0010c6c1sm19931957pff.164.2023.05.01.08.34.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 08:34:03 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH] tests/fetch.py: fix link to project documentation
Date: Mon,  1 May 2023 05:33:56 -1000
Message-Id: <4d45d9f9fbf36e0ff61be3c7a31a532b10c52f13.1682955165.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1682955165.git.steve@sakoman.com>
References: <cover.1682955165.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 May 2023 15:34:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14763

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 420faa19..61dd5ccc 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1338,7 +1338,7 @@ class FetchCheckStatusTest(FetcherTest):
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.2.tar.gz",
                       "http://downloads.yoctoproject.org/releases/sato/sato-engine-0.3.tar.gz",
                       "https://yoctoproject.org/",
-                      "https://yoctoproject.org/documentation",
+                      "https://docs.yoctoproject.org/",
                       "http://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "http://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
                       "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
-- 
2.34.1


