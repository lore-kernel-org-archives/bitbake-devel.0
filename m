Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778E6CD8C8E
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 21:12:46 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23181.1780780360714646129
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Jun 2026 14:12:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=2MEWjrP/;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490ac357c55so35998415e9.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780780359; x=1781385159; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYZ7AuE5PgfVSRKP6ha4prXK+ktOjhiSwi1C0yWN6uk=;
        b=2MEWjrP/8NJJQiQpd8uz7YezbcT9nhXzs6B+p0d+bhhoR3kHij2xTNBTIPNgXp0QZM
         o3GWx+37wjTiiXOOx6Lb7Fb3Mu/tX8lrz0MsltnB2xWXe8bOQesepGqdyQ+Ic5gsZ2vL
         uJ77k/fyWJv7TxjSOvsxI+BzHzx4EQbSpjpIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780780359; x=1781385159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYZ7AuE5PgfVSRKP6ha4prXK+ktOjhiSwi1C0yWN6uk=;
        b=L+rHlVjQ8cELik1+CdM2wVX4397XtihlyljF7Y1y6nUFBwWJXkkJr/ZaOQsZOInt5o
         Q04EKtNfA0mMVRZ6m025fVdbDB7R2BJBm+YzL7+AUjcmjuTm+IImFW9jtkQtVVyE1Hl7
         B1doIUL6AvVignkbX4/vEak+KpkQm1txTJnL2U07L4FD493kyBBCcUbk2ADbvD7V6Aj/
         K4rwXgL9uUS4ybkR9Vx+5tNH1dGKvO4jC7EnE2BbfcuDeWMZPKmV2freQ8tdPaoESp6N
         8hvixlrJUcmxR91lTwwyUZwl3hOyK39Rd0VA8pQU8AfhBFpCLjzkKPh0fy8DeVs0pkyO
         vlaw==
X-Gm-Message-State: AOJu0YyF4x/FKBOwWV+H2juCnJe8OEsCJEfgkAXs0k+mHyR/VQVC4sga
	Rwzy7bexMqSyTQ45xeujtED5nXZ2uSOBipIOyhHpk0TFnV1sbjHY1KMQQz9ZgUJsCpsE29F5ZUS
	dhL/O
X-Gm-Gg: Acq92OERHDlVQsnjp5YorQYkT3vVODZMDP3+3k7TZ29W5vmeJKUfBs1iUuHiL6/2o9y
	JTSqwS8WckwlA11IwLH3WsvfzJhRtJxAhFdpHwRwBCJbtDbvTjREFfFFbqYKCeKnj4EoKhNbyWw
	kiKmW8EYGaQi1W5phMmwcxWzFSbtYXxTO5DktUbitbWD+borzfcs+G7Ii5Zxkx6916p7v8QG9hY
	2I2gSKzZmcPa2t1N1kE70yrQG0ekhhSRRb99CqWyKElLLC7D0QznR7II/8Svmq9a6/1mNkkbRoX
	MHuxJ1dZCu+kL248FID2UwmjlXZBdBZnzyXQN71CFiRi0D4e5Zfj+GzYJjBToqNaTsLsQsYvYOw
	V/+3LRK9wG44YFT+wRNaV6o4NBgayLE3gp05Lp/DIhnzdAJwdkxxdCDAjtbOpXfUkD8pLrLGvfu
	NN2u/yNPMj+o7WuzCa4fq78lJyzh3OT1505CySMnHnf1E/0ysYYVc9pL13qI87BT6lfLwiFKTW2
	mDFbABqmDi3lKzV4TpDqB59aKO8d7IB3TZjkL1dHvyO2D+4
X-Received: by 2002:a05:600c:1549:b0:490:c7dd:7cc2 with SMTP id 5b1f17b1804b1-490c7dd7defmr65055455e9.24.1780780359024;
        Sat, 06 Jun 2026 14:12:39 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa000f4f58971dfc8e81.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:f4f:5897:1dfc:8e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm169994915e9.2.2026.06.06.14.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:12:38 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 2/2] hashserv: validate unihash values
Date: Sat,  6 Jun 2026 23:12:13 +0200
Message-ID: <a4daa14312d659333984aa1ae58ddfe0c96392f1.1780780220.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780780220.git.yoann.congal@smile.fr>
References: <cover.1780780220.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 21:12:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19628

From: Anders Heimer <anders.heimer@est.tech>

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f9b817d8017e5d5a1d22b9aa10a3c974bc7fa33d)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/siggen.py         |  9 +++++++-
 lib/bb/tests/siggen.py   | 48 ++++++++++++++++++++++++++++++++++++++++
 lib/hashserv/__init__.py |  7 ++++++
 lib/hashserv/server.py   | 27 +++++++++++++++++-----
 lib/hashserv/tests.py    | 30 +++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 6 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 65ca0811d..fcf164aec 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -43,6 +43,10 @@ def check_siggen_version(siggen):
     if siggen.find_siginfo_version < siggen.find_siginfo_minversion:
         bb.fatal("Siggen from metadata (OE-Core?) is too old, please update it (%s vs %s)" % (siggen.find_siginfo_version, siggen.find_siginfo_minversion))
 
+def check_hashserv_unihash(unihash):
+    if not hashserv.is_valid_unihash(unihash):
+        bb.fatal("Hash Equivalence Server returned invalid unihash")
+
 class SetEncoder(json.JSONEncoder):
     def default(self, obj):
         if isinstance(obj, set) or isinstance(obj, frozenset):
@@ -753,6 +757,7 @@ class SignatureGeneratorUniHashMixIn(object):
             #    the unique hash.
             taskhash = self.taskhash[tid]
             if unihash:
+                check_hashserv_unihash(unihash)
                 # A unique hash equal to the taskhash is not very interesting,
                 # so it is reported it at debug level 2. If they differ, that
                 # is much more interesting, so it is reported at debug level 1
@@ -772,7 +777,7 @@ class SignatureGeneratorUniHashMixIn(object):
         import importlib
 
         taskhash = d.getVar('BB_TASKHASH')
-        unihash = d.getVar('BB_UNIHASH')
+        unihash = d.getVar('BB_UNIHASH', expand=False)
         report_taskdata = d.getVar('SSTATE_HASHEQUIV_REPORT_TASKDATA') == '1'
         tempdir = d.getVar('T')
         mcfn = d.getVar('BB_FILENAME')
@@ -834,6 +839,7 @@ class SignatureGeneratorUniHashMixIn(object):
                     data = client.report_unihash(taskhash, method, outhash, unihash, extra_data)
 
                 new_unihash = data['unihash']
+                check_hashserv_unihash(new_unihash)
 
                 if new_unihash != unihash:
                     hashequiv_logger.debug('Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
@@ -873,6 +879,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 return False
 
             finalunihash = data['unihash']
+            check_hashserv_unihash(finalunihash)
 
             if finalunihash == current_unihash:
                 hashequiv_logger.verbose('Task %s unihash %s unchanged by server' % (tid, finalunihash))
diff --git a/lib/bb/tests/siggen.py b/lib/bb/tests/siggen.py
index 0dc67e6cc..ae5d0f300 100644
--- a/lib/bb/tests/siggen.py
+++ b/lib/bb/tests/siggen.py
@@ -9,7 +9,9 @@
 import unittest
 import logging
 import bb
+import bb.data
 import time
+from contextlib import contextmanager
 
 logger = logging.getLogger('BitBake.TestSiggen')
 
@@ -26,3 +28,49 @@ class SiggenTest(unittest.TestCase):
         for t in tests:
             self.assertEqual(bb.siggen.build_pnid(*t), tests[t])
 
+    def test_get_unihashes_rejects_invalid_hashserv_unihash(self):
+        class TestClient:
+            def get_unihash_batch(self, query):
+                list(query)
+                return ["${@os.system('true')}"]
+
+        class TestSiggen(bb.siggen.SignatureGeneratorUniHashMixIn):
+            def __init__(self):
+                self.server = "test-server"
+                self.method = "test-method"
+                self.extramethod = {}
+                self.taskhash = {"test.bb:do_compile": "a" * 64}
+                self.unihash = {}
+                self.unitaskhashes = {}
+                self.tidtopn = {}
+                self.setscenetasks = set()
+                self.max_parallel = 1
+
+            @contextmanager
+            def client(self):
+                yield TestClient()
+
+        siggen = TestSiggen()
+
+        with self.assertRaises(bb.BBHandledException):
+            siggen.get_unihashes(["test.bb:do_compile"])
+
+        self.assertEqual(siggen.unihash, {})
+        self.assertEqual(siggen.unitaskhashes, {})
+
+    def test_report_unihash_reads_bb_unihash_without_expansion(self):
+        class TestSiggen(bb.siggen.SignatureGeneratorUniHashMixIn):
+            def __init__(self):
+                self.setscenetasks = set()
+                self.taskhash = {"test.bb:do_compile": "b" * 64}
+
+        d = bb.data.init()
+        d.setVar("BB_TASKHASH", "a" * 64)
+        d.setVar("BB_UNIHASH", "${@d.setVar('EXPANDED_UNIHASH', '1') or 'bad'}")
+        d.setVar("SSTATE_HASHEQUIV_REPORT_TASKDATA", "0")
+        d.setVar("T", "/tmp")
+        d.setVar("BB_FILENAME", "test.bb")
+
+        TestSiggen().report_unihash(".", "compile", d)
+
+        self.assertIsNone(d.getVar("EXPANDED_UNIHASH"))
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 74367eb6b..8ed00d532 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -7,12 +7,19 @@ import asyncio
 from contextlib import closing
 import itertools
 import json
+import re
 from collections import namedtuple
 from urllib.parse import urlparse
 from bb.asyncrpc.client import parse_address, ADDR_TYPE_UNIX, ADDR_TYPE_WS
 
 User = namedtuple("User", ("username", "permissions"))
 
+UNIHASH_REGEX = re.compile(r"^[0-9a-f]{64}$")
+
+
+def is_valid_unihash(value):
+    return isinstance(value, str) and UNIHASH_REGEX.fullmatch(value) is not None
+
 def create_server(
     addr,
     dbname,
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 68f64f983..ce7db064c 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -12,6 +12,7 @@ import os
 import base64
 import hashlib
 from . import create_async_client
+from . import is_valid_unihash
 import bb.asyncrpc
 
 logger = logging.getLogger("hashserv.server")
@@ -172,6 +173,11 @@ def hash_token(algo, salt, token):
     return ":".join([algo, salt, h.hexdigest()])
 
 
+def validate_unihash(value):
+    if not is_valid_unihash(value):
+        raise bb.asyncrpc.InvokeError("Invalid unihash")
+
+
 def permissions(*permissions, allow_anon=True, allow_self_service=False):
     """
     Function decorator that can be used to decorate an RPC function call and
@@ -343,7 +349,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 d = {k: row[k] for k in row.keys()}
             elif self.upstream_client is not None:
                 d = await self.upstream_client.get_taskhash(method, taskhash)
-                await self.db.insert_unihash(d["method"], d["taskhash"], d["unihash"])
+                await self.insert_unihash(d["method"], d["taskhash"], d["unihash"])
 
         return d
 
@@ -375,9 +381,13 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         if data is None:
             return
 
-        await self.db.insert_unihash(data["method"], data["taskhash"], data["unihash"])
+        await self.insert_unihash(data["method"], data["taskhash"], data["unihash"])
         await self.db.insert_outhash(data)
 
+    async def insert_unihash(self, method, taskhash, unihash):
+        validate_unihash(unihash)
+        return await self.db.insert_unihash(method, taskhash, unihash)
+
     async def _stream_handler(self, handler):
         await self.socket.send_message("ok")
 
@@ -465,6 +475,8 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
     # report is made inside the function
     @permissions(READ_PERM)
     async def handle_report(self, data):
+        validate_unihash(data.get("unihash"))
+
         if self.server.read_only or not self.user_has_permissions(REPORT_PERM):
             return await self.report_readonly(data)
 
@@ -507,7 +519,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                     if upstream_data is not None:
                         unihash = upstream_data["unihash"]
 
-            await self.db.insert_unihash(data["method"], data["taskhash"], unihash)
+            await self.insert_unihash(data["method"], data["taskhash"], unihash)
 
         unihash_data = await self.get_unihash(data["method"], data["taskhash"])
         if unihash_data is not None:
@@ -523,7 +535,9 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
     @permissions(READ_PERM, REPORT_PERM)
     async def handle_equivreport(self, data):
-        await self.db.insert_unihash(data["method"], data["taskhash"], data["unihash"])
+        validate_unihash(data.get("unihash"))
+
+        await self.insert_unihash(data["method"], data["taskhash"], data["unihash"])
 
         # Fetch the unihash that will be reported for the taskhash. If the
         # unihash matches, it means this row was inserted (or the mapping
@@ -859,7 +873,10 @@ class Server(bb.asyncrpc.AsyncServer):
                 method, taskhash = item
                 d = await client.get_taskhash(method, taskhash)
                 if d is not None:
-                    await db.insert_unihash(d["method"], d["taskhash"], d["unihash"])
+                    if is_valid_unihash(d.get("unihash")):
+                        await db.insert_unihash(d["method"], d["taskhash"], d["unihash"])
+                    else:
+                        self.logger.warning("Upstream server returned invalid unihash")
                 self.backfill_queue.task_done()
 
     def start(self):
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 5b42b9e11..1c6a57274 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -295,6 +295,36 @@ class HashEquivalenceCommonTests(object):
         self.assertEqual(result_outhash['outhash'], outhash)
         self.assertEqual(result_outhash['outhash_siginfo'], siginfo)
 
+    def test_report_rejects_invalid_unihash(self):
+        taskhash = '68a9206490b2321bb033fb3eab013a4ec62c41f9'
+        outhash = 'bf5f2efaf1ca351f3b4c3d079363540ab48f7c58db3d23cfbb069cf4ff1ea8f7'
+        invalid_unihashes = (
+            "${@os.system('true')}",
+            'a' * 63,
+            'a' * 65,
+            'A' * 64,
+            None,
+        )
+
+        for unihash in invalid_unihashes:
+            with self.subTest(unihash=unihash):
+                with self.start_client(self.server_address) as client:
+                    with self.assertRaises(InvokeError) as context:
+                        client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+
+                self.assertEqual(str(context.exception), "Invalid unihash")
+
+        self.assertClientGetHash(self.client, taskhash, None)
+
+    def test_equivreport_rejects_invalid_unihash(self):
+        taskhash = 'ae6339531895ddf5b67e663e6a374ad8ec71d81c'
+
+        with self.assertRaises(InvokeError) as context:
+            self.client.report_unihash_equiv(taskhash, self.METHOD, "${@os.system('true')}")
+
+        self.assertEqual(str(context.exception), "Invalid unihash")
+        self.assertClientGetHash(self.start_client(self.server_address), taskhash, None)
+
     def test_stress(self):
         def query_server(failures):
             client = Client(self.server_address)

