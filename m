Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCDFC25B76
	for <webhook@archiver.kernel.org>; Sat,  1 Jun 2024 12:27:36 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web10.36208.1717244848666461952
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Jun 2024 05:27:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=BItbmA9o;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.182, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6819d785528so2029412a12.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1717244848; x=1717849648; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+OvjfbEDmxY0SMKfkyHP9gL7NaKMnfV4qYEnjYZsPU=;
        b=BItbmA9otGErmQV6623vhS3mtlJArvjD3Ycb96pAMpqZ67z0RfaZ7Q4OHjihrz5tfz
         00QHU8iCLp0rm+RJ95hFm6Nv4hgWSNLyLHaEaEdspyAsgsEDi7ciNUrG4MEqJtoPgQCt
         wp9TBLgSzlCjEcpG1vYPhUsecotxP/9jkbDanaJKanMZDhV5o8UH/OytLqjHggBbRWUZ
         e7JBzq5nCVIDGt9SdJQYjR3isULRpixS+TdEu9Y/1WnUo9wvETYA+B0aOSQOy0H7opf1
         tia4YSHXGE6hotc1nwy4GHXExY1zQuCCOlSJzUIxXxMOhIQj614rrhlvjXet8srh7H0c
         npVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717244848; x=1717849648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+OvjfbEDmxY0SMKfkyHP9gL7NaKMnfV4qYEnjYZsPU=;
        b=dNwKXcFf+DLzZxYUXH0qCZJASWdJLPRfTmfaTtMwFB5c4IBmEfakU69wp0udsJT0cu
         miIPzUEhd+gqy+UP1AEzhAsJqD6BD65R9d/zKke/jBzjNw4UjokJU+J8Ls1njfMXlWeW
         VaIzo/fGoVbXW/jp20Uz68fnZu0hZIi1rm6lQFNAEoA5wVQy9H52rNnr02lnMB3k4qz3
         UzTIZFP1i3LE3Rx45SxgBfN58mJAc6bqqOWETB2IM2HSEPel+27AM/kKZfpPCYU1bUB0
         IivXTG2Viwsmz55U2hkjlLVUvbiMdrJqOZpWIdBrc9WJtGcsMz8oCHb+ni1bYaeClwpn
         6zwQ==
X-Gm-Message-State: AOJu0YywqA3/wD+l2penwLlisMsFcYEdXKEN5gvUa7yZVFUVWOSTefz0
	H+wPWEAy47NZQ5PwSjRr4iNANB1FQI/Nvg2X/1Kz3nt7tccfWHcUj+4N78qH8d3UJ79uXCjeeKP
	8
X-Google-Smtp-Source: AGHT+IEYEeeMZcNF9ffJgkx8wBRtJpuKE5Iutj6baFg6C3ycON5xwVnD82OBy0Z7cAhscqOY1TPUow==
X-Received: by 2002:a05:6a20:244e:b0:1af:cfcd:a72f with SMTP id adf61e73a8af0-1b26f1c50b3mr5351700637.21.1717244847928;
        Sat, 01 Jun 2024 05:27:27 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b30013sm2809362b3a.211.2024.06.01.05.27.27
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 05:27:27 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/8] Patch review
Date: Sat,  1 Jun 2024 05:27:15 -0700
Message-Id: <cover.1717244760.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 12:27:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16304

Please review this set of changes for 2.8/scarthgap and have comments back by
end of day Tuesday, June 4

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6993

with two exceptions, the first a known reproducibility issue also present
on master:

https://bugzilla.yoctoproject.org/show_bug.cgi?id=15491

and the second is a failure on meta-agl-core, which will require an update
to the ptest-runner override in meta-agl once "ptest-runner: Bump to 2.4.4 (95f528c)"
merges.
The following changes since commit b5159c0373e2e7d403aed16e096ad655f38b1fa7:

  fetch2/gcp: Add missing runfetchcmd import (2024-05-28 15:27:08 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

Joshua Watt (3):
  bb: Use namedtuple for Task data
  hashserv: client: Add batch stream API
  siggen: Enable batching of unihash queries

Richard Purdie (4):
  runqueue: Add timing warnings around slow loops
  runqueue: Allow rehash loop to exit in case of interrupts
  runqueue: Process unihashes in parallel at init
  runqueue: Improve rehash get_unihash parallelism

joshua Watt (1):
  siggen/runqueue: Report which dependencies affect the taskhash

 lib/bb/__init__.py     |  12 +++++
 lib/bb/cooker.py       |   1 -
 lib/bb/runqueue.py     |  99 +++++++++++++++++++++++++++-----------
 lib/bb/siggen.py       |  11 +++--
 lib/hashserv/client.py | 106 +++++++++++++++++++++++++++++++++++++----
 lib/hashserv/tests.py  |  75 +++++++++++++++++++++++++++++
 6 files changed, 263 insertions(+), 41 deletions(-)

-- 
2.34.1


