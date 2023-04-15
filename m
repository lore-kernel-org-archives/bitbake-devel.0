Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21182C77B70
	for <webhook@archiver.kernel.org>; Sat, 15 Apr 2023 15:29:58 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.10450.1681572596544314150
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 15 Apr 2023 08:29:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20221208.gappssmtp.com header.s=20221208 header.b=nJjt/Ljl;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.48, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f48.google.com with SMTP id v9so26594308pjk.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 15 Apr 2023 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20221208.gappssmtp.com; s=20221208; t=1681572596; x=1684164596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/5tOEY19UF2JLriJWoGMS2xMArieWUqp8f/C97nGkM=;
        b=nJjt/LjlqNc1ex785aDhh/B8fyxrjl1dFSr0ecm0vChjrfJq6IcsXjJzN+NKGa06fN
         Z5aVwMthSEDvZdOskFUuRfldHBvbm5BqOv/xrsYzq8ijt3b6BBE8CD5RWYQNXQ/6mNHv
         rMAOsqS4svigbIc3CsF6suQclgG4WH+/UFm01U9n6r/pc5Bhs85UNWM2Cjzcsq13ePNe
         U+br5nVrHcHQyQI8K9ntq+wXYE7ps/XwG/FdLCTRPbQ2/ScYCYkhPV+g/CRIs1gVRjdA
         3JVW6CHMoX+w0jt3w+xGsv7u6dxfO4XM84RIozVSQqx+h96ucRiPadcyyKOLFS6bvAgU
         JrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681572596; x=1684164596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/5tOEY19UF2JLriJWoGMS2xMArieWUqp8f/C97nGkM=;
        b=MqmvjGL918Rj6+iueAqviaHxUSXD64mDwjr06rC9x4+YDrFCRI7tZ10luR+rOZpZPB
         xLPcVohYYEFaOCS7l5oqdn9DAB0auTy9VoyDaJX7JlL9IyJUoG4eVmllSEVNAsLzB5kn
         /J7FHLiIxh5v1u6EbhmZQqKnzI2iEgrFPKIX1AuXb/y09srPENBR83R/z56D4ZZusyPE
         MnWuhgfVA4f3gLjNFgZTJYSKL91UFFBFuAOgItVFKfg8PgcOEvJvVtCU5t8VWM+35WNs
         /g4KRHp48MAPEhLm6GYmtqaZ65wXR0BO1SyMKQdg8uv60TYUK07tfceVtHN5F2bJOy/Y
         +wIQ==
X-Gm-Message-State: AAQBX9dBdLc5E8zot3MEjtLvdN5ZwVQzz+OrkXCrjkaPYUL9KYOZAf1w
	rim5XYVdbBeQxFRzC+Fpl8mbSv6CuO752X8Vwxg=
X-Google-Smtp-Source: AKy350bHpS0X5YnAL8jhre94+sBqyvL82eH94zLjd9iiK/NTjx1lMW/FFddPVf+qHnqpVK3qcIpayQ==
X-Received: by 2002:a17:902:da8d:b0:1a5:150f:8553 with SMTP id j13-20020a170902da8d00b001a5150f8553mr7993454plx.0.1681572595620;
        Sat, 15 Apr 2023 08:29:55 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902be0a00b001a5240aa535sm4794819pls.37.2023.04.15.08.29.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 08:29:55 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Patch review
Date: Sat, 15 Apr 2023 05:29:48 -1000
Message-Id: <cover.1681572491.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 15 Apr 2023 15:29:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14702

Please review this set of patches for kirkstone/2.0 and have comments back by
end of day Tuesday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/5185

The following changes since commit 2802adb572eb73a3eb2725a74a9bbdaafc543fa7:

  fetch/git: Fix local clone url to make it work with repo (2023-03-31 04:28:22 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Frank de Brabander (1):
  bin/utils: Ensure locale en_US.UTF-8 is available on the system

 bin/bitbake        |  3 +--
 bin/bitbake-server |  5 +++--
 bin/bitbake-worker |  3 +--
 lib/bb/utils.py    | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.34.1


