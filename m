Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3F2CCFA0C
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 16:31:24 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1689.1762187476487598471
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Nov 2025 08:31:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=BSOKAdbC;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 31D961A1835
	for <bitbake-devel@lists.openembedded.org>; Mon,  3 Nov 2025 16:31:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0800C60628;
	Mon,  3 Nov 2025 16:31:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 53C4610B5009C;
	Mon,  3 Nov 2025 17:31:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762187474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dlrPpa+h9rWpU8SfUTAUGaBDzSD6jY375gYxV0hq7/w=;
	b=BSOKAdbC2mQI8l7khPfe1vnLWLEkduy5t/CiL+66ugGb3EJ/RB0SGQAvnp42k6uxgGaLyy
	sHpzNmXGNaIbC2qnykIZDCJfhSeP2/RIKZ8J+vn1LlvQf7+teJ5M7YV43IilU4mnZXgd2F
	OyjlnJebtK12IbmR9bLJO5PD2kzXOmGIdSuwaZtJEei89Cqo3HcnYqagf1fy4Jo3d7ilMm
	eT5wAKJ+Tw/yDojDN53omhwHqNQWVhTQRNvBRjFHNdGqfi/McmETAfwmxdwToSNmbQXapK
	OCGYX95pEkLFYacIEmxtSer+Dr0VpMxktK1uHYBhTztW/AjJ4yx/WzWed8rvUw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 03 Nov 2025 17:29:49 +0100
Subject: [PATCH 1/2] doc/conf.py: add wikipedia extlink
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-bitbake-setup-v1-1-635a7c829a4b@bootlin.com>
References: <20251103-bitbake-setup-v1-0-635a7c829a4b@bootlin.com>
In-Reply-To: <20251103-bitbake-setup-v1-0-635a7c829a4b@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=652;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=8Uyj02sdsC+CaHZ7lVuFOsunetTYcsZQ2pPDNsTWABg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpCNjQJ3fPWkMWPiEoDVLaIoUIXTQZJAWAr68KV
 C1G29deP6yJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaQjY0AAKCRDRgEFAKaOo
 NkSXEAC/GMjBHTe1em5qPYafexYUTwV9Dichgisq51tyX0+ui87EEGCVQihibqhqr1NRhrbE+4P
 aYDbnN5wbQBGak9NjQxr67u8BU1scGZ0ekdqpaXD2uJrK8ajnfxdptoyNfmk0aRqpVecWU71WGt
 JWrocvSxE/mgv+kwUR27gSl6SQI55aOuzUy8YswBO2n3ZYZaRoYL6NE386u7+YkJqtk/ga5NeTx
 APgNCVMqJz2k5ZEH31mwmri+zU1PZv8ORYB2iJeT6c3XdV5yW0xZVGxda4kdkdWpGgysZMa6hJo
 V2TlsdIq9+YzzVbswOwlw7bd0ePksMPqv7QFowkvT5/1kzQ5WNXlkO0SfzI6zJkuTFJqZSbF3aj
 AIoQF3EVaSobdsbw1JkI8v18hml0/mGPRy/Ce7RBUKAjDnqOU2O7avXuvPOEwJYzPWH5LuhfCz3
 KOYjsuemhd38l+GILnIB1jPGxrhaeGaluxdCXl3U1V1Pif6pHnvP2iwNaoWHBDVulKTiVRR3ZSg
 EdF4+6v9MOxewqE3zjAKVgezKCxQ7wGzsKoWU4VohBOEJTqfFCZ5V9RxeBTiiX+b+HG1NT4xEV9
 5KyebSPPx1LS3nOoZZnMfygNgAIFH1rHIkMl6lbzsU4r9/73a0haMYWfyJJMZwRusVWSrtXrpc2
 crevMVVpnT1sj0g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 16:31:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18242

For use in the documentation.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/conf.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/conf.py b/doc/conf.py
index f61241e28b..bce386624e 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -39,6 +39,7 @@ author = 'Richard Purdie, Chris Larson, and Phil Blundell'
 extlinks = {
     'yocto_docs': ('https://docs.yoctoproject.org%s', None),
     'oe_lists': ('https://lists.openembedded.org%s', None),
+    'wikipedia': ('https://en.wikipedia.org/wiki/%s', None),
 }
 
 # -- General configuration ---------------------------------------------------

-- 
2.51.0


