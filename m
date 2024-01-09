Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15551C4707B
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 17:31:52 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.23078.1704821511369228638
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 09:31:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=ks8OiaEo;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.171, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5cdbc7bebecso1172350a12.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 09:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1704821510; x=1705426310; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jpBIeSie7R9jRSolgzm6+Ssq1P8DPrh2znXHnS64vI=;
        b=ks8OiaEorJ3RuyoFu6i6NLYcQRvadyAmSZSEfVYPA7NdFp71jMPh3XOV3ZTAKlfRDB
         5ZR33IxXbrUd1qd89kO3I/PsMTqpOJhyugoRqn/2q1zX55tbxmlLYHWmlvQLMvjHa9nr
         Pm1Sd/nGOA7d+EL7Jm1nxRhqGysyzZgNVgT3M171RRgvSNHXVxljeK18Y+2bGeqwL5gW
         LF0SdWMWULRx72sb/WIAQ4CthtGYzO6LZ0GSh/qEmGKdiImfVXE7rEXq5sKWFTjXaYQw
         NWjAQS2SEm1bANJ/rjAb35bqzeOhnZ9s+ruJGa7DUAxZl4jSIEXikWV5NTYhhKzKKDbn
         GK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704821510; x=1705426310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jpBIeSie7R9jRSolgzm6+Ssq1P8DPrh2znXHnS64vI=;
        b=DRu0NwZFxwFE6X3QwlP4g4SaLh8C1y2OMoM367gJACaEiDmSVbhftnpT8//YAn3CR0
         jMyBc3/7n5W4zhYPKZ4Fp0oW9NMaG0WBxfU8q82dolMFdiykylTaxH1tBUidXhci6b00
         6bGWdwc5Txb0E2lUeJvWjAQfYnzQXPlZ7na2npCSGtfulpwl3rwd3qAKKJRfUJzl1lsJ
         ewLNjLamo8+KhrzVa+wPu5jBuLfkdfpPKjmikj/6YXdAiCmCaZ8BccuaBf6y1WqqPMMh
         jFVn/VxD8EgOieOPQp6RCgQrAC1ylneNqNet8Rz58W2bsYbT9c4w3LM/XRxeVxP3SRWP
         B+9g==
X-Gm-Message-State: AOJu0YzXlPZ4wg2g6i3kQEFlFu+cB7p25yPu12LPzC3qH40kX1nbFXm5
	6CNBMVwqYwgl/L1BKGsuxbrmvsk5Y4UmL5Y43JVwy3MXnY0qfA==
X-Google-Smtp-Source: AGHT+IEhVCLQ9aOGw81bOtafEbJgiyfSNeml60eNYzeTB+szgtzNfgGz/rLrjQmqjtIRmJ5ET5PLuw==
X-Received: by 2002:a17:90b:2ccd:b0:28d:a222:7db7 with SMTP id sx13-20020a17090b2ccd00b0028da2227db7mr657075pjb.65.1704821509954;
        Tue, 09 Jan 2024 09:31:49 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090a2e8100b0028d063e2906sm2240597pjd.1.2024.01.09.09.31.49
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 09:31:49 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Tue,  9 Jan 2024 07:31:44 -1000
Message-Id: <cover.1704821314.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 17:31:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15773

See discussion at:

https://lists.openembedded.org/g/openembedded-core/message/191263

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6425

The following changes since commit 2c6183594279e2e9d03f11155ad969448869c863:

  lib/bb: Add workaround for libgcc issues with python 3.8 and 3.9 (2023-12-30 11:04:40 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Joshua Watt (1):
  asyncrpc: Add context manager API

 bin/bitbake-hashclient    | 36 +++++++++++++++++-------------------
 lib/bb/asyncrpc/client.py | 13 +++++++++++++
 lib/prserv/serv.py        |  6 +++---
 3 files changed, 33 insertions(+), 22 deletions(-)

-- 
2.34.1


