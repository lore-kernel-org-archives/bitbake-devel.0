Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web12.32464.1620656187739554032
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 May 2021 07:16:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=NMG9WsSD;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.46, mailfrom: steve@sakoman.com)
Received: by mail-ot1-f46.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so14524970otp.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 May 2021 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xs82zu5qLOrGnK9JXLkn+vLW+K1HXU6fz+B8LOCuJxg=;
        b=NMG9WsSDSMIjcG6OfOMTG3GUE8o95KmoqYfQl3zqo54oVN632qsfVLlVimzkV3GDiz
         qD4y96af+Vwsjbd/bZWYXXZffWUOPIJsRqQhOlpHLipx87UTKzTkITEZRa1D28P61IvF
         ymJlJJkAd4XTpR3C7o5aEPQxqdjt+UflExy9UXdjpAhXQUZ5B+jQcrqrYcJUSjHO8Wn0
         4Ier8vCV2hXR9dWXExe0yteYqfMk4kMX7fM7RZV3QGCrww3/ZJ3I1O6w/+RTLu3zxWK7
         tVPYj2Z3Mx/C1iNsjX1GBLzVy9vQaR4UebKbdDNi2EzEBSZBhQ4bG5G4RysWnb/t0zyA
         kQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xs82zu5qLOrGnK9JXLkn+vLW+K1HXU6fz+B8LOCuJxg=;
        b=KZVwQsBYRHcW42mwsS8KTMbnpeELPgnw6BirkmGJgfT09hvLfZl/L1qTB9vbKNsbhZ
         X7/GrXrKb55TsvERxduLy/DjDCARwr4/PqqmAS/oVYvtTEo9QRtf6CTIxgbo4nasEl+j
         udLdfdPcwjlSF/v3HFaFSJOFaQOsWV55cRLzrA9QQYKDPjRQtWMQDN4OEscS+h7ElYDy
         kCJvrOY0Dg7rsGO9mVLhmkNvnaFpYk5wosOgqvQM46518JbEGNq2+6FNUtb9gsa+m4aH
         rZQ3+RaL7eMUMo7KaKsEeDZlglE6bOOWpICpLkDRF/THQAWQUAMiLDaIKlXwCgkloNVE
         9AZw==
X-Gm-Message-State: AOAM532z31VOYaoJMurslLJ3rBJHGcUHUSgEv+93/s+Klnf/i2Y/MvL7
	uuHAD5gqClc6/RZMMjk60ia8JvPfgdpWGKMTHh4=
X-Google-Smtp-Source: ABdhPJyDa2htiANZxoM9q1wmVJ4h0Xu0zOtAzWiC2KuVXCi7g1Qi74mu5jAtEHXPRepwY3+ZYmdv9g==
X-Received: by 2002:a05:6830:1c67:: with SMTP id s7mr14007899otg.197.1620656186526;
        Mon, 10 May 2021 07:16:26 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from localhost.localdomain ([172.243.4.16])
        by smtp.gmail.com with ESMTPSA id g106sm2401303otg.77.2021.05.10.07.16.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:16:26 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/4] Patch review
Date: Mon, 10 May 2021 04:15:15 -1000
Message-Id: <cover.1620655927.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review this next set of patches for bitbake and have comments back
by end of day Wednesday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2130

The following changes since commit 017a39ed05d065bf28fd38f91bcde8a098300551:

  Force parser shutdown after catching an exception (2021-04-06 22:45:22 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Mikko Rapeli (2):
  bitbake: tests/fetch: fix test execution without .gitconfig
  bitbake: tests/fetch: remove write protected files too

Niels Avonds (1):
  fetch/gitsm: Fix crash when using git LFS and submodules

Richard Purdie (1):
  runqueue: Fix deferred task issues

 lib/bb/fetch2/git.py  |  2 +-
 lib/bb/runqueue.py    |  4 ++++
 lib/bb/tests/fetch.py | 18 ++++++++++++++++--
 3 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.25.1

