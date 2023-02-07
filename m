Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F58C636CD
	for <webhook@archiver.kernel.org>; Tue,  7 Feb 2023 15:10:12 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.85628.1675782602934709654
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Feb 2023 07:10:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=tOsosd28;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.172, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f172.google.com with SMTP id 5so6692385pgd.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 07:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8iQg+AFHyM1xRtfnsB2JcAqRC8TaRiAttciTy5gEAgo=;
        b=tOsosd28aSwub9tJD3zsr3fI5HdJ/sfC/p3fXHgxEZrJmZcRfUvd9WdLSxnW0eTgC4
         dugTM6A2lFQAnQsyoGUeimn6NaeGCvbF+5B2M5/xu3RuTglYnkG9m26GuCTFArQJQMqv
         ig9U3itW09iOKCiHPWy8Q0+Af1ASg9jKgwHJX/yfyD95guRGUKQpUlNx+yObmBenXzOF
         k+en4X0fCIxSWzHjj7f+/lVseTq4P6r5KZ12Klx5WjNlfaWtoJtCHQaQOXITIfJJP3Gv
         HuDdZw8HMLPw38+K+aUDiEViJ/FKFHB6mJxuGdM9qPyYy2ucjeewzFpJdGbZmK4hj+QC
         xbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iQg+AFHyM1xRtfnsB2JcAqRC8TaRiAttciTy5gEAgo=;
        b=EFh0lGRm28BSsegfr1hL5RSB1o7y7hVzxwRuT9+x8E1gR691biuRtkkLZFxmjQ/4mX
         gbg6xR4ZxyRRlbVzo//6GwpdtO+QGPTrgTYiO6sxasNPF3WGjGFuwXb3FOIJi7fkpg5V
         C1CDbstlgoQoKLcgSqsGBSW3hOwxj745vNOQGYhzJRY3Q7tQLAEbWAE2Z/mLZp70RAH/
         JGMDr502BpPV9xTw78FUewTgH+f5HWVW/f4u65cidMAVpAXX/kS6Mw5mowYy1agGHQpJ
         8zIHcg0MN792dVl4AZ6ceJySXVS12hsT2k8+bxyfpEDp/7Rn5Dl5c1CkfaNxPHfKLtB3
         2oZA==
X-Gm-Message-State: AO0yUKVvWSdXzuOYMmHnxsN6wtETfLkvc86tRo/Cbo1zwCdATD/LZeaZ
	qDpgo8/l3yBxW9i1ZvCc21C3TLJbApyMBhBvFek=
X-Google-Smtp-Source: AK7set9qV0y5JSk/UcjKEb+V73ksZvzmlyyQWCXbz7aZSisQX3sTzoOkLudUXit6pMONPimtyxLoUQ==
X-Received: by 2002:a62:4e4b:0:b0:598:b98c:7ec9 with SMTP id c72-20020a624e4b000000b00598b98c7ec9mr3851454pfb.3.1675782601705;
        Tue, 07 Feb 2023 07:10:01 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id g28-20020aa796bc000000b005895f9657ebsm9243444pfk.70.2023.02.07.07.10.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 07:10:01 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/3] Patch review
Date: Tue,  7 Feb 2023 05:09:52 -1000
Message-Id: <cover.1675782497.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Feb 2023 15:10:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14380

Please review this set of patches for dunfell/1.46 and have comments back by
end of day Thursday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4893

The following changes since commit c16d364dbf68d2a500fecaf8d6e6d62b11475d9f:

  bb/utils: include SSL certificate paths in export_proxies (2023-02-06 23:42:50 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Charlie Davies (1):
  bitbake: fetch/git: use shlex.quote() to support spaces in SRC_URI url

Marek Vasut (2):
  fetch2/git: Prevent git fetcher from fetching gitlab repository
    metadata
  fetch2/git: Clarify the meaning of namespace

 .../bitbake-user-manual-fetching.rst          |  4 ++--
 lib/bb/fetch2/git.py                          | 20 ++++++++++++-------
 2 files changed, 15 insertions(+), 9 deletions(-)

-- 
2.25.1


