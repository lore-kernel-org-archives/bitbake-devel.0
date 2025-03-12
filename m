Return-Path: <c137.marques@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFB8C28B28
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 11:22:18 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web11.34767.1741778529974141180
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Mar 2025 04:22:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CtGj952h;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: c137.marques@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39133f709f5so2668782f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 12 Mar 2025 04:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741778528; x=1742383328; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=reCMR2i7wVJZUYD2gyC04maPR4AL+9TZ7qn9AIyijIQ=;
        b=CtGj952h2qqwLiCAUlV7bP/hDftdQ5bowfLzx0JPNGvGDyfP5keNkJJSpgauHWmIas
         kqg8fqJnxa2fTt4P/r3t0ouor4xZ4J1qF2NGKrvXmktQBiWP1G9cvY41vkZCQ1buD12X
         ZscWNvHQOjMKHKQIMcqJG5IVwIQzWPqJwEr4zjyYy+QJRSNqwm1tQsjnt7Oh7k4rP3iy
         ScyivFgOqQqHXbOrzksQ5xE3B2kJteDx9H3NFvbSadR7sxwVSFqzdoo70WyMwNhm0s0+
         93tkPJ45fgqcX58l5JoFHehrEAaRXfzdCoPJgvJqNgO0KpNtZDWmfMgW7WzhMoTixBQ1
         zINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778528; x=1742383328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reCMR2i7wVJZUYD2gyC04maPR4AL+9TZ7qn9AIyijIQ=;
        b=PuEjTY00xlD01ylbi5+OWyn75XRTkBhXr7oeL9DAopU6XpBRdyzOXCQjdTTivlDoKc
         UetQlK9lN7Lkah1n9HMEDDwtSnFnfAcj3IjufSe9YTUV9exo3oU7/qgdAjKLRt6L+jP1
         urH+yFk6/i6UnzkQH6NBAbZSVRzRqa3SPnld73wyMoysvTwxfD3Dvp0AxB1t83gtTL3e
         tFb+RWy7PFAXnPmEDO1ghdSxh/1R9nZ1K1+w1Li0AG6r7jscF28ccSjR5NzGfuWD0qG6
         +HTCIZU14TIe1C+mPEf9ckHBx/lsIo0wFkLKGNxIENqMvcilLukQtQucpMSzlB3gAgbC
         SM2g==
X-Gm-Message-State: AOJu0YxeqjBtLbcJr5U2EjN7EAfeD5v9sBuz7Tc7EwvxXHCawZnpZ8gc
	lrdlkGhHRnDMm10yToR0tr1WPl5/0X4LIMycW2Uzs6vuJdz0rXoY2saoAQ==
X-Gm-Gg: ASbGncvNYWaDIIwK9IxXKCURjzbwtXSmn6SEzZrsbcC9YDyc3YDWsgVt8QBJCfeHlpy
	dE/UiSIrq9fq/J0hGTNeAolrDYf1Q6EflozwUH0nNlW5YKuQj/CsG7PPYr928ukJypixZwzkCve
	o3lhYjRUc+uTlnB05qnpuMyJahxR4K9DKv8ydN1/UY5Qyo1fq6s6y4xTq2hfA+D7CIpVMmLqmLc
	Q+CWrzfUMQat+Hf9s6jiU+/OirjXMjY8aOw45sXDi06mH7vVEKKZX2gvS/kwVmqxrVeFu07gg/p
	VDTTD2843RkkNTeQ7Oa8YhmZLVfmv3QXZtHtgGhJvKSYh8KaZA==
X-Google-Smtp-Source: AGHT+IGneQNZeMSY8nWXF0kRlXBPZG8L6pAsv1DMg7RHIwJbuDYhLgu0Xj/ccrjpLjuEK79z/845jw==
X-Received: by 2002:a05:6000:1867:b0:390:fbcf:56be with SMTP id ffacd0b85a97d-39132b63fb8mr17155350f8f.0.1741778527727;
        Wed, 12 Mar 2025 04:22:07 -0700 (PDT)
Received: from pc.. ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba66esm21067651f8f.18.2025.03.12.04.22.06
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 04:22:07 -0700 (PDT)
From: Alexander Marques <c137.marques@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v4 1/1] hashserv: Add `gc-mark-stream` command for batch hash marking
Date: Wed, 12 Mar 2025 11:22:04 +0000
Message-Id: <20250312112204.778528-1-c137.marques@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Mar 2025 11:22:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17434

From: Alexandre Marques <c137.marques@gmail.com>

Implements the `gc-mark-stream` command to allow for marking equivalence entries
in batch, by  making use of stream mode communication to the server.

The aim of this is to improve efficiency by reducing the impact of latency when
marking a high volume of hash entries.

Example usage of the new `gc-mark-stream` command:

```
$ cat << HASHES | \
./bin/bitbake-hashclient --address "ws://localhost:8688/ws" gc-mark-stream "alive"
unihash f37918cc02eb5a520b1aff86faacbc0a38124646
unihash af36b199320e611fbb16f1f277d3ee1d619ca58b
taskhash a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c0 method oe.sstatesig.OEOuthashBasic
HASHES
```

Signed-off-by: Alexander Marques <c137.marques@gmail.com>
---
 bin/bitbake-hashclient | 31 +++++++++++++++++++++++++++++++
 lib/hashserv/client.py | 22 ++++++++++++++++++++++
 lib/hashserv/server.py | 29 +++++++++++++++++++++++++++++
 lib/hashserv/tests.py  | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)

diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
index a50701a88..b8755c579 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -227,6 +227,27 @@ def main():
         print("New hashes marked: %d" % result["count"])
         return 0
 
+    def handle_gc_mark_stream(args, client):
+        stdin = (l.strip() for l in sys.stdin)
+        marked_hashes = 0
+
+        try:
+            result = client.gc_mark_stream(args.mark, stdin)
+            marked_hashes = result["count"]
+        except ConnectionError:
+            logger.warning(
+                "Server doesn't seem to support `gc-mark-stream`. Sending "
+                "hashes sequentially using `gc-mark` API."
+            )
+            for line in stdin:
+                pairs = line.split()
+                condition = dict(zip(pairs[::2], pairs[1::2]))
+                result = client.gc_mark(args.mark, condition)
+                marked_hashes += result["count"]
+
+        print("New hashes marked: %d" % marked_hashes)
+        return 0
+
     def handle_gc_sweep(args, client):
         result = client.gc_sweep(args.mark)
         print("Removed %d rows" % result["count"])
@@ -366,6 +387,16 @@ def main():
                              help="Keep entries in table where KEY == VALUE")
     gc_mark_parser.set_defaults(func=handle_gc_mark)
 
+    gc_mark_parser_stream = subparsers.add_parser(
+        'gc-mark-stream',
+        help=(
+            "Mark multiple hashes to be retained for garbage collection. Input should be provided via stdin, "
+            "with each line formatted as key-value pairs separated by spaces, for example 'column1 foo column2 bar'."
+        )
+    )
+    gc_mark_parser_stream.add_argument("mark", help="Mark for this garbage collection operation")
+    gc_mark_parser_stream.set_defaults(func=handle_gc_mark_stream)
+
     gc_sweep_parser = subparsers.add_parser('gc-sweep', help="Perform garbage collection and delete any entries that are not marked")
     gc_sweep_parser.add_argument("mark", help="Mark for this garbage collection operation")
     gc_sweep_parser.set_defaults(func=handle_gc_sweep)
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index a510f3284..8cb18050a 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -78,6 +78,7 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
     MODE_NORMAL = 0
     MODE_GET_STREAM = 1
     MODE_EXIST_STREAM = 2
+    MODE_MARK_STREAM = 3
 
     def __init__(self, username=None, password=None):
         super().__init__("OEHASHEQUIV", "1.1", logger)
@@ -164,6 +165,8 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
             await normal_to_stream("get-stream")
         elif new_mode == self.MODE_EXIST_STREAM:
             await normal_to_stream("exists-stream")
+        elif new_mode == self.MODE_MARK_STREAM:
+            await normal_to_stream("gc-mark-stream")
         elif new_mode != self.MODE_NORMAL:
             raise Exception("Undefined mode transition {self.mode!r} -> {new_mode!r}")
 
@@ -306,6 +309,24 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         """
         return await self.invoke({"gc-mark": {"mark": mark, "where": where}})
 
+    async def gc_mark_stream(self, mark, rows):
+        """
+        Similar to `gc-mark`, but accepts a list of "where" key-value pair
+        conditions. It utilizes stream mode to mark hashes, which helps reduce
+        the impact of latency when communicating with the hash equivalence
+        server.
+        """
+        def row_to_dict(row):
+            pairs = row.split()
+            return dict(zip(pairs[::2], pairs[1::2]))
+
+        responses = await self.send_stream_batch(
+            self.MODE_MARK_STREAM,
+            (json.dumps({"mark": mark, "where": row_to_dict(row)}) for row in rows),
+        )
+
+        return {"count": sum(int(json.loads(r)["count"]) for r in responses)}
+
     async def gc_sweep(self, mark):
         """
         Finishes garbage collection for "mark". All unihash entries that have
@@ -351,6 +372,7 @@ class Client(bb.asyncrpc.Client):
             "get_db_query_columns",
             "gc_status",
             "gc_mark",
+            "gc_mark_stream",
             "gc_sweep",
         )
 
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 68f64f983..58f95c7bc 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -10,6 +10,7 @@ import math
 import time
 import os
 import base64
+import json
 import hashlib
 from . import create_async_client
 import bb.asyncrpc
@@ -256,6 +257,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                     "backfill-wait": self.handle_backfill_wait,
                     "remove": self.handle_remove,
                     "gc-mark": self.handle_gc_mark,
+                    "gc-mark-stream": self.handle_gc_mark_stream,
                     "gc-sweep": self.handle_gc_sweep,
                     "gc-status": self.handle_gc_status,
                     "clean-unused": self.handle_clean_unused,
@@ -583,6 +585,33 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
         return {"count": await self.db.gc_mark(mark, condition)}
 
+    @permissions(DB_ADMIN_PERM)
+    async def handle_gc_mark_stream(self, request):
+        async def handler(line):
+            try:
+                decoded_line = json.loads(line)
+            except json.JSONDecodeError as exc:
+                raise bb.asyncrpc.InvokeError(
+                    "Could not decode JSONL input '%s'" % line
+                ) from exc
+
+            try:
+                mark = decoded_line["mark"]
+                condition = decoded_line["where"]
+                if not isinstance(mark, str):
+                    raise TypeError("Bad mark type %s" % type(mark))
+
+                if not isinstance(condition, dict):
+                    raise TypeError("Bad condition type %s" % type(condition))
+            except KeyError as exc:
+                raise bb.asyncrpc.InvokeError(
+                    "Input line is missing key '%s' " % exc
+                ) from exc
+
+            return json.dumps({"count": await self.db.gc_mark(mark, condition)})
+
+        return await self._stream_handler(handler)
+
     @permissions(DB_ADMIN_PERM)
     async def handle_gc_sweep(self, request):
         mark = request["mark"]
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 13ccb20eb..da3f8e088 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -969,6 +969,48 @@ class HashEquivalenceCommonTests(object):
         # First hash is still present
         self.assertClientGetHash(self.client, taskhash, unihash)
 
+    def test_gc_stream(self):
+        taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
+        outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
+        unihash = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+
+        result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+        self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
+
+        taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
+        outhash2 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
+        unihash2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+
+        result = self.client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
+        self.assertClientGetHash(self.client, taskhash2, unihash2)
+
+        taskhash3 = 'a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c0'
+        outhash3 = '7289c414905303700a1117c1f5a7c9ab2f5a39cc6fe5e6152169d09c04f9a53c'
+        unihash3 = '905303700a1117c1f5a7c9ab2f5a39cc6fe5e615'
+
+        result = self.client.report_unihash(taskhash3, self.METHOD, outhash3, unihash3)
+        self.assertClientGetHash(self.client, taskhash3, unihash3)
+
+        # Mark the first unihash to be kept
+        ret = self.client.gc_mark_stream("ABC", (f"unihash {h}" for h in [unihash, unihash2]))
+        self.assertEqual(ret, {"count": 2})
+
+        ret = self.client.gc_status()
+        self.assertEqual(ret, {"mark": "ABC", "keep": 2, "remove": 1})
+
+        # Third hash is still there; mark doesn't delete hashes
+        self.assertClientGetHash(self.client, taskhash3, unihash3)
+
+        ret = self.client.gc_sweep("ABC")
+        self.assertEqual(ret, {"count": 1})
+
+        # Hash is gone. Taskhash is returned for second hash
+        self.assertClientGetHash(self.client, taskhash3, None)
+        # First hash is still present
+        self.assertClientGetHash(self.client, taskhash, unihash)
+        # Second hash is still present
+        self.assertClientGetHash(self.client, taskhash2, unihash2)
+
     def test_gc_switch_mark(self):
         taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
         outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
-- 
2.34.1


