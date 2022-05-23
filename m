Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E46C433FE
	for <webhook@archiver.kernel.org>; Mon, 23 May 2022 14:40:25 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web09.28626.1653316816144004208
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 May 2022 07:40:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=a2O7uKfk;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.180,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f180.google.com with SMTP id x12so13849053pgj.7
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 May 2022 07:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fk2IYY4gxIKKcn/KqyzDojHPNhzLq5moJhQQ0d6l/Nk=;
        b=a2O7uKfk5leSNnUQWA508epYYdWI4aNIm2dGcfDiHZP1CEWm0vWRffuMIX+rORv4Nb
         ejIbMvtwnvdqv0/9KBCJEvuh7vj1I3bYq3+HNbKuuG09+ce2+vvcrgV7OfNfR+YKk0xv
         9gAJ+eaX1OsmEYu9ZVD4QQAu5KiTgqnJADGnCkbdKwy4K75nV7WVIiLxr3xhWF+9xW3Y
         5gqFr/sUku831+Z4/VOvsXfz0yL3e1+sbQjM+XDR/33TkBNeOOFC3PZRuuY9zVHQGdbB
         ZudxR4M1iORm/T8kT1j/pXeIcTWwuFyd2uguMf6Nhpd8qSfJ1P8HLHoH9Eo2Iizxo24/
         zLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fk2IYY4gxIKKcn/KqyzDojHPNhzLq5moJhQQ0d6l/Nk=;
        b=NWkf3t2T4aBVJB+1ekk6kMNvSFDtAivASxlW5xCFOKYqFvgWB6KBUgjW/ZcwbhjjQy
         49WrYUHoztIMR39FNm/CIxRmREpvFBJSkiZeR6Px9fTKVOpEs6VLRLZYKTejFhVvJjES
         G0f68lJ4DJS+dLjNJM8Ozy+AhL7jwax341Js6KDwHOaA9bUO3lXYGv8d/cFjBZUtmk9l
         m1x/07MnSsx633q6R0SfASa6htcHq+cJIiJemq/l1XfMnq+WyBssRiz3HZ35stopaYOZ
         23ysXUDkIuLlUXYzjzrhsya0gfxTU790HVX6PPQTKvNiErB8Lse2adBlKmnUveYEJqPz
         KzAQ==
X-Gm-Message-State: AOAM532rZHiwTi+NrvJRxe1m9bdn/cRyWqi4f2VPX6uitOqlGvsvitEg
	kvelyMSXEtaOoVAfaATAN73k8lxPoMYdBzRB
X-Google-Smtp-Source: 
 ABdhPJwbEFrlFrgiKPxJDs/u+bt/vBm4ic3/aegQ4fVNyAIh31A0gX/wnZvuutVj8paF/dKVS0r1UQ==
X-Received: by 2002:a65:5c48:0:b0:382:2c7:28e9 with SMTP id
 v8-20020a655c48000000b0038202c728e9mr20839717pgr.472.1653316814793;
        Mon, 23 May 2022 07:40:14 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 u4-20020a655c04000000b003c14af50623sm4865576pgr.59.2022.05.23.07.40.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:40:13 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/3] Patch review
Date: Mon, 23 May 2022 04:40:02 -1000
Message-Id: <cover.1653314792.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 May 2022 14:40:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13707

Please review this set of patches for kirkstone/2.0 and have comments back
by end of day Wednesday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/3692

The following changes since commit 59c16ae6c55c607c56efd2287537a1b97ba2bf52:

  fetch/git : Use cat as pager (2022-05-12 13:41:35 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/2.0-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Gunjan Gupta (1):
  fetch2/osc: Small fixes for osc fetcher

Richard Purdie (1):
  build: Add clean_stamp API function to allow removal of task stamps

Tomasz Dziendzielski (1):
  data: Do not depend on vardepvalueexclude flag

 lib/bb/build.py      | 14 +++++++++-----
 lib/bb/data.py       |  2 ++
 lib/bb/fetch2/osc.py | 16 ++++++++++------
 3 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.25.1


