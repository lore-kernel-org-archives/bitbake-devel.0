Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614FCCAC592
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 12:21:41 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.31612.1757938898038279350
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 05:21:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=PA/0r0v6;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BF31C1A0E06
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 12:21:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93F966063F;
	Mon, 15 Sep 2025 12:21:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 064A0102F2A7D;
	Mon, 15 Sep 2025 14:21:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757938896; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=6gl8mHwA6rsyxyzKdrKmZg4XBww/+BEwT5LTvX8icYk=;
	b=PA/0r0v6Kr6SApWKMEvrGurPKQH+r7Mql9zgKSty+SKXf32sbbPOkrFFNjEY8y0RE82Pcb
	6eTTEyWxeph23Po6Q4DnBuMfr78FSopM2uVv5rSr5FLl3iXqRirpiOinC3YO1NZ6INIIN6
	K+9ysiZx50BWKvh7HkIpTZvTAc/snrnQxkCqkd1wF5tSSUz2kUJ4pPGHfOf0yPGpS8TH5V
	eKjJzOSa8lYw5aTh8hxU3Ln6LKDbCqjezP86Ow0S24L5xeqHvN4f0pzVV8bJ9tm55TywK3
	Ve9n44F4MQsY/TzgRf2qOZXcmNOkWJG1hxG4FEWk1VvoFRyLNoKfm7JT+p0kHA==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH 0/2] doc: fix the switchers menu
Date: Mon, 15 Sep 2025 14:19:53 +0200
Message-Id: <20250915-fix-switchers-js-v1-0-523ef53fe802@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGkEyGgC/x2MSQqAMAwAvyI5G2hLXb8iHrRGGw8qjahQ/LvF4
 8DMRBAKTAJtFiHQxcL7lkDnGTg/bAshT4nBKGO1MRXO/KDcfDpPQXAVrN1sbVFqNTYVpOwIlJx
 /2fXv+wGgLinIYgAAAA==
X-Change-ID: 20241227-fix-switchers-js-8cf445610b97
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=xT2feQjDKVqvvarmPLzj5LE9tmgrP5995MDyVJKRdTI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoyATOepvEUrvseKHyyZHwLoxTWRKFFs4aEZMZ+
 pvBF8RPBX2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaMgEzgAKCRDRgEFAKaOo
 NpjZD/9n67kwvsPKHVSgt1igGUPwAAKvprJ9dPt1pkbMVgpChdFzr3r2E+DTLl9r1/Ha4sb/e/j
 SJPUYX8cAik3gt5nN0GdploTaRBUDWk7w2VM/dTu0etMGpDXAhazAwLXMYyxnECvKFPElRB4KrT
 RgBSQAndmGxMnD1NHJmbWDlCbN5v5fpi4Edahdo+V4FaXkX6xdVDeWybNb4AHYlARxZFoh3tKp8
 PLj6h1Cao1me22vpwN3eJJJViPhOiwP/MRYdrnw4ybaT9L0Wt5FkjHl7d48yBod6Mq769y8Fxd4
 fRKuLGkE6nHE4ZMZw9UfVCnaRcbblQ1jtuuWsvpwVzTliPiGrqTZwsYxGTK/lkBf4seUn+mdXCu
 0+chpJntbW/y06IYzKZagdE6527gADUKAYICj5GyyLjcPAYbmypaCfx5YykLKTleX7g8x3XyIMG
 UV6orRFXOr4QytAcczL2OSGLtymZw+GBKx14KWt1UAG7nOEaLz5ykgRqh7sD8Poi4aCFDdNgNQV
 P2P8SOl7gybDjccb6ff0REAyJJSTFfWqtE6w9NdKQKg+oU73aiXyGKVTstjjrW9rwKdAr0v+eHD
 GGmYw+MK8AQs8Z9RCANuigeJOYHmY56eB5XYDEbSoOB8vXJbGOFW0XJLgKAyHWgyBDzt2W6zihs
 Hf/iEAN3iwKX/kQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 12:21:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18023

This series aims at fixing the switchers.js script of Bitbake to show
what are the supported versions and be able to switch between them. It
also get the current version from the environment, and shows it on the
sidebar. Moreover the "obsolete" warning is now shown when browsing an
outdated manual.

This also adds a set_versions.py script, which is largely inspired from
yocto-docs. This script replaces the version in switchers.js by the one
it finds in BITBAKE_ACTIVE_RELEASES (env variable passed from the
autobuilder).

IMPORTANT: must be merged with following series/patches:
- "set_versions.py: add bitbake-active-releases special argument" on
  the docs list
- "scripts/run-docs-build: improvements for the bitbake menu" on the
  yocto-autobuilder-helper/yocto-patches list

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Antonin Godard (2):
      doc: fix and automate switchers.js versions
      doc/conf.py: get current version from env

 doc/.gitignore                    |   1 +
 doc/Makefile                      |   3 +-
 doc/conf.py                       |   5 +-
 doc/set_versions.py               |  53 ++++++++
 doc/sphinx-static/switchers.js    | 233 -----------------------------------
 doc/sphinx-static/switchers.js.in | 250 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 310 insertions(+), 235 deletions(-)
---
base-commit: 546b347b4d3d82c01ecc99f45296f66e44638adc
change-id: 20241227-fix-switchers-js-8cf445610b97

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


