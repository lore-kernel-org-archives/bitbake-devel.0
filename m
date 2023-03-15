Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030EFC76195
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 01:33:42 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.2023.1678844013371373863
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Mar 2023 18:33:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=mOyOT0IK;
 spf=pass (domain: gmail.com, ip: 209.85.216.48, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f48.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso159207pjb.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 18:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678844012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VIbQEp8c/bvCRBGeMiC274g2S8z8CKCav8uxzyMmd9w=;
        b=mOyOT0IKdBDkkItit/f80lYeNtOZEELfDJVxZcpBor4NoKx95z5GKoLgE8KEhgzbAY
         rgdkoeVotC6q+cv0fpxYU8bGrwIN9iyzgdXPEi6CNpSopONqnwWBi5ej6Et8hL8a0Ju6
         iFpdDGomV8RbiRhUmtH1bJY7/VGYhquYOj8QNOz/iJMaNn3KLkOT0hrrkgxupFFiRfna
         7ctOpr69gQzD0+y+sXRoWGbJ1t8lJuBeav+Z+/38vf/xSTycN7ge21idWETh670zP77P
         luTxKs7IRik3K64yff7o1dF56YpUnTWTW3hKgotBD03NbtX5MwFwOoLPEuqivZRvUaYc
         7Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678844012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VIbQEp8c/bvCRBGeMiC274g2S8z8CKCav8uxzyMmd9w=;
        b=Kt6vRFBIikAqF7tgYGXuOQEpF4CnibUvSf8zuuX2glB2OmLSiY1elVbRqx7ULd88wQ
         Us4Cs+A6EPxGb/mZ6SHhUFNAIvHjuTt4MF5gVdKGlrvfWCHPAlbdcIzCnZCEIgLkEyB2
         roVjcOuz5Lv6Pab3hxm+XfeGD1kk2A8jad+2ePiwz+mbaOcwvg+mvoJZ52o5P0z8g501
         Tq+YkOgtPjmZ6RCChWv8kCKMIgwdnLLgiuPxHKrqrq8wpuBXcvRp7ZPgtsO8dAogub1c
         NL6GzHRsDXGvgxV5f+DQ9GRWuRnhIpei+ncsnF+aOrsmhiPOGYVoWfq2lcKUB65npchd
         SPpQ==
X-Gm-Message-State: AO0yUKXMTlqxySVa9BUSLK7f5/IrltwOkoJGhDT/8d2kJBmN5XCTSJi2
	BN2CCE1eUs9omewxuLC81Q/oEcrkxv8=
X-Google-Smtp-Source: AK7set/jxiX0/RMspJXiw4076M0WmHOd6d0ZKjT1DdekVv+ac1Vi6XYDk0LycmDjCT4i1LiL69iSVw==
X-Received: by 2002:a05:6a20:be24:b0:d4:5be:c578 with SMTP id ge36-20020a056a20be2400b000d405bec578mr9469759pzb.22.1678844011991;
        Tue, 14 Mar 2023 18:33:31 -0700 (PDT)
Received: from chiron.. ([2601:1c0:ca00:cea0:155f:ded0:e803:df3c])
        by smtp.gmail.com with ESMTPSA id t21-20020a62ea15000000b00571cdbd0771sm397745pfh.102.2023.03.14.18.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 18:33:31 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [mickledore][2.4][PATCH 0/2] update toaster fixtures
Date: Tue, 14 Mar 2023 18:33:04 -0700
Message-Id: <cover.1678843397.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 01:33:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14560

The toaster fixtures need to be updated for each stable release.

These should be applied during or shortly after the 2.4 bitbake branching
as part of the mickledore 4.2.0 release.

Drop langdale since support is expected to end in May 2023 (if not in April).

The following changes since commit b29f6e04091b6bfe697dc41c76880de466736fc3:

  wget.py: Combine urlopener exceptions (2023-03-11 20:49:19 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib timo/toaster-fixtures-mickledore
  http://cgit.openembedded.org/bitbake-contrib/log/?h=timo/toaster-fixtures-mickledore

Tim Orling (2):
  toaster: update gen_fixtures.py for mickledore
  toaster: update fixtures for mickledore

 lib/toaster/orm/fixtures/gen_fixtures.py |  7 ++++---
 lib/toaster/orm/fixtures/oe-core.xml     | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml        | 18 +++++++++---------
 3 files changed, 19 insertions(+), 18 deletions(-)

-- 
2.34.1


