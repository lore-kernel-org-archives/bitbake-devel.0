Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25827CDB474
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:15 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web11.25716.1697149030347721910
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JTFNpCzC;
 spf=pass (domain: gmail.com, ip: 209.85.160.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1e9d0fc55beso321505fac.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149029; x=1697753829; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFWAdssZoMDGeSMv3sVYL1wlY6WlNkoSllBA7PJuQY0=;
        b=JTFNpCzC1NGIZfEGIouPN7LCXRrukhBZoSjLFPs+o+7u4HJG+hmdMPTZqUkbDX2bV6
         lVE/gcVIPwpRw6+PsRPbjnWS+bBDE1ofI0hTrqeLK2o+dU/0eJxe6WPI0CmdOrMSdQvX
         abHm6aiNHLMHzmRNjLF2+Wkno7iwRF6aVQ7fW9FFTBqrgXkJspoO8FsvkLRkAyaAig7C
         os0OE1v0tnHk/zSyKTEOEPvEx8c1ORcLxeYQXB839wsfGiE8lw/VHBKfXXnmQL+zHlSX
         oUDvbUIkfQk/nN/O5kedML1WerCZTUBqvl6eCV12Q/mdvpongP/hZdvGVTqVk2s5Fxh3
         zK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149029; x=1697753829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFWAdssZoMDGeSMv3sVYL1wlY6WlNkoSllBA7PJuQY0=;
        b=TA/H+oDyYyy+tI2pEr235FLqnGeBVFegQrNVtc3Ks0jVD0pdWFI0TrdK36a/bR0ljK
         ji8NNZtSQPR2VAE0Sw3q1btLo6+e0Z1BUmLD0RY3qhV2C5GxYAJewcvO6OgiY3ytWgIa
         q00qLyYjZBZ4yTnT+jRJuOMuQJUY0njCHT7LCiPC4Gj27Eor9Bht054aQAbdFyMibMnb
         ocIxJz1paZAKx4i0y6wLfXYq/MrnsZuIV4FkfOXFu0ofpUc5mshHYGHK+T0qjwmMyfON
         p8PDvz7B8odn0Sjr822qvkXz6lnHfahhpNax3mCQZvJBWM0vvCm5dVgGosCDRRzx5V5C
         ggRA==
X-Gm-Message-State: AOJu0YyGJtxwev9OaxfkthmE28Vu5LT7Q/yznJLVco44y/wdGtAJ3z1y
	II0/gAV6bU6EPlWjkVLIqw7qxJ+h6jY=
X-Google-Smtp-Source: AGHT+IEIiR6CWiZ1r/FoRKj5xB4XbkjkZPB4fpSYJ0OjUIs/YSDmPEU1D9dPkHeV+ZjX24SF1yCuZA==
X-Received: by 2002:a05:6870:2b1a:b0:1e9:bda0:775 with SMTP id ld26-20020a0568702b1a00b001e9bda00775mr3005283oab.42.1697149029076;
        Thu, 12 Oct 2023 15:17:09 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:08 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 05/18] asyncrpc: Prefix log messages with client info
Date: Thu, 12 Oct 2023 16:16:42 -0600
Message-Id: <20231012221655.632637-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
 <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15223

Adds a logging adaptor to the asyncrpc clients that prefixes log
messages with the client remote address to aid in debugging

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/serv.py | 20 +++++++++++++++++---
 lib/hashserv/server.py  | 10 +++++-----
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 3040ac91..7569ad6c 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -12,10 +12,20 @@ import signal
 import socket
 import sys
 import multiprocessing
+import logging
 from .connection import StreamConnection, WebsocketConnection
 from .exceptions import ClientError, ServerError, ConnectionClosedError
 
 
+class ClientLoggerAdapter(logging.LoggerAdapter):
+    def __init__(self, logger, address):
+        super().__init__(logger)
+        self.address = address
+
+    def process(self, msg, kwargs):
+        return f"[Client {self.address}] {msg}", kwargs
+
+
 class AsyncServerConnection(object):
     def __init__(self, socket, proto_name, logger):
         self.socket = socket
@@ -23,7 +33,7 @@ class AsyncServerConnection(object):
         self.handlers = {
             "ping": self.handle_ping,
         }
-        self.logger = logger
+        self.logger = ClientLoggerAdapter(logger, socket.address)
 
     async def close(self):
         await self.socket.close()
@@ -236,16 +246,20 @@ class AsyncServer(object):
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
index b0bd63c5..5ba22c07 100644
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
@@ -479,8 +479,8 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
             row = self.query_equivalent(cursor, data['method'], data['taskhash'])
 
             if row['unihash'] == data['unihash']:
-                logger.info('Adding taskhash equivalence for %s with unihash %s',
-                                data['taskhash'], row['unihash'])
+                self.logger.info('Adding taskhash equivalence for %s with unihash %s',
+                                  data['taskhash'], row['unihash'])
 
             d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
 
-- 
2.34.1


