Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0741FC433F5
	for <webhook@archiver.kernel.org>; Thu, 21 Oct 2021 22:23:48 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.256.1634855026780007297
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Oct 2021 15:23:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=BM84+uEu;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.51,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f51.google.com with SMTP id
 q10-20020a17090a1b0a00b001a076a59640so6570646pjq.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Oct 2021 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yRKO2pvjzOEJ6BwIqT25cNT8zy5ZEcMwbHvvD4PDeQ=;
        b=BM84+uEuLoclqMTrQfycbgQKzcCJeOMUk0lOGSbZtL2hyi9J3S93g1xgmBSz5jUhR5
         j7m0S4pSAPnyXZe7QLNlHSBzHJ63cqitY3/TxPUn95OZjTjb5lyuyfAHc5qcsgsOYrS+
         ewPqy9OLCO9dnpy5FLBcMPclR8Zjhbb0wC4UDCl3gdWr0eNENf7U3vYuLc6FH5+Cur2Q
         pSPFhrS4sd7uWbD6C2S6V9owxa/wsyskuHTxBteXdxyr4gYHuZbL50I9r/C9ssElU6nf
         fetyC5TEnNvTQ/4Mycw/U5YTQyh9S2ISVxZBmhPmOhjy9i8h4AA05ZEoNnJLjGyJjf8n
         dYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3yRKO2pvjzOEJ6BwIqT25cNT8zy5ZEcMwbHvvD4PDeQ=;
        b=b3HaJ31zM/7Jg1AIEGhLdvalYn47JsN3+ifTwyoJHgjDRh51T2eSluiXB9xlPbaHhn
         pz740pMVSaT9wLrMJIV3AKO6Do1ia0NrLW3tcaxSsRHkrT9ob0+dpxaBVbr5GR+TMvqq
         l7qULFfXlZuq050tet0t2yWwb8r/DWEkLvytJJgOiwMKywcvEhmyb/bNRJhStZsuyoiA
         Dz7fXmutNCr5AJzXAyn7gNsALrE60ypDqKLKI5Ahtg9iVK0X3xS/wSp0VNiPUS83Nseq
         x0CNK7J6f6xHZW1rKTq0j3KbwnF3pWDvRg5mpvsadd8RhRz+aY7ReSsYPerIPv3q+u8/
         tnmQ==
X-Gm-Message-State: AOAM532E+5MxdgxZjjGCyqn3/EVq8GSPl+pvLZuETnKIT+SK8wS8wdBH
	AFH+LtVkSn8h5FPRyAEi9fFzQA/RkYIs9CytJ/Q=
X-Google-Smtp-Source: 
 ABdhPJxYr2i0cSG47iesc48EDEn+DOT+MqVwFMuhE1onTdwNPaXq9ysc4HzUQeoJB/4FFpnG1l3bdw==
X-Received: by 2002:a17:90a:191a:: with SMTP id
 26mr10081713pjg.79.1634855025855;
        Thu, 21 Oct 2021 15:23:45 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 142sm302188pgh.22.2021.10.21.15.23.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 15:23:45 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/7] Pull request (cover letter only)
Date: Thu, 21 Oct 2021 12:23:33 -1000
Message-Id: <cover.1634854899.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Oct 2021 22:23:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12813

The following changes since commit 93094705c1c66688e0730a1efb17805778c9fa9f:

  test/fetch: Update urls to match upstream branch name changes (2021-10-19 22:28:23 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

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

 lib/bb/compat.py              | 10 ----------
 lib/bb/data_smart.py          |  4 ++--
 lib/bb/event.py               | 16 ++++++++--------
 lib/bb/persist_data.py        | 13 +++++++------
 lib/bb/server/process.py      |  2 +-
 lib/bb/tests/event.py         | 17 +++++++++--------
 lib/bblayers/query.py         |  6 +++---
 lib/hashserv/server.py        |  4 ++--
 lib/layerindexlib/__init__.py |  1 -
 9 files changed, 32 insertions(+), 41 deletions(-)
 delete mode 100644 lib/bb/compat.py

-- 
2.25.1


