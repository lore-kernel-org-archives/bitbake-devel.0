Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B80BC4332F
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:26:56 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web11.52750.1699021613990425865
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:26:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MktOSY2S;
 spf=pass (domain: gmail.com, ip: 209.85.210.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d2fedd836fso1242950a34.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021612; x=1699626412; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh4ehdeyVJMztzun9eRb3IQMbgLvjrtjA6KQFiUsvAM=;
        b=MktOSY2SUzakzoAkRLztF9uJCFmBQMtumsoEyOdntfT3XmZuDvafFvAmRyWK3fb2cu
         s2lgn6CfeJOLAaRLlH9r8o7PP2qQimNJcmGMJqRhaYgutCVTPDQEFr+DgTmBg44OJFrK
         HINqdUQOvJEcdJKu4SeCxPPQUtna5b5J2UqaRmZuukFbDV9YOoLr1KCRDmhP1vV50IZq
         sASFyfkbzrtvsOUbPSBvFvPRR6lyyJepsak3/+AWdO5J4nuxhuUSmlBjurPGbMv3WXzc
         Rlapsia7ZN+smSF8U1PYVl2TV4YIxHU3u/ZOXjrXLAK0KDXRx4k17bAwOPRdrtXnhWDW
         UatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021612; x=1699626412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh4ehdeyVJMztzun9eRb3IQMbgLvjrtjA6KQFiUsvAM=;
        b=sWCIzEjLVTtjG6grDisg9M/b6mmVOBdP4KnOy8fZxN0RZ2j/OYR6txWpD+w1wpolGq
         fl6E9fvo3IzCH2WI2ea3nkwIPARSrYY9WW5ESNd40ecTPsjse0DuIGCxdh6Guy3nHvMu
         ok8CbFRH6UQCVQAKreR6MV7tF6rJB1VvU8AHvK0yP07tMcdMNjPawjyxjmOm1knHIG4V
         RCRWPbvLtGNHMtO0SG0P085SaK7gtN0gNP/t76kI9ksHk6tFqZU3mD7dFPZsr3i+h807
         W59GjUVgnbyCJz48B3j+Jg0CliKevums4yWnBtwWElBLlxmhn3LsvrXa+yR/jd7uF5jy
         4X+Q==
X-Gm-Message-State: AOJu0Yz7Q2LVLhNwOhiyKunUXyKkq/ZrqIQZiufjHsrlJx0ozPDAri7V
	kAg5kE+CWDU4LwNumWz18v21gnPPsdE=
X-Google-Smtp-Source: AGHT+IGe8aH4wT0AQOovVyal+wqKBhUo/TixaKCUiMVjBYo4ESn7LKgggFS9c0VCqVcSnY+yXmUNNQ==
X-Received: by 2002:a05:6870:11cc:b0:1ea:323e:4f11 with SMTP id 12-20020a05687011cc00b001ea323e4f11mr19936420oav.3.1699021611977;
        Fri, 03 Nov 2023 07:26:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:26:49 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 02/22] hashserv: Add websocket connection implementation
Date: Fri,  3 Nov 2023 08:26:20 -0600
Message-Id: <20231103142640.1936827-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:26:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15423

Adds support to the hash equivalence client and server to communicate
over websockets. Since websockets are message orientated instead of
stream orientated, and new connection class is needed to handle them.

Note that websocket support does require the 3rd party websockets python
module be installed on the host, but it should not be required unless
websockets are actually being used.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/bb/asyncrpc/client.py     | 11 +++++++-
 lib/bb/asyncrpc/connection.py | 44 +++++++++++++++++++++++++++++
 lib/bb/asyncrpc/serv.py       | 53 ++++++++++++++++++++++++++++++++++-
 lib/hashserv/__init__.py      | 13 +++++++++
 lib/hashserv/client.py        |  1 +
 lib/hashserv/tests.py         | 17 +++++++++++
 6 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index 7f33099b..802c07df 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -10,7 +10,7 @@ import json
 import os
 import socket
 import sys
-from .connection import StreamConnection, DEFAULT_MAX_CHUNK
+from .connection import StreamConnection, WebsocketConnection, DEFAULT_MAX_CHUNK
 from .exceptions import ConnectionClosedError
 
 
@@ -47,6 +47,15 @@ class AsyncClient(object):
 
         self._connect_sock = connect_sock
 
+    async def connect_websocket(self, uri):
+        import websockets
+
+        async def connect_sock():
+            websocket = await websockets.connect(uri, ping_interval=None)
+            return WebsocketConnection(websocket, self.timeout)
+
+        self._connect_sock = connect_sock
+
     async def setup_connection(self):
         # Send headers
         await self.socket.send("%s %s" % (self.proto_name, self.proto_version))
diff --git a/lib/bb/asyncrpc/connection.py b/lib/bb/asyncrpc/connection.py
index c4fd2475..a10628f7 100644
--- a/lib/bb/asyncrpc/connection.py
+++ b/lib/bb/asyncrpc/connection.py
@@ -93,3 +93,47 @@ class StreamConnection(object):
         if self.writer is not None:
             self.writer.close()
             self.writer = None
+
+
+class WebsocketConnection(object):
+    def __init__(self, socket, timeout):
+        self.socket = socket
+        self.timeout = timeout
+
+    @property
+    def address(self):
+        return ":".join(str(s) for s in self.socket.remote_address)
+
+    async def send_message(self, msg):
+        await self.send(json.dumps(msg))
+
+    async def recv_message(self):
+        m = await self.recv()
+        return json.loads(m)
+
+    async def send(self, msg):
+        import websockets.exceptions
+
+        try:
+            await self.socket.send(msg)
+        except websockets.exceptions.ConnectionClosed:
+            raise ConnectionClosedError("Connection closed")
+
+    async def recv(self):
+        import websockets.exceptions
+
+        try:
+            if self.timeout < 0:
+                return await self.socket.recv()
+
+            try:
+                return await asyncio.wait_for(self.socket.recv(), self.timeout)
+            except asyncio.TimeoutError:
+                raise ConnectionError("Timed out waiting for data")
+        except websockets.exceptions.ConnectionClosed:
+            raise ConnectionClosedError("Connection closed")
+
+    async def close(self):
+        if self.socket is not None:
+            await self.socket.close()
+            self.socket = None
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 3e0d0632..dfb03773 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -12,7 +12,7 @@ import signal
 import socket
 import sys
 import multiprocessing
-from .connection import StreamConnection
+from .connection import StreamConnection, WebsocketConnection
 from .exceptions import ClientError, ServerError, ConnectionClosedError
 
 
@@ -178,6 +178,54 @@ class UnixStreamServer(StreamServer):
         os.unlink(self.path)
 
 
+class WebsocketsServer(object):
+    def __init__(self, host, port, handler, logger):
+        self.host = host
+        self.port = port
+        self.handler = handler
+        self.logger = logger
+
+    def start(self, loop):
+        import websockets.server
+
+        self.server = loop.run_until_complete(
+            websockets.server.serve(
+                self.client_handler,
+                self.host,
+                self.port,
+                ping_interval=None,
+            )
+        )
+
+        for s in self.server.sockets:
+            self.logger.debug("Listening on %r" % (s.getsockname(),))
+
+            # Enable keep alives. This prevents broken client connections
+            # from persisting on the server for long periods of time.
+            s.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
+            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPIDLE, 30)
+            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPINTVL, 15)
+            s.setsockopt(socket.IPPROTO_TCP, socket.TCP_KEEPCNT, 4)
+
+        name = self.server.sockets[0].getsockname()
+        if self.server.sockets[0].family == socket.AF_INET6:
+            self.address = "ws://[%s]:%d" % (name[0], name[1])
+        else:
+            self.address = "ws://%s:%d" % (name[0], name[1])
+
+        return [self.server.wait_closed()]
+
+    async def stop(self):
+        self.server.close()
+
+    def cleanup(self):
+        pass
+
+    async def client_handler(self, websocket):
+        socket = WebsocketConnection(websocket, -1)
+        await self.handler(socket)
+
+
 class AsyncServer(object):
     def __init__(self, logger):
         self.logger = logger
@@ -190,6 +238,9 @@ class AsyncServer(object):
     def start_unix_server(self, path):
         self.server = UnixStreamServer(path, self._client_handler, self.logger)
 
+    def start_websocket_server(self, host, port):
+        self.server = WebsocketsServer(host, port, self._client_handler, self.logger)
+
     async def _client_handler(self, socket):
         try:
             client = self.accept_client(socket)
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 3a401835..56b9c6bc 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -9,11 +9,15 @@ import re
 import sqlite3
 import itertools
 import json
+from urllib.parse import urlparse
 
 UNIX_PREFIX = "unix://"
+WS_PREFIX = "ws://"
+WSS_PREFIX = "wss://"
 
 ADDR_TYPE_UNIX = 0
 ADDR_TYPE_TCP = 1
+ADDR_TYPE_WS = 2
 
 UNIHASH_TABLE_DEFINITION = (
     ("method", "TEXT NOT NULL", "UNIQUE"),
@@ -84,6 +88,8 @@ def setup_database(database, sync=True):
 def parse_address(addr):
     if addr.startswith(UNIX_PREFIX):
         return (ADDR_TYPE_UNIX, (addr[len(UNIX_PREFIX):],))
+    elif addr.startswith(WS_PREFIX) or addr.startswith(WSS_PREFIX):
+        return (ADDR_TYPE_WS, (addr,))
     else:
         m = re.match(r'\[(?P<host>[^\]]*)\]:(?P<port>\d+)$', addr)
         if m is not None:
@@ -103,6 +109,9 @@ def create_server(addr, dbname, *, sync=True, upstream=None, read_only=False):
     (typ, a) = parse_address(addr)
     if typ == ADDR_TYPE_UNIX:
         s.start_unix_server(*a)
+    elif typ == ADDR_TYPE_WS:
+        url = urlparse(a[0])
+        s.start_websocket_server(url.hostname, url.port)
     else:
         s.start_tcp_server(*a)
 
@@ -116,6 +125,8 @@ def create_client(addr):
     (typ, a) = parse_address(addr)
     if typ == ADDR_TYPE_UNIX:
         c.connect_unix(*a)
+    elif typ == ADDR_TYPE_WS:
+        c.connect_websocket(*a)
     else:
         c.connect_tcp(*a)
 
@@ -128,6 +139,8 @@ async def create_async_client(addr):
     (typ, a) = parse_address(addr)
     if typ == ADDR_TYPE_UNIX:
         await c.connect_unix(*a)
+    elif typ == ADDR_TYPE_WS:
+        await c.connect_websocket(*a)
     else:
         await c.connect_tcp(*a)
 
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 5f7d22ab..9542d72f 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -115,6 +115,7 @@ class Client(bb.asyncrpc.Client):
         super().__init__()
         self._add_methods(
             "connect_tcp",
+            "connect_websocket",
             "get_unihash",
             "report_unihash",
             "report_unihash_equiv",
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index f343c586..01ffd52c 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -483,3 +483,20 @@ class TestHashEquivalenceTCPServer(HashEquivalenceTestSetup, HashEquivalenceComm
         # If IPv6 is enabled, it should be safe to use localhost directly, in general
         # case it is more reliable to resolve the IP address explicitly.
         return socket.gethostbyname("localhost") + ":0"
+
+
+class TestHashEquivalenceWebsocketServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
+    def setUp(self):
+        try:
+            import websockets
+        except ImportError as e:
+            self.skipTest(str(e))
+
+        super().setUp()
+
+    def get_server_addr(self, server_idx):
+        # Some hosts cause asyncio module to misbehave, when IPv6 is not enabled.
+        # If IPv6 is enabled, it should be safe to use localhost directly, in general
+        # case it is more reliable to resolve the IP address explicitly.
+        host = socket.gethostbyname("localhost")
+        return "ws://%s:0" % host
-- 
2.34.1


