Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924BCC05023
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 09:03:02 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.42182.1712912575775805837
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Apr 2024 02:02:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=WUnWOu0t;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4DEE81BF206;
	Fri, 12 Apr 2024 09:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712912574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmltSZ8h2YgE+k6gGFI6Hsz3R/QXFiZUGWOT2Dp1QsU=;
	b=WUnWOu0tJoemaqo9in2VTnH6vBcIlOWPrB8Aber9tX/MvEQ8Zckw10/lmsnG41yTpd1i8u
	tG09MOyQgEd5NdHQFLJKtBFNgtC9mLaNC7bkkLkQAC6Hk+QHyJ39cGookPZLtejQ/Zqe9H
	5savbJjrW8a1txWk9V8iVrl7iYZkA539inQbQ3mILOdXGPGJwt4R3MvbJb9/UJ1E6jboHF
	0I2EHzUNjb1uggRp6bHXYgG5E/NgRc25bWf6pQ+N7BtYt7ABag8p9rrFk/f/R505Sdv71L
	YKz6TcwfAjJwna/9R+gCzu3kItSFNgfuTFU7+b5MOV6IYOXC1SB6anRLmUFGGw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 09/12] prserv: correct error message
Date: Fri, 12 Apr 2024 11:02:31 +0200
Message-Id: <20240412090234.4110915-10-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412090234.4110915-1-michael.opdenacker@bootlin.com>
References: <20240412090234.4110915-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Apr 2024 09:03:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16084

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

according to db.py, prserv.NotFoundError is returned here when
adding a new value to the database failed

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/serv.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index d1ce74e066..dc4be5b620 100644
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


