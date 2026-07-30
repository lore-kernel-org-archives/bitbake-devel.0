Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442DAC5516D
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:06 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18820.1785436384405712692
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 11:33:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Kl3sL6jH;
 spf=pass (domain: gmail.com, ip: 209.85.167.169, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4a45b3f0becso107821b6e.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785436383; x=1786041183; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VD93SLKM18OpnS12a8QoQjcZ2EtT5jyWQVqgwN97SRA=;
        b=Kl3sL6jHLDX25MY8Vptl9ahakxhTcdkOFDsm4y51Q1ZC5sJWYKdlkvZQXb05b/0k56
         79PBeGB3P6HoNxb9Fdg3ivnIKxwXCax+I2sc7u4ecR4LPe9D8nD1xJfbVrsIOpzsz9r2
         kecpeIhZPD3Vj+CpbkkrAhfN+yIQVJ8aW1A3N98OKEBPHGwV3eeDxozVbUKicGHiEsY+
         qmxVSauxbxi/WQm8JfiU8qd0CKqmH3aBJl8BRCtJOZymcI9HaLGqbeSQlCWaFuy0HbKK
         zMAAkuN+g/i/AV3yTtckZxkolZtRa7pjmvUx0v92l7GXq4RXIZLXQfCpFQDGYqDPyV1O
         ft2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436383; x=1786041183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VD93SLKM18OpnS12a8QoQjcZ2EtT5jyWQVqgwN97SRA=;
        b=TkOlzMyNA9JylHbMkfhlw2zSFnccNQgU0aAzCR9d9/XI/8eLBwE47zAkHCQ2jTZFgV
         kGVF7tgP2LgfwXqpISCqfz5RAmEo4vzZ9nRaqI1zhh9RGhufifKgSBZDZEUjGCnBNujR
         nCjQGj43tb9byTTbtwbzU/Tr98YEOLeSfAx/endEu2F+A+1WjdqcrwD+DDdzNEhikLcI
         3QMeT8nBavyjGukys1wKoS1lXomgerJgV+zJRrMgAy2DBSBasw3Mizp3Xvn4XYb0n0uu
         seleynSD/Rm8WvUx7OwjAtCsX9OER1PW3W+3VfFg4a+n2qTrcbT5ffAq7PI6LBXEkCPJ
         AxTw==
X-Gm-Message-State: AOJu0YwAMO6abmV2E4wRLeL53sEUuFWhYpp0vMG2hm/zvHrZnnwZF+ZM
	Z9l4/r22FxStuj1K0376tGaWnUNSLrA2PCMeJTFI2oyyab73n2x4uYmGBSmEdg==
X-Gm-Gg: AR+sD135DUyH/0EgxLclQ8JBq4jPsPo8eyC4yLdQ36uC6/Ecxmjfh4mNMzLHzuJRRuU
	SR5JilKxgQI8lWzzRphz62wMlTdTUdU00CTwhkEJeFVF7h0nuHa13G6jfD0wLk6Te3Y+6caH3sB
	l1bVSQjLTxhQsPxkNVQUmFomVAvcONJrR5H20YuD7Y6xZkDa6HoaUF7G+0pncPXCdN1p7xDi8TA
	cYzfaSC6Jz+cYjh00bXc/kjkR0LAK77+3BZRZdC4KfvqxqRyNIZL0DQ2BNjnj1w77D+LOZ9f+AW
	lTuOJ7v5vorIZ6UTPkNs4+3qJTSSViie8SkKKHz/+Lu5d/Dg9416/qmQge0AP+Opiw1AAVQgmLR
	jilA2NHYPTyDRwolLHKQ8/YzdMQcIbFzO7sw5I5ijt3VZ99JU/coycaX9avlMxiirr9O6Ze0Pu9
	NxaS4pBFg4lfF/fJUjYIHMy0361Mhx7rqV4rcjbYxvGzJtw/vx3j54O0EXmA==
X-Received: by 2002:a05:6808:16a7:b0:495:f74a:407d with SMTP id 5614622812f47-4ad8797025cmr2490264b6e.23.1785436383471;
        Thu, 30 Jul 2026 11:33:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::10c9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc5c3fsm4593047b6e.13.2026.07.30.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:33:03 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 09/10] hashserv: tests: Add more upstream tests
Date: Thu, 30 Jul 2026 12:31:02 -0600
Message-ID: <20260730183254.793698-10-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730183254.793698-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
 <20260730183254.793698-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 18:33:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19889

Adds a test to verify that the batch API works properly with an upstream
server and also a test to verify that if the upstream server restarts or
is temporarily disconnected that the client recovers properly.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/tests.py | 152 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 141 insertions(+), 11 deletions(-)

diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index a7ce7425e..bb227c161 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -5,12 +5,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from . import create_server, create_client
+from . import create_server, create_client, create_async_client
 from .server import DEFAULT_ANON_PERMS, ALL_PERMISSIONS
 from bb.asyncrpc import InvokeError
 import hashlib
 import logging
 from bb import multiprocessing
+import asyncio
 import os
 import sys
 import tempfile
@@ -41,19 +42,15 @@ class HashEquivalenceTestSetup(object):
     server_index = 0
     client_index = 0
 
-    def start_server(self, dbpath=None, upstream=None, read_only=False, prefunc=server_prefunc, anon_perms=DEFAULT_ANON_PERMS, admin_username=None, admin_password=None):
+    def start_server(self, dbpath=None, upstream=None, read_only=False, prefunc=server_prefunc, anon_perms=DEFAULT_ANON_PERMS, admin_username=None, admin_password=None, addr=None):
         self.server_index += 1
+        if addr is None:
+            addr = self.get_server_addr(self.server_index)
+
         if dbpath is None:
             dbpath = self.make_dbpath()
 
-        def cleanup_server(server):
-            if server.process.exitcode is not None:
-                return
-
-            server.process.terminate()
-            server.process.join()
-
-        server = create_server(self.get_server_addr(self.server_index),
+        server = create_server(addr,
                                dbpath,
                                upstream=upstream,
                                read_only=read_only,
@@ -63,7 +60,7 @@ class HashEquivalenceTestSetup(object):
         server.dbpath = dbpath
 
         server.serve_as_process(prefunc=prefunc, args=(self.server_index,))
-        self.addCleanup(cleanup_server, server)
+        self.addCleanup(self.stop_server, server)
 
         return server
 
@@ -83,6 +80,13 @@ class HashEquivalenceTestSetup(object):
         self.server = self.start_server()
         return self.server.address
 
+    def stop_server(self, server):
+        if not server or server.process.exitcode is not None:
+            return
+
+        server.process.terminate()
+        server.process.join()
+
     def start_auth_server(self):
         auth_server = self.start_server(self.server.dbpath, anon_perms=[], admin_username="admin", admin_password="password")
         self.auth_server_address = auth_server.address
@@ -476,6 +480,132 @@ class HashEquivalenceCommonTests(object):
         self.assertEqual(result['taskhash'], taskhash9, 'Server failed to copy unihash from upstream')
         self.assertEqual(result['method'], self.METHOD)
 
+    def test_upstream_batch(self):
+        down_server = self.start_server(upstream=self.server.address)
+        down_client = self.start_client(down_server.address)
+
+        taskhash1 = '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
+        outhash1 = 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e'
+        unihash1 = '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689380'
+        self.client.report_unihash(taskhash1, self.METHOD, outhash1, unihash1)
+
+        taskhash2 = "e3da00593d6a7fb435c7e2114976c59c5fd6d561"
+        outhash2 = "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a"
+        unihash2 = "7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774b64fa9a8a9fe"
+        self.client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
+
+        taskhash3 = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
+        outhash3 = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
+        unihash3 = 'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee33d9'
+        self.client.report_unihash(taskhash3, self.METHOD, outhash3, unihash3)
+
+        def query_generator():
+            yield unihash1
+            yield unihash2
+            yield unihash3
+            yield "cc74784b2c0ad5b378a6b783c74c518d2c46b8b52fba29cb39a8430d742440d7"
+
+        results = down_client.unihash_exists_batch(query_generator())
+        self.assertEqual(results, [True, True, True, False])
+
+    def test_upstream_interrupted(self):
+        up_server = self.start_server()
+        down_server = self.start_server(upstream=up_server.address)
+
+        def restart_upstream():
+            nonlocal up_server
+
+            self.stop_server(up_server)
+            up_server = self.start_server(addr=up_server.address, dbpath=up_server.dbpath)
+
+        # Report some hashes
+        with self.start_client(up_server.address) as up_client:
+            taskhash1 = '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
+            outhash1 = 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e'
+            unihash1 = '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689380'
+            up_client.report_unihash(taskhash1, self.METHOD, outhash1, unihash1)
+
+            taskhash2 = "e3da00593d6a7fb435c7e2114976c59c5fd6d561"
+            outhash2 = "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a"
+            unihash2 = "7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774b64fa9a8a9fe"
+            up_client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
+
+            taskhash3 = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
+            outhash3 = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
+            unihash3 = 'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee33d9'
+            up_client.report_unihash(taskhash3, self.METHOD, outhash3, unihash3)
+
+        restart_upstream()
+
+        with self.start_client(up_server.address) as up_client:
+            # Verify that reported hashes are correct after restaring server
+            self.assertTrue(up_client.unihash_exists(unihash1))
+            self.assertClientGetHash(up_client, taskhash1, unihash1)
+
+            self.assertTrue(up_client.unihash_exists(unihash2))
+            self.assertClientGetHash(up_client, taskhash2, unihash2)
+
+        async def check_unihashes():
+            async with await create_async_client(down_server.address) as down_client:
+                async with down_client.unihash_exists_stream() as stream:
+                    await stream.send_query(unihash1)
+                    r = await stream.get_result()
+                    self.assertTrue(r)
+
+                    restart_upstream()
+
+                    await stream.send_query(unihash2)
+                    r = await stream.get_result()
+                    self.assertTrue(r)
+
+                    await stream.send_query(unihash3)
+                    r = await stream.get_result()
+                    self.assertTrue(r)
+
+        asyncio.run(check_unihashes())
+
+    def test_upstream_lost(self):
+        up_server = self.start_server()
+        down_server = self.start_server(upstream=up_server.address)
+
+        def restart_upstream():
+            nonlocal up_server
+
+            self.stop_server(up_server)
+            up_server = self.start_server(addr=up_server.address, dbpath=up_server.dbpath)
+
+        # Report some hashes
+        with self.start_client(up_server.address) as up_client:
+            taskhash1 = '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
+            outhash1 = 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e'
+            unihash1 = '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689380'
+            up_client.report_unihash(taskhash1, self.METHOD, outhash1, unihash1)
+
+            taskhash2 = "e3da00593d6a7fb435c7e2114976c59c5fd6d561"
+            outhash2 = "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a"
+            unihash2 = "7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774b64fa9a8a9fe"
+            up_client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
+
+            taskhash3 = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
+            outhash3 = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
+            unihash3 = 'a69ec97f5af2e21e1a1f9cc8896965515d5559425666f734e245a3d40cee33d9'
+            up_client.report_unihash(taskhash3, self.METHOD, outhash3, unihash3)
+
+        async def check_unihashes():
+            async with await create_async_client(down_server.address) as down_client:
+                with self.assertRaises(ConnectionError):
+                    async with down_client.unihash_exists_stream() as stream:
+                        await stream.send_query(unihash1)
+                        r = await stream.get_result()
+                        self.assertTrue(r)
+
+                        self.stop_server(up_server)
+
+                        await stream.send_query(unihash2)
+                        r = await stream.get_result()
+
+        asyncio.run(check_unihashes())
+
     def test_unihash_exsits(self):
         taskhash, outhash, unihash = self.create_test_hash(self.client)
         self.assertTrue(self.client.unihash_exists(unihash))
-- 
2.54.0


