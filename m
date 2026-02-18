Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FA3E9A04B
	for <webhook@archiver.kernel.org>; Wed, 18 Feb 2026 13:15:41 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11586.1771420537193365731
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Feb 2026 05:15:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=l4mtCCHN;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 1E5D0C23D89
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 131856074B
	for <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 697F410368B89;
	Wed, 18 Feb 2026 14:15:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771420534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=AISCA1VtZEN6RVxcVXQXUC+z1qH3H6HOsvicjH3NjpM=;
	b=l4mtCCHN75felZDM7GYaxhwRXO9LlxMFnQItFpZj7Ysdu32Ul+GfuFulfOTJ50TnC0WYZO
	HyiLFlyHFVLmFSdi5H0W0vVQ5ue3GBzZr97bm+NftjjVEX8jYnHp/dn1Yd0tp8tol0kSIf
	SXE23lqyT5dmxJSmb5rv3xb3wlGS2LmSlZfvkUpXt7GV5fZjgamf7A0QjEhBPgiQJLfbf3
	eeeqgXUhzV9e+A362kEt2yYzbGyOQF3kGmae/Qdql0PVhowLN2pqbsLW0q8vQ0yJMLpWeb
	sLr1LL5wBT/p0n+6ROcuX9yl1Kk1+/UwpcZ9ljoFglw8slz1S2H/uwxcELi3hg==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v2 0/4] bitbake-setup: Improve readability
Date: Wed, 18 Feb 2026 14:15:25 +0100
Message-Id: <20260218-improve-bbsetup-readability-v2-0-351584e5df9c@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw6CMBAAf4X07Jp2USKe/A/DoS2LrEFK2tJIC
 P8uj7vHSSYzswjkmYK4Z7PwlDiw61fAUyZsq/sXAdcrC5RYSIU58GfwLhEYEyiOA3jStTbccZy
 gaQotiW5EeBVrYfDU8HevP6uDw2jeZOOW3IyWQ3R+2vdJbd5xQvX/lBRIuChLNjeyKEt8GOdix
 /3Zuo+olmX5AUC/ZKnaAAAA
X-Change-ID: 20260123-improve-bbsetup-readability-ff6a0ee8ee25
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=sf7kAvdwOn8Vv9QZfSucJQTWsdFmb+uEl1bs0kVANjA=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBplbt02+2DBVYkNQDwmCx+HADZ4Aiqmph76FqwD
 K2lbN2bKIGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaZW7dAAKCRDRgEFAKaOo
 Nh7jEACQSnmcNqNPoKWmxgPe88rkIoO5tWx0ngToNmedaq+uL24sJZEXhy03+MX8keCInPHZt8h
 Q/trL2Mwo15AemYtByELg4AasaaP1W2TnnznfpgVB49P83yAYcNMNMTPzfSc3Qb1soqCcMI7Er6
 auCakWlHjRnN9OiRczKwQoX/MvLAKWfAfnw8q7twf26ljfHCzx1dJPSyS271Ox0sCa47cFNvWPa
 JCLjBKKC4Z1n1Wd0ljT5AAsTc/82wxXT08j/zJoYKoWI0ha7wOEAv6V1oZs1VLn92mRmww+oG3Z
 BtGJni7o1HYsRYZv0nQdBAxS7FbrYONWN/xKKKOZ90EgShNZ6itGEFoxq/wtZ1VLlwsrMUoeWNN
 M6XVHgON/q7rjM0pj9UZXXcGpEPILAjSzk4W1CkFdAtLR4w0MGmO1ZzQ25dnaqiupFLvvi4YYyX
 bQVTPRrk3a6YoAFhGhsmgv0ptiQhT6Hck519AszLVrKgS/lgPK2zCVSAi0dHtogWnX5XumfDsYF
 s4zb2H4WderscSfIdN+H/E5rOtvyAfoCc3vJ9jFV4mUa1d3X60zTWh2JiGhcum9Flz1p4FnAkSh
 MAbMbO/xjE9/U064PPs00W105YqTLDMgoONjvWKAn+bvMwbmTgfFptRjp6xMNgtl7K1L2oozOyL
 wZvpFb+TNUtURrw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Feb 2026 13:15:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19058

The series is an attempt at improving the readability of some of the
bitbake-setup output on the console, to improve user experience.

Here's a summary of the changes:

- Align outputs of choices in the init command (instead of tabs)
- Print the diffs with color, which makes them much easier to read.

All the coloring can be disabled by passing --color=never.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Drop the --quiet patch
- Define a run_git_diff() helper function used for printing colored
  diffs. Drop get_diff() in favor of it.
- Link to v1: https://patch.msgid.link/20260213-improve-bbsetup-readability-v1-0-41cec3b06992@bootlin.com

---
Antonin Godard (4):
      bitbake-setup: define a color_enabled() helper function
      bitbake-setup: improve readability of choices
      bitbake-setup: print colored diffs
      bitbake-setup: drop get_diff and replace by run_git_diff

 bin/bitbake-setup | 130 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 94 insertions(+), 36 deletions(-)
---
base-commit: 5427500e4f23580962126d2b27ed627ca237fe4a
change-id: 20260123-improve-bbsetup-readability-ff6a0ee8ee25


