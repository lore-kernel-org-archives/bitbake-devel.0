Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB75AC61DDD
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:55 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4202.1787932790216193821
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=svbxoLm6;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f18c0e03e3so670741a34.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932789; x=1788537589; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=elGM45IJFjC0vRZKWZOIxkCy/9N9jYnBJzioh548U48=;
        b=svbxoLm6ZT68eyrwyzfXkmBFw60srH9MYTfKP9Wf7KHqyneoA9mLxiMQebmMSogHsR
         m1f5KmEtHPDe/mj+jSOZclnh3sHtLDSmPsdVaoEDYGktcI4RuFtr4Ws9knVUinhrp5FX
         ikOE8MtUJ18eFTCC2U/RLx4RxcClmNwgbDFmSG9bOp5IfS8W5FRPbYM3W5cLXIbTfYps
         69s+XlH66ErPE2L6la/eY/zsvBZQYeTcufs1DTvT80VuUImwbeXhuIhev599dk4daLMc
         SDDw5jBACPEe3ePRftGcrrSylsxSlf/CkJSsqMo2/A+5bx2B2sw8U7IyZYQNn5LPu8WU
         yMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932789; x=1788537589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=elGM45IJFjC0vRZKWZOIxkCy/9N9jYnBJzioh548U48=;
        b=pU9N3qURtatDMENHh72DytXMJLu0zzmBuxmFT2yVj1WhVnHzVtAWUoFleW8vOB9rgB
         wPBTzR8+bUOONaveaE3Ctb+jTq3SWZdfpvJzFTQ2W5JUIUX4xi14ISlHD+ZHcQcSuVo8
         Y1xNf6Wj0pjLNWM8Tj8KGWycA7+8I0qBLUIA02leQx6iJjs/20OW+0gMGlIxICgaIIKX
         /XDT96St37pE7nQuQl/jsL0LcXmYokyW94VwbvIuJ9LnFkFGBbIYgUieVtjcF/HaVYee
         7Cp8o7Be8bquvwUuUGNaVQYhLHVssLv5kYoflVZR7SUxClJjQck4zwEUbmFVGDvcqY5l
         oJDg==
X-Gm-Message-State: AFuF++k6sh+e/sQMkMj1/VaofgW65N0gnd4uKbplnaUHMjFjaKMMbHGg
	oEn29KYbKYwzJt7itpmDWUnzaFO06asabqMr68DuK42A2IiZVX/1WQ0S1QfPGw==
X-Gm-Gg: AR+sD12/R3BVi3YjrZYgvXCrmFnXsfFo0+/bQr3v50kfCozKJNPu35gyVkvhjdDBBBn
	41zDOZLWuh+g96rCuUJNKB8TjtOgk2+CSFJ6lCVcxPsCZT5Y2vD5VXZLSfhHibuGWmqGuhDNHRD
	kEV0GCSTwGYx5VvllnDuyfcxXXO4a3nzUkQHgEquaxx3v7kEsy65kXMEgBdzAb51notEYDhjy5F
	aGtD8WE/yvfxJ15r1c0HJlRkbiGCsfOpBKd5s6yXZiuA4B8cy47JSjxGdce7FDiBiFkOMfUgRHV
	uSfcc+liIxduDzVprVdRr84fteTfUZxLCprgPuUzexpysDyjf6U93DtQMU96Z2z9yVeqS7rcWkW
	//wwtONMgj0MNkLV4hadeZTHhsga7zk8TtzBYx45UQHUglYhNxZo+2SsBkYGY2NoTdi8w+nPTqP
	BSTf1oL6lHHB8tM0yY7b+GJ+p+YTLBARszaJQyuADuFYPdjCrCsiZGai9gxA==
X-Received: by 2002:a05:6830:4408:b0:7f4:f1f3:da3b with SMTP id 46e09a7af769-7f4f227a85emr9168115a34.4.1787932789321;
        Fri, 28 Aug 2026 08:59:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:48 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 05/11] hashserv: client: Add asynchronous streaming API
Date: Fri, 28 Aug 2026 09:58:12 -0600
Message-ID: <20260828155942.1219468-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828155942.1219468-1-JPEWhacker@gmail.com>
References: <20260730183254.793698-1-JPEWhacker@gmail.com>
 <20260828155942.1219468-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 15:59:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20111

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
 lib/hashserv/client.py | 349 ++++++++++++++++++++++++++++++++---------
 lib/hashserv/tests.py  |   4 +-
 3 files changed, 275 insertions(+), 80 deletions(-)

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
index 8cb18050a..b447fb259 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -8,70 +8,252 @@ import socket
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
+        await bb.asyncrpc.TaskGroup.run(send(), recv())
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
-        self.done = False
+    def __init__(self, send_queue, recv_queue):
+        self.send_queue = send_queue
+        self.recv_queue = recv_queue
+        self.fill_done = False
+        self.send_done = False
         self.cond = asyncio.Condition()
         self.pending = []
-        self.results = []
         self.sent_count = 0
+        self.recv_count = 0
+        self.item = None
 
     async def recv(self, socket):
         while True:
             async with self.cond:
-                await self.cond.wait_for(lambda: self.pending or self.done)
-
+                await self.cond.wait_for(lambda: self.pending or self.send_done)
                 if not self.pending:
-                    if self.done:
+                    if self.send_done:
                         return
                     continue
 
-            r = await socket.recv()
-            self.results.append(r)
+            m = await socket.recv()
+            await self.recv_queue.put(m)
 
             async with self.cond:
+                self.recv_count += 1
                 self.pending.pop(0)
 
-    async def send(self, socket, msgs):
-        try:
-            # In the event of a restart due to a reconnect, all in-flight
-            # messages need to be resent first to keep to result count in sync
+    async def fill(self):
+        async for m in self.send_queue:
+            async with self.cond:
+                # Wait for item to be consumed
+                await self.cond.wait_for(lambda: self.item is None)
+                self.item = m
+                self.cond.notify_all()
+
+        async with self.cond:
+            self.fill_done = True
+            self.cond.notify_all()
+
+    async def send(self, socket):
+        # In the event of a restart due to a reconnect, all in-flight
+        # messages need to be resent first to keep to result count in sync
+        async with self.cond:
             for m in self.pending:
                 await socket.send(m)
 
-            for m in msgs:
-                # Add the message to the pending list before attempting to send
-                # it so that if the send fails it will be retried
-                async with self.cond:
-                    self.pending.append(m)
-                    self.cond.notify()
-                    self.sent_count += 1
-
-                await socket.send(m)
-
-        finally:
+        while True:
             async with self.cond:
-                self.done = True
-                self.cond.notify()
+                await self.cond.wait_for(
+                    lambda: self.item is not None or self.fill_done
+                )
+                if self.item is None:
+                    if self.fill_done:
+                        self.send_done = True
+                        self.cond.notify_all()
+                        return
+                    continue
 
-    async def process(self, socket, msgs):
-        await asyncio.gather(
-            self.recv(socket),
-            self.send(socket, msgs),
-        )
+                m = self.item
 
-        if len(self.results) != self.sent_count:
-            raise ValueError(
-                f"Expected result count {len(self.results)}. Expected {self.sent_count}"
-            )
+            await socket.send(m)
 
-        return self.results
+            async with self.cond:
+                self.item = None
+                self.pending.append(m)
+                self.sent_count += 1
+                self.cond.notify_all()
+
+    async def stream(self, socket):
+        await bb.asyncrpc.TaskGroup.run(self.send(socket), self.recv(socket))
+
+    def check(self):
+        if self.sent_count != self.recv_count:
+            raise ConnectionError(
+                f"Sent {self.sent_count} messages but only received {self.recv_count}"
+            )
 
 
 class AsyncClient(bb.asyncrpc.AsyncClient):
@@ -98,29 +280,34 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
-
-        return await self._send_wrapper(proc)
+            await b.stream(self.socket)
+
+        async def process():
+            try:
+                await self._send_wrapper(proc)
+            finally:
+                await recv_queue.done()
+
+        # Create background process to process messages
+        async with bb.asyncrpc.TaskGroup() as group:
+            group.create_task(process())
+            group.create_task(b.fill())
+            try:
+                yield AsyncPipe(send_queue, recv_queue)
+                b.check()
+            except AsyncQueue.Shutdown as e:
+                pass
+            finally:
+                await send_queue.done()
+                await recv_queue.done()
 
     async def invoke(self, *args, skip_mode=False, **kwargs):
         # It's OK if connection errors cause a failure here, because the mode
@@ -173,15 +360,18 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
@@ -204,12 +394,18 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
@@ -309,23 +505,22 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
@@ -372,7 +567,7 @@ class Client(bb.asyncrpc.Client):
             "get_db_query_columns",
             "gc_status",
             "gc_mark",
-            "gc_mark_stream",
+            "gc_mark_batch",
             "gc_sweep",
         )
 
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 551b9e298..e24bdcacb 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -1057,7 +1057,7 @@ class HashEquivalenceCommonTests(object):
         # First hash is still present
         self.assertClientGetHash(self.client, taskhash, unihash)
 
-    def test_gc_stream(self):
+    def test_gc_batch(self):
         taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
         unihash = '46edb5140d2613049332d0bf3745d9fafec9c559dac8cc61813739a28007fcdf'
@@ -1080,7 +1080,7 @@ class HashEquivalenceCommonTests(object):
         self.assertClientGetHash(self.client, taskhash3, unihash3)
 
         # Mark the first unihash to be kept
-        ret = self.client.gc_mark_stream("ABC", (f"unihash {h}" for h in [unihash, unihash2]))
+        ret = self.client.gc_mark_batch("ABC", (f"unihash {h}" for h in [unihash, unihash2]))
         self.assertEqual(ret, {"count": 2})
 
         ret = self.client.gc_status()
-- 
2.55.0


