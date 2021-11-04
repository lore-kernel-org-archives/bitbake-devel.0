Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64276C433EF
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 14:11:29 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web12.12201.1636035088434669426
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 07:11:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=ahXRilCt;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.174,
 mailfrom: steve@sakoman.com)
Received: by mail-pl1-f174.google.com with SMTP id s24so7486000plp.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8b4UXqX0OUuLSdzKAoPhd+nc1Bgpd/1bMex8mgsVrHw=;
        b=ahXRilCt+6yoTClWE+Qk6dWaRbzC+FFQDJB5RbREtU1b1tAVeeIxIiRdNI592UtUgf
         Hbc5F3eBOD2wzc7JxvovtuUM2SkJ+YD8s9i87Eilmott4k8NiDI9Lk8bCLoG2hhXZpAx
         wxdTO0keh1OnflIbmSmtHHDxXyJqYwHg0jDd4P9ClCLUMSCyIsMuXmFOUR6V4rovYxkx
         n00hm3kE7MDcxT9hDE1kPfQH92gvfRQ+ZmAcKipC4zkgHtU4YhXAB4aZHXTgF6mTZaRm
         Iqany8AOyWOUPOnRMBlIESUWXY0aOqSAQZT/JghbauDI4nq+FwX5G93oi4+UWzZLl6hJ
         RFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8b4UXqX0OUuLSdzKAoPhd+nc1Bgpd/1bMex8mgsVrHw=;
        b=MIn9HC6obKtHxn6vG1n+oQoCdQctCMdeVjOpKfB+mZw22S9+pV/zk7Br890jxwbQMk
         ztQE5Qruq9QaUDV9J5QAWQ/2ZCFb92bjIM5AK7gULfT9ai06Sns7OrJr/EdGHJ8J+o1O
         BFOkVQgpyI9cRsNu9ErtEMCuM7gds1VtB7nI7cxYhlgmeLzm7B2QJfZ7gHqX30KnQlgc
         t28bIXDBGeaAsjnsTUB+LRKu+ADs0SJgEbF/arRjoC8rOzpOpsyljEqVFzT6ySr/jrpW
         ajOmMs+HqyEoT/L7Ybja6Sh9ATExT8RRxACdjs8dtIwmaoKoF6oIe0KkBaEhQxzDmCd1
         NP2w==
X-Gm-Message-State: AOAM5324WyKRPScMpQ4Ps2rpf6r+v0/2MDn+k16SIN3kCXXrWkkpNZ2Z
	bNBLebW4Bi+99FMv/AedaD9RIWlobdJEWaFy27s=
X-Google-Smtp-Source: 
 ABdhPJxCnQuzMxOomZheXRufaMVCUKhnmTP07iykwyTJANYm8sYDZZpcRb5R58CVUPxBorxsrho+rA==
X-Received: by 2002:a17:90b:3a83:: with SMTP id
 om3mr22698969pjb.211.1636035087352;
        Thu, 04 Nov 2021 07:11:27 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 lx12sm1850546pjb.5.2021.11.04.07.11.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:11:26 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/2] Patch review
Date: Thu,  4 Nov 2021 04:11:12 -1000
Message-Id: <cover.1636034890.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Nov 2021 14:11:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12879

Please review this set of patches for 1.46/dunfell and have comments back by
end of day Monday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/2876

The following changes since commit c222eddcebe892ae209aea7776cfc1147ac1df6e:

  fetch/git: Handle github dropping git:// support (2021-11-03 11:30:57 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Richard Purdie (2):
  tests/fetch2: Fix quoting warning
  tests/fetch: Update github urls

 lib/bb/tests/fetch.py | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

-- 
2.25.1


