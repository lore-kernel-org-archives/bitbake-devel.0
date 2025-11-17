Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F69CEBF91
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 12:52:33 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8390.1763383945025390915
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 04:52:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=mHdHFKK9;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A0369C1264F
	for <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 12:52:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AC99E606B9;
	Mon, 17 Nov 2025 12:52:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0DB4A1037160D;
	Mon, 17 Nov 2025 13:52:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763383942; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=IFYYlAppOZPXUSc3XZCNCWBl7wjndllvVpTQhb47Ae0=;
	b=mHdHFKK9wjAqH9EPgyUC3runwTbHuZDeFbsSRuU5vVP5CdNxhsbYs/GwDIvA2i7cMYypkf
	KzzxPDKmKqdDIbMgXOKwXm76lVgOM40d5X0GcGOv5+nyOqkudA/gYrtp1pgcsBDEGk59YJ
	1Wi6S6GDG1baBY32HBoajl0qbgPAF4BbRi3gb9gQawHlQgbJcJWTlsybLyAZjIUib6ijQG
	52rBizNLXRjzaVT4W00UeDp0fzUxj7RV6gCtnY7QAMGUQQ91U2N+w+Ca60bsc6vjiQIMi8
	nFbnQukpk+MlnLpfkXntGCZEBLlhmei35qs3iEWOpsvOkVNeeSonP4NVVYvrrA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v3 0/2] bitbake-setup: update: add a --update-bb-conf
 option
Date: Mon, 17 Nov 2025 13:52:16 +0100
Message-Id: <20251117-bitbake-setup-conf-updates-v3-0-46cdf826e79c@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIAaG2kC/43NSw7CIBSF4a0YxmKAvh25D+MA6MXiAxqgRNN07
 0Kd6MQ4PMmf78zIg9Pg0X4zIwdRe21NGsV2g+TAzRmw7tNGjLCKUlpioYPgV8AewjRiaY3C09j
 zAB53lEMJirc1B5SA0YHSjxU/nt7bT+ICMmQxF4P2wbrn+h5p7v46ihQT3HWkaou+Tbk4CGvDT
 ZudtHeUryL7xJqfGEsYI11dNECoEvCNLcvyAp9Y3UolAQAA
X-Change-ID: 20251114-bitbake-setup-conf-updates-91ae4efa86ae
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=F5E3HM5nHT8g9RkOTqdq+wgV82GUAc0lzdITJEyxa1Y=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpGxqEqKomvpG0DhH1u7YQbQtUkjwJ2FMBulC1w
 ov0lIkskZ+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRsahAAKCRDRgEFAKaOo
 Ng8iD/oCCK3QS1+IMaCbZD16Ij5djVRikhHfD4gCPoxnxSWNL7mxIcNdkI1BvIXX+LZAhLIU79w
 ajOzsPTTARr4o+7Vr2CAeaoMt+5FgdyhRtaC4knGqkdxSBMxm0D1fokv6p+DlMElZ4tJWNISFQW
 MNmrYlt3Xn70L8Q7GSHNX40bD+LlpTMRbPkoNRSHgfLJGk7kQhqws+5M2oCkIF4QYF24mWY00qm
 3PkvHPLkwnrnWNAMKGCknWcKK2fvbOg27g/S7wiDeN3peB9f7+UZgSVVi4AkiPuaDkIsg7IZaG1
 6nK53/ck271/hNuEQ8+ylixxCFiwOzNE6Ofn7e/cn7fMvROFtMTSEUJoT207v3KNER6sRN1K3C9
 3JD/W34UrsCY5gLJ1e8ynMgsksMyVFMTFZ4xiUqDc2XUMT5eoQ3Y/hYLm+S3PZIp4puf703D60Q
 tOfGnzYIVGZFOZxI0Sfo0ZQsXlgkOc685lVR3pfMCq9csva60bnzLDboayf97eqTsj+gEyDSyTY
 JUBPVISfc60X1MT0UW36/ADd6cqVTnjdPMygS5Cw6CZoZQSgeeiZ6Ypmjoqv1PeXfJxWm3rHKCh
 MiMjtSXaZcWtXzNCthYG6MpaSS+AFM7LUK2dFTfkIp/LsrS8lMlygnUi0EisauqQTSfGIbVc8xB
 HbgPDllEnIiF58g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 12:52:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18427

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v3:
- bitbake-setup:
  - Change the conf diff logic as suggested by Alex.
  - Use args in build_status() to get update_bb_conf.
  - Use get_diff() instead of git diff in _setup_bitbake_build()
- test:
  - Use hashlib update() instead of file_digest() for
    backwards-compatibility.
  - When computing checkum check that the item returned by glob.glob is
    a file and not a link (previously it would have tried to open a
    directory).
- Link to v2: https://lore.kernel.org/r/20251117-bitbake-setup-conf-updates-v2-0-209637e01fbe@bootlin.com

Changes in v2:
- As suggested by Alex, Rework the logic to apply upstream configuration
  changes first, then print the diff and ask the user whether to apply
  or not (default behavior).
- Behavior can still be overridden with --update-bb-conf='yes/no/prompt'
- Link to v1: https://lore.kernel.org/r/20251114-bitbake-setup-conf-updates-v1-0-990583d8251b@bootlin.com

---
Antonin Godard (2):
      bitbake-setup: update: add a --update-bb-conf option
      bitbake-selftest: setup: add test for --update-bb-conf=no

 bin/bitbake-setup                                  | 58 ++++++++++++++++------
 .../bitbake-user-manual-environment-setup.rst      |  8 +++
 lib/bb/tests/setup.py                              | 41 +++++++++++++--
 3 files changed, 89 insertions(+), 18 deletions(-)
---
base-commit: ae9a70c919f14ca323eb7c03ef9080fd0bd52c29
change-id: 20251114-bitbake-setup-conf-updates-91ae4efa86ae


