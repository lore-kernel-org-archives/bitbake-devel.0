Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AE6C433F5
	for <webhook@archiver.kernel.org>; Thu, 13 Jan 2022 14:10:34 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web12.9265.1642083033685140427
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jan 2022 06:10:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=V+gVfNBK;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.173,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f173.google.com with SMTP id u15so10169017ple.2
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Jan 2022 06:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=c3k0qPuA2JbT37qrzYrEGMqhQ2KbmLpS9svjAXVKWxY=;
        b=V+gVfNBKBgbLVMs33vhDqcNQyyEegDibR4sSbQZ4X43oTgcWY4ck2F9mp3f90+DaM2
         NsmXx9CWlBarqOy5K6ys18kii4+zSYvdh/LUD6d4fkA/iKCIlnpeEjXWH/XHjjhaThXm
         9aFt5qYjQ+r1K6FlzLF0nFXfKUtiIJO9kteVPsYKciJYAEVtZyIDzMEbi8smZTHgEALw
         vAdOb5nh94GveUvqxupjHdwURbFI3EG83NIeee9tCfwngUaCm/NgfS5uowZh5dwP7Ggu
         NR3cwKdZsoQLXFLN04Dsj/BhMx9IbTYrhk6nV8/IJNZLKZyAhaQmB/+ENPn0rsgnmhbF
         YaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3k0qPuA2JbT37qrzYrEGMqhQ2KbmLpS9svjAXVKWxY=;
        b=xm/TBAKHFS4W6uzdC3zTwxPkM25JXNvSZniC6KcD2ElQpSdUJGxd6GX3tEYCszUxkx
         Sy4YV89aAbXnhHwPINH7vmnpU2yh8i8hHZtdfGu74pAM2PLFAP9gzB6sQVYKU2y3gcva
         a8t5C03vTudxVpctTJYvU+Ppg4zbvdG0PBYafBhd39Wks2L94Y/C7HErzvqR/97CfWQA
         c0j365/q9wE9pWXEVyW/h9tNqzJEbW3AKN+92nCChOORO/V98OQ7VrwYOWWsJM348G1+
         JhnX6QITfP0VRQa7RXdiN344fg+03t+SAwqem81lP0ks9ZzhGni2IIGvYUqBc5Ca/O7Q
         pPoQ==
X-Gm-Message-State: AOAM533NaTfW8ZulwwsMbZSGKQJYuMaeiL1kbE2Ts+3vRL/afeoq5/Rg
	AaWIa4mTN9H2jIXCI+PbF/3mLYvEdsgBmmrzk58=
X-Google-Smtp-Source: 
 ABdhPJwFvHEo1tAhvy1HLuG+gx5r0p8V9D1GnewlkhOoFSAeiQRcdt1D6gHs34hPozuFaLRIWDt40A==
X-Received: by 2002:a17:90b:1651:: with SMTP id
 il17mr13826379pjb.151.1642083032707;
        Thu, 13 Jan 2022 06:10:32 -0800 (PST)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 go19sm8521033pjb.25.2022.01.13.06.10.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 06:10:32 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/2] tests/fetch: Drop gnu urls from
 wget connectivity test
Date: Thu, 13 Jan 2022 04:10:14 -1000
Message-Id: 
 <109ba4f850e7ae386a671d7ae76b4fa0af040b14.1642082551.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1642082551.git.steve@sakoman.com>
References: <cover.1642082551.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Jan 2022 14:10:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13232

From: Richard Purdie <richard.purdie@linuxfoundation.org>

These urls are no longer adding much to the test coverage but the intermittent
network issues connecting to them are painful. Drop the urls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit bdf5739c5d831dc97a7d81568f94a0953c71017f)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6ef5183b..44dc0945 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1290,9 +1290,6 @@ class FetchCheckStatusTest(FetcherTest):
                       "http://downloads.yoctoproject.org/releases/opkg/opkg-0.1.7.tar.gz",
                       "http://downloads.yoctoproject.org/releases/opkg/opkg-0.3.0.tar.gz",
                       "ftp://sourceware.org/pub/libffi/libffi-1.20.tar.gz",
-                      "http://ftp.gnu.org/gnu/autoconf/autoconf-2.60.tar.gz",
-                      "https://ftp.gnu.org/gnu/chess/gnuchess-5.08.tar.gz",
-                      "https://ftp.gnu.org/gnu/gmp/gmp-4.0.tar.gz",
                       # GitHub releases are hosted on Amazon S3, which doesn't support HEAD
                       "https://github.com/kergoth/tslib/releases/download/1.1/tslib-1.1.tar.xz"
                       ]
-- 
2.25.1


