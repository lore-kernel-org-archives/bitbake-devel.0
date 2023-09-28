Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751CBE732F8
	for <webhook@archiver.kernel.org>; Thu, 28 Sep 2023 17:05:59 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web11.18860.1695920758795780890
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Sep 2023 10:05:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ctqul+bG;
 spf=pass (domain: gmail.com, ip: 209.85.167.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3af5b5d7f16so1619161b6e.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 Sep 2023 10:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695920757; x=1696525557; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bw9taJarT/airkFdi9rJBJ9ECeJqhRQXfeJolDXHxAo=;
        b=Ctqul+bGWqHTwUQ0J+JCRVH/ypT2m6fmLi85dQTgZi+doh5fgrfqwPMfdxui6FLQLr
         xkRpljwAtEiXPy/Bz1oEwdSDs7dylDVCwkN9vYS5h2uKA1zukDIX0hQD35Wpj9XQaDPX
         eRHWkqE7QtlnLDaDZiluh1vArTMmCH63yO3jtV53oj0anWfdljd9aGarCMTGhdDGwTV3
         WxGnVuDR+wB/6JnApdSwIZpJ9n8BqADJM+eaS/L9PbS6AFJfpY2QWqbPBywsBXazhqsg
         RzsJWe1TF+KIvQC5PWmImzPLBEUYQoKgUs+Fku2+cKAouNUxAGYIoqqSFrPckH05nwX9
         aEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695920757; x=1696525557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bw9taJarT/airkFdi9rJBJ9ECeJqhRQXfeJolDXHxAo=;
        b=e7djmMxjlM0HTdUJfTpikcZCHll3N5CDvV5nt1ogdc1XRLsL2wccLam/GhJoPxWCJ6
         ZyF2VODhP4HzpHT1rfVwC4FKCDynNMz8S5esYl+SHy1nBH+VCk7PEQs4OOzlUVeNSRr/
         G47p85r2Ll1T5fKf/0ST67Re1FZV/Wb8N0yjQv6UdEidYD81baS6HblBHIjmEDL2vPTn
         DoaqWYyLWpj3Z+/5Ji5BJw2bUjixJWK+LhujnXotsv2O1CW4D3kfnX5qLmOe8W3LZN3O
         5SUB9OfMQO9+N8WOcCgrKvofZQEjxwG9yDQWjJa3LdNxOvr6am6NkQ28yvZZoo3B7MWr
         ysCw==
X-Gm-Message-State: AOJu0Yy1nIW9aGjK1n3f9SwUB3eOSPr9k5wDfX4e4jPsdZ/CcUg9r2zZ
	V9WpZ/EvC+E+an9yt9W6oFgPg3bxh1A=
X-Google-Smtp-Source: AGHT+IEfD7t+uYlVg8NPJeES+xu/P+pMcHiqGcveapqpHK+p/ZE3LL2wNt8kh/MNYoaxW+oI7awnCw==
X-Received: by 2002:a05:6870:148c:b0:1dc:bb65:f2be with SMTP id k12-20020a056870148c00b001dcbb65f2bemr1893607oab.10.1695920757259;
        Thu, 28 Sep 2023 10:05:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::f27c])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b001dd533c4bd1sm1389772oal.1.2023.09.28.10.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:05:56 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC 1/5] asyncrpc: Abstract client socket
Date: Thu, 28 Sep 2023 11:05:47 -0600
Message-Id: <20230928170551.4193224-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928170551.4193224-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Sep 2023 17:05:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15143

Rewrites the asyncrpc client code to make it possible to have other
transport backends that are not stream based (e.g. websockets which are
message based).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/asyncrpc/client.py | 135 ++++++++++++++++++------------
 bitbake/lib/hashserv/client.py    |  24 +++---
 bitbake/lib/prserv/client.py      |   8 +-
 3 files changed, 95 insertions(+), 72 deletions(-)

diff --git a/bitbake/lib/bb/asyncrpc/client.py b/bitbake/lib/bb/asyncrpc/client.py
index fa042bbe87c..335da09d8c6 100644
--- a/bitbake/lib/bb/asyncrpc/client.py
+++ b/bitbake/lib/bb/asyncrpc/client.py
@@ -13,10 +13,74 @@ import sys
 from . import chunkify, DEFAULT_MAX_CHUNK
 
 
+class StreamParser(object):
+    def __init__(self, reader, writer, timeout, max_chunk):
+        self.reader = reader
+        self.writer = writer
+        self.timeout = timeout
+        self.max_chunk = max_chunk
+
+    async def setup_connection(self, proto_name, proto_version):
+        s = "%s %s\n\n" % (proto_name, proto_version)
+        self.writer.write(s.encode("utf-8"))
+        await self.writer.drain()
+
+    async def invoke(self, msg):
+        async def get_line():
+            try:
+                line = await asyncio.wait_for(self.reader.readline(), self.timeout)
+            except asyncio.TimeoutError:
+                raise ConnectionError("Timed out waiting for server")
+
+            if not line:
+                raise ConnectionError("Connection closed")
+
+            line = line.decode("utf-8")
+
+            if not line.endswith("\n"):
+                raise ConnectionError("Bad message %r" % (line))
+
+            return line
+
+        for c in chunkify(json.dumps(msg), self.max_chunk):
+            self.writer.write(c.encode("utf-8"))
+        await self.writer.drain()
+
+        l = await get_line()
+
+        m = json.loads(l)
+        if m and "chunk-stream" in m:
+            lines = []
+            while True:
+                l = (await get_line()).rstrip("\n")
+                if not l:
+                    break
+                lines.append(l)
+
+            m = json.loads("".join(lines))
+
+        return m
+
+    async def send(self, msg):
+        self.writer.write(("%s\n" % msg).encode("utf-8"))
+        await self.writer.drain()
+
+    async def recv(self):
+        l = await self.reader.readline()
+        if not l:
+            raise ConnectionError("Connection closed")
+        return l.decode("utf-8").rstrip()
+
+    async def close(self):
+        self.reader = None
+        if self.writer is not None:
+            self.writer.close()
+            self.writer = None
+
+
 class AsyncClient(object):
     def __init__(self, proto_name, proto_version, logger, timeout=30):
-        self.reader = None
-        self.writer = None
+        self.socket = None
         self.max_chunk = DEFAULT_MAX_CHUNK
         self.proto_name = proto_name
         self.proto_version = proto_version
@@ -25,7 +89,8 @@ class AsyncClient(object):
 
     async def connect_tcp(self, address, port):
         async def connect_sock():
-            return await asyncio.open_connection(address, port)
+            reader, writer = await asyncio.open_connection(address, port)
+            return StreamParser(reader, writer, self.timeout, self.max_chunk)
 
         self._connect_sock = connect_sock
 
@@ -40,27 +105,24 @@ class AsyncClient(object):
                 sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM, 0)
                 sock.connect(os.path.basename(path))
             finally:
-               os.chdir(cwd)
-            return await asyncio.open_unix_connection(sock=sock)
+                os.chdir(cwd)
+            reader, writer = await asyncio.open_unix_connection(sock=sock)
+            return StreamParser(reader, writer, self.timeout, self.max_chunk)
 
         self._connect_sock = connect_sock
 
     async def setup_connection(self):
-        s = '%s %s\n\n' % (self.proto_name, self.proto_version)
-        self.writer.write(s.encode("utf-8"))
-        await self.writer.drain()
+        await self.socket.setup_connection(self.proto_name, self.proto_version)
 
     async def connect(self):
-        if self.reader is None or self.writer is None:
-            (self.reader, self.writer) = await self._connect_sock()
+        if self.socket is None:
+            self.socket = await self._connect_sock()
             await self.setup_connection()
 
     async def close(self):
-        self.reader = None
-
-        if self.writer is not None:
-            self.writer.close()
-            self.writer = None
+        if self.socket is not None:
+            await self.socket.close()
+            self.socket = None
 
     async def _send_wrapper(self, proc):
         count = 0
@@ -82,49 +144,14 @@ class AsyncClient(object):
                 await self.close()
                 count += 1
 
-    async def send_message(self, msg):
-        async def get_line():
-            try:
-                line = await asyncio.wait_for(self.reader.readline(), self.timeout)
-            except asyncio.TimeoutError:
-                raise ConnectionError("Timed out waiting for server")
-
-            if not line:
-                raise ConnectionError("Connection closed")
-
-            line = line.decode("utf-8")
-
-            if not line.endswith("\n"):
-                raise ConnectionError("Bad message %r" % (line))
-
-            return line
-
+    async def invoke(self, msg):
         async def proc():
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
+            return await self.socket.invoke(msg)
 
         return await self._send_wrapper(proc)
 
     async def ping(self):
-        return await self.send_message(
-            {'ping': {}}
-        )
+        return await self.send_message({"ping": {}})
 
 
 class Client(object):
@@ -142,7 +169,7 @@ class Client(object):
         # required (but harmless) with it.
         asyncio.set_event_loop(self.loop)
 
-        self._add_methods('connect_tcp', 'ping')
+        self._add_methods("connect_tcp", "ping")
 
     @abc.abstractmethod
     def _get_async_client(self):
diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index b2aa1026ac9..2a3c1b662b6 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -28,12 +28,8 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
 
     async def send_stream(self, msg):
         async def proc():
-            self.writer.write(("%s\n" % msg).encode("utf-8"))
-            await self.writer.drain()
-            l = await self.reader.readline()
-            if not l:
-                raise ConnectionError("Connection closed")
-            return l.decode("utf-8").rstrip()
+            await self.socket.send(msg)
+            return await self.socket.recv()
 
         return await self._send_wrapper(proc)
 
@@ -43,7 +39,7 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
             if r != "ok":
                 raise ConnectionError("Bad response from server %r" % r)
         elif new_mode == self.MODE_GET_STREAM and self.mode == self.MODE_NORMAL:
-            r = await self.send_message({"get-stream": None})
+            r = await self.invoke({"get-stream": None})
             if r != "ok":
                 raise ConnectionError("Bad response from server %r" % r)
         elif new_mode != self.mode:
@@ -67,7 +63,7 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         m["method"] = method
         m["outhash"] = outhash
         m["unihash"] = unihash
-        return await self.send_message({"report": m})
+        return await self.invoke({"report": m})
 
     async def report_unihash_equiv(self, taskhash, method, unihash, extra={}):
         await self._set_mode(self.MODE_NORMAL)
@@ -75,31 +71,31 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         m["taskhash"] = taskhash
         m["method"] = method
         m["unihash"] = unihash
-        return await self.send_message({"report-equiv": m})
+        return await self.invoke({"report-equiv": m})
 
     async def get_taskhash(self, method, taskhash, all_properties=False):
         await self._set_mode(self.MODE_NORMAL)
-        return await self.send_message(
+        return await self.invoke(
             {"get": {"taskhash": taskhash, "method": method, "all": all_properties}}
         )
 
     async def get_outhash(self, method, outhash, taskhash):
         await self._set_mode(self.MODE_NORMAL)
-        return await self.send_message(
+        return await self.invoke(
             {"get-outhash": {"outhash": outhash, "taskhash": taskhash, "method": method}}
         )
 
     async def get_stats(self):
         await self._set_mode(self.MODE_NORMAL)
-        return await self.send_message({"get-stats": None})
+        return await self.invoke({"get-stats": None})
 
     async def reset_stats(self):
         await self._set_mode(self.MODE_NORMAL)
-        return await self.send_message({"reset-stats": None})
+        return await self.invoke({"reset-stats": None})
 
     async def backfill_wait(self):
         await self._set_mode(self.MODE_NORMAL)
-        return (await self.send_message({"backfill-wait": None}))["tasks"]
+        return (await self.invoke({"backfill-wait": None}))["tasks"]
 
 
 class Client(bb.asyncrpc.Client):
diff --git a/bitbake/lib/prserv/client.py b/bitbake/lib/prserv/client.py
index 69ab7a4ac9d..6b81356fac5 100644
--- a/bitbake/lib/prserv/client.py
+++ b/bitbake/lib/prserv/client.py
@@ -14,28 +14,28 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
         super().__init__('PRSERVICE', '1.0', logger)
 
     async def getPR(self, version, pkgarch, checksum):
-        response = await self.send_message(
+        response = await self.invoke(
             {'get-pr': {'version': version, 'pkgarch': pkgarch, 'checksum': checksum}}
         )
         if response:
             return response['value']
 
     async def importone(self, version, pkgarch, checksum, value):
-        response = await self.send_message(
+        response = await self.invoke(
             {'import-one': {'version': version, 'pkgarch': pkgarch, 'checksum': checksum, 'value': value}}
         )
         if response:
             return response['value']
 
     async def export(self, version, pkgarch, checksum, colinfo):
-        response = await self.send_message(
+        response = await self.invoke(
             {'export': {'version': version, 'pkgarch': pkgarch, 'checksum': checksum, 'colinfo': colinfo}}
         )
         if response:
             return (response['metainfo'], response['datainfo'])
 
     async def is_readonly(self):
-        response = await self.send_message(
+        response = await self.invoke(
             {'is-readonly': {}}
         )
         if response:
-- 
2.34.1


