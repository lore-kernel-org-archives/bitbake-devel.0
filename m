Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713CBC531DC
	for <webhook@archiver.kernel.org>; Tue, 13 Aug 2024 13:09:43 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.71623.1723554579803714740
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Aug 2024 06:09:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Jg4yeDfj;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.177, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-710ce81bf7dso3501125b3a.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Aug 2024 06:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1723554579; x=1724159379; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0wXLMtew2QUVhTN6nAreonDhzDiFSbs3kl99N+5nSR4=;
        b=Jg4yeDfjfWbJTaQHwyACTa6fFckIXmMqHs4Si/kJErOVD1x/ylakrexQ4eAQ1gNb6g
         j8Se12fVgSM6d8fQBQIIoLLPhO6ZQrVWh/K6QLKrYpqZ3IN7BEKllrTTDSqbcZ86pZAP
         unqsZqlifo3KArk64OUzOEelJchUh2x3EdZpZ6dhanw0z11t5loTkSm4OnwhMM7+cs8C
         jjp8m1QnvpJ/h24HUxpGWFOJIyAIcY0w89UeF8sHr61adnhsHI2Bfqu+YXvWXaMiteVp
         zBAxkWKl4oz7sBZhr3jte+oALj9mDF4iArG5MX6E7PspIHnsg7a9O99HzKyA6dAR6kyA
         y+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723554579; x=1724159379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wXLMtew2QUVhTN6nAreonDhzDiFSbs3kl99N+5nSR4=;
        b=K2acsrTSdN0ydXDwlkdGO0DSCs1cHoUDfXju/QDmZJkNnSvW4zxU6qJfi+uIHAJRgY
         GCxfEzjmjLHxxoVLKCBs1KSHxtHBgvUFwmB1sGxpI25ZDomYca3ymdXVTvYEz/j7emrg
         0f2aZL2pxMDUklf74cvokoU9jJgQttv294xu72/qupaLm/ydu7E2VpOUaeZ51HkaDydC
         bK7qPaQgIJ2iqAoncWZxYwgaVjmvgUoNTpt9T9I8O/L2ZWq1BWPdxPKFx1PXDAL7QrkL
         EGZb7FKqwUIPq6Orjl00goRQL+pvoeZ8A5UXu8LgNTJ2G3fHolf+bCH5tFG1MAlu5EvR
         bjqw==
X-Gm-Message-State: AOJu0Yx+pQC5l9RJuAILTAhBQ1+CkUa3hs7A0ozkStRbofNC60Q/UkGL
	M/0GO/6RGCUKdVteiJUjMW/do6cCvWVGCUJe+R41/RvthC474P+rWvD+X8j7UImDABCDhYFzWTk
	8apw=
X-Google-Smtp-Source: AGHT+IFKKyPPddbMzYD+fSLvZFQU5FJRAUB/H5sLSN33c7nqAnJ3T2CgWomIT1PN34TZSPPHE4GXMA==
X-Received: by 2002:a05:6a20:9f4f:b0:1c6:fad1:c20f with SMTP id adf61e73a8af0-1c8d746dc8dmr4312369637.5.1723554578885;
        Tue, 13 Aug 2024 06:09:38 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5874d01sm5871606b3a.16.2024.08.13.06.09.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:09:38 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Patch review
Date: Tue, 13 Aug 2024 06:09:30 -0700
Message-Id: <cover.1723554034.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Aug 2024 13:09:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16478

Please review this set of changes for 2.0/kirkstone and have comments back by
end of day Thursday, August 15

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/7236

The following changes since commit 734b0ea3dfe45eb16ee60f0c2c388e22af4040e0:

  tests/fetch: Tweak test to match upstream repo url change Upstream changed their urls, update our test to match. (2024-06-11 11:22:11 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Robert Yang (1):
  data_smart: Improve performance for VariableHistory

 lib/bb/data_smart.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

-- 
2.34.1


