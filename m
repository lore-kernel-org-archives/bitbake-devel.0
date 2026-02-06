Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19867EB28F8
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 08:40:51 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7121.1770367243086384175
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Feb 2026 00:40:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=SeE/0O8t;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 90D7F4E42438
	for <bitbake-devel@lists.openembedded.org>; Fri,  6 Feb 2026 08:40:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 61C8660729;
	Fri,  6 Feb 2026 08:40:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B378119D1A08;
	Fri,  6 Feb 2026 09:40:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770367240; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AR/yECErx+o8NMv5Mj5TZ1Os650x216lBgwBd8QhDXo=;
	b=SeE/0O8tZkLK1D/xLcbXm0g3lVe5ZHBBN5kFFKUlecSSPBZyQsUxkuqMiIqcPaQKne+5J7
	7FVtBXmuK7Eu82J/gpsuoIkMLDBAlqH/TXYtRi5eruMtfUHbJJ9xZiZwYeeDHABPFEqHR3
	2+gdQ0KSWyNr3ISXb+QRhWvBElUeCnY/axSiy+HZCBbHQvmjoUvYmNP7N8FiuakEJjwK+G
	ouUs7q2hDmSOENam7Z1A4jTFQ48EU5vQVPhtEyYLI8iMIMq5+QJET6sOFQLMu49dHoB+jL
	ao6Mz+4Y3QRIm/AZM21pqCyhFwF5sXiSFK8g262NZ/Vc+1HOT2tX0bETBJgWaQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 06 Feb 2026 09:40:17 +0100
Subject: [PATCH v5 1/2] default-registry: update fragments choices with
 descriptions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260206-bitbake-setup-choose-builtin-v5-1-3038da12dd2f@bootlin.com>
References: <20260206-bitbake-setup-choose-builtin-v5-0-3038da12dd2f@bootlin.com>
In-Reply-To: <20260206-bitbake-setup-choose-builtin-v5-0-3038da12dd2f@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Kanavin <alex.kanavin@gmail.com>, docs@lists.yoctoproject.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3498;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=vjrkEwDDnD0pL5zPXqYCr/waf44pvH0vmuXAYYacLq0=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBphakGM+uiMhAbDUJI8PdnHlqcQQPt6lv03pqz0
 95Zr/YBppyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaYWpBgAKCRDRgEFAKaOo
 NrumEADIRHcS9OA+whFr4zsZE2aMYb0SzSmEVFKIF6jBwtALknBgntYvrSO9zQqowx6Lio28o2r
 EB9XV2HQpEUB9CG+3HX5o5OxS8Iuku/PxmSl3/oDTNrWvgfoFsC+QmQvb7PmSrGqUvswFtoB04Y
 k9/ERWj8z/a4aepmQuAWExJXnH293iQTuBoilVSc3azq8h+sobNSN7G9S3vUY5t2ya0r6/7GsFE
 bSFIRIdgorjfVvdMB6oVOwNsB1motwO87K6kuoWQgyJsIFftMU7ygKs2pjYHZC5IRWm/xC5QjmZ
 Qf4fpRpB9+Tc45hD5jEZYgd/9lfjttFEm59X4K9SCjVKi/gKjvWgFCvJQQc3xLciofMboyob53C
 HhiWclMFIg0baAAoTKtO+IEGS0x+RoGHWrXlA7k1gogRlgEuvZGZ5SppjQWPPSsIwUUu4fz5quo
 V21mwACYgMeBp9LVWEy5GNr8sXAsmshKGl39ehkGod0amqV+i4Qg3EATrEMtMOh1K5Lgwz5vuFZ
 zyrkR+BHLFH6+IxU/ogc8xwRUrVQCNB9N5cEextSK2znC6TaAypxhfEfOprfWSye3LHD/iVMAgB
 cc43kYlR+QxCWLHFxUsS1BGaiAI+OcdTp616ge/N1y1JuWOhkLG7AFsU4mqW/03ODfVIuE+wNKn
 mYn8aK/Heh/ledA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Feb 2026 08:40:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18978

Give descriptions to the fragment choices to help the user know what to
pick during 'bitbake-setup init'. These descriptions were based on the
descriptions found in the corresponding configuration files in
OE-Core/meta-yocto.

Also while we're at it, s/Distributions/distributions/ as "machines" is
lowercase in "Target machines" above.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../configurations/oe-nodistro-master.conf.json          |  6 +++++-
 default-registry/configurations/poky-master.conf.json    | 16 +++++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/default-registry/configurations/oe-nodistro-master.conf.json b/default-registry/configurations/oe-nodistro-master.conf.json
index e4e842177e7..5aa148d4217 100644
--- a/default-registry/configurations/oe-nodistro-master.conf.json
+++ b/default-registry/configurations/oe-nodistro-master.conf.json
@@ -33,7 +33,11 @@
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
-                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64"]
+                    "options" : [
+                        { "name": "machine/qemux86-64", "description": "x86-64 system on QEMU" },
+                        { "name": "machine/qemuarm64", "description": "ARMv8 system on QEMU" },
+                        { "name": "machine/qemuriscv64", "description": "RISC-V system on QEMU" }
+                    ]
                 }
             }
         }
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 0cabce95294..58d379648a3 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -38,11 +38,21 @@
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
-                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+                    "options" : [
+                        { "name": "machine/qemux86-64", "description": "x86-64 system on QEMU" },
+                        { "name": "machine/qemuarm64", "description": "ARMv8 system on QEMU" },
+                        { "name": "machine/qemuriscv64", "description": "RISC-V system on QEMU" },
+                        { "name": "machine/genericarm64", "description": "Arm64 SystemReady IR/ES platforms" },
+                        { "name": "machine/genericx86-64", "description": "x86_64 (64-bit) PCs and servers" }
+                    ]
                 },
                 "distro": {
-                    "description": "Target Distributions",
-                    "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
+                    "description": "Target distributions",
+                    "options" : [
+                        { "name": "distro/poky", "description": "Yocto Project Reference Distro" },
+                        { "name": "distro/poky-altcfg", "description": "Poky alternative with systemd as init manager" },
+                        { "name": "distro/poky-tiny", "description": "Poky alternative optimized for size" }
+                    ]
                 }
             },
             "configurations": [

-- 
2.52.0


