Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF8DC4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 20:14:30 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.32226.1714421669941524054
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Apr 2024 13:14:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=AGSHLWFG;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24ADB1C0008;
	Mon, 29 Apr 2024 20:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714421668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BiNHWZedTQUDworzQJJA7RM4WypooYTjRHh0Fw20Nw=;
	b=AGSHLWFGwnCVmAj3ij+Cz3lx4i8r5Wotk0F0fbe6lAwcB60HU61QTQRLbzhqZsUsWE0Bmv
	/T8FwNHk/7x7VVbw1vJsX5JRMZYicPU8jIxLr3G2ZaDS93v12Dwh+jQQbBphCZ8UApvy2B
	C7Xe7zmgaQWZFXUN6JqCj04fQs5WYMdHwqZ2q7ZGxaC4UmGVOkrmFFvasZXnw6LsLJI9wl
	PNa0K4MEY44lOpqg8bUn+/a/+tIvWex/WZQ5Qlo/XxasdugA7ktEqHSLtGExXR6Byr3aiP
	dco7kv2BoqmcXCk/JztVXL91DQh/SCt4k6K/RplHrUJRILGvFiIAoyo2WNLTFQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v5 1/5] prserv: declare "max_package_pr" client hook
Date: Mon, 29 Apr 2024 22:14:14 +0200
Message-Id: <20240429201418.657042-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Apr 2024 20:14:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16150

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Add missing declaration for the max_package_pr client hook

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/prserv/client.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/prserv/client.py b/lib/prserv/client.py
index 8471ee3046..99fc4e0f7f 100644
--- a/lib/prserv/client.py
+++ b/lib/prserv/client.py
@@ -65,7 +65,7 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
 class PRClient(bb.asyncrpc.Client):
     def __init__(self):
         super().__init__()
-        self._add_methods("getPR", "test_pr", "test_package", "importone", "export", "is_readonly")
+        self._add_methods("getPR", "test_pr", "test_package", "max_package_pr", "importone", "export", "is_readonly")
 
     def _get_async_client(self):
         return PRAsyncClient()
-- 
2.34.1


