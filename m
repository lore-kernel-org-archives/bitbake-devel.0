Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4296CC88E4D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 22:18:12 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51007.1789165091093915002
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Sep 2026 15:18:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=DUb7bvrr;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso1044075e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789165089; x=1789769889; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CGyMZKMpI7nicczezWNPLgDbwwWP/ivH+WqFKXRolIs=;
        b=DUb7bvrrLcLpJvyVrt4PAF1apI53D+9j859PZFYj6XHVaQkuvCN2TK2ETVZ+8OhGgb
         c13Sxe+iURhJuKb/DQf2lW267v5X4tBxlgUu26SR/JAzjlavIQ87BL1P+ri9U7KadYAR
         L29Lih/ZnPdsgbOcyo+MN50Iw00DgabBD/aAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789165089; x=1789769889;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CGyMZKMpI7nicczezWNPLgDbwwWP/ivH+WqFKXRolIs=;
        b=XS3bkUuYoisI1pmMVvzLCpZ9tGrX2FsBzKrrpqCMgoWWEVE6B/aGDUQLld5hY1uM0V
         O91x/mh+1duXEUO4m6mkRon33Thq4eqNuukmWjilwuG7OUx9vPs6sXtHj1lCUO2zecwe
         UDgg9QaZ5dIekFPWCn8hOHZ4YvwJkUgBJ+CVsbmSJAHbpe7eLq/EhnWQRwBWYAgUapZv
         H1twXFcqTGM7ascXz/v/5htA53oibLMbNr1g24tBuoMkXVZFCLBRZzuYDTO6bN/pxkkO
         LBsDVCb6132dkNINUuaXAzCqNdVCHhS16ye0qcGGuNplWAN9O/fRqfdJr9zmqfPnG6kn
         E4xQ==
X-Gm-Message-State: AFuF++lBSBvoMUmca+Wg+HSBPSUIArzE+doh3i2k6LLR7BtzRu6QWVVq
	5tr+gXWbUusXs0gMeCDvCrYALb13Pj6mUmWnCLR0weDhr782nN06+Ock/cOGShhhY2lLkfs1fp1
	5DSwyCAg=
X-Gm-Gg: AYBFou1mCHY86NNjZmN0DHSnbRnTDKXNkAkK8125xLgt/dmSbJylJggWFXTXgB1z1ll
	tKXtDgGqgEwSXzvQPWNtnps9ysNxOmtCO+v/Wvj+pgKqP+AeYXd4gDl9CIeL9N6mrxtSkX8YZuX
	tGUMHKZqDhxjx7I5x0VX5UqVp284NRN3bdUzc7y1LB+cMpQIJTLdXb0cty1FMB430QJI2RqiU5C
	DcrZKcstotQd4194i8DTf7NZO5CuQT7F/CZDpIskYj8dUI2ITxThrGt3Tdi+wAujoHdxiHTt6n3
	Ww91LWddmE2Z7KTVO7uq13PDewC6+xfRTCfcFMmeHf8A5zdi0j48LEh8zAd9/1gmRKYlYoX3qmU
	Yr295XD+JgCE2Qd1Wup9yKA6iwJZU/s6f0PyUawlINq5/ystxlzdgbAWoI5t8h4ILVaRlQasJ+A
	RcAmM/fZV+a443F8Q+pq8zxN4fOpOzZnTtbYn9FrDwFZ2qfIEke9MjZ0oSfv+9D+Lku//IsDTD4
	a3CYtXbt/zwRkaHFBWHKD63U0z5/geKmjw7ByQxnClR2cqbu4+4muzeFCxK2YMOBuFDiyfOl3VV
	4kFPTnW/Cw==
X-Received: by 2002:a05:600c:3f08:b0:49c:f13e:e50 with SMTP id 5b1f17b1804b1-49e6108c75dmr73303685e9.13.1789165089268;
        Fri, 11 Sep 2026 15:18:09 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a33e34sm78235165e9.0.2026.09.11.15.18.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:18:08 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/4] Patch review
Date: Sat, 12 Sep 2026 00:18:02 +0200
Message-ID: <cover.1789165002.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 22:18:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20183

Please review this set of changes for scarthgap and have comments back by
end of day Tuesday, September 15.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4718
* oe-selftest-fedora fails with 16415 – AB-INT: github infrastructure issues
  I still need to backport fixes from master to wrynose, and then,
  scarthgap.
* qemuarm64-ptest failed with 16267 – [scarthgap] AB-INT PTEST: python3 failure (test_wrong_cert_tls13)
  retried in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/61/builds/4516


The following changes since commit cff3be6f664f8f07a40727ff63eeeb24d6f5e00b:

  utils: Add NFS EEXISTS/isdir failure workaround (2026-07-19 18:02:05 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

for you to fetch changes up to cd50c3481e32afff995a143c3459cfa5ae25abd5:

  tests/fetch: Swap bitbake github mirror for YP one (2026-09-09 17:57:33 +0200)

----------------------------------------------------------------

Richard Purdie (3):
  fetch/gitsm: Store the original url data to fix relative gitsm paths
  tests/fetch: Swap github grpc repo for our own small test repo
  tests/fetch: Swap bitbake github mirror for YP one

Sebastian Muxel (1):
  fetch2/gcp: treat GatewayTimeout as fetch failure

 lib/bb/fetch2/__init__.py |  1 +
 lib/bb/fetch2/gcp.py      | 24 ++++++++++++++++++++++--
 lib/bb/fetch2/gitsm.py    |  5 ++++-
 lib/bb/tests/fetch.py     | 16 ++++++++--------
 4 files changed, 35 insertions(+), 11 deletions(-)


