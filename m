Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2344EE3686
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 13:53:34 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45376.1770904407491042217
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Feb 2026 05:53:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=b5skpBsj;
 spf=pass (domain: smile.fr, ip: 209.85.221.45, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-436317c80f7so1304637f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Feb 2026 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1770904405; x=1771509205; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YklQzU8w+V/eLVm0NnzDIznjaKHhxGXKSM2chG4+oGg=;
        b=b5skpBsjI3ae5RMAWrN+k2UXlCBs1MflQmAFX7WCbWlFvBF1JTZtZL2fd0fyMAaMlk
         In+wkNIgz/ieOQxHqpJYP/S1UwmBmM/RwrTa4/mQYXJgFc/FiSpu54HAR3PhUpT2/p8S
         GbQYS2M5HERXtkC+XhtkDjzD2M4kMUe4TFD6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770904405; x=1771509205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YklQzU8w+V/eLVm0NnzDIznjaKHhxGXKSM2chG4+oGg=;
        b=XOYZdgVM8xVvdnm01AqCTALcyK+c+kEGeRya3exo4D4z/WfUHpTNv99RYVy3bMDl9H
         9HdogzziEd/4s3yW3AqFw0lavYxLy00QM+qrPIVgMuutl7x9IfFFISzIej3SpbMhCjAZ
         VAopoTO0MmQFQohQzogvuWl7xHWO0Qe3KvumN1caXsujQeuR6T5bta3l1A7T6DQRBv7S
         3oWwazoZoygdVAW47pIdQWJBra4R1s5omKaUrmmUAy+hC45O+trLb7EAogmxUToIf7OF
         6i7pp2aVaZw/pmvYrcQIHh1ZkH7H+uSgf5XiCxtdirW8vFpbHLuHKBqCai2HFYbfxKYJ
         63YA==
X-Gm-Message-State: AOJu0YwoD4UmA5VAeRgsWlG+VP1ttRELd1si1i4/InYdcY6jipU9UWxc
	5Pf1cvBm6zpACURUmWrML2lzROjJycw2KD6K6dahy9x4QxTOtR30SKFu1h5/mTxMtt8HTAyGeae
	ChLPX
X-Gm-Gg: AZuq6aKs94TazMGZ7yhOrVViqQxw1Vt6D3MJAmajoKOR4Y3sDmsczgYjL7cchGZFsO7
	cx5qFrQXBUHY9ejRh4XO2s3DHFc1CuLO3O+jc/52+BfgxuWnrMj/Do5M0eS1xV2EToWGlj7shs/
	MIZTD44cpqpA+CKQAziDcDR+vR2cG4jkEJnZ9/iYhsXPBNpSwyFjJaLUf0mYfWn4mK2SMd21TIp
	oSoT+GwRE2m0BLINhGzB5uLX+1znICcFQsmcB6pZnKrxh0OdEiAb6JO5Jcwj3t0oFPKSWuSud26
	Cp19iUG4QkxgZyxkDGIkW+I3337E2hY8e2WAOoROa55XZSYHYfsNS62ZjBgaYOCdx7o8TQekbJG
	qN7YYcWj9y7rxKs3Er7X5hqC5rEBD5Y9pcFye/kYUsNIBKphduFfzErPSWTmqj3vEcc+Jmiijjh
	ZUPHaKeMeMzwQKxGUZMJsnvNGpydI25aoNjPCJ7oJoVbjNCWZl8qFwaZcJ0FH9FETErZWP+UIOL
	tZ9icdzhk9hPcH8HefNZUGd0Ek=
X-Received: by 2002:a05:6000:2484:b0:437:678b:83cd with SMTP id ffacd0b85a97d-4378e723665mr4723049f8f.15.1770904405491;
        Thu, 12 Feb 2026 05:53:25 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa0091410e731fc6f0fa.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:9141:e73:1fc6:f0fa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d50f3asm12817190f8f.13.2026.02.12.05.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 05:53:25 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Paul Barker <paul@pbarker.dev>
Subject: [bitbake][scarthgap][2.8][PATCH 0/2] Pull request (cover letter only)
Date: Thu, 12 Feb 2026 14:52:58 +0100
Message-ID: <cover.1770903920.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Feb 2026 13:53:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19020

Those are the patches from the last patch review:
https://lore.kernel.org/bitbake-devel/cover.1770629479.git.yoann.congal@smile.fr/T/#t

Passed a-full on autobuilder (with AB-INT):
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3195
* The build qemuarm-oecore failed:
  https://autobuilder.yoctoproject.org/valkyrie/#/builders/40/builds/3140
  This was caused by bug #16143 – AB-INT: do_image_wic: tar command return exit status 2
* The build qemuarm-oecore was succesfully retried:
  https://autobuilder.yoctoproject.org/valkyrie/?#/builders/40/builds/3143

The following changes since commit 8dcf084522b9c66a6639b5f117f554fde9b6b45a:

  fetch2/wget: Keep query parameters in URL during checkstatus (2025-11-12 15:53:31 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

for you to fetch changes up to 1b923cdd50449aaa41152b72eac8669f27ec7ec2:

  knotty: Make sure getTerminalColumns() returns two integers (2026-02-09 01:22:13 +0100)

----------------------------------------------------------------

Enrico Scholz (1):
  knotty: fix TIOCGWINSZ call for Python 3.14 and later

Zoltan Boszormenyi (1):
  knotty: Make sure getTerminalColumns() returns two integers

 lib/bb/ui/knotty.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


