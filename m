Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA31DC88E77
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 08:38:39 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10319.1789547910465168562
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Sep 2026 01:38:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=CWax+4CJ;
 spf=pass (domain: smile.fr, ip: 74.125.225.141, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so7322925e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Sep 2026 01:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789547909; x=1790152709; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MOND0rWdzcNLmcqf9jzD9nInXRDBDS0Kj+cbZ+aWWbI=;
        b=CWax+4CJP3y1Z0wFxu6OMZ8tO7t01jSm9r4zxEAuMEwvRotv3ur3ZFg11iJvYnK+eQ
         u5uOvg1oifrTp5Qq8E54XqScLC8j4y5+Qp8q18MtHyni00x4iFEF5fw3tfVo8qMVOmHO
         NTHn1AqfPtOlmKjR8qV5vM+SVK/WPQom6XxZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789547909; x=1790152709;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MOND0rWdzcNLmcqf9jzD9nInXRDBDS0Kj+cbZ+aWWbI=;
        b=2IWskbgAZP84piceYQpshyE6TF8+yNC2QmP9sbooQlBeiKLPmiiIY8bvWCujCDIdUh
         Mg5/H8hU8zYIuSiWQlK2T5M7vHT2InkWWN0RCO3IWR4VH3hH2v4svgcbrayKOTWh0Vgv
         3J86UfyfcZHulxVILLelKoVrnIGme8wl7+9hPR9KKfMqbReltnQPZj331ctepzpTE+f0
         xK211k7WjCUfHgDeyZsO44lOcLwRah89l3oe+tM5hLzqcmS+FYHui8ZuQR2XewcK3ctM
         njEd5LZGXALYW8zPj3Aa45KBsMFUHlp2LMZjdPGFPIr3nPc09Jx/dyTnOiQa3HFfcoS5
         8bog==
X-Gm-Message-State: AFuF++kOXnW2X88yoSJ0+5qKS5ev/ShrNzVR+w/UEp6nZHItisBW9s3j
	M39VU3Kjer72DAagkQYhXq/XYTnfU26bXahyCMEGSBpUBQEGPR4+MZ3JHrVsef75BkgU79ae9pm
	RlbuSloo=
X-Gm-Gg: AYBFou3a6ibOgMuMHIQwAUntB5AjRQ68k0TPhACyVu2cJcxZxWc2AFYMs9dmY5WFpJb
	uwZUvcngWBxD3zfUWVFDFy4P1qd0LkNxFgL5xFfjrsFGIxB2IB1SWszOWntvYKZuv/8O3mfL/IL
	VzfENWCHPS7oDNM9pTAfWoOzK+5jeGdYEiLWyOPh24mCzcxRE6oy15kVEOKIT1suIsiiAgCYsvi
	N6gWsYb1gBf5EvwcRSnnGA4Kof222wXEVUssV8J02USgLkrWfskHAwGFSvIBrfu4ys26GVX6Pk4
	cmxW5AJRw6idzQKDAMFxJgBXQK9tiju1gYNIw72kTCA6wGpHOeHGFeOxmv5Vh0MkfmnrqLpVEhi
	4VqRhdqOw+reZJzcaC/BJyECkmfGTwvbXMrb6Lmy8uTXXjVO1pUM/cKDaLeaJpCiEonZ6Uy1n4j
	vA7wcYS6aXiNWXrwNIKBg0laYkYhjZd+/wJ8xDLf9h4MmssFRV61MeplX2ckejA3IV7YseEfJb8
	zlwz9UjqA2qAQsPIV+4o2KqneovzYTM4C0BO64N+Zy6M0kCiYoA/9U48fTia5RKZwlaQ7gP4a/s
	cm/iC2U=
X-Received: by 2002:a05:600c:3547:b0:49e:7423:687c with SMTP id 5b1f17b1804b1-49eac46377amr17117705e9.1.1789547908646;
        Wed, 16 Sep 2026 01:38:28 -0700 (PDT)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83add1casm60619535e9.3.2026.09.16.01.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 01:38:28 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 0/4] Pull request (cover letter only)
Date: Wed, 16 Sep 2026 10:38:03 +0200
Message-ID: <cover.1789547778.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Sep 2026 08:38:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20217

Those are the patches from the last patch review:
https://lore.kernel.org/all/cover.1789165002.git.yoann.congal@smile.fr/
(No changes, no reviews)

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

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

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


