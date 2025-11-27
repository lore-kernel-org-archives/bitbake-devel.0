Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF7DD11183
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 08:56:55 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14605.1764233806532293325
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Nov 2025 00:56:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=ap5L3PEm;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 694F51A1DBA
	for <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 08:56:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 411186068C;
	Thu, 27 Nov 2025 08:56:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 75A02102F260E;
	Thu, 27 Nov 2025 09:56:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764233803; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=BvwWu1G78M1AQX8Cvvo90AHPDkQ4jk/Ws9jwYsHRvxY=;
	b=ap5L3PEm5UIr+UqQEE4RukT8qjRaXCRMoStB0vClTNk0Ce6aEXGDECxmRQxotCxRL4rUx8
	tvTCQ58Rg90k0AHITNMFikKQG2xDowdwSXIO6554iZcjRygAHzUDxF3hqZp/7rZZqDjyHn
	3RzlJbaRZtzlFmUsYaI2aObIY2WL00lsPVutSXIh7J4idWnKj9H7SFkoMzmv/kjdagj5Lc
	4oAfroBSZ2aCWr60067DU0vD0M1rYt/OTdIJkxKrsv/irOK3RH+MlAh9woQaxWLev6xrN7
	Xx/oXmj9/ogPpxvpqSN4FAmh4uy5nEveqxhsoa6cmDzIl1bgPeoD4wq2IjUslg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 27 Nov 2025 09:56:30 +0100
Subject: [PATCH] doc/bitbake-setup: extend doc of "path" option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-bbsetup-path-option-v1-1-2d2565eb927c@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAD0SKGkC/yXMQQqDMBCF4avIrDvQDNWKV5Eukjip04WGTJSCe
 HejLj94799AOQkrdNUGiVdRmacC86jAj3b6MspQDPSk2hh6o3PKeYkYbR5xjrns0duXaTgQBdt
 CecbEQf5Xtf/c1sX92OczBft+AEZYHjR3AAAA
X-Change-ID: 20251127-bbsetup-path-option-ca416ef22fa8
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=haPeBitl40M++TWiB7UtKLLxAJ8ml33aPVC/sXigk1A=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpKBJKIkpzCczYYFv8yhNiol6Hu+OoTVSGeH+Sz
 RJSA440WSyJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaSgSSgAKCRDRgEFAKaOo
 NmJCEAC6oGZUTnS4dZxAAuEXDLLpDgo/rhdkY4yc6uch9gZGAnc6ztGib/SzzhS4JM2vrsFiDvm
 1NyChBQdLIxuT8faP0L6ZKkSG85Av7T+XLAy+F3MjYLu2SRXeY+rSjro5PcnFxObBehsOshzY4a
 Qh8xv/I1Wu50OAjWxCScyOxnKR0Ggve9zGFC2U4bX/9YZJXfAtHWJeAZgPiHD2jr4kPqaVBgjXq
 HnyTLknSu53I3to1QQ3G/N8WcYd9JjuqY974qXiZmLXUPpSttBcFUfm2tp4IiEmwFnkf75vpxzR
 NIS1ZfLcEs8mR6IwkSPTObPOYBzR2IT79FNQKmMX0o2U3ifrMO+WrH8+B4SKzmqaIsbNnE0t05y
 Sjr9X5F7qJgJX8qSo6S4IRwKiiSKijSDDAct/uUkvVKAFHSGjEtS92ITHtmThgmqaYDQkS+6V8V
 SFHA+M3GykuDi/QndNPThe3m+li1DwIrAr+XuaqkmoNiYzkzX2OvJdk8db1IL1hS3Rqem2DlS7E
 U7h0VEc58Dal3gEBUQYg614FFSSammrxfA7bjkjID15PgoazG1vjYLevcz4osczC3znBI/aT9Mg
 xrXpseTawj6r1ZWOpuWMfse6CxmfAnIvLOHQLuL1W+sDfzMcNOa7IJ3ATdZ/1Bf68NO2i8Oj13d
 P1QA3gp44rlmcrw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 08:56:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18497

The commit 6727d0852f3f ("bitbake-setup: make "path" optional") changed
the behavior of this bitbake-setup JSON option. Document it.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 2b8051bcb4..edbc749ad6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -688,7 +688,9 @@ They contain the following sections:
    -  ``branch`` (**required**): the Git branch, used to check that the
       specified ``rev`` is indeed on that branch.
 
-   -  ``path`` is where the source is extracted.
+   -  ``path`` (*optional*): where the source is extracted, relative to the
+      ``layers/`` directory of a :term:`Setup`. If unspecified, the name of the
+      source is used.
 
 -  ``expires`` (*optional*): Expiration date of the configuration. This date
    should be in :wikipedia:`ISO 8601 <ISO_8601>` format (``YYYY-MM-DDTHH:MM:SS``).

---
base-commit: 6ee4df8ab58e0175b43106d8a6cbac1f6ab8d022
change-id: 20251127-bbsetup-path-option-ca416ef22fa8


