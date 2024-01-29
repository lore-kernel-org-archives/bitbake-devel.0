Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EF5C47DB3
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 19:42:31 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web10.76.1706557347287192864
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jan 2024 11:42:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Wi9jPBXI;
 spf=pass (domain: gmail.com, ip: 209.85.166.42, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7bed8faf6ebso112308639f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Jan 2024 11:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706557346; x=1707162146; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoZimQVcI+3V2n77GurVIVMuymAuOQNr48lcxeGuW1U=;
        b=Wi9jPBXIjIZ+GP/jrxzlBX2M806TB+7Z70Y2R3SZm1SikBwbXazCYGg+nxDMQxnzqR
         bjebstpis1jGK03CQvhy8Vxgawh6GkTJ/OSs6NOPrlkHCxM0RVOct6nXwMD/8uXoNPou
         4GfhZlsqAocbvIpYns16FFQncOaaq0+r5vpiH1ezPZIu96SuoSVMKgETFIZJ0qpt0g9l
         UNWquGrt0Il0nEj48gcEjSZCvMGSIQBn4h/BW2OEb7GXIo8a1iejWcwJa5HMcTvaeauV
         1SD44hrCvPK972hZ0YwvTwhRLjjIFXXne/wt6EASeeXZNcQvMA8ni9KQE8OPUJCOvMdE
         7V8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706557346; x=1707162146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoZimQVcI+3V2n77GurVIVMuymAuOQNr48lcxeGuW1U=;
        b=LjNJeDt7nPS9m738a6WDnGmcsizVk/2q/cqVQrbK3ZySkwsar7HODIiCIpjZW2bbpd
         fIECBlFge4/21EqaQNwSYnlXwpaPPEHF06HtSXv2rbqKqIUDfQiSoNpJgExefdxKlIAh
         sCbNxVqGL4NFMBs7le2cLO/HROw9Z2KZYzX6+ckhQPZRupiF6LcKZZbxlC/VozX0snLp
         h8HEAkr33ljq83ugA+jLkPUyU/4UfLZQUgsZ65/bcMRpGqn8HP6KZW6Nb8QJ8bUyU9K+
         Et9tkrAEHp9p7a4320+ym5RNpbuOc3L/mfE9o/uYAlGudIA0t8G1Udx/muyEZkFxy9fU
         k74g==
X-Gm-Message-State: AOJu0Yx5Uv6WU3PFQbRiS7zrP/9K9se6r2QKh/hc2DeuuXUnZbn5F+dD
	hCUiydc6bK6k4r0t4HMROHUnPNR4vIzIavTdWR+qrhPd7v2D5bjJxRa80YvD
X-Google-Smtp-Source: AGHT+IH9RWfFMYANWDLzlLCV/XI8sijukZeeaqKcCxjANcHwbf8k+y5rIRwASPHefa8gQd4McWHdvQ==
X-Received: by 2002:a5d:8919:0:b0:7bf:f410:5e0a with SMTP id b25-20020a5d8919000000b007bff4105e0amr3506274ion.17.1706557345925;
        Mon, 29 Jan 2024 11:42:25 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::529a])
        by smtp.gmail.com with ESMTPSA id b7-20020a6be707000000b007bfebc01ca4sm1082242ioh.8.2024.01.29.11.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:42:25 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 2/2] hashserv: Add Client Pool
Date: Mon, 29 Jan 2024 12:42:08 -0700
Message-Id: <20240129194208.4096506-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129194208.4096506-1-JPEWhacker@gmail.com>
References: <20240129194208.4096506-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Jan 2024 19:42:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15804

Implements a Client Pool derived from the AsyncRPC client pool that
allows querying for multiple equivalent hashes in parallel

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py | 80 ++++++++++++++++++++++++++++++++
 bitbake/lib/hashserv/tests.py  | 83 ++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 35a97687fbe..41784b3fb6a 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -228,3 +228,83 @@ class Client(bb.asyncrpc.Client):
 
     def _get_async_client(self):
         return AsyncClient(self.username, self.password)
+
+
+class ClientPool(bb.asyncrpc.ClientPool):
+    def __init__(
+        self,
+        address,
+        max_clients,
+        *,
+        username=None,
+        password=None,
+        become=None,
+    ):
+        super().__init__(max_clients)
+        self.address = address
+        self.username = username
+        self.password = password
+        self.become = become
+
+    async def _new_client(self):
+        client = await create_async_client(
+            self.address,
+            username=self.username,
+            password=self.password,
+        )
+        if self.become:
+            await client.become_user(self.become)
+        return client
+
+    def _run_key_tasks(self, queries, call):
+        results = {key: None for key in queries.keys()}
+
+        def make_task(key, args):
+            async def task(client):
+                nonlocal results
+                unihash = await call(client, args)
+                results[key] = unihash
+
+            return task
+
+        def gen_tasks():
+            for key, args in queries.items():
+                yield make_task(key, args)
+
+        self.run_tasks(gen_tasks())
+        return results
+
+    def get_unihashes(self, queries):
+        """
+        Query multiple unihashes in parallel.
+
+        The queries argument is a dictionary with arbitrary key. The values
+        must be a tuple of (method, taskhash).
+
+        Returns a dictionary with a corresponding key for each input key, and
+        the value is the queried unihash (which might be none if the query
+        failed)
+        """
+
+        async def call(client, args):
+            method, taskhash = args
+            return await client.get_unihash(method, taskhash)
+
+        return self._run_key_tasks(queries, call)
+
+    def unihashes_exist(self, queries):
+        """
+        Query multiple unihash existence checks in parallel.
+
+        The queries argument is a dictionary with arbitrary key. The values
+        must be a unihash.
+
+        Returns a dictionary with a corresponding key for each input key, and
+        the value is True or False if the unihash is known by the server (or
+        None if there was a failure)
+        """
+
+        async def call(client, unihash):
+            return await client.unihash_exists(unihash)
+
+        return self._run_key_tasks(queries, call)
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index 869f7636c53..d8cf4b421bb 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -8,6 +8,7 @@
 from . import create_server, create_client
 from .server import DEFAULT_ANON_PERMS, ALL_PERMISSIONS
 from bb.asyncrpc import InvokeError
+from .client import ClientPool
 import hashlib
 import logging
 import multiprocessing
@@ -549,6 +550,88 @@ class HashEquivalenceCommonTests(object):
         # shares a taskhash with Task 2
         self.assertClientGetHash(self.client, taskhash2, unihash2)
 
+
+    def test_client_pool_get_unihashes(self):
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
+        with ClientPool(self.server_address, 10) as client_pool:
+            for taskhash, outhash, unihash in TEST_INPUT:
+                self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+
+            query = {idx: (self.METHOD, data[0]) for idx, data in enumerate(TEST_INPUT)}
+            for idx, taskhash in enumerate(EXTRA_QUERIES):
+                query[idx + len(TEST_INPUT)] = (self.METHOD, taskhash)
+
+            result = client_pool.get_unihashes(query)
+
+            self.assertDictEqual(result, {
+                0: "218e57509998197d570e2c98512d0105985dffc9",
+                1: "218e57509998197d570e2c98512d0105985dffc9",
+                2: "218e57509998197d570e2c98512d0105985dffc9",
+                3: "3b5d3d83f07f259e9086fcb422c855286e18a57d",
+                4: "f46d3fbb439bd9b921095da657a4de906510d2cd",
+                5: "f46d3fbb439bd9b921095da657a4de906510d2cd",
+                6: "05d2a63c81e32f0a36542ca677e8ad852365c538",
+                7: None,
+            })
+
+    def test_client_pool_unihash_exists(self):
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
+        with ClientPool(self.server_address, 10) as client_pool:
+            for taskhash, outhash, unihash in TEST_INPUT:
+                result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+                result_unihashes.add(result["unihash"])
+
+            query = {}
+            expected = {}
+
+            for _, _, unihash in TEST_INPUT:
+                idx = len(query)
+                query[idx] = unihash
+                expected[idx] = unihash in result_unihashes
+
+
+            for unihash in EXTRA_QUERIES:
+                idx = len(query)
+                query[idx] = unihash
+                expected[idx] = False
+
+            result = client_pool.unihashes_exist(query)
+            self.assertDictEqual(result, expected)
+
+
     def test_auth_read_perms(self):
         admin_client = self.start_auth_server()
 
-- 
2.34.1


