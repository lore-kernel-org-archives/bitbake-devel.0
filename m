Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
 by mx.groups.io with SMTP id smtpd.web12.387.1591058391863907044
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 17:39:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=tbcrTclv;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.196, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f196.google.com with SMTP id d66so4232037pfd.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 17:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=O37PRi/dOYXmNKWqmOELj6r+j64/chLGqnXfwZh5vJM=;
        b=tbcrTclv3WwlUVrNeCG71hfBK6Vu0s1V7TYkzCaJnVHF83gOJlaB9cTS9KmXfaQg/Z
         XB3BestU8JMYncPuuovDcuJ7ZMMqhV8bYV7KtfPeIA/vN+hrYKLRwEOa8SXe95tD5dJS
         beQT8Apy2Er+wSmb8VZMGPFcE+T8gPK/fmqtpIA9XF/ucH8mhtzUbeg59iZA2RUhdE/e
         hgOxkw2k1vEBgd6pR1L/PikGpgmKPLEiOxcd6iezNaVKzmUPLaZUUdZeL8foOVLaqo43
         qciubjDj2M2ZdAUtuMMQpWJPHZeHTIC2bR1CoH2gLqzjQTBlEaqnFSMzCzHbBRfL3mL+
         foQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=O37PRi/dOYXmNKWqmOELj6r+j64/chLGqnXfwZh5vJM=;
        b=f+n2wFnGyppN7FTL2YJrJ4FIHbipwiccZPvfg06k+CybHcLRMBLk2kZFOHJBTyiACv
         uHQOQ+Xo3P7oS5fmKGhJSczXmW1P2gHjdjPmW439AhaArXGxryfToMoLgH9ETKF02phj
         zxhk25t240GudUVYbFTjSMUWxvZVs2QRihDKlISa39DvGSRSCczWKmRe/XOZhpeS37mN
         Qv8/NzuN5hYnxUhkKm5wXnslJoJHuLpPF/m6vhbl2AtkGwgnLBl1WmOCH80Uz4eVdcs/
         IMa7mqbLazQM93fVmMXW1iUlDIfgC5rgu8E/BD3mHIITLLpNAKUyJ6t4luzUTipPeT6u
         t82w==
X-Gm-Message-State: AOAM533NLBlXtzDHR5mdOwpMtfsHX5jvx3TEC9+83To0SQKNv6WEJoYJ
	lkcTXxyWBAn0dZ2NRsw68fKi5vaV/vs=
X-Google-Smtp-Source: ABdhPJy+gxe4TCp84MkFosFdiQAss9A2B4xTxugI1XY0lUxxg5YwEelNIsrybm7Qayt0q8a7SAUOzQ==
X-Received: by 2002:aa7:9ac5:: with SMTP id x5mr21191698pfp.234.1591058390784;
        Mon, 01 Jun 2020 17:39:50 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id l187sm465729pfl.218.2020.06.01.17.39.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 17:39:49 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/6] Patch review
Date: Mon,  1 Jun 2020 14:39:30 -1000
Message-Id: <cover.1591058197.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

Please review this set of patches for the upcoming 3.1.1 release and have comments back
by end of day Wednesday.

The following changes since commit b94dec477a8d48ebceec91952ba290798c56c1f5:

  bitbake.conf: Drop unneeded variables from bitbake.conf (2020-04-24 14:31:30 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Jacob Kroon (2):
  doc: Clarify how task dependencies relate to RDEPENDS
  doc: More explanation to tasks that recursively depend on themselves

Kai Kang (1):
  bitbake-user-manual-metadata.xml: fix a minor error

Robert P. J. Day (2):
  docs: delete reference to obsolete recipe-depends.dot
  user manual: properly tag content as <replaceable>

Tim Orling (1):
  toaster-requirements.txt: require Django 2.2

 .../bitbake-user-manual-execution.xml         |  4 ++--
 .../bitbake-user-manual-intro.xml             |  7 +------
 .../bitbake-user-manual-metadata.xml          | 19 ++++++++++++-------
 toaster-requirements.txt                      |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.17.1

