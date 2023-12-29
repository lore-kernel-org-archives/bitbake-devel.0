Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FBFC47072
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 16:12:08 +0000 (UTC)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
 by mx.groups.io with SMTP id smtpd.web11.151691.1703866321647577938
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Dec 2023 08:12:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=EERMybgc;
 spf=softfail (domain: sakoman.com, ip: 209.85.166.182, mailfrom: steve@sakoman.com)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-35fd04ede25so31760525ab.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 08:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1703866320; x=1704471120; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLmV7HMKMHJVzdUgMc3LA3ev9x/nwAmXfsCaR7hcnoA=;
        b=EERMybgcPqu/X+nBdRyfv1lArV+LGJV8mboRk3lSf1fqZBib1JufODmtzVfIA0sh6j
         5zPvSBt0ZyxVRAtll/Yo6AcgOakGqtpMPmVrTL9SkJsB9YnBjEBz0ydlKKDKHRuyPGHU
         9wwYK8LFjkRNZXprY1wp8jyUr9EpE056kaTlzuku/EBX8lG6cDppCrpUzsKkPiDD5flO
         k3RBNx6NzI4geissbyH3xLJ49BlbtsCvuz7QR64we/yM+VmNgOn6pQZJssXcNd8RNF15
         mNYFL2gY6HWJM4cNZMMVFfqvCStp6qhNcq+Lw1XUvKnOi6+osVyyfZd8OJw6V8iZpmr3
         cVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703866320; x=1704471120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLmV7HMKMHJVzdUgMc3LA3ev9x/nwAmXfsCaR7hcnoA=;
        b=r0W5NERTIOs+3xdOxP5ZtrQh9FiZpOhbPdYn8jaGR44ESiyhTqMnSsjkMmiLgOIUU/
         ZPFr2nEfpkn1RyKvwM9Clr1iJeJiBo6eFsvK3de9HDbwmQVcYF0oK2aqXgnshY7grqsJ
         HMzi5iOQ/o5so//k++2PZTW0n5m3xlhrywWCG/TcH0fVxLpLzA5j2YZp/VYstFSWxZiu
         bHoWNMwbntUDP2ZiC24D1HVQSWeeKSN9NS8kpA0V59XK7dyNXUbKSpS5adNYx62LYD8m
         eoCGhnUe9NrJI1HY5+f62TLBAMgd3IgmEFXf97vvSgg8PTWor93DujgaCJJPawQiTVPx
         LOMA==
X-Gm-Message-State: AOJu0Yw5OoQEVH2bvDKc6tz2E42YwzyVwwbLSyZuL0B4dKLwwlv6HpYZ
	jhb7QwY7oOU2P/i3pLkDZbqVvGSdJjqsc/CU5uITjR3naGeCng==
X-Google-Smtp-Source: AGHT+IGyOInrF5iKxiKjR1mO5TPu8WXre5ToK4klSV+fK4w/CfYsZu7R0BnDuzAgEstxJZi8RG+Tnw==
X-Received: by 2002:a05:6e02:168b:b0:35f:eb19:dcd1 with SMTP id f11-20020a056e02168b00b0035feb19dcd1mr13596699ila.58.1703866320107;
        Fri, 29 Dec 2023 08:12:00 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id i24-20020a635418000000b005cdad153d84sm14692517pgb.90.2023.12.29.08.11.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 08:11:59 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH] Pull request (cover letter only)
Date: Fri, 29 Dec 2023 06:11:55 -1000
Message-Id: <cover.1703866191.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 16:12:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15724

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6385

The following changes since commit 48d1d18c23b3f514dc7a1ee12cc35cf5993af88d:

  toastergui: verify that an existing layer path is given (2023-12-21 12:31:27 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/1.46-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Insu Park (1):
  data: Add missing dependency handling of remove operator

 lib/bb/data.py             |  1 +
 lib/bb/tests/codeparser.py | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.34.1


