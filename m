Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DD6ECAAD8
	for <webhook@archiver.kernel.org>; Fri, 16 Sep 2022 16:54:30 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web12.8527.1663347269234461623
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Sep 2022 09:54:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=xL89hGgp;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.181,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f181.google.com with SMTP id s18so16028225plr.4
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Sep 2022 09:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=quVlzDFd5BKIORrUbsdWYHATuxzSEu+8AsoFxXDYpKs=;
        b=xL89hGgpSVqitDQxvga2Jyjesr4YuhOcAIkZ3SJoTNu9lJNTPSXac2M5UylvQtIhnj
         Zw2z33oJG9vlisXiqzyUYN/eXp/lWsBSVzo+V11stUiscTf9r1GpCM191Yq37eBWYep7
         aO/5c05eVsrZsiF7x4vOwjm584DiVGVp5a92820ZzhZ//+Ki1Kj9Yh7Jtwz03QUimkxw
         Iy0QBI3xPGlR/Kgd6GFjuIQhjpxglTIrYjKh0fHMxTqsmWA2wp2ACiNpjn+RJFum5ixD
         mftgFdsRS04pQM2xWbWT4F7xOqiQHaySCkjo4KmluQR7eBFckwlX7y2R41N6079q+LXB
         4+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=quVlzDFd5BKIORrUbsdWYHATuxzSEu+8AsoFxXDYpKs=;
        b=0cyQ2CqVYKdwONnOtWiOcgipVNCViQdGl90wGC/UjqB6DCHb+nXHauWorZVNO05n2V
         KbuZbvWBlSdObIP0lcwCP4XDkim3Lkack0GQxARVFkjUZLlfUs3coSPSrmsMwOo6JR/I
         GyZOlrG2IcfyfZQxhCqDhWSF3e+Do5KuErS2CT5qul6KR85aym8ewZilxsGBCcoCfb1q
         Qs6jaQzo09BCD86fuKPTQTNv1LzdM9RsDa5GmMHGzs8cPTcFWtAn5Tg35xkz11oMObo2
         hx+1IdSauK5a9iBOHUqrmXEuR9kUjeZDbeqPIn3HZ2eeUrwpwQzDaIhar711fhGicFYH
         6mdA==
X-Gm-Message-State: ACrzQf2QfgBbuYg01sUyBqHDlU+MY48IBUObgXlnhWNnC/pnuRPs5dMS
	NNJff1b0xRoKhkbmstuTOf9rqZ0OO0MeEoCk
X-Google-Smtp-Source: 
 AMsMyM5POo/IJB/DR5SNPawf0NoBWIa0kGTBPBjM8negKmDnGC3yv6rjqIauiP0FD5hVDkfo2GFnPA==
X-Received: by 2002:a17:90a:b10c:b0:203:6a73:8a93 with SMTP id
 z12-20020a17090ab10c00b002036a738a93mr82702pjq.178.1663347268054;
        Fri, 16 Sep 2022 09:54:28 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 r16-20020aa79630000000b0053e56165f42sm15206776pfg.146.2022.09.16.09.54.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 09:54:27 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 00/14] Pull request (cover letter
 only)
Date: Fri, 16 Sep 2022 06:54:14 -1000
Message-Id: <cover.1663347153.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Sep 2022 16:54:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13977

The following changes since commit ce9fe70156e8f909a3a81da017b89ea61bc6fe38:

  utils: Pass lock argument in fileslocked (2022-09-02 11:44:47 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Gennaro Iorio (1):
  fetch2: gitsm: fix incorrect handling of git submodule relative urls

Jacob Kroon (1):
  bitbake-user-manual: Correct description of the ??= operator

Jose Quaresma (3):
  bitbake: bitbake-user-manual: hashserv can be accessed on a dedicated
    domain
  bb/utils: remove: check the path again the expand python glob
  bb/utils: movefile: use the logger for printing

Michael Opdenacker (3):
  doc: bitbake-user-manual: add explicit target for crates fetcher
  doc: bitbake-user-manual: document npm and npmsw fetchers
  bitbake-user-manual: npm fetcher: improve description of SRC_URI
    format

Mikko Rapeli (1):
  event.py: ignore exceptions from stdout and sterr operations in atexit

Ola x Nilsson (1):
  ConfHandler: Remove lingering close

Richard Purdie (4):
  runqueue: Fix unihash cache mismatch issues
  cooker: Drop sre_constants usage
  ConfHandler/BBHandler: Improve comment error messages and add tests
  fetch2: Ensure directory exists before creating symlink

 .../bitbake-user-manual-fetching.rst          | 78 ++++++++++++++++++-
 .../bitbake-user-manual-metadata.rst          | 55 +++++++++----
 .../bitbake-user-manual-ref-variables.rst     |  2 +-
 lib/bb/cooker.py                              |  5 +-
 lib/bb/event.py                               | 10 ++-
 lib/bb/fetch2/__init__.py                     |  2 +
 lib/bb/fetch2/gitsm.py                        |  2 +-
 lib/bb/parse/parse_py/BBHandler.py            |  4 +-
 lib/bb/parse/parse_py/ConfHandler.py          | 11 ++-
 lib/bb/runqueue.py                            |  3 +
 lib/bb/tests/parse.py                         | 23 ++++++
 lib/bb/utils.py                               | 16 ++--
 12 files changed, 172 insertions(+), 39 deletions(-)

-- 
2.25.1


