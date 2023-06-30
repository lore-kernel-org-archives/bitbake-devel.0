Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5CBEB64D7
	for <webhook@archiver.kernel.org>; Fri, 30 Jun 2023 17:27:59 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.19934.1688146074491641971
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 30 Jun 2023 10:27:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@sakoman-com.20221208.gappssmtp.com header.s=20221208 header.b=rNE2f56+;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.171, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1b852785a65so13871685ad.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20221208.gappssmtp.com; s=20221208; t=1688146073; x=1690738073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cMTPfOkhpKcz/oklvxGW2IkrUKW+/P+YsroxMDLjzzE=;
        b=rNE2f56+cMSRSnivA3hAPg8MCn5BXR69Htjf2KC515NlusinaewMExjXlzNP/FYsum
         Ml6rENBuMpkaSejkCXXyz2xCdRrFeAb+TTxEviB8POyVMksZrLPLBAr9zMQ+/eElWk93
         V9iAfAWQHRixlYgKo4JuLj5ZdDToZY0XH6uEFmkU9AOiMV7xJlJbqOPIYwRmT9J+C0JX
         tczm3cznZkBgN02BM31W3PwA1h+E2364n66uNlcVZ3bLCWDqlax3QKI3h9VaADgq9TyP
         JX3ygIiz13ahvr6NKVx5Gcvk2WabOaD9eq+U7SMr+Fqa8pa5E+EyjrywGRGLATcItuaF
         6x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688146073; x=1690738073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cMTPfOkhpKcz/oklvxGW2IkrUKW+/P+YsroxMDLjzzE=;
        b=TrzRDrrvb7vQDGxEgiVlgdfxr0cAwGymKFNCmMsijIjwsC7MaS+cIqLQBq+eug7twW
         CMGH9qIuqH0CLelH1AbM40jKwcOEiZvh04NtFJTcwQs9KYfh2392gMcFOus2IKmxnuZH
         Q7dbySQlZZ/RrFX1dZ3fDb6kg3wN+2b9GlWX/GLT/UAi4O7eTWb6gBXySmF4jRtrZQPJ
         P/VD0e+pDvBIdSD9oxWSfS1DITs3arEOsQL0p4ZXePxe9v59bcPPL5+KnDW1Je0K0+VK
         Kwdt+iKfrJOjtBq3n/hnOuJlw6gXmZqSNzQdBtAmO5IPQ3By+QiylOTOE/K58VpBebcY
         QR4w==
X-Gm-Message-State: AC+VfDwFIvW4WqbGqPxzIiXtOHNI363rQjQWBaPEAh6k6PnowwvH6BkY
	hPZQEioVTlsF570mzdLof2fuKQYuRUqRgdfQjmJpMA==
X-Google-Smtp-Source: ACHHUZ5AkeGV9FijumGgpLLUfn7tVscoCX/64e45PMJU7SDwOXdfRQsjftMKgyysti2+sgv5jvlb0w==
X-Received: by 2002:a17:903:44c:b0:1b6:eff5:c000 with SMTP id iw12-20020a170903044c00b001b6eff5c000mr9807703plb.17.1688146073491;
        Fri, 30 Jun 2023 10:27:53 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-234-106-30.hawaiiantel.net. [72.234.106.30])
        by smtp.gmail.com with ESMTPSA id bg6-20020a1709028e8600b001b3d0aff88fsm11007965plb.109.2023.06.30.10.27.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:27:53 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Pull request (cover letter only)
Date: Fri, 30 Jun 2023 07:27:45 -1000
Message-Id: <cover.1688145925.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 30 Jun 2023 17:27:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14873

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/5542

The following changes since commit e16a9ca7e9286790ac37a067fdc8fde3a35a1c44:

  tests/fetch.py: fix link to project documentation (2023-05-02 11:15:43 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/1.46-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-next

Richard Purdie (1):
  runqueue: Fix deferred task/multiconfig race issue

 lib/bb/runqueue.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.34.1


