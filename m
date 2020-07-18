Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
 by mx.groups.io with SMTP id smtpd.web12.4262.1595042839947942837
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jul 2020 20:27:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=UkS8jFZ2;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.196, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f196.google.com with SMTP id w2so7559776pgg.10
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Jul 2020 20:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=0Ppgp1aCECO9gcyY/vi63xjzkDF/lXx6115UUn7PjHA=;
        b=UkS8jFZ2c+ui2Ofv8TftBL88w4EYgHyfPwMj9TWVUZjfFk6Z7bIBHBDqav5wwvx8Ge
         75keinvrxXvrGhx40/iho45mLFkkZxqYWib+P8S5B52E+GUpHrGMu/7Qn32elXjR9ZeT
         RW8lcyurSwr3uvdnjstG995KuS5ryMIxdFEkmw40caKPd3FBwYwZ2wrFJ27n9BlPvYIE
         bFmF3xCSYVmSW64YNTLkf+dlWsnDZY5lztoK8S8fcTlL+tVsQEfdFn/LzAc0xMIOZ3Hs
         tlehjg0/hu/kRnQA2kPyfuwK2USik4dGiuW/LDy2PQfsXxdNJlp/Vln5yUW5LCbkoYrb
         0PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=0Ppgp1aCECO9gcyY/vi63xjzkDF/lXx6115UUn7PjHA=;
        b=iCUXWGoircCccKhoKLBlH/sYnye+n93/2D7GMVqJCO6yaMT7iWO/Q/J2zmR7Yv7Dei
         IKRgo7SRvAVHQff0lQ7JI81HuCkoNVDnEyfK8YYXHBlTX0S5N91vKwZcsiFApfFKyUs5
         JVCRsAzXNtLiezAN+tIr9EX0BKCQ+7KGGAi/TeR/drOzFYL9LpEbQbp2ManiA98A3/k0
         9WmJayQeOviKUHEHYq0m/GOqSU4+vUQbO8LDHwTJ2dv9qu2zU0IXZQK3GASId3rZ1vdo
         oE/jbrfAiWbWo7Ka3HhDWinlwzsgNBHBZMrnXiqDXRdqsKYKlcvst4kmtRHL//s0w89l
         0E3w==
X-Gm-Message-State: AOAM531DPJDSqIKEgHe05uv0BubxWo4Uou2ODTMcpTboCv0/cALxEjdi
	RE+f1Eon0IMK/u23/QdtZlXDJYcWh3I=
X-Google-Smtp-Source: ABdhPJz4D40iCt+hQLjnibrzT3tE9haCCevcfSZvb8rXA5nQIEGgDSdNzC7WfuKTjV6yLBBL2q7Q8g==
X-Received: by 2002:aa7:871a:: with SMTP id b26mr10420373pfo.294.1595042838857;
        Fri, 17 Jul 2020 20:27:18 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id x13sm8633359pfj.122.2020.07.17.20.27.17
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 20:27:18 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/8] Pull request (cover letter only)
Date: Fri, 17 Jul 2020 17:27:08 -1000
Message-Id: <cover.1595042779.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1

The following changes since commit 1d3892d93ee9688d69f5bb5ea6aef8b1152bd1e3:

  msg: Avoid issues where paths have relative components (2020-07-01 05:24:29 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

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

