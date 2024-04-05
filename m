Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F54CD12A0
	for <webhook@archiver.kernel.org>; Fri,  5 Apr 2024 16:41:48 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
 by mx.groups.io with SMTP id smtpd.web10.17460.1712335305658317507
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Apr 2024 09:41:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=oQuk8aJN;
 spf=pass (domain: bootlin.com, ip: 217.70.183.193, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8049240003;
	Fri,  5 Apr 2024 16:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712335303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmltSZ8h2YgE+k6gGFI6Hsz3R/QXFiZUGWOT2Dp1QsU=;
	b=oQuk8aJNAwGjt0m8RvPFbsatkYEE72BbfKNTmTJzwYH9x3a498wgDNY9I0F3/bWM70L5ti
	b+3HVLIiyLvDu1cW9cVd6XdjuFXig9JyyQqYBjX5VR+O8PvTcvV6gB8iUsPe7NzB00+jet
	p7w03FtfJZwsDymBRehd4ZdCs0Jk8ptflE0Dsp20a8CvVEXM5y6uBETgveha/l+i+QXpfN
	ermYhGokweAXZIG8P66QtM1NZUP55gZ79yG5/b/kWK8KXaQpbPHiOQDu14DfC3BvwWvIYx
	GS92awX1wJP5NBkrY00eYQN+jYYzGCMTjonxxoduQ4WlWEfgd1t06sGgwE0zNQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 10/12] prserv: correct error message
Date: Fri,  5 Apr 2024 18:41:23 +0200
Message-Id: <20240405164125.1652579-11-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405164125.1652579-1-michael.opdenacker@bootlin.com>
References: <20240405164125.1652579-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Apr 2024 16:41:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16058

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


