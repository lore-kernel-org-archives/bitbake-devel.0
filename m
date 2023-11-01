Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0864C4332F
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:47 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web10.10808.1698853357986680524
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e+FRLwYm;
 spf=pass (domain: gmail.com, ip: 209.85.167.169, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b2e72fe47fso4433054b6e.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853356; x=1699458156; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXhhnKVan9rIaJMm2CcVw5z9qWgCaOtaJFeQzbYYroU=;
        b=e+FRLwYmue2tuwk2tggw1tyIZJPXjOcT/5gbv/hS086KpHwVaLgLsH8W/LDTL+OM42
         HMuFKHnEKaG6Z6fiY+BYGKUGLAXGyHqX+TMO3db5X6g+sGxaUP5hr+doA7xrc9LeghsA
         Isq0QdvrmV98uLHEKJQ9N0HdmMHvMHNv5IZr4qegvXkhrFemMyXxsKAJyxS0jobMMRiC
         ppXxGfBP3KkFV8ESff+Foqs8fZQpovWIvo9pXHNnqnY+ZCNHUs58Plfa1piZcTW6iOeb
         /IjE5I0P5CTLGfthk1uo6bl6Bw4LYy4jGT5SE+Y1BXn5TB/otC2CvVgQt8/nK6k6ntPy
         EPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853356; x=1699458156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UXhhnKVan9rIaJMm2CcVw5z9qWgCaOtaJFeQzbYYroU=;
        b=AQxCRjLzgM0Z/2pEutskOtKLu3TSJiYjIEUis++cypX17czY8B8AozyvTJ8B28pxxT
         6ijYVnXhSvUV4tVlQkHdo7JQ8A6jhLczOv4V7mT5tZMNKkk/XRErMROei3ogK/qaCAkW
         mO+/rUr3VhEsyVLFJXyEMNFWIGs++19BY1TrPLCuqMt2dQonVPvg2ahlpUtafctbqPPz
         C/uWSil9muQyJp3PZB5ZN7/yYF4C7ZeW0Q/r2FFiZ0FY5GdRP3/v+rx+Yqsl5hLumo1P
         yacjWk01Y+FTXpM2KXeXLlKCFjCsNqZA9uHCNd8QuJk7BMtSvjily7iomoIrnFVhEy6e
         374Q==
X-Gm-Message-State: AOJu0YwSMiRkaMX7puVPO+emDJRA+d4P5iDRkjFbvgKSXd81dLmHFAmA
	OsnCqvuXd6bTwBLfWHOCdwDU+9Kdjiw=
X-Google-Smtp-Source: AGHT+IE6g89DEtvt7+VFlh6/kW/PD3/H2LuwtNEgPYM/CylsKT9s/zNe9Yfa06cFINnlIFKhHX96KA==
X-Received: by 2002:a05:6808:996:b0:3ae:1672:16ec with SMTP id a22-20020a056808099600b003ae167216ecmr14045892oic.11.1698853356760;
        Wed, 01 Nov 2023 08:42:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:35 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 10/22] asyncrpc: Add InvokeError
Date: Wed,  1 Nov 2023 09:42:04 -0600
Message-Id: <20231101154216.2758185-11-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15392

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
 lib/bb/asyncrpc/serv.py       | 11 +++++++++--
 4 files changed, 22 insertions(+), 4 deletions(-)

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
index a476cacd..fccbb196 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -14,7 +14,7 @@ import sys
 import multiprocessing
 import logging
 from .connection import StreamConnection, WebsocketConnection
-from .exceptions import ClientError, ServerError, ConnectionClosedError
+from .exceptions import ClientError, ServerError, ConnectionClosedError, InvokeError
 
 
 class ClientLoggerAdapter(logging.LoggerAdapter):
@@ -72,7 +72,14 @@ class AsyncServerConnection(object):
                 d = await self.socket.recv_message()
                 if d is None:
                     break
-                response = await self.dispatch_message(d)
+                try:
+                    response = await self.dispatch_message(d)
+                except InvokeError as e:
+                    await self.socket.send_message(
+                        {"invoke-error": {"message": str(e)}}
+                    )
+                    break
+
                 await self.socket.send_message(response)
         except ConnectionClosedError as e:
             self.logger.info(str(e))
-- 
2.34.1


