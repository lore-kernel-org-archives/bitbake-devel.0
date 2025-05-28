Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96237C5AD49
	for <webhook@archiver.kernel.org>; Wed, 28 May 2025 17:45:30 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.1852.1748454327583514765
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 May 2025 10:45:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=iYqkl9BJ;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77C9643192;
	Wed, 28 May 2025 17:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748454325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X+80+qOkrouwzHd5Lhl6Gicpq4a/yZHPBbSDB7pmxnU=;
	b=iYqkl9BJgpxhy4oOrkCOsKK0jq6Mve74D3N5qPJh6e3APRGgNB0o25wHF8P7ZMZYeQqawT
	2dcGTQhNCcaJT7SANAk5dF0SsM3RNpuTb6FdkZzDuEw+3pvnjx42La31WC5RRRSNFYxLlb
	R6CGwvFxfGYqj+58A9dJCXarhKKckSS9iaul6fBxDwwVK/GQ4sEMvwvGbhHFrBhNS93qRa
	1HAhnCr670zksJh2TcOagoCjUrMrARzglpdKcHHQRGrSPmxj3jPIxDqUNPnprC7pGEvYzM
	U477euXXEuVSbO1nUKy2ZS5QBc2CbsvKnZM7iXdId2dJKUJe68QK5ogqJCENMQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 28 May 2025 19:45:05 +0200
Subject: [PATCH] doc: update releases.rst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-walnascar-update-v1-1-9c6750e87e65@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAKBLN2gC/x3MTQqAIBBA4avErBNKFKqrRItJpxoIi7E/CO+et
 PwW770QSZgidMULQhdH3kJGXRbgFgwzKfbZoCttK6sbdeMaMDoUde4eD1Kmdjj61mDTTpCzXWj
 i51/2Q0ofg96BKGIAAAA=
X-Change-ID: 20250528-walnascar-update-41cabd94a89f
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=6maFlQjOdUVwD08iXUdGNuJZu/MilDTbgfz/SWm/Saw=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoN0u1usAQJAY/Nwpz0MYzDqJKgGPnUh7VyZn4a
 EUrZvHTlYmJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaDdLtQAKCRDRgEFAKaOo
 Nrk9D/0ayP8G1yzP7MyaA7heznY7psGPCJRtGKkOy4beNw9i2Kdsque1BmZ1SifjvQSbtPeVffO
 tLUh7/br7evmM3wr3tEEr9oAN7eR25zCaxHoCDTJf5FyQkFHLrjfpH8iLFD6Dx01Xl9F8o1R5Mu
 eUspXdm3zJnxieV31XhyFZ7hfFP/kcPdXmleVc0+eWbDfLjdmbvH5VX1F4bH7Mgsti9Sp54Yl5n
 h1aXiXYNN97KH/0aeoYtDXr89jv2iVJnmbzyn4em6wKiBJpIfbkyRYCuMW2gixQG9muMX/tDed3
 NIb8Elhds/uWvUC+OHUVtWNgOkpFRaYLVhFdeo4WdOUPXLbUHzXGt7YbRvf+Uw6owmf42QanWWL
 slZvfNMe8zlZtm8nxp6u5LOBdiQBVKgchmoeP3AstpxhixNUKRkSDXida9mJyM4vqp0o3ah82Qn
 BrugLQN9loY6HGCwwNQk87TMpWoV3DE76c8UXSSp/B0HaSWQM7xvmCYOL95OWy70qOa0WuJ7mJt
 OGiiZvBRGyw2h6KEdMNnByFgWaMppHM+TwQ7j/EDsrkA7EEayujJGnGVPSxvhGxGuFmbFawFaaC
 VLGGSoW1j9vjS5N3i/rworA2OhUOFjN5UrOv3MhDT7VULAHon/SYihY6jbdGs384uCzt7qDvK8u
 OnDs93cGHX4kzMw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvfeekleculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeijeeltdeiueetffevteelueffiedvffejgfethefgheelieetheeiueeikeeunecukfhppedvrgdtvdemkeegvdelmeekudejrgemgedttddumegttdgsvgemugehkegrmeegvdeltdemlegvrgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvleemkedujegrmeegtddtudemtgdtsggvmeguheekrgemgedvledtmeelvggrjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpt
 hhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 May 2025 17:45:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17653

Add Walnascar as a supported release manual, and move Styhead to the
outdated release manuals.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/releases.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/doc/releases.rst b/doc/releases.rst
index 3e8014074..676db66ec 100644
--- a/doc/releases.rst
+++ b/doc/releases.rst
@@ -4,11 +4,11 @@
 BitBake Supported Release Manuals
 =================================
 
-****************************
-Release Series 5.1 (styhead)
-****************************
+******************************
+Release Series 5.2 (walnascar)
+******************************
 
-- :yocto_docs:`BitBake 2.10 User Manual </bitbake/2.10/>`
+- :yocto_docs:`BitBake 2.12 User Manual </bitbake/2.12/>`
 
 *******************************
 Release Series 5.0 (scarthgap)
@@ -26,6 +26,12 @@ Release Series 4.0 (kirkstone)
 BitBake Outdated Release Manuals
 ================================
 
+****************************
+Release Series 5.1 (styhead)
+****************************
+
+- :yocto_docs:`BitBake 2.10 User Manual </bitbake/2.10/>`
+
 *******************************
 Release Series 4.3 (nanbield)
 *******************************

---
base-commit: 6e1434d93d489aa4bab07777a7a9dc58ba0ca5a7
change-id: 20250528-walnascar-update-41cabd94a89f

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


