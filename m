Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505E0C433EF
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 22:09:11 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.814.1657231746345276357
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Jul 2022 15:09:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=owDY+8h8;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id w24so16501238pjg.5
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Jul 2022 15:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODyrZ38Wr7wbtXD5FushJnVJd0jTHm0B5hHFM2o2rfI=;
        b=owDY+8h8EL9cTc1SjoCyFiAXHpc4SxHZEX3ffHJ642JJWY8k+Oo8SHjuvhmuSWM7zp
         Dkg+7YK22qIVoSrFk20rgmdTsjr5NvQzSknjLqKKI6nkWz4NVWyNhQLtldW7qLTZ2EQT
         LEglUsegtyc5efnSfoVLCN+TSSODoQIbQCGunzbYwh3FhacUDP49ezk4QbwmKQIEpe/K
         UQFeTtv7mz/5kM2rrexPx1gRsvvt8L0fbEe/MgIrVCRhrisEz7M0rRcW5Sh4QX7q8Fta
         WMzVOXi+WdkszU+p6Zk0TapOqZy5O4xm1Fr/44mzQzcGKET3XqIxv14sxnqJWFeZ1D90
         dLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODyrZ38Wr7wbtXD5FushJnVJd0jTHm0B5hHFM2o2rfI=;
        b=ER18b5loFWDyYrhLBE+hirb8OuMSdnILkLzdFdnUSv02DqitUJizjmbSLoUSaNNx/C
         aqQjJ0ez6gjy3Bm508ZwBu3gdJbhpScONNQnf1WCikY0RJPENXgEmOlfyxr4dW1q8SBt
         7Mnf6sksAcbfBHEReHvuJmrdBI4cQGsa71BlJTbjz9EWM/yQxLnpZJKAOyp+Q/G8Z2oP
         bGRI2DsYUPt1MOJRpVanz0h+cJ7DfiMz1XlAhs8jgXek8pQ7awIvMBj8ef5Dq47MUTj8
         uTY/DSWxIWigW3otmNogWr2GAB5Z0loOtPamhQH+MIZXZydDMhJH90VCCZR+WYxMIL4Y
         wS9A==
X-Gm-Message-State: AJIora8GG8hc/Dy7PsREUqzQ1gHtX8MfRfbqSW9x9131HeCcfVqBUxIH
	QFeq4rry6UCJEPR57igamyC03ns9SPzIZVlV
X-Google-Smtp-Source: 
 AGRyM1vz3CGSRb2oeIAlPtjBfQA20b2bibBGS4c+C6AX795gLWyWa2JuHg/Orf3Zz1aRc2u4Df/dZg==
X-Received: by 2002:a17:902:7b88:b0:16b:d9a5:7a94 with SMTP id
 w8-20020a1709027b8800b0016bd9a57a94mr33826pll.173.1657231745011;
        Thu, 07 Jul 2022 15:09:05 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 f126-20020a623884000000b0052891272298sm6320905pfa.120.2022.07.07.15.09.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:09:04 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Patch review
Date: Thu,  7 Jul 2022 12:08:55 -1000
Message-Id: <cover.1657231636.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Jul 2022 22:09:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13810

Just a single patch this time, please have any comments back by end of
day Monday.

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/3880

The following changes since commit a496a8952d8542ce814b13f460811d8849d25a3c:

  knotty: reduce keep-alive timeout from 5000s (83 minutes) to 10 minutes (2022-06-16 07:15:39 -1000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Joey Degges (1):
  fetch/git: Fix usehead for non-default names

 lib/bb/fetch2/git.py  |  7 +++++-
 lib/bb/tests/fetch.py | 52 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.25.1


