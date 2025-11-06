Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FC0CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 09:23:46 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10820.1762421019682406745
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 01:23:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=g4yjy0Ud;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 52A734E4155F
	for <bitbake-devel@lists.openembedded.org>; Thu,  6 Nov 2025 09:23:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A4E36068C;
	Thu,  6 Nov 2025 09:23:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D457118503CC;
	Thu,  6 Nov 2025 10:23:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762421017; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dlrPpa+h9rWpU8SfUTAUGaBDzSD6jY375gYxV0hq7/w=;
	b=g4yjy0UdwqDpmIjX1U9jlEq6qqCe/PFc8C9sLpFuk1g4C9JoXIsr6oQKvQae8/LyVqdIwQ
	OSHdZcX/SvfY3bqp4M77gLegknLgTh2/DOW3ufjvJ3HORKwU/LxtCmyPP/dB0fK/PwYunW
	4jFF300ao3aUZjoUgfpGh5rXCDf99aKRFoIbFO4Q42RU6qfnvOeK9Qq+fsplsZAC6owlGx
	iWhEBQoNTDW2l/BrZKhpWXFjw2/8LuqyEPJOEJnp1iOzd/Ln09d9fTYpRH+yyRcpkCSkCd
	+YtIDo+r4vkZl1Iv2YKbrkqx6n/Y52vid5xkWXL0wotBlZ3wIE6TGkrcYO7quw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Thu, 06 Nov 2025 10:23:30 +0100
Subject: [PATCH v2 1/2] doc/conf.py: add wikipedia extlink
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-bitbake-setup-v2-1-2722ef759c35@bootlin.com>
References: <20251106-bitbake-setup-v2-0-2722ef759c35@bootlin.com>
In-Reply-To: <20251106-bitbake-setup-v2-0-2722ef759c35@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=652;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=8Uyj02sdsC+CaHZ7lVuFOsunetTYcsZQ2pPDNsTWABg=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpDGkX0YviCoh2A3qeGdTnqrEpj2xvQJ3sJnF+P
 aSkf4ZcqUGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaQxpFwAKCRDRgEFAKaOo
 NsXoD/wODIxtak6stbIULi8IAGglM2eHUu4zY5T05XLW4r04pc4F2O1uTy0q7/MownM5HbcU0v3
 BdXetkKty9YDbrzGD8sh1C77kJC2Tf3I/vBUevPHldGZpq4WYPwQODff5utkEU6e73PILD9sBTa
 wAvAvfXjwn22iGLJzFXJX32JKcW/Gbyz+agbEurK310MAv7mWa10hSJBNmX02+GIXAXKNHbvT1q
 PMBvib4JihOV67eg/z4CoE3Alm4IZcWtHxjufzG8jGV0VQZAnFw+5T00KcHBJVQ80cF8hqt164r
 dWAJOJK/W87NRBrKlPmWx3IasduskAVVjr9UMlSTsTfo62xJjOIk/2THHzXys0nWLkMN/aSsO7X
 I9RkWBLUlLFMXcCFGhItXr8jVC5EXGlbIuuadVzYykv+ZJJuzRisFBmv2WFmD6sZpK/Kt8Rx2Oe
 2b5zpoFFSi58p437cvlUdt/0UWfybNujh4dCIPNJ7L2niiCvgkF7eFD/6c0Sjrui3dVw/ytbreX
 YEdlPDsgpx5Yzhewzfoec1bUEgFRaN4dw9hY85LXVuayHTCd0DcLGYQbzcHpEX91nhkztNcF+tY
 Z2s9Kdg47hyrxr1+Hd2LQnXv0Pyf/gxax1HvDw63SJTECcmn/qmSxRxMQLHxdSYRZD/fe1t0nH4
 l2PXjuTc2pcrj/Q==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 09:23:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18283

For use in the documentation.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 doc/conf.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/conf.py b/doc/conf.py
index f61241e28b..bce386624e 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -39,6 +39,7 @@ author = 'Richard Purdie, Chris Larson, and Phil Blundell'
 extlinks = {
     'yocto_docs': ('https://docs.yoctoproject.org%s', None),
     'oe_lists': ('https://lists.openembedded.org%s', None),
+    'wikipedia': ('https://en.wikipedia.org/wiki/%s', None),
 }
 
 # -- General configuration ---------------------------------------------------

-- 
2.51.0


