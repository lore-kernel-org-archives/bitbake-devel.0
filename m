Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4A4D2ED12
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 11:51:54 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4502.1768909909153186962
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 03:51:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=0W0c+CDY;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801bbbdb4aso26909855e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 03:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1768909907; x=1769514707; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IY6iWV1PlQ0rYMsMHdPg+3iU8o9EGnRRQbVclFiQUfs=;
        b=0W0c+CDYMmJ54sbBqW7mO2jexqllPDXDZnp/vVKU3TgjbOB1MrMaZDEQLxaY+BnQUi
         zVU5PidieDnw6Jq4H66REdMhNum0mrKVILR9k4m8J/utx8xdpVOdss8LbMWVjE/JG0eM
         SfZodu+T4d9emmz1iHoTs1dOyYNacjvtdZO4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909907; x=1769514707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IY6iWV1PlQ0rYMsMHdPg+3iU8o9EGnRRQbVclFiQUfs=;
        b=BlE4awJmqnpbbHeZGgHLzlzPuVcaUg1LA7wetrEkkvF6UIIkQ5K/jO7taZ8F4vGRru
         xDLqKVBxPm81KKkAAJCyaVOJ3eaV3Hy5/TbwXN1hEaHTeqXwUbEP7V/U1mUv84yf4rLb
         tQExyyimaLHsrDX7hlPqpLh0xtRoncLTpx1o0m1QnngherVI+MCQgesDoVkdFW9OWexE
         xNap5lyYTRAWeFya9Z9CpiTxmBMGG/QuPR8Rqpg6EpLYXIS4HCmpQO5SUomM9MWm0oDA
         GOrTfsenWfOlFvyvWMMbVcSjgB1oETQDy3gnHMPA5wJBlbUZi2a9yVHBCIRSYuMLxmgo
         36Gw==
X-Gm-Message-State: AOJu0YyLrjTgw/yQivjkAZ/GWvM5kMZCmjlQ8qnrFAvrT6vA6Q0TeF+Q
	dcPHGF2CF2G0j5GEtElwpW7SYseO/BxkK82DF6sEHa9cAHM4plA8ZOLe4CZ+7S9tJneTEpPz0MA
	h5Ggy
X-Gm-Gg: AY/fxX4F7pc603oIoWiNKW1IMsI8icDpp3xNnnlxgJ2lkoCuLmiZ0OGtblSLIP5vvux
	8G5FLNBJqb34WNkTcmNJIPU2GTPsia8MX27cS0CfST25isCwMACwjBA1rnmXowNPbhGW2nM00Ps
	22rX98hsVJv7S761ERSITFYs3olw5X0MA8orBRCeTMLZebgAgVfjd0ihUynpyAheuR1LloMs1a7
	DgpvUrdSx9al5OVLx1ndymiZSq4wvaE84PsosinxGTl4ysUrMg6dJsHDfJ298Rl5ASU4jG+ussf
	5HTLJVAh86Pf1eEGcOvnV54Tkme9m31CNe+opv2c/dL1toCfXGdUhFReL5ytIqZnOF8YM0dJzUl
	CquVLBcbthAEgnmpj8W5uPyj1QkGMI+jdsDnYLCPzVFmxylvhL+niRr3Rkde0Vmwo5r5nbhBJ8L
	w0EJd29UeN3gpOQfSXAuk/7QZp1s3NyNhmk9ivnNHfmbvtgZH9dqK/fRaUwFkJJMPwFhRd3m0co
	pT9zti3hRDjCLzbBr871Q==
X-Received: by 2002:a05:600c:3e08:b0:480:1c1c:47d6 with SMTP id 5b1f17b1804b1-4801e53c069mr173698565e9.6.1768909907093;
        Tue, 20 Jan 2026 03:51:47 -0800 (PST)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c197sm246193565e9.1.2026.01.20.03.51.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:51:46 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][whinlatter][2.16][PATCH 0/1] Patch review
Date: Tue, 20 Jan 2026 12:51:24 +0100
Message-ID: <cover.1768909613.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 11:51:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18814

Please review this set of changes for 2.16 and have comments back by
end of day Thursday, January 22.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3092

The following changes since commit 663021740bc086bd959a8457ad9ddb6da52a8278:

  bin: Hide os.fork() deprecation warning in all bitbake scripts (2026-01-12 09:17:16 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.16-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.16-nut

for you to fetch changes up to 74f8a927ca6a20342072e5579182aea917b6dc30:

  bitbake-setup: ensure paths with timestamps in them are unique (2026-01-17 23:15:33 +0100)

----------------------------------------------------------------

Alexander Kanavin (1):
  bitbake-setup: ensure paths with timestamps in them are unique

 bin/bitbake-setup | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)


