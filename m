Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E97D64096
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 08:48:45 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10416.1765961321103923406
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Dec 2025 00:48:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=rBXe5SCS;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F117A4E41C53
	for <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 08:48:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B8FD26072F
	for <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 08:48:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 235F01195033E;
	Wed, 17 Dec 2025 09:48:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765961314; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=OrQsnTiN9baRtcdLg3mKF5rYbs8i/4xdofg5r/gXwrs=;
	b=rBXe5SCSuR9SgvJjMLUY/MIankvecRem2hxa/yvW5c1ozmL1/qX6uAs6ZFthjauP3T5r62
	lkM1EI4O3fgSIgwh3EFWVumT+OucVuzTbLoflE+79vI1+wO3JXXZa5MiQnTQwLB1pwXNmw
	SYOtTZquZYErODgUecAE2bEbgh5xLs//l4CQ0H/5RRNGJj82iqDbz2RwtgUUpWKoG68DZv
	tf7Fo7lCOLuFIYJ+0+hydCi/AxxCGbvEUYgHaaWvFGMULOAKFINujMUN5P0Tn+IHpKSj4f
	IpgP8iDRaVwp/VpnGT8WIp/YKeQvHFqj9SDdmdCv+hKiVV9jJbWaJEQr3Sl77w==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/2] bitbake-setup: convert print calls to logger
Date: Wed, 17 Dec 2025 09:48:25 +0100
Message-Id: <20251217-bbsetup-logger-v1-0-6bc7d02c11c6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFluQmkC/yXMTQ5AMBBA4avIrDVpG/9XEQutUSOCdBCJuLti+
 S3eu4DREzJU0QUeD2Ja5gAVR2CHdnYoqAsGLXWqtMqFMYzbvoppcQ69KIwsi0QmmW0lhGj12NP
 5DevmN+9mRLu9F7jvB3WA5G5yAAAA
X-Change-ID: 20251217-bbsetup-logger-8b0984046ca0
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=440;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=B3QtXL1NyFPtMIsauEYKmrMPoH11XWTwtp/Tga64PE8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpQm5gAgKrtVzJ/1QLL0q/3cFhP0sZ4SF/Z2lIf
 jCEpqwnfNaJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaUJuYAAKCRDRgEFAKaOo
 Nv96EACj2pcIiJch3SYfdhxV944HUJmbWADn16YhzpgXccQumfodbCxoc+11WVcPuZdgA1EijRa
 nru38rVYrnNrkyY496mMZYDpiO+ako32pwcKW5TrzrngEgs2f6TW3e8w8a4/xLx0D2++nU0Hx09
 yvXIWEzdcPMo/NO0YxncE/Trxf0YqXJRJQv7xUB6cEJJCC3xhuycEIGKqfdoN6ytyfQNVgUQ0b+
 iZY2UAitFf2OLp6J4etgfRTYepWpZYesUlj7Z7IORut+RsLd178cuaAQoiGz9EGxvXTZWi7oQhF
 VN0f/3SohJvR6Iy4db7gYurZKDZHmyjGTZcj8amQZtwUHs4Dbc79u6redQgvwD15UEsf0wulJRK
 EQr9OLX3AduERu+XYlvfCbVaH+QeZ1SCz+++ndguoyHzhiGKo/KgBBSS1L/5cjx0NcZ6Muc5oo1
 hbC1pd2pSjpYfl1mvJGz3xVziWP9DPu8zDkLwY+1f61d7uTidzXogGQpREmtdK7lbFthAzn4WHc
 vMkrok8jXEhPj1ET9YI2ZkMep5q8RRLF/gXx0YeYEDJhWvGRogF3Zgc+zlqdt82BEVqAtVorUTX
 xRXC1vUfF1BPJE6rgE2QkGi1GFYQzu5f0lGsCJOyR9B1z0i7oBjeKt0tDvDV5wYZnHBcF83tgml
 d4zoKtQXzcK3vQQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 08:48:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18603

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      bitbake-setup: remove logging stream configuration
      bitbake-setup: convert print calls to logger

 bin/bitbake-setup | 155 +++++++++++++++++++++++++++---------------------------
 1 file changed, 78 insertions(+), 77 deletions(-)
---
base-commit: 0dde1a3ff852be057be40d17f233ecca19e7b389
change-id: 20251217-bbsetup-logger-8b0984046ca0


