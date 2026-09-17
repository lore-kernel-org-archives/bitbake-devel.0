Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154F9C982D8
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 22:17:20 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1871.1789683433807699734
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 15:17:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=NxfO7I5X;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e64ccso1043655e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789683432; x=1790288232; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uEa/ZQSRMKtNaIrsk+XiFMSRuF83qtmV2dd2lJEMvPo=;
        b=NxfO7I5XluJaoVQHj9w2ZWHm+pplWxwdyPRVSRgYt47WGhoaBV2vKaSI5jbKdoODvr
         xTMVThhAhHmwJM04YmRk4XBYhkS8bhNjkRBw+DEIorugvnUj1a8rL+552AFVSIswIu71
         ciiXY+Vv1+cEA1g/d6HtNwTYkKngvR7C383f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789683432; x=1790288232;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEa/ZQSRMKtNaIrsk+XiFMSRuF83qtmV2dd2lJEMvPo=;
        b=UUfm5Rk9ns/jtq1oX4cV6bi6IMTInElbl4Zd+rxCF3mTPmjGd0o4DZMOqfw9zQvt2s
         EXdJ00b5P6iZ01RF2dK1teIFguKcBbVohCBUM6fBODxBM2e/fYJA3y1Ea+nKsBwopKkb
         c690n9Z+KIbytmzv7nZrJkB0V0Jydh04L6Ml3doFksphbqlVfqQ7yxMSgbn1x4AWMNk/
         lH+1PMXYiACe38sjddDmZc0kMlHFCAZAITs/3m9KdJCkaB/0CRFsSnAT6LLlmDDwIG+m
         P0YTsCVCmNI2krawHPzEtLn/Ez0Nl+esusnk7e//g/E3EJfpRQyepggTGJi2R86FfBQA
         QJ/g==
X-Gm-Message-State: AFuF++l1p7lJab2Q1rTwLmEqu1/axTFlaG4Jt09OCjn779zGnN7GIlg7
	MUOaih3P+/PLMDS6qf+r+ViqDmyL0Sw2gc4+DaWphAE0OlSmJlPnAZ5TugPG/LBdqB5S4/yAVKT
	+JL75Bbw=
X-Gm-Gg: AYBFou3wVKyQSwY7Q2Iyt0IYC3jUMcO99BH4P8v0GfvNcqREv/sGav5miEsxAcRTcHt
	n66kvFvQSBmX6Np7bTWqNA4Q3skfEENaRTlWHFXbV/cojtec/deRQPuPCw6WLTR3GVu9nBeJInS
	ypnFId7nGbIy8WhFiIsG6gK1uEh4Gh8chJjX2jWQWpenmSMZBEBLoQyF9Ep0b51r8x+NRQNtqMx
	PL0dLMxCNDrE87lt9Nb179vK73f9220RO1B+Q4AeDbTSB7qLGhoW570RciwuSqFqmx3arotpbOn
	lYwLL/v3xQcwpApgiLP9hqpYk8H8P8POpxaJLR4qhKDVhX6ydP5AKTKpepN4ZxvFZ8MW1kqCU5q
	1+/qS8B4DBvARUTMC4reEpEAIjBQe0j5YVrvM/IEeR1XqGXpLamOU9kXI9a2Xe547SMQJP9P/QW
	eP4soFQ8EtJ0yxVkUvZgJRJsgT9biimDTiCwq8HbQQX+EeVGG6aUT2R3TolNaDDIyuwzIz+eoRl
	x6m0LCwyyVqCCb3T22Z1NTGkkNjjS1Y7zd+UmhmRKHNZfmtFvatA8hmKnmW1oXVbbDh64w1p9Lv
X-Received: by 2002:a05:600c:4e14:b0:49f:bd3c:bc19 with SMTP id 5b1f17b1804b1-49fc572eff5mr2896285e9.20.1789683431724;
        Thu, 17 Sep 2026 15:17:11 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm185737725e9.11.2026.09.17.15.17.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:17:11 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 0/7] Patch review
Date: Fri, 18 Sep 2026 00:16:58 +0200
Message-ID: <cover.1789683244.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 22:17:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20223

In this series, there is a notable exception to the usual stable
patches:
* Work toward automatic upgrade of stable recipes:
  * fetch2/git.py: add filter_regex parameter to latest_versionstring
  * fetch2/wget.py: add filter_regex parameter to latest_versionstring
  * fetch2/crate.py: add filter_regex parameter to latest_versionstring
  * fetch2/__init__.py: add filter_regex to default latest_versionstring
  * bb/tests/fetch.py: add case for filter_regex parameter in latest_versionstring

Please review this set of changes for wrynose and have comments back by
end of day Tuesday, September 22.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4761
  qemuarm64-armhost failed on 16233 – AB-INT: 502/520 and other errors on yocto gits
    retried in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/8/builds/4700
  qemux86-64-musl-ptest failed on 16348 – AB-INT PTEST: python3 ptest failure: in test_interrupt
    retried in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/110/builds/1211
    (master has the fix that I need to backport for this one)

The following changes since commit f0df79b6b56f6a69067adf974978d9405077f246:

  tests/fetch: Swap bitbake github mirror for YP one (2026-09-08 14:13:56 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-nut

for you to fetch changes up to 84a8d046593840df460c1312365031c817eb8918:

  tests/fetch: Drop ftp checkstatus test (2026-09-14 23:00:27 +0200)

----------------------------------------------------------------

Chen Qi (5):
  fetch2/git.py: add filter_regex parameter to latest_versionstring
  fetch2/wget.py: add filter_regex parameter to latest_versionstring
  fetch2/crate.py: add filter_regex parameter to latest_versionstring
  fetch2/__init__.py: add filter_regex to default latest_versionstring
  bb/tests/fetch.py: add case for filter_regex parameter in
    latest_versionstring

Richard Purdie (2):
  tests/fetch: Switch to YP mirror repos instead of github
  tests/fetch: Drop ftp checkstatus test

 lib/bb/fetch2/__init__.py |   2 +-
 lib/bb/fetch2/crate.py    |  10 +++-
 lib/bb/fetch2/git.py      |   6 +-
 lib/bb/fetch2/wget.py     |  17 ++++--
 lib/bb/tests/fetch.py     | 119 ++++++++++++++++++++++++++++++--------
 5 files changed, 121 insertions(+), 33 deletions(-)


