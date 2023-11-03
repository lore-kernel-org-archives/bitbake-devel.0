Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485B8C0018C
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:06 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.web11.52757.1699021618456525022
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:26:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LJxI51s9;
 spf=pass (domain: gmail.com, ip: 209.85.161.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-581e9b8e5fbso1024694eaf.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021617; x=1699626417; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCPigbmTBmMbljNzy6wVB7pBUoHJFafyiFsS+r6eL64=;
        b=LJxI51s9SGcIJUhYWjFgf2NgTYbv5CAmGzL/7FdwtFdGncFuw0oMjRPjKI+F2o94FD
         Fzag3aLIxFj3kVbApzww2DOgNqU6Zd5LDpo0ErUG5SH3HQX1vvqtsVQmR5hpNIyRuyef
         8lKYGy7HlNAzTH45AH7OtlBwEZnY0ZbRbulMDWX52fS4EKIFAYXNfLM8/h97tD44VoCj
         bAh1lmV7DqpI2YiP1roIle8Tzx4/W/2y1X3/UG7QQHMw8XAobrdBDio4BIRMODJy7WNe
         xFSPV0nbFOQur8jGvRCMAUE2G1i88k2P56mkAZMOyxUXhxTcMM/3n/gNSBEAumtIgjJw
         WlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021617; x=1699626417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCPigbmTBmMbljNzy6wVB7pBUoHJFafyiFsS+r6eL64=;
        b=CIqRIyzBC2Py2J1pGx5aZtFjKTe3F/+7RBaoLjqO0j+BAJ1+9F8Sm+MJiEa7FaQPgo
         kxB3lbe3roXsiW8sy7FZWxmdPJf7vKi0g0GWHvnfJxMjbhdPSHffcyNUi3DQSUE/Qu/b
         SB5FjVad3vARrPtaXczZAn/Rn6htp31dKM1vMaGCEKEPfpBSr5DOdBmbOhuzX6iVm38g
         fXHMfgjfLV/qiFEKgPfrI5spH0G0MvX2FihfDTaU1VsOSw8AhHj1l/ZlbfrqhBV+s4rR
         ctBpAX8efZ1L4zUOs9QS6woH9Dd0eSkxP9Y/e8rqbjgExAC86+1nWUT4ZHg1njty9Hap
         2Ung==
X-Gm-Message-State: AOJu0YyMWKojtSHYxDuI3hPYtvf9pYrQZ/fvL2OHpJrAWibrHU5Snvsz
	wG1oWqJJFfK2SoH3204pBD1/eRMaOb4=
X-Google-Smtp-Source: AGHT+IEIBFaVOqxIKGmKYan0Q647JHcWPZ7f4HkNeJRajnOcuXv3beVAWQCqpHz7ycIOPvrkCt8E4Q==
X-Received: by 2002:a05:6870:f621:b0:1e9:cc21:295f with SMTP id ek33-20020a056870f62100b001e9cc21295fmr1986853oab.16.1699021617174;
        Fri, 03 Nov 2023 07:26:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:26:55 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 05/22] asyncrpc: Prefix log messages with client info
Date: Fri,  3 Nov 2023 08:26:23 -0600
Message-Id: <20231103142640.1936827-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15426

Adds a logging adaptor to the asyncrpc clients that prefixes log
messages with the client remote address to aid in debugging

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/serv.py | 21 ++++++++++++++++++---
 lib/hashserv/server.py  | 10 +++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index dfb03773..c99add4d 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -12,10 +12,16 @@ import signal
 import socket
 import sys
 import multiprocessing
+import logging
 from .connection import StreamConnection, WebsocketConnection
 from .exceptions import ClientError, ServerError, ConnectionClosedError
 
 
+class ClientLoggerAdapter(logging.LoggerAdapter):
+    def process(self, msg, kwargs):
+        return f"[Client {self.extra['address']}] {msg}", kwargs
+
+
 class AsyncServerConnection(object):
     # If a handler returns this object (e.g. `return self.NO_RESPONSE`), no
     # return message will be automatically be sent back to the client
@@ -27,7 +33,12 @@ class AsyncServerConnection(object):
         self.handlers = {
             "ping": self.handle_ping,
         }
-        self.logger = logger
+        self.logger = ClientLoggerAdapter(
+            logger,
+            {
+                "address": socket.address,
+            },
+        )
 
     async def close(self):
         await self.socket.close()
@@ -242,16 +253,20 @@ class AsyncServer(object):
         self.server = WebsocketsServer(host, port, self._client_handler, self.logger)
 
     async def _client_handler(self, socket):
+        address = socket.address
         try:
             client = self.accept_client(socket)
             await client.process_requests()
         except Exception as e:
             import traceback
 
-            self.logger.error("Error from client: %s" % str(e), exc_info=True)
+            self.logger.error(
+                "Error from client %s: %s" % (address, str(e)), exc_info=True
+            )
             traceback.print_exc()
+        finally:
+            self.logger.debug("Client %s disconnected", address)
             await socket.close()
-        self.logger.debug("Client disconnected")
 
     @abc.abstractmethod
     def accept_client(self, socket):
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 13b75480..e6a3f405 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -207,7 +207,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
     async def dispatch_message(self, msg):
         for k in self.handlers.keys():
             if k in msg:
-                logger.debug('Handling %s' % k)
+                self.logger.debug('Handling %s' % k)
                 if 'stream' in k:
                     return await self.handlers[k](msg[k])
                 else:
@@ -351,7 +351,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                     break
 
                 (method, taskhash) = l.split()
-                #logger.debug('Looking up %s %s' % (method, taskhash))
+                #self.logger.debug('Looking up %s %s' % (method, taskhash))
                 cursor = self.db.cursor()
                 try:
                     row = self.query_equivalent(cursor, method, taskhash)
@@ -360,7 +360,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
                 if row is not None:
                     msg = row['unihash']
-                    #logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
+                    #self.logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
                 elif self.upstream_client is not None:
                     upstream = await self.upstream_client.get_unihash(method, taskhash)
                     if upstream:
@@ -480,8 +480,8 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
             row = self.query_equivalent(cursor, data['method'], data['taskhash'])
 
             if row['unihash'] == data['unihash']:
-                logger.info('Adding taskhash equivalence for %s with unihash %s',
-                                data['taskhash'], row['unihash'])
+                self.logger.info('Adding taskhash equivalence for %s with unihash %s',
+                                  data['taskhash'], row['unihash'])
 
             d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
 
-- 
2.34.1


