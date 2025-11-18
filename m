Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B34CEBF92
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 08:20:28 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7955.1763454014596766604
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Nov 2025 00:20:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=iMUIG2M3;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 66CEF4E4175A;
	Tue, 18 Nov 2025 08:20:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3D0B8606FE;
	Tue, 18 Nov 2025 08:20:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FBA210371CED;
	Tue, 18 Nov 2025 09:20:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763454011; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=lnjDgT2zM6zqSDGJdthVKTNsO4XNjuWYoyuKz0b37vc=;
	b=iMUIG2M3xR66JkZq1W37AQthhXEgG+27oi89rgQ58zdMM6DTGaTr5Hk1K50y7yX3zTDs53
	XIz8Z35vZrLLnXAixiy36Ii2iNgTU5z0olurRxMr92wzRXcx2GEWqlLghbqZYkfl7XyYS0
	+OFvis8D7vbQc3LKpiKmRxSeZUwb4eVaNpC3ApOZUzg/kUBiwTt9XimMUcGOhNlUWoWiwJ
	0/ZHUlsL0Xb4g03mfesk9NhZZPpkcVFzT2vTywzMjuBa9EXNfxVSkwtyuUyeLA+SqyTFga
	o5h0SzSRTck6e7WSwdcSdmr5GEuieav6WLRedyy5/6W50d0f880XuC9blc8IEg==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v4 0/2] bitbake-setup: update: add a --update-bb-conf
 option
Date: Tue, 18 Nov 2025 09:19:55 +0100
Message-Id: <20251118-bitbake-setup-conf-updates-v4-0-7336b663bca6@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACssHGkC/43NSw7CIBSF4a0YxmKA0geO3IdxAPRi8VGaQomm6
 d6ldaIxMR2e5M93RuSht+DRfjOiHqL11rVp8O0G6Ua2Z8C2ThsxwnJKKcfKBiWvgD2EocPatQY
 PXS0DeCyoBA5GVoUElICuB2MfC348vbcf1AV0mMW5aKwPrn8u75HO3aqjSDHBQpC8yuoq5eqgn
 As32+60u6P5KrJPrPyLsYQxIoqsBEKNgl8sW49lCeOFrk3FCiiF/samaXoBdiVWX3IBAAA=
X-Change-ID: 20251114-bitbake-setup-conf-updates-91ae4efa86ae
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1752;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=CcOzZ4h7htgQTm9/+Fms6MwvmXhxMi3ob3vJV6QA5G8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpHCw6C1n8vGlB+krrgov8dl/pFOPDDa93n7UgN
 eT6t1woaQ2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRwsOgAKCRDRgEFAKaOo
 NnAkD/sGyC1nsAElGNBC4IlxbdUhsXpCwpQQ/EGilJMzAFxZaYLu3PgLXNYPEWE5ZQ1w/SDYA61
 oNVaQ2UMOUKySzVf5O/SYo1ekpKlhbnZ8ImRBp2xWZyBrdkBD/fAOtcVApq+gsrZ05Q2FQyGN1U
 s+ar8oyIxOkxoujeR81vS7XHmXePTfqZXxKwumVIYWqth6LYYdYz0BX6v6JEOqacootomIM01MP
 P+8AL7KNJAslXveP0FGT/KGadgT/AItz8YR84qTd4n4IwrGx5lGpdRhHDVO/sECJ+vHKtXcJal9
 zAPkedfdLKsvpZlkxscs7Md3utbpXlwKyWCioT8ZR5azem9U87F4Q7hcuLqDQid+EYvpLVgVBGY
 2DThIZ6BuxiRVNBxUQqZ5aAa2ek47S4ADQOxvzRj6hqZeMl/1fjYNt0I5xYJD0Mcjjd3du5K1QZ
 QCeOZ4gy8n9PXPTtE8pNK/wM/5mV2yLJLAY+rYym1AAIHY3MDp2Eh+zdgOz+eveXeha1jczRnFa
 DIBPAjxG5BuY8PnXqoyv2X9TaalNau/lCLVQhhpTuCK8YzG3SYsp5e9+l5wuwu2O5XrVFbbZoHC
 Aj6ArbaWDpu3xGc8NII9kZabAzzEncgPQ+HN/E6tylr6w3Xk2gUHNLMvuOZtXyudGLEEMZBj76r
 s1mfEgiS5VHQGkQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Nov 2025 08:20:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18443

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v4:
- Simplify argument passing in build_status(), as suggested by Alex
- Link to v3: https://lore.kernel.org/r/20251117-bitbake-setup-conf-updates-v3-0-46cdf826e79c@bootlin.com

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

 bin/bitbake-setup                                  | 53 ++++++++++++++++------
 .../bitbake-user-manual-environment-setup.rst      |  8 ++++
 lib/bb/tests/setup.py                              | 41 +++++++++++++++--
 3 files changed, 84 insertions(+), 18 deletions(-)
---
base-commit: ae9a70c919f14ca323eb7c03ef9080fd0bd52c29
change-id: 20251114-bitbake-setup-conf-updates-91ae4efa86ae


