Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DD8CD1292
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:40:28 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.32.1711723228349102969
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:40:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=krBrEqof;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E04501BF209;
	Fri, 29 Mar 2024 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewbCccP+tUGDul/E9eAtsKyOg+SD070Nt1YF32bCuK8=;
	b=krBrEqof2OIj03nZ9Xp6ZsNxKM1DSLqKZywTZavqRf0IdMOWt8LDEoCeKjtE0cZElgGScg
	w+/RZLUgMknCiXJb1ifoYoYGlYf8vEUQBTEEYUrRL1P3FAMq06Xl6o81rT27SWL6SvwVog
	4riepnh2qDpYbEik7D6bzD3mE6yC4BzNBaBy9ZL7oxJ1uiM4x29TjaAxP3QwWQkHSUeA34
	UYcvZ7JJPsaYx0iY121URKunT62ZClz3N8KLqn4dT6cEKpbq2iv46YesGYktvdbC4yYzzc
	Ge7jzq5EcI+ZUntK0VQb51j0KlYWy+K9Nu4CgQOCuSU5oJLjijJSdkqZRF922A==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH 09/12] prserv: remove redundant exception handler
Date: Fri, 29 Mar 2024 15:39:53 +0100
Message-Id: <20240329143956.1602707-10-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
References: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Mar 2024 14:40:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16030

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This exception handler is already present in db.py's get_value() code.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
---
 lib/prserv/serv.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 473dfa790c..127036f9cc 100644
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


