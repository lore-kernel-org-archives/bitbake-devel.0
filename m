Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF195C54E41
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 17:12:08 +0000 (UTC)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
 by mx.groups.io with SMTP id smtpd.web10.258.1709745114513513243
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Mar 2024 09:11:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=YYjKKg2P;
 spf=pass (domain: bootlin.com, ip: 217.70.183.195, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C202E60004;
	Wed,  6 Mar 2024 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709745112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0HNJ75i435wDeuDDjzighN8RXOy7Wxa0N3G7thlOn8g=;
	b=YYjKKg2P0Mb10moI1kVEIpsRn1ADCnODWo/lz2RP+AVmryeELHASVUn93fMEkow/+KhMEo
	yVt0urR3lx4pxKQy81jTFYZMcGLGJYxk/TmbiHHnQgSGk7I1BjOdahOqPtlWyiyvQd4Rt7
	1PIzhqdQ5c5I44ZOXoXh0y5ljbRHm0hxO1g6DhR1FXXtCqTHM1NRn3gvT53Eaf3zDCh8tb
	5+tpxd8kXGhcZBqkoXnxpG2LqCn/+dS/FjoO9xp5vb18x9rgop1FNwPbqU18ArgjbBdoWC
	dC4HREDEFgnoTrRfBpzoY3v2Ne3QH+o4igFtolJm/oMuJYmTrIf+loF/b8Ostg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] prserv: remove dead code in exception handling
Date: Wed,  6 Mar 2024 18:11:44 +0100
Message-Id: <20240306171144.1874798-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Mar 2024 17:12:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15990

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

As explained in https://docs.python.org/3/reference/compound_stmts.html#else-clause,
the code after the "else" statement won't be run as there is a "return"
in the "try" block.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>

---

See the whole code on
https://git.openembedded.org/bitbake/tree/lib/prserv/serv.py#n38
---
 lib/prserv/serv.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 5fc8863f7..5032f7cd7 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -40,8 +40,6 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         except:
             self.table.sync()
             raise
-        else:
-            self.table.sync_if_dirty()
 
     async def handle_get_pr(self, request):
         version = request['version']
-- 
2.34.1


