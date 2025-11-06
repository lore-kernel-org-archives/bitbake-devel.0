Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B03ECCFA19
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 09:23:46 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10819.1762421019564871581
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 01:23:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ETsT/0Rw;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C38341A18EF
	for <bitbake-devel@lists.openembedded.org>; Thu,  6 Nov 2025 09:23:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 958646068C;
	Thu,  6 Nov 2025 09:23:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1A71C118502E8;
	Thu,  6 Nov 2025 10:23:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762421017; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=tIxzznvcC10XJOGjsvpgg2eMZk3k59C6YCAQQMh+24I=;
	b=ETsT/0RwUi7/lryn/YESzeF+BISitCQ05Xs+AbupWqI/xwijwzs38jD+OBSvJPFI6qbZHP
	8UOCTA+vW/or8LzL35cdatOtgm+n6ARkLTJjaG7GFJIf/CdG5UxEYDDaZTRralE253SoKB
	AOrbXOv+IsmSOzKVOmEr7xLVJsX6kyuRYRlxI9cIhP2JiujdhMFe1xOaIlG05qkVRWVyPx
	Y3Gzq0Art6E4Ccr7eVZdvmSnbL2ZnNbDFhKYx2thJUsgXtHktnZxpKUT7RBu/Wd34HvCMi
	N99tw4Z7FOWBA6F5mQXNBpHet7YWISOg4/An548Zbw8xkedfaVScitISTLBpdA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v2 0/2] Add bitbake-setup documentation
Date: Thu, 06 Nov 2025 10:23:29 +0100
Message-Id: <20251106-bitbake-setup-v2-0-2722ef759c35@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABFpDGkC/13NQQ6CMBCF4auQWVtDiwi48h6GRaeMMiqUtIVoC
 He3wM7ln7z5ZgZPjsnDJZnB0cSebR9DHRIwre4fJLiJDSpVuUwzKZAD6hcJT2EcBGGJutIVNYW
 BeDM4uvNn82713n7EJ5mwIuuiZR+s+24PJ7nudjvif/YkRSrOWa4LU6pKn/CK1oY390djO6iXZ
 fkB9qvPWb4AAAA=
X-Change-ID: 20251031-bitbake-setup-eb8ba9a9ed7c
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=uQ21UW6gkS+0I5HQiUh2sfstQ1A+I5/n8SVYPi36+oM=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpDGkX0kDxY1uhIBqLzGl3HtfzVqwBeOADHFKtZ
 R0T7eOLwSeJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaQxpFwAKCRDRgEFAKaOo
 Nqr7D/4vIvcLdHnj5iNaDoq/P7M10f6OaKN2Mug1WshDf4P1Te3U0GJ4CiZ7RU4yBkJ1fRx/jH3
 QoV1ZrIS75cMRCWiM9dFBHFjl3z3REVn9fWZfFDt/DJPgHAHSnQ5R/kYWsRsKZkQfR/E5u+Z1IH
 duk3S5oA5oI471mohsVRWUuZDV8deZoBLiB2XpFXi6u01D5IrEATprDlzOlAD4w2Rx7Xv2PXkna
 R1OJPaighP+8IZv4ohXSyUReRYzhIygqvFRGaGB4LVTB/g/QKOvlBMtECqn2PjLskoLIk2X2pdy
 BwPxvcVsadk/ImX15sh03dCTI/H02xxOVUMc43x+I49/s89OeAcES7wcR0OIt3WvP9SSk699QrM
 B1uXvLeadjtLMsLeIy1zRoC51SIiahkEZyKw2sIYCF7in7dt8LzXPqs2x2+UO8UJX8TMdzv8Nx3
 sFe6ANaQhk9YHs9JTaSqfw0EvncgsCr3Zx4Dx1eTf6M2/ELXJzUm7+cpuG58muExsNwye/EADfT
 fooBcp4F4nHztTZtz54dCrTd0s4hyzraFwF/9Amtw4XPJl0UZ6NikMyTeKmf0IwHhJYNhkh4OIs
 mHjCdXfLaKQk7AEaJTf+7qraEWPaqLZYC+pF8t/QcOhXUDW56Xwu/pp5g3IR+j0lTzCpHZdJS5T
 QifSW/11xpso70Q==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 09:23:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18282

Add the reference documentation for bitbake-setup, in a new
bitbake-user-manual-environment-setup.rst document.

Depends on https://lists.openembedded.org/g/bitbake-devel/message/18237.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Apply suggestions/corrections from Alex and Johannes (thanks!)
- Add missing 'expires' generic config.
- Add the doc for {THISDIR}
- Reorganize the terminology a bit. Start from the directories, unroll
  the terminology from there.
- Add definition for the Specific Configuration.
- Link to v1: https://lore.kernel.org/r/20251103-bitbake-setup-v1-0-635a7c829a4b@bootlin.com

---
Antonin Godard (2):
      doc/conf.py: add wikipedia extlink
      Add bitbake-setup documentation

 .../bitbake-user-manual-environment-setup.rst      | 802 +++++++++++++++++++++
 doc/conf.py                                        |   1 +
 doc/index.rst                                      |   1 +
 3 files changed, 804 insertions(+)
---
base-commit: 22b3fd418efc10da7e4a8c1725de285714d2396b
change-id: 20251031-bitbake-setup-eb8ba9a9ed7c

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


