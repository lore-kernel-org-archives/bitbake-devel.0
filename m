Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web08.17232.1618227720058447224
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Apr 2021 04:42:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=UlaJxHE6;
 spf=pass (domain: konsulko.com, ip: 209.85.221.43, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f43.google.com with SMTP id x15so12599820wrq.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Apr 2021 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PH9WLLNcd47LqEQRvAVdPesef2wcVeTmoEFJgvZJ17o=;
        b=UlaJxHE660KlBtyrqSyIZT+i03v7iSfz+oeudVHuBWkJsiK5Onl+Qefahu1Ls9a7eM
         w6G/+vB4kFTrSanDAnBGADMFnXJrpvpr5x6Z25gioepTfw+dSEkxqxPy8szUo7sY/vEl
         F067nT/K7X/GxGWKtc9kv570Mzk3fKWxXVFjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PH9WLLNcd47LqEQRvAVdPesef2wcVeTmoEFJgvZJ17o=;
        b=Qt85dsYKouVLIaNqh+RedK8mmg0mCAnF03xeT1NnQ58hIHqnQlRI+sGLt/Vlxxr4kl
         WQiJz75hnc4/ZMLdGp/qzZS3cNyWQGXoUdmqdgWqLSHlCQI6N+XHiX8JoBZHR26VxKdk
         MiepzRzStCB7mQrLKmwzLkYFPsEoMtL8+DApIxVx2TWuZeHfuWJW+T8fHEz3cz68OejM
         QakFJAeIC/SF2dvBuWvYtdPJWQ4223po5vBLJxm3GKGnhFFEYNii3YjU1aHtPDKuoAb9
         URfrNQ2V7eVFO1JM/tvoLknt2k2GPc89F7AUKw+3zPYr4WCpp4tPmKYuuRq6tD/1a2DE
         1fnQ==
X-Gm-Message-State: AOAM532Scwm6yO2SV7Da2NT/z5JddWmZf3MFJBPFmEOAq/6MQdg3y8ah
	eVtG1rZOUWLr2Gmb1zc9rbi2ikREc3oWZQ==
X-Google-Smtp-Source: ABdhPJyup/n99YnIc3so9+WMaO4zDXAhL8WiSxMbg0PLGwaHhXhC+TnDLY3aYh/s6IA0BXGx/TgTIg==
X-Received: by 2002:adf:f308:: with SMTP id i8mr11541917wro.209.1618227718332;
        Mon, 12 Apr 2021 04:41:58 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id 3sm17931294wma.45.2021.04.12.04.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:41:57 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 02/11] asyncrpc: Common implementation of RPC using json & asyncio
Date: Mon, 12 Apr 2021 12:41:40 +0100
Message-Id: <20210412114149.4750-3-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412114149.4750-1-pbarker@konsulko.com>
References: <20210412114149.4750-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hashserv module implements a flexible RPC mechanism based on sending
json formatted messages over unix or tcp sockets and uses Python's
asyncio features to build an efficient message loop on both the client
and server side. Much of this implementation is not specific to the
hash equivalency service and can be extracted into a new module for
easy re-use elsewhere in bitbake.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/bb/asyncrpc/__init__.py |  31 +++++
 lib/bb/asyncrpc/client.py   | 145 ++++++++++++++++++++++++
 lib/bb/asyncrpc/serv.py     | 218 ++++++++++++++++++++++++++++++++++++
 3 files changed, 394 insertions(+)
 create mode 100644 lib/bb/asyncrpc/__init__.py
 create mode 100644 lib/bb/asyncrpc/client.py
 create mode 100644 lib/bb/asyncrpc/serv.py

diff --git a/lib/bb/asyncrpc/__init__.py b/lib/bb/asyncrpc/__init__.py
new file mode 100644
index 000000000..b2bec31ab
--- /dev/null
+++ b/lib/bb/asyncrpc/__init__.py
@@ -0,0 +1,31 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import itertools
+import json
+
+# The Python async server defaults to a 64K receive buffer, so we hardcode our
+# maximum chunk size. It would be better if the client and server reported to
+# each other what the maximum chunk sizes were, but that will slow down the
+# connection setup with a round trip delay so I'd rather not do that unless it
+# is necessary
+DEFAULT_MAX_CHUNK = 32 * 1024
+
+
+def chunkify(msg, max_chunk):
+    if len(msg) < max_chunk - 1:
+        yield ''.join((msg, "\n"))
+    else:
+        yield ''.join((json.dumps({
+                'chunk-stream': None
+            }), "\n"))
+
+        args = [iter(msg)] * (max_chunk - 1)
+        for m in map(''.join, itertools.zip_longest(*args, fillvalue='')):
+            yield ''.join(itertools.chain(m, "\n"))
+        yield "\n"
+
+
+from .client import AsyncClient, Client
+from .serv import AsyncServer, AsyncServerConnection
diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
new file mode 100644
index 000000000..4cdad9ac3
--- /dev/null
+++ b/lib/bb/asyncrpc/client.py
@@ -0,0 +1,145 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import abc
+import asyncio
+import json
+import os
+import socket
+from . import chunkify, DEFAULT_MAX_CHUNK
+
+
+class AsyncClient(object):
+    def __init__(self, proto_name, proto_version, logger):
+        self.reader = None
+        self.writer = None
+        self.max_chunk = DEFAULT_MAX_CHUNK
+        self.proto_name = proto_name
+        self.proto_version = proto_version
+        self.logger = logger
+
+    async def connect_tcp(self, address, port):
+        async def connect_sock():
+            return await asyncio.open_connection(address, port)
+
+        self._connect_sock = connect_sock
+
+    async def connect_unix(self, path):
+        async def connect_sock():
+            return await asyncio.open_unix_connection(path)
+
+        self._connect_sock = connect_sock
+
+    async def setup_connection(self):
+        s = '%s %s\n\n' % (self.proto_name, self.proto_version)
+        self.writer.write(s.encode("utf-8"))
+        await self.writer.drain()
+
+    async def connect(self):
+        if self.reader is None or self.writer is None:
+            (self.reader, self.writer) = await self._connect_sock()
+            await self.setup_connection()
+
+    async def close(self):
+        self.reader = None
+
+        if self.writer is not None:
+            self.writer.close()
+            self.writer = None
+
+    async def _send_wrapper(self, proc):
+        count = 0
+        while True:
+            try:
+                await self.connect()
+                return await proc()
+            except (
+                OSError,
+                ConnectionError,
+                json.JSONDecodeError,
+                UnicodeDecodeError,
+            ) as e:
+                self.logger.warning("Error talking to server: %s" % e)
+                if count >= 3:
+                    if not isinstance(e, ConnectionError):
+                        raise ConnectionError(str(e))
+                    raise e
+                await self.close()
+                count += 1
+
+    async def send_message(self, msg):
+        async def get_line():
+            line = await self.reader.readline()
+            if not line:
+                raise ConnectionError("Connection closed")
+
+            line = line.decode("utf-8")
+
+            if not line.endswith("\n"):
+                raise ConnectionError("Bad message %r" % msg)
+
+            return line
+
+        async def proc():
+            for c in chunkify(json.dumps(msg), self.max_chunk):
+                self.writer.write(c.encode("utf-8"))
+            await self.writer.drain()
+
+            l = await get_line()
+
+            m = json.loads(l)
+            if m and "chunk-stream" in m:
+                lines = []
+                while True:
+                    l = (await get_line()).rstrip("\n")
+                    if not l:
+                        break
+                    lines.append(l)
+
+                m = json.loads("".join(lines))
+
+            return m
+
+        return await self._send_wrapper(proc)
+
+
+class Client(object):
+    def __init__(self):
+        self.client = self._get_async_client()
+        self.loop = asyncio.new_event_loop()
+
+        self._add_methods('connect_tcp', 'close')
+
+    @abc.abstractmethod
+    def _get_async_client(self):
+        pass
+
+    def _get_downcall_wrapper(self, downcall):
+        def wrapper(*args, **kwargs):
+            return self.loop.run_until_complete(downcall(*args, **kwargs))
+
+        return wrapper
+
+    def _add_methods(self, *methods):
+        for m in methods:
+            downcall = getattr(self.client, m)
+            setattr(self, m, self._get_downcall_wrapper(downcall))
+
+    def connect_unix(self, path):
+        # AF_UNIX has path length issues so chdir here to workaround
+        cwd = os.getcwd()
+        try:
+            os.chdir(os.path.dirname(path))
+            self.loop.run_until_complete(self.client.connect_unix(os.path.basename(path)))
+            self.loop.run_until_complete(self.client.connect())
+        finally:
+            os.chdir(cwd)
+
+    @property
+    def max_chunk(self):
+        return self.client.max_chunk
+
+    @max_chunk.setter
+    def max_chunk(self, value):
+        self.client.max_chunk = value
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
new file mode 100644
index 000000000..cb3384639
--- /dev/null
+++ b/lib/bb/asyncrpc/serv.py
@@ -0,0 +1,218 @@
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import abc
+import asyncio
+import json
+import os
+import signal
+import socket
+import sys
+from . import chunkify, DEFAULT_MAX_CHUNK
+
+
+class ClientError(Exception):
+    pass
+
+
+class ServerError(Exception):
+    pass
+
+
+class AsyncServerConnection(object):
+    def __init__(self, reader, writer, proto_name, logger):
+        self.reader = reader
+        self.writer = writer
+        self.proto_name = proto_name
+        self.max_chunk = DEFAULT_MAX_CHUNK
+        self.handlers = {
+            'chunk-stream': self.handle_chunk,
+        }
+        self.logger = logger
+
+    async def process_requests(self):
+        try:
+            self.addr = self.writer.get_extra_info('peername')
+            self.logger.debug('Client %r connected' % (self.addr,))
+
+            # Read protocol and version
+            client_protocol = await self.reader.readline()
+            if client_protocol is None:
+                return
+
+            (client_proto_name, client_proto_version) = client_protocol.decode('utf-8').rstrip().split()
+            if client_proto_name != self.proto_name:
+                self.logger.debug('Rejecting invalid protocol %s' % (self.proto_name))
+                return
+
+            self.proto_version = tuple(int(v) for v in client_proto_version.split('.'))
+            if not self.validate_proto_version():
+                self.logger.debug('Rejecting invalid protocol version %s' % (client_proto_version))
+                return
+
+            # Read headers. Currently, no headers are implemented, so look for
+            # an empty line to signal the end of the headers
+            while True:
+                line = await self.reader.readline()
+                if line is None:
+                    return
+
+                line = line.decode('utf-8').rstrip()
+                if not line:
+                    break
+
+            # Handle messages
+            while True:
+                d = await self.read_message()
+                if d is None:
+                    break
+                await self.dispatch_message(d)
+                await self.writer.drain()
+        except ClientError as e:
+            self.logger.error(str(e))
+        finally:
+            self.writer.close()
+
+    async def dispatch_message(self, msg):
+        for k in self.handlers.keys():
+            if k in msg:
+                self.logger.debug('Handling %s' % k)
+                await self.handlers[k](msg[k])
+                return
+
+        raise ClientError("Unrecognized command %r" % msg)
+
+    def write_message(self, msg):
+        for c in chunkify(json.dumps(msg), self.max_chunk):
+            self.writer.write(c.encode('utf-8'))
+
+    async def read_message(self):
+        l = await self.reader.readline()
+        if not l:
+            return None
+
+        try:
+            message = l.decode('utf-8')
+
+            if not message.endswith('\n'):
+                return None
+
+            return json.loads(message)
+        except (json.JSONDecodeError, UnicodeDecodeError) as e:
+            self.logger.error('Bad message from client: %r' % message)
+            raise e
+
+    async def handle_chunk(self, request):
+        lines = []
+        try:
+            while True:
+                l = await self.reader.readline()
+                l = l.rstrip(b"\n").decode("utf-8")
+                if not l:
+                    break
+                lines.append(l)
+
+            msg = json.loads(''.join(lines))
+        except (json.JSONDecodeError, UnicodeDecodeError) as e:
+            self.logger.error('Bad message from client: %r' % lines)
+            raise e
+
+        if 'chunk-stream' in msg:
+            raise ClientError("Nested chunks are not allowed")
+
+        await self.dispatch_message(msg)
+
+
+class AsyncServer(object):
+    def __init__(self, logger, loop=None):
+        if loop is None:
+            self.loop = asyncio.new_event_loop()
+            self.close_loop = True
+        else:
+            self.loop = loop
+            self.close_loop = False
+
+        self._cleanup_socket = None
+        self.logger = logger
+
+    def start_tcp_server(self, host, port):
+        self.server = self.loop.run_until_complete(
+            asyncio.start_server(self.handle_client, host, port, loop=self.loop)
+        )
+
+        for s in self.server.sockets:
+            self.logger.info('Listening on %r' % (s.getsockname(),))
+            # Newer python does this automatically. Do it manually here for
+            # maximum compatibility
+            s.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1)
+            s.setsockopt(socket.SOL_TCP, socket.TCP_QUICKACK, 1)
+
+        name = self.server.sockets[0].getsockname()
+        if self.server.sockets[0].family == socket.AF_INET6:
+            self.address = "[%s]:%d" % (name[0], name[1])
+        else:
+            self.address = "%s:%d" % (name[0], name[1])
+
+    def start_unix_server(self, path):
+        def cleanup():
+            os.unlink(path)
+
+        cwd = os.getcwd()
+        try:
+            # Work around path length limits in AF_UNIX
+            os.chdir(os.path.dirname(path))
+            self.server = self.loop.run_until_complete(
+                asyncio.start_unix_server(self.handle_client, os.path.basename(path), loop=self.loop)
+            )
+        finally:
+            os.chdir(cwd)
+
+        self.logger.info('Listening on %r' % path)
+
+        self._cleanup_socket = cleanup
+        self.address = "unix://%s" % os.path.abspath(path)
+
+    @abc.abstractmethod
+    def accept_client(self, reader, writer):
+        pass
+
+    async def handle_client(self, reader, writer):
+        # writer.transport.set_write_buffer_limits(0)
+        try:
+            client = self.accept_client(reader, writer)
+            await client.process_requests()
+        except Exception as e:
+            import traceback
+            self.logger.error('Error from client: %s' % str(e), exc_info=True)
+            traceback.print_exc()
+            writer.close()
+        self.logger.info('Client disconnected')
+
+    def run_loop_forever(self):
+        try:
+            self.loop.run_forever()
+        except KeyboardInterrupt:
+            pass
+
+    def signal_handler(self):
+        self.loop.stop()
+
+    def serve_forever(self):
+        asyncio.set_event_loop(self.loop)
+        try:
+            self.loop.add_signal_handler(signal.SIGTERM, self.signal_handler)
+
+            self.run_loop_forever()
+            self.server.close()
+
+            self.loop.run_until_complete(self.server.wait_closed())
+            self.logger.info('Server shutting down')
+        finally:
+            if self.close_loop:
+                if sys.version_info >= (3, 6):
+                    self.loop.run_until_complete(self.loop.shutdown_asyncgens())
+                self.loop.close()
+
+            if self._cleanup_socket is not None:
+                self._cleanup_socket()
-- 
2.26.2

