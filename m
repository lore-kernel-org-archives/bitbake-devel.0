Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE5CC48BF8
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 20:08:04 +0000 (UTC)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
 by mx.groups.io with SMTP id smtpd.web11.25651.1708286881319476516
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 12:08:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hKA6zUtx;
 spf=pass (domain: gmail.com, ip: 209.85.166.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7c3e01a7fe0so172941339f.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 12:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286879; x=1708891679; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjgoUuru/5mh1737D5tbdwzUctpUmZzvxjF8D9ZkMhc=;
        b=hKA6zUtxlfnujWP4AfNg4pthmrt/pwM/VRXYOwJ3SW9m/IPOZcwzXhKRplJWZDRvGc
         m7FkwnijWw61j3fjGPRvbDjkebay9DTwM2djfAvzEXaYiblNzmXP9Jina8hdMiP89qYW
         RK/QTIdMvfQkgeRjS8eRskp/630eFEppMf7ROS5jHVSI1u/BgC9NkSfiXP0PkM1nsVmB
         pfXUQDE8wJXmdtvV3HVp46YW4/I2Z4w10+CfJCrFOWw2F6JEmwARL373E1DHNOsnQhFS
         D2HLHKqMxi7oUVjbfQ0GJmJE0yCAk30musYh5uNFeIwc1/92QuHnn3HhgjbxQmEGbItY
         /dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286879; x=1708891679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjgoUuru/5mh1737D5tbdwzUctpUmZzvxjF8D9ZkMhc=;
        b=DOdLD0OrW8Aml9A9IHoRBo6AzK9VMJC6iS8vhkTKGJb6sFYpYyQa3H1Hn4/nXV0G1Q
         SYzKDpjaLrBrdwiOmtyPpL1Nj9Pk0CDgoX5MERpYbZnmIPpS7hLJgojCm4023sL/qRsO
         BJqVyHkyId8oDIqYpQe9v58SahSyRbfdEsJbpty8a6AdleHPxLQmfZ4ICSDLfjMePHST
         a845SABS/c0C7CQpmI94auPZPaodqfPjcUPk2/45Q56ftSNX39lK0krb9pE3Y6kXFX95
         1qev3iOqRqMp2tznjSJViWpaD5EsPNtOeBXOvJV3EkmvOgzpyr4ip4ZgQ5Eh/A3BDLvJ
         gcbA==
X-Gm-Message-State: AOJu0YwabN97EU1T/8zhhzkHd3ijE9tUZv53iMyctJEYnOM5IWDrIumK
	NoZWLWOoOwlTMg748hf1yQfpbCR4xHzFwNhrZ3mL4dUV4Mw7hsOIQCM3cH5x
X-Google-Smtp-Source: AGHT+IHSM2UTNW4IoL3x7OlgKT+1M8VWRSFWUioXAxR750MGbOKOGV/pbTWxGRowyxAf19te/TD7Pw==
X-Received: by 2002:a05:6602:809:b0:7c7:28dd:2b4e with SMTP id z9-20020a056602080900b007c728dd2b4emr7369969iow.13.1708286878883;
        Sun, 18 Feb 2024 12:07:58 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id u6-20020a02aa86000000b004741e1544b6sm549278jai.81.2024.02.18.12.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 12:07:58 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 4/5] hashserv: Add Client Pool
Date: Sun, 18 Feb 2024 13:07:42 -0700
Message-Id: <20240218200743.2982923-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218200743.2982923-1-JPEWhacker@gmail.com>
References: <20240218200743.2982923-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 20:08:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15920

Implements a Client Pool derived from the AsyncRPC client pool that
allows querying for multiple equivalent hashes in parallel

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py | 80 ++++++++++++++++++++++++++++++++
 bitbake/lib/hashserv/tests.py  | 83 ++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index daf1e128423..b269879ecfd 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -283,3 +283,83 @@ class Client(bb.asyncrpc.Client):
 
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
index fbbe81512a0..0809453cf87 100644
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
@@ -554,6 +555,88 @@ class HashEquivalenceCommonTests(object):
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


