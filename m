Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55D1C4167B
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:37 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web11.10724.1698853349668743479
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JHmvVLec;
 spf=pass (domain: gmail.com, ip: 209.85.167.173, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3b512dd7d5bso4722241b6e.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853347; x=1699458147; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHlgQLjZUS0/9Yn8kAJZc1ob/1Unta6vmWJW+nrDHxU=;
        b=JHmvVLecaZDY4zu/EA556taFHGwjVZhzkuh6BBTuQyLWxAwnM/DajTh2tJTy/WLfOY
         hROUkfJWiXHsV7dqgtxRZd4x4gm3EpC61zUg70/P9/og0JeXMVOL7hp17ZtGoQqrp4bW
         At9p+Eo3Fo6+W/LUfBTAhMVA8SVSbJYigA4Nj9muzoLgW5YyJEAzRuC0iNQy89KXyUyf
         MpdJyNWTQwvZ+5F64R4KMiSeBzGsnXVWW5Q2bywJOaoAs/vdnHdUuO83gCOMoNODDyWr
         iZC+BUoMM188h8NznjDMYHbyG43Es24Xm+rzb820t6Yk/JkyVe+5f0IP1wLqmisPbrbD
         VyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853347; x=1699458147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHlgQLjZUS0/9Yn8kAJZc1ob/1Unta6vmWJW+nrDHxU=;
        b=go4pOCLMf8+QLiU4n8tiNE+Lrojrmstdt04u6RigyB4hnCB1sO9fl9TqGx2jIthHJR
         CBi5U9SDC1qJqtV0cuGlKeygCSVA4oUY5gBhYZhPB0vVw+reI7hwDdck77IWZlvpN7Wr
         YnOU5fR8/UdFAgX9bzenZW6XW/sMLEIP/U7F2+vDqtVlhnEHbbt8oszyyRWVwkIWN3Vc
         ilxQ2UsN2buEr/YDDeyRnjJ9p+oYH/zVrFVTsN2SNatspwRNwnJncWqKUMilDwpEXitA
         KYPUcSXxLa/R2Yo6RUEYuKKqf4iTObu4gFbhQCIZNsm6fv1HYh4DzgwPqvlkCIS/T3cH
         CZcw==
X-Gm-Message-State: AOJu0YzG/jh9Ckz19AKxtcc1Ru+Nfd2LLuC00KXLXLEgsSZkZhLjjhqp
	NOoUaizLNu+w6CV25ThFgVeJFxKL4jE=
X-Google-Smtp-Source: AGHT+IHrgKrTjugswTltSoDucNnGDgpWn6kupQ5Iu+VvsPMTusWvGkQyuOjSBkWP7dUZbap7P9iaxw==
X-Received: by 2002:a05:6808:4409:b0:3b2:f3a6:a238 with SMTP id eo9-20020a056808440900b003b2f3a6a238mr18618236oib.19.1698853347640;
        Wed, 01 Nov 2023 08:42:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:25 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 05/22] asyncrpc: Prefix log messages with client info
Date: Wed,  1 Nov 2023 09:41:59 -0600
Message-Id: <20231101154216.2758185-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15387

Adds a logging adaptor to the asyncrpc clients that prefixes log
messages with the client remote address to aid in debugging

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/serv.py | 21 ++++++++++++++++++---
 lib/hashserv/server.py  | 10 +++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 3040ac91..a476cacd 100644
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
     def __init__(self, socket, proto_name, logger):
         self.socket = socket
@@ -23,7 +29,12 @@ class AsyncServerConnection(object):
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
@@ -236,16 +247,20 @@ class AsyncServer(object):
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
index 6d3a4751..928532c7 100644
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


