Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA5CD129C
	for <webhook@archiver.kernel.org>; Fri,  5 Apr 2024 16:41:48 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.17458.1712335302519769183
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Apr 2024 09:41:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=oCBqEHg2;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0F31C0005;
	Fri,  5 Apr 2024 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712335300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSWqVC9eYVk500ijX1Trr47OAQDUG1I8fUSpoqvkE5k=;
	b=oCBqEHg2/pXGIbOQPuDKi6cKwWVYQreoKyHnfseFvqis6oxhwpkB5ktPhmy+swJA9LfdOq
	QTs1GE/MmLzYJgQt9n50LlnCRnZZ8CPrkTGAz/bFEuwvRT0FvukIZqOZAOE5R0pxYwt1pq
	RHASJcRxeqtxR9rSgL6Xld50EXduA2GWyYcXX6DlsvcUu8ssMzgKfaKc7BVrbIOYsngGYh
	Q97NVOrmPtnVkynKZpL+oDaXVTVbaQuWXcetbuYfJjnVvpxaAy6QwedmpDlsHAclg9O+4w
	1/1imaKyvSLLsRlB+a52dxdUi0T2DM6jSshUAuDF7w0dwfoBNWf11moSuDFdQQ==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 05/12] asyncrpc: include parse_address from hashserv
Date: Fri,  5 Apr 2024 18:41:18 +0200
Message-Id: <20240405164125.1652579-6-michael.opdenacker@bootlin.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16053

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Moving the code and related definitions from
hashserv/__init__.py to asyncrpc/client.py,
allowing this function to be used in other asyncrpc clients.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
Suggested-by: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 lib/bb/asyncrpc/client.py | 23 +++++++++++++++++++++++
 lib/hashserv/__init__.py  | 27 +--------------------------
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 29a5ab76aa..a350b4fb12 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -10,11 +10,34 @@ import json
 import os
 import socket
 import sys
+import re
 import contextlib
 from threading import Thread
 from .connection import StreamConnection, WebsocketConnection, DEFAULT_MAX_CHUNK
 from .exceptions import ConnectionClosedError, InvokeError
 
+UNIX_PREFIX = "unix://"
+WS_PREFIX = "ws://"
+WSS_PREFIX = "wss://"
+
+ADDR_TYPE_UNIX = 0
+ADDR_TYPE_TCP = 1
+ADDR_TYPE_WS = 2
+
+def parse_address(addr):
+    if addr.startswith(UNIX_PREFIX):
+        return (ADDR_TYPE_UNIX, (addr[len(UNIX_PREFIX) :],))
+    elif addr.startswith(WS_PREFIX) or addr.startswith(WSS_PREFIX):
+        return (ADDR_TYPE_WS, (addr,))
+    else:
+        m = re.match(r"\[(?P<host>[^\]]*)\]:(?P<port>\d+)$", addr)
+        if m is not None:
+            host = m.group("host")
+            port = m.group("port")
+        else:
+            host, port = addr.split(":")
+
+        return (ADDR_TYPE_TCP, (host, int(port)))
 
 class AsyncClient(object):
     def __init__(
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 552a33278f..74367eb6b4 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -5,39 +5,14 @@
 
 import asyncio
 from contextlib import closing
-import re
 import itertools
 import json
 from collections import namedtuple
 from urllib.parse import urlparse
-
-UNIX_PREFIX = "unix://"
-WS_PREFIX = "ws://"
-WSS_PREFIX = "wss://"
-
-ADDR_TYPE_UNIX = 0
-ADDR_TYPE_TCP = 1
-ADDR_TYPE_WS = 2
+from bb.asyncrpc.client import parse_address, ADDR_TYPE_UNIX, ADDR_TYPE_WS
 
 User = namedtuple("User", ("username", "permissions"))
 
-
-def parse_address(addr):
-    if addr.startswith(UNIX_PREFIX):
-        return (ADDR_TYPE_UNIX, (addr[len(UNIX_PREFIX) :],))
-    elif addr.startswith(WS_PREFIX) or addr.startswith(WSS_PREFIX):
-        return (ADDR_TYPE_WS, (addr,))
-    else:
-        m = re.match(r"\[(?P<host>[^\]]*)\]:(?P<port>\d+)$", addr)
-        if m is not None:
-            host = m.group("host")
-            port = m.group("port")
-        else:
-            host, port = addr.split(":")
-
-        return (ADDR_TYPE_TCP, (host, int(port)))
-
-
 def create_server(
     addr,
     dbname,
-- 
2.34.1


