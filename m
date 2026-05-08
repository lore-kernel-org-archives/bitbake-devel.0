Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A72CD3436
	for <webhook@archiver.kernel.org>; Fri,  8 May 2026 07:13:51 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8200.1778224423765458182
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 May 2026 00:13:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=NqzXhRVs;
 spf=pass (domain: smile.fr, ip: 209.85.221.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-44c4cc7c1cfso1343719f8f.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 08 May 2026 00:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1778224422; x=1778829222; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HqmLudyo6+sbTI/sN0xU2jhEvir5uoIMuYUMeGJI+Xo=;
        b=NqzXhRVsADKTlK6C9noyDkm3fRXLUXBgs0OnY5JI1Bn5IwtIpEMXvDCkTfNAF+hx5B
         6pyPXtwYOwCjiP4VRqbBcZNWNiFbFCs5dkkAEdOzpjeTTTZ3iiXE9cxRpHh5EDoaFc5T
         3fTLiQdHpg93q9ARe5oEPP9LQlJVL2CNkrTII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778224422; x=1778829222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqmLudyo6+sbTI/sN0xU2jhEvir5uoIMuYUMeGJI+Xo=;
        b=aTRbFPCIXSXsHUa+Ho5mmLP7xQwEX5Jl8aAtZ2wTxeRMeIogXxJHLzjYSxIk7MGRfn
         46GelIgJPdGrgteTSzkAdSa5GMS8msOpweywomJVzcUDWTOfHl8vr9yamaUQ0q1vcnUs
         37oMn1kh6ZTGo1TEqxVWIwjdAxYaThi+ufTW6uKoDrBAGZALfqTGpWteDhc38oQzJuK5
         11kijUBRwO3BBs8HprH67NIRZU4utC2iLULFlUQdmWU+dAg1t15mblLy2PahyP62uYit
         WA8YIXXn5VoZ/US2+mgx88FGerLETYpbP4FO1439e/BNT1jPYR3LmwkrJGPQ7oEnFwkg
         jluQ==
X-Gm-Message-State: AOJu0YxOOvtpklPc2bWLEqhW/zr05M02nPj24u6kIqOC+zIakGjK1EGf
	qGJqR7Vqqj95akD4+pAkXU237EzFJnV3Hu/SIZC9nknvWduym+luYMehWtz+UDOf9u7Kb9qa1sv
	9+xhlpT4=
X-Gm-Gg: AeBDieuKzgw+ktwJUY9nOIZq/nYimi8mW6Eyk20D7ITqNsThK/niK1YQ5q2C0gTF1n+
	f9BJ1Q0s3JRQiPlgpDQU+E9FgjOHuBVUuC/LRHd5VV92pNs7p3OgjngEsrG0PEvRC8HPbPIHHc7
	ot6TkHUpzbtralXoIBqFkQvvPKEEQQ3/bzzyBBmfKXY7R14/XCHeWMuQq7nQOk7p84xuRQR7tgg
	8pmCPFmflcoAaWfgMjynqou7qFzZqv71/RLMsCB3xxykzaegcaEOsK/cPWHBOAdviVHpa2GXEqA
	PWx1I9k04nW3lT346dV29FqIE+AXWnQDthx2I+yT6kzT8DY7pr1Qiob5kN4qeOaunj7bVilQNbx
	o1torCJn//k9Mx0UXvw+c/5ijh6WT9Gev859qLe3ing4rhKF17nopv/u72/iIes2bphVrxlbh6j
	i3/ZchI3ctKkyqaJCwuueH81TQmmYxrWf/7QvHbcYG6ioPAydPxQi40AEjiSZ9hT/x2CRnau118
	mq7SQg+AlSKPO7lMKlvRkvEiH9gdYV0+BYdYg==
X-Received: by 2002:a05:600c:4e0c:b0:48a:54fd:54ea with SMTP id 5b1f17b1804b1-48e51e21378mr193196385e9.12.1778224421663;
        Fri, 08 May 2026 00:13:41 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68edcc3asm26363195e9.6.2026.05.08.00.13.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 00:13:41 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 0/3] Patch review
Date: Fri,  8 May 2026 09:13:18 +0200
Message-ID: <cover.1778197991.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 May 2026 07:13:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19474

Please review this set of changes for wrynose/2.18 and have comments back by
end of day Monday, May 11.

Passed a-full on autobuilder with 3 AB-INT issues:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3795
* qemuarm-tc: 15698 – AB-INT: runqemu.QemuTest.test_qemu_can_shutdown hangs with "Data received serial thread"
  Retried in https://autobuilder.yoctoproject.org/valkyrie/#/builders/42/builds/3689
* qemuriscv64-ptest: https://autobuilder.yoctoproject.org/valkyrie/#/builders/56/builds/1562
  This is a ptest failure in procps: 'pgrep_match_against_full_process_name'
  This particular ptest later passed in https://autobuilder.yoctoproject.org/valkyrie/#/builders/56/builds/1564
  (I have yet to properly report this one)
* qemuarmv5: 16217 – AB-INT: boot hang in qemu (amba chip errors?)
  Retried in https://autobuilder.yoctoproject.org/valkyrie/#/builders/80/builds/3559

The following changes since commit a2dd9be788274d9c7280be5b1be5eb5c3990cf54:

  fetch2/crate: use CDN endpoint for version checking if possible (2026-04-30 10:08:54 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-nut

for you to fetch changes up to 87dcc2935137558ac236676ab7bcbc3cc4883c2c:

  lib: Replace codegen with ast.unparse() (2026-05-05 17:36:57 +0200)

----------------------------------------------------------------

Alexander Kanavin (1):
  fetch/wget: in upstream version checks, match versioned directories
    exactly

Paul Barker (1):
  doc: Fix description of git shallow mirror tarball creation

Richard Purdie (1):
  lib: Replace codegen with ast.unparse()

 .../bitbake-user-manual-ref-variables.rst     |   5 +-
 lib/bb/codeparser.py                          |   5 +-
 lib/bb/fetch2/wget.py                         |   2 +-
 lib/codegen.py                                | 564 ------------------
 4 files changed, 6 insertions(+), 570 deletions(-)
 delete mode 100644 lib/codegen.py


