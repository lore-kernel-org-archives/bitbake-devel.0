Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2399BC25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 22:47:46 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web10.2794.1717022864632076208
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 May 2024 15:47:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=N03F3Gev;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f89b16d081so191831a34.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 15:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717022863; x=1717627663; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=504/9JzXLefbNAddjTmvD4rU9PNXm82o1AXoIP9QZJA=;
        b=N03F3GevnOC88ktkHdwEIVYMEdA+hKZJLOzxAlsY2LNxaf7YoZMD5Bk3oEN3xN1MXW
         7TNP6GNcvOeB227qq9iTJuiCTMYPVMdTnImJAVjHVtlUzRVtH0SPGDc51VclcUjf15+5
         Ukq3A8sTa1OO5Osu5iatl+qhEN13NzqabS7zuAsGMKxGzd+IrBgwzRX9piKGI3UEFz0v
         O3QrmDG7MrWtqEq8y/FcD86NF4MxL2/Gac3eadUDzE1T0J7h61DerIJfwd9er7IVHs0v
         uHvSCym/oF0sIzqaJcJQGmWggX0eFLixh6ehRoESNYJN7k1OYnN+b+nqmKJFPeZLJ69t
         800A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717022863; x=1717627663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=504/9JzXLefbNAddjTmvD4rU9PNXm82o1AXoIP9QZJA=;
        b=tcMYeHg+mQzPmALX9pIdmWOlYyNdzm7zrUkPtdqvfhTn7yMMzclYbY55/kqIfN+XIW
         ahNFvHbtssvk338KSY1MWY3tOom5HOz3WrHgmgk8IuoSU3yuj0kRaO79qcnONDBXfYce
         4ALLliUtTi9JvqdmFchOfXd2TEP3IX9s+sVjWNNP6MEoA9E1ePgLGtJcQ/79KsPvjXfw
         3/NE0t2VpqIo7lFRJuZrfor/HeijLLplYMx3IUB+YlB4KDCaZ7zCL2+XZ/R6uaG8gI2h
         cYnpsEezeSsG6CsuFqMcIcV8Cbndhg4XUL0KMKFb3GeaNZax0EqbhantqK3J2/aJnK2s
         Gz0w==
X-Gm-Message-State: AOJu0Yx48pg9/+5gMYWQdTE8z/cNpWq6hbtGNnV07oDpSBWUYAfr1RlT
	RCIk97k8fwq9FsL2Ss7bTyAleGxLqoCwxv37irvw9K5ubNq68OZR+8Rx/Q==
X-Google-Smtp-Source: AGHT+IGhZU3u/FbjEffGn5UBVgbQQSanUxuRUBoAh9EzHE2u9ZMT0zRjh3aBQO7iwRGLMMqBrkOFaw==
X-Received: by 2002:a05:6870:8325:b0:24f:e3ad:72ce with SMTP id 586e51a60fabf-25060b3456fmr742241fac.23.1717022862189;
        Wed, 29 May 2024 15:47:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::980])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0bb6693sm2466344a34.1.2024.05.29.15.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 15:47:41 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4] hashserv: client: Add batch stream API
Date: Wed, 29 May 2024 16:47:34 -0600
Message-ID: <20240529224734.540363-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240529203958.3389577-1-JPEWhacker@gmail.com>
References: <20240529203958.3389577-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 22:47:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16285

Changes the stream mode to do "batch" processing. This means that the
sending and reciving of messages is done simultaneously so that messages
can be sent as fast as possible without having to wait for each reply.
This allows multiple messages to be in flight at once, reducing the
effect of the round trip latency from the server.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py | 106 ++++++++++++++++++++++++++++++---
 bitbake/lib/hashserv/tests.py  |  75 +++++++++++++++++++++++
 2 files changed, 172 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 0b254beddd7..775faf935a8 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -5,6 +5,7 @@
 
 import logging
 import socket
+import asyncio
 import bb.asyncrpc
 import json
 from . import create_async_client
@@ -13,6 +14,66 @@ from . import create_async_client
 logger = logging.getLogger("hashserv.client")
 
 
+class Batch(object):
+    def __init__(self):
+        self.done = False
+        self.cond = asyncio.Condition()
+        self.pending = []
+        self.results = []
+        self.sent_count = 0
+
+    async def recv(self, socket):
+        while True:
+            async with self.cond:
+                await self.cond.wait_for(lambda: self.pending or self.done)
+
+                if not self.pending:
+                    if self.done:
+                        return
+                    continue
+
+            r = await socket.recv()
+            self.results.append(r)
+
+            async with self.cond:
+                self.pending.pop(0)
+
+    async def send(self, socket, msgs):
+        try:
+            # In the event of a restart due to a reconnect, all in-flight
+            # messages need to be resent first to keep to result count in sync
+            for m in self.pending:
+                await socket.send(m)
+
+            for m in msgs:
+                # Add the message to the pending list before attempting to send
+                # it so that if the send fails it will be retried
+                async with self.cond:
+                    self.pending.append(m)
+                    self.cond.notify()
+                    self.sent_count += 1
+
+                await socket.send(m)
+
+        finally:
+            async with self.cond:
+                self.done = True
+                self.cond.notify()
+
+    async def process(self, socket, msgs):
+        await asyncio.gather(
+            self.recv(socket),
+            self.send(socket, msgs),
+        )
+
+        if len(self.results) != self.sent_count:
+            raise ValueError(
+                f"Expected result count {len(self.results)}. Expected {self.sent_count}"
+            )
+
+        return self.results
+
+
 class AsyncClient(bb.asyncrpc.AsyncClient):
     MODE_NORMAL = 0
     MODE_GET_STREAM = 1
@@ -36,11 +97,27 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
             if become:
                 await self.become_user(become)
 
-    async def send_stream(self, mode, msg):
+    async def send_stream_batch(self, mode, msgs):
+        """
+        Does a "batch" process of stream messages. This sends the query
+        messages as fast as possible, and simultaneously attempts to read the
+        messages back. This helps to mitigate the effects of latency to the
+        hash equivalence server be allowing multiple queries to be "in-flight"
+        at once
+
+        The implementation does more complicated tracking using a count of sent
+        messages so that `msgs` can be a generator function (i.e. its length is
+        unknown)
+
+        """
+
+        b = Batch()
+
         async def proc():
+            nonlocal b
+
             await self._set_mode(mode)
-            await self.socket.send(msg)
-            return await self.socket.recv()
+            return await b.process(self.socket, msgs)
 
         return await self._send_wrapper(proc)
 
@@ -89,10 +166,15 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         self.mode = new_mode
 
     async def get_unihash(self, method, taskhash):
-        r = await self.send_stream(self.MODE_GET_STREAM, "%s %s" % (method, taskhash))
-        if not r:
-            return None
-        return r
+        r = await self.get_unihash_batch([(method, taskhash)])
+        return r[0]
+
+    async def get_unihash_batch(self, args):
+        result = await self.send_stream_batch(
+            self.MODE_GET_STREAM,
+            (f"{method} {taskhash}" for method, taskhash in args),
+        )
+        return [r if r else None for r in result]
 
     async def report_unihash(self, taskhash, method, outhash, unihash, extra={}):
         m = extra.copy()
@@ -115,8 +197,12 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         )
 
     async def unihash_exists(self, unihash):
-        r = await self.send_stream(self.MODE_EXIST_STREAM, unihash)
-        return r == "true"
+        r = await self.unihash_exists_batch([unihash])
+        return r[0]
+
+    async def unihash_exists_batch(self, unihashes):
+        result = await self.send_stream_batch(self.MODE_EXIST_STREAM, unihashes)
+        return [r == "true" for r in result]
 
     async def get_outhash(self, method, outhash, taskhash, with_unihash=True):
         return await self.invoke(
@@ -237,10 +323,12 @@ class Client(bb.asyncrpc.Client):
             "connect_tcp",
             "connect_websocket",
             "get_unihash",
+            "get_unihash_batch",
             "report_unihash",
             "report_unihash_equiv",
             "get_taskhash",
             "unihash_exists",
+            "unihash_exists_batch",
             "get_outhash",
             "get_stats",
             "reset_stats",
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index 0809453cf87..5349cd58677 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -594,6 +594,43 @@ class HashEquivalenceCommonTests(object):
                 7: None,
             })
 
+    def test_get_unihash_batch(self):
+        TEST_INPUT = (
+            # taskhash                                   outhash                                                            unihash
+            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e','218e57509998197d570e2c98512d0105985dffc9'),
+            # Duplicated taskhash with multiple output hashes and unihashes.
+            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'),
+            # Equivalent hash
+            ("044c2ec8aaf480685a00ff6ff49e6162e6ad34e1", '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', "def64766090d28f627e816454ed46894bb3aab36"),
+            ("e3da00593d6a7fb435c7e2114976c59c5fd6d561", "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a", "3b5d3d83f07f259e9086fcb422c855286e18a57d"),
+            ('35788efcb8dfb0a02659d81cf2bfd695fb30faf9', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2cd'),
+            ('35788efcb8dfb0a02659d81cf2bfd695fb30fafa', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2ce'),
+            ('9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74', '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69', '05d2a63c81e32f0a36542ca677e8ad852365c538'),
+        )
+        EXTRA_QUERIES = (
+            "6b6be7a84ab179b4240c4302518dc3f6",
+        )
+
+        for taskhash, outhash, unihash in TEST_INPUT:
+            self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+
+
+        result = self.client.get_unihash_batch(
+            [(self.METHOD, data[0]) for data in TEST_INPUT] +
+            [(self.METHOD, e) for e in EXTRA_QUERIES]
+        )
+
+        self.assertListEqual(result, [
+            "218e57509998197d570e2c98512d0105985dffc9",
+            "218e57509998197d570e2c98512d0105985dffc9",
+            "218e57509998197d570e2c98512d0105985dffc9",
+            "3b5d3d83f07f259e9086fcb422c855286e18a57d",
+            "f46d3fbb439bd9b921095da657a4de906510d2cd",
+            "f46d3fbb439bd9b921095da657a4de906510d2cd",
+            "05d2a63c81e32f0a36542ca677e8ad852365c538",
+            None,
+        ])
+
     def test_client_pool_unihash_exists(self):
         TEST_INPUT = (
             # taskhash                                   outhash                                                            unihash
@@ -636,6 +673,44 @@ class HashEquivalenceCommonTests(object):
             result = client_pool.unihashes_exist(query)
             self.assertDictEqual(result, expected)
 
+    def test_unihash_exists_batch(self):
+        TEST_INPUT = (
+            # taskhash                                   outhash                                                            unihash
+            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e','218e57509998197d570e2c98512d0105985dffc9'),
+            # Duplicated taskhash with multiple output hashes and unihashes.
+            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'),
+            # Equivalent hash
+            ("044c2ec8aaf480685a00ff6ff49e6162e6ad34e1", '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', "def64766090d28f627e816454ed46894bb3aab36"),
+            ("e3da00593d6a7fb435c7e2114976c59c5fd6d561", "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a", "3b5d3d83f07f259e9086fcb422c855286e18a57d"),
+            ('35788efcb8dfb0a02659d81cf2bfd695fb30faf9', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2cd'),
+            ('35788efcb8dfb0a02659d81cf2bfd695fb30fafa', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2ce'),
+            ('9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74', '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69', '05d2a63c81e32f0a36542ca677e8ad852365c538'),
+        )
+        EXTRA_QUERIES = (
+            "6b6be7a84ab179b4240c4302518dc3f6",
+        )
+
+        result_unihashes = set()
+
+
+        for taskhash, outhash, unihash in TEST_INPUT:
+            result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+            result_unihashes.add(result["unihash"])
+
+        query = []
+        expected = []
+
+        for _, _, unihash in TEST_INPUT:
+            query.append(unihash)
+            expected.append(unihash in result_unihashes)
+
+
+        for unihash in EXTRA_QUERIES:
+            query.append(unihash)
+            expected.append(False)
+
+        result = self.client.unihash_exists_batch(query)
+        self.assertListEqual(result, expected)
 
     def test_auth_read_perms(self):
         admin_client = self.start_auth_server()
-- 
2.43.2


