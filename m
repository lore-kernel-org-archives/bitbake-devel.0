Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC4AC87FCA
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 22:03:43 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.74123.1753999415917570354
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Jul 2025 15:03:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=JTRIbS1e;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.170, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2405c0c431cso15319015ad.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 31 Jul 2025 15:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1753999415; x=1754604215; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LpTxgK5cRQHx0T8guJ2zkEfL+CfAVHD8/8xdPZ3my08=;
        b=JTRIbS1e/h/sic8SCeukT89P452N9qjesCfhBfmDowgAsyylcW8EIc6rijv55UDjDb
         aOzgVk/iqdYtOJuZTPBEPxwGdESNiG23l9jNfgOMjRrSeKceIBClOGGg1FC0JBWV+3TR
         w5ewBzaN7jm2NX2ZtBCAS+n6ySuJtq1bFjLRBLLHJOBzKoG7OdNJuqMUqlRMpGZNEZJ9
         Ucm1UQl3ztTEIrWbXD0CM/s3eUpjLhXcYh6A7WllmPt4kYGJbEaL573aEgq7xiSsldSg
         d9/AZgwtM4A+639BDsfDXwjfUFaM34lcAJEm0gjwfjhVi2q39RQZR6m9o/GAq9WdoFBj
         2CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753999415; x=1754604215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpTxgK5cRQHx0T8guJ2zkEfL+CfAVHD8/8xdPZ3my08=;
        b=lOnN2y99g+/9RcyLNt1m8QiP7nT+5QXakUeGADao52JuAlcNyWoSiz5J0YlcQJLQ4r
         KxoptRHnpmz0xMG7rNm4DBeX7rvV5O5Y1Aabma30jWb9a+Z2OcuUdDtE3ooalFERLNuL
         d9G6sITnggq6l5nV3d2gOR8PXWE1OSNOC+oRi/YXKFl5olnUqKq8tsVWvrHAYQeiWoAP
         2cyN7xmYLtdnu/yauPdVq75tBAimKNKEVy33aaeDC7B/skQaQk3Kf2wkSLWUaEgCvkvI
         I8NmL9MIcqxG3v40me1GN4IygNzdT29jvCCAH8t+036+ZBwHXyD4VbOx83myQ7wnxEe4
         pqCw==
X-Gm-Message-State: AOJu0Yym/78ARi1GdiYh2HPR2l8Oqt+Mta8HA2OIArJua+NeCTxE6bjI
	BXI/o8rdr2PEltm30H/plLRnP8/wpqcnLIUbqy5nWMemgnEtQ/9+42XctikYmT8ixdzHTOA6GUK
	qMs7G
X-Gm-Gg: ASbGncv5mvtJ7gcSViawwAIpfz/k2TG2GLAo4JKy5dK5qhzV7mJraRDFEq/lAzE/258
	WbpQQr5Ac8X+56e3pGOkeTWxLfRXZkLckSHJ5qSMabEVCZFuQ95U8WWugaAZVOyu7souMS6tjAO
	dXs2oi32y1VikJfrMDzRWojC5USIXoEgsa+axqo96zeeDqmBLKK9No4iIjGBeH1xXR8KyYewTOo
	1E06yx4ZBlEEcexsz+OdKo6946RwwGwSkwGb+4L4GHO+TMinxQsRvNNsBhawG1jDUPJyLz9G08y
	oRj4fwfEIstolqXh1HMahZ34krE/CAgij6SOX9GIAK1PG85pJOhmunWKPFqUMpJ4qJL7yDMCWrP
	Ona4RXOPXa+DFGw==
X-Google-Smtp-Source: AGHT+IH3ybJNw8GUzcQet3+NUNYlpb2/qGQnWf0tJnvIjQ81ltBuRFGznKUk8S0lrPxG4ED+YlLDTQ==
X-Received: by 2002:a17:902:d50a:b0:240:3f39:2c73 with SMTP id d9443c01a7336-240969a82acmr120210515ad.0.1753999414884;
        Thu, 31 Jul 2025 15:03:34 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:8df8:dc37:f204:6fd2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac0b57sm2283914a12.31.2025.07.31.15.03.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 15:03:34 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][walnascar][2.12][PATCH 0/1] Pull request (cover letter only)
Date: Thu, 31 Jul 2025 15:03:24 -0700
Message-ID: <cover.1753999319.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Jul 2025 22:03:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17831

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/2123

The following changes since commit c1cee49479063eabd3f14c1520feaeac4e04de7b:

  test/fetch: Switch u-boot based test to use our own mirror (2025-07-22 15:08:06 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.12-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.12-next

Richard Purdie (1):
  utils: Optimise signal/sigmask performance

 lib/bb/utils.py | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
2.43.0


