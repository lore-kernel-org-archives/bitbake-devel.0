Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A46C19F4F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 17:15:31 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.21659.1714497330150562573
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Apr 2024 10:15:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=mfgEHmBp;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3850AC0003;
	Tue, 30 Apr 2024 17:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714497328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BiNHWZedTQUDworzQJJA7RM4WypooYTjRHh0Fw20Nw=;
	b=mfgEHmBpnEvVgpHtTiweGKznAOHskxW+WKqUMXLTxTY1jZ+7lqPJPgJTW+HHrE6hLJ6gEl
	VD9jdJaTgatHOaZ3+k/yeugjog9u/DeJi4dmD73b7uPG1Vn8x5al29NlOrSgwPtlZR3A63
	1yQlmQYTtsHXY9STiOZJ9SUEuRRSDaa/DojyXd9wpU0eJoxY4+uMOEdDzmJFWACWoOyA8w
	vdHFEOav91OqwdFr8X7fR5V6P0/wdhjHCyu5zdmbtPeJFXEJ8o4D4WYEXKDjcjE01y3q4+
	KOyf8hssGQz/TMK6zrfut6oTUEPUoy1XIwLYLP7MEPDzcF0rBd0KyAEDEG5WGg==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v6 1/8] prserv: declare "max_package_pr" client hook
Date: Tue, 30 Apr 2024 19:15:05 +0200
Message-Id: <20240430171512.936371-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430171512.936371-1-michael.opdenacker@bootlin.com>
References: <20240430171512.936371-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 17:15:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16166

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


