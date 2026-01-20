Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260FBD2ED14
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 08:57:53 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2500.1768899463299397380
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 00:57:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=olCE4D1I;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C763D1A2956
	for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 08:57:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9E541606AB;
	Tue, 20 Jan 2026 08:57:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9749010B6B31A;
	Tue, 20 Jan 2026 09:57:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768899461; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=VK89vZ7jd5XL3qfAWDoKroz4uG+jQ2YMN3pogP0wXEM=;
	b=olCE4D1I9mg7V3EUHxCDa/27Q8G97AXG7K1hzJWcrveGjJEMsx/pqiL75DeZOnyIDIXdzU
	zY4whOackN5PfrBUJc/Ri2L4Qk6cxrPvYf/rADL07RLPtSJqlOxSaYRd4fiu7wvu9N3pmb
	H2yyQXd2b7yg0SAA3nQQBLgMTw6KABA43IH9Vbi0GgUOF6oeRcwjCxTTRfFPQv1SQlZLvV
	EA1CZww+wrYNeuygjoQirbQWGCg73qomJF5vTIEaipk9bPpvKt4nd/tSyr72kEc6lJmes/
	3/QZBf3/1yIMuinCGrk2nt1h7obGTmk//Xh4jfrD8mHKB4cRne+zUiJO05JLQg==
From: Antonin Godard <antonin.godard@bootlin.com>
Subject: [PATCH v2 0/2] bitbake-setup: add descriptions for fragment
 choices
Date: Tue, 20 Jan 2026 09:57:32 +0100
Message-Id: <20260120-bitbake-setup-choose-builtin-v2-0-ade604ff2351@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHxDb2kC/42NQQ6CMBBFr0Jm7Zi2ESKuvIdhQcsgo9iSthAN6
 d2leAH/7iU/760QyDMFuBQreFo4sLMbqEMBZmjtnZC7jUEJVQkpK9QcdfskDBTnCc3gXCDUM4+
 RLfZa1rUoT8aoEjbF5Knn966/NT8Os36QidmZHwOH6Pxn7y8y//5MLRIFnrsqr62p767auTiyP
 Rr3gial9AVVaRV43AAAAA==
X-Change-ID: 20260116-bitbake-setup-choose-builtin-fb199054cc25
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1162;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=wWRJeaK++5MlwzIRIY+CwCKx6sayctNsiral3vwzS5g=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpb0ODbLsU2ob1+u0/J5IitW+3AFXSeg3tWsPJy
 pF7z1Bq2ReJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaW9DgwAKCRDRgEFAKaOo
 Nq0rEACqvIslAxFKvR4iuZz0kfbndPysKXwFRVQW6oy6K6NwOsGJPXaTiFH5kljxdIwNaA8w+1z
 jd4BSSs4eujMxFZobi5Hr0XDmhMYmc6db0pM0C7VYVHQ45LoZfDbIDAGE80xi+9mMo97GP99np5
 O8VJ03pU+8rVWAEYbNhsu5tvyq/zVuTmEN3DkAy+Jbh97xdJWWB4qqshmrSzZbbO7jDdTHcVg97
 wGv/uVSnJNs2AeJtwNv7dkV2++oAwMMLM5GG9Wlw0YQqwGJzmxhH+X/E6ZbKzYVnyMXKlE29xtQ
 udIZ8v820QoFHBzt3EJ2etwJMurRZqt0dfeH5DvTyF+ZzgzkOplUVkY8+E2KUgs6vQeAQTA1Wkk
 0Y74HUuasngRkfYHIpM9AvfJhq2fDgEDDRbb31oA60lQiR5sJUcw9m7ZeOMyMhNmeDfV5/vVsey
 sZFvdVRFU+LBJBd/vJzsCHKxJ0vE0O6RqTjWRzgQf8BGlhrOUDRtAY641sdHR2ULPGGgpWAdai7
 3sS880hArt6aODM528J5A+oCSJxJ4jBz1thbiqtQKlnq2A0IaLI2NO3E2Ozw8KCGl5kecRLGF8u
 jIWofJKUYL3djGzKmhPQ7bkXNINwmh+pUJkRCgTPzPTp4LP569oPtnX7pS50WmlM1aK9KZFegTo
 bohgAk0mKwhNiTQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 08:57:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18811

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- As suggested by Alex, change the new way of specifying fragments to
  remain a dictionary so they can be extended in the future
- Link to v1: https://patch.msgid.link/20260116-bitbake-setup-choose-builtin-v1-0-8d66666a9efd@bootlin.com

---
Antonin Godard (2):
      bin/bitbake-setup: add descriptions for fragment choices
      default-registry: update fragments choices with descriptions

 bin/bitbake-setup                                  | 21 ++++++++++++-----
 .../configurations/oe-nodistro-master.conf.json    |  6 ++++-
 .../oe-nodistro-whinlatter.conf.json               |  6 ++++-
 .../configurations/poky-master.conf.json           | 14 ++++++++++--
 .../configurations/poky-whinlatter.conf.json       | 14 ++++++++++--
 .../bitbake-user-manual-environment-setup.rst      | 26 ++++++++++++++++++++--
 setup-schema/bitbake-setup.schema.json             | 21 ++++++++++++++++-
 7 files changed, 94 insertions(+), 14 deletions(-)
---
base-commit: d48c93e13d4c17a2c63a09335c97ea8630571201
change-id: 20260116-bitbake-setup-choose-builtin-fb199054cc25


