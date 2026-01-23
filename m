Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95258D74EC5
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 13:24:28 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.67344.1769174659873895011
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Jan 2026 05:24:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=JZD1n4fA;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5D11D1A2AD4
	for <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 13:24:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D3616070A;
	Fri, 23 Jan 2026 13:24:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BD18119A87D8;
	Fri, 23 Jan 2026 14:24:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769174657; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jgM4Kg90qhX31I7AWOB41exSR9nYVnnPa/BevY8S2A4=;
	b=JZD1n4fAykJKSMoJVd3gfOI7s8gfzADIeO3LcrcLhlGeHs1BpeyZcKz65R+S1yvNZBHvFO
	GG8LSkJTzqKIiZWpZup2gHA0Ma/IdCAPf/Mz3fT7gDq+7TG2dS0tu5Welc0kfLMlK4XeKS
	KsIo8UVI03ymH5rtnebEcIauEDKcEYMGTr4txmsW1i5ZXEvC3CGhUL5ctJX6w5mBr5k6yP
	3CWstyVfajgtZr+1cAAsB5f3fprEAgZ7GAHFSPxf9K1DKLr1KgjcBFCHQLUSzpEqldt69I
	wISRpv4Y/orp0RqtVNULW08A1gvjN0Vs8WBJCsKQVv6kA8dHgJbyt9hAJsBiBQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 23 Jan 2026 14:24:07 +0100
Subject: [PATCH v4 2/3] default-registry: update fragments choices with
 descriptions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-bitbake-setup-choose-builtin-v4-2-99361f2128f6@bootlin.com>
References: <20260123-bitbake-setup-choose-builtin-v4-0-99361f2128f6@bootlin.com>
In-Reply-To: <20260123-bitbake-setup-choose-builtin-v4-0-99361f2128f6@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Alexander Kanavin <alex.kanavin@gmail.com>, docs@lists.yoctoproject.org, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3676;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=jWpA35XcRtNFx/OZh7hKYjjVUJYcHpz6omjTxj5vqeI=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpc3Z+JbAcSLDarIwgdLe89shulujdlmQueNOso
 TefvNmHykmJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaXN2fgAKCRDRgEFAKaOo
 Nu/ZD/9oZkKMvuT33u2jl8QQFKnOpNblx+JcJbCufDC4lo7dWoiBjhl1DMeJvp9HJuy4RpitaJI
 ipS+yvgKs89KJthClp2U9tBJ5iiKu8OFPSGA9cHAG6kbvMRAIf5T3keCGGJT7EzPAsbgzIt2qWE
 PfqsGwQwyoho3rg9sEzYVwzC/bWHVw16qPj6iJfwLT+nzH6mTGmbRAB4P1Ck2TX2m/l8+s7adhc
 4ofAd7whJDxiPqaJUjWlzd1EgdUsz6PbrhtsaohgKhkVizGdOQ6zyk/sK4WKYG5CLrUWMWMO2Ml
 3OZCwlFfhBQ3JzCKjzv8FYvbPIgKZlS5cLjs1vS1t6WoqDAXLDcQBB7uB1/5OA7/dP6W4rSLXvX
 MOiVoBXxadcNU6qkVq0rtKdnSLlV+f+j0W/AsXPRq+7RZCNxmF30vKKVTboYJDII+Up/uD7sC3r
 QqySymosgVDG9+sdN/QRIeAUczN0C2BIpx7kT9t4afuMMt2fSSLnnt5e9GJ/AVprWZXYDNgZem8
 Ji5HbZ+eyGjazX7hiUd/DmR7WPajGxzYvTncv6dEwcDIw+BK5zHTj33u/smw5uYTs0tkG8bbq/o
 802JG+FbOKmzszLMA06sdz1c7gPJTV+1HjYqq677FSjC3uZVPKxRpTdPyvEnPSK5sQ5qm4FxeqW
 JxF/BFA8g93jRhQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Jan 2026 13:24:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18858

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


