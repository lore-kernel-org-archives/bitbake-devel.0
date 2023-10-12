Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E2FCDB482
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:25 +0000 (UTC)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
 by mx.groups.io with SMTP id smtpd.web10.25785.1697149041669286679
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ESLnqSIh;
 spf=pass (domain: gmail.com, ip: 209.85.210.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6c7ce16ddfaso981864a34.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149040; x=1697753840; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UYOyhxEl7PpAcVCSERVPjzNvG40y7Uw5OaUDui3ad0=;
        b=ESLnqSIhCyrUa2LwauR7oIAs80sGluUi8BOnji3HXZmQ/teHNpw56iyABAPNJHiCuF
         YhK6IK39OZRT5N371arG49hYczLmkrfk8jnCuDJ1UaKA4frPLn37Y+Vkii2sT5DhEM7T
         fe+EYi84udxT/cikCqIJ3ipwdFTTeRBjXF0IyzJP3DIA4FqQn0wk0OOSJgNfes1Dsody
         axiOC8xRm37nA8ucOB0/C2iQDl4GOsZTJiWbpKbIt/QsIc5RmLCugwy/qhFo7OL+sS+d
         jNbJ8UvmWhCwLjwnnZJE0kBEMX6Wkls159CP+EljJanMJC6WmuVJlUQvPqYKAw7nkny2
         kG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149040; x=1697753840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UYOyhxEl7PpAcVCSERVPjzNvG40y7Uw5OaUDui3ad0=;
        b=IVzv9DoOdKguUALyuypME97aWSn2OaVdigHUcVOgAYKjvMOkpWCii93v2ZJU3WsPGz
         9f4MjZIfLx5xkF9t1pZH55onpOiCz7wQNw6SOddBxmLIOwaHcDA0r+bZzIRc6w/RS765
         TxbyUTyZNHRpv1z2b2/AmtR0CqkWy4JnonSQ1kbt0LMjWp0brkoe8+f5MDINYTGlteaL
         VxiIG2o8L4Hob8aMY0qUGIDMYMvBHHKHJOCpff7dEA1eoyibI1fsqOFwDu45/oE/JwVe
         91PWwEaK6CU3840fmq+ugz6LPsNWFRJdyCNKOyzbap4yjAoPpMJ9dDxRnp/+sfdadUWj
         OyQg==
X-Gm-Message-State: AOJu0YyKM5kFfhNFhZGQWgd05tdAtCk592KHQatv4kEGz3Jd0w0X86gu
	2R30ByYz5s8QjaoPz7J8Uc5Tj+rmAIc=
X-Google-Smtp-Source: AGHT+IEteE3sPFENi4Ea10VYNUPN2P5AJRxznJVi8VsPi/c04EAXnQkrM0dPJ2IGfssfYvH9nITkfg==
X-Received: by 2002:a05:6871:4d04:b0:1e9:9715:3cc5 with SMTP id ug4-20020a0568714d0400b001e997153cc5mr5022275oab.25.1697149040417;
        Thu, 12 Oct 2023 15:17:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:19 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 12/18] asyncrpc: Add InvokeError
Date: Thu, 12 Oct 2023 16:16:49 -0600
Message-Id: <20231012221655.632637-13-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
 <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15230

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


