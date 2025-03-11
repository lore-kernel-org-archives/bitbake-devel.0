Return-Path: <c137.marques@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B15C28B2F
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 16:32:42 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web11.14375.1741710758437049971
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Mar 2025 09:32:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=g74lJMpb;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: c137.marques@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3913fdd0120so1838476f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Mar 2025 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741710756; x=1742315556; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4JtLNXaWKauwYNe4H/ilqnkL6bmoFC/bc45bUuNMbOM=;
        b=g74lJMpbeIWh/fD9b/dJpjOVlgjZgtT6aHRibYryv2vOWvzjAKbEF1rpN+y1Kj+gmL
         BhQZ1d5g3hHBnmS8cxbPDY4EXrGbIAl9rIwPbMvBNpLezqTb6HYvMHqUAXVu8kfuwMyS
         bb2CbVX3wEBXdOdRlG1MZK6QylK+OoWIoGW3zZ3se/ebdPKazgAB0kGMVacaOHzUhWBZ
         9Q7v1OoEUgpvr6Cbdq0QRMsZlr+EcTR2Le80GI/j1x+7z+v5xbqUzVETFkFzP9cYyM9M
         be2DOnqfJ4ru0AlX1OdmybKh2MgVIVGHadY9oF+C9iVUHcV0gHMKPm39s4LmRTQBqDMj
         W6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741710756; x=1742315556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JtLNXaWKauwYNe4H/ilqnkL6bmoFC/bc45bUuNMbOM=;
        b=TEaIuJFk3ARPrnQP79FNNoFXMyKOvy9W1Ue+kcaLDYJim84VTnlF5MWMv3SXbJ1ngW
         t9VXbpcV1ountycRGKxvOIMKuMdnd1sPMztl95uWEqDV0+2x2VtLu1pWUgDk1Ggc3OIs
         IhPLcjlriqo9ieyHafaFO7tmOL39f7mqDeeMOKxFnamR7+1RJQA3EngxDg2HS3ivUQ6O
         1LjhGFC5QJsm8s7JeHJVUT6DermjvKvwKT1ZqRQXK0OCUsCgeIl2b3nu3sulc14+C7Mc
         DoWotEY1D9g0vqxcjVJyh++TX/VVfoMCOyZdT71vTn+uh/Anll1U1LOhxfPdEMRto/qM
         tDoQ==
X-Gm-Message-State: AOJu0Yz7J186Mc77pV1ECfXCjk9eL1hRfgPKgwMiXVFTCVHL3AGbGN4/
	cYwGJ7RF7/3G9ru9p2lOD3+Hod/GHE+745J+/76WuH2z/JLhAknOp19KKg==
X-Gm-Gg: ASbGncse1Msv8Yf0AOP2L4d6K+HipQ1d/+SmZnfDTbhiMxRKU2viIiLJN7fZvObJuR/
	jfcmcm6S7d5jbsqPGGqzUz6loNXBx8Lyd4WkkkAbDwQPxEOa0xQpg/f6YRDjQJ5PBtOoPXzWHlF
	ZLR9N+wgQfKxICENm1ruhLdr9OxWDEoRUkVER6Ybf78Mj2jDOZEm++ojcYBOour2TVCdESZfVJL
	A7k8i1X3C4mVTYBy2ZBW4Ioxhui+hGTgFzXepgL2eyqGh8sOb1TPd49C07E5FSzzLg+ZpZCnMXo
	9beDayltPXhxq9tbfpFzwZ8Dn3K0tZPLwJFJjmXivIsPb41AWA==
X-Google-Smtp-Source: AGHT+IEv/GXt0KHYpp06vCnnOfZiUZTP/cjt/E8xUhht61JIh0u9YTI/kRJS+rSH1NiCojHKwUermQ==
X-Received: by 2002:a5d:6482:0:b0:390:f88c:a6a2 with SMTP id ffacd0b85a97d-39132d986f8mr18409007f8f.39.1741710756297;
        Tue, 11 Mar 2025 09:32:36 -0700 (PDT)
Received: from pc.. ([213.205.68.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01d2cdsm18861412f8f.57.2025.03.11.09.32.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 09:32:35 -0700 (PDT)
From: Alexander Marques <c137.marques@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3 1/1] hashserv: Add `gc-mark-stream` command for batch hash marking
Date: Tue, 11 Mar 2025 16:32:33 +0000
Message-Id: <20250311163233.452668-1-c137.marques@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Mar 2025 16:32:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17433

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
 tmp                    |  0
 5 files changed, 124 insertions(+)
 create mode 100644 tmp

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
diff --git a/tmp b/tmp
new file mode 100644
index 000000000..e69de29bb
-- 
2.34.1


