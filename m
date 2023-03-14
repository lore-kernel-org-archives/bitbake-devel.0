Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D1C7618D
	for <webhook@archiver.kernel.org>; Tue, 14 Mar 2023 20:31:47 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web11.6295.1678825902890443507
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Mar 2023 13:31:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YOMZjXIc;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: ticotimo@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so6850566pjz.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678825902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FpubYZ/MFZoE9hpay4W2wBnp8OHMoN03DmgLMx2BCIo=;
        b=YOMZjXIccqA0S+RtUlx7ZK4crw9iK3WhTYy/R0z9/dZ5xXIA3/OVVTgUN9xKDpN/K0
         zjeg7fhEj7RK+vw+NBsYE+KuersvacXhjAgrpzOJ7nYcrXUkAEG5bsT1fuyxFph2rvIb
         bVx/HWlcHQFSxlIpy76vCeweWumwAErF41fenycyAU3HhJtVbG4Jyypb09kMhHcQx4ey
         zOd9kAxxMRRgRb5A9BSJ12Zu1nxd7HhcEEFNUE3K+N8S21nG5DPsle/E+ndv705Z8PLi
         Y8T/S4KZwIgsCQ9ZYwKFpVPYx0YLqsGPvYbE+vhFRhUB2JX4y59kIznz1NlbvQlQaVPm
         u2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678825902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpubYZ/MFZoE9hpay4W2wBnp8OHMoN03DmgLMx2BCIo=;
        b=pAnL0QzhlAyi8z+2ihmhK2SVjNbRpjPtfyVjUUXyT0HzehTEvXUFqeKSFalRvtjBAL
         pmdkek0uqnucuH0t4t4uZYkCrwrw5CcncnxkJYcuNzQTPLMjjYefWGcPncncUuZUqlie
         b8udqhtpvfdplqFdyInmdiKggejUUFM4wTwHjpJ70BX6Kokls/FxZ8c/mPXqIuflb7wp
         OzC+BDUN5BuCSfieSLtgUB7n+MWTL2GErIjX1L6z7wlPADL+6OZJOczv9qT/Hr0lEPea
         xbKLuA8ysDFf9LGSN976btaPQD980vWM27mO1l06YmfjOSvI6ur8ccO1IR4AudW4Sj2x
         a57g==
X-Gm-Message-State: AO0yUKVvCno8ZZN+vSp0ai8ZSvUDD+IC7d6+iBhd170dmxiy8M2HxS30
	KxUCVuqcfLp2ADIXMLF2CpyCQSGN2TA=
X-Google-Smtp-Source: AK7set/VzE7vcBXIT1ITZCsxHvwyrXCuLQDMSlYyPP4eT1cgshZfltOqCc3Gm/ER39a7fhoFjs2Aug==
X-Received: by 2002:a17:902:ce81:b0:196:3088:5dd6 with SMTP id f1-20020a170902ce8100b0019630885dd6mr421113plg.13.1678825901694;
        Tue, 14 Mar 2023 13:31:41 -0700 (PDT)
Received: from chiron.. ([2601:1c0:ca00:cea0:155f:ded0:e803:df3c])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902ac8f00b001a076568da9sm215464plr.216.2023.03.14.13.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:31:41 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Cc: steve@sakoman.com
Subject: [langdale][2.2][PATCH 0/3] toaster: update fixtures
Date: Tue, 14 Mar 2023 13:31:27 -0700
Message-Id: <cover.1678825322.git.tim.orling@konsulko.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Mar 2023 20:31:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14556

The toaster fixtures need to be updated for each stable release.
A similar series was already applied to master, but also needs to
be applied to langdale or else toaster is not able to target langdale.

Discovered through crops/toaster-container testing:
https://github.com/crops/toaster-container/actions/runs/4356771460/jobs/7615227153#step:7:322

* Patches 1 and 3 are identical to the same in master
* Patch 2 is slightly different with newer dot releases of stable branches
* Update to latest langdale 4.1.3 and kirkstone 4.0.8
* Re-instate dunfell and update to 3.1.23
  - drop comments about bitbake crash

The following changes since (stable/2.2-nut) commit ca911d5be42f8d4d928d0fb911089f1b126e06a0:

  cookerdata: Drop dubious exception handling code (2023-03-11 06:09:24 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib timo/toaster-fixtures-langdale
  http://cgit.openembedded.org/bitbake-contrib/log/?h=timo/toaster-fixtures-langdale

Tim Orling (3):
  toaster: fixtures/README: django 1.8 -> 3.2
  toaster: fixtures/gen_fixtures.py: update branches
  toaster: Add refreshed oe-core and poky fixtures

 lib/toaster/orm/fixtures/README          |  2 +-
 lib/toaster/orm/fixtures/gen_fixtures.py | 11 ++++----
 lib/toaster/orm/fixtures/oe-core.xml     | 26 ++++++++---------
 lib/toaster/orm/fixtures/poky.xml        | 36 ++++++++++++------------
 4 files changed, 38 insertions(+), 37 deletions(-)

-- 
2.34.1


