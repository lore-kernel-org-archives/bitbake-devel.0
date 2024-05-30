Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661B0C27C43
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 15:41:37 +0000 (UTC)
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
 by mx.groups.io with SMTP id smtpd.web11.12851.1717083696724468519
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 May 2024 08:41:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=W2VZyJ21;
 spf=pass (domain: gmail.com, ip: 209.85.161.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b9776123a3so508125eaf.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717083695; x=1717688495; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRkSUlybHhZzSokGJQV+ZwFY5HQKXm8VcUurYZHK+ZE=;
        b=W2VZyJ21Dkm0/JgI2YgxeM5Pvopb6ZlvLtEshPQ30C6GFXySy/oVUIvWmlZOgmP4DT
         3Y+Z8j82a2GB66Q3DHGSNPgGTsRxDn1MpXgqiFchP5DdY7jxklu1tI42LxNoqwsec2l6
         +EXUbQNz5m0WRTFfGXqoDBitmstjLqUqRhBTVlzIUqUaMPnXFTUkz1lh4t19VHXFXFFy
         FaR+tsIKTLqFs/A33iNj/T+4CkZL4fSlwcSpUDS2LnrDlQyrzaPOXCeWpTDG6/9tJF0d
         Caf/ckEgpTCCvbzTfGz17QkmZL59ansWoxutZRjNB1CQXojXC/DuwceVAmyTfivwbG82
         s04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717083695; x=1717688495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRkSUlybHhZzSokGJQV+ZwFY5HQKXm8VcUurYZHK+ZE=;
        b=m+LL2JcIw2v1uHRQqkQopnUuzK2PWdImRoAx73iYTXDMK+HqOoS5Re8zVSMVbAptyB
         RzDOdeAW9ipmsz/HOAqbfsNvv+Ge0uJCmDIN36Z3tgr8IA+yOkvQgN/Bz6HNT5sveYTg
         DtBkTCgwX++3tdpyzifZaNPDSnbnXaIH/OxL71CpytO4SqBBRMeeZn88q58RiRI7Yr/E
         urP0P+HCT453zPdU3kWHnfagQ1IcesJEbvAC6VHgpii2a6avOHuMvDKRhzmxXryn20g6
         wyuW/0d/9AVmIr7A9F8wBQjRbGYGYIkmVzcb+EP6ZphjZeEnpp0M93BiSOwHhz6F1Ot9
         TDmw==
X-Gm-Message-State: AOJu0YwolfxEZnZqTMD5U5W9m5ZnwbQtZoYwbToOsWYt6LBCw0mTMwRP
	52qrvadvco5TgJofc1IezISMvR/j6VH03dBbJGL+SAA4CiNjAIIiaY1srw==
X-Google-Smtp-Source: AGHT+IH2iJZO7Z1wlzLq+Zmj9qbIMeZHG6exEDtua1JdCT9VaGRqIRPNlVUKSzmtt5Nxj3fxTzxuQw==
X-Received: by 2002:a05:6820:1b8c:b0:5b9:8a06:c47 with SMTP id 006d021491bc7-5b9ec83b401mr2817982eaf.8.1717083694793;
        Thu, 30 May 2024 08:41:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::125b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b96c6d60f1sm3184813eaf.45.2024.05.30.08.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:41:34 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 2/3] asyncrpc: Remove ClientPool
Date: Thu, 30 May 2024 09:41:26 -0600
Message-ID: <20240530154127.792582-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240530154127.792582-1-JPEWhacker@gmail.com>
References: <20240530154127.792582-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 15:41:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16290

Batching support on the client side has proven to be a much more
effective way of dealing with server latency than multiple client
connections and is also much nicer on the server, so drop the client
pool support from asyncrpc and the hash server

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/asyncrpc/__init__.py |  2 +-
 bitbake/lib/bb/asyncrpc/client.py   | 76 +-------------------------
 bitbake/lib/hashserv/client.py      | 80 ----------------------------
 bitbake/lib/hashserv/tests.py       | 82 -----------------------------
 4 files changed, 2 insertions(+), 238 deletions(-)

diff --git a/bitbake/lib/bb/asyncrpc/__init__.py b/bitbake/lib/bb/asyncrpc/__init__.py
index 639e1607f8e..a4371643d74 100644
--- a/bitbake/lib/bb/asyncrpc/__init__.py
+++ b/bitbake/lib/bb/asyncrpc/__init__.py
@@ -5,7 +5,7 @@
 #
 
 
-from .client import AsyncClient, Client, ClientPool
+from .client import AsyncClient, Client
 from .serv import AsyncServer, AsyncServerConnection
 from .connection import DEFAULT_MAX_CHUNK
 from .exceptions import (
diff --git a/bitbake/lib/bb/asyncrpc/client.py b/bitbake/lib/bb/asyncrpc/client.py
index b49de993131..746bbefdd87 100644
--- a/bitbake/lib/bb/asyncrpc/client.py
+++ b/bitbake/lib/bb/asyncrpc/client.py
@@ -29,6 +29,7 @@ WEBSOCKETS_MIN_VERSION = (9, 1)
 if sys.version_info >= (3, 10, 0):
     WEBSOCKETS_MIN_VERSION = (10, 0)
 
+
 def parse_address(addr):
     if addr.startswith(UNIX_PREFIX):
         return (ADDR_TYPE_UNIX, (addr[len(UNIX_PREFIX) :],))
@@ -260,78 +261,3 @@ class Client(object):
     def __exit__(self, exc_type, exc_value, traceback):
         self.close()
         return False
-
-
-class ClientPool(object):
-    def __init__(self, max_clients):
-        self.avail_clients = []
-        self.num_clients = 0
-        self.max_clients = max_clients
-        self.loop = None
-        self.client_condition = None
-
-    @abc.abstractmethod
-    async def _new_client(self):
-        raise NotImplementedError("Must be implemented in derived class")
-
-    def close(self):
-        if self.client_condition:
-            self.client_condition = None
-
-        if self.loop:
-            self.loop.run_until_complete(self.__close_clients())
-            self.loop.run_until_complete(self.loop.shutdown_asyncgens())
-            self.loop.close()
-            self.loop = None
-
-    def run_tasks(self, tasks):
-        if not self.loop:
-            self.loop = asyncio.new_event_loop()
-
-        thread = Thread(target=self.__thread_main, args=(tasks,))
-        thread.start()
-        thread.join()
-
-    @contextlib.asynccontextmanager
-    async def get_client(self):
-        async with self.client_condition:
-            if self.avail_clients:
-                client = self.avail_clients.pop()
-            elif self.num_clients < self.max_clients:
-                self.num_clients += 1
-                client = await self._new_client()
-            else:
-                while not self.avail_clients:
-                    await self.client_condition.wait()
-                client = self.avail_clients.pop()
-
-        try:
-            yield client
-        finally:
-            async with self.client_condition:
-                self.avail_clients.append(client)
-                self.client_condition.notify()
-
-    def __thread_main(self, tasks):
-        async def process_task(task):
-            async with self.get_client() as client:
-                await task(client)
-
-        asyncio.set_event_loop(self.loop)
-        if not self.client_condition:
-            self.client_condition = asyncio.Condition()
-        tasks = [process_task(t) for t in tasks]
-        self.loop.run_until_complete(asyncio.gather(*tasks))
-
-    async def __close_clients(self):
-        for c in self.avail_clients:
-            await c.close()
-        self.avail_clients = []
-        self.num_clients = 0
-
-    def __enter__(self):
-        return self
-
-    def __exit__(self, exc_type, exc_value, traceback):
-        self.close()
-        return False
diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 775faf935a8..d415617b206 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -352,83 +352,3 @@ class Client(bb.asyncrpc.Client):
 
     def _get_async_client(self):
         return AsyncClient(self.username, self.password)
-
-
-class ClientPool(bb.asyncrpc.ClientPool):
-    def __init__(
-        self,
-        address,
-        max_clients,
-        *,
-        username=None,
-        password=None,
-        become=None,
-    ):
-        super().__init__(max_clients)
-        self.address = address
-        self.username = username
-        self.password = password
-        self.become = become
-
-    async def _new_client(self):
-        client = await create_async_client(
-            self.address,
-            username=self.username,
-            password=self.password,
-        )
-        if self.become:
-            await client.become_user(self.become)
-        return client
-
-    def _run_key_tasks(self, queries, call):
-        results = {key: None for key in queries.keys()}
-
-        def make_task(key, args):
-            async def task(client):
-                nonlocal results
-                unihash = await call(client, args)
-                results[key] = unihash
-
-            return task
-
-        def gen_tasks():
-            for key, args in queries.items():
-                yield make_task(key, args)
-
-        self.run_tasks(gen_tasks())
-        return results
-
-    def get_unihashes(self, queries):
-        """
-        Query multiple unihashes in parallel.
-
-        The queries argument is a dictionary with arbitrary key. The values
-        must be a tuple of (method, taskhash).
-
-        Returns a dictionary with a corresponding key for each input key, and
-        the value is the queried unihash (which might be none if the query
-        failed)
-        """
-
-        async def call(client, args):
-            method, taskhash = args
-            return await client.get_unihash(method, taskhash)
-
-        return self._run_key_tasks(queries, call)
-
-    def unihashes_exist(self, queries):
-        """
-        Query multiple unihash existence checks in parallel.
-
-        The queries argument is a dictionary with arbitrary key. The values
-        must be a unihash.
-
-        Returns a dictionary with a corresponding key for each input key, and
-        the value is True or False if the unihash is known by the server (or
-        None if there was a failure)
-        """
-
-        async def call(client, unihash):
-            return await client.unihash_exists(unihash)
-
-        return self._run_key_tasks(queries, call)
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index 5349cd58677..43c3c36f045 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -8,7 +8,6 @@
 from . import create_server, create_client
 from .server import DEFAULT_ANON_PERMS, ALL_PERMISSIONS
 from bb.asyncrpc import InvokeError
-from .client import ClientPool
 import hashlib
 import logging
 import multiprocessing
@@ -555,45 +554,6 @@ class HashEquivalenceCommonTests(object):
         # shares a taskhash with Task 2
         self.assertClientGetHash(self.client, taskhash2, unihash2)
 
-
-    def test_client_pool_get_unihashes(self):
-        TEST_INPUT = (
-            # taskhash                                   outhash                                                            unihash
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e','218e57509998197d570e2c98512d0105985dffc9'),
-            # Duplicated taskhash with multiple output hashes and unihashes.
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'),
-            # Equivalent hash
-            ("044c2ec8aaf480685a00ff6ff49e6162e6ad34e1", '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', "def64766090d28f627e816454ed46894bb3aab36"),
-            ("e3da00593d6a7fb435c7e2114976c59c5fd6d561", "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a", "3b5d3d83f07f259e9086fcb422c855286e18a57d"),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30faf9', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2cd'),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30fafa', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2ce'),
-            ('9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74', '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69', '05d2a63c81e32f0a36542ca677e8ad852365c538'),
-        )
-        EXTRA_QUERIES = (
-            "6b6be7a84ab179b4240c4302518dc3f6",
-        )
-
-        with ClientPool(self.server_address, 10) as client_pool:
-            for taskhash, outhash, unihash in TEST_INPUT:
-                self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
-
-            query = {idx: (self.METHOD, data[0]) for idx, data in enumerate(TEST_INPUT)}
-            for idx, taskhash in enumerate(EXTRA_QUERIES):
-                query[idx + len(TEST_INPUT)] = (self.METHOD, taskhash)
-
-            result = client_pool.get_unihashes(query)
-
-            self.assertDictEqual(result, {
-                0: "218e57509998197d570e2c98512d0105985dffc9",
-                1: "218e57509998197d570e2c98512d0105985dffc9",
-                2: "218e57509998197d570e2c98512d0105985dffc9",
-                3: "3b5d3d83f07f259e9086fcb422c855286e18a57d",
-                4: "f46d3fbb439bd9b921095da657a4de906510d2cd",
-                5: "f46d3fbb439bd9b921095da657a4de906510d2cd",
-                6: "05d2a63c81e32f0a36542ca677e8ad852365c538",
-                7: None,
-            })
-
     def test_get_unihash_batch(self):
         TEST_INPUT = (
             # taskhash                                   outhash                                                            unihash
@@ -631,48 +591,6 @@ class HashEquivalenceCommonTests(object):
             None,
         ])
 
-    def test_client_pool_unihash_exists(self):
-        TEST_INPUT = (
-            # taskhash                                   outhash                                                            unihash
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e','218e57509998197d570e2c98512d0105985dffc9'),
-            # Duplicated taskhash with multiple output hashes and unihashes.
-            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'),
-            # Equivalent hash
-            ("044c2ec8aaf480685a00ff6ff49e6162e6ad34e1", '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', "def64766090d28f627e816454ed46894bb3aab36"),
-            ("e3da00593d6a7fb435c7e2114976c59c5fd6d561", "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a", "3b5d3d83f07f259e9086fcb422c855286e18a57d"),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30faf9', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2cd'),
-            ('35788efcb8dfb0a02659d81cf2bfd695fb30fafa', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2ce'),
-            ('9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74', '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69', '05d2a63c81e32f0a36542ca677e8ad852365c538'),
-        )
-        EXTRA_QUERIES = (
-            "6b6be7a84ab179b4240c4302518dc3f6",
-        )
-
-        result_unihashes = set()
-
-
-        with ClientPool(self.server_address, 10) as client_pool:
-            for taskhash, outhash, unihash in TEST_INPUT:
-                result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
-                result_unihashes.add(result["unihash"])
-
-            query = {}
-            expected = {}
-
-            for _, _, unihash in TEST_INPUT:
-                idx = len(query)
-                query[idx] = unihash
-                expected[idx] = unihash in result_unihashes
-
-
-            for unihash in EXTRA_QUERIES:
-                idx = len(query)
-                query[idx] = unihash
-                expected[idx] = False
-
-            result = client_pool.unihashes_exist(query)
-            self.assertDictEqual(result, expected)
-
     def test_unihash_exists_batch(self):
         TEST_INPUT = (
             # taskhash                                   outhash                                                            unihash
-- 
2.43.2


