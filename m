Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D7EC61DD3
	for <webhook@archiver.kernel.org>; Mon, 31 Aug 2026 10:24:10 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26490.1788171847140346487
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 31 Aug 2026 03:24:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=FsrOLLMe;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0CBEF4E41441
	for <bitbake-devel@lists.openembedded.org>; Mon, 31 Aug 2026 10:24:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CEE6860231
	for <bitbake-devel@lists.openembedded.org>; Mon, 31 Aug 2026 10:24:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7F19911C78AE0;
	Mon, 31 Aug 2026 12:23:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788171840; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=18GPdCgK2TdUulky/W1x0Wlo02zufEcing3S2CBkEvo=;
	b=FsrOLLMe5g3YWacECp6gS4AWddFkN0s7GOwWq92d7i1XvxQEYFKyW/cwk0NRViKs52iuN3
	9tqEzPZrCjG5V19ELnJ6R0nmhuSd1ppUmwMGCv31jU3taD/UIWn3F0RqptPCfFyz/cHuRP
	fyTE2cOvYXl4KjKTR18JK4heMx8kzIWJIc5HY2E4314Ja202qL7UCMxsV3pP1UAWG5EVcr
	8HV+YCFYGv/y615NCaVaESrqPAI+ZmmbwNKAFT0fQIlTqW0lp+LLc/ooLYwT1tZHiiwo2e
	OUO0qZX6jgtg3OCW4moukL1cpkrl218NzV76OarIkS/XtYG7zx2cRxRVy16tXg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 31 Aug 2026 12:23:45 +0200
Subject: [PATCH] default-registry: use core/yocto/monitor-disk-space
 fragment by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-monitor-disk-space-v1-1-feaf88e16a0e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrDuQaIk/Vyku0jjqKCaSUSmId
 29al9/ivROEIpNAk50Q6WDh4BP0IwM3Wj8QcpcMucqNqgqNS/C8hYgdy4yyWkdYFcYaVWrt6ie
 kcI3U8+c/fbW3ZX9P5LbfCa7rC8H+SiR2AAAA
X-Change-ID: 20260831-monitor-disk-space-836a60711c94
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=fLK2EXhJCoRo8Hxuu6Ox+G1mixHkHxZhxI1d5PufqGs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqlVY/NljfjpujrTRjRjx2TS370MizjCbs4I/Oo
 GXCNd6uTK2JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCapVWPwAKCRDRgEFAKaOo
 NvRLEADNhjLw53/ngejuiMGzcDgdVOzb7sUaq6QqJuEo+mCTBNGQo6D4FO449sVeMsjtfuJsP5W
 Oc0crG67UKuaze2yrxQTHrZqn7oykDMUpyVSu0ta+PPMo/a07M+tCECN1Ql5/wNU1kuwE+SOJxl
 xFuX1UUDeFIPbeE24c/6GSW5tuGCUe312QGY0Lr0O/J5D7zFaycgsaMQ/cMvT1Cc/NTPXy/MF76
 eNKjIDnMFPOsmJABd6zbLvkqqDOgFjgSQbw9rpet4lztPgoOYPA1DaKwhY3jZVYh7LGKLu9xIhw
 V5sdz1Md5uadR6W2Mwq3BvjRw01wd8cZhbImXyCugyGugCaehVPwOXGAkACINPniMkXLpccvBE1
 TiAAvD7bta7BmqPw4tLwEpHrytmQFA8oltCvcLd6+HN04dJRGdfM5LI9YGmbpQ4ZsITDEAPAamx
 Irb3unTEKZIx/4ABXYqAzKXOCaDbVftoppTOkPBua6gWX5tPk5n6ncJJVWvTfSfpGj2WPhpXKZq
 DYlfbiUAkNAIKov9/113QrNTpYPSuAu1uKnCVYXRHe+7OOZv0Q8e5N5nDyt27J3b51NJgk9yb7U
 97KFglVYoTI/djFQHxST1mHUK7hg6du4eizn9BaJpkVsIQzzITOCAHII/ns618b4iJ7c4fPR0Kk
 7irAvzrMjidN9iw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Aug 2026 10:24:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20135

This fragment is now part of OE-Core[1] so we can use it by default in
our bitbake-setup configurations. This matches the local.conf.sample
file provided by OE-Core.

[1]: https://git.openembedded.org/openembedded-core/commit/?id=df3cc9f85f9921c6585d9a69cb5351689680f659

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 default-registry/configurations/oe-nodistro-master.conf.json | 1 +
 default-registry/configurations/poky-master.conf.json        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/default-registry/configurations/oe-nodistro-master.conf.json b/default-registry/configurations/oe-nodistro-master.conf.json
index 5aa148d4217..c5d966618d4 100644
--- a/default-registry/configurations/oe-nodistro-master.conf.json
+++ b/default-registry/configurations/oe-nodistro-master.conf.json
@@ -30,6 +30,7 @@
             "description": "OpenEmbedded 'nodistro'",
             "setup-dir-name": "oe-nodistro-master",
             "bb-layers": ["openembedded-core/meta"],
+            "oe-fragments": ["core/yocto/monitor-disk-space"],
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 58d379648a3..452d933a576 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -35,6 +35,7 @@
         {
             "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
             "setup-dir-name": "$distro-master",
+            "oe-fragments": ["core/yocto/monitor-disk-space"],
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",

---
base-commit: 18cca50ba3da5ce27bc674478957bb08e7536b9a
change-id: 20260831-monitor-disk-space-836a60711c94


