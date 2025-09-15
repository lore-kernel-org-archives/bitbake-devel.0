Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5498CAC59A
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 12:28:41 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.web11.31892.1757939313896840854
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 05:28:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=btmGId2Q;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 629D34E40B62;
	Mon, 15 Sep 2025 12:28:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 34F036063F;
	Mon, 15 Sep 2025 12:28:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6581F102F2AB8;
	Mon, 15 Sep 2025 14:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757939311; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ZpHFkb3ZjTsjLelivfULXTPVsAMUEinAK8sXN/fBcWE=;
	b=btmGId2QgrNdcVFjgddeTvJPxanC618/GO4Pf/yD4E2L6nbtU7UWEEqkH5XDyHliP2b1jr
	hIXi+f4qTkL6mkk/hPZD2VJ6KPwM6N+jdLeJQGfMSDl7doXfHJhUIbEjscYgkI+mQ9l1mz
	h7L+tYpxDb6Io3SmwEDEnWO6xdaRmoom76p9NxFNR7gqgw+ptZFsY6M2hKeeMXZ2rxL3kQ
	IqmMaaIlKN/xuYUi30IsX+X0JVFeBEI5/JwrVTwf7dpTm6zdaLA931rUbxi5PvUXcNt80h
	plnKaPED/nJ15qgKqhI6mQPgDKI5cL0UGzf8AjohF3YQqOuJJW1pI3wvQRCs0g==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 15 Sep 2025 14:28:03 +0200
Subject: [PATCH] bitbake-user-manual/ref-variables: extend PERSISTENT_DIR
 doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-improve-persistent-dir-v1-1-c0f64b6c5b74@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAFIGyGgC/yXMQQ6CMBBG4auQWTsJJSDoVYwLpH91TCzNTCUmh
 LtTdfkt3lvJoAKjc7WSYhGTORa4Q0XTY4x3sPhiauqmq0+uZXklnRdwgppYRszsRXnwfR+Ofmz
 dEKjESRHk8xtfrn/b+/bElL832rYdm8l2EnoAAAA=
X-Change-ID: 20250914-improve-persistent-dir-8d77f6da418f
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=mzaxt+NfKuEpPlAHPN1yypwu9OtTj80mpfl2XIkY+Bs=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBoyAZuI4cDawPwLRk5eaDWRNfrx5rkYm3Q31zsE
 UW1g4UDS0uJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaMgGbgAKCRDRgEFAKaOo
 NkkoD/46o6DTlj7ME3k05C51n5vmbMvLygdfX3F5zd400pIli/63foeG6GA4UsjB4C23CxW+yGu
 4PjC9QoUcWUuqDytnFYBes/oRFTg7RiYauaQmKCiyIcR0dFMftKOTvY//vYRC0Sji+rrRCirnEg
 1NSa4LX9JV43RYlzRLxPDPVU7ZemNEvIZ2l0o+dBxWAsdbuqK1xCjT/36wRBCbiVtRAFvK2ZVie
 lXIXkfNGbZhF5/i13gRSYPdIQvqSv0q7KIYyzA60x4YHNeaPMXMy4buSocxb0GYpjmkfmyNElJ8
 jByq9Ay31EC469D48rUAv5fKZ/yB7L0WZHbC5RiCVg516f44eEsaMFjMZMP4lci2mjKcHG+iSFw
 IobV3AeyOu6FdWe6hvLJWQJ5XT0aAxtBj9/YzNksn1SO1LH+7QTeE2dHaYyHaWZl6mBNNUu9L5x
 PpbpznWWQ+T/DaDkeMEmMpfAy2ZYpQarfcTHhdpysRSIgSJVHVDwTHeesG6Qa/pbZ/PePGrW72T
 ugyEm/q4pQFA4YFyTWLpvh3RuIXZw4s251IaYxzcKq1rjVsJpNdF8/J4dU6qF2tCsKiS/29yku4
 po33KckZnn0ghEnbggA//CVg9fZVKu5WpaFhMQdnLI2M/Ug+oYLj1Izf06WGvY5cmKEOxfIjvj9
 ax3yypB30sis60g==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 12:28:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18026

Extend the current documentation of PERSISTENT_DIR:

- Mention that it also contains the hash equivalence database when
  BB_HASHSERVE = auto.
- Mention that it should not be shared between builds.

[YOCTO #15727]

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 810f886897..3b8fab52e8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -1313,8 +1313,13 @@ overview of their function and contents.
    :term:`PERSISTENT_DIR`
       Specifies the directory BitBake uses to store data that should be
       preserved between builds. In particular, the data stored is the data
-      that uses BitBake's persistent data API and the data used by the PR
-      Server and PR Service.
+      that uses BitBake's persistent data API, the data used by the PR
+      Server and PR Service, and the default location of the Hash Equivalence
+      database (when :term:`BB_HASHSERVE` is set to ``auto``).
+
+      This directory should not be shared between different builds. If you need
+      to share the Hash Equivalence database, you should setup a Hash
+      Equivalence server instead.
 
    :term:`PF`
       Specifies the recipe or package name and includes all version and

---
base-commit: 546b347b4d3d82c01ecc99f45296f66e44638adc
change-id: 20250914-improve-persistent-dir-8d77f6da418f

Best regards,
--  
Antonin Godard <antonin.godard@bootlin.com>


