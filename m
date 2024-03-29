Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AC7CD1293
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:40:28 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
 by mx.groups.io with SMTP id smtpd.web11.28.1711723226172600666
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:40:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=ADJgQjDh;
 spf=pass (domain: bootlin.com, ip: 217.70.183.201, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D96E1BF207;
	Fri, 29 Mar 2024 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaCtMatgb1hwvYnCGaN8RiVGv0br/058v/0hyi2SfyA=;
	b=ADJgQjDhV+aSMhDC08L6MGJvxeo0Bm/17nI422l7TjMoIOtdfvqwRX8FFByV7H8IsdseTY
	91qcikDqjx2fKMO1jOTpExGUwluM6p3f5NMxHi8YW+4xVZ8YpiTrmkmiVTGUPYFXyc6ZtL
	lE5FHBaLX/uhcG+Wa7dUEyoX3EynGxzY0UyDGmRSSe4CwFE6ucNBkols/R+zIUcnV6s6fh
	NXMqYIWb6ZvcC2nprd2SHA/u51lJodkmCXawohbBXogLoN7NzePfXQ9PeZXgZG/kjgvhpP
	4xrcEMhpC9Kp+N8+y0ZWxuxWimGC0/cYjWYTbm219zUvqivNAVECKKSgLNN0KQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH 04/12] prserv: use self.logger instead of logger directly
Date: Fri, 29 Mar 2024 15:39:48 +0100
Message-Id: <20240329143956.1602707-5-michael.opdenacker@bootlin.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16026

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

In both the PRServerClient and PRClient objects.

This aligns with what is done in hashserv/server.py and makes it
possible to benefit from possible specializations of the logger
in the corresponding super classes, instead of using
always the global logger.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
---
 lib/prserv/serv.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 874edd7069..eafa76673c 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -53,9 +53,9 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
             value = self.server.table.getValue(version, pkgarch, checksum)
             response = {"value": value}
         except prserv.NotFoundError:
-            logger.error("can not find value for (%s, %s)",version, checksum)
+            self.logger.error("can not find value for (%s, %s)",version, checksum)
         except sqlite3.Error as exc:
-            logger.error(str(exc))
+            self.logger.error(str(exc))
 
         return response
 
@@ -82,7 +82,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         try:
             (metainfo, datainfo) = self.server.table.export(version, pkgarch, checksum, colinfo)
         except sqlite3.Error as exc:
-            logger.error(str(exc))
+            self.logger.error(str(exc))
             metainfo = datainfo = None
 
         return {"metainfo": metainfo, "datainfo": datainfo}
@@ -105,7 +105,7 @@ class PRServer(bb.asyncrpc.AsyncServer):
         self.db = prserv.db.PRData(self.dbfile, read_only=self.read_only)
         self.table = self.db["PRMAIN"]
 
-        logger.info("Started PRServer with DBfile: %s, Address: %s, PID: %s" %
+        self.logger.info("Started PRServer with DBfile: %s, Address: %s, PID: %s" %
                      (self.dbfile, self.address, str(os.getpid())))
 
         return tasks
-- 
2.34.1


