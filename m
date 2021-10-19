Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5B3C433F5
	for <webhook@archiver.kernel.org>; Tue, 19 Oct 2021 20:06:28 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web08.15452.1634673987788506096
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=aj5lVSbM;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.53,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f53.google.com with SMTP id
 nn3-20020a17090b38c300b001a03bb6c4ebso793803pjb.1
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnJjKW3VreKPHPyk55UpGw9RiKu1NJfYFX1mQfWCqKk=;
        b=aj5lVSbMWfiHjmQf/ND/QGQth+KuJqCGZjwxO9AoaDl5LrGQ5TW9+DWBS+baQWDhDL
         OpDO1PCbiE+r7lRCPz+u/i8BFrX6IXeijS6rJl1wl4YbZ+T/r++d00Ayq/GFK5UEuBxR
         yzySryCHuHkCWvDOJ8ygAR1AoG4Koq+0qZtYL/x784XbGgp65wHwfnJ/fFLIya8ZHYp9
         qIbccwQ9IRw/+L6dLfandnr4QYx2cESrZ81CTwRejP31V3epGS1mF9LicBrgO08BUiGM
         YdJTLJoWKvHySP4xVBkF3FI/uUM+gZ3GICVaUEtVmEK5qKCr4tgd4/2mBHDyfnD3bRMd
         panA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TnJjKW3VreKPHPyk55UpGw9RiKu1NJfYFX1mQfWCqKk=;
        b=Do1cbgC7Ax7pikE9IGp4uTQIOipaefAptcUewvt/LJqUHXkzGTCUSiFLRlZC8r2TZv
         D7t5mPeV1a2Pv1auxqXfEeUyfNOBXXrjpATXT3fmq6mJYX4bVpf++Nm0RPm0LPnu+0s4
         hxFQWvsRrafNuiTlZPixWhAngNMGvhw6XjFsoPbK2rNCvEcIA1etoBLN2N9X4rFOB6B+
         zOmJsm0PgLqsiLEsem3zRSBgYF9n4W9PYw71RCXdtz8h3ZwQyguGl7cOQv48fyeHPTif
         XL8IkYt51WW4DrMIv1MyENPUMXXdMMgRMdPRTz8TX/oUY2ziTI3xhimjFZZ0KuqmvuuM
         Vbfw==
X-Gm-Message-State: AOAM531+U3B8pKNnXAnAxkLJe8pkhh8Fx0HNY6nPqFge+TQc9x/OHNnt
	YuBRJAWtxxwcOr66+spwJyzetThuIfvFcgHOZqs=
X-Google-Smtp-Source: 
 ABdhPJyUjWNorojetnVIpnylWpd/Lk7/C6fd9pjxmMm1kaWp3IzBt1wfk3RlcwFyTYkt3j6lgotx2A==
X-Received: by 2002:a17:902:c104:b0:13f:59f9:db92 with SMTP id
 4-20020a170902c10400b0013f59f9db92mr34678232pli.75.1634673986588;
        Tue, 19 Oct 2021 13:06:26 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 l6sm3533562pjy.23.2021.10.19.13.06.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:06:26 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/8] Patch review
Date: Tue, 19 Oct 2021 10:06:08 -1000
Message-Id: <cover.1634673786.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Oct 2021 20:06:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12802

Please review this next set of patches for dunfell/1.46 and have comments
back by end of day Thursday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2772

The following changes since commit b4117231bf070703b9375af4411bcd160e07fdae:

  build/msg: Cleanup verbose option handling (2021-09-30 04:12:50 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Alexander Kanavin (5):
  bitbake: correct the collections vs collections.abc deprecation
  bitbake: fix regexp deprecation warnings
  bitbake: do not import imp in layerindexlib
  bitbake: adjust parser error check for python 3.10 compatibility
  bitbake: correct deprecation warning in process.py

Chris Laplante (1):
  compat.py: remove file since it no longer actually implements anything

Justin Bronder (1):
  hashserv: let asyncio discover the running loop

Richard Purdie (1):
  test/fetch: Update urls to match upstream branch name changes

 lib/bb/compat.py              | 10 ----------
 lib/bb/data_smart.py          |  4 ++--
 lib/bb/event.py               | 16 ++++++++--------
 lib/bb/persist_data.py        | 13 +++++++------
 lib/bb/server/process.py      |  2 +-
 lib/bb/tests/event.py         | 17 +++++++++--------
 lib/bb/tests/fetch.py         |  6 +++---
 lib/bblayers/query.py         |  6 +++---
 lib/hashserv/server.py        |  4 ++--
 lib/layerindexlib/__init__.py |  1 -
 10 files changed, 35 insertions(+), 44 deletions(-)
 delete mode 100644 lib/bb/compat.py

-- 
2.25.1


