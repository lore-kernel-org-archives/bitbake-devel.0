Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F912C0018A
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:13 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web11.1673.1698772925569055420
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=e+Bp58he;
 spf=pass (domain: gmail.com, ip: 209.85.160.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso3915348fac.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772923; x=1699377723; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10HjD7Vw5FNkVskfx9zOFqB8gAwa2iSQcqMm7RCQNKs=;
        b=e+Bp58heubr8rlagvXbXchfqtHlCKvDVuzGqk7ok9vURmPrVjEvUZcdf8oB3INDQpU
         GSFAkdg4wscHbhyOOwBWPWfPo+/Zdb10+eoNIQ84MTqpSommcelzKvIkh7SB98Gfe2R8
         MXa585Hgu2ZC3Wo7mG2Ehyjle0sfdYTSMl1luSZCqtHIs6jhRSHt1UjBO74eNGXcnLWB
         rKAAC7hZ8AMVA7fQogcGsj8d8ax4ox0v185QvZIHOv1a2JaArJUI8xkxou5Ec1PJY/x+
         3C8QYSRpBGUSJA460YEMF0fpVqbJWiH7Y3JyPeWOHXxx18ggtX846twj88ONnse1Q7ec
         ggoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772923; x=1699377723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10HjD7Vw5FNkVskfx9zOFqB8gAwa2iSQcqMm7RCQNKs=;
        b=EqSFd9tvLQ1h61JCnHK01FDlnUPfMrAADUgl8L59+M8tLLfTSAMYooaezhrA1jliaX
         Fk1V0gbqMWahUe2L2Wn6StwtQgz2LpdLqd+7o1OoZtWp3lS60RF/vsKVxGJLiP8r+1uZ
         Ovu1/fNfMwHyREbAPBjc8oVh42XO1ynX5sKTwu5jLq/1eIe2vPFxtmaYouTZ/xe/c4lW
         oVZUQpgUX2dpnjuRRJzQ+6sGQRkXFPjactdbRwhFt1ePFr6SamAdOmj/ewF8zGo7wcFF
         WhagiRHNKCygCEptorWhuv5dFK7R51Soi+OgpCvjEcuwGy9TqYBm4BO8YhfM8df3uZPN
         Ru1Q==
X-Gm-Message-State: AOJu0YzEbgKNZN4pu4KSuZzPg2X2yFWWJ0QTWyh2qULBe7yLwl8sODuE
	8qWxLV7Gfk+QIu3IWZx1QQWG0z7zgFs=
X-Google-Smtp-Source: AGHT+IEqm8hxUHhKZDX6g5suu7v64ruh7bgJBAr7UkVGp+8olu/GSxseAUpxNt3rFMd9Whye7Xg8kA==
X-Received: by 2002:a05:6870:d62a:b0:1e9:9c34:af67 with SMTP id a42-20020a056870d62a00b001e99c34af67mr15625724oaq.18.1698772923685;
        Tue, 31 Oct 2023 10:22:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:02 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 10/22] asyncrpc: Add InvokeError
Date: Tue, 31 Oct 2023 11:21:26 -0600
Message-Id: <20231031172138.3577199-11-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:22:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15360

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
index 7569ad6c..1a7f9a88 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -14,7 +14,7 @@ import sys
 import multiprocessing
 import logging
 from .connection import StreamConnection, WebsocketConnection
-from .exceptions import ClientError, ServerError, ConnectionClosedError
+from .exceptions import ClientError, ServerError, ConnectionClosedError, InvokeError
 
 
 class ClientLoggerAdapter(logging.LoggerAdapter):
@@ -71,7 +71,14 @@ class AsyncServerConnection(object):
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


