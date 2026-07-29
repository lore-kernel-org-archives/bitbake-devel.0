Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF1DC54F57
	for <webhook@archiver.kernel.org>; Wed, 29 Jul 2026 07:57:56 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6436.1785311867807865327
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 Jul 2026 00:57:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=a5WptfY9;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f71156e1aso339253f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 Jul 2026 00:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1785311866; x=1785916666; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6IGsAFmov31IqCwW4nrFZd9W2DQJXJvegQwNrcIBL6Q=;
        b=a5WptfY9HipPjTqRYPxDrtLEG/2RBFSjzWp7zzzjXe//DIDFOlACuwQ/YY562PFKYj
         qf3lMWAy3tOmzqcD9iTMxYGnyxO/2v3SmtHuk6HiV5qpI4e3SDw2UDAKkCzU1MyKDKgU
         bSId6PQhjIr3RUuX0W1gWUDqnJKbpgXb2CrVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311866; x=1785916666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6IGsAFmov31IqCwW4nrFZd9W2DQJXJvegQwNrcIBL6Q=;
        b=HqMVLbjfdLx1B6fwAbjZ58aFuJFA9l7ZkbmMCL0KELTkKJw8xn+fAN6KDDlDMwJ5hL
         i7nElBtsEe7ZOq/5Y+2vuxksOlyqESInKA+Gkg6smMkIkrmhSWlJUDh0eOhkwaIAnceQ
         /acVu39MxR3LRPdSqsb3qvkno/Plf83L1bGdF+TR2g8Jyf2wkWF4Y0QXYP8rBZDr9Fqh
         UmnlU/Vhne34W6K5O7Vxc6uJ9yi4c0+UebhVRENZxglxWkHj6P88SHq8/4+Eta7aXdvI
         wtC7f9E2q8/ITbXzOeAsmEctfGJ3Cd/8zvAtoJZnnIxY7WVkH+JKEYurLdMh1OO4p/eb
         tU3A==
X-Gm-Message-State: AOJu0YxUTXbcacbeHbK2LDkjAZar7L570DZT9Eyus6a30j9JDg6Lxhle
	XiyyoD/ZuuH1unq+4GbVhNcc4Uq5IITJbp6Lsr8YZmzzrb/11tEl2syjf0V6ZUwWOXOqjeio92h
	0y3TAcn0=
X-Gm-Gg: AR+sD12JmQmLebOdLC4VAS6Zt6xxx/tmyde2166ncWjYRKpbanZRYpXP7Ru0DGCYr1w
	Lj3QHPN5mxj/yS21cj3lEQUoMR+pnacmlZuGdzKRF6rg/JhBsVo8Z+095EmkvGx8OkAWgrZ2DoW
	SsVneYzT4M0tSnd9WU3r53Raa5fTl0uSZ5Di7WSb8q3Ra8qLxf6tez7uA3g5F+kXxMHN2uzePrp
	TDsuJmHW97CkfDTvVWtf6x3RRUkfKlMp1vE5JXKFIX5cXjpifgeLTgOYcel+J4Go0NCTLK7CCH5
	MdkZKSOx437GYGZfEAPlgHRWrwoDrRi4YcXMy+nueJopetX+eeC3F9J0Ob9PEREOIDhRkMgF1bH
	Mefj+ER9q03rdHbsCKz+Aw88SEI/KAw5z2QCe128dkN1YTtrPV3uN99ZI1BeVmTTCtojTcYpxM4
	efUgNR5q5cGqWotg3WfZ4Al6jZ7T/Xzf9i8wyBAKF7ipykh0yUttRj0Ie/njz/40kG7pELv5s99
	uBfDVp1qRq9uMWKX3rwz0lsI/93E9q+msb80Vrbqk6Dkc4qjegqK2oSUEQFFai0
X-Received: by 2002:a05:600c:4fc7:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-496c6413164mr76514565e9.2.1785311865833;
        Wed, 29 Jul 2026 00:57:45 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49764d77970sm39189595e9.5.2026.07.29.00.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 00:57:45 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 0/2] Patch review
Date: Wed, 29 Jul 2026 09:57:20 +0200
Message-ID: <cover.1785311679.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 Jul 2026 07:57:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19869

Please review this set of changes for scarthgap and have comments back by
end of day Thursday, July 30.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4312

The following changes since commit 0880963fea4d91a034e4a6e007d23f98658ab986:

  data: fix issue with varflag exclusion (2026-06-12 11:39:20 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

for you to fetch changes up to cff3be6f664f8f07a40727ff63eeeb24d6f5e00b:

  utils: Add NFS EEXISTS/isdir failure workaround (2026-07-19 18:02:05 +0200)

----------------------------------------------------------------

Richard Purdie (1):
  utils: Add NFS EEXISTS/isdir failure workaround

Yoann Congal (1):
  README: Add "2.8" subject-prefix to git-send-email suggestion

 README          |  2 +-
 lib/bb/utils.py | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)


