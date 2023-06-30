Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E433EB64D7
	for <webhook@archiver.kernel.org>; Fri, 30 Jun 2023 18:20:20 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web10.21280.1688149209180338415
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jun 2023 11:20:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@sakoman-com.20221208.gappssmtp.com header.s=20221208 header.b=YvUpN3Ni;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.179, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso1212541a12.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20221208.gappssmtp.com; s=20221208; t=1688149208; x=1690741208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UY+q8gts1IpuiMAt81pDFdMKBB/Qz89QXtpclEjZdDU=;
        b=YvUpN3NiBL7b3Ze5SoI+k1yE6C7IpsGUvxS6BsBPwCkwJkamPhcLTsg/51N+Qi/u1B
         SiZSWcid7HSPjzaDXVV0i/2fqPGtPZY9vEP30ZS8oq/9E0EJvDDDGx91lkfxpAJ4Ffm2
         R/wHtC9fMy7QFigLMLOVREN4GoCB1lD7fDjWV2R6tVQ0Jfxb6cU4CHYszXqOOwVWNfMy
         tE+85b4e1v2W4xGBwOedd6ja3rohxrKYZYsj5iFurR3EAhMnSSI9cDRYLiW9F8Fr4/+H
         fawJAISCssyv18LPnSgXPSsD72sjy2HmQT21Kb7UlNsxgCWZErsZS78738OY9e1K1bZt
         n/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688149208; x=1690741208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UY+q8gts1IpuiMAt81pDFdMKBB/Qz89QXtpclEjZdDU=;
        b=c4XZV+Z2s8HDXeX6ZMn4T2zs8DY85/LFTtGKs6iZG6vJaNcVV3+yJg3XXfg1vta6CM
         afRN8VB5CaE0bMkO7HsbFcsKCww8qRNndwC9AmZCLuCqlRD0lpPeAt1Aaq7yYCkHXNlD
         KEjpayuDXLAxATn4XWfDfQIUnghTbB2OYtlEpTIEvyE3w2bTizLEaEoRA5B3R+hLkKxR
         cZfpjslVgwT/XPafKTlIgvYo80wwXHJFCEtzya1pQVhdNi+CxQ+N7bXLrSCFYXrYRblg
         tQtfJcTZ7iI0vhzzT8LIfvnLN7swn/TXj8L8usJc/30qhBRW6nd/6NWCxzLmY0XVnl/W
         NIwg==
X-Gm-Message-State: ABy/qLbz2OeNnUmLz/1cxdLtHzjU5+mYwu7B+Hg+lF8Fk7gYx8YULUbd
	aFeD7G2zcV4TwCOCp4PhyLsB0z67agmdRF0m42mMPg==
X-Google-Smtp-Source: APBJJlFs7bt1R5EHQNXlm4P5MATtN4gyK6lyIqiSd1+rg9KZsnnN3+02MoA1n8cbCUW6nNbJ4eZH0g==
X-Received: by 2002:a17:90a:19c8:b0:262:e58e:a40 with SMTP id 8-20020a17090a19c800b00262e58e0a40mr2594677pjj.43.1688149207093;
        Fri, 30 Jun 2023 11:20:07 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-234-106-30.hawaiiantel.net. [72.234.106.30])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090a1f8d00b0025bf9e02e1bsm11890393pja.51.2023.06.30.11.20.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:20:06 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Fri, 30 Jun 2023 08:20:02 -1000
Message-Id: <cover.1688149101.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 18:20:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14874

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/5551

The following changes since commit 0c6f86b60cfba67c20733516957c0a654eb2b44c:

  bin/utils: Ensure locale en_US.UTF-8 is available on the system (2023-04-13 08:17:57 -1000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Richard Purdie (1):
  runqueue: Fix deferred task/multiconfig race issue

 lib/bb/runqueue.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.34.1


