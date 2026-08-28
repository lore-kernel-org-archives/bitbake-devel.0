Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D26C61DD3
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:55 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4206.1787932793978993685
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nC9Y/khI;
 spf=pass (domain: gmail.com, ip: 209.85.210.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7f4dedd67b8so1391226a34.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932793; x=1788537593; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=trJxSlvOYmX9uexDym3Vg3/mLaOnCCusDYcJNFLRf1A=;
        b=nC9Y/khIo7K6DkJRhLEhYv1xdUhgXgaSkp+bZjbcnnK8Wz7Y8Aq/6bNG61MQtzeaIN
         FQOr+5m8wp4/1vfikrklCyj2ylKyPe2vsn91KPWG8+/biSGhMnf9/qRuDC+1vFSunSLd
         6ctyKKzzcubZWYUzLsE+fh/oXmB2ma+OaF1SZXZkdWBcjV1TUr0vUCUN8cPEuLdmr2hm
         P/10TDTkc22bONvut3I7QD9QSUBUbAj6QNVVJ6GpY7xOHQGNPL0hgZxw+wTMUN3srcf5
         0B/mQsPfjQYcQV7X8vOqttI/NX9kusN/hmJ1z4unQp9pn6+lS/PbdbYXjuIxmBDA0qns
         vH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932793; x=1788537593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=trJxSlvOYmX9uexDym3Vg3/mLaOnCCusDYcJNFLRf1A=;
        b=oHT4Mp6P1EyW8hOmzwO+FIp6LRKD3Zo7rS88XuIvNhiELPR7MQzZTnS8CH1Z6hnYlC
         JIpXcKS16YElIF+rU0dxfFIvDt+2YwF6O2XZu4Hgjd7O1UAS3lriq6Mo8s8uRbId0Jf3
         Ol6v+pPF2snfE/eVYD3/oduAuCbFKxQ9KzFS0Bc1InF85MBHdFiSFVHx+DF4CDxuzhbR
         Qk0z8Cvamb4QZuMVM/S59Wxquv1olSLP5HIS9VR3JJaksMSUKd7HYpCbrSlh+IEbX42x
         jQ172xGAj4u69dO9KrjErAOKPIKEhcCpj3mGMc7zkkkQonaIwovtKhlEpSbBUIr4l00j
         uLmQ==
X-Gm-Message-State: AFuF++lWk+LtEPqh5L4PYkfxPc4wUlkkAGN/VUC8tqkQ6/HBS1zJpJYs
	aoyYYHYnZse2Qgzw/sLsHh0eygPIa+fRuqmiT8dWFrTFhtANgMaVovQ6yZCKYw==
X-Gm-Gg: AR+sD11SXtMv4a+F1OlFS9Lxi52SMxioiRPygrWUKzyPZzTT3xuWS2EO+qLenjnJMpo
	UI2kRdG7rheO1fQUfRN1/4qD5cafW6B3zlaZ62HRkSvcjBWj2esnf6pND4wW0/Mu/V4fITZlaZF
	KS0aF5zM718afZybI6ay/5mAlD3JiQ+jsX82sgWttIDrTZG+IydVTSz0iJ8XGzh1Z+X9/v6jLPI
	UETMgYr2a47WDeCg0B/zAHFOT8PnzM5Qhf/ckmL4B6Zo6iu++r9RprpL4iAVrIVJwTNvmq8nzt7
	zGk/KW7X/MGjTlnLsdv8GgXf3mf3AeOebQGBl+1JieS9h3c6ZM/3moxOvnuwSQxAIPzBz2Z5SG6
	GiU0O4IcD47BT8SH/5bGuuNNN26VDcm03O0c5efujNrPRlGkOxKkM45s6hMK2h/6TaPYdy/1IBK
	0mfwWsq9UPuqtZEY989xQSjnR6AQaoaqfl3mOyhTKGBow2iUFlxttW5Lbl5Q==
X-Received: by 2002:a05:6830:618a:b0:7e6:f4a3:1df5 with SMTP id 46e09a7af769-7f4f23b7ac2mr10332399a34.1.1787932793087;
        Fri, 28 Aug 2026 08:59:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:52 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 09/11] hashserv: tests: Add more upstream tests
Date: Fri, 28 Aug 2026 09:58:16 -0600
Message-ID: <20260828155942.1219468-10-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20115

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
2.55.0


