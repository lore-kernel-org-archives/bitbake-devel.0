Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570ECCCFA09
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 16:31:24 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1687.1762187475951373011
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Nov 2025 08:31:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=hIMxqaCY;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A63E8C0D7B6;
	Mon,  3 Nov 2025 16:30:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 77A3C60628;
	Mon,  3 Nov 2025 16:31:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 04C2B10B5016D;
	Mon,  3 Nov 2025 17:31:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762187474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QoKhX4bzSqoqELSu7lyw4P3R9F228/T6JuVFQrTM+a0=;
	b=hIMxqaCYdwMxhykKxfT3/vGeqA3Vf+SIYfe5vxeTIU4FcL85NEj2dt6veYtVMdHhRrlDw7
	Qpi/Yjyrqc3kEN8+OhENEYVoOarO4aRs0zlGyyCMKUWpi66WYLmCvngPlDuNHKy516eNFO
	WZPCycqY4n5lUMonfO6iRDiP5LoUvFLHqqB/5yfry3QuxE4vO+Ib7qyiKhm72E6LGvEIF+
	ynsscjykmGV6m4StQB3X0sIAq8IADxPjkWcmLxRNNiWGkB9YjKtDMgag95+bFuKMRZcZ+A
	cL/o5ZhycUEEiw8P3nTdiRmE6qivLrLF4ZJ8bZGYJWA7meAnH7VjGCVSbgtnbw==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/2] Add bitbake-setup documentation
Date: Mon, 03 Nov 2025 17:29:48 +0100
Message-Id: <20251103-bitbake-setup-v1-0-635a7c829a4b@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHzYCGkC/yXMQQqDMBBG4avIrA0YRdRepXSRib/tWLCSiSKId
 zfV5bd4bydFECg9sp0CVlH5TQk2z8h/3PSGkT6ZyqKsbVFZwxLZfWEUcZkNuGXXuQ594yk1c8A
 g2/V7vm7rwiN8/E/oOE5NKWsfcQAAAA==
X-Change-ID: 20251031-bitbake-setup-eb8ba9a9ed7c
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=777;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=xm439Y4s4WEkO8etZFGcG6VBI+XsPr+Gk9Zzcy9PJwo=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpCNjQJIZQzf0XgUIRMkpEkxgI+x4O9Azb0pqOO
 mNDtCEEgauJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaQjY0AAKCRDRgEFAKaOo
 NqFJEADJifbeGNEc7PCBSto6tEPlFohGuiM00DchKlG2+ljeB+I+Fgj9b+HGZtAhoXY6xbsIiG2
 KBOCR+PWL894zV/S8TXeNJoUoJZwhJ1AoaWYSLBJWsaKUlzxaAlmYFRSP1TumW1uOjycI0EBdcf
 KVbH6ZSHu8T28rpkOb9Nql5h5wIcWGQEYJLUZwDOsq3YY2xGlujYWi4Hd4doZ8Y5wipayjvmIyq
 XfCAajo05Qred0H8fq+IhVS7PjVqA24rw6U3YxlfwoinJWUYfSoHXheb2wFm+p1VSfGFywFIU98
 eFIauF1kiazG6L6juiDR8yzKZr8FnVD9YkKhdy7OPSOZJmszqvX3ZUegFWWs08vq+/6CfRUZzbo
 iAoAIo6wmmKe9UhWJfr9wFeO+62MZ+p036d8yN7kpSZVyGlVpSCxO9M7qfAVVkAWckCsqQqmmah
 tuLeIxuBRx7Cb3fOK1lNUAyG0kWV6+Suwvfmh7/yeINKdwWT4nui5sRFK3Xx8XXAwzuzpPEYNl9
 ruUkhkR9UJgZbZ6znvHdP0dVspGCFJjbSfcTZBSnRjwVU9mziJvjkTgocJttOwhB+hddmHUnyS8
 cqiLcxfJRZXd7hk8+iuOsad7r68kL1p8qjyk7FHyAtlY7/yYTvEJfHPLjXcRfq6p0euStr1XZzq
 5iXTV6b7xqyJp4g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 16:31:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18241

Add the reference documentation for bitbake-setup, in a new
bitbake-user-manual-environment-setup.rst document.

Depends on https://lists.openembedded.org/g/bitbake-devel/message/18237.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      doc/conf.py: add wikipedia extlink
      Add bitbake-setup documentation

 .../bitbake-user-manual-environment-setup.rst      | 672 +++++++++++++++++++++
 doc/conf.py                                        |   1 +
 doc/index.rst                                      |   1 +
 3 files changed, 674 insertions(+)
---
base-commit: 35a421cdcafb3595b9de5489ffdc567825400d26
change-id: 20251031-bitbake-setup-eb8ba9a9ed7c

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


