Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849CCCE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 08:21:21 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5100.1763367676138068184
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 00:21:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=KOpkN/QJ;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0F73B1A1B54;
	Mon, 17 Nov 2025 08:21:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D1FFC606B9;
	Mon, 17 Nov 2025 08:21:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D558C103716CF;
	Mon, 17 Nov 2025 09:21:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763367673; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=QNyXaXAVQPHuAOZnVAI8hV2lfi4U0CfTigAZw3Uv1FY=;
	b=KOpkN/QJOcxjiAc0yMSUoqEzEciSd/2LIC92MIaSV2zHKV/I0+uOt7Qh6S1zXOlp4WtoGl
	NvC63522hdIRLkG/3W170ti8nV0oep8ZVgFVTXgRDVygzm/Tfej/d6xaxsubtyf31fsBAt
	BtO/AMA0KdKzc6q/jU/WTbyTvgduiUFDHgkcT6sr6gr+vvD5l7mTxVyQ6HQwbjKNiEsYrB
	ajEvNvWdPRgG6iQdRS07jX9gvspvh9XDsMCZWDhzuQYzkDfKk+FU4WcTMFfD7dITSFEX7d
	AVl4J42Zvhh3UuUkoIVi0n823Pme2u+jtqtKgrYNvlv9P5XWfE3mrqf+ZUgj/Q==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v2 0/2] bitbake-setup: update: add a --update-bb-conf
 option
Date: Mon, 17 Nov 2025 09:21:07 +0100
Message-Id: <20251117-bitbake-setup-conf-updates-v2-0-209637e01fbe@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPPaGmkC/42NSw6CMBBAr2Jm7RiKYMCV9zAs2jLI+GlJpxAN4
 e4WvIDLl7y8N4NQYBI472YINLGwdwny/Q5sr92NkNvEkGd5qZQq0HA0+kEoFMcBrXcdjkOrIwn
 WSlNBna5OmiAFhkAdv7f4tfmxjOZONq7F1ehZog+f7T6p1ftrNCnMsK6zsjq2VdLNxXgfn+wO1
 r+gWZblC/aHim3YAAAA
X-Change-ID: 20251114-bitbake-setup-conf-updates-91ae4efa86ae
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=978;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Wmj6Boucr+cUvjsf1fOlXfphBuOdoHU0BzsXn9fI6rU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpGtr3KRP8uMtEFVZ2ckDoMOdOBeGF5x7ZBTHEA
 hSZhYz0tlGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRra9wAKCRDRgEFAKaOo
 Nt4QEADMbS2rhBtSFQkYuXx6LcI6+YQjmQRdqYxdf03yQpPxwDK/dCtqWh2pFkRFrXpOu6gRvKe
 X8ibr8t4o1ufC40gYBmJUs8kT6umj4auVZrzo3OpuR6V0Pmy7kT/Ymg1+AoHv+1CRBaS+wjlwCr
 Vqldn+6Qx3RKGyOaTJA267BLWMh128q9m14EMlP9KeZv603gNzvJlXT7ny+iHmIxu0nsW3Zo5Qp
 aVbdhpqj0TevUG0eA1Fm6s9cktzd8emyhYhmVHA+7zmj5xcMjPw7kyOuqtFlkjppgDpMRXvlFCZ
 L13VbkTx3uc5G3EutaRRGqG75q1RGsiLSkF3tJFh3drRO/y2dq/E1GeYqs1qbs7Euxykwrj+HHV
 z6mNvLECcxbmaIgGTMOwT82sJQymNWXm4gIRcJH+nLY/zmbr649JtudppQh1vtNwYuy25tQDenf
 vfdeCocTG0xRM81OcllEcLJ1Aw2wrMyJcGVXUChA22W9+HugeV0X/tWfYHU58Fe9OTR0mmfIoAf
 51o262G7ST+QZ8TkITDLpBsjGu8g6d8H4zrvutgjt50XnMbolj0i4xFXJM4t3jws0QOLcAuYyQJ
 kVwKyqPvaOsx9C8yKPdkGjwEzNmHTx0sZ31FTYco70T83wL/eU0abkFMS+u/VNWT3vRrCWDg84n
 I9K32mY8E83y80A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:21:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18419

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
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

 bin/bitbake-setup                                  | 98 ++++++++++++++--------
 .../bitbake-user-manual-environment-setup.rst      |  8 ++
 lib/bb/tests/setup.py                              | 40 ++++++++-
 3 files changed, 108 insertions(+), 38 deletions(-)
---
base-commit: ae9a70c919f14ca323eb7c03ef9080fd0bd52c29
change-id: 20251114-bitbake-setup-conf-updates-91ae4efa86ae


