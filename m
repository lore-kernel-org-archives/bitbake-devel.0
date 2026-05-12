Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974E9CD4855
	for <webhook@archiver.kernel.org>; Tue, 12 May 2026 09:08:03 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71497.1778576882795547227
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 May 2026 02:08:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=vI6kMI2Y;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso32214405e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 May 2026 02:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1778576881; x=1779181681; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zxgjyEAlGpZohPMUuhCgJyFQYVPNClHetiA1mm8M+Ms=;
        b=vI6kMI2YOowyRbHZwpmMn//SGSd9usHyLUkUL1HrffpKcNNH7FXx4YIB/LD2fLuROa
         IHCIKwhb5Cg+MxkndjoXHFlmcX/oQMyD/aP5F1kfSYXdYdYEWMbvpOx5ThK0787CggE2
         GknCcbgTBREaTtq3ZKtf5e3mG5W7hH2S/HkF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778576881; x=1779181681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxgjyEAlGpZohPMUuhCgJyFQYVPNClHetiA1mm8M+Ms=;
        b=msMoogL7LckwNDhHcakKxlyPRFFfT0h8carIkMHcfrSe5yinO3KU+YaDR8yluxxc5g
         WpPJXQMjrDRQdKQNJVIs1tpoK84b4gpwr00jsRUexFR/9ENCaOKodir2i1REhiWu3EHY
         7Dd3ZDMHELy0rFSnxccxCinE9bwyNkN0qpHapNfJF7BgfKgbXksKeEQlNd+Ssiud76jx
         7a4Cv4HrAUAGu33PYURJAlFudl4a6Cs59V1rv/dQgceUSCRnIf5l2i2jQ4tb6ILRD6lM
         o+VB2Tu8fqpafgXuSZoavUT9SHjyZB9E/+6tY8FaUB0UH8mgdjI46Q4vsClp/DI3wX31
         DsDQ==
X-Gm-Message-State: AOJu0YymVb/AeA+669ebD+gZJX23rc8oQzDMnvcKMFsGPdRAl+ZJ3sZ7
	wIZwM+zMpuXTi0T08AMyCHMJC04bC9aIHxEDSVwdF+Q/nu7Z68ToXdTZDJjbRHkZ1pf4HM00aNl
	hRc7Yc1A=
X-Gm-Gg: Acq92OHUCViY1kZgHXiA/anrKfAUakDKJH4AQ1mA/oFUXkR3Kgw0nZbp5flQICw4P52
	FvJSrIAMgz27tnZ54key86FyKJWdkpaOQJws+sznzWsmVlZ+WlFz1IB2ALiyJSIjvo+jvuMb/qt
	QQCPc7X9FCYHjKNDLg8isUNF5vNFC9FkKrbHce1ELleaHW46eWdMbkxdYVnhb8EQSq36reNO6sc
	Yt2iKt32EKcb1seutY9E/ek8dv6q/1uouMxe8kes1fHpAWKkxEYL/4u0StFmyctVno4wf3n4Pcs
	9xIU3XDlt5hnmCUZyocQ6HL2dntbs/6+CiQnUH0i01CPSGP3BHi+fz5BSx2rkt6Jml9INdvzMTx
	JlPziHv2pjlvidFwSLgpjq7EPVWL4PAVXNTF7GygHQNppWsnk6mOQOkaqLz8LqtXgX72SJedzF0
	AIApUoE1Uz4WdlxPb8YDykDEbw+/tWN3UEXTMpXpXG8NvkA7SuU+Xo0+i/2MYvm8ULTST5Ydg/7
	mFaPPpl6PT47n94s+9NEhtEN2CDmO3n3rG7yw==
X-Received: by 2002:a05:600c:8594:b0:48a:52ce:a4b1 with SMTP id 5b1f17b1804b1-48e676a4e1fmr210087275e9.15.1778576880877;
        Tue, 12 May 2026 02:08:00 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e906b04a9sm52043525e9.7.2026.05.12.02.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 02:08:00 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 0/3] Pull request (cover letter only)
Date: Tue, 12 May 2026 11:07:45 +0200
Message-ID: <cover.1778576715.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 May 2026 09:08:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19498

Those are the patches from the last patch review:
https://lore.kernel.org/bitbake-devel/cover.1778197991.git.yoann.congal@smile.fr/T/#t

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

  https://git.openembedded.org/bitbake-contrib stable/2.18-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-next

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


