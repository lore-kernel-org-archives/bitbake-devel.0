Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C1CD11DD
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:40:28 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.31.1711723227243929616
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:40:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=loDtvtRm;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B32B3C0004;
	Fri, 29 Mar 2024 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjad1F2DlqYmiwAQ5co92HERFnqOdXslsv9F3W0fQ80=;
	b=loDtvtRmCgXGw8HnF07JRIOqbjeQBia6cdhSdBF4r4EXUkyg3IMX4w42j+zrCjuzYQJX3A
	M4BSfC4b5K5yztChBMS7iggc00hobyhDDo14T86ThnHqPQwTmQQUW7UU5KT19Z2SM7utDy
	v9u5fAbor97phnm1s++aE1nQ9BJBC3vkk+ObzA0FOKf8CkP6YwjKwJC9qNJ3qON5XrJziS
	3W0a1wIC7UzoHE78CFbiDJh3L8EtYOgdj11+sEfhlPGucINYzQYVxw0U5VtUKTiQ0q+yOA
	bgZW+QxZAbqZJfI5qHxSNWOiIvtKWJ85hFY9NWZDRX/9o24bhpIgK8PCJ78Jhw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH 07/12] prserv: fix read_only test
Date: Fri, 29 Mar 2024 15:39:51 +0100
Message-Id: <20240329143956.1602707-8-michael.opdenacker@bootlin.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16029

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

read_only is an attribute of the parent server object, not of the client.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
---
 lib/prserv/serv.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 242cd11a5a..efb2e0cf93 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -61,7 +61,7 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
 
     async def handle_import_one(self, request):
         response = None
-        if not self.read_only:
+        if not self.server.read_only:
             version = request["version"]
             pkgarch = request["pkgarch"]
             checksum = request["checksum"]
-- 
2.34.1


