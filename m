Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D48CC433FE
	for <webhook@archiver.kernel.org>; Mon, 10 Oct 2022 16:15:56 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.8331.1665418554426118605
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Oct 2022 09:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=NH9vV3NS;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id n7so10826090plp.1
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Oct 2022 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=43lq9rJtoQ96Mk3JAnCFccBknSNZmcZcnvyya/qb6Xs=;
        b=NH9vV3NS6Fhanbse9aMH6EpHRxtZ6A0V5AKVCY+7OFZD9q8+SBcUdcK8AmgxMTz0cw
         x8WVj9jLOgjuPEt9pVO2D/ozTGDy6MfHX8DHpMrT6gFf+5fIx0gIqK4l9kxarEGTb5/j
         s1AQ8HprScowchyrvChufUn4NQuM0iGXmuMsQ0LfyC8DdTc8MDj/1xOAqsVq/EFFvAvV
         UvGk7KKQjaVzelNNzWTMw+Oog8VqXv3Z51EwSzLCR1vspiUdDBLFq/L9vp8dWiyCCOJb
         uyX8YGFeoFwPMNU6kAI39/xontFyQ3dcszOS/faAgFagYLTZNgfALhnyMkCtp4cpt/sZ
         bFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43lq9rJtoQ96Mk3JAnCFccBknSNZmcZcnvyya/qb6Xs=;
        b=QQAbw4dzLSetEwSLhyJJTomuBoJKYmtqyXuSJnZSjRyW5+LPXqWb1IrphnpyeCmcoX
         qBflZidGOSMO3WqXnJY1hzoCZ/r0gHVbX7VrS2C09rtYlZKNN9x+zmY7ZDhEHBalIfNZ
         1rV1gZv1MC7YkeVSMEPPfgiAQlrvJexbugWSjIZP5yVO2uoC21k6b4/OtkcT3U4yO3aI
         tL1f4pkAaFcXyG5wrvuWFTrapVKUXA49l47yGCO0Gd8NTiQUKZbPBuINnKbaqMSL/yNQ
         Ny8nWyQaFXS2UmExjH/dX4bqinWhv1xsiPopJy14d0Xbl6zZvOjx0TLYYTHleGBB6BQu
         NnEg==
X-Gm-Message-State: ACrzQf1Ge8++OonRPiMfpHbwC1+iPfaTgtyK+pAyxUUpHcnrBN4ttfsO
	4RXGnxbS58/iZlmy0NQP0Cqj7e67Xb3Bpdwy
X-Google-Smtp-Source: 
 AMsMyM4BVmxG+yoJDi0cdOuiRC7R6JI9o766m9uGPgU5TLdiEQHF6oiD9CZAJTRk/BfvgUms2yibOw==
X-Received: by 2002:a17:902:b944:b0:179:fdb0:1c39 with SMTP id
 h4-20020a170902b94400b00179fdb01c39mr19947174pls.98.1665418553109;
        Mon, 10 Oct 2022 09:15:53 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 r27-20020aa7963b000000b005636d8aa98dsm1979312pfg.141.2022.10.10.09.15.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 09:15:52 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/8] Pull request (cover letter only)
Date: Mon, 10 Oct 2022 06:15:44 -1000
Message-Id: <cover.1665418501.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Oct 2022 16:15:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14031

The following changes since commit ac576d6fad6bba0cfea931883f25264ea83747ca:

  bitbake-user-manual: npm fetcher: improve description of SRC_URI format (2022-09-16 17:52:26 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

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


