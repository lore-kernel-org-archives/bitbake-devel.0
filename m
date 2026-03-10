Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3077FD88CB
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 22:56:19 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8023.1773183375914525159
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Mar 2026 15:56:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=FshYjZzM;
 spf=pass (domain: smile.fr, ip: 209.85.221.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439baf33150so316620f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Mar 2026 15:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773183374; x=1773788174; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DcRnX2X9AoZM3ioWqGPDQQaLHhyIS+oBXnqpJqnRVFQ=;
        b=FshYjZzM+kvkjndG2shw2SxtVNbkBmxoBw/qxiy229z5pk7iw/sDJC2CIvqOGOAV1L
         e8T56QuXNn5WrQHRa8v3foBFTLMHbEx3OxUUjosdMdNPwjb8sLRUnKxfEn9AxY6IUxYX
         MaJmh22YHrc3s0B5MF4ANAqi1pawvxtKP22CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773183374; x=1773788174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DcRnX2X9AoZM3ioWqGPDQQaLHhyIS+oBXnqpJqnRVFQ=;
        b=vvUQCsIwDN63VX2HcSl0KPb4QXGYtufKowB7lONrfkiJQvCoyujCFgxgmZRWVECVKS
         IqnKyMAK7ZzhjfbM8dqjApjQFBA111G4+FWNbKge5dVO9RD7h2VoFM4fcXOhA2yPOqr/
         gMxwoET07PC/h1zzD83tOj3ltCU1emg4RlStWGxhlQ5RwhyUCwrdSmd1N7Hx7wd/WGta
         xShaQ2q0mTPEVxlW0Zu6+Mf4Cj4k9OopOovg93tOnOUTMAJ50pbcbMaSlMfjXaSNQM5+
         t6Bey5QtJ+uh4T+UNHT9OxR5esw9d6LGrd0+ClczGLh3y4eh5tC3vPyn/+J8Ar5rAqVP
         tdOA==
X-Gm-Message-State: AOJu0YzRB1ALwHY2XCXxAC2sqi/q6lCzOgoP0XXxBHlPch6Tcrx+wku8
	J1JhZ/I3YG4Jfrh77wZ82s36kcOynIMiq6JrOtXYrYYA3rfzUhM1zDumWKEMNi9s2At8Y0ERash
	q2uMw
X-Gm-Gg: ATEYQzzxQzInsTUmcDwTE2SpgvScFw9XaF5N4qp1simhMX+WlbjitN0B5OWf0rAcDs1
	pv/BioOnrHKqKmwgyKNNN1SFFC7w24keCqCQWzutPdhoC26TI2+lJag9SUeXRzBL59H66NsGUz/
	WC0IQNi0wWQCPIEcqdS1rPSY5r1f9B9Fpd3Hx33LYJ4k48BDN8rnT57LkF0GR1kBCryldOE12Yd
	h3rH4PFvvQIj5wHdZsqdqY2vBcbq3/KE7E6gC1lYPFYE+CKklNW0n6KNIlJacj/lYm7bMXCtodY
	sS5JAKmK60YuIuTEwjFg56ps4UlSonjeN06J+drgPoC4018svgc5CFHHcOsa3zfoOPYsEB8BXXG
	rgJ0Wii1gQPqQo4z9B649nMAC32wa7XGB19Xf1aMi/uKCi9lEGEpFzlXY+IaP2WZsaLSg/uDAsv
	YXKu1EDAGQuwqk2C6FKczURE/qlQVLWXbD9frh9t2mgcRkT0eocPkpktK5H84GhPylXLUMJaLMg
	wBgprj7CaBN3GkBp/I+zTXh3msEWO3quNTM8w==
X-Received: by 2002:a5d:5f82:0:b0:439:bee4:8a93 with SMTP id ffacd0b85a97d-439f8bbd6f7mr758593f8f.12.1773183374024;
        Tue, 10 Mar 2026 15:56:14 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a0239sm1498473f8f.10.2026.03.10.15.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 15:56:13 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <paul@pbarker.dev>
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Pull request (cover letter only)
Date: Tue, 10 Mar 2026 23:55:56 +0100
Message-ID: <cover.1773183271.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Mar 2026 22:56:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19144

Those are the patches from the last patch review:
https://lore.kernel.org/bitbake-devel/cover.1772924048.git.yoann.congal@smile.fr/T/#t
(no change during review)

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3349
Ignore the warning about Centos Stream9 (it's support is a work in progress)

The following changes since commit 10118785e4a670bce4980e1044c0888a8b6e84af:

  knotty: Make sure getTerminalColumns() returns two integers (2026-02-13 08:48:40 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

for you to fetch changes up to bebecffef63a3ac60420b5347d549f71b00dc151:

  COW: Fix hardcoded magic numbers and work with python 3.13 (2026-03-06 21:15:02 +0100)

----------------------------------------------------------------

Richard Purdie (1):
  COW: Fix hardcoded magic numbers and work with python 3.13

 lib/bb/COW.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)


