Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F3BCD343B
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 14:36:32 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13616.1778164587199140854
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 07:36:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bootlin.com header.s=dkim header.b=YuuI6BJC;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A3ED61A3562
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 May 2026 14:36:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 78AA560495
	for <bitbake-devel@lists.openembedded.org>; Thu,  7 May 2026 14:36:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C29441081949C;
	Thu,  7 May 2026 16:36:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778164585; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Fy6zLCcvBtOGLP979DKA7mkElfNg/J/TPCziZparfyA=;
	b=YuuI6BJCNF/F4lgx9j0NtUdhX3UOK9Iu3tw9haYJPpvV17aHwfnIFphyi31dQIrT07OdNJ
	ud6NXUEPdsbZFLJ0v54PYRJgVYLRHvv4JFGz/h/qb+NQdp4NjIgqCDItEGD6URyQWr8HgJ
	3v1ofkVD6X3JJ69cdUdyEiDDZVkzwmPEVQjsDfCvbTcB1cl6awNuIwqb0okUY3iC/nn1tK
	W+h8+tiwZYaRnBa+GZt9qIT2x9ZeKUxd3j9YXQp2ROt47nXPjKM/eQWuU/7mqs4s6tcgzt
	8eGkPYo1pZlRP+XPAgdBlq53Gu2CJOCqINaVVPeayw7Nc6HMOM6iKOg7pKojqg==
From: thomas.perrot@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: thomas.petazzoni@bootlin.com,
	Thomas Perrot <thomas.perrot@bootlin.com>
Subject: [bitbake-devel][PATCH] fetch2/crate: skip yanked versions when reading cargo index
Date: Thu,  7 May 2026 16:36:14 +0200
Message-ID: <20260507143614.972053-1-thomas.perrot@bootlin.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 14:36:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19467

From: Thomas Perrot <thomas.perrot@bootlin.com>

The cargo sparse index marks yanked crate versions with "yanked": true.
Treat those the same way as non-existing versions so that version
checking never promotes a yanked release as the latest one.

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 lib/bb/fetch2/crate.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index b89817ab94d5..d84bae0bcd1e 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -178,7 +178,8 @@ class Crate(Wget):
         response =3D self._fetch_index(ud.versionsurl, ud, d)
         for line in response.splitlines():
             data =3D json.loads(line)
-            versions.append((0, data["vers"], ""))
+            if not data.get("yanked", False):
+                versions.append((0, data["vers"], ""))
=20
         versions =3D sorted(versions, key=3Dcmp_to_key(bb.utils.vercmp))
         return (versions[-1][1], "")
--=20
2.54.0


