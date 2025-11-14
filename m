Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F4FCE7AB2
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:07:58 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15474.1763118471396080681
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 03:07:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=O7HDUVt1;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2FA7EC10F5E
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC3656060E
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A19F102F292F;
	Fri, 14 Nov 2025 12:07:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763118468; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7riTTX4QaM6XYuvKTGSD6l0i8JDth6IFuQHQgWdRPPE=;
	b=O7HDUVt1drHZGs9uWH6X6P0GK6NRvjE3bA3h9Fy6nq/ZHznA73ny6+voi7o3zNIAGzEKK7
	AO+q8PA2MVnHd7cAhDJiQ3pPdG42/SVN2onub4EI9lwEjEg0fVEH1Ccsa/3zxUOD14M69R
	fm1Q7lupqwOskw1MaapgaN2KatdjtBo/h/PWSJc/eJ9HYcpE+N6hl9Dn/PWKmZUNdJJM0o
	h76gyuT22GmTLOJNteh0w0wvp1yC0qbBbytSgp0l2e9piFJqqy3KAtRubKr9IB4fW84Laz
	OLl8cr3pd8JPm5+8ECKNbiIJvfDS4sp4cewzNFabHoLxezV0a37ar2vYP0cq4Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/3] bitbake-setup init improvements
Date: Fri, 14 Nov 2025 12:07:31 +0100
Message-Id: <20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHMNF2kC/yXMQQ6CMBBG4auQWTsJpZCAVzEupvVXBhMgnWJMC
 He36vJbvLeTISmMztVOCS81XeYCd6oojjI/wHorpqZuOudcy0FzkCfYkLeVJSwpcy+d9z7W7QC
 hUq4Jd33/rpfr37aFCTF/V3QcH3FtjuV3AAAA
X-Change-ID: 20251114-bitbake-setup-abort-8a5333c049ea
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=657;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=bM0fbvQi16t9dPbj2D2RnQ/W5elqaK3SHeokfuJLRuM=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpFw2COCcSn080aXtiMHjgCuQzzOESUA9jTn2Ow
 pHEVvzPb1yJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRcNggAKCRDRgEFAKaOo
 NjfEEACk970jThMFePqd0nVYmD3TrxZmi3qQB3u/LGV38OKvBW/3KHQfst9oNbF2u7OG+DyMYO0
 6Ou5IbDUMLbgGuXAk/kD1lWxxIjt5WZbntRvNswmCO9uuMIyew8lWnOZD+wGd/68dd6RgZdsrKW
 R38UGmZIEvPLCU8fth2yVpkuX/92w2QH6deIXIx70xAgQPOEs90u74q2yDC7K1l1OiL5TvtbTMU
 omWZnLN5GqeFjkw//fe7ReE5+tpURwHkstbFyCEZ/SUyZrXDeZFX1X4RWVhSgOOVw/YizsYp0HR
 RNNM8+/BzRNAUlCAWvltrkg1AqZScjF84u5hrYjakyX5Hc7zW59JHQM/5buCCtg9xqiXwi4vvNv
 Kznt2hzsZt1k4K/RPqMRxdaX3bUnbdyXcdr99Wm/gWayrWZObcC7rsDIjTz2v2UZJV8tBw+5I/J
 a0a+cMlpBfgd8YbBRGmX9/l3zpwjlTXjZRZVqiPiS0H/Z1h4cTPPc0DBFj+Sa4FFnR1zLH9IUoo
 N7ev/YxYw/x64Y17vygVyWOVtm/gf7l4KnNVgoGnNA9t3l2d1yBAAgrkcudE0q6Aq/BX+e26pQr
 RmVpZ4DsCTR7NQBwSQ+zswYiJIRTeNwkDHyiY4phdPUNtGXabiFk9EY2rum3806mimOTKDnoZEI
 dUwmNGpULhtyL9g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 11:07:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18390

Improve the init user experience by:

- Creating the top directory only when we need it (and avoid leaving
  empty directories behind)
- Print a message when a user stops the init with Ctrl+C

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (3):
      bitbake-setup: fix top_dir creation in create_siteconf
      bitbake-setup: create top-dir later in init
      bitbake-setup: handle ctrl+c in init

 bin/bitbake-setup | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)
---
base-commit: 363e0d34b1cd03d27d1674f9c08da819dfe32dfa
change-id: 20251114-bitbake-setup-abort-8a5333c049ea


