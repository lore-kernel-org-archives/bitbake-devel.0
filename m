Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web08.4092.1619425008842471227
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Apr 2021 01:16:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=VAUgMgbi;
 spf=pass (domain: konsulko.com, ip: 209.85.128.43, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f43.google.com with SMTP id a22-20020a05600c2256b0290142870824e9so229685wmm.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Apr 2021 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i0ZZXZsCyY70C5Ljcv/QG2uPguKqaJAGWNQAheLM4Bw=;
        b=VAUgMgbirL7vkoNrL0cbpXGFFpkQYPBNadFGRRTI1Vd58/F1sP1w7SfmpvIq10hmwu
         /DIb1uWLaEcRUS8V3mQimqODWaju9koOILSJaj08Jt5wZICbZOiQonPBmUzs+asjb5U1
         /dh/aXFbS4tFKi8H74szr24lRi7fnvhDmPUFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i0ZZXZsCyY70C5Ljcv/QG2uPguKqaJAGWNQAheLM4Bw=;
        b=O9+jtziLC/+vER/QzoZtsCSPpSjZZNyZNk5BJS4UbK2133obuqLETA2BtBCtNezAJF
         04aBB/I9hQGDo0rmLVOyPfkjkmuqX6EQKKmqIueOZpz1QdgniafjUJRTydvnae0PN9lY
         R0/PVX+T2LfA2/6AVgSYoz7uPsAqsTeLV8C8sBAhU+hAb8f3E7LzeZOe8+gD1Ssze0+h
         MTCT+0yihbAmUf3Qr8BQkko/IQwH9FxwEyxNPfrYsDAgqG1HYn9o9DguJ8b0Gh5dPq3c
         hR154hub7IMv2XGdZ0/qM5wHOzkxWDSZp2qMW5EmmRNEnOsYgW/hcjW3Yse1e8v0KxMd
         woRw==
X-Gm-Message-State: AOAM531c4IQyFde2aGM5Z5D7U5qTLnIDyGAOz3AqIRIdgIzsM4eV+CDP
	dN7Qr4N/FNvaeDTnAATRjBUvLgUkAsZm7w==
X-Google-Smtp-Source: ABdhPJzZTwT5ZO2NRTB1dT/ZpGlowh1hdkFNHbmQGho4GkEnI2+ky1sxTLgSkQwoMPoww9uxm+qomw==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr17990046wmb.183.1619425006981;
        Mon, 26 Apr 2021 01:16:46 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id a9sm4631320wrw.26.2021.04.26.01.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:16:46 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 3/6] hashserv: Refactor to use asyncrpc
Date: Mon, 26 Apr 2021 09:16:30 +0100
Message-Id: <20210426081633.5020-4-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210426081633.5020-1-pbarker@konsulko.com>
References: <20210426081633.5020-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The asyncrpc module can now be used to provide the json & asyncio based
RPC system used by hashserv.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/hashserv/client.py | 137 ++++-----------------------
 lib/hashserv/server.py | 210 +++++------------------------------------
 2 files changed, 41 insertions(+), 306 deletions(-)

diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index f370cba63..531170967 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -8,106 +8,26 @@ import json
 import logging
 import socket
 import os
-from . import chunkify, DEFAULT_MAX_CHUNK, create_async_client
+import bb.asyncrpc
+from . import create_async_client
 
 
 logger = logging.getLogger("hashserv.client")
 
 
-class AsyncClient(object):
+class AsyncClient(bb.asyncrpc.AsyncClient):
     MODE_NORMAL = 0
     MODE_GET_STREAM = 1
 
     def __init__(self):
-        self.reader = None
-        self.writer = None
+        super().__init__('OEHASHEQUIV', '1.1', logger)
         self.mode = self.MODE_NORMAL
-        self.max_chunk = DEFAULT_MAX_CHUNK
 
-    async def connect_tcp(self, address, port):
-        async def connect_sock():
-            return await asyncio.open_connection(address, port)
-
-        self._connect_sock = connect_sock
-
-    async def connect_unix(self, path):
-        async def connect_sock():
-            return await asyncio.open_unix_connection(path)
-
-        self._connect_sock = connect_sock
-
-    async def connect(self):
-        if self.reader is None or self.writer is None:
-            (self.reader, self.writer) = await self._connect_sock()
-
-            self.writer.write("OEHASHEQUIV 1.1\n\n".encode("utf-8"))
-            await self.writer.drain()
-
-            cur_mode = self.mode
-            self.mode = self.MODE_NORMAL
-            await self._set_mode(cur_mode)
-
-    async def close(self):
-        self.reader = None
-
-        if self.writer is not None:
-            self.writer.close()
-            self.writer = None
-
-    async def _send_wrapper(self, proc):
-        count = 0
-        while True:
-            try:
-                await self.connect()
-                return await proc()
-            except (
-                OSError,
-                ConnectionError,
-                json.JSONDecodeError,
-                UnicodeDecodeError,
-            ) as e:
-                logger.warning("Error talking to server: %s" % e)
-                if count >= 3:
-                    if not isinstance(e, ConnectionError):
-                        raise ConnectionError(str(e))
-                    raise e
-                await self.close()
-                count += 1
-
-    async def send_message(self, msg):
-        async def get_line():
-            line = await self.reader.readline()
-            if not line:
-                raise ConnectionError("Connection closed")
-
-            line = line.decode("utf-8")
-
-            if not line.endswith("\n"):
-                raise ConnectionError("Bad message %r" % message)
-
-            return line
-
-        async def proc():
-            for c in chunkify(json.dumps(msg), self.max_chunk):
-                self.writer.write(c.encode("utf-8"))
-            await self.writer.drain()
-
-            l = await get_line()
-
-            m = json.loads(l)
-            if m and "chunk-stream" in m:
-                lines = []
-                while True:
-                    l = (await get_line()).rstrip("\n")
-                    if not l:
-                        break
-                    lines.append(l)
-
-                m = json.loads("".join(lines))
-
-            return m
-
-        return await self._send_wrapper(proc)
+    async def setup_connection(self):
+        await super().setup_connection()
+        cur_mode = self.mode
+        self.mode = self.MODE_NORMAL
+        await self._set_mode(cur_mode)
 
     async def send_stream(self, msg):
         async def proc():
@@ -185,12 +105,10 @@ class AsyncClient(object):
         return (await self.send_message({"backfill-wait": None}))["tasks"]
 
 
-class Client(object):
+class Client(bb.asyncrpc.Client):
     def __init__(self):
-        self.client = AsyncClient()
-        self.loop = asyncio.new_event_loop()
-
-        for call in (
+        super().__init__()
+        self._add_methods(
             "connect_tcp",
             "close",
             "get_unihash",
@@ -200,30 +118,7 @@ class Client(object):
             "get_stats",
             "reset_stats",
             "backfill_wait",
-        ):
-            downcall = getattr(self.client, call)
-            setattr(self, call, self._get_downcall_wrapper(downcall))
-
-    def _get_downcall_wrapper(self, downcall):
-        def wrapper(*args, **kwargs):
-            return self.loop.run_until_complete(downcall(*args, **kwargs))
-
-        return wrapper
-
-    def connect_unix(self, path):
-        # AF_UNIX has path length issues so chdir here to workaround
-        cwd = os.getcwd()
-        try:
-            os.chdir(os.path.dirname(path))
-            self.loop.run_until_complete(self.client.connect_unix(os.path.basename(path)))
-            self.loop.run_until_complete(self.client.connect())
-        finally:
-            os.chdir(cwd)
-
-    @property
-    def max_chunk(self):
-        return self.client.max_chunk
-
-    @max_chunk.setter
-    def max_chunk(self, value):
-        self.client.max_chunk = value
+        )
+
+    def _get_async_client(self):
+        return AsyncClient()
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index a0dc0c170..c941c0e9d 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -14,7 +14,9 @@ import signal
 import socket
 import sys
 import time
-from . import chunkify, DEFAULT_MAX_CHUNK, create_async_client, TABLE_COLUMNS
+from . import create_async_client, TABLE_COLUMNS
+import bb.asyncrpc
+
 
 logger = logging.getLogger('hashserv.server')
 
@@ -109,12 +111,6 @@ class Stats(object):
         return {k: getattr(self, k) for k in ('num', 'total_time', 'max_time', 'average', 'stdev')}
 
 
-class ClientError(Exception):
-    pass
-
-class ServerError(Exception):
-    pass
-
 def insert_task(cursor, data, ignore=False):
     keys = sorted(data.keys())
     query = '''INSERT%s INTO tasks_v2 (%s) VALUES (%s)''' % (
@@ -149,7 +145,7 @@ async def copy_outhash_from_upstream(client, db, method, outhash, taskhash):
 
     return d
 
-class ServerClient(object):
+class ServerClient(bb.asyncrpc.AsyncServerConnection):
     FAST_QUERY = 'SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
     ALL_QUERY =  'SELECT *                         FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
     OUTHASH_QUERY = '''
@@ -168,21 +164,19 @@ class ServerClient(object):
         '''
 
     def __init__(self, reader, writer, db, request_stats, backfill_queue, upstream, read_only):
-        self.reader = reader
-        self.writer = writer
+        super().__init__(reader, writer, 'OEHASHEQUIV', logger)
         self.db = db
         self.request_stats = request_stats
-        self.max_chunk = DEFAULT_MAX_CHUNK
+        self.max_chunk = bb.asyncrpc.DEFAULT_MAX_CHUNK
         self.backfill_queue = backfill_queue
         self.upstream = upstream
 
-        self.handlers = {
+        self.handlers.update({
             'get': self.handle_get,
             'get-outhash': self.handle_get_outhash,
             'get-stream': self.handle_get_stream,
             'get-stats': self.handle_get_stats,
-            'chunk-stream': self.handle_chunk,
-        }
+        })
 
         if not read_only:
             self.handlers.update({
@@ -192,56 +186,19 @@ class ServerClient(object):
                 'backfill-wait': self.handle_backfill_wait,
             })
 
+    def validate_proto_version(self):
+        return (self.proto_version > (1, 0) and self.proto_version <= (1, 1))
+
     async def process_requests(self):
         if self.upstream is not None:
             self.upstream_client = await create_async_client(self.upstream)
         else:
             self.upstream_client = None
 
-        try:
-
-
-            self.addr = self.writer.get_extra_info('peername')
-            logger.debug('Client %r connected' % (self.addr,))
-
-            # Read protocol and version
-            protocol = await self.reader.readline()
-            if protocol is None:
-                return
-
-            (proto_name, proto_version) = protocol.decode('utf-8').rstrip().split()
-            if proto_name != 'OEHASHEQUIV':
-                return
-
-            proto_version = tuple(int(v) for v in proto_version.split('.'))
-            if proto_version < (1, 0) or proto_version > (1, 1):
-                return
-
-            # Read headers. Currently, no headers are implemented, so look for
-            # an empty line to signal the end of the headers
-            while True:
-                line = await self.reader.readline()
-                if line is None:
-                    return
+        await super().process_requests()
 
-                line = line.decode('utf-8').rstrip()
-                if not line:
-                    break
-
-            # Handle messages
-            while True:
-                d = await self.read_message()
-                if d is None:
-                    break
-                await self.dispatch_message(d)
-                await self.writer.drain()
-        except ClientError as e:
-            logger.error(str(e))
-        finally:
-            if self.upstream_client is not None:
-                await self.upstream_client.close()
-
-            self.writer.close()
+        if self.upstream_client is not None:
+            await self.upstream_client.close()
 
     async def dispatch_message(self, msg):
         for k in self.handlers.keys():
@@ -255,47 +212,7 @@ class ServerClient(object):
                         await self.handlers[k](msg[k])
                 return
 
-        raise ClientError("Unrecognized command %r" % msg)
-
-    def write_message(self, msg):
-        for c in chunkify(json.dumps(msg), self.max_chunk):
-            self.writer.write(c.encode('utf-8'))
-
-    async def read_message(self):
-        l = await self.reader.readline()
-        if not l:
-            return None
-
-        try:
-            message = l.decode('utf-8')
-
-            if not message.endswith('\n'):
-                return None
-
-            return json.loads(message)
-        except (json.JSONDecodeError, UnicodeDecodeError) as e:
-            logger.error('Bad message from client: %r' % message)
-            raise e
-
-    async def handle_chunk(self, request):
-        lines = []
-        try:
-            while True:
-                l = await self.reader.readline()
-                l = l.rstrip(b"\n").decode("utf-8")
-                if not l:
-                    break
-                lines.append(l)
-
-            msg = json.loads(''.join(lines))
-        except (json.JSONDecodeError, UnicodeDecodeError) as e:
-            logger.error('Bad message from client: %r' % message)
-            raise e
-
-        if 'chunk-stream' in msg:
-            raise ClientError("Nested chunks are not allowed")
-
-        await self.dispatch_message(msg)
+        raise bb.asyncrpc.ClientError("Unrecognized command %r" % msg)
 
     async def handle_get(self, request):
         method = request['method']
@@ -499,74 +416,20 @@ class ServerClient(object):
             cursor.close()
 
 
-class Server(object):
+class Server(bb.asyncrpc.AsyncServer):
     def __init__(self, db, loop=None, upstream=None, read_only=False):
         if upstream and read_only:
-            raise ServerError("Read-only hashserv cannot pull from an upstream server")
+            raise bb.asyncrpc.ServerError("Read-only hashserv cannot pull from an upstream server")
+
+        super().__init__(logger, loop)
 
         self.request_stats = Stats()
         self.db = db
-
-        if loop is None:
-            self.loop = asyncio.new_event_loop()
-            self.close_loop = True
-        else:
-            self.loop = loop
-            self.close_loop = False
-
         self.upstream = upstream
         self.read_only = read_only
 
-        self._cleanup_socket = None
-
-    def start_tcp_server(self, host, port):
-        self.server = self.loop.run_until_complete(
-            asyncio.start_server(self.handle_client, host, port, loop=self.loop)
-        )
-
-        for s in self.server.sockets:
-            logger.info('Listening on %r' % (s.getsockname(),))
-            # Newer python does this automatically. Do it manually here for
-            # maximum compatibility
-            s.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1)
-            s.setsockopt(socket.SOL_TCP, socket.TCP_QUICKACK, 1)
-
-        name = self.server.sockets[0].getsockname()
-        if self.server.sockets[0].family == socket.AF_INET6:
-            self.address = "[%s]:%d" % (name[0], name[1])
-        else:
-            self.address = "%s:%d" % (name[0], name[1])
-
-    def start_unix_server(self, path):
-        def cleanup():
-            os.unlink(path)
-
-        cwd = os.getcwd()
-        try:
-            # Work around path length limits in AF_UNIX
-            os.chdir(os.path.dirname(path))
-            self.server = self.loop.run_until_complete(
-                asyncio.start_unix_server(self.handle_client, os.path.basename(path), loop=self.loop)
-            )
-        finally:
-            os.chdir(cwd)
-
-        logger.info('Listening on %r' % path)
-
-        self._cleanup_socket = cleanup
-        self.address = "unix://%s" % os.path.abspath(path)
-
-    async def handle_client(self, reader, writer):
-        # writer.transport.set_write_buffer_limits(0)
-        try:
-            client = ServerClient(reader, writer, self.db, self.request_stats, self.backfill_queue, self.upstream, self.read_only)
-            await client.process_requests()
-        except Exception as e:
-            import traceback
-            logger.error('Error from client: %s' % str(e), exc_info=True)
-            traceback.print_exc()
-            writer.close()
-        logger.info('Client disconnected')
+    def accept_client(self, reader, writer):
+        return ServerClient(reader, writer, self.db, self.request_stats, self.backfill_queue, self.upstream, self.read_only)
 
     @contextmanager
     def _backfill_worker(self):
@@ -597,31 +460,8 @@ class Server(object):
         else:
             yield
 
-    def serve_forever(self):
-        def signal_handler():
-            self.loop.stop()
-
-        asyncio.set_event_loop(self.loop)
-        try:
-            self.backfill_queue = asyncio.Queue()
-
-            self.loop.add_signal_handler(signal.SIGTERM, signal_handler)
-
-            with self._backfill_worker():
-                try:
-                    self.loop.run_forever()
-                except KeyboardInterrupt:
-                    pass
-
-                self.server.close()
-
-            self.loop.run_until_complete(self.server.wait_closed())
-            logger.info('Server shutting down')
-        finally:
-            if self.close_loop:
-                if sys.version_info >= (3, 6):
-                    self.loop.run_until_complete(self.loop.shutdown_asyncgens())
-                self.loop.close()
+    def run_loop_forever(self):
+        self.backfill_queue = asyncio.Queue()
 
-            if self._cleanup_socket is not None:
-                self._cleanup_socket()
+        with self._backfill_worker():
+            super().run_loop_forever()
-- 
2.26.2

