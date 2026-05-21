Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BDBCD5BAC
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 15:50:37 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39921.1779378629701908649
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 May 2026 08:50:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=qFy6oIQz;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44c350a5b87so3899343f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 May 2026 08:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779378628; x=1779983428; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0CeFalJCj40ZrFgDryezwlz9YFqG77kN/NSWpGe408Q=;
        b=qFy6oIQzt7VqU+8YpAGSfR8Tnr1/l2QwNzAS4Fna/u7Bkaqy7CoN8U4tEwl8GtgFQs
         Z8RTv91b9F9AGzU/PD6Oj4Iya0F0gL8lTBPO+53fNoEA8qCBcclSYCqXY5AHN659W0dt
         slcN0c9NlJjz29eHPKzxhykau3sabAIBjv9Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779378628; x=1779983428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CeFalJCj40ZrFgDryezwlz9YFqG77kN/NSWpGe408Q=;
        b=Tan4TE+Ct7x2wcpTzcg2jHitGbygDERBXH8mnwT43yfJBt4AFuqEWncL2cpfF+E9yE
         u0taApM6TEEIuEprAzkvpm0mKabgJztZnS8K/EI311fo2Fu2pEZ5S6eYTYL0e3Mi0wlN
         CYifYBCyKM9xB159xQNmsatUviYGuPvX1EIQLNHEHDS9U0WgvWmGOPIL/KS8+KS3tCWm
         UbSriBq6th7VBBAWsZC26U1gP1N4/6XkIzQ3blup/g/Kdfeos+czlm66Pkb7RJulQoe6
         7cT7c6cUKlsAEuCg4XcP/EDroXcDP1g3/tD0M3mPaYf/AajDN6tviZ+aj3YT2Ft+5Pc6
         81VA==
X-Gm-Message-State: AOJu0YxwNYMPpuAQSzm4baBLgfpCcvTXDR+f0wbH5wrW+X1zZZCjk3xH
	IR+cozwrB38ea5cTIA341jC0VkWxpNDpFdo2MgCykkvruXlNsqMp8ylXT0XcPLb91QgpdqsT1PN
	FpUgx
X-Gm-Gg: Acq92OFu4YCgFIt4MBkPU1vU43vAdleQKt2qTpPdnKP2dMGzNcRPXN4Bd6hUuxdLtzz
	flrr8KxKwvA+5QHsM5F6F9X3wfypqvP3HBQOBFZ/jUlp9b93cN0viGkaQNqNp08HTpYmnxAGctz
	BfHcz7o86G+lVASw8W6eR6PZIUiHhF3otNzcRT2mPNuu6UWM92GMqM4mQzeqBzD22C/bYJkVFNw
	Z01uNVfZ1Xiq0VHo6bVI4aD2xZ1QpQLyNI00urxvR4XbaJWYhXTuF7ViLdbJrUOtQcbSqZfeJfd
	vRHo2Qhdl0QbjYCHNAM7x7eXPdNGeeOf7MeclRL0BwOwE5VD7/rnrJjsx7wWta0jNP9LwRmi6wK
	rJeOWtEgw0Gt8mWUqyl6Uq2SA0MGQ/g/7wOO4lPrWboEPSOPihlkx8GCb5aPJASliEguGPbH0lw
	AnWJCxOdXsFEchRa7mrUdXQaJSDEEprSJA8LetrLzWVqdR+E2Z+mptwp8q7o3Qzlr9uTGOtviDy
	6YCkuqSKwc20+E9Px1Vj1fVs6hl5mlyuBsngg==
X-Received: by 2002:a05:6000:240b:b0:45b:d5d7:1f59 with SMTP id ffacd0b85a97d-45ea3ff7b9amr5706045f8f.24.1779378627852;
        Thu, 21 May 2026 08:50:27 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7d9daasm4256740f8f.11.2026.05.21.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:50:27 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 0/3] Pull request (cover letter only)
Date: Thu, 21 May 2026 17:50:18 +0200
Message-ID: <cover.1779378493.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 May 2026 15:50:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19548

Those are the patches from the last patch review:
https://lore.kernel.org/bitbake-devel/cover.1779233514.git.yoann.congal@smile.fr/T/#t

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3851
Got some AB-INTs but nothing related to this series:
* qemux86 https://autobuilder.yoctoproject.org/valkyrie/#/builders/30/builds/3766
  => Bug #16284 – AB-INT: do_testsdkext failed with no clear reason
  retried as https://autobuilder.yoctoproject.org/valkyrie/#/builders/30/builds/3767
* oe-selftest-debian https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3884
  & oe-selftest-fedora https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3746
  => Reported: 16292 – AB-INT: Hung up HTTP connection while fetching on git.yp.org and git.oe.org
  retried as:
    https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3885
    https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3747
* qemuriscv64-ptest https://autobuilder.yoctoproject.org/valkyrie/#/builders/56/builds/1616
  => I reported it: #16290 – AB-INT PTEST RISCV64: procps ptest failure (pgrep_match_against_full_process_name)
  Retried as https://autobuilder.yoctoproject.org/valkyrie/#/builders/56/builds/1617

The following changes since commit 0415a00658b59f66bdab22a3558794f238c42973:

  fetch/git: Improve temporary directory handling (2026-05-13 17:50:24 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-next

for you to fetch changes up to 22021758e66737bcf68dfd2b74adc6a0cb1d42d9:

  README: Add "2.18" subject-prefix to git-send-email suggestion (2026-05-19 11:08:15 +0200)

----------------------------------------------------------------

Alexander Kanavin (1):
  fetch/wget: in upstream version checks, match versioned directories
    exactly

Yoann Congal (2):
  b4-config: add send-prefixes for 2.18/wrynose
  README: Add "2.18" subject-prefix to git-send-email suggestion

 .b4-config            | 1 +
 README                | 4 ++--
 lib/bb/fetch2/wget.py | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)


