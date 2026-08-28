Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3404BC61DE4
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:57 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4209.1787932796284044940
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=tFz2rjNp;
 spf=pass (domain: gmail.com, ip: 209.85.210.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f3ff92cf4aso1472470a34.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932795; x=1788537595; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PfBBnipMtCzeMdVMDwm1MJXt0ux8RleKhlKvKgsAJxc=;
        b=tFz2rjNpNaQkn5O31sEuEKhEXTxceJUd+hVj4ymcIwZTiL0PUOhpOSSqPCiMpB58rQ
         73iKk8wdZyEEWHfnFaD2HYgR3aAkzxKQsEf6rELKre9pcMvSM2OjGe7FaHOE5eazXG3W
         JW0GUigrjEpcXzfHsTAfP5XbYGU+f3Te1/9ZLOxvXEudOEjfDbM9S/jg/iPAeGAg592k
         +EY/GcJpcISDdPeb/LGt57iBhr/Qm1kEp+RDP6GHW9BmvjQkJCUKhxNy0NIaVgdvTHhR
         YvPdgInTqIRZtQxWkng+eQnRevj5r2ZScsdz6bz11itMAY15sTR0eTFBkGnBZSi96Yzg
         n1IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932795; x=1788537595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PfBBnipMtCzeMdVMDwm1MJXt0ux8RleKhlKvKgsAJxc=;
        b=e4CYr9BRmFDKhzvIg2TwYmOw8lUKedoWwKdmtihfKycY2zWhVZj3yzyYYTt7KL+U5z
         p+tjXgXNXblL7tdh+HZ2IHTM5ujqPABmRzldB8PrMxq0Qcwe4q2kjpELAqSEXa1rOP10
         +aMMS+KQU3yejML6CAOM5/y9F1Iw5x4a329/nL0KKbME0KlFMh6EChUwBuzZCB9cH+5Q
         qCjUe5hrsq1Hv657kgtr4O2JPfZH6NreRy6wsxeYJ2SCs0fN3h/OWZgNOLTmsYq/2Vv8
         pRgpJ5O28yZG0lK1fi8rg8g08581RmdkYDzfB1mzNtiBV5KlKMvbTnV3LGqQ8ZPbiX3V
         Yn4A==
X-Gm-Message-State: AFuF++nkOLzPK3G9H4dk4BQ5ydAjJhXUjmB2GcsmZZqSEadNuqtRqguN
	X2xaY/woXbh4jpphO4sy7sYIP94UZEZ4vcJ5+mesTp5CjShIwNpxzpGECIOaPw==
X-Gm-Gg: AR+sD13vSuxW6sRh1dW+TZVIFubU0TxKjuifsv8Elxwosp/08ifjj+z0TenwS3gkU5O
	VqOe+11vmI4AoMqlomQN9lgykMIfB094ftIlUvubyjtE4cHPywBPrYA5WZAEfHj95TNm+bzJYNL
	SblmeD0M2KpkerMkAqqczEVDYNKXVZQ9Awa6CpX3nw4lC/dI6GbRcUmr9Z496LDuQbQg3T8D2n5
	HQOvEyhOURoRvzkoNeGAc8M5nA6MFkh/Y6waltdAZ5rl6KkrPgj4YTSjMuy+MwwLI5NEKfJxZfB
	REre6ZOWU9a+E59LIOC/cQhjwOfmqHpzVKg6dxhaJs3kheQ44+viGkIfzQIxIudfRbjsk4M/hNz
	LfnU5tcKpWE8/SJSJTvnSzB85NsvWFhbY1E7tS821jVGBrvxwEZvw2WLTXZy7tX9qcLjur6tU7M
	hCoPZ0LpAsGCWnXyCTrcG63j7q62mYHJkGIkYZ4+GuomayGlyMsqYNxqhe3Il6b4cuJz7OYA==
X-Received: by 2002:a05:6830:618a:b0:7e7:76f:3ec0 with SMTP id 46e09a7af769-7f4f24fb8b2mr10285375a34.15.1787932795438;
        Fri, 28 Aug 2026 08:59:55 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:54 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michal.sieron@nokia.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 11/11] hashserv: server: Fix upstream get-unihash miss truncating stream
Date: Fri, 28 Aug 2026 09:58:18 -0600
Message-ID: <20260828155942.1219468-12-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828155942.1219468-1-JPEWhacker@gmail.com>
References: <20260730183254.793698-1-JPEWhacker@gmail.com>
 <20260828155942.1219468-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 15:59:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20117

From: Michal Sieron <michal.sieron@nokia.com>

When an upstream hash equivalence server is configured,
handle_get_stream() resolves each query through get_upstream_result().
On an upstream miss this returned None, but None is the end-of-stream
sentinel consumed by _stream_queue_handler(). Returning it there
terminated the response stream early, so the downstream client received
fewer replies than it sent, timed out and retried.

Return an empty string ("") on a miss instead, which matches the
non-upstream get-stream handler.

AI-Generated: Uses Cursor
Signed-off-by: Michal Sieron <michal.sieron@nokia.com>
Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 20 ++++++++++++++++++--
 lib/hashserv/tests.py  | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 0153730fa..d9c30bdb8 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -232,7 +232,15 @@ def permissions(*permissions, allow_anon=True, allow_self_service=False):
 class UpstreamQueue(object):
     UPSTREAM_NONCE = object()
 
-    def __init__(self, queue, get_local_result, send_upstream, get_upstream_result):
+    def __init__(
+        self,
+        logger,
+        queue,
+        get_local_result,
+        send_upstream,
+        get_upstream_result,
+    ):
+        self.logger = logger
         self.queue = queue
         self.pending = []
         self.cond = asyncio.Condition()
@@ -256,6 +264,12 @@ class UpstreamQueue(object):
                 if value is self.UPSTREAM_NONCE:
                     value = await self.get_upstream_result(m)
 
+                if value is None:
+                    self.logger.error(
+                        "None is not allowed as a stream value. Terminating stream"
+                    )
+                    return
+
                 await self.queue.put(value)
         finally:
             await self.queue.put(None)
@@ -504,10 +518,11 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 if unihash:
                     method, taskhash = m.split()
                     await self.server.backfill_queue.put((method, taskhash))
-                return unihash
+                return unihash or ""
 
             queue = asyncio.Queue()
             upstream = UpstreamQueue(
+                self.logger,
                 queue,
                 get_local_result,
                 send_upstream,
@@ -543,6 +558,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
             queue = asyncio.Queue()
             upstream = UpstreamQueue(
+                self.logger,
                 queue,
                 get_local_result,
                 stream.send_query,
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 6201ce3bd..15ee7ecde 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -606,6 +606,43 @@ class HashEquivalenceCommonTests(object):
 
         asyncio.run(check_unihashes())
 
+    def test_upstream_get_stream_miss(self):
+        down_server = self.start_server(upstream=self.server.address)
+        down_client = self.start_client(down_server.address)
+
+        # Two hashes present upstream (hits)
+        taskhash1 = '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
+        outhash1 = 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e'
+        unihash1 = '5b521d8a12683086cc08bc2c6d94a7a2dcff17eba53b9911e145d51164689380'
+        self.client.report_unihash(taskhash1, self.METHOD, outhash1, unihash1)
+
+        taskhash2 = 'e3da00593d6a7fb435c7e2114976c59c5fd6d561'
+        outhash2 = '1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a'
+        unihash2 = '7aebef07d66a8c0f92d0c4f65ec8b1fbb850a3693c53827b8774b64fa9a8a9fe'
+        self.client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
+
+        # Two taskhashes present nowhere (upstream misses)
+        miss1 = '0000000000000000000000000000000000000001'
+        miss2 = '0000000000000000000000000000000000000002'
+
+        # Miss interleaved with hits: a miss must not truncate the stream
+        results = down_client.get_unihash_batch([
+            (self.METHOD, miss1),
+            (self.METHOD, taskhash1),
+            (self.METHOD, miss2),
+            (self.METHOD, taskhash2),
+        ])
+        self.assertEqual(results, [None, unihash1, None, unihash2])
+
+        # All-miss batch
+        self.assertEqual(
+            down_client.get_unihash_batch([(self.METHOD, miss1), (self.METHOD, miss2)]),
+            [None, None],
+        )
+
+        # Singular get-unihash miss
+        self.assertClientGetHash(down_client, miss1, None)
+
     def test_unihash_exsits(self):
         taskhash, outhash, unihash = self.create_test_hash(self.client)
         self.assertTrue(self.client.unihash_exists(unihash))
-- 
2.55.0


