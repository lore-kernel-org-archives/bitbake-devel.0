Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944F7CD6E7C
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 22:12:43 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5824.1780697562731066290
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2026 15:12:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=tjm4yv7P;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45fd45e596cso1185531f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 15:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780697561; x=1781302361; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/VBMCGm4n1J6dxtC6EMc334LsclbM0OxqGsPOiLaI0=;
        b=tjm4yv7PWZz24ecfPShreZ7QyfbCWJsTKBFYtz8GqAXLtC42WVliw4MA7b99GVje7K
         PWbIbd9U0dyB1TG3pLsXQQQlHpFDhDyg2V0HCbNHeBbHzX1Zvd75I94tb8se26VvTnoU
         P8hiGG+dgI4oh1dQRwGrINCchNNCvQ1EPGcCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780697561; x=1781302361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/VBMCGm4n1J6dxtC6EMc334LsclbM0OxqGsPOiLaI0=;
        b=auRxUqD/3cKccmHfgKq/pPuaAWiEkROAgIHy3ik+bckbuSYupv0clL5xgfTQNWftL+
         +qeYy0Nqp7iktnjc/7rfq1iom0uxNS8C+6DuoXUyyMcO1EbGC4clHRRyozsBNDmgLpC8
         SW9NRG4YYE5/1aTIqlhndn+KIxVZirQbHcDBBCIw1hXsM2cfL9IuYujcYNT0TFatltDz
         Y4zqJqI2DT9pH5hMjYKnSJERGHqE8x2r1o4HJenFXViQgHV7Cvpne7OAl9w7wwPMslhS
         elNQqZsFU7S6jSFidg/sREOjOAG6mN8FEAr8AxXISnZrIXks5xIqGiADrfjlCQg9Afzh
         0nww==
X-Gm-Message-State: AOJu0YzirmghxfA/5hIipFnBaPuArWw4IQg8KrWYNYA4rjZykuJHrx/+
	vBVqxfP4wC3gPUGRAPdumHUbScH26pcq1AvYYdMcHYaDsVyOYady/CtRhrMLszAkiLxgLytW9G1
	xgFnY
X-Gm-Gg: Acq92OEmc1riz1DVw9gCGGC4MgodU7ewc5GnGAXORZSFOdwWWajjCPKzydAeSKIrSZ+
	l9LhfEQh/i0i39wue/bniRuFxjzXD1xxJp6F0BbVW2pVW75lvW1L1NgJVrcBeYA1cS7XoOkFrhS
	1MHYsxKWy0eOIkuXWrgl26oYJUehaJ+mk2uVfUc+sUZ21SPq8lFyXiZDZ/yqm5GIhNQ71+jXFJJ
	lj9m3IaIt26QRXBE2thSRXwBvvImS6KJ0w/J7/qhnbmuSPpZGT0fN64Fw/te4Fk4hjaUtsgg5iC
	IPWL0hnipJLqsQX18EQX8EDa7uKA18VNqROQUc18Y+7gHQH1JWWNVBGlX0Cb5kQ8Q8zWV5pfph0
	ojUZJnkVy8uvDzbhlPflC21fLiFTk5eE6nw/Z8H+4uH4ssZDCvs8B+Cpj+k3nQruS33O7uoSdYT
	KZF80WdTggdyjEqE/9QLWGoelQX2jp53buhLeH2/sbOimYzZiW9rZe5nfDCdkAPVxZRDa080I3p
	NWUs0/PUMWHtq1cnVVerN2Upcx2Yx0LBLWcaB4=
X-Received: by 2002:adf:e98f:0:b0:45e:ea9b:edf6 with SMTP id ffacd0b85a97d-46030766829mr6932122f8f.36.1780697561049;
        Fri, 05 Jun 2026 15:12:41 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00b3e1ccc1be2b2798.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:b3e1:ccc1:be2b:2798])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcae2sm30770393f8f.6.2026.06.05.15.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 15:12:39 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 0/4] Pull request
Date: Sat,  6 Jun 2026 00:12:24 +0200
Message-ID: <cover.1780697470.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 22:12:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19621

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3933

The following changes since commit 82abbfcdbda949851a03bb2cb2049ea689564ad6:

  tests/fetch: Avoid using git protocol in tests (2026-05-13 22:22:20 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

for you to fetch changes up to 37beb06ba9329cd16976273efbb341f781d4e749:

  fetch2: Unpack RPMs with --no-absolute-filenames (2026-06-05 12:50:29 +0200)

----------------------------------------------------------------

Anders Heimer (4):
  fetch2: validate deb/ipk data member names
  fetch2: validate striplevel parameter
  fetch2/git: quote shallow extra ref arguments
  fetch2: Unpack RPMs with --no-absolute-filenames

 lib/bb/fetch2/__init__.py | 19 +++++---
 lib/bb/fetch2/git.py      |  2 +-
 lib/bb/tests/fetch.py     | 94 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 7 deletions(-)


