Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DBFC79FB8
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 07:31:14 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6471.1788939065590754781
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2026 00:31:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=A3sccmkR;
 spf=pass (domain: smile.fr, ip: 209.85.128.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49557167508so64758775e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1788939064; x=1789543864; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CZgST4oB6jNAoeMtG+XD8QenDG9PcJUikl1HgYuHgo8=;
        b=A3sccmkRf+JAkDiOQyE2fiqe5pr1DurwFVmfyNgRau4HKT2Vw8AUqj6xrLRif/qJRj
         22jPUYVAEDOaMCh8fz+XBfcAl+m247Xcc0n6WTb7gmUMg3OA+laILMiT79oAW/6MOV+F
         aUuXqcejr2bMWIOEfa94XS8QzbedM9PK9eF6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939064; x=1789543864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CZgST4oB6jNAoeMtG+XD8QenDG9PcJUikl1HgYuHgo8=;
        b=PX3536m6zrt6dSqZShRPWyza37UNJRzmekSW286uW46qZv9u986gemBnDdqAmHwAVp
         d3KZTOMn5vxLo583z/QdKtIVTDSJDSoAI4RPvxvVi/t/TYz/fPuqP7UFxDTvn9KH2xRZ
         gdlNH+SwgYI3yYwfR4o/GQLdiDGwwpzGESe2qVaVGlQ2Hih1SPjq3Wrd8Y3b6/41NJkK
         9fJxQqv8C7wrW4dG/Taxc6CU+/GQLFqBvq+AJ/JrpC/H3exnZRhDVKVUdeNfwk7nzdUA
         89pyDDTcvWLogLVlR8BOyphG24Oxd7Uwg+YIJ9JHmnmUSJ1kI8JvL99CYr4rNML/T0pD
         3dOQ==
X-Gm-Message-State: AFuF++mg2amCHBwpLLVggxp7o0kNDKkjctAR2PvIBaLyWbWu2LSwImcm
	ScuGTq6WYduG38fy24sGwQ3MyiXBhfpT2+LMotlMFieGZmh82TNnDRqZafnBphHlIg+B3Q4JZGe
	Z6g/Xhq4=
X-Gm-Gg: AYBFou2xYgXWmxEs4dSOqOvJ/DJ99XS2MyhmCF56aJUF+Mcbn2A+a7MiNd0h78PuECD
	N0owi6cp/SlwnJUyvpR+wheq0zijwwWhlzcxJakM8Dgi13tGeyPtwPmwA8EGRxUReFzpHdYqaxx
	AMegBFY7ot8dhU1tqN1vwbf+jTieGY+GbnME4E/DmfBJZwvD+GcbQ5zuJwqVhwrndZ4nv6mEbpo
	hjREM/3QVvEmqZl9bCmswLYZEU2QqsP5poxON2PG8UeSE/IpLQC9OoPq08bJJqyfcCjMYJenZGP
	fEa4qyymEq5hWAIqMWeHW6rxB6ZbYpISg+Qb0fww+ZEkNagyk1rCHz5azRvLnqCW+QgNIWKjvro
	sAkT2OClW3ZKxnX/cHqiQRvUvjKnmNont7ZT3SifUIHx0XXB+GdMHt+Tesj4tQNJvYaTLFW/W3P
	gTuKy+v9BqxYfokscKCq4pPXCtZ4ocNRlrxmLtuLGCK1Br30HwF559eWKpr18HVJzF59J8hHS/P
	PaLRnKpxo/AQY4p7UXV644alSqX2+m59u4K2ShEzONfDwyGKmeti+vnlAkGCvLaM8opR2NCI6w=
X-Received: by 2002:a05:600c:3b01:b0:49b:4d64:bbc4 with SMTP id 5b1f17b1804b1-49cf81f1592mr584947365e9.8.1788939063694;
        Wed, 09 Sep 2026 00:31:03 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm553491385e9.4.2026.09.09.00.31.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:31:03 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 0/4] Patch review
Date: Wed,  9 Sep 2026 09:30:56 +0200
Message-ID: <cover.1788939009.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 07:31:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20172

Please review this set of changes for wrynose and have comments back by
end of day Friday, September 11.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/4697

The following changes since commit 0ad6c1c34a5e07a5f8dd66ab248c1e7b37b69fa9:

  doc: bitbake-user-manual-environment-setup: use pip to install bitbake-setup (2026-08-20 11:15:51 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-nut

for you to fetch changes up to f0df79b6b56f6a69067adf974978d9405077f246:

  tests/fetch: Swap bitbake github mirror for YP one (2026-09-08 14:13:56 +0200)

----------------------------------------------------------------

Alejandro Mery (1):
  data: Return a list from exported_vars()

Richard Purdie (3):
  fetch/gitsm: Store the original url data to fix relative gitsm paths
  tests/fetch: Swap github grpc repo for our own small test repo
  tests/fetch: Swap bitbake github mirror for YP one

 bin/bitbake-worker        |  6 ++++--
 lib/bb/data.py            | 10 +++++++++-
 lib/bb/fetch2/__init__.py |  1 +
 lib/bb/fetch2/gitsm.py    |  5 ++++-
 lib/bb/tests/data.py      | 28 ++++++++++++++++++++++++++++
 lib/bb/tests/fetch.py     | 16 ++++++++--------
 6 files changed, 54 insertions(+), 12 deletions(-)


