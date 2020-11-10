Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
 by mx.groups.io with SMTP id smtpd.web09.28924.1605020400616168135
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2020 07:00:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=tul9Iv8f;
 spf=pass (domain: gmail.com, ip: 209.85.210.67, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f67.google.com with SMTP id i18so12787505ots.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2020 07:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W9idXQgAlZ7EWdABp9FVfQWqCvJyx2hx9QOn6YSalo0=;
        b=tul9Iv8fxk6/gFeub6Ty66IPwcx1Ol0hD2U46X21tdZqaYgEjXNcE1anvA39S1zD4D
         z0M7AsI51tO3d9hP7izwsEdKZTj/+DRbb/nqKk3GX9PqIskPUcdIWxo1rpvqvVD7SCGG
         3R/9fSpiwy9C6uwamfGZKYdWRxvoRDOxI3IwcQZmDDOeqDX76DWcNf4wjLSgVKcT9YSQ
         ZEE68SjDUlstgGCYXogIIlbaWfkEKrnArSKENVx/u8yB1CVrw5JuMxkMq8DHs21zrain
         xW+KBZy3IaauaWOfg6R18Rh3974A6tMRN9ZRZTmoefDKLHbc7KanJPhefjGqDjqtnSnC
         IsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9idXQgAlZ7EWdABp9FVfQWqCvJyx2hx9QOn6YSalo0=;
        b=QdLz6iNbW5a4Qw1PqrPlfUUKhvxgq/YrZgyRyAolT55XS6RvHRAtA45QQq9R+OfXp9
         TalCGaad6oLHsOWqOlBQqyZ6rg0D2FlcWMfvoGmHbzYtehpL49G73ZjPmDm5Ly58nTOI
         KAJbBCgGX+an+Uu5ZfY/F8GEGQgXtLzEgA6gHJv30V6/di/xH56KO1aC5L7qLytMFQRs
         XTXiY9QNmPT4tRzg3HEGqf5G8/a7KbIwuT2plWydX+eA2fWLGLTNxCO2bmY51PB3anX9
         P7PVeKq8mQlla9vm7zzNSYUbyfRrEqop1+gmFmVRwHRZ0FdInXrAt0h1PsHTPeCGWyI7
         4NsQ==
X-Gm-Message-State: AOAM533t7TQPHEvTmRSWIApkO579aeNxt4x4ZA8j3Q63Z6wgvT6m4/qY
	clvFVc51ID3sCiXNsZQ/UaxiwIaXSr3hJA==
X-Google-Smtp-Source: ABdhPJwOChs+fWfkW3gDMvdK8mj+3y9scvIHAWDvBcICfLc3ptt359xK4Ql0O7Znwa+WBzP2wTmUnA==
X-Received: by 2002:a9d:bec:: with SMTP id 99mr15043355oth.103.1605020399577;
        Tue, 10 Nov 2020 06:59:59 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id a21sm1191038otr.36.2020.11.10.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:59:59 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 1/2] bitbake: hashserve: Add async client
Date: Tue, 10 Nov 2020 08:59:55 -0600
Message-Id: <20201110145956.1518964-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110145956.1518964-1-JPEWhacker@gmail.com>
References: <20201110145956.1518964-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for create a client that operates using Python asynchronous
I/O.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/__init__.py |  13 ++
 bitbake/lib/hashserv/client.py   | 238 +++++++++++++++++--------------
 2 files changed, 143 insertions(+), 108 deletions(-)

diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
index f95e8f43f1..622ca17a91 100644
--- a/bitbake/lib/hashserv/__init__.py
+++ b/bitbake/lib/hashserv/__init__.py
@@ -3,6 +3,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
+import asyncio
 from contextlib import closing
 import re
 import sqlite3
@@ -113,3 +114,15 @@ def create_client(addr):
         c.connect_tcp(*a)
 
     return c
+
+async def create_async_client(addr):
+    from . import client
+    c = client.AsyncClient()
+
+    (typ, a) = parse_address(addr)
+    if typ == ADDR_TYPE_UNIX:
+        await c.connect_unix(*a)
+    else:
+        await c.connect_tcp(*a)
+
+    return c
diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index a29af836d9..d0b3cf3863 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -3,189 +3,211 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
+import asyncio
 import json
 import logging
 import socket
 import os
-from . import chunkify, DEFAULT_MAX_CHUNK
+from . import chunkify, DEFAULT_MAX_CHUNK, create_async_client
 
 
-logger = logging.getLogger('hashserv.client')
+logger = logging.getLogger("hashserv.client")
 
 
 class HashConnectionError(Exception):
     pass
 
 
-class Client(object):
+class AsyncClient(object):
     MODE_NORMAL = 0
     MODE_GET_STREAM = 1
 
     def __init__(self):
-        self._socket = None
         self.reader = None
         self.writer = None
         self.mode = self.MODE_NORMAL
         self.max_chunk = DEFAULT_MAX_CHUNK
 
-    def connect_tcp(self, address, port):
-        def connect_sock():
-            s = socket.create_connection((address, port))
-
-            s.setsockopt(socket.SOL_TCP, socket.TCP_NODELAY, 1)
-            s.setsockopt(socket.SOL_TCP, socket.TCP_QUICKACK, 1)
-            s.setsockopt(socket.SOL_SOCKET, socket.SO_KEEPALIVE, 1)
-            return s
+    async def connect_tcp(self, address, port):
+        async def connect_sock():
+            return await asyncio.open_connection(address, port)
 
         self._connect_sock = connect_sock
 
-    def connect_unix(self, path):
-        def connect_sock():
-            s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
-            # AF_UNIX has path length issues so chdir here to workaround
-            cwd = os.getcwd()
-            try:
-                os.chdir(os.path.dirname(path))
-                s.connect(os.path.basename(path))
-            finally:
-                os.chdir(cwd)
-            return s
+    async def connect_unix(self, path):
+        async def connect_sock():
+            return await asyncio.open_unix_connection(path)
 
         self._connect_sock = connect_sock
 
-    def connect(self):
-        if self._socket is None:
-            self._socket = self._connect_sock()
-
-            self.reader = self._socket.makefile('r', encoding='utf-8')
-            self.writer = self._socket.makefile('w', encoding='utf-8')
+    async def _connect(self):
+        if self.reader is None or self.writer is None:
+            (self.reader, self.writer) = await self._connect_sock()
 
-            self.writer.write('OEHASHEQUIV 1.1\n\n')
-            self.writer.flush()
+            self.writer.write("OEHASHEQUIV 1.1\n\n".encode("utf-8"))
+            await self.writer.drain()
 
-            # Restore mode if the socket is being re-created
             cur_mode = self.mode
             self.mode = self.MODE_NORMAL
-            self._set_mode(cur_mode)
+            await self._set_mode(cur_mode)
 
-        return self._socket
+    async def close(self):
+        self.reader = None
 
-    def close(self):
-        if self._socket is not None:
-            self._socket.close()
-            self._socket = None
-            self.reader = None
+        if self.writer is not None:
+            self.writer.close()
             self.writer = None
 
-    def _send_wrapper(self, proc):
+    async def _send_wrapper(self, proc):
         count = 0
         while True:
             try:
-                self.connect()
-                return proc()
-            except (OSError, HashConnectionError, json.JSONDecodeError, UnicodeDecodeError) as e:
-                logger.warning('Error talking to server: %s' % e)
+                await self._connect()
+                return await proc()
+            except (
+                OSError,
+                HashConnectionError,
+                json.JSONDecodeError,
+                UnicodeDecodeError,
+            ) as e:
+                logger.warning("Error talking to server: %s" % e)
                 if count >= 3:
                     if not isinstance(e, HashConnectionError):
                         raise HashConnectionError(str(e))
                     raise e
-                self.close()
+                await self.close()
                 count += 1
 
-    def send_message(self, msg):
-        def get_line():
-            line = self.reader.readline()
+    async def send_message(self, msg):
+        async def get_line():
+            line = await self.reader.readline()
             if not line:
-                raise HashConnectionError('Connection closed')
+                raise HashConnectionError("Connection closed")
+
+            line = line.decode("utf-8")
 
-            if not line.endswith('\n'):
-                raise HashConnectionError('Bad message %r' % message)
+            if not line.endswith("\n"):
+                raise HashConnectionError("Bad message %r" % message)
 
             return line
 
-        def proc():
+        async def proc():
             for c in chunkify(json.dumps(msg), self.max_chunk):
-                self.writer.write(c)
-            self.writer.flush()
+                self.writer.write(c.encode("utf-8"))
+            await self.writer.drain()
 
-            l = get_line()
+            l = await get_line()
 
             m = json.loads(l)
-            if 'chunk-stream' in m:
+            if "chunk-stream" in m:
                 lines = []
                 while True:
-                    l = get_line().rstrip('\n')
+                    l = (await get_line()).rstrip("\n")
                     if not l:
                         break
                     lines.append(l)
 
-                m = json.loads(''.join(lines))
+                m = json.loads("".join(lines))
 
             return m
 
-        return self._send_wrapper(proc)
+        return await self._send_wrapper(proc)
 
-    def send_stream(self, msg):
-        def proc():
-            self.writer.write("%s\n" % msg)
-            self.writer.flush()
-            l = self.reader.readline()
+    async def send_stream(self, msg):
+        async def proc():
+            self.writer.write(("%s\n" % msg).encode("utf-8"))
+            await self.writer.drain()
+            l = await self.reader.readline()
             if not l:
-                raise HashConnectionError('Connection closed')
-            return l.rstrip()
+                raise HashConnectionError("Connection closed")
+            return l.decode("utf-8").rstrip()
 
-        return self._send_wrapper(proc)
+        return await self._send_wrapper(proc)
 
-    def _set_mode(self, new_mode):
+    async def _set_mode(self, new_mode):
         if new_mode == self.MODE_NORMAL and self.mode == self.MODE_GET_STREAM:
-            r = self.send_stream('END')
-            if r != 'ok':
-                raise HashConnectionError('Bad response from server %r' % r)
+            r = await self.send_stream("END")
+            if r != "ok":
+                raise HashConnectionError("Bad response from server %r" % r)
         elif new_mode == self.MODE_GET_STREAM and self.mode == self.MODE_NORMAL:
-            r = self.send_message({'get-stream': None})
-            if r != 'ok':
-                raise HashConnectionError('Bad response from server %r' % r)
+            r = await self.send_message({"get-stream": None})
+            if r != "ok":
+                raise HashConnectionError("Bad response from server %r" % r)
         elif new_mode != self.mode:
-            raise Exception('Undefined mode transition %r -> %r' % (self.mode, new_mode))
+            raise Exception(
+                "Undefined mode transition %r -> %r" % (self.mode, new_mode)
+            )
 
         self.mode = new_mode
 
-    def get_unihash(self, method, taskhash):
-        self._set_mode(self.MODE_GET_STREAM)
-        r = self.send_stream('%s %s' % (method, taskhash))
+    async def get_unihash(self, method, taskhash):
+        await self._set_mode(self.MODE_GET_STREAM)
+        r = await self.send_stream("%s %s" % (method, taskhash))
         if not r:
             return None
         return r
 
-    def report_unihash(self, taskhash, method, outhash, unihash, extra={}):
-        self._set_mode(self.MODE_NORMAL)
+    async def report_unihash(self, taskhash, method, outhash, unihash, extra={}):
+        await self._set_mode(self.MODE_NORMAL)
         m = extra.copy()
-        m['taskhash'] = taskhash
-        m['method'] = method
-        m['outhash'] = outhash
-        m['unihash'] = unihash
-        return self.send_message({'report': m})
-
-    def report_unihash_equiv(self, taskhash, method, unihash, extra={}):
-        self._set_mode(self.MODE_NORMAL)
+        m["taskhash"] = taskhash
+        m["method"] = method
+        m["outhash"] = outhash
+        m["unihash"] = unihash
+        return await self.send_message({"report": m})
+
+    async def report_unihash_equiv(self, taskhash, method, unihash, extra={}):
+        await self._set_mode(self.MODE_NORMAL)
         m = extra.copy()
-        m['taskhash'] = taskhash
-        m['method'] = method
-        m['unihash'] = unihash
-        return self.send_message({'report-equiv': m})
-
-    def get_taskhash(self, method, taskhash, all_properties=False):
-        self._set_mode(self.MODE_NORMAL)
-        return self.send_message({'get': {
-            'taskhash': taskhash,
-            'method': method,
-            'all': all_properties
-        }})
-
-    def get_stats(self):
-        self._set_mode(self.MODE_NORMAL)
-        return self.send_message({'get-stats': None})
-
-    def reset_stats(self):
-        self._set_mode(self.MODE_NORMAL)
-        return self.send_message({'reset-stats': None})
+        m["taskhash"] = taskhash
+        m["method"] = method
+        m["unihash"] = unihash
+        return await self.send_message({"report-equiv": m})
+
+    async def get_taskhash(self, method, taskhash, all_properties=False):
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.send_message(
+            {"get": {"taskhash": taskhash, "method": method, "all": all_properties}}
+        )
+
+    async def get_stats(self):
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.send_message({"get-stats": None})
+
+    async def reset_stats(self):
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.send_message({"reset-stats": None})
+
+
+class Client(object):
+    def __init__(self):
+        self.client = AsyncClient()
+        self.loop = asyncio.new_event_loop()
+
+        def get_wrapper(self, downcall):
+            def wrapper(*args, **kwargs):
+                return self.loop.run_until_complete(downcall(*args, **kwargs))
+
+            return wrapper
+
+        for call in (
+            "connect_tcp",
+            "connect_unix",
+            "close",
+            "get_unihash",
+            "report_unihash",
+            "report_unihash_equiv",
+            "get_taskhash",
+            "get_stats",
+            "reset_stats",
+        ):
+            downcall = getattr(self.client, call)
+            setattr(self, call, get_wrapper(self, downcall))
+
+    @property
+    def max_chunk(self):
+        return self.client.max_chunk
+
+    @max_chunk.setter
+    def max_chunk(self, value):
+        self.client.max_chunk = value
-- 
2.29.2

