Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D06C46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 08:10:25 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
 by mx.groups.io with SMTP id smtpd.web11.13563.1706602218868096994
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jan 2024 00:10:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=B0ZEQv+Y;
 spf=pass (domain: bootlin.com, ip: 217.70.183.197, mailfrom: alexandre.belloni@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 436BF1C0003;
	Tue, 30 Jan 2024 08:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706602216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4hNZMDYEasHkKCpyxshITX+3blN+op90NWjCjHfGmwg=;
	b=B0ZEQv+YmwFtjSMkEyxfavQC5NwB06QoKpt1dIB9+9TeohswpEK22kpe/EbquuS4oxV8UT
	t9vMkw/Oyx5UYhfFIBqm0M9vaR1n5SjT/XRcYJNO+LUy0Sc7GyyU8rkRcdVhYFUi9lG+Ni
	k0uJDLnyjzrz4mkW+NXOCSeynFIk7/TlxESP4CdUeYBI+ASb4xU8eauA/RjLosmpKQ6ghS
	PbG2UYx4BQAvTWRG00FrNr2BlRxrhoEmPcq2i+nAHo+/l27s2I9wTckQ83gPCgyTy+oCpm
	tdNj5RiwlC8qgKB5Guh/4Safq/fIrX9L38yAmlT5fa8DOxkxT2NkmeT2PDycjg==
Date: Tue, 30 Jan 2024 09:10:16 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joshua Watt <JPEWhacker@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel][PATCH 2/2] hashserv: Add Client Pool
Message-ID: <2024013008101674311323@mail.local>
References: <20240129194208.4096506-1-JPEWhacker@gmail.com>
 <20240129194208.4096506-2-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129194208.4096506-2-JPEWhacker@gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 08:10:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15805

bitbake-selftest failed:

https://autobuilder.yoctoproject.org/typhoon/#/builders/80/builds/6308/steps/11/logs/stdio


On 29/01/2024 12:42:08-0700, Joshua Watt wrote:
> Implements a Client Pool derived from the AsyncRPC client pool that
> allows querying for multiple equivalent hashes in parallel
> 
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> ---
>  bitbake/lib/hashserv/client.py | 80 ++++++++++++++++++++++++++++++++
>  bitbake/lib/hashserv/tests.py  | 83 ++++++++++++++++++++++++++++++++++
>  2 files changed, 163 insertions(+)
> 
> diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
> index 35a97687fbe..41784b3fb6a 100644
> --- a/bitbake/lib/hashserv/client.py
> +++ b/bitbake/lib/hashserv/client.py
> @@ -228,3 +228,83 @@ class Client(bb.asyncrpc.Client):
>  
>      def _get_async_client(self):
>          return AsyncClient(self.username, self.password)
> +
> +
> +class ClientPool(bb.asyncrpc.ClientPool):
> +    def __init__(
> +        self,
> +        address,
> +        max_clients,
> +        *,
> +        username=None,
> +        password=None,
> +        become=None,
> +    ):
> +        super().__init__(max_clients)
> +        self.address = address
> +        self.username = username
> +        self.password = password
> +        self.become = become
> +
> +    async def _new_client(self):
> +        client = await create_async_client(
> +            self.address,
> +            username=self.username,
> +            password=self.password,
> +        )
> +        if self.become:
> +            await client.become_user(self.become)
> +        return client
> +
> +    def _run_key_tasks(self, queries, call):
> +        results = {key: None for key in queries.keys()}
> +
> +        def make_task(key, args):
> +            async def task(client):
> +                nonlocal results
> +                unihash = await call(client, args)
> +                results[key] = unihash
> +
> +            return task
> +
> +        def gen_tasks():
> +            for key, args in queries.items():
> +                yield make_task(key, args)
> +
> +        self.run_tasks(gen_tasks())
> +        return results
> +
> +    def get_unihashes(self, queries):
> +        """
> +        Query multiple unihashes in parallel.
> +
> +        The queries argument is a dictionary with arbitrary key. The values
> +        must be a tuple of (method, taskhash).
> +
> +        Returns a dictionary with a corresponding key for each input key, and
> +        the value is the queried unihash (which might be none if the query
> +        failed)
> +        """
> +
> +        async def call(client, args):
> +            method, taskhash = args
> +            return await client.get_unihash(method, taskhash)
> +
> +        return self._run_key_tasks(queries, call)
> +
> +    def unihashes_exist(self, queries):
> +        """
> +        Query multiple unihash existence checks in parallel.
> +
> +        The queries argument is a dictionary with arbitrary key. The values
> +        must be a unihash.
> +
> +        Returns a dictionary with a corresponding key for each input key, and
> +        the value is True or False if the unihash is known by the server (or
> +        None if there was a failure)
> +        """
> +
> +        async def call(client, unihash):
> +            return await client.unihash_exists(unihash)
> +
> +        return self._run_key_tasks(queries, call)
> diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
> index 869f7636c53..d8cf4b421bb 100644
> --- a/bitbake/lib/hashserv/tests.py
> +++ b/bitbake/lib/hashserv/tests.py
> @@ -8,6 +8,7 @@
>  from . import create_server, create_client
>  from .server import DEFAULT_ANON_PERMS, ALL_PERMISSIONS
>  from bb.asyncrpc import InvokeError
> +from .client import ClientPool
>  import hashlib
>  import logging
>  import multiprocessing
> @@ -549,6 +550,88 @@ class HashEquivalenceCommonTests(object):
>          # shares a taskhash with Task 2
>          self.assertClientGetHash(self.client, taskhash2, unihash2)
>  
> +
> +    def test_client_pool_get_unihashes(self):
> +        TEST_INPUT = (
> +            # taskhash                                   outhash                                                            unihash
> +            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e','218e57509998197d570e2c98512d0105985dffc9'),
> +            # Duplicated taskhash with multiple output hashes and unihashes.
> +            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'),
> +            # Equivalent hash
> +            ("044c2ec8aaf480685a00ff6ff49e6162e6ad34e1", '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', "def64766090d28f627e816454ed46894bb3aab36"),
> +            ("e3da00593d6a7fb435c7e2114976c59c5fd6d561", "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a", "3b5d3d83f07f259e9086fcb422c855286e18a57d"),
> +            ('35788efcb8dfb0a02659d81cf2bfd695fb30faf9', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2cd'),
> +            ('35788efcb8dfb0a02659d81cf2bfd695fb30fafa', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2ce'),
> +            ('9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74', '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69', '05d2a63c81e32f0a36542ca677e8ad852365c538'),
> +        )
> +        EXTRA_QUERIES = (
> +            "6b6be7a84ab179b4240c4302518dc3f6",
> +        )
> +
> +        with ClientPool(self.server_address, 10) as client_pool:
> +            for taskhash, outhash, unihash in TEST_INPUT:
> +                self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
> +
> +            query = {idx: (self.METHOD, data[0]) for idx, data in enumerate(TEST_INPUT)}
> +            for idx, taskhash in enumerate(EXTRA_QUERIES):
> +                query[idx + len(TEST_INPUT)] = (self.METHOD, taskhash)
> +
> +            result = client_pool.get_unihashes(query)
> +
> +            self.assertDictEqual(result, {
> +                0: "218e57509998197d570e2c98512d0105985dffc9",
> +                1: "218e57509998197d570e2c98512d0105985dffc9",
> +                2: "218e57509998197d570e2c98512d0105985dffc9",
> +                3: "3b5d3d83f07f259e9086fcb422c855286e18a57d",
> +                4: "f46d3fbb439bd9b921095da657a4de906510d2cd",
> +                5: "f46d3fbb439bd9b921095da657a4de906510d2cd",
> +                6: "05d2a63c81e32f0a36542ca677e8ad852365c538",
> +                7: None,
> +            })
> +
> +    def test_client_pool_unihash_exists(self):
> +        TEST_INPUT = (
> +            # taskhash                                   outhash                                                            unihash
> +            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e','218e57509998197d570e2c98512d0105985dffc9'),
> +            # Duplicated taskhash with multiple output hashes and unihashes.
> +            ('8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a', '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'),
> +            # Equivalent hash
> +            ("044c2ec8aaf480685a00ff6ff49e6162e6ad34e1", '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d', "def64766090d28f627e816454ed46894bb3aab36"),
> +            ("e3da00593d6a7fb435c7e2114976c59c5fd6d561", "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a", "3b5d3d83f07f259e9086fcb422c855286e18a57d"),
> +            ('35788efcb8dfb0a02659d81cf2bfd695fb30faf9', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2cd'),
> +            ('35788efcb8dfb0a02659d81cf2bfd695fb30fafa', '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f', 'f46d3fbb439bd9b921095da657a4de906510d2ce'),
> +            ('9d81d76242cc7cfaf7bf74b94b9cd2e29324ed74', '8470d56547eea6236d7c81a644ce74670ca0bbda998e13c629ef6bb3f0d60b69', '05d2a63c81e32f0a36542ca677e8ad852365c538'),
> +        )
> +        EXTRA_QUERIES = (
> +            "6b6be7a84ab179b4240c4302518dc3f6",
> +        )
> +
> +        result_unihashes = set()
> +
> +
> +        with ClientPool(self.server_address, 10) as client_pool:
> +            for taskhash, outhash, unihash in TEST_INPUT:
> +                result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
> +                result_unihashes.add(result["unihash"])
> +
> +            query = {}
> +            expected = {}
> +
> +            for _, _, unihash in TEST_INPUT:
> +                idx = len(query)
> +                query[idx] = unihash
> +                expected[idx] = unihash in result_unihashes
> +
> +
> +            for unihash in EXTRA_QUERIES:
> +                idx = len(query)
> +                query[idx] = unihash
> +                expected[idx] = False
> +
> +            result = client_pool.unihashes_exist(query)
> +            self.assertDictEqual(result, expected)
> +
> +
>      def test_auth_read_perms(self):
>          admin_client = self.start_auth_server()
>  
> -- 
> 2.34.1
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15804): https://lists.openembedded.org/g/bitbake-devel/message/15804
> Mute This Topic: https://lists.openembedded.org/mt/104039098/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

