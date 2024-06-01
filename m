Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DC1C41513
	for <webhook@archiver.kernel.org>; Sat,  1 Jun 2024 12:27:47 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.36213.1717244860558195149
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Jun 2024 05:27:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=zpo1o0UN;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.179, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7025b84c0daso175785b3a.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1717244860; x=1717849660; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrBUtbmTzASjMhuNVF9aO5s2VrhJltfN2ABj7IPmhaE=;
        b=zpo1o0UNxvuZOiEu+k1wA+9dfywxi3hYmH+oPFtGrYkYoSE+A88Py1uXVYWTXLBN0Z
         nagcPr/PYx8oXzYn8LW759WhnZmc3AFZwvLePtpnXfUVZdgrWUsss1kNVmyR88ur73/o
         1jyYAgiSqvlmqvyiaFDtxZYJ2LY+qjQDnOSQ10v+0o+b7iTg/aNXVRTS+O3M4LsZlq+j
         VpoBetfs30maf/y2CnxpxJWhoEsnP6eD9SC+6JYr2ANFD7mRz3f2Js9jqlaWWNTauM3S
         QqkBkj/tTg2MwEBN6KyPQUl0bFnwKQ7vTKJXcwloD27uId+MYrOFMIKzNJUTjP0YWW0Z
         vKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717244860; x=1717849660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrBUtbmTzASjMhuNVF9aO5s2VrhJltfN2ABj7IPmhaE=;
        b=V4tCXjZvv9oDKWYTyMLs7BhuyyFMfgMeW/XeVXJMW88GcmtqIiaav37E8CvZM1Z/eG
         vkyERKYjC9D13lBeN5DFPb39KjYvJAlS3v5pvNmBCM0C/zkVu84ADmEqKmkYYjy9DFO0
         z0w+oAfBlSPMK7Rqfa6oGykOMR4QHbx2iExAj+0NvjDONPoMg5o9r3UDj7dECD1pf1/e
         paT8ZYi4mwa/S+jdgt+rXFydxotCg1O/msLguUGiynVVUCyy2GrWuBtc11p/vfauJFRk
         bucdBMLXqqUGI0cDHQ0v7UGfitMwIML8N/JUfMP+BvQqobUslNHtAQmmevlJrO6UsHdG
         fl5w==
X-Gm-Message-State: AOJu0Yx2vuhgzgVjItaDGTdz5YLu02k1XYAZejuIrS79WjMwwc4EBNH6
	Cj4vs3CHHKIx7IShPi5Zgt6IWkUnUXX9uQlNspbsfWn0nAYb0L7B3Jpj+mhQDOKeo2P5UdVKVXi
	7
X-Google-Smtp-Source: AGHT+IHk33wDgGc1XhupvsjFI3Gc+xJulfC0ekqTXWtK8zVhNwIL9PvHcvXiJYeDMcXH9APWFAB5FA==
X-Received: by 2002:a05:6a00:1a91:b0:702:2749:6097 with SMTP id d2e1a72fcca58-702477bc078mr4574617b3a.1.1717244859593;
        Sat, 01 Jun 2024 05:27:39 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b30013sm2809362b3a.211.2024.06.01.05.27.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 05:27:39 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 7/8] hashserv: client: Add batch stream API
Date: Sat,  1 Jun 2024 05:27:22 -0700
Message-Id: <3599293793816a7c5c9d0f296fb4bb96ea266f8d.1717244760.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717244760.git.steve@sakoman.com>
References: <cover.1717244760.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Jun 2024 12:27:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16311

From: Joshua Watt <JPEWhacker@gmail.com>

Changes the stream mode to do "batch" processing. This means that the
sending and reciving of messages is done simultaneously so that messages
can be sent as fast as possible without having to wait for each reply.
This allows multiple messages to be in flight at once, reducing the
effect of the round trip latency from the server.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/hashserv/client.py | 106 +++++++++++++++++++++++++++++++++++++----
 lib/hashserv/tests.py  |  75 +++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+), 9 deletions(-)

diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 0b254bedd..775faf935 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
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
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 0809453cf..5349cd586 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
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
2.34.1


