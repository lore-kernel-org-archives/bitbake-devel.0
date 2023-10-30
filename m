Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30294C00144
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:14 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web10.158338.1698693487660850331
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=C5pnIr2e;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ce327458a6so2456036a34.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693486; x=1699298286; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UYOyhxEl7PpAcVCSERVPjzNvG40y7Uw5OaUDui3ad0=;
        b=C5pnIr2eX0bYZHGShIVmteXTLX+RUkzq7OQIxOKeWj7n99vnBNMwFWMPt3wIKzQ/2W
         Stsq6Tla7eGF/ABaN43hZtXyri/pkniqUgdLEK5wb/Gw6Eh/hkc/u/kBk8o4py9JNOvi
         nuqnt810BzKTnp7BN9AjzN+RrLFzR29Yn0YmGgARpbY3kQUdDddzBa6dw8aepQy7rblw
         94d2r7+Tq2ruz5dKuIk4SoBQjcahmWUbAVtzqY04As8Bv3CvsQ5W+CZQk+iLPrRm92ZY
         xkXzM/7Gf4T1ZfgWSOCV8xnCGs8X2eLtrm26/kMDXk80287eEWyfmkLMeIJkHwwK5CvE
         qZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693486; x=1699298286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UYOyhxEl7PpAcVCSERVPjzNvG40y7Uw5OaUDui3ad0=;
        b=BoFQ9ikM4b9XY2V76dAhRReNz5lCqhVd9F5cuxvoz1SsM9qV5/xjWJGdIzNgmLVlK2
         xKnPwvJ3guClVBJsydUD6X0ISNeYQ9nlsOTUDLV2iR5hCmDSKaXfQnUG5zIV4f4D1sku
         bHKhiSFxexs9R6R5FMhXJY91SfacN4VRVNl7ZgrOKE1N6pISjtMXbdjFEg/BpiU4/xdu
         4z7RtfczMsi0pEkq4GJY13I2QTl9QWh+osJDCZbT9hUsvkeO5Bomy1lqFjywy3CB+Zop
         iFDnJCBJg4X7T5VGot/PCJJO5WXRVWsCfk7fAVoHDRpJAmeaJ7IlJDINjqLu6KwvuVl6
         2isQ==
X-Gm-Message-State: AOJu0YyXyKsqCghJPCtkXMiWQ02hHpgANVf206UBsH8bIq+yKZNfB5lT
	y1aTtwggXMBcuawJ48hTXHwM1+31f5A=
X-Google-Smtp-Source: AGHT+IEk1fR1gZjaFSYuI1qru7uledeXLRyUv6i0t2U8vBmj0NRBNU2l57izyObT8QEuFmLEVbpamg==
X-Received: by 2002:a9d:3e4a:0:b0:6b9:5735:d9dc with SMTP id h10-20020a9d3e4a000000b006b95735d9dcmr279583otg.14.1698693486375;
        Mon, 30 Oct 2023 12:18:06 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:18:05 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 10/22] asyncrpc: Add InvokeError
Date: Mon, 30 Oct 2023 13:17:16 -0600
Message-Id: <20231030191728.1276805-11-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15312

Adds support for Invocation Errors (that is, errors raised by the actual
RPC call instead of at the protocol level) to propagate across the
connection. If a server RPC call raises an InvokeError, it will be sent
across the connection and then raised on the client side also. The
connection is still terminated on this error.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/__init__.py   |  1 +
 lib/bb/asyncrpc/client.py     | 10 ++++++++--
 lib/bb/asyncrpc/exceptions.py |  4 ++++
 lib/bb/asyncrpc/serv.py       |  9 +++++++--
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/lib/bb/asyncrpc/__init__.py b/lib/bb/asyncrpc/__init__.py
index 9f677eac..a4371643 100644
--- a/lib/bb/asyncrpc/__init__.py
+++ b/lib/bb/asyncrpc/__init__.py
@@ -12,4 +12,5 @@ from .exceptions import (
     ClientError,
     ServerError,
     ConnectionClosedError,
+    InvokeError,
 )
diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 009085c3..d27dbf71 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -11,7 +11,7 @@ import os
 import socket
 import sys
 from .connection import StreamConnection, WebsocketConnection, DEFAULT_MAX_CHUNK
-from .exceptions import ConnectionClosedError
+from .exceptions import ConnectionClosedError, InvokeError
 
 
 class AsyncClient(object):
@@ -93,12 +93,18 @@ class AsyncClient(object):
                 await self.close()
                 count += 1
 
+    def check_invoke_error(self, msg):
+        if isinstance(msg, dict) and "invoke-error" in msg:
+            raise InvokeError(msg["invoke-error"]["message"])
+
     async def invoke(self, msg):
         async def proc():
             await self.socket.send_message(msg)
             return await self.socket.recv_message()
 
-        return await self._send_wrapper(proc)
+        result = await self._send_wrapper(proc)
+        self.check_invoke_error(result)
+        return result
 
     async def ping(self):
         return await self.invoke({"ping": {}})
diff --git a/lib/bb/asyncrpc/exceptions.py b/lib/bb/asyncrpc/exceptions.py
index a8942b4f..ae1043a3 100644
--- a/lib/bb/asyncrpc/exceptions.py
+++ b/lib/bb/asyncrpc/exceptions.py
@@ -9,6 +9,10 @@ class ClientError(Exception):
     pass
 
 
+class InvokeError(Exception):
+    pass
+
+
 class ServerError(Exception):
     pass
 
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 7569ad6c..2d2a98d4 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -14,7 +14,7 @@ import sys
 import multiprocessing
 import logging
 from .connection import StreamConnection, WebsocketConnection
-from .exceptions import ClientError, ServerError, ConnectionClosedError
+from .exceptions import ClientError, ServerError, ConnectionClosedError, InvokeError
 
 
 class ClientLoggerAdapter(logging.LoggerAdapter):
@@ -71,7 +71,12 @@ class AsyncServerConnection(object):
                 d = await self.socket.recv_message()
                 if d is None:
                     break
-                response = await self.dispatch_message(d)
+                try:
+                    response = await self.dispatch_message(d)
+                except InvokeError as e:
+                    await self.socket.send_message({"invoke-error": {"message": str(e)}})
+                    break
+
                 await self.socket.send_message(response)
         except ConnectionClosedError as e:
             self.logger.info(str(e))
-- 
2.34.1


