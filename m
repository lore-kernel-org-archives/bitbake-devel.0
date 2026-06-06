Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A8FCD8C8E
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 21:20:06 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23173.1780780802937454544
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Jun 2026 14:20:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=G1P4mtMF;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490ac10e337so27349685e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 14:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780780801; x=1781385601; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4/8A8Ah4PnxHLqIpl04T9fynPyhqhQ3U4UyM3OrSr4=;
        b=G1P4mtMFDbaCaRH5ie3uNkVhIOkspgJ4BO+mCvRPPHzr2siWBynTbTcJFuAvuM7z1n
         /VBDVgB5wsuLmMpQ/16aSw6W6pwA8uJqau9jxMeOqZcPWRPrSjaBe2P8XrTQ671c4vyn
         Pxu5BLaC3PAj4LdADzUYTG23aJMNvJPrdBP9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780780801; x=1781385601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4/8A8Ah4PnxHLqIpl04T9fynPyhqhQ3U4UyM3OrSr4=;
        b=nWQyeFzoBZE0AJyqsffsYF8iw33NE++ypx/uwESSDIPITDbAiNUejS8ftL8nS3oBuV
         e+UwV4CQMNZUuCfc7YY+TjAHS7GvexKjTGtaAKLS7gzuubrqps1VzeOd5z7oIumckuF2
         P5N0JguIKLEUBPhncblPLJo4Enmk/ayleDTakwcoV1IeRTcWcTiPZ/5iPDeYkZtjjREL
         FcBp3LqWCqF/7GI/bUO/nsUa0IV/Z9kZqDBTC5EM2vKB5v8diYrIU6+UTX/B5i5RMoiD
         JDrTh7LF8Icyjhdig13/hBHUhG7PHDCA8W8A88jZauQAcq2+ODgAWQxWRpiU9sir74yk
         7uaA==
X-Gm-Message-State: AOJu0YzsUYhVIDOkMC1sr5/snCNlsrRnpcTMnkSyAk8SoNKRICXPY/rT
	BSJc/3/4z2IBM/3drjQoXSXY9/9UQsy3lrXcQKymgqJeYEGFaflhM/CrZFM7LSrEhRh/486pzMW
	0Sl2w
X-Gm-Gg: Acq92OECy/8dKaLqlBCU5uvgR2xcVS4eM9cQ5E9MKQFgPwDlTREUDihYb8i6LgVwOJM
	8NIMgzODxVhKtRJIRrAMnZeVllmnOtCZxaMXmNFJnx8Ibnl0CXvE8jb0xfzENYO0SwxBFFUt2EO
	sa11b5uR98TylLw4tG0ZZiMwTcLz8y/AZdTsyRpj9T6EUwkwCHQhnQpOHPmK/1YGva83SFksSnn
	Dm72tqWOxCwEcgEkCR/6Fks8nwxLl+XqbpTCP/IBqRlLsu4npoHsD76ylFsoG8o8W/g/bGsi/DY
	a1G5N31uzUxIEWO+9fdZ2yWEKRs4zNscRW9UEqFUKH117BIc2Qkz2bjVHhcv/dymWI+sYJk3cRC
	i5480qcEpfjwJ4tiwHjV2/Lamniipl2zCc/hbAz63npcE7mlKTjjPAM0jbqPPhdQp8a6jgg3McX
	IWIhuyMIUARpd1fjWx/pWCzRlM3hQ0DUoD4mPxgqMB/ngUdInPP4ul2oOqcNNgbRFXyzbShgY4q
	nNmiDLXbFCGBZEF+zU1tkayI6el/2zpuFEcnw==
X-Received: by 2002:a05:600c:83c6:b0:490:6e12:542d with SMTP id 5b1f17b1804b1-490c25fc0e1mr159259795e9.19.1780780801216;
        Sat, 06 Jun 2026 14:20:01 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa000f4f58971dfc8e81.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:f4f:5897:1dfc:8e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm314340625e9.9.2026.06.06.14.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:20:00 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 0/3] Pull request
Date: Sat,  6 Jun 2026 23:19:36 +0200
Message-ID: <cover.1780780690.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 21:20:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19629

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/3940

The following changes since commit edd1cd43eee1a1f87dcd1ca356ae4247c41eac8f:

  fetch2: Unpack RPMs with --no-absolute-filenames (2026-06-05 12:57:05 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-next

for you to fetch changes up to 294074e65f37822a0f31bb11eb968d311b54a66a:

  toaster: use https for clones, remove cgit in links in defaults (2026-06-06 01:17:50 +0200)

----------------------------------------------------------------

Anders Heimer (2):
  hashserv/tests: use valid 64-character unihashes
  hashserv: validate unihash values

David Reyna (1):
  toaster: use https for clones, remove cgit in links in defaults

 lib/bb/siggen.py                         |   9 +-
 lib/bb/tests/siggen.py                   |  47 ++++++
 lib/hashserv/__init__.py                 |   7 +
 lib/hashserv/server.py                   |  27 +++-
 lib/hashserv/tests.py                    | 193 ++++++++++++++++-------
 lib/toaster/orm/fixtures/gen_fixtures.py |  31 ++--
 lib/toaster/orm/fixtures/poky.xml        |  40 ++---
 7 files changed, 262 insertions(+), 92 deletions(-)


