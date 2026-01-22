Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9364D3EE7B
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 15:02:29 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39449.1769094144608348861
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 07:02:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=hEmguzlh;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0172E4E421F2;
	Thu, 22 Jan 2026 15:02:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C271D606B6;
	Thu, 22 Jan 2026 15:02:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA6CE119B82C9;
	Thu, 22 Jan 2026 16:02:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094142; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jgM4Kg90qhX31I7AWOB41exSR9nYVnnPa/BevY8S2A4=;
	b=hEmguzlhjieD4r6BuE9hkf+mpwbi1DK3CB51chaYXmmEgNEKslaXTX70W3z6KKQFpazqdN
	0FU8y0/R6YcVyQJHATGkkpPnM6VIcaF7K08KQwosdgeued1xlJePy/kFagX9r/aNBFx0V4
	67o6mtUQds0dx08X7/yPrcyttamoZ4zdDTu3x6rHlUSZper3Mw76N3imTao8edQznqBkVQ
	abAjLmzyc2S0YLiklXItCP79Y2mGHDCLcpCNBtZWo/WnsZX1bZ7i9O7+Iggxygl4LwefdJ
	EGzrF+P60P2qKYEvonKrMNXagU6HJlddhCdUYdnBOS9nlcnpKhFqhjPmDhp/oA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 22 Jan 2026 16:01:59 +0100
Subject: [PATCH v3 2/3] default-registry: update fragments choices with
 descriptions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-bitbake-setup-choose-builtin-v3-2-c55291acc1a7@bootlin.com>
References: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com>
In-Reply-To: <20260122-bitbake-setup-choose-builtin-v3-0-c55291acc1a7@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Kanavin <alex.kanavin@gmail.com>, docs@lists.yoctoproject.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3676;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=jWpA35XcRtNFx/OZh7hKYjjVUJYcHpz6omjTxj5vqeI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpcjv7IvkfZmnRhS1pFIJ/h9TXYpLgz6ickCWgE
 NrxEGwmTzCJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXI7+wAKCRDRgEFAKaOo
 NttRD/9qHBoNNSrl8f14c03JzsbcNxjHK+O4N3KTpTLdu7N4nKVx641fu5G06z7M5xltFGYTVgT
 c69MFNPHoavDDFpT37UPDC0k61tNR4Mjbb9bBtsHsY1eXUZPoh+12IO10965RfW9YDThYpfrk+b
 sxWz2pFpchlq6GWrmmLihxKOZIMtmGACoAdOi8xgZHPOJigZ3kwc1r+yrNm5kDsVSh1RX9HV6cb
 7Rvn8UbnqSWLLDunAxj4dVOU0yru/LEnIc8IwS1wKJ8Kgd2sRGOYaE/nMWlucP5lq2AnwEhxpbo
 aUdYoWBk8aAoGHXz1cnpPuRx7LkyjONTLYWVFYvHE6eh06EDPghv+XGxLjOWzHGjlz2HTefoqjl
 RpAtNK7mFwW5X9ATxNeWC3JUR2Jsq3/p7ChAKjp5cTAkCI7qOxNFo0pnfkDMkQXIapEooj+MIGm
 AjpzfGPbBLQEiP73tSGAh7LriQtyzJUyKTb9bc0SUeDWKl0h9IgrYOfsbYoAaa/I5s1K54PXf65
 S8eczJV2dJNbpZfFhcthfSayRWftL3URWKL9YgCBOynx7OQ6Mf9RMKUTmg50JM3jQP7C3/o4hB8
 y1y8nWqoMFuzNWFKc7sR66X5x0IK69OHKo5JlzfTwmb+BzQVAKJdRCsLOiVyEeIZJTFzUCLZVeB
 SQMJMZgEq1ktQYw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 15:02:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18850

Give descriptions to the fragment choices to help the user know what to
pick during 'bitbake-setup init'. These descriptions were based on the
descriptions found in the corresponding configuration files in
OE-Core/meta-yocto.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../configurations/oe-nodistro-master.conf.json            |  6 +++++-
 default-registry/configurations/poky-master.conf.json      | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/default-registry/configurations/oe-nodistro-master.conf.json b/default-registry/configurations/oe-nodistro-master.conf.json
index 180d2008a72..00c4befb1ac 100644
--- a/default-registry/configurations/oe-nodistro-master.conf.json
+++ b/default-registry/configurations/oe-nodistro-master.conf.json
@@ -45,7 +45,11 @@
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
-                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64"]
+                    "options" : [
+                        { "name": "machine/qemux86-64", "description": "Machine configuration for running an x86-64 system on QEMU" },
+                        { "name": "machine/qemuarm64", "description": "Machine configuration for running an ARMv8 system on QEMU" },
+                        { "name": "machine/qemuriscv64", "description": "Machine configuration for running an RISC-V system on QEMU" }
+                    ]
                 }
             }
         }
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 1de038babe7..18657ece103 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -54,11 +54,21 @@
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
-                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+                    "options" : [
+                        { "name": "machine/qemux86-64", "description": "Machine configuration for running an x86-64 system on QEMU" },
+                        { "name": "machine/qemuarm64", "description": "Machine configuration for running an ARMv8 system on QEMU" },
+                        { "name": "machine/qemuriscv64", "description": "Machine configuration for running an RISC-V system on QEMU" },
+                        { "name": "machine/genericarm64", "description": "Machine configuration for Arm64 SystemReady IR/ES platforms" },
+                        { "name": "machine/genericx86-64", "description": "Machine configuration for generic x86_64 (64-bit) PCs and servers" }
+                    ]
                 },
                 "distro": {
                     "description": "Distribution configuration variants",
-                    "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
+                    "options" : [
+                        { "name": "distro/poky", "description": "Distro configuration for Poky (Yocto Project Reference Distro)" },
+                        { "name": "distro/poky-altcfg", "description": "Distro configuration for Poky (systemd init manager)" },
+                        { "name": "distro/poky-tiny", "description": "Distro configuration for Poky (optimized for size)" }
+                    ]
                 }
             },
             "configurations": [

-- 
2.52.0


