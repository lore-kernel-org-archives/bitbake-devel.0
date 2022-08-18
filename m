Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83BFC00140
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 17:09:12 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.44681.1660842544190380006
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Aug 2022 10:09:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=m+8/UF6H;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.180,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f180.google.com with SMTP id 130so2107086pfy.6
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Aug 2022 10:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=gWa2dpyiGhaiotXIhc0N8IkeGa/CKtP5MFLyuuhdKps=;
        b=m+8/UF6HDruyFKBJEaRkUTD7aESzhMmlAIzzfhg23c/TT91rAYoJNGDQU69b6t3Z91
         DNJb2UNWAHuqrA7T9NPyDoYciR9c54WDvPlLO4fJ8N5fSs/Cm1ehZ7ZqLV1ZW6hFQeP1
         wzpG1dMhVUKAMGXxArjTmMBvGtE+SMEMlaB+FGNAw9ilUjLMBuL8WFqk0+LGeVurpwrP
         e/iieK56VVAtV/TPKCE0iVS9zuYssvluqzW82UIpzhn2C/VHxKkMpZl3wl3ysP44LH8z
         ULHpiqyvTNuiWl1SIKRhP2jhSyU2tvI8y96mDsV6vlV1LJdVG45L2ESyaivMlWAAAhAG
         saLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=gWa2dpyiGhaiotXIhc0N8IkeGa/CKtP5MFLyuuhdKps=;
        b=w59SNCQgeVPU/QpHPuMf565Pb1FA5iVCIvemAq4MbLaZT3hOWovqJIJ21brJokXdBb
         LUPGWwbc3KtcR7zoWmPOe29oOiih7Sc/s/dNcOTfzb+4JPADAv5WrJMlQNu/BYIV0QwX
         H+feZEL1eMCBrVLO+iVRQ0mVqjEPmhWQG60aN+HXHWKeYgrWMc3gjQHA5PM3tnHLzy5/
         iDkVaNfBXaIY2sRsAsZ+zNjhw8TZJn8kcQAby8Y1GhnPsfxmUb36sVU47N02UQkL1KG+
         89fSvifpAZwW2dKf8HGyA7WLvDjXz+BKw86PpnxerOBhIetykQsobvJda+hkbS3psy4K
         q0tA==
X-Gm-Message-State: ACgBeo19u6J69oz8krl86NXX2Y8zlSvvl6uhhqr7n+DWZS3CqBIwnWDL
	42BYCXl/CGARhO3xtD7RNkZVWkoHQNzzm2Cm
X-Google-Smtp-Source: 
 AA6agR4IZRosavvHZKLwDf16Gk4Z+5eUQZGVjso609oSKrBx/Pao5NHw/xoG8Ddxh/1U5XHGa0yXEg==
X-Received: by 2002:a05:6a00:8cf:b0:522:93a6:46e9 with SMTP id
 s15-20020a056a0008cf00b0052293a646e9mr3928082pfu.62.1660842543022;
        Thu, 18 Aug 2022 10:09:03 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 b1-20020a170903228100b0016d1d1c376fsm1644339plh.287.2022.08.18.10.09.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 10:09:02 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Patch review
Date: Thu, 18 Aug 2022 07:08:51 -1000
Message-Id: <cover.1660842419.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Aug 2022 17:09:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13901

Please review this patch for the upcoming dunfell 3.1.19 release.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4098

The following changes since commit 7fc4cffebf5dcc1d050416c0b7f7d58c765c1d69:

  fetch/wget: Move files into place atomically (2022-07-08 06:48:38 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Christophe Priouzeau (1):
  fetch2/wget: Update user-agent

 lib/bb/fetch2/wget.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.25.1


