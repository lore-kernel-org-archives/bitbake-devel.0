Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18BAC04FFE
	for <webhook@archiver.kernel.org>; Sat, 11 May 2024 11:03:05 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.12400.1715425385439540837
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 11 May 2024 04:03:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=U6hvM+tB;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D6DE120004;
	Sat, 11 May 2024 11:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715425383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8BiNHWZedTQUDworzQJJA7RM4WypooYTjRHh0Fw20Nw=;
	b=U6hvM+tBzqkwkOpSLS8/goYyFID63dOaeMWOvLIsP1zC7XIX/BTlYJzmgskpNfQrgdbLAl
	hWddYLV0/oIUnpXsIA3hFo3EFjwuCqeEsUM5rKlbkj9rj9Hb5wWAvjfVZp462Ocy6BxISi
	K1HOEWrV0penujAjiOYuI8FM/vAC4hw3uKMb2Cbu2l0xsbHakVahhtBItfvoMw3mQI8moY
	4ltKfKVkwnN9wXhH0Jf1Iqug2KIwX2PLh4iMQH5CxDeERT6btPYwpOam7oP1a8mKvSqhR4
	xYddJ+nS8KpASXZPB4+ZqK0WAib1KVas8P/+ZW9Rj7eMfu5vHNOVL7FClZosoA==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v7 1/8] prserv: declare "max_package_pr" client hook
Date: Sat, 11 May 2024 16:31:28 +0530
Message-Id: <20240511110135.1887578-2-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511110135.1887578-1-michael.opdenacker@bootlin.com>
References: <20240511110135.1887578-1-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 11 May 2024 11:03:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16200

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


