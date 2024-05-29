Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A92CC41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 15:03:00 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web11.16732.1716994973347668484
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 29 May 2024 08:02:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UuSmPZZb;
 spf=pass (domain: gmail.com, ip: 209.85.210.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f264d5dadaso1217006a34.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716994972; x=1717599772; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k3kWPjx3Plnp17//ENy6QR/iWDtnd3wNDxTrlzXWn4=;
        b=UuSmPZZb+dz7RWxdFkgGcAvPoLJjxtFfjW+HPq7/l7d1RSMT29FZ/JXejR8v5Q/hXf
         AaNBI0/mYQMkdwKBPOrMC+pBYfnvlS1FwIUecejcQRxxKwwKkkkFB6Yr5ds5zNZVE/MO
         lQqtLWwxDvxPou1MZOxkW/l4v92fRQ3Kjp1Io1JTh2+IszRh24R5L8RBTDkHxXlmixek
         0DXiEUYpX6LSNm6m3j+ANk3AChX2ds75oAkB8STuDAR6fwhYBlY1tCfN1mn/hqDWK7Ld
         vy1qxF2EFa0ymDJpmXKYXYUcVfzLHhNBFhrhyS0JuDkNh26dB3bS/fMVteHhaqpm+iz6
         R6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716994972; x=1717599772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k3kWPjx3Plnp17//ENy6QR/iWDtnd3wNDxTrlzXWn4=;
        b=wt+uP4mYpKFzch/pgTy05YdNuXhmssmamyMCFajONi4+MHq6VLM8bW2qvbijo3l2Sa
         bjoRJQqZ+8RMo5nAOYBIUgUN7INqHmjLc7oLd9f5nPv7JJoB8fbemugvN3ZI2a19XCNK
         lnDfCASAI1vWP7zyRbkB9uFmWOtLvqyM1QWimZGufZqlrbyjZeADYDQXHSftB5OprWSw
         0c8cNXkXqm2W1KCj+4sL8vS2xWx8farPe2j+Br2iLGf7XsEVOTj0fnR/K6l3BCmwvMhj
         WOlHAPvH6A5oArVy7B742yZY4II/ZlWGHhSAJ4oQudvm7an+v/CVhzQv+XrHJsCDkgZC
         aqdA==
X-Gm-Message-State: AOJu0Yz2TQYg47dSpiry/ye/6ETZxdKB0fCxJdcDdfRBo5AWeWQZ93FI
	vIYmz5nh3h4fQUAkOnYXF848v8kRNozCfEu9uwI8n9+2JbwM6fkgkiNZTg==
X-Google-Smtp-Source: AGHT+IEe7+7uetXx+n1kz+J44Db6i+RPbeyVPTAyvhbOVRd4rCun+7UGgJziyGc1/dOVkKMEoUkezg==
X-Received: by 2002:a05:6830:2b0a:b0:6ee:3b91:5e3b with SMTP id 46e09a7af769-6f8d0b22c6dmr19895683a34.27.1716994971661;
        Wed, 29 May 2024 08:02:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::980])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0daf302sm2338944a34.20.2024.05.29.08.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 08:02:51 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 1/2] hashserv: client: Add batch stream API
Date: Wed, 29 May 2024 09:00:10 -0600
Message-ID: <20240529150234.3321732-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240529150234.3321732-1-JPEWhacker@gmail.com>
References: <20240529150234.3321732-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 29 May 2024 15:03:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16280

Changes the stream mode to do "batch" processing. This means that the
sending and receiving of messages is done simultaneously so that messages
can be sent as fast as possible without having to wait for each reply.
This allows multiple messages to be in flight at once, reducing the
effect of the round trip latency from the server.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py | 87 ++++++++++++++++++++++++++++++----
 bitbake/lib/hashserv/tests.py  | 75 +++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 9 deletions(-)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 0b254beddd7..b1bdd67eeaa 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -5,6 +5,7 @@
 
 import logging
 import socket
+import asyncio
 import bb.asyncrpc
 import json
 from . import create_async_client
@@ -36,11 +37,65 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
+        done = False
+        send_count = 0
+        cond = asyncio.Condition()
+
+        async def reader():
+            nonlocal done
+            nonlocal send_count
+            nonlocal cond
+
+            result = []
+
+            while True:
+                async with cond:
+                    await cond.wait_for(lambda: len(result) < send_count or done)
+
+                    if len(result) == send_count and done:
+                        return result
+
+                r = await self.socket.recv()
+                result.append(r)
+
+        async def writer():
+            nonlocal done
+            nonlocal send_count
+            nonlocal cond
+
+            try:
+                for msg in msgs:
+                    await self.socket.send(msg)
+
+                    async with cond:
+                        send_count += 1
+                        cond.notify()
+            finally:
+                async with cond:
+                    done = True
+                    cond.notify()
+
         async def proc():
             await self._set_mode(mode)
-            await self.socket.send(msg)
-            return await self.socket.recv()
+
+            result = await asyncio.gather(
+                reader(),
+                writer(),
+            )
+            return result[0]
 
         return await self._send_wrapper(proc)
 
@@ -89,10 +144,18 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
@@ -115,8 +178,12 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
@@ -237,10 +304,12 @@ class Client(bb.asyncrpc.Client):
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


