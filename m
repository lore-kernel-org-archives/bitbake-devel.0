Return-Path: <jeremy.rosen@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86431CD98E2
	for <webhook@archiver.kernel.org>; Thu, 18 Jun 2026 09:36:37 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15606.1781775386579503278
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2026 02:36:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Hw5cOmPM;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: jeremy.rosen@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3637b90so4854125e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 02:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781775385; x=1782380185; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3+ubAilCjrNYwdyqnc1koCYwA/PQAMCnrmPdkheCv4=;
        b=Hw5cOmPMOspVTp0O3/j98rrtgzBp49wQ3Te+G4t14rzAfQapNW5p5kaOmoMIKK+rIP
         4hnc/A2p7VgexeSV0F7wxkTtbXBb/t54RkRdZo7qKzNK8gkNzdUJc6vmbvampMKTs3oC
         hwKVdYMMXrgAosUCluBKF73X2XhXLPAQYEWr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781775385; x=1782380185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3+ubAilCjrNYwdyqnc1koCYwA/PQAMCnrmPdkheCv4=;
        b=IIEuGJjSoP+SvIImoO/eTz5BaQfMa19vAsy8YfTxjHoWTDOTq4KcCJEXfPpdz6BRsw
         MxorHf66TXJToLU1JSobgKqPWoBZfYYFOb849EDJXjCevoATjdFK/0R2Dvl279uN6Ph4
         MDUtRF84KZzsrf8f6jmosE3VzdfVIjswcrDSbmwznb/SlWqfv3mVBkqTon5F+l2qxcxa
         EVYb0ebYNHMKuQuLbY7J7Q58Q648En7PJWq0LAd3Yk6nScprMBmL9oKlh/3pi5CftzFo
         Ru6/VCBTfJLUy+/4bLIetJvPeq+pd2XXToVaYyCKMHXqXoPc2N9Vu96wMP78WqeoEFJj
         W/bQ==
X-Gm-Message-State: AOJu0YwqGn1mJQ7/QOEr6L+LAWxjKQPWgNj/6d4jNQ9mqaPQ2ZhYdY+m
	eoIxwR7lCD2XUzxGz3SoS0i5ZIFJmKyETqZS50p5wkgcqTX5/p1SzBXehyuS0kJnxpniSXOFzjn
	PTPo0EQ==
X-Gm-Gg: Acq92OHRiCxzJuBSdBPybiw9iZ+Tu8ZBoc0IOhVWJsduQVGX5F1tRPZxN2G2gaUMHyN
	XPsypa1TUYS5UcR21qjp0HS6d0rGVt676tA1PoYGykHXycFO1qrQBsEBGx0QdnQAMdyYoGcbhm6
	eJ6oQ8hvkNXgHHg2F7fDaQkOtDLAR7Hdmqh6TrfRzL2TDx7bRR1kb6F/s5gBZh/HpUT39gca8SF
	IQK/EFIQwpC8/5ZqpXEueIdRZL6JLzITC1hRVObSlHZcOjoNOa66qYPTHkpNbWO1F2N7si6I5Hd
	0Mv9j+YtG5YjwJO6XyWCrSfE6P+zPyOpNvajWVV28qSXP4P3jni9OODvE++MIhTxnNzAdUVk0EJ
	jRzsu3upJKSKHuDJM9tx8JQKIUIJsI2f47vts6GqLZYzlsnFt4u+V3QV2/f9Lh+45Ftw8c03jhu
	//ktAZH/RJy1MlB+0VyzMe6v9aHYOCSOlkcadvrnYoiqIUoDJFS/yiY6sTge7FavTH9Qw=
X-Received: by 2002:a05:600c:154a:b0:491:7325:39c4 with SMTP id 5b1f17b1804b1-4923822c4a8mr50923755e9.34.1781775384706;
        Thu, 18 Jun 2026 02:36:24 -0700 (PDT)
Received: from Logrus (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4922fa9f2c0sm279117755e9.15.2026.06.18.02.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:36:23 -0700 (PDT)
From: Jeremy Rosen <jeremy.rosen@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 0/4] Pull request (cover letter only)
Date: Thu, 18 Jun 2026 11:36:13 +0200
Message-ID: <cover.1781774920.git.jeremy.rosen@smile.fr>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jun 2026 09:36:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19732


(Acting as LTS maintainer in training, process has been reviewed by
Yoann Congal)

Those are the patches from the last patch review:
https://lore.kernel.org/bitbake-devel/cover.1781271084.git.jeremy.rosen@smile.fr/

please not that patch 0001-fetch2-wget-handle-HTTP-308-Permanent-Redirect.patch
was added to the patchset to enable backport of
0002-fetch2-wget-limit-auth-on-checkstatus-redirects.patch

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3980

The following changes since commit a4daa14312d659333984aa1ae58ddfe0c96392f1:

  hashserv: validate unihash values (2026-06-06 15:52:19 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

for you to fetch changes up to 0880963fea4d91a034e4a6e007d23f98658ab986:

  data: fix issue with varflag exclusion (2026-06-12 11:39:20 +0200)

----------------------------------------------------------------

Anders Heimer (2):
  fetch2/wget: limit auth on checkstatus redirects
  tests/fetch: cover checkstatus redirect auth handling

Marcio Henriques (1):
  data: fix issue with varflag exclusion

Ross Burton (1):
  fetch2/wget: handle HTTP 308 Permanent Redirect

 lib/bb/data.py        |  2 +-
 lib/bb/fetch2/wget.py | 65 +++++++++++++++++++++++++++++++++++++++----
 lib/bb/tests/fetch.py | 62 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 6 deletions(-)

-- 
2.53.0


