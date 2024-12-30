Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4D3E77188
	for <webhook@archiver.kernel.org>; Mon, 30 Dec 2024 12:40:41 +0000 (UTC)
Received: from esa14.hc324-48.eu.iphmx.com (esa14.hc324-48.eu.iphmx.com [207.54.69.24])
 by mx.groups.io with SMTP id smtpd.web10.61334.1735562433460861048
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Dec 2024 04:40:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=DHFDraTM;
 spf=pass (domain: bmw.de, ip: 207.54.69.24, mailfrom: prvs=087d82423=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1735562433; x=1767098433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sWkYgepd3vXd8yRat6bCuRC7Kl4KNXou4+CO524Y//E=;
  b=DHFDraTM/5PvxNJiu0Qu/Rddr/FGkeACg+6yQw1dfu17T504+qWIrNH2
   Ld0hpqsw9287JR6yZvjlRR4ErH/ek9MakO4V4CNSfBs2MWvFT843/NsMk
   yuo9xmlxTmAx7ALhK1hr63xp7suFDv25Mc/MAwvYgIc611yf9VdTew9fB
   s=;
X-CSE-ConnectionGUID: zTxRE5YsTRGhiNqF/lYgpA==
X-CSE-MsgGUID: tsYvS8MPS+e4jsn0CIarGg==
Received: from esagw3.bmwgroup.com (HELO esagw3.muc) ([160.46.252.35]) by
 esa14.hc324-48.eu.iphmx.com with ESMTP/TLS; 30 Dec 2024 13:40:31 +0100
Received: from esabb2.muc ([160.50.100.34])  by esagw3.muc with ESMTP/TLS;
 30 Dec 2024 13:40:31 +0100
Received: from smucmp07b.bmwgroup.net (HELO SMUCMP07b.europe.bmw.corp) ([10.30.13.60])
 by esabb2.muc with ESMTP/TLS; 30 Dec 2024 13:40:31 +0100
Received: from localhost.localdomain (10.30.85.202) by SMUCMP07b.europe.bmw.corp
 (2a03:1e80:a15:58f::220b) with Microsoft SMTP Server (version=TLS;
 Mon, 30 Dec 2024 13:40:31 +0100
X-CSE-ConnectionGUID: DcvuaiN+T/WpCgj+SWJYFw==
X-CSE-MsgGUID: Nh+cjTULR5KMlAFnfgrUhQ==
X-CSE-ConnectionGUID: /0MKhjlOSxyj/B/sW9+I9g==
X-CSE-MsgGUID: g3b/aNJFQPiVtXe6sqmerw==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>
Subject: [PATCH] asyncrpc: Handle websockets exceptions
Date: Mon, 30 Dec 2024 13:35:47 +0100
Message-ID: <20241230123547.2593913-1-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp10a.europe.bmw.corp (2a03:1e80:a15:58f::1:26) To
 SMUCMP07b.europe.bmw.corp (2a03:1e80:a15:58f::220b)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Dec 2024 12:40:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16951

The websockets library throws a number of exceptions which are currently
not caught leading to unhandled exceptions in the idle loop.

Fix this by catching them and reexposing them as a `ConnectionError`
which is the exception expected by users of `asyncrpc`.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/asyncrpc/client.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 9be49261c..17b72033b 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -112,11 +112,16 @@ class AsyncClient(object):
             )
 
         async def connect_sock():
-            websocket = await websockets.connect(
-                uri,
-                ping_interval=None,
-                open_timeout=self.timeout,
-            )
+            try:
+                websocket = await websockets.connect(
+                    uri,
+                    ping_interval=None,
+                    open_timeout=self.timeout,
+                )
+            except asyncio.exceptions.TimeoutError:
+                raise ConnectionError("Timeout while connecting to websocket")
+            except (OSError, websockets.InvalidHandshake, websockets.InvalidURI) as exc:
+                raise ConnectionError(f"Could not connect to websocket: {exc}") from exc
             return WebsocketConnection(websocket, self.timeout)
 
         self._connect_sock = connect_sock

