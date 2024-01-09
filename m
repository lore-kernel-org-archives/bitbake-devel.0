Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6E8C46CD2
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 17:26:42 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.22994.1704821194536139201
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 09:26:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Utys+ZJa;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.172, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d4ab4e65aeso27340175ad.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 09:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1704821193; x=1705425993; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+6XBsTuiRUZ+aGhBA7LsqaOFAB9yjvwLpVQtgY0PXg=;
        b=Utys+ZJaN0XP/HDVW9kB2hINchyafMFb7DJleT6l7pQGCj/SbmKYkar194kStpPo6D
         7rCD5l8eSaoN4cyrJlej2Z5V1bl/42vSjSdzfAsRKbXWw/gY3e7fO+T30zsv0oiZ/A+U
         MNOxcIoCAOgxYfg455jlvJGMG2p+a2yGujBn/7umg4nnPq2D/hIuq1LAYFBkzpTmSe1K
         oc5TbfZmbS5g5BboGg14lHMDhGqRn2Q9BWaN9fs5HOS069qbEmS4lznlXLApNsbBAHDM
         I6X4xhxAO3GRVRvKDnq/9GhgQdbBmQnPoQ7Phk1rw+kVNIaeJ0eGPz/tTT2VtFhywEmx
         b1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704821193; x=1705425993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+6XBsTuiRUZ+aGhBA7LsqaOFAB9yjvwLpVQtgY0PXg=;
        b=ANx9pA4whcWzyQReBLWUR12T2rDke9DmSmISU4Wd9PBfiN/CP35ES8uPEVJYGpXzUa
         +1KAyZsvFvHehIyRiz74PyvvnWZk4N8yMGyVHBjryyoV6aySwx7aMFOL7sUdkMK8I2dg
         FLTmhNqFW7HoDiEPBylspFdztr7ZaFQ1AzifslmsikykZ/XgVXiT0wuyGXUO5Yp8mtEM
         S59jARSS0Uqu/iXpgBw8Z7I0RrvjAMiCEsewP4ddNJ7eqEzp0+kse6N7tgvuf4zHnkln
         zSZUXziypKr4ieHaxpelJWmxaSXoDBAjRg+d9zFF6KCQNl8sftVYT6Kpty5fzhcdTswW
         vmbA==
X-Gm-Message-State: AOJu0YzyDBYpnNGIK7cCPSf6U8XeoUw/JK0QBEiXEOEk4539ExqyW1hk
	+gH26fxqo4dGDjtw4ir/greF5aV+smwEev3dieNC1RUumy+UIA==
X-Google-Smtp-Source: AGHT+IFKaCL7mt1vlbWF0+vWI2lKvJf7gQv71ZXauRycme9HJdaPBbkN3/HnKaYOSPWkdr+mhXTA3Q==
X-Received: by 2002:a17:902:d352:b0:1d3:b609:eb0b with SMTP id l18-20020a170902d35200b001d3b609eb0bmr1191092plk.27.1704821193525;
        Tue, 09 Jan 2024 09:26:33 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id jk11-20020a170903330b00b001d4b1d190e3sm2048133plb.58.2024.01.09.09.26.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:26:33 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][nanbield][2.6][PATCH 0/1] Pull request (cover letter only)
Date: Tue,  9 Jan 2024 07:26:28 -1000
Message-Id: <cover.1704820993.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 17:26:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15772

See discussion at:

https://lists.openembedded.org/g/openembedded-core/message/191263

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6423

The following changes since commit 72bf75f0b2e7f36930185e18a1de8277ce7045d8:

  lib/bb: Add workaround for libgcc issues with python 3.8 and 3.9 (2024-01-02 13:59:37 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.6-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.6-next

Joshua Watt (1):
  asyncrpc: Add context manager API

 bin/bitbake-hashclient    | 36 +++++++++++++++++-------------------
 lib/bb/asyncrpc/client.py | 13 +++++++++++++
 lib/prserv/serv.py        |  6 +++---
 3 files changed, 33 insertions(+), 22 deletions(-)

-- 
2.34.1


