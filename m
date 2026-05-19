Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A973CD4F5B
	for <webhook@archiver.kernel.org>; Tue, 19 May 2026 23:34:02 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1074.1779233636520464694
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 May 2026 16:33:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=zeHAheNE;
 spf=pass (domain: smile.fr, ip: 209.85.221.54, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45e7c636e74so1952927f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 May 2026 16:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1779233635; x=1779838435; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhiaabLN2hltIFBkOd1rFp15y/aevKYHOdIB4XjgNMc=;
        b=zeHAheNEUP+L9LYepVc6YXNu9W9QYI67GP2UvpX7CSrb/MVJTFUbLVHFwgL8355+QK
         2rqKL33a6x9aM6FONCb7r7HEBx4KGqOJforQ104KISKfLjzOAjkjsFiWNoD187LY2xwn
         9ruypvje5WuWDU9HQrhp+dLABIy9tJsuVsBko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779233635; x=1779838435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhiaabLN2hltIFBkOd1rFp15y/aevKYHOdIB4XjgNMc=;
        b=otNb+jLpiTo/mZJoDCTIXu9N/iN9Z8Dq5uf2WISYxMFUe5Kp652DRTm0KrC295JlO2
         k9q+Xvs52mKhurfjuFLywX3VtOpKRAI0kHVgEKfMUWynr9fVl4X4iQR2hw9CNpDbz67k
         D52jzX0cU/06bKJCeSlO/ZaOXLeDryXwlAiJlCAj+oloiZVDrkY9Dn3AtmmAiNBBPqHl
         h4R2639K534Nv00AIDSlMNJEpWTqb/xk3zF6/N4d8p68+6jNVV4sCejl5C2O6Xdpgym3
         8hL8NY3Bxamdt+DoT9iJxMbacvoDlXvBsFlutC2mKhsmdS4WokvEqS3GTJub/2JpzvGz
         lIEg==
X-Gm-Message-State: AOJu0YxcSFBEkbjUIHFKGCREKvkc+zph9bhzqAlfYDC9IVh70MHSHYsc
	z22TKp3riSki14iTWIrpJDdkYbB6NTjGj88EW4D1ORyHiv07oKmtkkHA7r83t88DBmL01g4SLkv
	9H1jf
X-Gm-Gg: Acq92OG4RwbRmlZEWZG48zUyglYc7t4hGAW19XQ3Ea4ZkN4SgDZeRbRi+Qplztzf9N+
	XEokkmkcqQaJ3418nbNNxqnU6QB7UaDvseP1Ym/Umfcg5fs/Cu/F05A5BpCcWDwH4tfZsexGUuG
	V/xLvfqnnx8t6vYGiuz9j+Mjm7UFy2vIx9HrG9BcSBlRnqDx3Voqc2Rd5zOUBVjUJ4J46++KMej
	hiTTMNBOzx1Y7pMq7ZEhz5YN3d8S4rMkzetXvX+pZ6hh/C3Gef9cqshQIYHHZcu9DDpalMHZ4HV
	g9NPa0ZnoThR/k6HgqlqWqdyuAk3w1fMoTK425/zwRyANbVVd51oGGMzZygttax96nh7uZ9z5lQ
	b8CerIYXrR+YhFv7AuZNdJszqj4XHEtX1EVl4lgQQgsZwh9xeL/a/L1J6Yvhrl1BTxQd/FFWEUE
	zXIzjnZqiNS+FD7KWYJY2RQhWuzlIYwXVlIFzu4MJpO8h6Kj/XASiINzllbrnwr8nxvJhZkqlkW
	tnpYdzqqNuigk8oC5oi++zEDmHFTDy4j861ZQ==
X-Received: by 2002:a05:600c:a11c:b0:48f:e230:8cac with SMTP id 5b1f17b1804b1-48fe662a1cbmr245555185e9.32.1779233634646;
        Tue, 19 May 2026 16:33:54 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88495sm349517665e9.4.2026.05.19.16.33.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:33:54 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 0/3] Patch review
Date: Wed, 20 May 2026 01:33:43 +0200
Message-ID: <cover.1779233514.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 May 2026 23:34:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19543

Please review this set of changes for 2.18/wrynose and have comments back by
end of day Thursday, May 21.

Passed a-full on autobuilder with some AB-INT issues:
* https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3846
  * check-layer https://autobuilder.yoctoproject.org/valkyrie/#/builders/27/builds/3851
    Failed due to 16285 – AB-INT: check-layer: unexplained changed signatures
    retried as https://autobuilder.yoctoproject.org/valkyrie/#/builders/27/builds/3852
  * qemux86-64-ptest https://autobuilder.yoctoproject.org/valkyrie/#/builders/73/builds/3688
    Failed due to 16279 – AB-INT: groff error: couldn't exec preconv: No such file or directory
    retried as https://autobuilder.yoctoproject.org/valkyrie/#/builders/73/builds/3689
  * qemuriscv64-ptest https://autobuilder.yoctoproject.org/valkyrie/#/builders/56/builds/1610
    Failed due to 16215 – AB-INT PTEST RISCV64: libpng ptest failure
    Retried as https://autobuilder.yoctoproject.org/valkyrie/#/builders/56/builds/1611
  * oe-selftest-debian https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3878
    retried as https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3879
    git.openembedded.org hung up a HTTP git clone connection
  * oe-selftest-fedora https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3740
    retried as https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3741
    git.yoctoproject.org hung up a HTTP git clone connection
I attribute the last 2 to the current situation with bot scrappers.

A new build is running here:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3847

The following changes since commit 0415a00658b59f66bdab22a3558794f238c42973:

  fetch/git: Improve temporary directory handling (2026-05-13 17:50:24 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-nut

for you to fetch changes up to 22021758e66737bcf68dfd2b74adc6a0cb1d42d9:

  README: Add "2.18" subject-prefix to git-send-email suggestion (2026-05-19 11:08:15 +0200)

----------------------------------------------------------------

Alexander Kanavin (1):
  fetch/wget: in upstream version checks, match versioned directories
    exactly

Yoann Congal (2):
  b4-config: add send-prefixes for 2.18/wrynose
  README: Add "2.18" subject-prefix to git-send-email suggestion

 .b4-config            | 1 +
 README                | 4 ++--
 lib/bb/fetch2/wget.py | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)


