Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33691D2ED15
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 08:57:53 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2466.1768899464687746041
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 00:57:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=2xpoLgVV;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C7AE3C214ED;
	Tue, 20 Jan 2026 08:57:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E2BD1606AB;
	Tue, 20 Jan 2026 08:57:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E2C410B6B31D;
	Tue, 20 Jan 2026 09:57:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768899462; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=J/3sAPmcS9Yi+bB7UKrzmdWx2ZsEzLdntcg4V8OsVQQ=;
	b=2xpoLgVV23phCNmfwrtnc/kdeAxVX3PkY+EjL5OcTrtJt8SOEupbEq+zRbThoD9acLH29y
	rsloqsNjFlqOd8+vaAiXfzW0YDnVJtTU5zYf1eCggDRPvZn9XiaC6AAKynTiQKOtUe4Luq
	3iSBTeF367Uj6QDalIS4XhUH3KQBusdDHmMa7F8zxDdql/H718I+5dxIp44pGsiYZv9Ac0
	2i9mvrYEXoZu2YtdL2vQaG5POTlJQu8/JLW94jypcwFMuYGvqR9SyceYys4T5GMajoUaWh
	CUij0/T4ilsG3HRs5f2Sqz0XIRqsxH1DeYLPlujBdV/RzWngkj0Hh43q9UWrNg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 20 Jan 2026 09:57:34 +0100
Subject: [PATCH v2 2/2] default-registry: update fragments choices with
 descriptions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-bitbake-setup-choose-builtin-v2-2-ade604ff2351@bootlin.com>
References: <20260120-bitbake-setup-choose-builtin-v2-0-ade604ff2351@bootlin.com>
In-Reply-To: <20260120-bitbake-setup-choose-builtin-v2-0-ade604ff2351@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7018;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=yZpaC+AdPPZYMOczg1f1KJfIKAnmARj3zzGYIsqNxQM=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpb0OEWLGHb7R8nwWJzbNrejabFwbc8NXC2KYdU
 WPfDPZXHGGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaW9DhAAKCRDRgEFAKaOo
 NuC+EACyo9RGQgJ9XSJjaW3h5d2UU+M8laEGAYoUL4OVOfcsFQZNYKA6CCCClBwbbqR9qbvJUCb
 WaB/tomdZAEsOCev+Ll1KU8bamkGoQGvOhex3dkWHgVgSgMIkhVVEnCwPH0hb1kMiAflYiUgs/a
 oBwXdPWJG+cMe8fuf2rIGn1OUJo5Q6YvhkuPt4qghv1xgPHvAa5nc4rL+l7Kk1ziK1a55YveReG
 AXAi/xHJVyPLtY83Un6TuY0PDbZaLwf8WhrPuu1KuCxTIRbL+8Z4FC5rmWgHUCVJ2sosU5PSWNP
 BNrcSPr0fXZHVD8S18LKFRVA1iNxxy9wiYA+ztCcY7dwvmyXuDyye5tEpzuNZNidd2cL9yKUoz8
 QPpMUPRt7lIcixWjAMkB3USpSgyXbE0+gAR2GaNcGTRTcUsdrX8zlSZ5vt8axMtrcnL6ZGgTBuk
 XBIQ2gnnmwx0SmJjrihc7iy4XTMF+YPrYOf7nZZSj/GLdKYHV91dbJMAhvGe+7b32U5ze8XTZBg
 cja2pr5xHX+hPYzE1fxUCQnmBy+U6R0w7dmR9lN1kTHqdQz0rTemdZ4/geYDHfJ5MC+Tsfjokdt
 ADre0Sdxdijn/MnKGRWcijgvb+x0CwbAsqf5BZZXWexeagREUFXc47Ut+6ZsF30I59vEd/DjAfN
 H77rWb1/kH0YKRw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 08:57:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18813

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
diff --git a/default-registry/configurations/oe-nodistro-whinlatter.conf.json b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
index 7b183ae1c43..8d416015ab0 100644
--- a/default-registry/configurations/oe-nodistro-whinlatter.conf.json
+++ b/default-registry/configurations/oe-nodistro-whinlatter.conf.json
@@ -46,7 +46,11 @@
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
diff --git a/default-registry/configurations/poky-whinlatter.conf.json b/default-registry/configurations/poky-whinlatter.conf.json
index bfa67426dbf..d9f75a8cd38 100644
--- a/default-registry/configurations/poky-whinlatter.conf.json
+++ b/default-registry/configurations/poky-whinlatter.conf.json
@@ -55,11 +55,21 @@
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


