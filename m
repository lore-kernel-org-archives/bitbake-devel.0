Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA324C44507
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 09:52:56 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10153.1784281973352118631
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jul 2026 02:52:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=DKcFIeJf;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so54304765e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Jul 2026 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1784281971; x=1784886771; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5BK7YvA+eTnF8GEaYlK9LQ8wK838uKBZ8EYLpW1wdHM=;
        b=DKcFIeJfhppsd3hPf2GOvh1hOC4B+bgpOCX+ROCLf0FwK2XdblHDJ6CsbgbYialiQg
         /aHYV82Yxtm+babVKIfe1CZnglROjRxuiUzULbVxSlq0Zgd2XO6g5uM0Ws92yA4BetrX
         7rFNHT7V8bqHe/OOdHyW+OyeHGPqeVUbIcO9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784281971; x=1784886771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5BK7YvA+eTnF8GEaYlK9LQ8wK838uKBZ8EYLpW1wdHM=;
        b=kQSe9MlaurSCXNCcdDFmaRbwxyQP0r2m0lqluMVMjyz3ziyd0zrr6rDyEZHo7I95xM
         6X29aOV6o8O7LI+COWqAPsQRh5c5CybY/bj6N7yKRm77UF/vmm1zzBYMnnf1Vw1xyyMk
         LYj16jQN4L9j4B4rwPD9w3D81NFmvrYk7Qhs1kA7zAw71xRCG1u0kUGqz4YGJQhBNlgU
         lvl8cKSs5xEsFnkOp6f1oc/VLhsiMhnZfn9+D/BHKin8fF1hUUj8fCsGGvEOhrks6KZG
         4cwb5Gikz5lx0WWK35q9B92ipqCv8SdikWx1RGV4xkw+XtBBb9WFWUh/ZTSHhwwaISgo
         yULg==
X-Gm-Message-State: AOJu0YymISMpudt4ScsptuomxySbW8KNZt4nJR/coqiWa0p5J7M6K27V
	vLK17ARDN1YvlMoTKs8D2rIkHUGE7pdg/n6JcYwbA0FVozCV9CQVL0NLbrx7Z1ZfxaJCt4mkhY1
	F2rsOWg8=
X-Gm-Gg: AfdE7cnmNWDmeab3f2+mAd0gKz1RaCj2ci86HUGTKTg81fhej749wgE554V0BzRzCTv
	OvGKSPOAlAU1nY8O3CqL2O6wgRG1XKHCCXry/4Dakm8tFQMBJLEOMlNCdZqa5tWmY7kg5cXc2zU
	Lv8FePRlK7kzZ3X0Ui7IO3BdsG/bVFtlSCVS9/y7UWAIrnGo6CDGPUm4QhAJelxgFDfGLEStuEd
	6K7lI5H5gG5h8/zTTRC9fev5rZYOQM3SR7xkbTR4McP+7YjDGZJh2te/UMJDXMeXG3kJnz+0wY3
	jZP+SQIza9c/9i1oGpjMCHdMT0O2StuzqqDG4udlGjHeSKiNLgVrrii5OQ4ca/RCpFg7B7/NEae
	EulDtglyNY/JZBjA43wmLRkjc18prp341K8cCh4KY8uYUYCyUbBm6deZ+kKy+WApnhS3G+CmQ7T
	OblVQxyS48RMv9uvxpV8al2GfqNPu1Fjyr5CuiQQHjpu0cCAHvjrNxpj7N4IMlLtwCRIp6o1/N/
	17xL1M=
X-Received: by 2002:a05:600c:4fce:b0:493:fa66:4861 with SMTP id 5b1f17b1804b1-4954a404bc2mr23785035e9.25.1784281971092;
        Fri, 17 Jul 2026 02:52:51 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0093f4151e9fe9f4b8.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:93f4:151e:9fe9:f4b8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549c9c929sm32932095e9.12.2026.07.17.02.52.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:52:50 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 0/2] Patch review
Date: Fri, 17 Jul 2026 11:52:14 +0200
Message-ID: <cover.1784281828.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jul 2026 09:52:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19841

Please review this set of changes for wrynose/2.18 and have comments back by
end of day Tuesday, July 21.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/4214

The following changes since commit acfe02fa38b5da9e6a36c6cedcf91d4fcbefbfbd:

  tests/fetch: cover checkstatus redirect auth handling (2026-06-11 11:50:29 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-nut

for you to fetch changes up to fae9db3168dbff1b8c76fe9c6726a9687ff97514:

  utils: Add NFS EEXISTS/isdir failure workaround (2026-07-09 17:37:07 +0200)

----------------------------------------------------------------

Ernest Van Hoecke (1):
  bitbake-setup: always write newline at end of the README

Richard Purdie (1):
  utils: Add NFS EEXISTS/isdir failure workaround

 bin/bitbake-setup |  5 +++--
 lib/bb/utils.py   | 14 +++++++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)


