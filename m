Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC489C25B76
	for <webhook@archiver.kernel.org>; Tue, 11 Jun 2024 13:17:16 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.9321.1718111832503464988
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Jun 2024 06:17:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=2qPW390O;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.181, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6fd08e0f2so20118055ad.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Jun 2024 06:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1718111832; x=1718716632; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJFavkbXTlgaA/YfBmiA8NpPHmExO3lD6O5MBtF4WFQ=;
        b=2qPW390Oh77vnPqcgoGVhD2nh+SVbeuNw1NjTsj2FFCBVLbzVONzPH8z9Dqn6zf1gT
         sIvarQMVujdBgCW/QZAvP4UETjx87t8Ry6U3d3MimO9n8ixFO/4KWS/FBbCVHWRWq+44
         UcRejjEuIFW4MKvsEkMpEctsWZcUsaJ/rjZxcGtlUqJA7oTalJ4s+e3x/PrEpuNl2keP
         E9daCz36938ZxjQYgT5+qObatN3PVMlaTkPT7yMAkPDiKorX57mj/6zrbd75rF6wqIiO
         RrZYuwxYNDzn2Zu5qjxjL11DSq1i9Kkr6N7XwSUKg13RmOoxZgDZfYBeXrZBZ82E8VZQ
         0IiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718111832; x=1718716632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJFavkbXTlgaA/YfBmiA8NpPHmExO3lD6O5MBtF4WFQ=;
        b=VtEtN+otI6Lzfxr4QqrRpLpz/jdwyvk/DEJvQQcoTqCg2qtmb1e80/B/C4sim14Tag
         4hlQssOMz9fWGBwtAB2oX6qFdB6xAfLKTspZC+vIHndPyOagAKmHbPWtgfhJbHAGBhUX
         3W6f4fSCL1EMX5+CS9Iloi3NgrZdCS94Xrf4kA+UmN4Qe39Ako9LpCy45EBSSPShHsd+
         V9kq9tWcAgFJRNzv5aCfc7tGZ9wEzyx88aj7J6O7v514fA0P4yG3wp+I1zY3jxLBx8qu
         mRekdff6BhLtfAp8I8RW4emj7K2qYAc96ZBx4dQRumxBHWfZOe60YZ3yyU1aADEBjioF
         eeXg==
X-Gm-Message-State: AOJu0YyEGS91ohTxHRPafE1AyXNkRmPzA1+zWSWxU0BJdBwM+9vim6eR
	qjh6KRKJ+RClx1+JHr2RzPLZycFfZLnTRUBgsjv0ZnVPcqcyqfUMLLEgK90BHisuYczBQlZmy/V
	h
X-Google-Smtp-Source: AGHT+IE27fW5PqZFGUY80KzOEoD+QaaupF0COJBa4lEbkMwAcAGYcBMAyDA+q2D85Lb2JyOjqk4sdQ==
X-Received: by 2002:a17:903:228d:b0:1f7:20eb:9135 with SMTP id d9443c01a7336-1f720eb94a6mr40727235ad.55.1718111831689;
        Tue, 11 Jun 2024 06:17:11 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f72110e4b5sm25996905ad.125.2024.06.11.06.17.11
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 06:17:11 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Patch review
Date: Tue, 11 Jun 2024 06:17:04 -0700
Message-Id: <cover.1718111650.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Jun 2024 13:17:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16347

Please review this set of changes for 2.8/scarthgap and have comments back by
end of day Thursday, June 13.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/7024

The following changes since commit fdac31655fb5441139f70e50292dbb5774cfdafe:

  siggen: Enable batching of unihash queries (2024-06-05 16:52:59 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

Richard Purdie (1):
  tests/fetch: Tweak test to match upstream repo url change

 lib/bb/tests/fetch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


