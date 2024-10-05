Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B093CF887E
	for <webhook@archiver.kernel.org>; Sat,  5 Oct 2024 13:45:08 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.11804.1728135898125500320
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 05 Oct 2024 06:44:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=AqbJfFhh;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.46, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e109539aedso2604213a91.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 05 Oct 2024 06:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1728135897; x=1728740697; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ7+TIjC6lFbNev4U2yQiyHhEmGBVx3ZjHWSf43aknU=;
        b=AqbJfFhhspPEg+HeqEqD6uO5ZbTrmQ6yWiPQXU/jqYsI79R4nMNVjRehkakl9SekNX
         IrcX3PyuBrAElBLvgevpIK/nCMBrzD2/ryds79l3scaUagzMn6u7lNE4mGsaYi9+Ozyt
         owzzciNscQV49m23EpXi5RwV2mYmtlPTGl9zSvmV4tp2ks7kqVbjeT0XcxbsWsR5O9ks
         PN3Nvmpd1Hf21tI43RI4toFNbc9/eUe01sMoaYlBrd/JdWIKsr7ZH5c6itW6U+sg6DZV
         bXfUrnI045+wRa4zK/A13Gq4iChPEyxgeqCg0NKYt+/y1BvsW6k6vIfticjm7pRH/pjD
         7nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135897; x=1728740697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQ7+TIjC6lFbNev4U2yQiyHhEmGBVx3ZjHWSf43aknU=;
        b=veeuMgIFxKpmaaJ4lZOAuOjQx3GNR1DheBx29mIFe2/zmLRfm/QLPV+HDWli5IL00A
         2xKaIa+iPifZUb4wYXzH8WODquYvyfeWrBRspoR/vu2t4S0I9XSHtmkJMqRUVXMBfItm
         R0f7QfCqExVObUCBIwYavlayiw9JKuPqNrtNRYBkGBvAKMcEG2ngf28rAQyk69ZW4qDx
         uI6AbGZjFIj7D2bk4eMln8QMzx3xzPQIA7dJjkdCgeF2L+ko1LljZtkyXQP3KGZ0siXb
         QqrB46SACMfvSwhSjL/+MY49EA6JjyakdJThGN5gAldXE4k0EAx0w3Qpqb8GMcqw+mEi
         sb5A==
X-Gm-Message-State: AOJu0YyMyRNC/q6ChsW/ELYG3sw3ec91/3xqnIddOSDYH/4pPR8EmlIf
	nBJGL0sFTtJWhGoxyzshEbQ9PMdM/p/4xs5TJYH7ZCfkX72XBTWX/CNXcDbFY0SYU4/FDWnFS50
	/GAg=
X-Google-Smtp-Source: AGHT+IHKxDI4ILJyac8ZaNp7rjdi7lz2MOHWiPvx5LmskZcLP3boMEeTy2rtFW9jqbvqd/KjbI6xdA==
X-Received: by 2002:a17:90a:ad8e:b0:2e0:78a0:55c4 with SMTP id 98e67ed59e1d1-2e1e622723bmr7561481a91.9.1728135897194;
        Sat, 05 Oct 2024 06:44:57 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f919csm1831617a91.44.2024.10.05.06.44.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 06:44:56 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/4] Patch review
Date: Sat,  5 Oct 2024 06:44:47 -0700
Message-Id: <cover.1728135724.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 05 Oct 2024 13:45:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16640

Please review this set of changes for 2.0/kirkstone and have comments back by
end of day Tuesday, October 8

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/7372

The following changes since commit ec2a99a077da9aa0e99e8b05e0c65dcbd45864b1:

  data_smart: Improve performance for VariableHistory (2024-08-08 09:19:30 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Richard Purdie (2):
  tests/fetch: Tweak to work on Fedora40
  fetch/wget: Move files into place atomically

Rob Woolley (1):
  wget: Make wget --passive-ftp option conditional on ftp/ftps

Rudolf J Streif (1):
  fetch2/wget: Canonicalize DL_DIR paths for wget2 compatibility

 lib/bb/fetch2/wget.py | 21 ++++++++++++++-------
 lib/bb/tests/fetch.py |  6 +++---
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.34.1


