Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652FE7718B
	for <webhook@archiver.kernel.org>; Fri, 27 Dec 2024 09:06:49 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web10.10135.1735290402807245015
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Dec 2024 01:06:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=gfl4vHwH;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D32BD1C0003;
	Fri, 27 Dec 2024 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735290401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=48j8GkvbMTDJDjaxwczNmZprLPTr+JbVDRzik52Hin0=;
	b=gfl4vHwHGFeE/Bi6hW0WLoq7xPJDl70R4wgh08fyP8Wd1casHgCarQDXBYY6gq8ms3aIGR
	tk7doMY4e1hRoCTFdUAT7juo5a+FsUy8FfcgOoFBMkoEybn4PMzPiGqtkfd2eqvodSKBo6
	rh5MSsoCGKXXKj2ZC8L7M3J9wH/AWNj+zXmEyrj+sb5ShuAtaXXGYxE77OnQJkyvT+3i1H
	eAlxlDcTda7HvHnkE9oBrxgXwOYFzFMDAwJ97CV1B6kBAgHBEEjGiKNPeig9tfVhhFdBXo
	yJR/7yYDyZUpyOqwW9GdsZZX9eERzJLyt8oD8lZElnI/ArfTxqnc9Sev3KRHMQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 27 Dec 2024 10:06:21 +0100
Subject: [PATCH] doc: update releases.rst
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241227-update-releases-v1-1-1641a151991e@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAxubmcC/x3M3QpAQBCG4VvRHNuy4y9uRQ42+2FKaAcpuXebw
 +fgfR9SBIFSmzwUcInKtkbYNKFhdusEIz6aOOPCMtfm3L07YAIWOIUam1uu6mFsysxRrPaAUe7
 /2PXv+wGTYITuYQAAAA==
X-Change-ID: 20241227-update-releases-131267cf950a
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=4eCZcESmPXnwIiI7H1uJw1h07m8wEXZ1O1KOmcLRm7A=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBnbm4gTjnGu6OpChf4aJSXR0RMJPICSmNnIQnUP
 z+4xqWoq4uJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ25uIAAKCRDRgEFAKaOo
 Nh6hD/9OC7yOVzV4DZIBIyWYyiKDyI3WMiMgeaWuiyDl2IRJWNNQU6vnzJzer4/13JzJA4FPmd2
 g8ot6FdYAYhIJXC/kOGp5GbYmVAND6DHO9kQlJKOlZNythe06agFAkqkus8GKkcebBgB1NKME1p
 oyVtBq2S2LwEWP0BqCKBizrTyOtDQcclEDmylj/iYgfpRExsw3yWJ3PGnn5jC19P0NvMMR0WqZt
 vt9w07hGaJFKq7w1bRb7H1z5U2l6FMofAmP7/ycb35ni5GUJQWLV4X6CONfB9MRisTJaJSX8/nu
 cAm897txrwhWAuQtCsVS/KfrRus8RPkFoA6zdtLSBK+PBRNehRjBejUx96ompa2/59kbGfOBv6g
 R64qjqiDebfVQTcpJ3eQtbB0lYGjF01Clxq6JAZM497uR4cR/e/hNZ2bromeDFQ33FIDxPLIGO1
 jje1gCC6jba3ifoNl6tdQT+eNSoJ1n/oClOCAPjB2/45by0am0GG/WQ+PwTrgmwtmNVGYEwMB69
 ucn5jEwfKrw46aIvcq3+9hiRGLZAJ5BIDZmcVlSwiD/RMLedUVLVtycvbQoevdlUrrvD9K+31zU
 A9gRUnFJnlAKhyWxxh4+JmKzaN6JIWqVmCK4bHAsZGq303dDuKXjqZFNUQK9z1wt0BYVvmBihmM
 OB7NYw+wm4YHMMA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Dec 2024 09:06:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16950

Add Styhead as a supported release manual, and move Dunfell to the
outdated releases manuals.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/releases.rst | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/doc/releases.rst b/doc/releases.rst
index b271e2ad30a6d294f679aff3b270756f7e28e5af..3e8014074096c0f7c1a65a9820afbf74fe8cf657 100644
--- a/doc/releases.rst
+++ b/doc/releases.rst
@@ -4,6 +4,12 @@
 BitBake Supported Release Manuals
 =================================
 
+****************************
+Release Series 5.1 (styhead)
+****************************
+
+- :yocto_docs:`BitBake 2.10 User Manual </bitbake/2.10/>`
+
 *******************************
 Release Series 5.0 (scarthgap)
 *******************************
@@ -16,12 +22,6 @@ Release Series 4.0 (kirkstone)
 
 - :yocto_docs:`BitBake 2.0 User Manual </bitbake/2.0/>`
 
-****************************
-Release Series 3.1 (dunfell)
-****************************
-
-- :yocto_docs:`BitBake 1.46 User Manual </bitbake/1.46/>`
-
 ================================
 BitBake Outdated Release Manuals
 ================================
@@ -62,10 +62,11 @@ Release Series 3.2 (gatesgarth)
 
 - :yocto_docs:`BitBake 1.48 User Manual </bitbake/1.48/>`
 
-*******************************************
-Release Series 3.1 (dunfell first versions)
-*******************************************
+****************************
+Release Series 3.1 (dunfell)
+****************************
 
+- :yocto_docs:`BitBake 1.46 User Manual </bitbake/1.46/>`
 - :yocto_docs:`3.1 BitBake User Manual </3.1/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.1.1 BitBake User Manual </3.1.1/bitbake-user-manual/bitbake-user-manual.html>`
 - :yocto_docs:`3.1.2 BitBake User Manual </3.1.2/bitbake-user-manual/bitbake-user-manual.html>`

---
base-commit: c9906bb289dcfd9ae41f10bd5399ccc17a4cc437
change-id: 20241227-update-releases-131267cf950a

Best regards,
-- 
Antonin Godard <antonin.godard@bootlin.com>


