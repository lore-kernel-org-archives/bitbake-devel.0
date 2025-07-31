Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED50CC87FCC
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 19:57:22 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.71540.1753991836314918950
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Jul 2025 12:57:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=OuQqEXE8;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.45, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31f4e49dca0so903470a91.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 31 Jul 2025 12:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1753991835; x=1754596635; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHf0axXeuAxKTSjdPqUJxaD2pLSMIUANGWny+6j9qFM=;
        b=OuQqEXE8yYIeCvdsYdrL3S7n15Sfam5d+Betfcd9frdgPkGRZOSptB/ENZ1MUBJiNU
         p4o5+Q0R6kZxvKVfnmXfgiwGI8plwpV6+sluWxIssPI+aMPeOygBewWq7VqYXm28k7aT
         A81jZYHPRTgwyJkqhsBrCPvuz+va5PKhF0ps+fxyJmTkbbILmwEpCWTVtcjIYcSGNjeU
         mfqzc2SV9CPDveVpaQP/yL9fRZwpVUdDNOz0vcL2pTc9kF9shpGtj0Ly7gMFjNH3bCig
         VEp0Fc1QwU/rTJ6ZYlT2bmGo5Nd7J3cYcfB6b3bQ/YVDdFoYhuq6iZ8BGBphS11e39uo
         52xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753991835; x=1754596635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHf0axXeuAxKTSjdPqUJxaD2pLSMIUANGWny+6j9qFM=;
        b=fsCKGbe85zi9uhw/nEog8me8ZEwN3v1oLCXszdtjk2ujU/NTeiS+TKaLu8Wp2bpbbw
         dDj73FLToUvp9R5FdzuUtG7GgYgG0i3B6Zaq5O5+PpgpYWEGKELosQXaN6qcvLiIsUou
         UN4ExH7n44JR/5hx+zqAFHa+ZOQoPX3Z2CKyP1ijvnHZVge6terk4P2YjC7N3I/csTpM
         TElV6pxHCElVNTCztRkHVrIBhLtQ1IMFJhuFGl73c8yoMB5Ej/FqhzIkRKFy9baic5eT
         LduTXCZlPFi4NGXwvm7Dph5/3su3S/t6sZHWzx8TIepfFMrn8aKKVIcY7sdiQPKNuFfQ
         DgEw==
X-Gm-Message-State: AOJu0Ywxc4+O5Rv211mtdumWJoQVvGO7jf6Pi/nSJMkOVN6JZE4AtInN
	yySM5SjQZeiWoTHLrE5oFr/rgnOg2k9Y0PVC/mGC2/c73kW1bfji1uXMZuk7geopUcdGWQ8q3va
	LNv+Y
X-Gm-Gg: ASbGncu3h6JzYl5Yqgp9+9pkuIC9w3x80PJyuUMInj90tzLZfuFWbL81YUFb4GZKKmD
	XHPDHK01RosKTr3eUjHJdbJ0KgSptvyzCqPsCMWrCx3XFXYfWA/EC/KD872EsL733gWzsfM5y9g
	jYRs/5Pdcz6Auyz+Ryn0mkOVIE+DY7uzh/L55vpepYCKd4Wq+ewElDzcrsAkcnOrtXUf6sNEQos
	g6mKtwPtIDSs2j9PdnNYU9wwmmzxNI/+4iO9XRyqUopucp3GkAZ3+hNE0NI/F7uQlATlD6nO/2g
	gH49f8U0IQU8S1LTrOT4afTUTYvF+qxB2T8uPKSE/77lIOEvFkEOQ9Q4Nync8CE76rxpHtZMu/y
	B5aN+LUFQouKybX/pOX98Hb6L
X-Google-Smtp-Source: AGHT+IEXRFX208kCCaGTJISRxO2Mjd+Jh2AodIuxStWD/2DsguzHr99To+DYL1QktpjxEauWuFVnPw==
X-Received: by 2002:a17:90b:5350:b0:311:c970:c9c0 with SMTP id 98e67ed59e1d1-320fbc0c089mr115049a91.22.1753991835403;
        Thu, 31 Jul 2025 12:57:15 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:8df8:dc37:f204:6fd2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6f4csm2726765a91.5.2025.07.31.12.57.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 12:57:15 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/2] Pull request (cover letter only)
Date: Thu, 31 Jul 2025 12:57:07 -0700
Message-ID: <cover.1753991742.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Jul 2025 19:57:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17830

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/2122

The following changes since commit 86e7a58c0e9904c33b1b94dddc3d683c2da22d1a:

  test/fetch: Switch u-boot based test to use our own mirror (2025-07-22 15:08:13 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Mark Hatle (1):
  bitbake: runqueue: Verify mcdepends are valid

Richard Purdie (1):
  utils: Optimise signal/sigmask performance

 lib/bb/runqueue.py                        |  2 ++
 lib/bb/tests/runqueue-tests/recipes/g1.bb |  2 ++
 lib/bb/tests/runqueue-tests/recipes/h1.bb |  0
 lib/bb/tests/runqueue.py                  | 11 ++++++++++-
 lib/bb/utils.py                           | 17 +++++++++++++----
 5 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/g1.bb
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/h1.bb

-- 
2.43.0


