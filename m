Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F82CC7EE30
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 09:54:02 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.6465.1751363632703397357
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Jul 2025 02:53:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=pQIwnM0f;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7157D43123;
	Tue,  1 Jul 2025 09:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751363630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8MgbW5GJcGIg6ONyslmu8AvkjMiHH4TpnJIXXTzBNTE=;
	b=pQIwnM0fNQcaMZy71bGmnDGOiScBYYnaWoW/rni6SDbrhyKTMYdBSym2GUIO0xCuqKgZgp
	s++PVzBk9OZ50cTkn5y2kyxyzD5ZYT7hn5YgM5ENoSZK9MeOMg6eX2IRqWiPE8jhHTt1d+
	/Kbvzb7JiMprPtyH9pOKd4Es+gz1UPtuwlmn2uAC56sIhhpmVY9jfjswFVWFf2g84jEFNt
	P/VhYw3mCkLZ4Trlv5e52zUGAfS6fo2OBoSq5fAOe+n0/xfXeyIQZvE7cMORV3O3BBvKQZ
	SnOCBV8psaRuEgmMFgACdk0AVNfrMw2OFoTdVvvbZXABhmRipPnSZGg0N0bg7w==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 01 Jul 2025 11:53:41 +0200
Subject: [PATCH] runqueue: show the current pressure as debug messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-pressure-messages-v1-1-bebffe123676@bootlin.com>
X-B4-Tracking: v=1; b=H4sIACSwY2gC/yWMSwqAMAwFryJZW6hFUbyKuGhr1Ah+aKwI4t2Nu
 noMvJkLGAMhQ51cEPAgpnURyNIE/GiXARV1wmC0KXSpM7UFZI4B1SxrB2Tl8tJXlXHe5hbEk0d
 P59ds2p85ugn9/obgvh9E2c3YdQAAAA==
X-Change-ID: 20250701-pressure-messages-b47c882bca4a
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=MhE/RJpZ8g05d7q/x0yXprOij5I4DAop9uL1YELNRyw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoY7AtyoT7Zg256x5R/xoub1aa7kxkNBKzJtxgJ
 ZUOz8EsB8CJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaGOwLQAKCRDRgEFAKaOo
 Ng72EACVI4z+fZVylO04ea56wvTiz3WY6YqDRbWDBlkEXarkLqfnZpC8XAhgEMHYcyzCAWdodCk
 hmjR9Jt/zj7jt+i8BYIOFO+5i9cV9ThpLIAjdIzHxyGe13jXq3fGVN46j7glTPQVfSmwwOtlWcE
 8ov4fgDKOZuuxPjvbJZDwAy5TT4E3k0u9JwE0+HxdTm15rZMAhjakaI5XPn1hXRa9bCA3Ef/FDQ
 LcuDd3mMopIf9PQUlaWnRoOUUaUt5tUnqbETUZ73BJd2seCvmjTcl+OY/4IOFhW36+tTlQa7eBv
 RJSheXXaRtgO1Vu61MmiXuP9BvB4UWergk8q+L7lyxjaXh7Fs63tFmDa7edlEzChY6y2eDQ3maZ
 NMiGMCTQFAL5oFRs024aqQkVx+RGBIQ6HZoHYCJWPHS+8BTTUkL5mua8cdvPYsooQjd9z02gzZk
 91F/v/cFlv4e9DsdGumvBqUitMMd2CKnZwoR1KdUD/3nle2zUx9HEXizsEcsg0Z1W3bS+giT2/y
 ScY3emu9xi+sWGc9BJ437Uhp7Iq7Oq914IPzytRvReczuxND32m+Qt5ZsoVregD2sBMFO/fzXWp
 riuT22TeLbAyN9bDfrJUuZN5gBjd7tfJDfYAAbIDHx09x64MjwN9dFl6lFSg+/sIjF8rlZtnTRO
 HNqtfVRdWzt104w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpeetnhhtohhnihhnucfiohgurghrugcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudeijeeltdeiueetffevteelueffiedvffejgfethefgheelieetheeiueeikeeunecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfegtkedumegvsggrjeemudgskegsmegrhegtledphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepsghithgsrghkvgdquggvvhgvlheslhhishhtshdrohhpvghnvghmsggvugguvggurdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnthhonhhinhdrghhou
 ggrrhgusegsohhothhlihhnrdgtohhm
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 01 Jul 2025 09:54:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17731

The current pressure logic only prints pressure information when the
limits set by BB_PRESSURE_* variables are exceeded. But in order to
determine the best pressure limits for a given host, it can be useful to
monitor pressure information after setting BB_PRESSURE_* to the maximum
(1000000) and get a sense of how high the pressure can be.

Add three bb.debug() calls showing that information.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/runqueue.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 80f3d3282f..cae4bfa3e5 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -206,6 +206,9 @@ class RunQueueScheduler(object):
                 cpu_pressure = (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff
                 io_pressure = (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff
                 memory_pressure = (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff
+                bb.debug(3, f"Current CPU pressure: {cpu_pressure}")
+                bb.debug(3, f"Current IO pressure: {io_pressure}")
+                bb.debug(3, f"Current Memory pressure: {memory_pressure}")
                 exceeds_cpu_pressure =  self.rq.max_cpu_pressure and cpu_pressure > self.rq.max_cpu_pressure
                 exceeds_io_pressure =  self.rq.max_io_pressure and io_pressure > self.rq.max_io_pressure
                 exceeds_memory_pressure =  self.rq.max_memory_pressure and memory_pressure > self.rq.max_memory_pressure

---
base-commit: f68b513c38fa33c89236efbaab2674a25983d5e1
change-id: 20250701-pressure-messages-b47c882bca4a

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


