Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46022D3B7DD
	for <webhook@archiver.kernel.org>; Mon,  8 Dec 2025 07:02:10 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2812.1765177323868013638
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Dec 2025 23:02:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=T3mRpu9j;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 853871A2017
	for <bitbake-devel@lists.openembedded.org>; Mon,  8 Dec 2025 07:02:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C1E960707;
	Mon,  8 Dec 2025 07:02:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D51B102F0B3A;
	Mon,  8 Dec 2025 08:01:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765177321; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=90cFlqKszEDNZp1RgviwpMYGb7Vp+kiXo0NEBsH/7jY=;
	b=T3mRpu9jjDnWcgyzAu1MtyOQ5ASQjlAkZHBPYYbR13nrdJ+BFAO1QGm1SCEF0NRD1LUelE
	luM00hoEDgxxw8IQp4YDg+/En3hvJChxO9SrdSMj+wH9aBNTqeutNy+VYsGZADNr7def18
	jMNPzwQwoYdNiOTu7OveXyWpODt63WSap5wH+MdcIWBgvLAf873yiMD1EvsNDaDYpEgpqv
	UHkwd46Nzr2CcAPiQNOR3/fXjWFLFHhkIaK/9N4+wUAmShglRJX2pB2IajHVL1Zyi8amEM
	tsnIg20ig0rpCiv/9xPT2UXXCQhsLb+Kq7IZUkD2WlVub4ntTGhTWVnUIAmEAg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 08 Dec 2025 08:01:49 +0100
Subject: [PATCH] bitbake-layers: Also hide os.fork() deprecation warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-mathieu-fork-warning-v1-1-6d74b0ae8962@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANx3NmkC/x3MSwqAMAwA0atI1gZqQRSvIi5iGzWIVVJ/IN7d4
 vItZh6IrMIRmuwB5VOirCGhyDNwE4WRUXwyWGPLwpoaF9on4QOHVWe8SIOEEXvHzlXGE7GHlG7
 Kg9z/tu3e9wOEw4KuZgAAAA==
X-Change-ID: 20251208-mathieu-fork-warning-bcecc70daaed
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765177319; l=987;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=O/hbvUqCu7qRIR8p0tq3rXD7fGoYcm6U9qG6SZSKIAk=;
 b=2IalxZpS5vzzn3aEVxW+hIEcHGGiXx5SKAW9Wm1UEyJY7mbHD5Cxkrfcdf2BYtR2wW8zIg2nT
 fe7fX5JCCRyDcywpZZJ2QWY0AqTGQsAUFW1PvkOZTnlA+hwt0B79LUB
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Dec 2025 07:02:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18550

Import the deprecation warning hiding line from bitbake server/worker
code. Justification is still the same, we are being fairly careful here
and believe this code is safe.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 bin/bitbake-layers | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index c49a5f30eef4..37c196226cbe 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -16,6 +16,7 @@ import sys
 import argparse
 import warnings
 warnings.simplefilter("default")
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 
 bindir = os.path.dirname(__file__)
 toolname = os.path.basename(__file__).split(".")[0]

---
base-commit: 720df1a53452983c1c832f624490e255cf389204
change-id: 20251208-mathieu-fork-warning-bcecc70daaed

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


