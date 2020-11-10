Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web08.28449.1605020401609957874
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Nov 2020 07:00:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=LKD2tc6/;
 spf=pass (domain: gmail.com, ip: 209.85.210.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id k3so12744923otp.12
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Nov 2020 07:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yBpqY0Zau5T9ynxG28jnbuavTSzzA0dVcRXFehP7bL8=;
        b=LKD2tc6/339lAVilNBVFB8V4EBEZIrt49q4WJ8b0s/4tBMjEU1Jlj+ijxNX/PIyTU4
         ucGUH4JnzGnv8XgNzawX9AR8YSj2KDkAJLWpQz4coWZKzHcBR0Zsa2/VwCld/qdLXKaU
         5gwLo4xsmKey3ZiJ1wEOXbEVyyhq05fBxWbGacNIjeXpGhywHNLCExOcMY6siM1B6pzz
         8+MDWV9xVpkSj+6R+L3/XCbW+Ga3kQWsluByyobd1RQyJvGPSuIVgfKjfOHPPlX+YcvL
         oK+KRIteEHjScTbzTURN5Gf62Unu4qpRW2n7WZgFbpNSARzeFRv2DZEYEF1nBOLur3jb
         zx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yBpqY0Zau5T9ynxG28jnbuavTSzzA0dVcRXFehP7bL8=;
        b=VagEmV72Su/ySY1ywEa1NrmdbY+h0BeF4TxGj5yvrbBSTkn7q4w9Uj1mwNf1FISED6
         s4c11KilcZQp9de4n9n9s0GEeOOzH1VGgJvjnZmQuTsjprMqzAKTL8SNLYslMlrkKtkx
         0LjH1JPKFpmwYUx1yFI2QIlWJTwWSgTJVkF8VYKiSJV5vRmDJcoEuihXSXDdFwhUhj1a
         jVTyNLXJkSjt1U4iYm/o4kCghzj+U/ZD6a6WGSL9Jaa+t8ulPQx7c7CETl/EC5ZGYFML
         /YAAKl7AzOubRZPBYLk+J59vfjLLE4pTYoAIZXrSqTU5e0QHwEArg7PibBOp/LoJxWkE
         w0tQ==
X-Gm-Message-State: AOAM532w6Vv3ECuBr/GSYUlu8MxH0vN5nO+/6ORPtMPysqv+QrNaz8IT
	KdfnlXbUMwLZLhUIfIZphSCTiDUCR7hDpw==
X-Google-Smtp-Source: ABdhPJy1FLzkCFI3fzr/VMV2IGi8TmD0prWGpY6fVGI0llHYoJl0h8OM0tHwkCtqEkJCLUMPRO8OYQ==
X-Received: by 2002:a05:6830:12d0:: with SMTP id a16mr13485447otq.88.1605020400487;
        Tue, 10 Nov 2020 07:00:00 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id a21sm1191038otr.36.2020.11.10.06.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:59:59 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 2/2] bitbake: hashserve: Add support for readonly upstream
Date: Tue, 10 Nov 2020 08:59:56 -0600
Message-Id: <20201110145956.1518964-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110145956.1518964-1-JPEWhacker@gmail.com>
References: <20201110145956.1518964-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds support for an upstream server to be specified. The upstream server
will be queried for equivalent hashes whenever a miss is found in the
local server. If the server returns a match, it is merged into the
local database. In order to keep the get stream queries as fast as
possible since they are the critical path when bitbake is preparing the
run queue, missing tasks provided by the server are not immediately
pulled from the upstream server, but instead are put into a queue to be
backfilled by a worker task later.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/__init__.py |  39 ++++----
 bitbake/lib/hashserv/client.py   |  19 ++--
 bitbake/lib/hashserv/server.py   | 149 ++++++++++++++++++++++++-------
 bitbake/lib/hashserv/tests.py    | 147 +++++++++++++++++++++++-------
 4 files changed, 268 insertions(+), 86 deletions(-)

diff --git a/bitbake/lib/hashserv/__init__.py b/bitbake/lib/hashserv/__init__.py
index 622ca17a91..55f48410d3 100644
--- a/bitbake/lib/hashserv/__init__.py
+++ b/bitbake/lib/hashserv/__init__.py
@@ -22,6 +22,24 @@ ADDR_TYPE_TCP = 1
 # is necessary
 DEFAULT_MAX_CHUNK = 32 * 1024
 
+TABLE_DEFINITION = (
+    ("method", "TEXT NOT NULL"),
+    ("outhash", "TEXT NOT NULL"),
+    ("taskhash", "TEXT NOT NULL"),
+    ("unihash", "TEXT NOT NULL"),
+    ("created", "DATETIME"),
+
+    # Optional fields
+    ("owner", "TEXT"),
+    ("PN", "TEXT"),
+    ("PV", "TEXT"),
+    ("PR", "TEXT"),
+    ("task", "TEXT"),
+    ("outhash_siginfo", "TEXT"),
+)
+
+TABLE_COLUMNS = tuple(name for name, _ in TABLE_DEFINITION)
+
 def setup_database(database, sync=True):
     db = sqlite3.connect(database)
     db.row_factory = sqlite3.Row
@@ -30,23 +48,10 @@ def setup_database(database, sync=True):
         cursor.execute('''
             CREATE TABLE IF NOT EXISTS tasks_v2 (
                 id INTEGER PRIMARY KEY AUTOINCREMENT,
-                method TEXT NOT NULL,
-                outhash TEXT NOT NULL,
-                taskhash TEXT NOT NULL,
-                unihash TEXT NOT NULL,
-                created DATETIME,
-
-                -- Optional fields
-                owner TEXT,
-                PN TEXT,
-                PV TEXT,
-                PR TEXT,
-                task TEXT,
-                outhash_siginfo TEXT,
-
+                %s
                 UNIQUE(method, outhash, taskhash)
                 )
-            ''')
+            ''' % " ".join("%s %s," % (name, typ) for name, typ in TABLE_DEFINITION))
         cursor.execute('PRAGMA journal_mode = WAL')
         cursor.execute('PRAGMA synchronous = %s' % ('NORMAL' if sync else 'OFF'))
 
@@ -89,10 +94,10 @@ def chunkify(msg, max_chunk):
         yield "\n"
 
 
-def create_server(addr, dbname, *, sync=True):
+def create_server(addr, dbname, *, sync=True, upstream=None):
     from . import server
     db = setup_database(dbname, sync=sync)
-    s = server.Server(db)
+    s = server.Server(db, upstream=upstream)
 
     (typ, a) = parse_address(addr)
     if typ == ADDR_TYPE_UNIX:
diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index d0b3cf3863..ae5875d1b3 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -178,18 +178,16 @@ class AsyncClient(object):
         await self._set_mode(self.MODE_NORMAL)
         return await self.send_message({"reset-stats": None})
 
+    async def backfill_wait(self):
+        await self._set_mode(self.MODE_NORMAL)
+        return (await self.send_message({"backfill-wait": None}))["tasks"]
+
 
 class Client(object):
     def __init__(self):
         self.client = AsyncClient()
         self.loop = asyncio.new_event_loop()
 
-        def get_wrapper(self, downcall):
-            def wrapper(*args, **kwargs):
-                return self.loop.run_until_complete(downcall(*args, **kwargs))
-
-            return wrapper
-
         for call in (
             "connect_tcp",
             "connect_unix",
@@ -200,9 +198,16 @@ class Client(object):
             "get_taskhash",
             "get_stats",
             "reset_stats",
+            "backfill_wait",
         ):
             downcall = getattr(self.client, call)
-            setattr(self, call, get_wrapper(self, downcall))
+            setattr(self, call, self._get_downcall_wrapper(downcall))
+
+    def _get_downcall_wrapper(self, downcall):
+        def wrapper(*args, **kwargs):
+            return self.loop.run_until_complete(downcall(*args, **kwargs))
+
+        return wrapper
 
     @property
     def max_chunk(self):
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index 81050715ea..3ff4c51ccb 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -3,7 +3,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-from contextlib import closing
+from contextlib import closing, contextmanager
 from datetime import datetime
 import asyncio
 import json
@@ -12,8 +12,9 @@ import math
 import os
 import signal
 import socket
+import sys
 import time
-from . import chunkify, DEFAULT_MAX_CHUNK
+from . import chunkify, DEFAULT_MAX_CHUNK, create_async_client, TABLE_COLUMNS
 
 logger = logging.getLogger('hashserv.server')
 
@@ -111,16 +112,40 @@ class Stats(object):
 class ClientError(Exception):
     pass
 
+def insert_task(cursor, data, ignore=False):
+    keys = sorted(data.keys())
+    query = '''INSERT%s INTO tasks_v2 (%s) VALUES (%s)''' % (
+        " OR IGNORE" if ignore else "",
+        ', '.join(keys),
+        ', '.join(':' + k for k in keys))
+    cursor.execute(query, data)
+
+async def copy_from_upstream(client, db, method, taskhash):
+    d = await client.get_taskhash(method, taskhash, True)
+    if d is not None:
+        # Filter out unknown columns
+        d = {k: v for k, v in d.items() if k in TABLE_COLUMNS}
+        keys = sorted(d.keys())
+
+
+        with closing(db.cursor()) as cursor:
+            insert_task(cursor, d)
+            db.commit()
+
+    return d
+
 class ServerClient(object):
     FAST_QUERY = 'SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
     ALL_QUERY =  'SELECT *                         FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
 
-    def __init__(self, reader, writer, db, request_stats):
+    def __init__(self, reader, writer, db, request_stats, backfill_queue, upstream):
         self.reader = reader
         self.writer = writer
         self.db = db
         self.request_stats = request_stats
         self.max_chunk = DEFAULT_MAX_CHUNK
+        self.backfill_queue = backfill_queue
+        self.upstream = upstream
 
         self.handlers = {
             'get': self.handle_get,
@@ -130,10 +155,18 @@ class ServerClient(object):
             'get-stats': self.handle_get_stats,
             'reset-stats': self.handle_reset_stats,
             'chunk-stream': self.handle_chunk,
+            'backfill-wait': self.handle_backfill_wait,
         }
 
     async def process_requests(self):
+        if self.upstream is not None:
+            self.upstream_client = await create_async_client(self.upstream)
+        else:
+            self.upstream_client = None
+
         try:
+
+
             self.addr = self.writer.get_extra_info('peername')
             logger.debug('Client %r connected' % (self.addr,))
 
@@ -171,6 +204,9 @@ class ServerClient(object):
         except ClientError as e:
             logger.error(str(e))
         finally:
+            if self.upstream_client is not None:
+                await self.upstream_client.close()
+
             self.writer.close()
 
     async def dispatch_message(self, msg):
@@ -239,15 +275,19 @@ class ServerClient(object):
         if row is not None:
             logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
             d = {k: row[k] for k in row.keys()}
-
-            self.write_message(d)
+        elif self.upstream_client is not None:
+            d = await copy_from_upstream(self.upstream_client, self.db, method, taskhash)
         else:
-            self.write_message(None)
+            d = None
+
+        self.write_message(d)
 
     async def handle_get_stream(self, request):
         self.write_message('ok')
 
         while True:
+            upstream = None
+
             l = await self.reader.readline()
             if not l:
                 return
@@ -272,6 +312,12 @@ class ServerClient(object):
                 if row is not None:
                     msg = ('%s\n' % row['unihash']).encode('utf-8')
                     #logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
+                elif self.upstream_client is not None:
+                    upstream = await self.upstream_client.get_unihash(method, taskhash)
+                    if upstream:
+                        msg = ("%s\n" % upstream).encode("utf-8")
+                    else:
+                        msg = "\n".encode("utf-8")
                 else:
                     msg = '\n'.encode('utf-8')
 
@@ -282,6 +328,11 @@ class ServerClient(object):
 
             await self.writer.drain()
 
+            # Post to the backfill queue after writing the result to minimize
+            # the turn around time on a request
+            if upstream is not None:
+                await self.backfill_queue.put((method, taskhash))
+
     async def handle_report(self, data):
         with closing(self.db.cursor()) as cursor:
             cursor.execute('''
@@ -324,11 +375,7 @@ class ServerClient(object):
                     if k in data:
                         insert_data[k] = data[k]
 
-                cursor.execute('''INSERT INTO tasks_v2 (%s) VALUES (%s)''' % (
-                    ', '.join(sorted(insert_data.keys())),
-                    ', '.join(':' + k for k in sorted(insert_data.keys()))),
-                    insert_data)
-
+                insert_task(cursor, insert_data)
                 self.db.commit()
 
                 logger.info('Adding taskhash %s with unihash %s',
@@ -358,11 +405,7 @@ class ServerClient(object):
                 if k in data:
                     insert_data[k] = data[k]
 
-            cursor.execute('''INSERT OR IGNORE INTO tasks_v2 (%s) VALUES (%s)''' % (
-                ', '.join(sorted(insert_data.keys())),
-                ', '.join(':' + k for k in sorted(insert_data.keys()))),
-                insert_data)
-
+            insert_task(cursor, insert_data, ignore=True)
             self.db.commit()
 
             # Fetch the unihash that will be reported for the taskhash. If the
@@ -394,6 +437,13 @@ class ServerClient(object):
         self.request_stats.reset()
         self.write_message(d)
 
+    async def handle_backfill_wait(self, request):
+        d = {
+            'tasks': self.backfill_queue.qsize(),
+        }
+        await self.backfill_queue.join()
+        self.write_message(d)
+
     def query_equivalent(self, method, taskhash, query):
         # This is part of the inner loop and must be as fast as possible
         try:
@@ -405,7 +455,7 @@ class ServerClient(object):
 
 
 class Server(object):
-    def __init__(self, db, loop=None):
+    def __init__(self, db, loop=None, upstream=None):
         self.request_stats = Stats()
         self.db = db
 
@@ -416,6 +466,8 @@ class Server(object):
             self.loop = loop
             self.close_loop = False
 
+        self.upstream = upstream
+
         self._cleanup_socket = None
 
     def start_tcp_server(self, host, port):
@@ -458,7 +510,7 @@ class Server(object):
     async def handle_client(self, reader, writer):
         # writer.transport.set_write_buffer_limits(0)
         try:
-            client = ServerClient(reader, writer, self.db, self.request_stats)
+            client = ServerClient(reader, writer, self.db, self.request_stats, self.backfill_queue, self.upstream)
             await client.process_requests()
         except Exception as e:
             import traceback
@@ -467,23 +519,60 @@ class Server(object):
             writer.close()
         logger.info('Client disconnected')
 
+    @contextmanager
+    def _backfill_worker(self):
+        async def backfill_worker_task():
+            client = await create_async_client(self.upstream)
+            try:
+                while True:
+                    item = await self.backfill_queue.get()
+                    if item is None:
+                        self.backfill_queue.task_done()
+                        break
+                    method, taskhash = item
+                    await copy_from_upstream(client, self.db, method, taskhash)
+                    self.backfill_queue.task_done()
+            finally:
+                await client.close()
+
+        async def join_worker(worker):
+            await self.backfill_queue.put(None)
+            await worker
+
+        if self.upstream is not None:
+            worker = asyncio.ensure_future(backfill_worker_task())
+            try:
+                yield
+            finally:
+                self.loop.run_until_complete(join_worker(worker))
+        else:
+            yield
+
     def serve_forever(self):
         def signal_handler():
             self.loop.stop()
 
-        self.loop.add_signal_handler(signal.SIGTERM, signal_handler)
-
+        asyncio.set_event_loop(self.loop)
         try:
-            self.loop.run_forever()
-        except KeyboardInterrupt:
-            pass
+            self.backfill_queue = asyncio.Queue()
+
+            self.loop.add_signal_handler(signal.SIGTERM, signal_handler)
 
-        self.server.close()
-        self.loop.run_until_complete(self.server.wait_closed())
-        logger.info('Server shutting down')
+            with self._backfill_worker():
+                try:
+                    self.loop.run_forever()
+                except KeyboardInterrupt:
+                    pass
 
-        if self.close_loop:
-            self.loop.close()
+                self.server.close()
+
+            self.loop.run_until_complete(self.server.wait_closed())
+            logger.info('Server shutting down')
+        finally:
+            if self.close_loop:
+                if sys.version_info >= (3, 6):
+                    self.loop.run_until_complete(self.loop.shutdown_asyncgens())
+                self.loop.close()
 
-        if self._cleanup_socket is not None:
-            self._cleanup_socket()
+            if self._cleanup_socket is not None:
+                self._cleanup_socket()
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index 4566f24738..3dd9a31bee 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -16,35 +16,54 @@ import threading
 import unittest
 import socket
 
+def _run_server(server, idx):
+    # logging.basicConfig(level=logging.DEBUG, filename='bbhashserv.log', filemode='w',
+    #                     format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
+    sys.stdout = open('bbhashserv-%d.log' % idx, 'w')
+    sys.stderr = sys.stdout
+    server.serve_forever()
 
 class TestHashEquivalenceServer(object):
     METHOD = 'TestMethod'
 
-    def _run_server(self):
-        # logging.basicConfig(level=logging.DEBUG, filename='bbhashserv.log', filemode='w',
-        #                     format='%(levelname)s %(filename)s:%(lineno)d %(message)s')
-        self.server.serve_forever()
+    server_index = 0
+
+    def start_server(self, dbpath=None, upstream=None):
+        self.server_index += 1
+        if dbpath is None:
+            dbpath = os.path.join(self.temp_dir.name, "db%d.sqlite" % self.server_index)
+
+        def cleanup_thread(thread):
+            thread.terminate()
+            thread.join()
+
+        server = create_server(self.get_server_addr(self.server_index), dbpath, upstream=upstream)
+        server.dbpath = dbpath
+
+        server.thread = multiprocessing.Process(target=_run_server, args=(server, self.server_index))
+        server.thread.start()
+        self.addCleanup(cleanup_thread, server.thread)
+
+        def cleanup_client(client):
+            client.close()
+
+        client = create_client(server.address)
+        self.addCleanup(cleanup_client, client)
+
+        return (client, server)
 
     def setUp(self):
         if sys.version_info < (3, 5, 0):
             self.skipTest('Python 3.5 or later required')
 
         self.temp_dir = tempfile.TemporaryDirectory(prefix='bb-hashserv')
-        self.dbfile = os.path.join(self.temp_dir.name, 'db.sqlite')
-
-        self.server = create_server(self.get_server_addr(), self.dbfile)
-        self.server_thread = multiprocessing.Process(target=self._run_server)
-        self.server_thread.start()
-        self.client = create_client(self.server.address)
-
-    def tearDown(self):
-        # Shutdown server
-        s = getattr(self, 'server', None)
-        if s is not None:
-            self.server_thread.terminate()
-            self.server_thread.join()
-        self.client.close()
-        self.temp_dir.cleanup()
+        self.addCleanup(self.temp_dir.cleanup)
+
+        (self.client, self.server) = self.start_server()
+
+    def assertClientGetHash(self, client, taskhash, unihash):
+        result = client.get_unihash(self.METHOD, taskhash)
+        self.assertEqual(result, unihash)
 
     def test_create_hash(self):
         # Simple test that hashes can be created
@@ -52,8 +71,7 @@ class TestHashEquivalenceServer(object):
         outhash = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
         unihash = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
 
-        result = self.client.get_unihash(self.METHOD, taskhash)
-        self.assertIsNone(result, msg='Found unexpected task, %r' % result)
+        self.assertClientGetHash(self.client, taskhash, None)
 
         result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
@@ -84,22 +102,19 @@ class TestHashEquivalenceServer(object):
         unihash = '218e57509998197d570e2c98512d0105985dffc9'
         self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
 
-        result = self.client.get_unihash(self.METHOD, taskhash)
-        self.assertEqual(result, unihash)
+        self.assertClientGetHash(self.client, taskhash, unihash)
 
         outhash2 = '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d'
         unihash2 = 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'
         self.client.report_unihash(taskhash, self.METHOD, outhash2, unihash2)
 
-        result = self.client.get_unihash(self.METHOD, taskhash)
-        self.assertEqual(result, unihash)
+        self.assertClientGetHash(self.client, taskhash, unihash)
 
         outhash3 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
         unihash3 = '9217a7d6398518e5dc002ed58f2cbbbc78696603'
         self.client.report_unihash(taskhash, self.METHOD, outhash3, unihash3)
 
-        result = self.client.get_unihash(self.METHOD, taskhash)
-        self.assertEqual(result, unihash)
+        self.assertClientGetHash(self.client, taskhash, unihash)
 
     def test_huge_message(self):
         # Simple test that hashes can be created
@@ -107,8 +122,7 @@ class TestHashEquivalenceServer(object):
         outhash = '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076f5b14f7d39db44'
         unihash = '90e9bc1d1f094c51824adca7f8ea79a048d68824'
 
-        result = self.client.get_unihash(self.METHOD, taskhash)
-        self.assertIsNone(result, msg='Found unexpected task, %r' % result)
+        self.assertClientGetHash(self.client, taskhash, None)
 
         siginfo = "0" * (self.client.max_chunk * 4)
 
@@ -156,14 +170,83 @@ class TestHashEquivalenceServer(object):
 
         self.assertFalse(failures)
 
+    def test_upstream_server(self):
+        # Tests upstream server support. This is done by creating two servers
+        # that share a database file. The downstream server has it upstream
+        # set to the test server, whereas the side server doesn't. This allows
+        # verification that the hash requests are being proxied to the upstream
+        # server by verifying that they appear on the downstream client, but not
+        # the side client. It also verifies that the results are pulled into
+        # the downstream database by checking that the downstream and side servers
+        # match after the downstream is done waiting for all backfill tasks
+        (down_client, down_server) = self.start_server(upstream=self.server.address)
+        (side_client, side_server) = self.start_server(dbpath=down_server.dbpath)
+
+        def check_hash(taskhash, unihash, old_sidehash):
+            nonlocal down_client
+            nonlocal side_client
+
+            # check upstream server
+            self.assertClientGetHash(self.client, taskhash, unihash)
+
+            # Hash should *not* be present on the side server
+            self.assertClientGetHash(side_client, taskhash, old_sidehash)
+
+            # Hash should be present on the downstream server, since it
+            # will defer to the upstream server. This will trigger
+            # the backfill in the downstream server
+            self.assertClientGetHash(down_client, taskhash, unihash)
+
+            # After waiting for the downstream client to finish backfilling the
+            # task from the upstream server, it should appear in the side server
+            # since the database is populated
+            down_client.backfill_wait()
+            self.assertClientGetHash(side_client, taskhash, unihash)
+
+        # Basic report
+        taskhash = '8aa96fcffb5831b3c2c0cb75f0431e3f8b20554a'
+        outhash = 'afe240a439959ce86f5e322f8c208e1fedefea9e813f2140c81af866cc9edf7e'
+        unihash = '218e57509998197d570e2c98512d0105985dffc9'
+        self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+
+        check_hash(taskhash, unihash, None)
+
+        # Duplicated taskhash with multiple output hashes and unihashes.
+        # All servers should agree with the originally reported hash
+        outhash2 = '0904a7fe3dc712d9fd8a74a616ddca2a825a8ee97adf0bd3fc86082c7639914d'
+        unihash2 = 'ae9a7d252735f0dafcdb10e2e02561ca3a47314c'
+        self.client.report_unihash(taskhash, self.METHOD, outhash2, unihash2)
+
+        check_hash(taskhash, unihash, unihash)
+
+        # Report an equivalent task. The sideload will originally report
+        # no unihash until backfilled
+        taskhash3 = "044c2ec8aaf480685a00ff6ff49e6162e6ad34e1"
+        unihash3 = "def64766090d28f627e816454ed46894bb3aab36"
+        self.client.report_unihash(taskhash3, self.METHOD, outhash, unihash3)
+
+        check_hash(taskhash3, unihash, None)
+
+        # Test that reporting a unihash in the downstream client isn't
+        # propagating to the upstream server
+        taskhash4 = "e3da00593d6a7fb435c7e2114976c59c5fd6d561"
+        outhash4 = "1cf8713e645f491eb9c959d20b5cae1c47133a292626dda9b10709857cbe688a"
+        unihash4 = "3b5d3d83f07f259e9086fcb422c855286e18a57d"
+        down_client.report_unihash(taskhash4, self.METHOD, outhash4, unihash4)
+        down_client.backfill_wait()
+
+        self.assertClientGetHash(down_client, taskhash4, unihash4)
+        self.assertClientGetHash(side_client, taskhash4, unihash4)
+        self.assertClientGetHash(self.client, taskhash4, None)
+
 
 class TestHashEquivalenceUnixServer(TestHashEquivalenceServer, unittest.TestCase):
-    def get_server_addr(self):
-        return "unix://" + os.path.join(self.temp_dir.name, 'sock')
+    def get_server_addr(self, server_idx):
+        return "unix://" + os.path.join(self.temp_dir.name, 'sock%d' % server_idx)
 
 
 class TestHashEquivalenceTCPServer(TestHashEquivalenceServer, unittest.TestCase):
-    def get_server_addr(self):
+    def get_server_addr(self, server_idx):
         # Some hosts cause asyncio module to misbehave, when IPv6 is not enabled.
         # If IPv6 is enabled, it should be safe to use localhost directly, in general
         # case it is more reliable to resolve the IP address explicitly.
-- 
2.29.2

