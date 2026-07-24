Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD8DC53209
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 21:28:31 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28918.1784928507495863074
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jul 2026 14:28:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=DuQGag9S;
 spf=pass (domain: gmail.com, ip: 209.85.210.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e6b5737bb2so798349a34.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 14:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784928507; x=1785533307; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkvlTppzlY9z98B+XfnNU0JHQBJqdVgCIejfzQAzX74=;
        b=DuQGag9SEF+rPkro4cYmfu/kGrcIo8uOdGyn4Q0x85AviYhINkNbnXXJ7cI90itdqC
         uGKLG0BWksZX3OptSTzWuSSqpRpgpzgDDOsdMCb6G1U6Nuz7kHa/T7zzsjT3mTKb5Jcy
         lRiJC2S8zdIuCu7KnjwK4/id4xzsHXWXDQUlXrmhyAcf47ZLQt/YSSh1aUkOsm6UZQ8q
         e8mGAfEESJmRUJH1CckeDPgFp+GbcPKOgKocC9q5pvqeTQ2ehVVhPZ4T1FNlNtZxT4cT
         urGA3rcc+ijTczeRNoNl+WLYMdTg+XSslQOEBhthgtVias8uK1nnM57MOYQngscBADww
         lxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928507; x=1785533307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkvlTppzlY9z98B+XfnNU0JHQBJqdVgCIejfzQAzX74=;
        b=h4/gRlBvaKbqPvhcSLlpUOkb0BlowWPY7OitoPqD2r7ajges/a7vq1Hiqg0B/VM7Gz
         ijjLN5V+Kn3twAQcOmIuQsKOYHOI/QUjb8Ud2gmt5vwJjZ2dcBXLgVfSYANwHDxehpfC
         GPWeDrNta5eSzsX40+FSPwUdcJAh7+YFdjrn2KVN0Qr2hiXH1QMTiS68SqdQGG/iRbnK
         EVWcHxprj3eeAsFIIv4u86dHRjQOfSDi6+TH397jfr0vMoaJhVKHgmoEwswH0t+RhhNW
         KX7o0blBAPbMUK9BImi1+H8TXrwfuV8gKWQHVTCxNOylqzber1XZmJsVuGmYe4EUy7j1
         yUCg==
X-Gm-Message-State: AOJu0YyVgUUkd6Fv/NvmkC4C+jr7EfnxJFbq5b24NO/Yv3l4tRZGlyyO
	9DhKRgCNRvoLTSfoFUyAq8/D0raE2kiGhcd650V+UrTteSmgjP5mbIk2dCDVZg==
X-Gm-Gg: AR+sD12DUFBw+QIrE5pGHlwYrRRkAwqZAniGGZzjAWqkbUHk/XWZCxSqARovBHf9VYo
	pcsSZbXA5DZ4W8p6bfXlm7EnMkL3892vfL9Jf9Q1c1dTPT1mYLSyMG7nbyxveu9aLvvuwv2h2Q/
	iQe1+M+BGehmy8OZZruJWhnnTdVVtLBec+/JkPu8wQoS52bIRu1osS4VGEK1i9a02PeRU2aUpUC
	eEJDN/6egGyMxxv4WEHTqZZqeK9RWwPPyPOb75cTUeSanRMwYbBl4KzJXMW2z8OLdAR+8eQjUYu
	vHjlxdGcI9pCJ0b9fBOAstDOVw+43NCSaR9FGKRaKX12Z2dv5gjIzrQ18A4PirCsmhBdvrKuBWc
	9XI79TEnFsBs3C1XKQ3pWjHLw2pa5PrFJDyrzO48Io5fv1l173ki/8KG1fI9UuPZnSyJdYKFBXm
	YVk9wGL64QRA==
X-Received: by 2002:a05:6808:14c4:b0:4a1:296:adec with SMTP id 5614622812f47-4ab6a0dec55mr186123b6e.15.1784928506580;
        Fri, 24 Jul 2026 14:28:26 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::5d97])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457673d2dc1sm8183883fac.10.2026.07.24.14.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:28:26 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michal.sieron@nokia.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 1/6] hashserv: client: Add asynchronous streaming API
Date: Fri, 24 Jul 2026 15:25:09 -0600
Message-ID: <20260724212822.1165552-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724212822.1165552-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 21:28:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19851

Implments a true asynchronous streaming API for getting a unihash
(get_unihash_stream()) and checking if a unihash exists
(unihash_exists_stream()). These APIs allow a client to send a query the
to the server, then wait for the reply later. Using this API, it is
possible to interleave queries and replies.

In addition, the gc_mark_stream() API is renamed gc_mark_batch() to
match the pattern of the other APIs, and an actual gc_mark_stream() API
is implemented that allows asynchronous streaming like the others.

Note that the new stream APIs are not accessible in the "synchronous"
client API since async constructs must be used for them to make sense.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashclient |   2 +-
 lib/hashserv/client.py | 306 ++++++++++++++++++++++++++++++++---------
 lib/hashserv/tests.py  |   4 +-
 3 files changed, 243 insertions(+), 69 deletions(-)

diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
index 3a2bf5c0d..ee5c32f5f 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -240,7 +240,7 @@ def main():
         marked_hashes = 0
 
         try:
-            result = client.gc_mark_stream(args.mark, stdin)
+            result = client.gc_mark_batch(args.mark, stdin)
             marked_hashes = result["count"]
         except ConnectionError:
             logger.warning(
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 8cb18050a..8e9eaaca3 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -8,44 +8,212 @@ import socket
 import asyncio
 import bb.asyncrpc
 import json
+from abc import abstractmethod
+from collections.abc import AsyncIterable
+from contextlib import asynccontextmanager
+from dataclasses import dataclass
 from . import create_async_client
 
-
 logger = logging.getLogger("hashserv.client")
 
 
+class AsyncQueue(AsyncIterable):
+    class Shutdown(Exception):
+        pass
+
+    SHUTDOWN_SENTINEL = object()
+
+    def __init__(self, *args, **kwargs):
+        self.__queue = asyncio.Queue()
+        self.__shutdown = False
+        self.__is_done = False
+
+    async def done(self):
+        if self.__is_done:
+            return
+        self.__is_done = True
+        await self.__queue.put(self.SHUTDOWN_SENTINEL)
+
+    async def put(self, item):
+        if self.__is_done:
+            raise self.Shutdown
+        await self.__queue.put(item)
+
+    async def get(self):
+        if self.__shutdown:
+            raise self.Shutdown
+
+        item = await self.__queue.get()
+        if item is self.SHUTDOWN_SENTINEL:
+            self.__shutdown = True
+            raise self.Shutdown
+
+        return item
+
+    def __aiter__(self):
+        return self
+
+    async def __anext__(self):
+        try:
+            return await self.get()
+        except self.Shutdown:
+            raise StopAsyncIteration
+
+
+@dataclass(eq=False, frozen=True)
+class AsyncPipe:
+    send_queue: AsyncQueue
+    recv_queue: AsyncQueue
+
+
+class Stream(AsyncIterable):
+    def __init__(self, pipe):
+        self._pipe = pipe
+
+    async def done(self):
+        await self._pipe.send_queue.done()
+
+    def __aiter__(self):
+        return self
+
+    async def __anext__(self):
+        try:
+            return await self.get_result()
+        except AsyncQueue.Shutdown:
+            raise StopAsyncIteration
+
+    @abstractmethod
+    async def _send_batch_input(self, i):
+        raise NotImplementedError("Not implemented")
+
+    @abstractmethod
+    async def get_result(self):
+        raise NotImplementedError("Not implemented")
+
+    async def batch(self, inputs):
+        """
+        Does a "batch" process of stream messages. This sends the query
+        messages as fast as possible, and simultaneously attempts to read the
+        messages back. This helps to mitigate the effects of latency to the
+        hash equivalence server be allowing multiple queries to be "in-flight"
+        at once
+
+        The input may be a generator or an async generator
+        """
+
+        async def get_inputs():
+            if isinstance(inputs, AsyncIterable):
+                async for i in inputs:
+                    yield i
+            else:
+                for i in inputs:
+                    yield i
+
+        async def send():
+            try:
+                async for i in get_inputs():
+                    await self._send_batch_input(i)
+            finally:
+                await self.done()
+
+        results = []
+
+        async def recv():
+            async for item in self:
+                results.append(item)
+
+        await asyncio.gather(send(), recv())
+        return results
+
+
+class GetUnihashStream(Stream):
+    def __init__(self, pipe):
+        super().__init__(pipe)
+
+    async def _send_batch_input(self, i):
+        method, taskhash = i
+        await self.send_query(method, taskhash)
+
+    async def send_query(self, method, taskhash):
+        await self._pipe.send_queue.put(f"{method} {taskhash}")
+
+    async def get_result(self):
+        r = await self._pipe.recv_queue.get()
+        return r if r else None
+
+
+class UnihashExistsStream(Stream):
+    def __init__(self, pipe):
+        super().__init__(pipe)
+
+    async def _send_batch_input(self, i):
+        await self.send_query(i)
+
+    async def send_query(self, unihash):
+        await self._pipe.send_queue.put(unihash)
+
+    async def get_result(self):
+        r = await self._pipe.recv_queue.get()
+        return r == "true"
+
+
+class GcMarkStream(Stream):
+    def __init__(self, pipe, mark):
+        super().__init__(pipe)
+        self.mark = mark
+
+    async def _send_batch_input(self, i):
+        def row_to_dict(row):
+            pairs = row.split()
+            return dict(zip(pairs[::2], pairs[1::2]))
+
+        await self.send_mark(row_to_dict(i))
+
+    async def send_mark(self, where):
+        await self._pipe.send_queue.put(json.dumps({"mark": self.mark, "where": where}))
+
+    async def get_result(self):
+        r = await self._pipe.recv_queue.get()
+        return json.loads(r)
+
+
 class Batch(object):
-    def __init__(self):
+    def __init__(self, send_queue, recv_queue):
+        self.send_queue = send_queue
+        self.recv_queue = recv_queue
         self.done = False
         self.cond = asyncio.Condition()
         self.pending = []
-        self.results = []
         self.sent_count = 0
+        self.recv_count = 0
 
     async def recv(self, socket):
-        while True:
-            async with self.cond:
-                await self.cond.wait_for(lambda: self.pending or self.done)
+        try:
+            while True:
+                async with self.cond:
+                    await self.cond.wait_for(lambda: self.pending or self.done)
 
-                if not self.pending:
-                    if self.done:
-                        return
-                    continue
+                    if not self.pending:
+                        if self.done:
+                            return
+                        continue
 
-            r = await socket.recv()
-            self.results.append(r)
+                await self.recv_queue.put(await socket.recv())
 
-            async with self.cond:
-                self.pending.pop(0)
+                async with self.cond:
+                    self.recv_count += 1
+                    self.pending.pop(0)
+        finally:
+            await self.recv_queue.done()
 
-    async def send(self, socket, msgs):
+    async def send(self, socket):
         try:
             # In the event of a restart due to a reconnect, all in-flight
             # messages need to be resent first to keep to result count in sync
             for m in self.pending:
                 await socket.send(m)
 
-            for m in msgs:
+            async for m in self.send_queue:
                 # Add the message to the pending list before attempting to send
                 # it so that if the send fails it will be retried
                 async with self.cond:
@@ -60,19 +228,14 @@ class Batch(object):
                 self.done = True
                 self.cond.notify()
 
-    async def process(self, socket, msgs):
-        await asyncio.gather(
-            self.recv(socket),
-            self.send(socket, msgs),
-        )
+    async def stream(self, socket):
+        await asyncio.gather(self.send(socket), self.recv(socket))
 
-        if len(self.results) != self.sent_count:
-            raise ValueError(
-                f"Expected result count {len(self.results)}. Expected {self.sent_count}"
+        if self.sent_count != self.recv_count:
+            raise ConnectionError(
+                f"Sent {self.sent_count} messages but only received {self.recv_count}"
             )
 
-        return self.results
-
 
 class AsyncClient(bb.asyncrpc.AsyncClient):
     MODE_NORMAL = 0
@@ -98,29 +261,32 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
             if become:
                 await self.become_user(become)
 
-    async def send_stream_batch(self, mode, msgs):
-        """
-        Does a "batch" process of stream messages. This sends the query
-        messages as fast as possible, and simultaneously attempts to read the
-        messages back. This helps to mitigate the effects of latency to the
-        hash equivalence server be allowing multiple queries to be "in-flight"
-        at once
-
-        The implementation does more complicated tracking using a count of sent
-        messages so that `msgs` can be a generator function (i.e. its length is
-        unknown)
-
-        """
-
-        b = Batch()
+    @asynccontextmanager
+    async def send_stream(self, mode):
+        send_queue = AsyncQueue()
+        recv_queue = AsyncQueue()
+        b = Batch(send_queue, recv_queue)
 
         async def proc():
-            nonlocal b
-
             await self._set_mode(mode)
-            return await b.process(self.socket, msgs)
+            await b.stream(self.socket)
+
+        async def process():
+            try:
+                await self._send_wrapper(proc)
+            finally:
+                await recv_queue.done()
 
-        return await self._send_wrapper(proc)
+        # Create background process to process messages
+        task = asyncio.create_task(process())
+
+        try:
+            yield AsyncPipe(send_queue, recv_queue)
+        except AsyncQueue.Shutdown:
+            pass
+        finally:
+            await send_queue.done()
+            await task
 
     async def invoke(self, *args, skip_mode=False, **kwargs):
         # It's OK if connection errors cause a failure here, because the mode
@@ -173,15 +339,18 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         self.mode = new_mode
 
     async def get_unihash(self, method, taskhash):
-        r = await self.get_unihash_batch([(method, taskhash)])
-        return r[0]
+        async with self.get_unihash_stream() as stream:
+            await stream.send_query(method, taskhash)
+            return await stream.get_result()
 
     async def get_unihash_batch(self, args):
-        result = await self.send_stream_batch(
-            self.MODE_GET_STREAM,
-            (f"{method} {taskhash}" for method, taskhash in args),
-        )
-        return [r if r else None for r in result]
+        async with self.get_unihash_stream() as stream:
+            return await stream.batch(args)
+
+    @asynccontextmanager
+    async def get_unihash_stream(self):
+        async with self.send_stream(self.MODE_GET_STREAM) as pipe:
+            yield GetUnihashStream(pipe)
 
     async def report_unihash(self, taskhash, method, outhash, unihash, extra={}):
         m = extra.copy()
@@ -204,12 +373,18 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         )
 
     async def unihash_exists(self, unihash):
-        r = await self.unihash_exists_batch([unihash])
-        return r[0]
+        async with self.unihash_exists_stream() as stream:
+            await stream.send_query(unihash)
+            return await stream.get_result()
 
     async def unihash_exists_batch(self, unihashes):
-        result = await self.send_stream_batch(self.MODE_EXIST_STREAM, unihashes)
-        return [r == "true" for r in result]
+        async with self.unihash_exists_stream() as stream:
+            return await stream.batch(unihashes)
+
+    @asynccontextmanager
+    async def unihash_exists_stream(self):
+        async with self.send_stream(self.MODE_EXIST_STREAM) as pipe:
+            yield UnihashExistsStream(pipe)
 
     async def get_outhash(self, method, outhash, taskhash, with_unihash=True):
         return await self.invoke(
@@ -309,23 +484,22 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         """
         return await self.invoke({"gc-mark": {"mark": mark, "where": where}})
 
-    async def gc_mark_stream(self, mark, rows):
+    async def gc_mark_batch(self, mark, rows):
         """
         Similar to `gc-mark`, but accepts a list of "where" key-value pair
         conditions. It utilizes stream mode to mark hashes, which helps reduce
         the impact of latency when communicating with the hash equivalence
         server.
         """
-        def row_to_dict(row):
-            pairs = row.split()
-            return dict(zip(pairs[::2], pairs[1::2]))
+        async with self.gc_mark_stream(mark) as stream:
+            results = await stream.batch(rows)
 
-        responses = await self.send_stream_batch(
-            self.MODE_MARK_STREAM,
-            (json.dumps({"mark": mark, "where": row_to_dict(row)}) for row in rows),
-        )
+        return {"count": sum(int(r["count"]) for r in results)}
 
-        return {"count": sum(int(json.loads(r)["count"]) for r in responses)}
+    @asynccontextmanager
+    async def gc_mark_stream(self, mark):
+        async with self.send_stream(self.MODE_MARK_STREAM) as pipe:
+            yield GcMarkStream(pipe, mark)
 
     async def gc_sweep(self, mark):
         """
@@ -372,7 +546,7 @@ class Client(bb.asyncrpc.Client):
             "get_db_query_columns",
             "gc_status",
             "gc_mark",
-            "gc_mark_stream",
+            "gc_mark_batch",
             "gc_sweep",
         )
 
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 7c736d6cc..3acfdcd8c 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -1055,7 +1055,7 @@ class HashEquivalenceCommonTests(object):
         # First hash is still present
         self.assertClientGetHash(self.client, taskhash, unihash)
 
-    def test_gc_stream(self):
+    def test_gc_batch(self):
         taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
         unihash = '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc61813739a28007fcdf'
@@ -1078,7 +1078,7 @@ class HashEquivalenceCommonTests(object):
         self.assertClientGetHash(self.client, taskhash3, unihash3)
 
         # Mark the first unihash to be kept
-        ret = self.client.gc_mark_stream("ABC", (f"unihash {h}" for h in [unihash, unihash2]))
+        ret = self.client.gc_mark_batch("ABC", (f"unihash {h}" for h in [unihash, unihash2]))
         self.assertEqual(ret, {"count": 2})
 
         ret = self.client.gc_status()
-- 
2.54.0


