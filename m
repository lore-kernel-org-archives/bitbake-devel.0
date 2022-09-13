Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519C2C54EE9
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:27:00 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web08.5352.1663079218165494293
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:26:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=1Nw59Het;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.175,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f175.google.com with SMTP id c2so12007239plo.3
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Sep 2022 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=OJ0G2ELecLNdxw/D6lnEexgtylU/Bv9qBWFtJbmkVxw=;
        b=1Nw59HetTpXcX+kvn419QuzGtqrQVo8QHShNENN9HtzISr2owiBUnmBowU1hAqr9AC
         dOl5aHID568S4ev84J3aJXbHT1Cf/usfGDc4FjcmmApSIg/mqOiBniNGsvoHPvWwSS55
         V0HRu4o2aiOMlLFwR6PFRAnXX7943LOKjUNSQIGBCcKLINp8j7jMMyx+TZpeZFbF/PvY
         EuQlE43OTzjbukbJ+j+Ec3TOReWX25soZidFvcupHAcCM5HbK9ysJqNQbz3jk9di9/zR
         oaNoRaIT80duGkoTEAIoL+q7cmDxAg+l3Q5TP3fv/n6FqGB19SVvgPMDX9TNLp8S7QXE
         2Fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=OJ0G2ELecLNdxw/D6lnEexgtylU/Bv9qBWFtJbmkVxw=;
        b=r/6t2xFAD0Uk02gb4QnvSqmIgLVCp5GBsaW6BEPcpH0/KOqVdbT4iyIOBI6XVVu4zO
         ZVChKzCFRNpiCHO32JICfP3jT4kzzeZCr6wyUTboeQ7MJcuBFVnbkNBcPXCgyHEI4WiL
         cU0QuvQ8iSwp62RxvUIAoFPyYdE64IQ98EnCnpGaI8nc7wbUtX4WovuJNiAMrQmx9uua
         YjVZCA9ou+5LzzW7eXSAYrE0FXC3sGSXCc4KAmSu8XE7t4TEzi6zsPfYHJPJMSCs+sm1
         myQ6V3Rvxy0lrelk0/qVBFHgEt1EeM0bfogBH7KIpYrFyyEGfyjtaOCwbQgsxp0Zaz0f
         uf/A==
X-Gm-Message-State: ACgBeo1Zg+uIPoDmVccSCT5y0+dO9AJFe0PeGQS1nwASM2S0prIJnUVj
	9nEpAtxH3TZUZiZyzdJS1K+G91Ev4CzzwF+C
X-Google-Smtp-Source: 
 AA6agR6xFWeGtLM6H9N2t8b1L3PQYh5BZ0KvN7BtCgUPSbWt0GiSKCCcVWdulTSu/6pC1Yp1a5mIiA==
X-Received: by 2002:a17:902:aa81:b0:173:3f68:e768 with SMTP id
 d1-20020a170902aa8100b001733f68e768mr32016938plr.80.1663079217023;
        Tue, 13 Sep 2022 07:26:57 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f196-20020a6238cd000000b00540de61c967sm7840286pfa.201.2022.09.13.07.26.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 07:26:55 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 00/14] Patch review
Date: Tue, 13 Sep 2022 04:26:30 -1000
Message-Id: <cover.1663078873.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Sep 2022 14:27:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13961

Please review this set of patches for 2.0/kirkstone and have comments back
by end of day Thursday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4220

The following changes since commit ce9fe70156e8f909a3a81da017b89ea61bc6fe38:

  utils: Pass lock argument in fileslocked (2022-09-02 11:44:47 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/2.0-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

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


