Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A302D232FC
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 08:59:36 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6400.1767949174535386619
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Jan 2026 00:59:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=2cvtZLIm;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E37681A273B;
	Fri,  9 Jan 2026 08:59:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9B8E60734;
	Fri,  9 Jan 2026 08:59:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E672A103C814E;
	Fri,  9 Jan 2026 09:59:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767949172; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Qav2Nu7n9xKdacXk2qi7IbXUh7KNpvGIk8IJRRXFa2k=;
	b=2cvtZLImco71iSP5rGZRnE1jgWeFFOCtn+8ztesRoD7hDbm67bAL79w++BsJE9HhPz7uFj
	kSek2WH5cxkIH4uq1EUEoW1NBAjQDyixqgP35SznuGa7nsr5dvA4phaExAFMx7ft/zzIz5
	u4qPQrpgXC1vWfJ3nd+2DvQTDfPkGICHgu87cjzCg9NmA5swsPjySmgz3gVv7dcf7dhat5
	8BlwYIQCxryPgl4krTIOYHlXKLXqK2DfLIy/G+1SZj0N5yOXd6oLOcmBlVFTNE9mbh9ND9
	L92qwpGTcfdhO7SgFZlh4536xfsa+pEk3lQA3rL3kleROj39mhGSPCttVmI2pg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 09 Jan 2026 09:59:17 +0100
Subject: [PATCH v2] doc/releases.rst: add whinlatter, move walnascar to EOL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-update-releases-rst-v2-1-f4a92b7352e9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAGTDYGkC/32NQQ6CMBBFr2Jm7Rim0IS68h6GRSmD1CAlnUI0h
 LsLuHf5kvffX0A4eha4nhaIPHvxYdhAnU/gOjs8GH2zMahMaVJkcBobmxgj92yFBaMkLPLcZmV
 JujAFbMsxcuvfR/Ve/Vim+sku7and6LykED/H7Uy79/9hJiTMTWt1Q8bVurzVIaTeDxcXXlCt6
 /oFFtjISsoAAAA=
X-Change-ID: 20251219-update-releases-rst-433a08815494
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=Z6EiK21/T87jxZ7WgMJzfsE7mOdlVAIA8xTKAIO+KeU=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpYMNzMlE+911E5K5O5UsdImMsUUPwXjxDn8KWj
 56K06oi7buJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaWDDcwAKCRDRgEFAKaOo
 NuPgD/9Cgf8hztHiT3LsvZwtQIROgK6i3obVvgeDNGUzAV8jPYLt0h35rV7rzu6KWBZ0UE1DR+q
 L+0Kq2K0Gq68zcSNY25W/2vpg0XQ3jOe8zhy/Fl/hLoIQky/7f+GT1Ka/Epm112nzndLs4KvByS
 bqVyc04YnFikTUO6FxIp+9S3u0arx3lFdkkRLUXd6iIi2tggziSn+sw62wVtHfn4Sbb8nIDKRhj
 /R6ua+XDFbnVJdykUxe+42j/4/0E8m9UxAR0ubcsZiRz+zN4+5TYBQTl+XvV+mgU5Gq79qusww0
 RbqvEc4ssxPZo2mD8kYXNEzcpB8JpzMVjRWWZSDfrySyY7q9+FGtrRKCd5Cfr6WVPoVuSlRg+ju
 18E4FE2wpP8mnCVUOg03ebbi1h9NHTvfC0MAxVHbTe49+gDZ60De21409PtprC+MnZx2hOQr/G+
 wveZmiRYRmB1LGkBBwvbobI6tiXaXrXBvNv9DX94MeZ9q6vYSaYxAep/pw/BnHy9ehRkjFE6MYp
 3JUx0CNdbsa3Yqdpal199kIpS30RsbLJBQuelmUhYiKuit0Ra3h3xLLMr20dcQo42k+w6PB/v+s
 dNcK1Uf3LTiG7qyEo7cDJliChjWq9xZcf1UkIUO+0S21iCWFnlE/wu02lPQMOh+bLbBRG/y6o8h
 PjSmZ+1QGjwmsdw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Jan 2026 08:59:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18718

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
Changes in v2:
- Fix bitbake branch version for whinlatter, which is 2.16, not 2.14.
- Link to v1: https://patch.msgid.link/20251219-update-releases-rst-v1-1-39fa5d19cb58@bootlin.com
---
 doc/releases.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/doc/releases.rst b/doc/releases.rst
index 676db66ec5..a0b0ce766e 100644
--- a/doc/releases.rst
+++ b/doc/releases.rst
@@ -4,11 +4,11 @@
 BitBake Supported Release Manuals
 =================================
 
-******************************
-Release Series 5.2 (walnascar)
-******************************
+*******************************
+Release Series 5.3 (whinlatter)
+*******************************
 
-- :yocto_docs:`BitBake 2.12 User Manual </bitbake/2.12/>`
+- :yocto_docs:`BitBake 2.16 User Manual </bitbake/2.16/>`
 
 *******************************
 Release Series 5.0 (scarthgap)
@@ -26,6 +26,12 @@ Release Series 4.0 (kirkstone)
 BitBake Outdated Release Manuals
 ================================
 
+******************************
+Release Series 5.2 (walnascar)
+******************************
+
+- :yocto_docs:`BitBake 2.12 User Manual </bitbake/2.12/>`
+
 ****************************
 Release Series 5.1 (styhead)
 ****************************

---
base-commit: 6e511d035a3d1e4129dab7b0dfbf216bd8e99b47
change-id: 20251219-update-releases-rst-433a08815494


