Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A22EC88E4D
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 21:47:48 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50430.1789163258395922848
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Sep 2026 14:47:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=I5jIj+US;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49cf4f81d86so10709265e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 14:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789163256; x=1789768056; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6zZGMVPIWlZkImJpLRA0CzIjipfHxJgTPAhkCa42yp4=;
        b=I5jIj+USwwNGwrKTbQvsOzlrc7bqbsvhuoCq71RPT7YxghAkYEE2lp4m1YY8RDIA5l
         ooohJygcGDo7Jq3T0Rpe8/7baZeK6UUwSYMz1gtSPz/EUOJAVHsTXsfPIvHJ6ZTvn4Gl
         K6HMKOLM2aqKV7EJodw4G4gTrbdct5A6c6kSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789163256; x=1789768056;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6zZGMVPIWlZkImJpLRA0CzIjipfHxJgTPAhkCa42yp4=;
        b=IHn/40QheCIv6pUYGSm5nfjI/ozMxEWCuU1Z64N4xiULhim+g5XFklEIaoI7Va/XUX
         RkD+iUAsYb+41T/HJRzNErFYsHqU2OgdzxLR73BpzkzzyNJnhwMfWu4kb/a2UR2NvM0U
         JpF+FTx6g2iyOhgxGgTjB517tIk1BR12TP6kzB9cC52nC2CJiis1kAGVfTfZhaKqbelO
         lyYNGZbLrLedIfyb3/V4F6SPEFoBh3x1jS6MkdYVxcJdN2xC9fc571h23ptI1nOXv3U6
         i0Rr7m981xPbNwo+wQKEQGu9SJycG41wP7aAilcPd8mn+dFO4v5tIpW/r5TR2/5wKdrE
         gRiA==
X-Gm-Message-State: AFuF++nMent8Pw+1SNzmk+0jTuxA5b5eciS/NeDWUIgkJvb+phC2lhYe
	UOvbwspBvj9BBOeSw7Gtj3J5EZZEsrNoZ0ikgYEYn1VpVkE47OsfEOM8rICNsh26H0uyatmrhSU
	5pbbf0jI=
X-Gm-Gg: AYBFou2Ihz95DEHKVQ6AMeBzTsCjOMaEkc2dUwFvo6HWgYFrcHQqNC9Cmj3a3JslOVL
	QIamQzLaj72hpDYH4YCBdRR0auIAjQOHYTX2lNJx2KEAqyZJNlJC/74VCsCa8AxjU5zo47WjQ8R
	3jGuVoAmJxjkIYOSNc0CSxGYGmTiKtwG3aU8q755t6z0vvw42QojA+JkY/JRfUSuoWQDKnscRZK
	t+rrCxZLWSph0yXvN1Qmu80OZDMxBdhua10ktVx25uKjZUipD7R3FGlDb+09Ve0L2MhFfMBapqc
	GIZ5H8vagORCxiTbeBT8Cs7NRrTcdDO8Bq5L9bDSQMrutFoOOrRGI2Gl1/oQ7srI1JaiCIemwFN
	2qihDxGp7C2oSfIvxG9+B96cbM+WU2Y+RWbtYjfzG0DIELrwwMoI17WzN2IP3bbiL+a4KTUMtBD
	fUcRE/NY2D+P1ngPI0cGB18rNsDQC0G4uUyXeUqeTEv8bKOswxtg/62C1EusotjYf+KaBe7OjQ4
	6aipSGr7KIO1qnrkPN2pVH3Dl/B2q1UInvt0lISTHBdYdfBeKpEwDWmY0DwT3zGZz7LjU4mTB0=
X-Received: by 2002:a05:600c:8b5b:b0:49c:fc6c:be1b with SMTP id 5b1f17b1804b1-49e619d5301mr78821065e9.33.1789163256601;
        Fri, 11 Sep 2026 14:47:36 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e62f58e74sm16157475e9.1.2026.09.11.14.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 14:47:36 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 0/4] Pull request (cover letter only)
Date: Fri, 11 Sep 2026 23:47:28 +0200
Message-ID: <cover.1789163101.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 21:47:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20182

Those are the patches from the last patch review:
https://lore.kernel.org/all/cover.1788939009.git.yoann.congal@smile.fr/
(No review, no changes)

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4704
5 builds failed due to 16421 – AB-INT: SSL UNEXPECTED_EOF_WHILE_READING errors
The builds are fine now:
* oe-selftest-fedora https://autobuilder.yoctoproject.org/valkyrie/?#/builders/48/builds/4646
* qemuarm64 https://autobuilder.yoctoproject.org/valkyrie/?#/builders/36/builds/4628
* oe-selftest-debian https://autobuilder.yoctoproject.org/valkyrie/?#/builders/35/builds/4839
* oe-selftest-armhost https://autobuilder.yoctoproject.org/valkyrie/?#/builders/23/builds/4874
* qemuarm https://autobuilder.yoctoproject.org/valkyrie/?#/builders/16/builds/4664

The following changes since commit 0ad6c1c34a5e07a5f8dd66ab248c1e7b37b69fa9:

  doc: bitbake-user-manual-environment-setup: use pip to install bitbake-setup (2026-08-20 11:15:51 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-next

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


