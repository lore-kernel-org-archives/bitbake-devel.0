Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07062C4167B
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:04 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web10.158328.1698693480767449317
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=S525V/PX;
 spf=pass (domain: gmail.com, ip: 209.85.210.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6cd09663b1cso2862956a34.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693479; x=1699298279; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFWAdssZoMDGeSMv3sVYL1wlY6WlNkoSllBA7PJuQY0=;
        b=S525V/PX358epxkrYtMJGusn1/qjwztb+4YnvD32n6gk1XLz5bUcgwfyzXt3j7h/YS
         szzA2wlGnQRRTpsjfJDH1bHFya3MeoR2f2jFM8RMLbiN3SVU2Xx/szhYRgAqYbQUPAUQ
         GnJWW1BnCoH8XzP42gKwz8oeFtiR+ygSEpAKgXQRxLHpi6kYTiR5SezKw2l2nAtBCE+6
         nNS8fZdl7iQfVPGYvX4Owgz3ap6PpGaL4eXLF07VEi4/b63Z7YaieUM1/cj+tHccWCW7
         FlYmUHJnsy3Dau8dY7wLe+7IU5ul2OnF2IyQ+iDC2pYC5pmei6o3xCBOPM66HJlnWAOz
         CdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693479; x=1699298279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFWAdssZoMDGeSMv3sVYL1wlY6WlNkoSllBA7PJuQY0=;
        b=Yhy8G+wtfzDIYU1c6nVIIexKtn4EPD+ujYsxstMddoF675S0OehnWUgOtPPdaTBfmW
         6mnHep+JdvDFomLHcUvQDTE6TALa1Ye2UlMDb+Fd0nza6ITPeEWdZ0zdwqvRX/amd2sn
         GQ3sEbR8AWzgOPcTtS8RwyHjBgQEcV30llQh5aXzD7V6pzAqjefx1/jiBy+J4gXFtgzP
         0L4eSXcCcAdcMXQ8zS7Mg4dVf/bn0ItJXHj7TyQfecwvKIIbAXICDrDVZ7LObZKm10Ph
         OvxChlYDSZAhsqKfbHlZQTa5a0AeZb5IInUElPcD/PXwHwlqh7xQsibKsm61J6AdSBdF
         ahiw==
X-Gm-Message-State: AOJu0Yw/jEID+uFX/KhSrTBZoPaLihGVe9zxZvZxvmUDK1xv3X8PqXM5
	lOOkBZ3pCCGCp+0hGh38Yx7aNVqBp5w=
X-Google-Smtp-Source: AGHT+IHgyJ1/yldYUu09UfwaZectNzauR926z1JK6qg94rQwPVzIEmSs2RNK8DESmm/ssy4Rxllsdw==
X-Received: by 2002:a05:6870:bd41:b0:1ea:8b10:247e with SMTP id og1-20020a056870bd4100b001ea8b10247emr13807268oab.27.1698693479449;
        Mon, 30 Oct 2023 12:17:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:17:58 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 05/22] asyncrpc: Prefix log messages with client info
Date: Mon, 30 Oct 2023 13:17:11 -0600
Message-Id: <20231030191728.1276805-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15307

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


