Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDE1CD98C5
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 22:53:28 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.33614.1781132004214593902
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 15:53:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=15GqDTtr;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so50063905e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781132002; x=1781736802; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LLVPTjkqosh1wJaBP69LS8t1/GcfX/Zz4SlkTIkeHRo=;
        b=15GqDTtr2B5mnW2cYSn5XiAXDGnAu5LXB8AgARIKcAKdoaZ/Zzf87hLewUFoUePElo
         J+ZUxxpICS08oINE2jkJ+A35G2JljuhMoVwdeh/kCQtdnxROrFtpHoATcd5We69xgI8C
         npiYaaTE7EJs475p1wjKvbO8mX5oWxis/pcUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132002; x=1781736802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLVPTjkqosh1wJaBP69LS8t1/GcfX/Zz4SlkTIkeHRo=;
        b=eWCXjh9SrWn2p8db+0JZazo39tBzkYmJHnaVIWrjOcoxnB2M8ioQ5hvhVsB7Ti+BZo
         63rhqLH1qfpDpeG0mLAQFGQ065/IlrcwVEaTDocksVA8+qCJ4xCv+Xm7poWjYi5mrYCo
         9IFIvhxnkZyWc1RQ/cGkhZRCyn6kTfVYvh9MpW3aDCsOtLSnO1sQZPEQHOOmHinKF8TC
         Ovxvdd3EMx5AvReY7FZyjfa2BDFnFdqhFqyvSPx93Pf+V5RgJ0AHMzBY+c3NitKJ7Fsc
         6bRFhXN8BI22it2rc6Gs5Mp0twYzbF1uhQTnrBYI6tKib3KFKL0NvKgHXYLGvmylO+Nu
         zLSg==
X-Gm-Message-State: AOJu0YwPKMpNjGmzYTQKBS6JlqGdGXkKGv4TiYruluw9XfzzAEiErHuh
	xPRaJmS3qnXa6mNO2rtE124mB1ciJaEIj0MTq+4xcdGHHd+ZmpCDiWascaI7c6adC/ZGdrhPX3a
	J9dWH
X-Gm-Gg: Acq92OEIRonNtdJ/LIIIAU1r7x4N4vst8Hyw/yyM5sBgM9ByExd1gr8SMLWZEgP5uli
	DvSc2v3+iIoci88VuRn9hPfHaYklYnCNa+KyaPqZxWArqwVT5mA+83rOm/ftFK0IbPG9dnjYoIN
	mBz3cAuRJ2DmK4x0RR//oOUtlqqeBFsYtGMxwyvnO7Jn6zm5YpvaLnjJaKdmuUBowtBP1s85OMz
	W901Q1RnLFR/VWEO4J0+X/IAeaiAxAgrb4Eidf/TbTt6NMyB95xN14BfQXD5sdk4y5T5cUpGTAG
	R9HRI7YST/Fva8D0khJcGOSS2WnT1Gyq3e1xsCZktao2/skmhSfhMbM7AamVN0YFGiV2HAimTHo
	XJwkQJU9r5lqSKrbHwl62QgcxjRwO+q6d56VqHGvOZd0YCTwsnH0BT0culHLI7LKVXQlF1w67Ug
	j5stR8Q01mzWWniUWVCYrfAjYvXg5Spu12wM/eBE9w+qW4yWpWh6YKUy53CzDSK79/wyjVvBy6n
	p4ZxfjP5pIi6BPeY0iup2XWjFCwD2jvZeL0bR4=
X-Received: by 2002:a5d:4f0d:0:b0:45e:f188:393d with SMTP id ffacd0b85a97d-460677b572amr189436f8f.29.1781132002219;
        Wed, 10 Jun 2026 15:53:22 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00bb749f54eeb85d7b.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:bb74:9f54:eeb8:5d7b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm132348771f8f.29.2026.06.10.15.53.21
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 15:53:21 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 0/6] Patch review
Date: Thu, 11 Jun 2026 00:53:02 +0200
Message-ID: <cover.1781131922.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 22:53:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19647

Please review this set of changes for 2.18/wrynose and have comments back by
end of day Friday, June 12.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/3963

The following changes since commit 294074e65f37822a0f31bb11eb968d311b54a66a:

  toaster: use https for clones, remove cgit in links in defaults (2026-06-06 01:17:50 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-nut

for you to fetch changes up to 52b3bff42f17933595af48654098b172ea10baff:

  fetch2: allow empty value for params while formatting URI string. (2026-06-10 14:11:31 +0200)

----------------------------------------------------------------

Anthony Squires (1):
  fetch2: reraise IOError during download

João Marcos Costa (1):
  layerindexlib: restapi.py: fix unbound variable

Marcio Henriques (1):
  bitbake: fix issue with varflag exclusion

Thomas Perrot (2):
  fetch2/crate: skip yanked versions when reading cargo index
  fetch2/crate: guard against empty version list

hongxu (1):
  fetch2: allow empty value for params while formatting URI string.

 lib/bb/data.py               | 2 +-
 lib/bb/fetch2/__init__.py    | 8 ++++++--
 lib/bb/fetch2/crate.py       | 7 ++++---
 lib/bb/tests/fetch.py        | 6 +++---
 lib/layerindexlib/restapi.py | 2 +-
 5 files changed, 15 insertions(+), 10 deletions(-)


