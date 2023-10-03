Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7C2E7AD69
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 14:53:02 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
 by mx.groups.io with SMTP id smtpd.web10.110645.1696344778244043009
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 07:52:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fT3hysjn;
 spf=pass (domain: gmail.com, ip: 209.85.160.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1dd1db54d42so654891fac.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 07:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344777; x=1696949577; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogzgQHCdWX/1lzKRWqRhwcqoambb25mdwnksnUoPMXY=;
        b=fT3hysjn+DiIjzXnFRrrCV9YsnVnut6vsJz6IVfeUv7eTrZ7dATSZbQHt6QwirYddN
         WpM6Q+DIe64fvHifEj9nmyy0EJP7dF69Dv6QkLF8vXhzCPPJdPRyZQfxAz7biR34fK76
         hMWXarymXVdcLZ9szRaugvs5tjHETKtimTqHGExKUHp0CXpwXTOrj8+u3uYaM6TZj0Bm
         ysQgYODxO++EnxkZP5GnZ4fdX+rRZi6gD3CQPjlbe8tunvj85YClQrPyGQsNtPWtH1mK
         94w82VATqzlyfTxBQJYDAu+LZGhqf/WSlZ8DFZwDcFT/AA/cwUJE07slE5SG6LWVtP3m
         57DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344777; x=1696949577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogzgQHCdWX/1lzKRWqRhwcqoambb25mdwnksnUoPMXY=;
        b=csO/APRz4appF9KZ8bgHmNwhXhc92Aoxt+yNu1QotBEVckholwkcMqsT+i7NWPsIR8
         FRbBK0KIe6wBGjoIdsoWmyyJS5JkqE5eJ+gIgDMrChJBt0fjDbibnva+QGEBNBgsaJZn
         wCNy7lT5cMZ2RuOy4HJIxOJD8nWhzZIpCRqB4SvynZh4fKBL6I2SVnfWKADQob8XqN8i
         plExFgnpMl1bSjB0LwQdDulVzkKt8yjanoDvseDrscbyW8dMBaGQ8GltgAK0/zygf3e9
         6x58T1SySAoM1p8hEoXNzLbI7vPCI20OqNffRUPj4ygal/0L4Ji0pWGEP8CskdtZyGwD
         oV/w==
X-Gm-Message-State: AOJu0Yzw9RkcDkjJKlpkT9CnhNI/xI1fv74WC/ClyAjysw4pBwas/eqg
	BG0XL/tHqtkwxJuVA7y7DceGoTJkfXs=
X-Google-Smtp-Source: AGHT+IH9NRQGdgZk4pnkqFbURiB02A1EkvvjvtfXjDDqBvw1ZFuPQOuJrCNYF42HArezJdEtA4AQDA==
X-Received: by 2002:a05:6870:4206:b0:1c0:131b:2bb8 with SMTP id u6-20020a056870420600b001c0131b2bb8mr15833942oac.58.1696344776942;
        Tue, 03 Oct 2023 07:52:56 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::589])
        by smtp.gmail.com with ESMTPSA id du28-20020a0568703a1c00b001dd2b869a26sm253477oab.17.2023.10.03.07.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:52:56 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 04/12] hashserv: Add websocket connection implementation
Date: Tue,  3 Oct 2023 08:52:41 -0600
Message-Id: <20231003145249.1166276-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003145249.1166276-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
 <20231003145249.1166276-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 14:53:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15165

Adds support to the hash equivalence client and server to communicate
over websockets. Since websockets are message orientated instead of
stream orientated, and new connection class is needed to handle them.

Note that websocket support does require the 3rd party websockets python
module be installed on the host, but it should not be required unless
websockets are actually being used.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/asyncrpc/client.py     | 11 +++++-
 bitbake/lib/bb/asyncrpc/connection.py | 44 ++++++++++++++++++++++
 bitbake/lib/bb/asyncrpc/serv.py       | 53 ++++++++++++++++++++++++++-
 bitbake/lib/hashserv/__init__.py      | 13 +++++++
 bitbake/lib/hashserv/client.py        |  1 +
 bitbake/lib/hashserv/tests.py         | 17 +++++++++
 6 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/asyncrpc/client.py b/bitbake/lib/bb/asyncrpc/client.py
index 7f33099b639..802c07df1f4 100644
--- a/bitbake/lib/bb/asyncrpc/client.py
+++ b/bitbake/lib/bb/asyncrpc/client.py
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
diff --git a/bitbake/lib/bb/asyncrpc/connection.py b/bitbake/lib/bb/asyncrpc/connection.py
index c4fd24754c8..a10628f75a6 100644
--- a/bitbake/lib/bb/asyncrpc/connection.py
+++ b/bitbake/lib/bb/asyncrpc/connection.py
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
diff --git a/bitbake/lib/bb/asyncrpc/serv.py b/bitbake/lib/bb/asyncrpc/serv.py
index e823a764067..e2589cb0990 100644
--- a/bitbake/lib/bb/asyncrpc/serv.py
+++ b/bitbake/lib/bb/asyncrpc/serv.py
@@ -12,7 +12,7 @@ import signal
 import socket
 import sys
 import multiprocessing
-from .connection import StreamConnection
+from .connection import StreamConnection, WebsocketConnection
 from .exceptions import ClientError, ServerError, ConnectionClosedError
 
 
@@ -172,6 +172,54 @@ class UnixStreamServer(StreamServer):
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
@@ -184,6 +232,9 @@ class AsyncServer(object):
     def start_unix_server(self, path):
         self.server = UnixStreamServer(path, self._client_handler, self.logger)
 
+    def start_websocket_server(self, host, port):
+        self.server = WebsocketsServer(host, port, self._client_handler, self.logger)
+
     async def _client_handler(self, socket):
         try:
             client = self.accept_client(socket)
diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
index 3a4018353f2..56b9c6bc829 100644
--- a/bitbake/lib/hashserv/__init__.py
+++ b/bitbake/lib/hashserv/__init__.py
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
 
diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index d11d0ca29d0..95c0692353a 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -115,6 +115,7 @@ class Client(bb.asyncrpc.Client):
         super().__init__()
         self._add_methods(
             "connect_tcp",
+            "connect_websocket",
             "get_unihash",
             "report_unihash",
             "report_unihash_equiv",
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index a3e066406e3..a2827e6a301 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -464,3 +464,20 @@ class TestHashEquivalenceTCPServer(HashEquivalenceTestSetup, HashEquivalenceComm
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


