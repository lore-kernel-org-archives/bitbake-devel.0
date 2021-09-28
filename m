Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3248EC433EF
	for <webhook@archiver.kernel.org>; Tue, 28 Sep 2021 23:20:56 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.1920.1632871254166485832
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Sep 2021 16:20:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=2Ly7yhxw;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.180,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f180.google.com with SMTP id q23so324837pfs.9
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Sep 2021 16:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NRl85hhYA0+v0rXDd2CXUl4P53SErF+XqasHnQyNUsM=;
        b=2Ly7yhxwqfLg44xpyQGzHTKWqgXemKA5XNpqB5vZlIZax+QYZe/kjmpVK2AfzZFa8x
         zOa8Z+aGnWpBIqVh7nolidqbrYh/VwCvrju1sgP3khfCZ4KL2UzIku9A0OcIq/woecYl
         LzIZww+XVtAQCrLfMJO5uz8rhoo+FwWY8WWPXTniFWHeQuymxiwXy/QfE2kvurHqROLS
         WFZj1od1yHSDlIK8B8Z/izTohaWunSXiU88CW2l1shd0pgglhp0wlzGKw+eOmpBRjbDM
         OK+V5ZYw7Ht5xISE5defkRF5fEpX9Y1/sjgw39iUDvPiuK6YDBiaSF2GROYDd+QA9EfC
         AhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NRl85hhYA0+v0rXDd2CXUl4P53SErF+XqasHnQyNUsM=;
        b=HR5sESIY4FkK/wdzYjZcftegjBKhwtyjCBLE6Ywd1YwsS1pvyiqQcFhAjKTBLe3Mfh
         JVLuC/kOAkdG7jYbnt4RfiIRgqtK/K2JV/O4lQEpUUy2yvQfmdjiwn1lsEuBgPPM0rmD
         qxS+K0dX7SA1urwseI4cWGv82JBZaXJp8SDUH+tvAit43uYc7FoCdtb/PkhapYo/GOxF
         fyzSWpDn4DfEl0bkCpTA3bAEABCNvSRlhlGdBSPvePfvcGkLXnEAmOOu2tSgmKYDRf4i
         euAYB2w48FO3/QSxg2a5Y+4mLtPocEQ/YAE8Ir5M7g9g37kH46mfIhLzG5PmaPRfQzI3
         Pr5w==
X-Gm-Message-State: AOAM531cEAeUSsCpaXR4w+Xvlu/xzob2nKpASZrEo4OjkBinJwkonwqt
	uSXHUfwNrKntKJdeER0HbDzz4hBPuqwsDF6K2D0=
X-Google-Smtp-Source: 
 ABdhPJynjlamdvuCTjHceymZ3ZZW2HYEG9GagUqtIN5SmEPFhsLyXLKC0+epMQK5phs90yheUImvVg==
X-Received: by 2002:a62:d151:0:b0:44b:2b04:9b11 with SMTP id
 t17-20020a62d151000000b0044b2b049b11mr7902822pfl.38.1632871252774;
        Tue, 28 Sep 2021 16:20:52 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 77sm186203pfu.219.2021.09.28.16.20.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:20:52 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 00/14] Pull request (cover letter
 only)
Date: Tue, 28 Sep 2021 13:20:35 -1000
Message-Id: <cover.1632871177.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Sep 2021 23:20:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12712

The following changes since commit 3c1799b2576f80b6dcb310e03f77105a58b9fa8e:

  tests/fetch2: Use our own git server for dtc test repo (2021-09-22 22:45:10 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Joshua Watt (1):
  server: Fix early parsing errors preventing zombie bitbake

Marco Felsch (1):
  bitbake: bitbake-layers: add skip reason to output

Richard Purdie (12):
  ui/taskexp: Improve startup exception handling
  ui/taskexp: Fix to work with empty build directories
  build: Match markup to real function name
  build: Handle SystemExit in python tasks correctly
  process: Don't include logs in error message if piping them
  build: Avoid duplicating logs in verbose mode
  build: Catch and error upon circular task references
  data_smart: Improve error display for handled exceptions
  cookerdata: Improve missing core layer error message
  cookerdata: Show error for no BBLAYERS in bblayers.conf
  bitbake-worker: Improve error handling
  cookerdata: Show a readable error for invalid multiconfig name

 bin/bitbake-worker       | 10 ++++++----
 lib/bb/build.py          | 12 +++++++++---
 lib/bb/cookerdata.py     |  7 +++++++
 lib/bb/data_smart.py     |  2 ++
 lib/bb/process.py        |  3 +++
 lib/bb/server/process.py |  3 ++-
 lib/bb/ui/taskexp.py     |  5 +++++
 lib/bblayers/query.py    |  2 +-
 8 files changed, 35 insertions(+), 9 deletions(-)

-- 
2.25.1


