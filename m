Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D578BC4708E
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:02 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
 by mx.groups.io with SMTP id smtpd.web10.1611.1698772917830888784
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:21:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Z6ZRmH6s;
 spf=pass (domain: gmail.com, ip: 209.85.160.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1ea4a3d0a44so4020529fac.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772916; x=1699377716; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9Wfmd+jiWppDHkVkZxKDIWXFk1cUxylfwTCXrQJMHU=;
        b=Z6ZRmH6shWzyVhDyjy9dPrc3VLDWITjqnWGDewgchIIja8UGYYJa9TJAnjx0QvUojm
         X7uohnB6VKDyR+VZN4VbegSvyhcBoHEGl2YMXBUJorg+XAk/ft2TVhtcNEaZKk7Aqv5U
         AuEpaunUM7gATdATBlz2RM/O/uvUGi39jEsAGw3WnFX4G8Gi9EN0T3yckkwBM1MD3St4
         xuF6DWk67VczhCI7qU5KBve4Xx766713+xrDY9h4Etoq2BtfvoIhaGgJfl8B89EQtyLo
         X1U7d3HHQXky/Y/UmicmW9ttaZwaSqPTmCrQIJVai0ElCTrTzk9ka2mfssIs5mgUkhrc
         WEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772916; x=1699377716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9Wfmd+jiWppDHkVkZxKDIWXFk1cUxylfwTCXrQJMHU=;
        b=nlQl/U5tDn2YMXVsKf/Ncw9bf7trmCVOGBoFF4SCv+3iDyONFirEvQTIs9dWdfOA/l
         II4xyUGDmyTnQxpacwsSQQ6DidxNQLZQokq3JuuuRnXAvQE10mYt29BE6rfanpnVeTUL
         OenxD0gpaS/ngKSgeTfTajEYfT4j1ZgBKSvrIfXQgKuRb0laSN1s3nr0b4iV2Er8kJwB
         QVTxhZyLIAOIgdKE2yHtatAuME072SqmFE8Yw0cuYiV31jngs8Nvpi6Lz9sV+5UmWP5A
         Fy8BQtGlKbinucLT2vYzWauX3w5VayOZWINGFmo6IBtvMgodxt2rBaNmsaeYdYpz9EwA
         hi5A==
X-Gm-Message-State: AOJu0Yze0wOa/yJr76MhctdWowMgCb7N0jnXIYfQFfA400uZWC/ZK8D8
	7jaZvU7ntVQhbSQzliMhbWrTWRko5jg=
X-Google-Smtp-Source: AGHT+IGjfL+ynceELOKnwN2hXttMSLmL6TQfUxIIGLqfhu8dAqvmbK33mtRCemHbBak2Vb1dtqHlBw==
X-Received: by 2002:a05:6871:2b04:b0:1e9:5480:1df8 with SMTP id dr4-20020a0568712b0400b001e954801df8mr17370554oac.51.1698772915822;
        Tue, 31 Oct 2023 10:21:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:21:52 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 05/22] asyncrpc: Prefix log messages with client info
Date: Tue, 31 Oct 2023 11:21:21 -0600
Message-Id: <20231031172138.3577199-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:22:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15355

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


