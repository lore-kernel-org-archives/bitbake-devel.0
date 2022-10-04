Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA5C4332F
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 15:55:18 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web08.12413.1664898910860796005
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=Sn9eufIN;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.179,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f179.google.com with SMTP id c7so13041468pgt.11
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=LiUkz1jr6zBgtqiwsBwshwtifb7GcAnXYv2RQl20ol0=;
        b=Sn9eufIN3zi1cNO873oGrdvKI+rbByVjx6767/18WZmvIH3uJK6PEvdckXWpKhCwXp
         bc0MGNuFA1hc7F7pGEhfRi2JOWWvc0tHI5SXFjMeqMw40KwxKmd2TLDTP6QGtiTeWMhp
         IiFgjcvsT8A675+sYJJQXayK5BmvNY3xlwUBTjPD2vDVzIPoizDhiFg/OMu04QhAotOq
         WRu0iR1a2iEAbTZY3+jHQx535gkOtG1wo8fBAmlw39Z6RUPtBmx3Tk+zicvPgvw3CcsT
         93X6pwRKPbkIMjDJkUO8yRQdJ2arZKlG8wyUgaQ/WnqnK29XM9FmHbd/0AOpZLZF/Kzx
         s0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=LiUkz1jr6zBgtqiwsBwshwtifb7GcAnXYv2RQl20ol0=;
        b=qfu7T+yxGDUPFOWSH25vB+WzXLYtoTJhsStq6rpfbGLj6hqItdUdy/JmkMrjxZvK+G
         DmwoJebK/aqi1sZWq2J0kac6gDsxDUdFZYCfB1HfGNsdkDxcIVn+Fk1B4FSBZM6tR8yK
         GDhENnpSYhtoqPvGB1LiPqmEivCD2blUXO+28dzzgIRcava5TewiQYPNB+7+z0rVYAOw
         L9S3pOMFcRy6gsguV/U3Yv6u9xrXAZyjR1k8P8Wy+UyY6RqTIZyf/tg3t+uLvcBK6+GZ
         98gVAgq44oCjXmDaLHe+AQ8+PzGPA6C0BADAZVSnB0EPDtSiA+ZNYrK708uCScD3QhB6
         b/Bw==
X-Gm-Message-State: ACrzQf1zVvATZzK82IDPBBcxwqBo1NFTsikU1YVWkJp+qWqraUh1hq2L
	3uTrSPs7iiNtnxn4eTLY+3gnJmBDzyuAU/6l
X-Google-Smtp-Source: 
 AMsMyM6///XL+Tm+wDJhkeRUygevUTKjXPApsqWg0n7kmD60P++zMwt48aBzhvysk67LhyKbTDrnNg==
X-Received: by 2002:aa7:8893:0:b0:544:7429:b077 with SMTP id
 z19-20020aa78893000000b005447429b077mr28239491pfe.69.1664898908466;
        Tue, 04 Oct 2022 08:55:08 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k18-20020a170902c41200b0017e232b6724sm4716457plk.69.2022.10.04.08.55.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:55:07 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/8] Patch review
Date: Tue,  4 Oct 2022 05:54:51 -1000
Message-Id: <cover.1664898736.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Oct 2022 15:55:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14015

Please review this set of patches for kirkstone/2.0 and have comments back
by end of day Wednesday.

Passded a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4294

The following changes since commit ac576d6fad6bba0cfea931883f25264ea83747ca:

  bitbake-user-manual: npm fetcher: improve description of SRC_URI format (2022-09-16 17:52:26 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Joshua Watt (1):
  siggen: Fix insufficent entropy in sigtask file names

Neil Horman (1):
  Fix npm to use https rather than http

Pavel Zhukov (1):
  gitsm: Error out if submodule refers to parent repo

Richard Purdie (5):
  runqueue: Ensure deferred tasks are sorted by multiconfig
  runqueue: Improve deadlock warning messages
  runqueue: Drop deadlock breaking force fail
  bitbake: Add copyright headers where missing
  asyncrpc/client: Fix unix domain socket chdir race issues

 bin/bitbake-prserv               |  2 ++
 bin/bitbake-worker               |  2 ++
 bin/git-make-shallow             |  2 ++
 lib/bb/COW.py                    |  2 ++
 lib/bb/asyncrpc/__init__.py      |  2 ++
 lib/bb/asyncrpc/client.py        | 24 +++++++++++++++---------
 lib/bb/asyncrpc/serv.py          |  2 ++
 lib/bb/codeparser.py             |  2 ++
 lib/bb/compress/_pipecompress.py |  2 ++
 lib/bb/compress/lz4.py           |  2 ++
 lib/bb/compress/zstd.py          |  2 ++
 lib/bb/daemonize.py              |  2 ++
 lib/bb/exceptions.py             |  2 ++
 lib/bb/fetch2/gitsm.py           |  3 +++
 lib/bb/fetch2/npm.py             |  2 +-
 lib/bb/fetch2/osc.py             |  2 ++
 lib/bb/process.py                |  2 ++
 lib/bb/runqueue.py               | 20 +++++++++++---------
 lib/bb/siggen.py                 |  4 +++-
 lib/bb/tests/compression.py      |  2 ++
 lib/bb/tests/cooker.py           |  2 ++
 lib/bb/utils.py                  | 21 +++++++++++++++++++++
 lib/bblayers/__init__.py         |  2 ++
 lib/bblayers/action.py           |  2 ++
 lib/bblayers/common.py           |  2 ++
 lib/bblayers/layerindex.py       |  2 ++
 lib/bblayers/query.py            |  2 ++
 lib/prserv/__init__.py           |  2 ++
 lib/prserv/client.py             |  2 ++
 lib/prserv/db.py                 |  2 ++
 lib/prserv/serv.py               |  2 ++
 lib/toaster/manage.py            |  2 ++
 32 files changed, 106 insertions(+), 20 deletions(-)

-- 
2.25.1


