Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12878C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 19:38:12 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web10.25208.1717011489337189498
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 May 2024 12:38:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lKUG6YqY;
 spf=pass (domain: gmail.com, ip: 209.85.167.181, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d1c077b9baso12378b6e.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717011488; x=1717616288; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtPo09TCv+jJmt5s253OKj0/XBIIpYvWgwic+bg3zpA=;
        b=lKUG6YqYkdjgTYa61Gm/iIKtc/J5ga9D0BEfo+x+Vi1DDWmwzD2pxXXA0BAlB2Lf82
         +yUMGjUJ2GB+dR76tRIWibVtO66TD9BCxyKw8bM1qKzS/BZohwywQf7VWFvI5kkjW90M
         HQvJ8Tf6KNVJiLScez4LM4DRCaypQqCqDrRll3FfHCisWjO/Ig1YyA7DHoSu5GN+F0r+
         DsGXGfN/7ae4dg7wQNsp/0BlZwCXhWVQgoeO8lMYiR9glu7+s7Rv6j7+vxu2z7Usprf4
         MKtJo+YuHJRwSPX7myHiqN/00YTuyKYZqc3khuOC9whnaXJtsqnWz2mm8V+AFCbQ0VjY
         /aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717011488; x=1717616288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtPo09TCv+jJmt5s253OKj0/XBIIpYvWgwic+bg3zpA=;
        b=m1k4DgbRkuRIC3SrCKUHrqPoCbKseHr3RHj0RjPCo+FxqYfqVrwR3eNog4bAA3fZwz
         4PyJkZfz/y2z75pBA09fF1bHMu9vr25ZoubVt10byOc9X9NdM7cloWGOxA1f9MnR00Em
         151EklvF8zUapm3ZbfMV/uM6hPpwpBC0KFdISvu6uVUoN4DOL7Jy7Uk8eq7Bjzphv1ok
         QD7T4COUkyk+fnKazgqRokkB7fLD3XMxoxG/cHVA3xh2mheALrl/ojvwEjMqPtTfxeEs
         QpMn4U27aEoKr5zGCC6iza3MiKmgeMwOwDtVZ1g91qkWOO4YE9NlKoHt5leQ4zVFeg3F
         jgSg==
X-Gm-Message-State: AOJu0YwIizRIPgrGubgRFS6L4Yaeu8b7PyyLjgSjmhjuNsstgtyRK7U2
	YBe8cS9/65+JsYC8CS0MgNJajHOCJNjxmWiQMG15ncwJKr0UYGSgNcIHIw==
X-Google-Smtp-Source: AGHT+IED5bI4yP3HG+4yu2ZNzHtteVMh9+Qqsyhu7+n5FAVeWu33phBmvStnXIUJUeb1qQBj/WmdUw==
X-Received: by 2002:a05:6808:1790:b0:3c9:92f3:d519 with SMTP id 5614622812f47-3d1dcc9afe2mr4322b6e.4.1717011487718;
        Wed, 29 May 2024 12:38:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::980])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d1b37200f9sm1771156b6e.36.2024.05.29.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 12:38:07 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] hashserv: client: Add batch stream API
Date: Wed, 29 May 2024 13:37:51 -0600
Message-ID: <20240529193751.3372652-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240529150234.3321732-2-JPEWhacker@gmail.com>
References: <20240529150234.3321732-2-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 19:38:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16282

Changes the stream mode to do "batch" processing. This means that the
sending and reciving of messages is done simultaneously so that messages
can be sent as fast as possible without having to wait for each reply.
This allows multiple messages to be in flight at once, reducing the
effect of the round trip latency from the server.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py | 92 ++++++++++++++++++++++++++++++----
 bitbake/lib/hashserv/tests.py  | 75 +++++++++++++++++++++++++++
 2 files changed, 158 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 0b254beddd7..9cc5e10708e 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -5,6 +5,7 @@
 
 import logging
 import socket
+import asyncio
 import bb.asyncrpc
 import json
 from . import create_async_client
@@ -13,6 +14,51 @@ from . import create_async_client
 logger = logging.getLogger("hashserv.client")
 
 
+class Batch(object):
+    def __init__(self, socket):
+        self.done = False
+        self.cond = asyncio.Condition()
+        self.pending = 0
+        self.socket = socket
+
+    async def recv(self):
+        result = []
+
+        while True:
+            async with self.cond:
+                await self.cond.wait_for(lambda: self.pending or self.done)
+
+                if self.pending == 0:
+                    if self.done:
+                        return result
+                    continue
+
+                self.pending -= 1
+
+            r = await self.socket.recv()
+            result.append(r)
+
+    async def send(self, msgs):
+        try:
+            for m in msgs:
+                await self.socket.send(m)
+
+                async with self.cond:
+                    self.pending += 1
+                    self.cond.notify()
+        finally:
+            async with self.cond:
+                self.done = True
+                self.cond.notify()
+
+    async def process(self, msgs):
+        result = await asyncio.gather(
+            self.recv(),
+            self.send(msgs),
+        )
+        return result[0]
+
+
 class AsyncClient(bb.asyncrpc.AsyncClient):
     MODE_NORMAL = 0
     MODE_GET_STREAM = 1
@@ -36,11 +82,25 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
         async def proc():
             await self._set_mode(mode)
-            await self.socket.send(msg)
-            return await self.socket.recv()
+
+            b = Batch(self.socket)
+            return await b.process(msgs)
 
         return await self._send_wrapper(proc)
 
@@ -89,10 +149,18 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
+
+        self.logger.warning(f"sent batch of {len(result)}")
+
+        return [r if r else None for r in result]
 
     async def report_unihash(self, taskhash, method, outhash, unihash, extra={}):
         m = extra.copy()
@@ -115,8 +183,12 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
@@ -237,10 +309,12 @@ class Client(bb.asyncrpc.Client):
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


