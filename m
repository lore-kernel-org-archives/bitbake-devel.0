Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8539FC3DA63
	for <webhook@archiver.kernel.org>; Thu, 18 Jul 2024 13:48:41 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.15448.1721310511772019957
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jul 2024 06:48:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=q23nlgtq;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.45, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2cb585375f6so240744a91.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jul 2024 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1721310511; x=1721915311; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OgMddIjjR9jxuYyWjF1shGGcdkpjY8AbabKwqiBZCw=;
        b=q23nlgtq0qbk0i3VNBnM5b+cwFl5hIoHVb91txzFTFuoU8u5ICfBqK+n1y07eRpZtq
         FLBMnD7RqHaOdZOfrqkKVBkbKCYlSbC54Bm/P6iCfpX6iVfH9RKk1HDspLn4aZi4r0vA
         Uw1wL9RamQAvunbk2RYoiQPHibvPHxvZhNCZswtnvW31zpdDDzUQGetZye8xFlAE/nBm
         Epp/SPbQ+6MEjtSleEzeHsw79Odb82iqyzYQwsGI8nGwg1WOOhhERkWxyuExbAZ18L2a
         k16s1h05NNz71IfE7TZEkPQ2rO025Oc5UNscgTzP8DIK7MuEO67U6vNbwPMuUbOKFfjj
         Yz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721310511; x=1721915311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OgMddIjjR9jxuYyWjF1shGGcdkpjY8AbabKwqiBZCw=;
        b=SZPrCyopLWC3Zu6kturpIyQooWU147wl6aziokDAa2QZJ0eZL6KdefnF6ldWYn+HFv
         Az/9/Tdag21fxsadQvtvei6ln6fL0P1Ony3sYtrFJmQS9YsMv0rb/pAcm2TKhirix1WB
         FN3MgAtzaDwCKk+Clo/bUCxGGhVMUKkf64pvPrN/HxkJGOrFNenxj9ipgslzIwPI3dRI
         3bIh0fezMwp9h13so98yCB66cRpSNt8en2C660XPQ0JZqf8EKsV9+/Eu43zJkoH1gPzt
         MHrTTY23SaKjHqaLYRluAT2ZzoCqG8YxLx/pAQ6oRe5WCTZ3QcJW85aEX5EYOriaPgNM
         NuBA==
X-Gm-Message-State: AOJu0YygpDehvCJikPm527j1lS/02NpIIsMSyC9PvpAEMFy2h0g0zjbW
	nW3aurHyiddU3QnxNcPjjMvP0V78Ge9JTHvk3WB65tjpbfmNReIXSk/tBHHvIT4GbwivMB5upUr
	U
X-Google-Smtp-Source: AGHT+IHxBri7dCqKdGvRQEOG42OFKZic81QpquVEc42IFJfFRivoZzNx3KSYdHMboGpgAbff5L7aAQ==
X-Received: by 2002:a17:90a:5302:b0:2c3:40b6:293b with SMTP id 98e67ed59e1d1-2cb7755b722mr781807a91.39.1721310511013;
        Thu, 18 Jul 2024 06:48:31 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77a33ee9sm671269a91.24.2024.07.18.06.48.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 06:48:30 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/2] Patch review
Date: Thu, 18 Jul 2024 06:48:25 -0700
Message-Id: <cover.1721310419.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jul 2024 13:48:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16423

Please review this set of changes for 2.8/scarthgap and have comments back by
end of day Monday, July 21

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/7150

The following changes since commit 8714a02e13477a9d97858b3642e05f28247454b5:

  fetch2/wget: Fix failure path for files that are empty or don't exist (2024-06-14 08:48:23 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

Richard Purdie (2):
  codeparser/data: Ensure module function contents changing is accounted
    for
  codeparser: Skip non-local functions for module dependencies

 lib/bb/codeparser.py | 33 ++++++++++++++++++++++-----------
 lib/bb/data.py       |  2 +-
 2 files changed, 23 insertions(+), 12 deletions(-)

-- 
2.34.1


