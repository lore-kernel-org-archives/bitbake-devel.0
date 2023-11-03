Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DE7C41535
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:16 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web11.52765.1699021628544404906
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y8RKmtPi;
 spf=pass (domain: gmail.com, ip: 209.85.160.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1f066fc2a28so679273fac.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021627; x=1699626427; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfLnjX425GVxcrsbYprfpS/9R1ZxwzhcGsg2H7xqan0=;
        b=Y8RKmtPiUGUw/urTDX/KigO/ku09rKBh9b2bf0H90C/F/xw+CyLIwTrlZ7EOEC9j0F
         UpMFxj11vlhCI/5ywJiK6KLw6L3YIgAcqf2t5oUCHCodYxmAF9IB9MyB46Gnvxuu9ncX
         PtPGbKtHPY22TwnSlaqK7giVRXGDCQ9JzAGjcQwp0Y9QcS73IPXtHA+W8YjEyI2QLiOQ
         bCccLxTxW2eAY2Wygxyhepq4AgANmN6IUTo1p5UOIXWGgjuF4us4f4R8/oST34uYnsre
         VRMZOU4XaHv2hytzF0YqRyAvd+M7Mi0cT4ymRzCoKrQaaMTQyUKT0a/qDVCD3UwavzCN
         q0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021627; x=1699626427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfLnjX425GVxcrsbYprfpS/9R1ZxwzhcGsg2H7xqan0=;
        b=BSVyr0XI6xWiGLPhnSqe4VOiNm7GOWumqGAX2MXizAr8oWEr3EE+IeEO58uLSsvl2n
         je4Kdc3xNgGNz4L1TPXx/ZUKgoYl1jHOC8q7DebTQbHsxsw1T1jtUmEQv1L/NYrME2qb
         2hx2dj3UZASsMFzZh2kwZOUMdbeNnguWgVdVGOCT1Vil+n8ER4+JsZTG9SPVc6lfCRkO
         BIZxkzwhtkVIijLKuVOZe9G9E1f7OuforcdW1d+IB+bf4Bzic83oMPvv2RQd/GAq05Yi
         KP9hJBvwjtdzcvzAQbexHF/4zSJVxUjkSg+peQ+YoIcd+5NbdrmduAZK9WB4LpqIR2EN
         BbfA==
X-Gm-Message-State: AOJu0YwBgS2ueiTKC8rT1q9NvWRx9qQ5sv6VQ8+pJTq8nnu6jBhj/5VU
	fF1sZav7aMhTdeqBGACzu5wN5BGbWMc=
X-Google-Smtp-Source: AGHT+IGyTHiNklHGrj+QN67JAoUqa9e9YtwUBjsq8I2Azrnc0zeePZ2YN+dRfAHh1rlKatrzoXxcaA==
X-Received: by 2002:a05:6871:8790:b0:1e9:cdad:4903 with SMTP id td16-20020a056871879000b001e9cdad4903mr26811915oab.50.1699021627256;
        Fri, 03 Nov 2023 07:27:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:27:06 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 10/22] asyncrpc: Add InvokeError
Date: Fri,  3 Nov 2023 08:26:28 -0600
Message-Id: <20231103142640.1936827-11-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15431

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
index c99add4d..5fed1730 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -14,7 +14,7 @@ import sys
 import multiprocessing
 import logging
 from .connection import StreamConnection, WebsocketConnection
-from .exceptions import ClientError, ServerError, ConnectionClosedError
+from .exceptions import ClientError, ServerError, ConnectionClosedError, InvokeError
 
 
 class ClientLoggerAdapter(logging.LoggerAdapter):
@@ -76,7 +76,14 @@ class AsyncServerConnection(object):
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
                 if response is not self.NO_RESPONSE:
                     await self.socket.send_message(response)
 
-- 
2.34.1


