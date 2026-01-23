Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238CCD74ED4
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 13:38:39 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.67987.1769175509501369527
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jan 2026 05:38:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Xy0u77nb;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48049955f7fso16538635e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 05:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1769175508; x=1769780308; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ekfLVinpzXmgwEICDAtJ4EOK///xHDOol0ztEyzDrn0=;
        b=Xy0u77nbbSeId4fQaO66gREFA3f7t6PVMvq7VFGWorXOo41oKCsU5yd2Nfqz9ChVak
         dzJfIs/pPgWrZz19mi+gx5stiB/SYVXC3Ni5q7XpvZ6wmt2qEyeXoMBsNRwQJNe4ittU
         QJTNtGSK9gowyrhZR29/hjIgBSrUUB94+E8e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769175508; x=1769780308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekfLVinpzXmgwEICDAtJ4EOK///xHDOol0ztEyzDrn0=;
        b=bZ/r/khsdF9zYE4I2Anvna2nmmKq7BkdqoCjMRIpKAXzB+s3VeHgWKyf83GmwWuUuX
         est2KE/YDUO/vOTWnrtYpPaaL9OA0t4HWnEYuDseRwmTjZzaib6znsxC1RL7/JNwjHPr
         5Z9eYXG+0lZMohQJnvyKDLh7XiTUsfJzPsSWhy7XDdU6J9rY2oTm9WVtp26dB4nklWnN
         r74uicD2rzXRxjI3Sd5XKgEj7n8pxdFwdq+gvkfS8D2Y9oGY7iEkHRnIw8lLgxI7lugk
         sPlfUwNxLbAH3UeM899fTjz5GxvGJEksItGqC8q8HaojamqFacaVlSvnXo0NM32j5UoK
         FH2g==
X-Gm-Message-State: AOJu0YzDgEQ78PUixhqUSvURk417A9tWO8pkWOmZO10lorL3CqAu3tL1
	LVvp/kx3qPI9dukZKomN6d2tvy1zCr5qXjonPPVb94v2JYzGctfWNI1QXe+YqZweQsIZnhPho9c
	otzku/80=
X-Gm-Gg: AZuq6aILatEvtjUP82UsiZToMaCRVdLcH0MJp91Akb2RFCd0zt+pILRHVQNMbJMOvLg
	/z/V7Jyx8oIUBmLfINF8QzC5mx6nNOacI0+5DpDSVP2hV5QdPyC9a0EbojWSS+YTQEKH9FtkHHa
	x5CnxeA4PuRL6EHYZ/jYqK/ilIAUptPgDu7gmPImBN8dcT5RbmkpQck2m9/6Qx4fW6L3qlnEq+m
	YbEIDj6mC+vsKLCrCvAmoSzN0Hh38CkEG/OvNtxL5eRu3YGgvEsbF4XpofYxuusEFTnOB9obUWT
	M55w2eecPM9vzRsVCC2GQoLRHCf+jam7FC3IRlIehAJYGILbqwEhaY15VeHqnYjg7oNlI2XOiFy
	rZtHpII1CPRbpVweryeEkak+yglkzjrmUNqT7GY9rRMtNXb4SuP/c7TlyQDZRggRa3eyIXZ7MTo
	KlNc51+u2q9HLPBxCtlNXsi6ARyRqQJ2sW4OCwv5F46jbil61SD9UnKL5/BlTQjdsLlu7yLNOZW
	vDAODUr+rA5QTk=
X-Received: by 2002:a05:600c:4751:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-480511e4ecbmr21023155e9.8.1769175507585;
        Fri, 23 Jan 2026 05:38:27 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804703b59esm145546055e9.4.2026.01.23.05.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 05:38:27 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <paul@pbarker.dev>
Subject: [bitbake][whinlatter][2.16][PATCH 0/1] Pull request (cover letter only)
Date: Fri, 23 Jan 2026 14:38:24 +0100
Message-ID: <cover.1769175148.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 13:38:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18862

This is the patch from the last patch review:
https://lore.kernel.org/bitbake-devel/cover.1768909613.git.yoann.congal@smile.fr/T/

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/3112
The "Send QA Email" step failed, that is a known AB-INT bug:
#15696 – AB_INT: resulttool: File exists
https://bugzilla.yoctoproject.org/show_bug.cgi?id=15696

The following changes since commit 663021740bc086bd959a8457ad9ddb6da52a8278:

  bin: Hide os.fork() deprecation warning in all bitbake scripts (2026-01-12 09:17:16 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.16-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.16-next

for you to fetch changes up to 74f8a927ca6a20342072e5579182aea917b6dc30:

  bitbake-setup: ensure paths with timestamps in them are unique (2026-01-17 23:15:33 +0100)

----------------------------------------------------------------

Alexander Kanavin (1):
  bitbake-setup: ensure paths with timestamps in them are unique

 bin/bitbake-setup | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)


