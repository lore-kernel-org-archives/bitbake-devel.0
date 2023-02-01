Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA0AC05027
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 14:24:22 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.24674.1675261460660344839
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Feb 2023 06:24:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=r0UMy4SH;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.177, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f177.google.com with SMTP id 5so18608733plo.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 06:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vOT1ZRP1XCXU8LBW7Rns4S/4rkghHvXYo9TNuq2xgMw=;
        b=r0UMy4SH1C4wUFOHc/xMzAa0956wNkPBtyyoaGgOitG6RanbVgS8yf8kWwsXkSOGIJ
         ks56hTN2QgmgD1qfNjLYuWrcM+uN5rroq/1eKcYs9sypRPe9RCOnaa8EMKFaRmE1V4JP
         K4nTkREOREsmg+OZGBe8L0SVOGa+JrctST4/z2SqKec5X1OvZtXEc2siay3wSkR62XOz
         AWaRuep977bm4JTiS2UyuzJryfubQLY9wXCLds3NkIQjzY1ZZC3k1KKG8fz5DWrLReJ2
         0Z2NBCFvuy0h0rUkXfYXu+QNaGjG0Hea8R7TDLIKlTRGsc1ahNRNKdicCJrukmLf8j/0
         YCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOT1ZRP1XCXU8LBW7Rns4S/4rkghHvXYo9TNuq2xgMw=;
        b=WAmAtYrwEeqZfhBc4PSUCSRyMiwQwDyJhn+ILF0/rLbi1RYRYZ2KsBE9sj3XCAhsCt
         ztPcoDWJka8IXdNw/AnkgiBqBORBbM/SNqKgnmFm5wsAnBjYGhRa+TG9e6KXh5m2lzt7
         VZZlyp3enRLVKljC/s2F9J/5Sn2fSteORJtR0apu2OdoBF9M4WszZIpX2/sIZgQC2n56
         M4dWVUqxwj7Uvipfe2fbtpFKDYDJObDO5h0TzvFVsRVxuuEbW727uk3p7yZ97U1l+mve
         MWHcG5pgodO/WIOtcjjPar1V4W9iscOGvgQa40+WZYsTeWlGfOXxh/AaM/+hP9TsySlC
         lHuw==
X-Gm-Message-State: AO0yUKWU7au+E40YJSyfulqHzrJ9zAn4iD07JGiUGXAnWBMPY5ZdB+3X
	5F1g76aMPCRE+s5UxOtR4B/Har9ft93i7lPQPSc=
X-Google-Smtp-Source: AK7set9IVYdplDpXhXoR6cn28/TrMDbNXQTMzc9J7W0GyZnCX5iRfy8TgSVj2StBt8sFXvAYz64AcA==
X-Received: by 2002:a17:902:d2c9:b0:198:b284:c2f4 with SMTP id n9-20020a170902d2c900b00198b284c2f4mr1953038plc.61.1675261459502;
        Wed, 01 Feb 2023 06:24:19 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902744200b00186b7443082sm11788834plt.195.2023.02.01.06.24.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:24:19 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][langdale][2.2][PATCH 0/2] Patch review
Date: Wed,  1 Feb 2023 04:24:11 -1000
Message-Id: <cover.1675261340.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 14:24:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14365

Please review this set of patches for 2.2/langdale and have comments back by
end of day Friday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4871

The following changes since commit 28ba566c25af72afe62ea3cb62b0bafeffc47de8:

  bb/utils: include SSL certificate paths in export_proxies (2023-01-30 08:37:04 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.2-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.2-nut

Marek Vasut (2):
  fetch2/git: Prevent git fetcher from fetching gitlab repository
    metadata
  fetch2/git: Clarify the meaning of namespace

 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 lib/bb/fetch2/git.py                                     | 9 +++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.25.1


