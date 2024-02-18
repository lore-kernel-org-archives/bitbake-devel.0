Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E30C54764
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 23:00:15 +0000 (UTC)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
 by mx.groups.io with SMTP id smtpd.web10.29047.1708297210506627606
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 15:00:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=N+6viJkh;
 spf=pass (domain: gmail.com, ip: 209.85.166.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7beda6a274bso154668339f.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 15:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708297208; x=1708902008; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtvV3E/YY2tMZ2TEJt6BPtAHOVV5gzzmxAya+OjTTsE=;
        b=N+6viJkh/xgzjvqYC2rvRMw0DHJFSONpUIYQJ5PdTh3EWpOi5ovTQlzfSWmnrimrvr
         AZlnBrhRA9PXcNajFeKPNACrUY01RN3Hh9Iuuny2mOYbJ+NQ/KyvUm0ZybUMKjlViXCq
         mCx9USik3g+t8riDcRznYIOG0aIOhXUhp6hqK/5ZD3wxMApmx9HYHSfVC18kiaiknI3T
         BncW+Y1fS9TFZG7c7VL4v9X7KNqnIT6O9owG2GzAoEf/9lcqNYxAgxYG9oqc85ulEFK/
         4SDbF3plVa3Sqkscb5TrVTaPSKPyNfITfrPmtW/U1mH1JgeA9fA6M0KxUDPwMfpqChT0
         9IiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297208; x=1708902008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtvV3E/YY2tMZ2TEJt6BPtAHOVV5gzzmxAya+OjTTsE=;
        b=drS7Nv72xMFWwq/gJrVWC5uXFbpoIhog7AZyd0jnNycDxp9n8HtCWaMjt/NAwSf34S
         dE7hVj+vQKD1rSEKQpeGtL7Lui4f3TeHtPJ4T+t/bwS1FXGzT2/3H+sgDqsaM+qb5Kg5
         Mrx1NIFPTaDa15osOXOSW/40FaGXh85iR5TSH+gtQfXC8XxlIlmlCd2mXEXPuq6mi8vd
         LsxHnl/JqDSj+8ULozzyEUFeHRB+2igML33kjMmdAhNQDeumctC5iDi7Ax5Ruj2CzStN
         U2jRQZkNS1YrSIS8Za4/X+aCePPqLFzb5QBUadi/wSyHeXw9lGszOg7ac+j2kvdkfWpB
         N+CQ==
X-Gm-Message-State: AOJu0YyGwljqPk6iRY7oUMjxufCrZMHsPVjkiVgcn8/Ph1/aw2/9phtX
	iXwIBiiDGQsriQ53rFdqkvCuXjpIuEIKAZPCVr4e6Eg2Syj/lLU01LZIHkIY
X-Google-Smtp-Source: AGHT+IEx0OG7MxNksu/NoNuOhfIhKJJueciuyxZethexIgPl0fiJ60h3Rm5Zr/CccUd1I9gnZCFM0w==
X-Received: by 2002:a05:6602:2c95:b0:7c7:44e6:9192 with SMTP id i21-20020a0566022c9500b007c744e69192mr3566941iow.16.1708297208138;
        Sun, 18 Feb 2024 15:00:08 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id n3-20020a02cc03000000b004712a778fb4sm1214848jap.28.2024.02.18.15.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 15:00:06 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 3/8] hashserv: Add unihash-exists API
Date: Sun, 18 Feb 2024 15:59:48 -0700
Message-Id: <20240218225953.2997239-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218225953.2997239-1-JPEWhacker@gmail.com>
References: <20240218200743.2982923-1-JPEWhacker@gmail.com>
 <20240218225953.2997239-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 23:00:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15925

Adds API to check if the server is aware of the existence of a given
unihash. This can be used as an optimization for sstate where a client
can query the hash equivalence server to check if a unihash exists
before querying the sstate cache. If the hash server isn't aware of the
existence of a unihash, then there is very likely not a matching sstate
object, so this should be able to significantly cut down on the number
of negative hits on the sstate cache.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient     | 13 +++++++
 bitbake/lib/hashserv/client.py     | 44 ++++++++++++++++-----
 bitbake/lib/hashserv/server.py     | 61 +++++++++++++++++++-----------
 bitbake/lib/hashserv/sqlalchemy.py | 11 ++++++
 bitbake/lib/hashserv/sqlite.py     | 16 ++++++++
 bitbake/lib/hashserv/tests.py      | 39 +++++++++++++++++++
 6 files changed, 151 insertions(+), 33 deletions(-)

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index f71b87404ae..47dd27cd3c2 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
@@ -217,6 +217,14 @@ def main():
         print("Removed %d rows" % result["count"])
         return 0
 
+    def handle_unihash_exists(args, client):
+        result = client.unihash_exists(args.unihash)
+        if args.quiet:
+            return 0 if result else 1
+
+        print("true" if result else "false")
+        return 0
+
     parser = argparse.ArgumentParser(description='Hash Equivalence Client')
     parser.add_argument('--address', default=DEFAULT_ADDRESS, help='Server address (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
@@ -309,6 +317,11 @@ def main():
     gc_sweep_parser.add_argument("mark", help="Mark for this garbage collection operation")
     gc_sweep_parser.set_defaults(func=handle_gc_sweep)
 
+    unihash_exists_parser = subparsers.add_parser('unihash-exists', help="Check if a unihash is known to the server")
+    unihash_exists_parser.add_argument("--quiet", action="store_true", help="Don't print status. Instead, exit with 0 if unihash exists and 1 if it does not")
+    unihash_exists_parser.add_argument("unihash", help="Unihash to check")
+    unihash_exists_parser.set_defaults(func=handle_unihash_exists)
+
     args = parser.parse_args()
 
     logger = logging.getLogger('hashserv')
diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index e6dc4179126..daf1e128423 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -16,6 +16,7 @@ logger = logging.getLogger("hashserv.client")
 class AsyncClient(bb.asyncrpc.AsyncClient):
     MODE_NORMAL = 0
     MODE_GET_STREAM = 1
+    MODE_EXIST_STREAM = 2
 
     def __init__(self, username=None, password=None):
         super().__init__("OEHASHEQUIV", "1.1", logger)
@@ -49,19 +50,36 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
             await self.socket.send("END")
             return await self.socket.recv()
 
-        if new_mode == self.MODE_NORMAL and self.mode == self.MODE_GET_STREAM:
+        async def normal_to_stream(command):
+            r = await self.invoke({command: None})
+            if r != "ok":
+                raise ConnectionError(
+                    f"Unable to transition to stream mode: Bad response from server {r!r}"
+                )
+
+            self.logger.debug("Mode is now %s", command)
+
+        if new_mode == self.mode:
+            return
+
+        self.logger.debug("Transitioning mode %s -> %s", self.mode, new_mode)
+
+        # Always transition to normal mode before switching to any other mode
+        if self.mode != self.MODE_NORMAL:
             r = await self._send_wrapper(stream_to_normal)
             if r != "ok":
                 self.check_invoke_error(r)
-                raise ConnectionError("Unable to transition to normal mode: Bad response from server %r" % r)
-        elif new_mode == self.MODE_GET_STREAM and self.mode == self.MODE_NORMAL:
-            r = await self.invoke({"get-stream": None})
-            if r != "ok":
-                raise ConnectionError("Unable to transition to stream mode: Bad response from server %r" % r)
-        elif new_mode != self.mode:
-            raise Exception(
-                "Undefined mode transition %r -> %r" % (self.mode, new_mode)
-            )
+                raise ConnectionError(
+                    f"Unable to transition to normal mode: Bad response from server {r!r}"
+                )
+            self.logger.debug("Mode is now normal")
+
+        if new_mode == self.MODE_GET_STREAM:
+            await normal_to_stream("get-stream")
+        elif new_mode == self.MODE_EXIST_STREAM:
+            await normal_to_stream("exists-stream")
+        elif new_mode != self.MODE_NORMAL:
+            raise Exception("Undefined mode transition {self.mode!r} -> {new_mode!r}")
 
         self.mode = new_mode
 
@@ -95,6 +113,11 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
             {"get": {"taskhash": taskhash, "method": method, "all": all_properties}}
         )
 
+    async def unihash_exists(self, unihash):
+        await self._set_mode(self.MODE_EXIST_STREAM)
+        r = await self.send_stream(unihash)
+        return r == "true"
+
     async def get_outhash(self, method, outhash, taskhash, with_unihash=True):
         await self._set_mode(self.MODE_NORMAL)
         return await self.invoke(
@@ -236,6 +259,7 @@ class Client(bb.asyncrpc.Client):
             "report_unihash",
             "report_unihash_equiv",
             "get_taskhash",
+            "unihash_exists",
             "get_outhash",
             "get_stats",
             "reset_stats",
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index 5ed852d1f30..68f64f983b2 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -234,6 +234,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 "get": self.handle_get,
                 "get-outhash": self.handle_get_outhash,
                 "get-stream": self.handle_get_stream,
+                "exists-stream": self.handle_exists_stream,
                 "get-stats": self.handle_get_stats,
                 "get-db-usage": self.handle_get_db_usage,
                 "get-db-query-columns": self.handle_get_db_query_columns,
@@ -377,8 +378,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         await self.db.insert_unihash(data["method"], data["taskhash"], data["unihash"])
         await self.db.insert_outhash(data)
 
-    @permissions(READ_PERM)
-    async def handle_get_stream(self, request):
+    async def _stream_handler(self, handler):
         await self.socket.send_message("ok")
 
         while True:
@@ -400,35 +400,50 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 if l == "END":
                     break
 
-                (method, taskhash) = l.split()
-                # self.logger.debug('Looking up %s %s' % (method, taskhash))
-                row = await self.db.get_equivalent(method, taskhash)
-
-                if row is not None:
-                    msg = row["unihash"]
-                    # self.logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
-                elif self.upstream_client is not None:
-                    upstream = await self.upstream_client.get_unihash(method, taskhash)
-                    if upstream:
-                        msg = upstream
-                    else:
-                        msg = ""
-                else:
-                    msg = ""
-
+                msg = await handler(l)
                 await self.socket.send(msg)
             finally:
                 request_measure.end()
                 self.request_sample.end()
 
-            # Post to the backfill queue after writing the result to minimize
-            # the turn around time on a request
-            if upstream is not None:
-                await self.server.backfill_queue.put((method, taskhash))
-
         await self.socket.send("ok")
         return self.NO_RESPONSE
 
+    @permissions(READ_PERM)
+    async def handle_get_stream(self, request):
+        async def handler(l):
+            (method, taskhash) = l.split()
+            # self.logger.debug('Looking up %s %s' % (method, taskhash))
+            row = await self.db.get_equivalent(method, taskhash)
+
+            if row is not None:
+                # self.logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
+                return row["unihash"]
+
+            if self.upstream_client is not None:
+                upstream = await self.upstream_client.get_unihash(method, taskhash)
+                if upstream:
+                    await self.server.backfill_queue.put((method, taskhash))
+                    return upstream
+
+            return ""
+
+        return await self._stream_handler(handler)
+
+    @permissions(READ_PERM)
+    async def handle_exists_stream(self, request):
+        async def handler(l):
+            if await self.db.unihash_exists(l):
+                return "true"
+
+            if self.upstream_client is not None:
+                if await self.upstream_client.unihash_exists(l):
+                    return "true"
+
+            return "false"
+
+        return await self._stream_handler(handler)
+
     async def report_readonly(self, data):
         method = data["method"]
         outhash = data["outhash"]
diff --git a/bitbake/lib/hashserv/sqlalchemy.py b/bitbake/lib/hashserv/sqlalchemy.py
index 873547809a0..0e28d738f5a 100644
--- a/bitbake/lib/hashserv/sqlalchemy.py
+++ b/bitbake/lib/hashserv/sqlalchemy.py
@@ -48,6 +48,7 @@ class UnihashesV3(Base):
     __table_args__ = (
         UniqueConstraint("method", "taskhash"),
         Index("taskhash_lookup_v4", "method", "taskhash"),
+        Index("unihash_lookup_v1", "unihash"),
     )
 
 
@@ -279,6 +280,16 @@ class Database(object):
             )
             return map_row(result.first())
 
+    async def unihash_exists(self, unihash):
+        async with self.db.begin():
+            result = await self._execute(
+                select(UnihashesV3)
+                .where(UnihashesV3.unihash == unihash)
+                .limit(1)
+            )
+
+            return result.first() is not None
+
     async def get_outhash(self, method, outhash):
         async with self.db.begin():
             result = await self._execute(
diff --git a/bitbake/lib/hashserv/sqlite.py b/bitbake/lib/hashserv/sqlite.py
index 608490730d7..da2e844a031 100644
--- a/bitbake/lib/hashserv/sqlite.py
+++ b/bitbake/lib/hashserv/sqlite.py
@@ -144,6 +144,9 @@ class DatabaseEngine(object):
             cursor.execute(
                 "CREATE INDEX IF NOT EXISTS taskhash_lookup_v4 ON unihashes_v3 (method, taskhash)"
             )
+            cursor.execute(
+                "CREATE INDEX IF NOT EXISTS unihash_lookup_v1 ON unihashes_v3 (unihash)"
+            )
             cursor.execute(
                 "CREATE INDEX IF NOT EXISTS outhash_lookup_v3 ON outhashes_v2 (method, outhash)"
             )
@@ -255,6 +258,19 @@ class Database(object):
             )
             return cursor.fetchone()
 
+    async def unihash_exists(self, unihash):
+        with closing(self.db.cursor()) as cursor:
+            cursor.execute(
+                """
+                SELECT * FROM unihashes_v3 WHERE unihash=:unihash
+                LIMIT 1
+                """,
+                {
+                    "unihash": unihash,
+                },
+            )
+            return cursor.fetchone() is not None
+
     async def get_outhash(self, method, outhash):
         with closing(self.db.cursor()) as cursor:
             cursor.execute(
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index aeedab3575e..fbbe81512a0 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -442,6 +442,11 @@ class HashEquivalenceCommonTests(object):
         self.assertEqual(result['taskhash'], taskhash9, 'Server failed to copy unihash from upstream')
         self.assertEqual(result['method'], self.METHOD)
 
+    def test_unihash_exsits(self):
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
+        self.assertTrue(self.client.unihash_exists(unihash))
+        self.assertFalse(self.client.unihash_exists('6662e699d6e3d894b24408ff9a4031ef9b038ee8'))
+
     def test_ro_server(self):
         rw_server = self.start_server()
         rw_client = self.start_client(rw_server.address)
@@ -1031,6 +1036,40 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
     def test_stress(self):
         self.run_hashclient(["--address", self.server_address, "stress"], check=True)
 
+    def test_unihash_exsits(self):
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
+
+        p = self.run_hashclient([
+            "--address", self.server_address,
+            "unihash-exists", unihash,
+        ], check=True)
+        self.assertEqual(p.stdout.strip(), "true")
+
+        p = self.run_hashclient([
+            "--address", self.server_address,
+            "unihash-exists", '6662e699d6e3d894b24408ff9a4031ef9b038ee8',
+        ], check=True)
+        self.assertEqual(p.stdout.strip(), "false")
+
+    def test_unihash_exsits_quiet(self):
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
+
+        p = self.run_hashclient([
+            "--address", self.server_address,
+            "unihash-exists", unihash,
+            "--quiet",
+        ])
+        self.assertEqual(p.returncode, 0)
+        self.assertEqual(p.stdout.strip(), "")
+
+        p = self.run_hashclient([
+            "--address", self.server_address,
+            "unihash-exists", '6662e699d6e3d894b24408ff9a4031ef9b038ee8',
+            "--quiet",
+        ])
+        self.assertEqual(p.returncode, 1)
+        self.assertEqual(p.stdout.strip(), "")
+
     def test_remove_taskhash(self):
         taskhash, outhash, unihash = self.create_test_hash(self.client)
         self.run_hashclient([
-- 
2.34.1


