Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D819EDF169
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 13:50:53 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.71816.1770990650719112334
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 13 Feb 2026 05:50:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=TIBIWzYc;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 917BFC237F8
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B369C606BE
	for <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE82510368E25;
	Fri, 13 Feb 2026 14:50:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770990647; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vZ6GcNVuXhxGT8/60+8toOeN3d96+AO54VZckLOyXOw=;
	b=TIBIWzYc37kdGBtPgZlJ9q0Zvtc4nMJDiY4IxWcp7sm38pnZqbGlAFjZ4sPANpiUewYUCy
	wIxX1ctXmiHtP85Vii4ph2hikML0NRtug77Gxc4fxHdFYYlZkOaNxb039yxbVzbV0oc3kz
	x2IkBnLUluV+qq7vDU8sDeJlijmckqZbBm7FMVvgXYbo5Obtlxon0QOvflBfLUorXcmwzJ
	SAd5I2j0mq7VIycb04jZFgi7gyGwcwMogEeR3xzVf9ikVBe4jeUjofkCWqi6YcKnW7VAQD
	tDkw0C46Dk0cFekbVcC3PjatNe4H9v1bg7lPS7kQOWGDHiY7gl9ORrn3S6AKjg==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/4] bitbake-setup: Improve readability
Date: Fri, 13 Feb 2026 14:50:38 +0100
Message-Id: <20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBAF0KuUWTuQRiziVcRF0v7oiLZhJi1K6
 d2Nunybt5JBBUanZiXFIibTWNHuGupvYbyCZagm73znWr9neWadFnCMhjJnVoQhRHlIeXNKXXD
 AEfAHqkNWJHn99vPlb5vjHX35lrRtHxTGkYx/AAAA
X-Change-ID: 20260123-improve-bbsetup-readability-ff6a0ee8ee25
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=BT2UT50LgtxYUE7ph6PILKfDkfxa6jelzbzqmnl4vQ0=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpjyw1aIn7PPB7ogiqPsNo8hZx0U07cQWjI0oS/
 nUG5kBN+ayJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaY8sNQAKCRDRgEFAKaOo
 NglCEADNiHJvdAwR8fb28xTQYXbf26yZqGrZWEWND5p8Sqjh8RqfmfH1BnCfFpnmoW8acJPH8Og
 i5iGrhWbu4OlfA5h5Oq2PaR3QEejA/F8bEXDoXeKgaFRDoeP5oxecKs2YWVwwFk1thaN7H7u/rI
 DTamXGfMC23HmoO3m5kqkubZKH1idNFjxYEPOM+Pcx5f4iTE0LfvRsYCM+l/mykLspGRV4EaJDr
 l+W7U2Z3KXQJutmYCOFyj3iv4gBEJ42DJWN5/E3A1QN2j50gdOgOdUMGgt9ZARC3bUf7jFe6NG5
 /CegkRSGsnTuKxF8nbAINE35DXz7sRMIQJoOOukjxN/arXoxhrdzJJKzopAG0bVUm6YPqkDIMce
 vkUxlBef6ch9dBR8H2omBiP7OgghYrkOh3rj8d2e2tPrVHIrMi/BEMAHwaKrDEnwDK70phrYGSc
 9+cJ0qBWcPc7RA52ZIQ5rNxTD7Rg62yKDb95dAuiabatxh0DDes0/lE5WASpIrzSLv/C5SuVr7V
 2vVkl1LOd8pe/v0UgjMGVbeoCWXj8sTZA42y+N9VJhgSZouZuJcVsf1+RJIHaPPWX22k1TZvjX3
 43gBkp1JDoLLIcaKH7X7fUzfFOTunoZWFChkzwY+ZxVJe/l4RGclhEna2lX06UGp/wTt/F/wNHO
 pO+7ls8kLKz4N8A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 13 Feb 2026 13:50:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19024

The series is an attempt at improving the readability of some of the
bitbake-setup output on the console, to improve user experience.

Here's a summary of the changes:

- Align outputs of choices in the init command (instead of tabs)
- Keep printing plain messages when passing --quiet (otherwise it makes
  most command unusable)
- Print the diffs with color, which makes them much easier to read.

All the coloring can be disabled by passing --color=never.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (4):
      bitbake-setup: define a global for the color choice
      bitbake-setup: improve readability of choices
      bitbake-setup: print plain messages in quiet mode
      bitbake-setup: print colored diffs

 bin/bitbake-setup | 91 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 27 deletions(-)
---
base-commit: 8b635a400152bb40beaa0d7a47181febb43f5c84
change-id: 20260123-improve-bbsetup-readability-ff6a0ee8ee25


