Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B3DD78771
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 13:19:09 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16499.1766150343429994866
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Dec 2025 05:19:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=UmQYMInt;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 491A64E41CB5
	for <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 13:19:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15A4D6071D;
	Fri, 19 Dec 2025 13:19:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 32707102F0B74;
	Fri, 19 Dec 2025 14:18:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766150340; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=TtHaDoefakF5Zhp8m+m3DyKgNlVU1o96DCDytOOP+yE=;
	b=UmQYMIntqt4GLj2EO08to3+nPaGiSCn874+/ltzXJ8IuGjszx+FAfIrUJaVsDOfL9aOcdg
	NMx9qyMK7eMkANfQXHQXEJLczaUQbswFwNM8k26the2x6Az3yL+xjfPH+ogy9NsYcru/AJ
	GINYk6hYUJOML14ahTJLx4Tg9wlQ6WZts3ILZHslAxxAjRYyFqpoFGqxpK1KQ80AWmV+AN
	0iw8A3vpuGHPWk+GdJPdCwtBCE1kJNeNqxuHQLT90bmkha+KFzHnsiU8RlvV9ZxMvngstS
	CKFQMAKWg0mdbZFrfPrgPtVuVPJq/GcZ8Tod83AK5sqeQq7Aw7VGZb4SANFsUQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 19 Dec 2025 14:18:55 +0100
Subject: [PATCH] doc/releases.rst: add whinlatter, move walnascar to EOL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-update-releases-rst-v1-1-39fa5d19cb58@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAL5QRWkC/yXMQQqDMBBG4avIrDtgYgTtVUoXUf/qlGJlJoog3
 r1pu/wW7x1kUIHRtThIsYnJe85wl4L6Kc4jWIZs8qWvnXctr8sQE1jxQjQYqyUOVRXLpnF1aAP
 lclE8ZP9db/e/be2e6NN3Ref5ASMj8x13AAAA
X-Change-ID: 20251219-update-releases-rst-433a08815494
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=3SQHarBC/99a81gvYJvJpaDs89OpA9OCfPDl921cKBc=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpRVDDs3EkJ5M/0Z3WP78/tSxNAqX5XwkK4xqKe
 sVTCXi/XQCJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaUVQwwAKCRDRgEFAKaOo
 Np4lD/9NY0QSpH389oRwq7h67XfDzgODkcZkckt2bd0gOPRv5cwVWLpBujtznPEk9yiv0uUGwg6
 B+HHGBOVeIfkTOhO3Hc+W2FyrT4c3pfrNkcC8FJwVdWrCVUOoLGkZVzVfkhO2p2oRkaX/+6jclD
 A1sc1u0etxtnAlDREptm1H7P6Oj4sZ24uw431+H+HfBHWRjJtvlFK6RNSZsgvVVcM+ffxxLLGOu
 2ao7PpQ+2dYNFf37jYAsY9i8ef0cPVFPrc8lb6STVX3GM6z7C0WhnxzF2P9mPMcovw3yAp2IO40
 StaPcoBbvA158n2RlHu1jih9AJowCf7sBAuJzeIKDEIAaNyR4/9uicQV01HyOq2QreVeEN8gR0h
 R575dF0HehnEqTG2TVib8Gm3EXXkodkFw2NBeMyFufdcYEiqOCAtu3ymJuwexCymOIItC/mZd2s
 y9stebb4H3DsuuZswvgZEJe8pHA5QQqDFtfmXcPY6uU2cbtUnCku7jTmbpnuOmWZNktzkUJF8Qd
 Ybf15M5YcSSnXG920DieJCepq/h5j3gAqgMr3AzRf00uJxgLKpEFHQNVCYcDJQbXGRTieUSC8k5
 vthZx1+CdOfNoorECxGowWTebTE3IsUagivVysKP+vqNq+NK7I3W+1HZ8Uv7WyvlgZ5KLoMVqa3
 MenRl6ol2/R0NiQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Dec 2025 13:19:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18621

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/releases.rst | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/doc/releases.rst b/doc/releases.rst
index 676db66ec5..ed96650b7c 100644
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
+- :yocto_docs:`BitBake 2.14 User Manual </bitbake/2.14/>`
 
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


