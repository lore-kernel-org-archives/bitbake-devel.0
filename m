Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D00DC48297
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 16:20:47 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web11.15935.1707495638109214014
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 08:20:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=PpRcae6q;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F894240003;
	Fri,  9 Feb 2024 16:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707495636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9z+FPIy085a2JzYWb1pgzbdEvFgtdVAlQat6d+cGXew=;
	b=PpRcae6qgv4TbL0g0vuM8YL9VOxN5TDBqheZpe8LIUp5tsZmB8esr3UN5m8HJQI8AQaV0F
	fPmRX6+ObY5jeSVNz30DhlD3fE7XBnvQi4TQthWeuOBmZDFP3CcYLXZ0/lpYoNPmzd9urV
	quoaYO41rzBoyIgDlztdMqJR9L1iOxipmveQM+DoS8A76XeVeAEnxxzcPW2/hbzPaT62Z7
	uujcY+9H8JmRNbxDl5JWycZOAnUcm0hMm5rxEvnAGECnyNX3CWBEs8pjdap4KRJ/wbuONs
	tW/G96KmhLCOtBIsjnrlt16lXRpneZPuDJqFoM3El0HpGdmUP5F9/viSXC4hig==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] doc: README: simpler link to contributor guide
Date: Fri,  9 Feb 2024 17:20:18 +0100
Message-Id: <20240209162018.454006-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 16:20:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15859

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/README b/README
index 38a461f5c..e9f4c858e 100644
--- a/README
+++ b/README
@@ -18,7 +18,7 @@ Bitbake requires Python version 3.8 or newer.
 Contributing
 ------------
 
-Please refer to our contributor guide here: https://docs.yoctoproject.org/dev/contributor-guide/
+Please refer to our contributor guide here: https://docs.yoctoproject.org/contributor-guide/
 for full details on how to submit changes.
 
 As a quick guide, patches should be sent to bitbake-devel@lists.openembedded.org
-- 
2.34.1


