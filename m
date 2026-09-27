Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77591C9830E
	for <webhook@archiver.kernel.org>; Sun, 27 Sep 2026 07:46:48 +0000 (UTC)
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33617.1790495199607800914
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Sep 2026 00:46:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=0MNxmNhj;
 spf=pass (domain: smile.fr, ip: 74.125.225.99, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488780459e2so2088249f8f.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 00:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790495198; x=1791099998; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u+b1dCwiOGg/IiTm3c566cdVEBdPz9EhznD8l6s/h9c=;
        b=0MNxmNhjIUZ/iEICAJJDV+MW1Y9T9J6d3SdqYw99TW3bDUWwZd3PjBfqohOyrO4ke3
         yGR5FYU+0ppja5+gxxjju37WGr1+9lI1xZKKR1ys4i277c1UwARWw6hgQekbEnjRAxDH
         6350xhi7hrz1wQq+Q7F/N4lHupS4npaI6r/iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790495198; x=1791099998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u+b1dCwiOGg/IiTm3c566cdVEBdPz9EhznD8l6s/h9c=;
        b=j3A8L8cysNIaMOaWtWOS2PBSkGd18HwCIZUFnCUe+GdbfLy0yGz5uBYpuTIyrDGArA
         PaIi7RtuOoRcz9TMOlXa5Bh4NzSD3+LCJLS5q2wifYEhmu0MGb7ePlnA553VeTSWZxcT
         +wVCCwG7eWxG3kMy3Kz190UT6ssok2Vdxf/EhXWraOfLMWE67A21RLdpzS6tUJ/fJ8YK
         u9OhdaBEuc6PoKCx3kaxc7jqe0RcrYVFaAUrn6jEuAGoO0AJWvACjEnvU5/8z4+2oWGz
         zzY56jJqmsn+rCTQDqfGdspXEKVyAXV9T2BVKs8HkLG20tLd6SaqgSCZuAKJz23WlH9z
         kYSQ==
X-Gm-Message-State: AFq9FYKfNUiEzCSuFqAQywmFmcByQV8MeFDWB1FvIp2LKLDCtG06ZIjd
	G2nV3aVcL497PVccivfw6ddCKUBp8jvx6tTTrq5Bn98yKfYVp66V6FJpLIXh3Y+6XM4rZ14i3FE
	vbnsThpw=
X-Gm-Gg: AYBFou1MackDfN50VNDg22N/cvQgv9Nqb4wXgDCem1VKClgbSiOMBM+4dTRQcgdEhJ+
	LcyEQZMeiNeDLsVnE/eXikUI9duw5+wEM1Dyj/ui92VVXZjb2yqXN4FZmR5808TlZFTOZm1P3ff
	7Z5d7FU1DDvA/f3pqoLzZ9DIp/6xPkwWCZXOuG4tpm0zKgMmPLHrXr5Qbx0Jtlgp7BhKEbvPsXM
	fQ2el2FQpXn5OeUotQ3xgzhWsJqgiQRz4i5Rm07qLBBemnS+X9DUjjwk0iw0U2EmzCdnuykF4hJ
	MtxpDmuVf+LJadaXBLLiBY/jg1LUEC4FyfIIqgmaCgscDZjPU9N4fa7ljc3h5qc47brNt5bJGQ2
	VPeMWVWXZHFZNfXRiwIudqEJbUv7rSp12pOeG01xmWsyxqT7CaOkYvQivoy/I2A9CSNPsagna7g
	Oks6/PsVVs9uWS6m4y3gUzfPRx4DqVzZ85au9kOgnMOdlJE2Idz2uVlOeJfrdg44tR2+bTS0iBR
	Z6JQR+BSl2CqWW0xmFu1xRbLdYL4K42adYKg5uSd10HoBn8JppZvRWzFZDRpa5nyMFRQ9tc2HxQ
	MHkxVu1g
X-Received: by 2002:a05:6000:2307:b0:488:9695:d15e with SMTP id ffacd0b85a97d-4889695d396mr1593449f8f.37.1790495197908;
        Sun, 27 Sep 2026 00:46:37 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm18485266f8f.2.2026.09.27.00.46.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:46:37 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 0/6] Patch review
Date: Sun, 27 Sep 2026 09:46:29 +0200
Message-ID: <cover.1790495160.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Sep 2026 07:46:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20259

Please review this set of changes for wrynose and have comments back by
end of day Tuesday, September 29.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4811

The following changes since commit 84a8d046593840df460c1312365031c817eb8918:

  tests/fetch: Drop ftp checkstatus test (2026-09-14 23:00:27 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-review
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-review

for you to fetch changes up to a8b1dd0aa61ad91716379cdad59c4a9206ebfd7f:

  asyncrpc: Close the client event loop when the client is collected (2026-09-23 15:55:35 +0200)

----------------------------------------------------------------

Chris Laplante (3):
  runqueue: Fix pending_hash_index not including taskname
  runqueue: fix bad check in process_possible_migrations
  runqueue: wait for covered tasks before setscene

Francisco Pedraza (1):
  asyncrpc: Close the client event loop when the client is collected

Richard Purdie (2):
  fetch/wget: Handle long filenames correctly
  data: Fix expandKeys recursion issue

 lib/bb/asyncrpc/client.py | 50 ++++++++++++++++++++++++++++++++++++---
 lib/bb/data.py            |  2 +-
 lib/bb/data_smart.py      |  5 ++--
 lib/bb/fetch2/wget.py     |  7 ++++--
 lib/bb/runqueue.py        |  9 ++++---
 lib/bb/tests/data.py      | 25 ++++++++++++++++++++
 6 files changed, 85 insertions(+), 13 deletions(-)


