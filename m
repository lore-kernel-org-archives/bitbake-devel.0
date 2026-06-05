Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC7BCD6E6E
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 22:09:23 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5777.1780697361658750970
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2026 15:09:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=piDxxEwL;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ac357c55so28863335e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 15:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780697360; x=1781302160; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2cZ7v8MxTwzdxmZ7/ls4cGdd8MDX7KgJPiDypKRdok=;
        b=piDxxEwLyRgayjp7UcRlvPW8UdR24pMqxkUMGGUJm3e3nJr6nutsD86uY03hTXmsFE
         ssRoG08kvKJ4U4zWweKm1bnEnO+VI+E6VlLNg+dhqqc6WQFkKUHP5eWLDGj6iPYQBMAR
         KXYJnFORo32/fuMo3DM41mT5FZzT92aWP92VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697360; x=1781302160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2cZ7v8MxTwzdxmZ7/ls4cGdd8MDX7KgJPiDypKRdok=;
        b=kfDJP+L9qtySR0PigZHiwOXZfW7b3mibuEImwNIx20g/0+Ob7anZYi7ZPO6L2Jhay+
         +tPNtfKo21RWQ/R+EjqlHQAENIi7/ObrCTAqwbpIheud0ijRJt0XhdSSuK3Ic2rEzb2f
         DgpkZpzdHTdBYn/jeNevUuG3tdK3jUdCtN8kzwDYsVjPu04Z80Bi/wX9y5KyawFAmswt
         p/wJUvkh/JLAjz+7e1B8lyXuKGBjANOSkOW2HJtaW8roAIYdV6C34obnFD/93hOmktOk
         moydqHxNCst06VhN4hcqqbs4lVEpEjIjDdwSrgWzeYIbgzddxGo3MUy1xRFaMCUB3SuQ
         5nOA==
X-Gm-Message-State: AOJu0Yxar4r+VWS8qWL6lyv83im0NEsRZqVILWWx38Ue7W6di1ySdq/P
	GMzwiMBsKs0mEzUmYdXJB4ENaZe0E0Xa9eL/dxjpHiynr6avXyOMpyG7FoNgv3uohRS4hjZ4w+U
	k6HTE
X-Gm-Gg: Acq92OFqfUeGMLh4UYfsG1QCbgZtFsPavtdoooTVPhU/788Nksq6mtjj1iPvuJ6sORx
	TG1HraLIlwVvctB9J8pTjnMQya2uKzueH76SyFMgTPDlS6s36mFkwOhewqmL3L9PPF0ENjGqQj3
	NMx+sgxWGLH7qku2VTB8btBR/4yrfCuZLKfxCaUIkr/912NI5az+i+F6363BHgUOLIJR7k55Jf0
	/zU9f/RwXZD2OGZafIJTh3pOqc5fm2x36LUsKIbAe6SvrGIm8ahmmSV0O/ltp7GuA6Sme/Zjvws
	i/GQ+BeMrFr6g96amYQA6SwQYoGbNLSkJ4mNIMDoMUv0oPDeXziDx1tuIWlgCuiv9Tl6QzYcfXo
	2pekGL3iSjYnTMz4yhYOQbk2D5f252tvwGjho8IubSXTPWE/6RRE8nCjOjTF8y/9vp3WRcBhJlA
	2B+bcqBgAhRY9u/orN+i/6KHXhco9JUH9Fhg0f4qyqToj/c6sxHwJ2zccMOniY/6TpuwUrnph32
	UuVkh+/eyM5MjDkV9hd7fL0a3abXrytd72vY7gtpwEzUq0UuA==
X-Received: by 2002:a05:600c:5020:b0:48f:e230:d5ab with SMTP id 5b1f17b1804b1-490c260f495mr92567445e9.31.1780697360042;
        Fri, 05 Jun 2026 15:09:20 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00b3e1ccc1be2b2798.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:b3e1:ccc1:be2b:2798])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd502sm182367015e9.11.2026.06.05.15.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:09:19 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 0/4] Pull request
Date: Sat,  6 Jun 2026 00:08:54 +0200
Message-ID: <cover.1780696925.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 22:09:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19616

Passed a-full on autobuilder with 2 AB-INT failures:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/3934
* qemuarm64-ptest failed with #16241 – AB-INT PTEST: util-linux ptest failure: timeout
  -> retried in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/61/builds/3760
* oe-selftest-fedora failed with #16308 – AB-INT: selftest: xterm: Xt error: Can't open display: :1
  -> retried in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/48/builds/3832

The following changes since commit 22021758e66737bcf68dfd2b74adc6a0cb1d42d9:

  README: Add "2.18" subject-prefix to git-send-email suggestion (2026-05-19 11:08:15 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-nut

for you to fetch changes up to edd1cd43eee1a1f87dcd1ca356ae4247c41eac8f:

  fetch2: Unpack RPMs with --no-absolute-filenames (2026-06-05 12:57:05 +0200)

----------------------------------------------------------------

Anders Heimer (4):
  fetch2: validate deb/ipk data member names
  fetch2: validate striplevel parameter
  fetch2/git: quote shallow extra ref arguments
  fetch2: Unpack RPMs with --no-absolute-filenames

 lib/bb/fetch2/__init__.py | 19 +++++---
 lib/bb/fetch2/git.py      |  6 ++-
 lib/bb/tests/fetch.py     | 93 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 8 deletions(-)


