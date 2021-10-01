Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9CBC433EF
	for <webhook@archiver.kernel.org>; Fri,  1 Oct 2021 15:35:26 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web09.10011.1633102525625743199
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Oct 2021 08:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=XcXN6jAd;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.172,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f172.google.com with SMTP id 187so3842412pfc.10
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Oct 2021 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dpPF7Rra5GYgAxeWEKVpd0LpSsDAo+D3hK+HbuHZv0=;
        b=XcXN6jAdCDVXdUr+8u4u3Q7TbzedA6bFlvMfud5XY5kbufADKh8kY7VFt57neGtQzw
         2fSAOLaXdfTWLql7KcGYRp8Ask8R3kO1BJmA8GDbioDr2JdxymzFY7JOzn0tSQGwk9Ot
         /CxucETBAxCEd7JcxEyAwODVlk+VJGaFrV2cMxnYIKe0DW4CqO8NcmUjYbkfGqx1eTc7
         IZcRbJtOMnhLlcpLQ1lObFo+RDbV58omHEKiFKjBUfxx9pLDGZ2e0sKwqAQu6MbLc848
         CdYkg1UMWP35wvHUIDKUc4FdQvt3GfHb9D6OVIdbz98h7PNoi66Y53PjXNl8a36ZnKWb
         Elhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dpPF7Rra5GYgAxeWEKVpd0LpSsDAo+D3hK+HbuHZv0=;
        b=DJ2swriR2XxPODaK2jC4M8ZrxSPpyqnyti6J4CjZbs3WmJbut5RsS/4CcnnI6cl2BB
         0MID9AsaSjBU/Czx7GT6aX+2xnBHY+8LNPfTplYx64WqgQ5SqsONTJGcPSdY/NELx6Ju
         2ITT5ikgvOPucHs0KYV7CW4KJclDN2f3aFyOXli4aC3JipuX0UzGEVTMrmwwWuFUF4b2
         aRa40fpI8MXQXEY1uN7SZtYYuUclaoE1oISjL4HGj5faj0ydRudWYtq8Du6AanfYd8je
         cZBU6fdMXGbnz5joqMJ0srBMMzG9x+qO210qSod5z55F1rvpcIZc5+GZ+iUNZIprsgxu
         AwQQ==
X-Gm-Message-State: AOAM5314uQ7B4ltm/hB6qYpwmKUWsgShrcDw5NagK2p34adSH021QQ6/
	O+H0kApSm1DB6M5cc3n7TLqDMSDpJ09AmHMa9Wk=
X-Google-Smtp-Source: 
 ABdhPJx9hA9ml2qE8xa0CmnzfD1uFQThNKTzJfrk/BBN0OX1tTeOaQje7EhTAyIiNEuoPZY3POGX5g==
X-Received: by 2002:aa7:9e0a:0:b0:447:a7f7:40e with SMTP id
 y10-20020aa79e0a000000b00447a7f7040emr10744372pfq.37.1633102524390;
        Fri, 01 Oct 2021 08:35:24 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 d2sm2179611pjg.35.2021.10.01.08.35.22
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 08:35:23 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 00/15] Pull request (cover letter
 only)
Date: Fri,  1 Oct 2021 05:34:54 -1000
Message-Id: <cover.1633102328.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Oct 2021 15:35:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12721

Based on feedback, resubmitting pull request with the addition of:

build/msg: Cleanup verbose option handling

Passed additional a-full test on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2677

The following changes since commit 3c1799b2576f80b6dcb310e03f77105a58b9fa8e:

  tests/fetch2: Use our own git server for dtc test repo (2021-09-22 22:45:10 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Joshua Watt (1):
  server: Fix early parsing errors preventing zombie bitbake

Marco Felsch (1):
  bitbake: bitbake-layers: add skip reason to output

Richard Purdie (13):
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
  build/msg: Cleanup verbose option handling

 bin/bitbake-worker       | 14 ++++++++------
 lib/bb/build.py          | 19 ++++++++++++++-----
 lib/bb/cooker.py         |  5 -----
 lib/bb/cookerdata.py     | 14 +++++++++++++-
 lib/bb/data_smart.py     |  2 ++
 lib/bb/msg.py            |  6 ------
 lib/bb/process.py        |  3 +++
 lib/bb/runqueue.py       |  4 ++--
 lib/bb/server/process.py |  3 ++-
 lib/bb/ui/taskexp.py     |  5 +++++
 lib/bblayers/query.py    |  2 +-
 11 files changed, 50 insertions(+), 27 deletions(-)

-- 
2.25.1


