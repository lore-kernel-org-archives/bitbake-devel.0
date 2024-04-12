Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA74C0650F
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 09:03:02 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.42607.1712912575387518441
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Apr 2024 02:02:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=VqpH6Zur;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF71BC0006;
	Fri, 12 Apr 2024 09:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712912574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWt+p3BwCcbfO+hapVrTtEEopipqQ03zbPb4MEfd72g=;
	b=VqpH6ZurgOEGMvjLj8fgtES05ell2Rqdpgesdv9v7OMox6O80IiAuMHS34e59DvjoCl3DQ
	lmRzKA7V2P9nS5P9uPIjVbvV/AmmXM4YwAqALvUK1SwYP8d/LkeAerFovNpBlThgV5hDwK
	Sfqmq7kHEdcOznCv95mFNxLvMWLQKJIrppguy+I7AseStCNfXNXX5B1OXvqXpONIQbOSo/
	Ic9UZtBdrDffgxsyxtHDPZmuFB0Q1V7IXlylNfpktuuL3dbgRALWE0WxjE3NwLUg01le+0
	gVSZZko02FmAt0MZ50dtoTQKFR/Forvkd5t49IvT8CF+5G0BNis/1jv1iR0baA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 08/12] prserv: remove redundant exception handler
Date: Fri, 12 Apr 2024 11:02:30 +0200
Message-Id: <20240412090234.4110915-9-michael.opdenacker@bootlin.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16083

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This exception handler is already present in db.py's get_value() code.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/serv.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 86bd3bb75f..d1ce74e066 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -82,8 +82,6 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
             response = {"value": value}
         except prserv.NotFoundError:
             self.logger.error("can not find value for (%s, %s)",version, checksum)
-        except sqlite3.Error as exc:
-            self.logger.error(str(exc))
 
         return response
 
-- 
2.34.1


