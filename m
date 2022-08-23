Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C4DC32772
	for <webhook@archiver.kernel.org>; Tue, 23 Aug 2022 14:17:21 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web10.32621.1661264234759933664
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Aug 2022 07:17:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=gIEWyIqK;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.177,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f177.google.com with SMTP id x15so12711900pfp.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Aug 2022 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc;
        bh=2iHSGhMYKduAa9QRlKG3hjf8NKs0nQoqoYBzdmiRUHU=;
        b=gIEWyIqK8bhGJpZUSreC0aXAGT8qE0kY5ayg9m0CpqfIz2P45HsAK+Je0I/C00au9n
         zoweJjNO8IUDaAlMaV1X4/2xzY6W06dQal/qBVNtD2rZ+e1XgUFYJaTgwxuT7TMl9pCc
         QKzlwmL0W9LatOMURLAs84cfY/B/AOxQsTQTPT4GkdM094/+1q5YzJTPM/Xn74cBPnol
         v1GGzXsRxCbmFubB7TFAcZoBpdoQ5NZwYnbhvb8/j5KZbf4vOH7PICO5mnkeyj7b2ThZ
         hgwhHLXG1RzBBUviJ29Tvz3WtzU+ajtSsEI2WI3RdvA1LpFMDBcr5vDZOTf/XcYyqC8e
         CbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc;
        bh=2iHSGhMYKduAa9QRlKG3hjf8NKs0nQoqoYBzdmiRUHU=;
        b=k+CDt/n/y7QKinRNwGZWfhiUa7LSoMa3VCl8tBXJ/vZzou5a/Z7RWxChZLBCv0BRoh
         3RD6aq1Ul6Wgk3B8J4sUT8jW9ZBqirxDR7I4I1YjnG9ibrDpZ+GBkWptQNDr+E1Itk/C
         cCAMkOJ1sRuINERroroLmRkMvkao4e1RNx4aX567gjg3aOX6dvXs8s2BgCiLwtWWBbY/
         4Gtfz1xZHMqk4h9nSYWEpGZd6HXXtlbf8OOvRmJzEio4xNnEoPjM9vE3IDYMtiM56MPQ
         jxzARsJ83yfjM2zsQK1v22Nh6f8qF/z8KiV5kDggJe/T4ydBMJUzCF7DFwTytwMWaFDB
         DtqA==
X-Gm-Message-State: ACgBeo0wImQAc/LAMXw3aytaDwD3FIfUgbG6f1bcBga6a9zEMNvxYz5C
	7J5+lz1yym1NJDF4/n7aCvYXObO7R3pZbK2O
X-Google-Smtp-Source: 
 AA6agR44Vh8xYKoOaNpgqonmNk1ayhRT9rxqAaEomghb0zKyiu7zTg+OZjvxbFN8KdWOD4XWHpCQcQ==
X-Received: by 2002:a63:1e5c:0:b0:41d:b225:9ee1 with SMTP id
 p28-20020a631e5c000000b0041db2259ee1mr20280182pgm.245.1661264233647;
        Tue, 23 Aug 2022 07:17:13 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 y15-20020a17090264cf00b00172a8e628e7sm10557649pli.190.2022.08.23.07.17.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:17:13 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/2] Pull request (cover letter only)
Date: Tue, 23 Aug 2022 04:17:01 -1000
Message-Id: <cover.1661264139.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Aug 2022 14:17:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13930

The following changes since commit b8fd6f5d9959d27176ea016c249cf6d35ac8ba03:

  server/process: Fix logging issues where only the first message was displayed (2022-06-26 22:55:33 +0100)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Aryaman Gupta (2):
  bitbake: runqueue: add cpu/io pressure regulation
  bitbake: runqueue: add memory pressure regulation

 lib/bb/runqueue.py | 82 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

-- 
2.25.1


