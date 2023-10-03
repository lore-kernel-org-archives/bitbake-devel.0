Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B21E7AD64
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 14:53:12 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
 by mx.groups.io with SMTP id smtpd.web10.110648.1696344782468391962
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 07:53:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kZif6sVq;
 spf=pass (domain: gmail.com, ip: 209.85.160.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1e10507a4d6so687707fac.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344781; x=1696949581; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r7TMZcsmFxTnyD/wPfvCOVnl1EZUyuR4feCCdaAdec=;
        b=kZif6sVqaAfzQvA0KPHmdDFG4ddKay6J8HYOFoYOGp9fC0iw1ZXxJAf19OB1/EX+P5
         Ku7gqD7S73Ry48Wa5bDX3wRKkSchWw4DpadI5JkbAS5FqGd/Dd7ca809FMuiKDrVdcvu
         as+VCrpRjcBhpRO0cjFZ7iz4DhnReuhWaPQWZdS4lDq0x0TpKdShkcBzfIlTZUu1ZxP8
         5BFkXajpXRnwApFgbNCSu7bqPgWo35SWQcker787+/PrWf+rIZvReEvpybSB+dkqQYbu
         Vc4ZQbDiVQdNz5F8MIjcW6IijUtTISmNpVdPJH/TmCm8sa2JQTkhIt9NJqk6q9OiuuPf
         UJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344781; x=1696949581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+r7TMZcsmFxTnyD/wPfvCOVnl1EZUyuR4feCCdaAdec=;
        b=XE0iQl24fNg3vJvqfjV8OUSBEW2S2P0fNQ3OSBkNbae00qi88HXPPOOqKOt0IVHKxj
         gCfribbeJOqO9h3saU6rlj42ICQ2bMUbJu6zZ6rP3THaG7t6Uz4tla5zayKMuEeenJEm
         sXq2sxPxYYTCRG6vleZG99d4Skyv3ELXhtbEpd3qAmcOYh56BUSSYNpXX6UVcZAziPxn
         g7YVkm3FglMovX816gL0w/grSdB2vdWWMyL+SadA4gPeo1CNdm3Q8g0GjtHpcvMRctW8
         lRTwCs4drKH/QfSOJYglPhC7lLOQ7my8krhgXBQ6/jq/pzzGTVu9gqklwxOE7reUagVl
         Q+iQ==
X-Gm-Message-State: AOJu0YxFn++tPrfKTuEb85R4vqniEIjN+5zBp90q8MCDsdUTbinB6uIf
	qrlgs68NdYG8TvV0tievocvOpsN7kSE=
X-Google-Smtp-Source: AGHT+IHFR/yPC/AM5Lhs+8Y7j6VBtadzz188dvC7/9si4ZMeh5lMOM0tHzaEGRT95/lngUEfv5fYYA==
X-Received: by 2002:a05:6871:78a:b0:1d7:1533:6869 with SMTP id o10-20020a056871078a00b001d715336869mr15819677oap.31.1696344781152;
        Tue, 03 Oct 2023 07:53:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::589])
        by smtp.gmail.com with ESMTPSA id du28-20020a0568703a1c00b001dd2b869a26sm253477oab.17.2023.10.03.07.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:53:00 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 07/12] asyncrpc: Prefix log messages with client info
Date: Tue,  3 Oct 2023 08:52:44 -0600
Message-Id: <20231003145249.1166276-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003145249.1166276-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
 <20231003145249.1166276-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 14:53:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15168

Adds a logging adaptor to the asyncrpc clients that prefixes log
messages with the client remote address to aid in debugging

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/asyncrpc/serv.py | 20 +++++++++++++++++---
 bitbake/lib/hashserv/server.py  | 10 +++++-----
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/asyncrpc/serv.py b/bitbake/lib/bb/asyncrpc/serv.py
index e2589cb0990..c4829b82e0b 100644
--- a/bitbake/lib/bb/asyncrpc/serv.py
+++ b/bitbake/lib/bb/asyncrpc/serv.py
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
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index 35465240ae9..ee959a6bd94 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -206,7 +206,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
     async def dispatch_message(self, msg):
         for k in self.handlers.keys():
             if k in msg:
-                logger.debug('Handling %s' % k)
+                self.logger.debug('Handling %s' % k)
                 if 'stream' in k:
                     return await self.handlers[k](msg[k])
                 else:
@@ -335,7 +335,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                     break
 
                 (method, taskhash) = l.split()
-                #logger.debug('Looking up %s %s' % (method, taskhash))
+                #self.logger.debug('Looking up %s %s' % (method, taskhash))
                 cursor = self.db.cursor()
                 try:
                     row = self.query_equivalent(cursor, method, taskhash)
@@ -344,7 +344,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
                 if row is not None:
                     msg = row['unihash']
-                    #logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
+                    #self.logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
                 elif self.upstream_client is not None:
                     upstream = await self.upstream_client.get_unihash(method, taskhash)
                     if upstream:
@@ -463,8 +463,8 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
             row = self.query_equivalent(cursor, data['method'], data['taskhash'])
 
             if row['unihash'] == data['unihash']:
-                logger.info('Adding taskhash equivalence for %s with unihash %s',
-                                data['taskhash'], row['unihash'])
+                self.logger.info('Adding taskhash equivalence for %s with unihash %s',
+                                  data['taskhash'], row['unihash'])
 
             d = {k: row[k] for k in ('taskhash', 'method', 'unihash')}
 
-- 
2.34.1


