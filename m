Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDADC61DBE
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 01:37:13 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3433.1787708229745086138
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 18:37:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UPWPd7J8;
 spf=pass (domain: gmail.com, ip: 209.85.222.180, mailfrom: twoerner@gmail.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92ed19f4d60so29763085a.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 18:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787708229; x=1788313029; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NFWrIK7q5swhXALBkw1yx9Y3MjbyO0YF6+zCdDPwEa0=;
        b=UPWPd7J8ndJWMmRQbX6h+/eEUNe2vWuQTGntermdaLWhmufofJVVbpJk1uqqIEAqrN
         IUvtl7AivhHdv2Sum6jvB0daNiu01dv/bWg71dAC+XlKf+TbqexdzqjjkhdePcSC58Tq
         WuE4oTVHSncN6nla0qM6wvEnHI5rJiRIqUhJSON6EUXmRE+yiXQ845fEKE8qy7LdZODz
         m76HL/RrDMdekinwalPl4HHK64owvQH3ztyg+ziCfmYozjSJpf7FlIMYLUK1W+FyhVj7
         OdNMVRGkanoZSlqg3bZ18KZbGjcEtuf37OWd9Hh6JEavzKoKxURMHoX62ZNLJfNNA4Sl
         QbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787708229; x=1788313029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NFWrIK7q5swhXALBkw1yx9Y3MjbyO0YF6+zCdDPwEa0=;
        b=kHT9s9pCLSTd05jXqu0HysyfEvh7Hf6Q9dDwtz6HrO1bgR+kH+Q40U4BL+FBQoR/YW
         zjYe9VMbQY8rvqAtfazMoNV9jwA4ClO41MUbftlIxdRHIVtXGBU1/3rNdtw0aPMCAKtQ
         qxXz66CH/4nmKwMqmj3o+bh/IoGwWlX1l2aIasYeRBViYb+C+jnFTL117VYnizm6Bzc9
         A9OMeFrxnq+nLunTFC75q8zNfrQv239xr60PnmDSaXNhkuZbb/P3xsxz49o7bOsOlsvH
         SeHHEHHYdAj2ocUl0sVJ8mgI4jOdlHyIhx1Q/LKqz9/n/3j3hwZ62maqhA0Orp7OJiiv
         cejw==
X-Gm-Message-State: AFuF++mrAfnOMY656Zf0mRxiEkIqq2RPLH7ReRH3pLMJXRfAJRbrFi2k
	LjFIPPBfp9I22dTM7963/27Yz6PgIGa0G8QuvXb9B53e8/t+Bui/ZrdvXyHvpc3Y
X-Gm-Gg: AR+sD133s0kd6BQtAkewQ1HOJ+6AWfyqk9MO91n1I754PCPB+yhQ0MNEhAa0kD3ESqj
	NuI+MDUxMRbu02jEbqin0TJdYgCeyHAb4EuS8eshHKCnO59Mwdb6g0xwtvlL0E7sMBRpRmnwwrq
	YVrWXNcTcuCHOJgvfyePtreaimHxEn/YWff6sbHEJRCTuNQpL6u2GFK/uttbjoDfEvCAv705Y6M
	80XY90h38sUDVAEUvBem2PwwAZCvxgjzopUsA84VFHUarMoK50bSBi4cDDpz9yHks97EVW+5tZD
	CiYVmhnZlygXIbstEQentO4KLjfKCPfGZtSIXdDSmEM9czHSzVc0JJIEv65x3ucqrMh+IglpQkj
	1hAUa6aJ/2JniA1V6T91XCTMJNoDJ+dYDJMxFn6QWOotG7T7gVYPIcuKyl5E+I7H/po+wmtKoMq
	owH/PlZNLJ+T/NDBVwGbgFzcXjpXcR6LDGIRENNLdfepD0EIBT0i9TXDq/ajQStuNA3kyT8Mjb4
	AVN4iJjCvES2nlWlQisQmZ46sJgbBQ=
X-Received: by 2002:a05:620a:440f:b0:936:ef9c:8bef with SMTP id af79cd13be357-9376f2fb958mr1235192785a.2.1787708228608;
        Tue, 25 Aug 2026 18:37:08 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e67c50esm103863685a.37.2026.08.25.18.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 18:37:07 -0700 (PDT)
From: Trevor Woerner <twoerner@gmail.com>
To: docs@lists.yoctoproject.org
Cc: bitbake-devel@lists.openembedded.org
Subject: [PATCH 0/4] doc: highlight BitBake snippets with the bitbake language
Date: Tue, 25 Aug 2026 21:36:59 -0400
Message-ID: <20260826013703.2674786-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Aug 2026 01:37:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20050

Pygments 2.21.0 added a BitBake lexer, so BitBake snippets can now say
what they are instead of rendering as plain literal blocks. The user
manual is where the language is documented, so it seemed the wrong place
to leave unhighlighted.

No prose changes, no reflowing, no reindenting - every hunk turns a
literal-block introducer into a code-block directive and nothing else.

Which blocks were converted was decided by reading. Blocks that share
BitBake's assignment shape but are another language were left alone,
including the bitbake-setup settings files, which are INI and already
tagged as such.

Please do not apply this yet
----------------------------

The autobuilder builds the docs with a pinned buildtools tarball that
currently carries Pygments 2.19.2, which predates the BitBake lexer.
run-docs-build also passes SPHINXOPTS="-j auto", dropping the -W the
Makefile defaults to, so on that toolchain every one of these blocks
would publish unhighlighted and the build would still succeed. I have
asked separately about refreshing that tarball.

Sending now for review rather than to be merged. Once the toolchain can
render it, this applies as-is.

Depends on
----------

"doc: state the language of six Python blocks explicitly", sent
separately. That patch stands on its own and can go in independently;
this series is based on it only so the two do not touch the same lines.

One block worth a second opinion
--------------------------------

bitbake-user-manual-ref-variables.rst has two blocks where one real
assignment is followed by a long prose "where: ..." explanation. I have
tagged them, but the same shape elsewhere was deliberately left as a
plain literal block, so I may have called this one wrong.

Trevor Woerner (4):
  doc: bitbake-user-manual-metadata: use the bitbake code-block language
  doc: bitbake-user-manual-ref-variables: use the bitbake code-block
    language
  doc: bitbake-user-manual-fetching: use the bitbake code-block language
  doc: use the bitbake code-block language in the remaining chapters

 .../bitbake-user-manual-execution.rst         |  44 ++-
 .../bitbake-user-manual-fetching.rst          | 124 ++++--
 .../bitbake-user-manual-hello.rst             |  20 +-
 .../bitbake-user-manual-intro.rst             |  24 +-
 .../bitbake-user-manual-metadata.rst          | 372 +++++++++++++-----
 .../bitbake-user-manual-ref-variables.rst     | 188 ++++++---
 6 files changed, 579 insertions(+), 193 deletions(-)


