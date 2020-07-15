Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
 by mx.groups.io with SMTP id smtpd.web12.7826.1594823236581253406
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jul 2020 07:27:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=DWoNJpdZ;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.65, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f65.google.com with SMTP id mn17so3147055pjb.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Jul 2020 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=1YZPrNdkfY23LgaFQoWQxc3wpzGBc9+pksk234nfpkI=;
        b=DWoNJpdZeN3MgkWedXiPt3oiK8Af2PUr1+VYJNilzFCTvzuNbrUPsumihGY1G9/ZcP
         UlnEcaUBKPTUOhcI9pL2noNwZVZuMjrLJOh3/k+Z4oRWBRYQLSsPJLdTHvPYk3DTlh5V
         6eSsAwVLuaQFd89YbuvB+E/xQLuz7mmKm8ZriehV8BcRRDMWliUwwJAZaos/gsXFvH6x
         ex9804eaGEE0MjfbB6EhNKXpDOpb+mZXKpwjoWUKyOdHXuExFda0wzm9m6RtQLiqgrE6
         tKd8YSqRELAHbZMAW6fCDdwAsc6kk+SBJ1j66RIS655KPeCmHCvXGU1nXg2aWBQa0twN
         F8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=1YZPrNdkfY23LgaFQoWQxc3wpzGBc9+pksk234nfpkI=;
        b=U2/u35Ku0JnJrpIvSUqj3mTa64j6be6DPuQFSos7MIUDqTSIEWoQKb9uOxeGs3lSa0
         NR6M/C2EUJZkLdvJVNFVyk0awXaFhrfErsvTrBT+kwX7rY4V+3BQS8WfSMyZ4w7lMXbJ
         wNFEAxzT85DnvAQB33k9ElZhHrqLRs13rMyX7GanZKrmZXpkqjYaZ/mnV4zL/HcKLwfV
         7B+5NmmCM+3Mw8yGsQAq+2lfTOqFld+rUUrvBk/DdUJZjpT50pLFtpFiPQRUPVHw/uWb
         xHV/Ax4gYuDAHzyY5LmQRH3nA8aBY1rIpEOdp6cCPgaNkj7aqnk+4aOA9su/98joKzrl
         kMsg==
X-Gm-Message-State: AOAM530XOEHp7HprcHdS43iqikx5NPs7gB+ZP2g7h1JaR/X6CsWtUf4m
	xq4No/xjT+UZmVLANYrqPBSVZkNRS25Lbw==
X-Google-Smtp-Source: ABdhPJySA6W7cCn1szKZV05qRDnm3bsW8zVVzq7MU00HABHylYwV0nnqXPbiG+FneiK4ggViZ4oaag==
X-Received: by 2002:a17:90a:71c3:: with SMTP id m3mr11006064pjs.225.1594823235507;
        Wed, 15 Jul 2020 07:27:15 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id i125sm2423915pgd.21.2020.07.15.07.27.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:27:14 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/8] Patch review
Date: Wed, 15 Jul 2020 04:26:42 -1000
Message-Id: <cover.1594822992.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

Please review this next set of patches for 1.46 (dunfell) and have comments back
by end of day Friday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1167

The following changes since commit 1d3892d93ee9688d69f5bb5ea6aef8b1152bd1e3:

  msg: Avoid issues where paths have relative components (2020-07-01 05:24:29 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Chris Laplante (1):
  ui/teamcity: don't use removed logging classes

David Khouya (2):
  lib/ui/taskexp: Validate gi import
  lib/ui/taskexp: Fix missing Gtk import

Konrad Weihmann (1):
  pyshyacc: allow double COMMA statements

Richard Purdie (4):
  server/process: Increase timeout for commands
  fetch2: Change git fetcher not to destroy old references
  server/process: Fix a rare lockfile race
  server/process: Ensure UI-less servers don't sit in infinite loops

 lib/bb/fetch2/git.py     |  2 +-
 lib/bb/pysh/pyshyacc.py  |  1 +
 lib/bb/server/process.py | 25 +++++++++++++++++++------
 lib/bb/ui/taskexp.py     | 13 ++++++++++---
 lib/bb/ui/teamcity.py    |  2 --
 5 files changed, 31 insertions(+), 12 deletions(-)

-- 
2.17.1

