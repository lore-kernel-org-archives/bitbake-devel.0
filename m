Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031A2C87FC5
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 10:16:03 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.9115.1753352162344853350
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Jul 2025 03:16:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=c6N6SHk7;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0FB4643210;
	Thu, 24 Jul 2025 10:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753352160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xlpsKJYDnKIUS4X2HNR/OdRghqPPG68FQDNWsciaQX4=;
	b=c6N6SHk7HzpbjQZ2aAp07YwPdWhJ2czP+JyOkSlU+L0AMoMyvawaD8b3IQrMtWwnSaq3x4
	gVE6D7JlBQtQIECBBfoIN9Xl5TfuSlox6zYcyJ/Iop+rZR97JQH+969YwgYTK7fh1oy/2y
	EFy+UGZHPVklgH6io/5weHoG/CioB0NUtUg9omEgMOhIyORs4kmqlpbmggYhL/MwbeHOqz
	MoQZNF+XoLaGDCn9BUuR47Gdt4Th134m0XwkMQvlOWBUV5G8wTwXTboaZe/cApUe9X1rQh
	RgQAFm2zbNhcbpU+/XR4i9EqEax9rjL/kDndVLCQZalUSHEu8WKSoKiCLAFjow==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 24 Jul 2025 12:15:46 +0200
Subject: [PATCH] doc/bitbake-user-manual-ref-variables: document
 BB_DEFER_BBCLASSES
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-bb-defer-bbclasses-v1-1-70f1826d4b83@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANEHgmgC/x2MQQqAMAwEv1JyNlBDVfAr4qHVqAFRaUAE8e9Gb
 zs77N6gnIUVWndD5lNU9s2gLBwMS9xmRhmNgTxVvqGAKeHIE2cLwxpVWfHrq0C1NwE2PDJPcv2
 nXf88L3QR2DpkAAAA
X-Change-ID: 20250724-bb-defer-bbclasses-072454260def
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2448;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=G6jrHQ4MwBqoHvnz3Jhi5z444wdlGp7zYGTDM1WN9Cw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoggffwFoIwSYsvSnCB4LRwlkYxFrU+TwA3K2ZT
 n+8bvT0EPqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaIIH3wAKCRDRgEFAKaOo
 NjlSD/9Bnohik0Yoz/K1eLnv71JvmFPtuGF9DQQSjs9b6kvbducSNe1nomIC9Xj5384dDmEL48J
 cbdLY+G9Mq1f7BrgKf1k5TT4/BejnStKjbkVeVJZTEQS54qRyOkOg3LaqWLkPjfJNFkBKZITjgB
 k7CQq4yKen9kwi0beI0ART+jfKMC1i0c4h+OTYgDV6YfduFC2eeqf677TM05Oiw7nCHmGbU1CyN
 uizuabcbCmHgzeaAdzewiIak/hzOyAxGnguqgyQjW+XHGSa+3sD8/WMwkfNfNRA6a+76Wo62Et5
 7Z6cfAZJEmVjotodP8RMweqtjejmBSE2RNWLH8ydXqMkkCDNOjLmrGOEKQTdWTuVT4CCIw/Ag2F
 9s8PWvUw3xqpdJPIKOCOiq0hJpp8iMj43MUyu/oXL/Tv6t7Amhiu5sQmOz/DsDdn2yENKX5LTuI
 pvk2kEYBBc09vIgyM+MMJfOXtFwRZKg7mg7kRx112uVEFFD+Isbhl5iPsR/0KTNpqhZDmfcd4Vq
 TzAr4P2HkHaweQrh7r2slxl7FLQsw5HHd8L9jFNiS7qDx9asM+T+Iy+w5Kd3k+WgwWbL5ykP5Ar
 lm4Hn63u/xBZbiPGe60WGT77sXl4BES25U+ufH7JNOG0RSkXC54t9crB3APQbaFMmU7EhUbrpGX
 LSgW2nwUsfIpNMA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeijeeltdeiueetffevteelueffiedvffejgfethefgheelieetheeiueeikeeunecukfhppedvrgdtvdemkeegvdelmeekudejrgemgedttddumegttdgsvgemugehkegrmeegvdeltdemlegvrgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvleemkedujegrmeegtddtudemtgdtsggvmeguheekrgemgedvledtmeelvggrjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhro
 hhjvggtthdrohhrghdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Jul 2025 10:16:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17808

Document the BB_DEFER_BBCLASSES variable added in 8e741b2e885a
("ast/BBHandler: Add support for BB_DEFER_BBCLASSES").

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 .../bitbake-user-manual-metadata.rst                  |  3 +++
 .../bitbake-user-manual-ref-variables.rst             | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
index f60a9d8312..8df81e9b66 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
@@ -871,6 +871,9 @@ In all cases, if the expression evaluates to an
 empty string, the statement does not trigger a syntax error because it
 becomes a no-op.
 
+See also :term:`BB_DEFER_BBCLASSES` for automatically promoting classes
+``inherit`` calls to ``inherit_defer``.
+
 ``include`` Directive
 ---------------------
 
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 6be8dbbf63..cc1f74825f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -141,6 +141,25 @@ overview of their function and contents.
       The default umask to apply to tasks if specified and no task specific
       umask flag is set.
 
+   :term:`BB_DEFER_BBCLASSES`
+      The classes listed in this variable have their :ref:`inherit
+      <ref-bitbake-user-manual-metadata-inherit>` calls automatically promoted
+      to deferred inherits. See :ref:`inherit_defer
+      <ref-bitbake-user-manual-metadata-inherit-defer>` for more information on
+      deferred inherits.
+
+      This means that if :term:`BB_DEFER_BBCLASSES` is set as follows::
+
+         BB_DEFER_BBCLASSES = "foo"
+
+      The following statement::
+
+         inherit foo
+
+      Will automatically be equal to calling::
+
+         inherit_defer foo
+
    :term:`BB_DISKMON_DIRS`
       Monitors disk space and available inodes during the build and allows
       you to control the build based on these parameters.

---
base-commit: 5ba7c2f0797a72536a81f57276d4e5c75f23011c
change-id: 20250724-bb-defer-bbclasses-072454260def

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


