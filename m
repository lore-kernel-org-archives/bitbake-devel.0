Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E3C982D7
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 15:49:25 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55.1768578562161186210
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 16 Jan 2026 07:49:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=g1hqybwj;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 78B24C1F1FE;
	Fri, 16 Jan 2026 15:48:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4C76B60732;
	Fri, 16 Jan 2026 15:49:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 126B810B68C23;
	Fri, 16 Jan 2026 16:49:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768578559; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Sk6FPnbqIQ/qYezwMTu38jpLOvor7CGQBV0NS4Kuk8k=;
	b=g1hqybwjHuOGQ8qNS8pv2wzAxZNm0lcYcVv+MWz/7HhzcKKDlyfXpKMIlyPkeQxP8iNEDS
	d/UU/N7QxM6LS+zPDFll/yoTPo2oX4Isu8E+54tuq0n4tlsLL7VbKrTEDYXeV+YIaEj7an
	BmF+mOl+37R8QcNvMn7/lY/2Sxk0zNMuPq89a8lzKnQZ6Vru1eVpbFoo0Jo4A1rIeIhVFa
	E/15TmH/+jdbisyPeoghV8U++eMKOZM42LrXJOMeCazoUk1Rr8J70fxOmarJYVoiP4bv3J
	U8XFro/EfCrJLoqOKlgTF/fuyIi8pxfqS1fMDCLdYQ9nazW6pA4/FzKOdqelHA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 16 Jan 2026 16:48:57 +0100
Subject: [PATCH 2/2] default-registry: update fragments choices with
 descriptions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-bitbake-setup-choose-builtin-v1-2-8d66666a9efd@bootlin.com>
References: <20260116-bitbake-setup-choose-builtin-v1-0-8d66666a9efd@bootlin.com>
In-Reply-To: <20260116-bitbake-setup-choose-builtin-v1-0-8d66666a9efd@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6424;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=xT4TMcp4Irq5QrCrFkTWXD/rBiNEwJrfbOu0wFNUGb8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpal36WRHVxL9cWqI63X67SBXjS3tuHidsrz9Po
 Qs1lYzNnMyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaWpd+gAKCRDRgEFAKaOo
 NrekD/oCp3GApK3oMkWqv80+mtqc21fgGULNThyP/a83T87JNqoTZMelhtJhblb3dXpz/dPgcFk
 q8Cm6pmaU9Gsx1Q1+va5udFalwVaY5dnknOzu+YI+ZyscUbw0ck0vnamrrImMGDD6j6nGPhlUv2
 nFRkBF+jmUUUIY035xirNAgcxkKINx4yuJp5ZVcea2hyvg5gNr91K3cUi/KnNC+ajLpV3VhEVBT
 JGF9Uk3U7bU46ux+s7iYMMg7QF6ajS+ipKk6lkShPvvN/fEOpJomy6M+Np06k2u33eu+iWhwQzq
 3D6zd93+jDP+rFF3UqJzpPEZyZU3I5BP0dovtRWaorSitqXLabpCiy5maezRSRN9yPJjisku+EN
 D8S5TFdwQqqpAHHlV9fAj83Rf6Kzv8+SYCY7uHQjExlujpElSnBccEOVMPffQWfLxnDo/xQBWw5
 cHZ8JufW1oO1Mpo4ShT5mPTRyZzBE4rrwgBrePWkT5py98pA/atqSo3/a8OPnZ0Eip59CMPdaby
 v4CEJaZd/Xf5zQw5AdOn9i8brsRHcPa0qE4YoQXzHVqKWBseHW6ECqalffACfLj/J3xCbqnz3x6
 ZYIBVA9E2JMR2hN3MGwE03wkKI94/7d3Acfgp/Vgb6eLpziwffs6KGW0s9awOEVK1z5VxHR94Gh
 00aZ5sGQeWWFbpg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Jan 2026 15:49:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18801

Give descriptions to the fragment choices to help the user know what to
pick during 'bitbake-setup init'. These descriptions were based on the
descriptions found in the corresponding configuration files in
OE-Core/meta-yocto.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../configurations/oe-nodistro-master.conf.json            |  6 +++++-
 .../configurations/oe-nodistro-whinlatter.conf.json        |  6 +++++-
 default-registry/configurations/poky-master.conf.json      | 14 ++++++++++++--
 default-registry/configurations/poky-whinlatter.conf.json  | 14 ++++++++++++--
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/default-registry/configurations/oe-nodistro-master.conf.json b/default-registry/configurations/oe-nodistro-master.conf.json
index 180d2008a72..b8d4324dc3b 100644
--- a/default-registry/configurations/oe-nodistro-master.conf.json
+++ b/default-registry/configurations/oe-nodistro-master.conf.json
@@ -45,7 +45,11 @@
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
-                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64"]
+                    "options" : {
+                        "machine/qemux86-64": "Machine configuration for running an x86-64 system on QEMU",
+                        "machine/qemuarm64": "Machine configuration for running an ARMv8 system on QEMU",
+                        "machine/qemuriscv64": "Machine configuration for running an RISC-V system on QEMU"
+                    }
                 }
             }
         }
diff --git a/default-registry/configurations/oe-nodistro-whinlatter.conf.json b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
index 7b183ae1c43..7774bf7eefd 100644
--- a/default-registry/configurations/oe-nodistro-whinlatter.conf.json
+++ b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
@@ -46,7 +46,11 @@
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
-                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64"]
+                    "options" : {
+                        "machine/qemux86-64": "Machine configuration for running an x86-64 system on QEMU",
+                        "machine/qemuarm64": "Machine configuration for running an ARMv8 system on QEMU",
+                        "machine/qemuriscv64": "Machine configuration for running an RISC-V system on QEMU"
+                    }
                 }
             }
         }
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 1de038babe7..e3998ab8c7d 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -54,11 +54,21 @@
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
-                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+                    "options" : {
+                        "machine/qemux86-64": "Machine configuration for running an x86-64 system on QEMU",
+                        "machine/qemuarm64": "Machine configuration for running an ARMv8 system on QEMU",
+                        "machine/qemuriscv64": "Machine configuration for running an RISC-V system on QEMU",
+                        "machine/genericarm64": "Machine configuration for Arm64 SystemReady IR/ES platforms",
+                        "machine/genericx86-64": "Machine configuration for generic x86_64 (64-bit) PCs and servers"
+                    }
                 },
                 "distro": {
                     "description": "Distribution configuration variants",
-                    "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
+                    "options" : {
+                        "distro/poky": "Distro configuration for Poky (Yocto Project Reference Distro)",
+                        "distro/poky-altcfg": "Distro configuration for Poky (systemd init manager)",
+                        "distro/poky-tiny": "Distro configuration for Poky (optimized for size)"
+                    }
                 }
             },
             "configurations": [
diff --git a/default-registry/configurations/poky-whinlatter.conf.json b/default-registry/configurations/poky-whinlatter.conf.json
index bfa67426dbf..b6834274f8a 100644
--- a/default-registry/configurations/poky-whinlatter.conf.json
+++ b/default-registry/configurations/poky-whinlatter.conf.json
@@ -55,11 +55,21 @@
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
-                    "options" : ["machine/qemux86-64", "machine/qemuarm64", "machine/qemuriscv64", "machine/genericarm64", "machine/genericx86-64"]
+                    "options" : {
+                        "machine/qemux86-64": "Machine configuration for running an x86-64 system on QEMU",
+                        "machine/qemuarm64": "Machine configuration for running an ARMv8 system on QEMU",
+                        "machine/qemuriscv64": "Machine configuration for running an RISC-V system on QEMU",
+                        "machine/genericarm64": "Machine configuration for Arm64 SystemReady IR/ES platforms",
+                        "machine/genericx86-64": "Machine configuration for generic x86_64 (64-bit) PCs and servers"
+                    }
                 },
                 "distro": {
                     "description": "Distribution configuration variants",
-                    "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
+                    "options" : {
+                        "distro/poky": "Distro configuration for Poky (Yocto Project Reference Distro)",
+                        "distro/poky-altcfg": "Distro configuration for Poky (systemd init manager)",
+                        "distro/poky-tiny": "Distro configuration for Poky (optimized for size)"
+                    }
                 }
             },
             "configurations": [

-- 
2.52.0


