Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2891FCD8C9A
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 21:20:07 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23175.1780780803870615000
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Jun 2026 14:20:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=PWiXziLn;
 spf=pass (domain: smile.fr, ip: 209.85.128.41, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490b64c8311so34586105e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780780802; x=1781385602; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovJCRAw45fskTwqYbbyjS4itBvLfVHhv71aVXPtC9GI=;
        b=PWiXziLnFg3FpoFRh2nhH+gCf9gTnQN8VWwd+L39/hY4urpxKmu9yB3S3tHOjIpt66
         6LLcEInTC9OGf5Wa4Z/SbtG7v8Ake39wch83COR+8cnTnXqC0goDtfrUcqy4KuU1goLf
         7qQb841Mi+SE0gfIrpZMP0TZyhXipTYOJ0kJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780780802; x=1781385602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ovJCRAw45fskTwqYbbyjS4itBvLfVHhv71aVXPtC9GI=;
        b=iSV7gfvmeXQ2CujAAGZ3HPLxtxP0TnQt6/TE9ywTOT4a8nhTxw+pYSKc/KObl0mJGs
         GUX0XibS5wDSLyKl3Gt5NaiUp4mHMCyCmU2JP4Bl3thjPLEZM1IHfuFt+3RI+rFy9mdM
         mu7xv6e85l6R1Lv/IHkLU7MP6j5ayliNO0BiTxXzjqiYb0T3gMG3cuULFxKydJa/RSHX
         z0l7egBLXRpTuSag5TfD+OKc+h9o0cZlu/cNOzWQo+BR/EG8M3Xnr5kGWhuW5ePoc0jc
         btsbYZ/DfSCSK7fdEZe3QH2kuKQGtxJ1b41nFqJRSd2eRQQ/wuK2UsRy3NGTzLTjmjlc
         1a0g==
X-Gm-Message-State: AOJu0YxL0YhoO7ApxDpXzPoE9fiJaPApNDWaGXZYIuDEjg0yL2Qx2yJj
	zPpWGF2+Mq08X7BQi4fhxofE1LXxf1aoWShD1Dvdgm8xo4Sj6s9In1taiA4ftT4d8v54wrNo2LZ
	l1DkG
X-Gm-Gg: Acq92OGtS6o9IewaeRUHLJ0hiYzSKSexeu+b0/pkOJoIT05xRsNMekhNKwkGKC6WlUo
	BYqNMhDyShbZA/G3m09+Bqo/bjg4o+8tW1QWdpntbSoxrISwAnW6J8oU4zPxupPxNccWuVNAvK0
	Jgph2Rz+DDTzgKolWcAVX32LtjDnJB+sLMTirNCxoKPn3p6BY8xaMWBqc2/iHiMCk1xaBcyZH+u
	yGD3VHQopPxemR9g13Vv1eC0Ial09s6+h5k+vADSfxVZHhi6IppDAugneoc3LMMtsqduW0+Fjjd
	avO+leCp42Wg1ydhlQKh4fQ5dR4wGwhWkRth9MahKI3EGt/UfhrBZRZN7H4FQOm2+cbxFZKUrOQ
	vdzfGYJXQTqF70/o5x5LNfZRhUDMM7R8qW14rm29ScebQv8YpKjVVy/ME7uxJ8MYoBOp8NDkx19
	ApNxQHr570+m8s2k4Z213gBjMBCFl2dG3FIRl1vmb8w7i943rYpNObwDidBpYYJg4BG1OCJe8c4
	iz3oQ+0DboAsjbSPsTYOb8sIXMx5LgXh6iCtg==
X-Received: by 2002:a05:600c:8183:b0:490:5cd8:d213 with SMTP id 5b1f17b1804b1-490c25c4898mr137377815e9.15.1780780802154;
        Sat, 06 Jun 2026 14:20:02 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa000f4f58971dfc8e81.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:f4f:5897:1dfc:8e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cc140sm314340625e9.9.2026.06.06.14.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:20:01 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][wrynose][2.18][PATCH 2/3] hashserv: validate unihash values
Date: Sat,  6 Jun 2026 23:19:38 +0200
Message-ID: <01195988915a26da5c2fc6b1571279a707d50be9.1780780690.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780780690.git.yoann.congal@smile.fr>
References: <cover.1780780690.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 21:20:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19631

From: Anders Heimer <anders.heimer@est.tech>

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f9b817d8017e5d5a1d22b9aa10a3c974bc7fa33d)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/siggen.py         |  9 +++++++-
 lib/bb/tests/siggen.py   | 47 ++++++++++++++++++++++++++++++++++++++++
 lib/hashserv/__init__.py |  7 ++++++
 lib/hashserv/server.py   | 27 ++++++++++++++++++-----
 lib/hashserv/tests.py    | 30 +++++++++++++++++++++++++
 5 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 985fa7e4c..3a203676e 100644
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
@@ -729,6 +733,7 @@ class SignatureGeneratorUniHashMixIn(object):
 
             if unihashes and unihashes[idx]:
                 unihash = unihashes[idx]
+                check_hashserv_unihash(unihash)
                 # A unique hash equal to the taskhash is not very interesting,
                 # so it is reported it at debug level 2. If they differ, that
                 # is much more interesting, so it is reported at debug level 1
@@ -747,7 +752,7 @@ class SignatureGeneratorUniHashMixIn(object):
         import importlib
 
         taskhash = d.getVar('BB_TASKHASH')
-        unihash = d.getVar('BB_UNIHASH')
+        unihash = d.getVar('BB_UNIHASH', expand=False)
         report_taskdata = d.getVar('SSTATE_HASHEQUIV_REPORT_TASKDATA') == '1'
         tempdir = d.getVar('T')
         mcfn = d.getVar('BB_FILENAME')
@@ -809,6 +814,7 @@ class SignatureGeneratorUniHashMixIn(object):
                     data = client.report_unihash(taskhash, method, outhash, unihash, extra_data)
 
                 new_unihash = data['unihash']
+                check_hashserv_unihash(new_unihash)
 
                 if new_unihash != unihash:
                     hashequiv_logger.debug('Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
@@ -848,6 +854,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 return False
 
             finalunihash = data['unihash']
+            check_hashserv_unihash(finalunihash)
 
             if finalunihash == current_unihash:
                 hashequiv_logger.verbose('Task %s unihash %s unchanged by server' % (tid, finalunihash))
diff --git a/lib/bb/tests/siggen.py b/lib/bb/tests/siggen.py
index 0dc67e6cc..eb07cc920 100644
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
 
@@ -26,3 +28,48 @@ class SiggenTest(unittest.TestCase):
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
index ac891e017..ba8e0acce 100644
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
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 58f95c7bc..3ff434785 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -13,6 +13,7 @@ import base64
 import json
 import hashlib
 from . import create_async_client
+from . import is_valid_unihash
 import bb.asyncrpc
 
 logger = logging.getLogger("hashserv.server")
@@ -173,6 +174,11 @@ def hash_token(algo, salt, token):
     return ":".join([algo, salt, h.hexdigest()])
 
 
+def validate_unihash(value):
+    if not is_valid_unihash(value):
+        raise bb.asyncrpc.InvokeError("Invalid unihash")
+
+
 def permissions(*permissions, allow_anon=True, allow_self_service=False):
     """
     Function decorator that can be used to decorate an RPC function call and
@@ -345,7 +351,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 d = {k: row[k] for k in row.keys()}
             elif self.upstream_client is not None:
                 d = await self.upstream_client.get_taskhash(method, taskhash)
-                await self.db.insert_unihash(d["method"], d["taskhash"], d["unihash"])
+                await self.insert_unihash(d["method"], d["taskhash"], d["unihash"])
 
         return d
 
@@ -377,9 +383,13 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
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
 
@@ -467,6 +477,8 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
     # report is made inside the function
     @permissions(READ_PERM)
     async def handle_report(self, data):
+        validate_unihash(data.get("unihash"))
+
         if self.server.read_only or not self.user_has_permissions(REPORT_PERM):
             return await self.report_readonly(data)
 
@@ -509,7 +521,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                     if upstream_data is not None:
                         unihash = upstream_data["unihash"]
 
-            await self.db.insert_unihash(data["method"], data["taskhash"], unihash)
+            await self.insert_unihash(data["method"], data["taskhash"], unihash)
 
         unihash_data = await self.get_unihash(data["method"], data["taskhash"])
         if unihash_data is not None:
@@ -525,7 +537,9 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
     @permissions(READ_PERM, REPORT_PERM)
     async def handle_equivreport(self, data):
-        await self.db.insert_unihash(data["method"], data["taskhash"], data["unihash"])
+        validate_unihash(data.get("unihash"))
+
+        await self.insert_unihash(data["method"], data["taskhash"], data["unihash"])
 
         # Fetch the unihash that will be reported for the taskhash. If the
         # unihash matches, it means this row was inserted (or the mapping
@@ -888,7 +902,10 @@ class Server(bb.asyncrpc.AsyncServer):
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
index 9993fc9f3..7c736d6cc 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -291,6 +291,36 @@ class HashEquivalenceCommonTests(object):
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

