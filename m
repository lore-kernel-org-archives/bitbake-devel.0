Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8412CD11DD
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:40:38 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web10.25.1711723228741339574
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:40:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Sz5Zy9Mg;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50BFEFF804;
	Fri, 29 Mar 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CVZfoH7FOKEoFhEtJi3hRHM9nBKmUs2eTXO670wRawI=;
	b=Sz5Zy9Mgv7JNqE6ftmffMG+cHIBZSIuNJV2fIRkqyFplb/adXc52XOtR8FS3g3xpkE64lT
	RZ2kbLsqp134NgQuVptC+hXUXtW+FftPSRGv+48AHFnopqroWpJlZIvJ/qGQ85thckF5RP
	qa4vU3eTFPeoa0q56RKA7gSOcduaqMn6BSnotpci9xVJxvD8pfbOR9XIN1F/ngC//r7QP3
	DPJ0iwSm1Eg22BzTcNGiiFfDlZV4FlDx5o1lPJmkPxOnVOfwafHsYx58v4KwxcqZnnuwur
	sH46okgyz3iQ8YCa6DzcRhCv+EkxP6jcPGTH9xW21xqMEOYCK5XpUuSvONtZkA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH 10/12] prserv: correct error message
Date: Fri, 29 Mar 2024 15:39:54 +0100
Message-Id: <20240329143956.1602707-11-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
References: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Mar 2024 14:40:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16032

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

according to db.py, prserv.NotFoundError is returned here when
adding a new value to the database failed

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
---
 lib/prserv/serv.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 127036f9cc..604df6ce61 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -81,7 +81,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
             value = self.server.table.get_value(version, pkgarch, checksum)
             response = {"value": value}
         except prserv.NotFoundError:
-            self.logger.error("can not find value for (%s, %s)",version, checksum)
+            self.logger.error("failure storing value in database for (%s, %s)",version, checksum)
 
         return response
 
-- 
2.34.1


