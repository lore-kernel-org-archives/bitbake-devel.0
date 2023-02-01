Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DD2C05027
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 22:20:21 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.218.1675290012142109154
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Feb 2023 14:20:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=f1Mwj73T;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.172, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f172.google.com with SMTP id 5so19951918plo.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 14:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvFG6LtLEZv95qF+OQBAp3tKDrgWST/GUFGvOMbwnIQ=;
        b=f1Mwj73TIw4TsXly+49NyfLc7XEt7ETb389jq29Hldyzs8hJwGU4AF2EV8tNoB++72
         tQWYfrm9Quue0OP3QkZRc5aXz7kIp7e5TFR8rpwZOjZ3Vto5dnSeEO6BB6RVIWLWfrHd
         3sWT4lyFbAX5h1NNepU6hd/IMNsIlZ7a3uN1snAKkDNun6n3JAs+CVfxtOOklcCjC99Y
         ikXKPFj48SL3ajUkCrWpjf6DnUxwTCSXRb3WulM+BTq5b9SNjcnX+yiOTrLP+2+2IeB0
         bDzPbesTaTIgIahCkKDTz/EFnjxF86b4VAUcRBqWCQ9rgH65q7LemrzB1nhpm1GdcCX4
         U46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvFG6LtLEZv95qF+OQBAp3tKDrgWST/GUFGvOMbwnIQ=;
        b=r3cRXoO8d8818i1levwcQpe+x7sUdESfc7acnAcMul874k3WXugjfd6obpwbeAjb28
         nsMRNSCKcAVQCtF8J3pHe9sb2ug41j+j10qII0kJmMzwFwdTcpg1DW2Je4cgNCHv4BAQ
         jC3YHNuuT8ZeXIhEICjPLykQtuXn0pCt8syobmxVc5m3vyW43SbxuAuto6QI7VKrALv4
         sVbazt4eAYMIgRQEZSuMLihQOqo2yAg6Y9vEDl6It9FgWtkZQ0ybh8zVsUxc7yY8DeUG
         SUTpSAMCW6mIdBmqKi3z3Tc5P5dQl63eejsuiQ4UyA7+QrNWHb3zLKAwRbKkr5itFj2a
         Zu9w==
X-Gm-Message-State: AO0yUKUkBEcRVH65r9hRNvx6CSynp2yBRB9aEloz7QJQD8ehQvbkRwk5
	f6kpS3/NQbHUbk0CQgS/9e62c70Tq6speT4Ywag=
X-Google-Smtp-Source: AK7set9wB9pRA2lovI2MDfSRG0crJ5sNEhr0ORjfeb+B6PzRa7jjWKfDlhJdcFIzaLTqkdXDOI9NzA==
X-Received: by 2002:a17:902:e84c:b0:193:39bd:df97 with SMTP id t12-20020a170902e84c00b0019339bddf97mr5921158plg.14.1675290011219;
        Wed, 01 Feb 2023 14:20:11 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id iw12-20020a170903044c00b00186acb14c4asm12294049plb.67.2023.02.01.14.20.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 14:20:10 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/2] Patch review
Date: Wed,  1 Feb 2023 12:19:49 -1000
Message-Id: <cover.1675289845.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Feb 2023 22:20:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14369

Please review this set of patches for 2.0/kirkstone and have comments back by
end of day Friday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/4872

The following changes since commit ed0dcc40f80c48839bac20298013d70043858a4e:

  bb/utils: include SSL certificate paths in export_proxies (2023-01-30 08:37:10 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-nut

Marek Vasut (2):
  fetch2/git: Prevent git fetcher from fetching gitlab repository
    metadata
  fetch2/git: Clarify the meaning of namespace

 doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
 lib/bb/fetch2/git.py                                     | 9 +++++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.25.1


