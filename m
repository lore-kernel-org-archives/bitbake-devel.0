Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web12.6800.1612524381327906604
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 03:26:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=o4hhbGIy;
 spf=pass (domain: konsulko.com, ip: 209.85.128.44, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f44.google.com with SMTP id w4so5724023wmi.4
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 03:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tuovCvmKizDcsEz7dWjcyWcV6h1TENxlp+xQIudgio8=;
        b=o4hhbGIyVVHHyBxRWJUcfjdqzktxFM/E+tAjW6gGr1wIKStQyQ3ZKgwjKMJYkMgSaV
         TxObm1Zl69Z2RSQWlKAtKei2q+OW8W7TbaZ3b5EhQuJZKuer9JLl231woq4TnXHdfF8+
         tMwScedVc8wG2+6bomGudv8VDmWQZqq9fLMWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tuovCvmKizDcsEz7dWjcyWcV6h1TENxlp+xQIudgio8=;
        b=XEhwZ7e+L1N7cbbDi/yPRlZd1joktn8dMdHCYo4//LG5J2SFKLBLLQfuk1fdWfGCWT
         wvD2z3y+lv8yq9SHX2AOodLPTozUho9iL9wHeBh8iPuxy6I8+gaSeQfaCE2LjiHRTBKf
         8owVRfmWkVUiaAlqQ5C/HdSCEsrPScOy/sC4HqUgqUl/s4YDDguiIjnAtFuTOM8/sVXe
         ppPNKhSeOMYl83NMUxxSN2jKonZsxRefoc18nPgTH3AH8wHN5OXFu2XbHZKTenwky24E
         Zw1eFzMbED/63ejO6HMDLRbHI+8yyH7HJvy0ZlzEkW9HfG6+qRNabVWUj87mfuP/T5SJ
         MPcw==
X-Gm-Message-State: AOAM5318K+ImSy6AEdrhWTLFtlaX81L8cORdYnuAuegikfQ8nhTVf4F1
	UAbGZD9+RJirksFhCH/fE6DKFFmCEC54Q3MY
X-Google-Smtp-Source: ABdhPJw+N2//lrfBYqJhHeJ2ishcc6NzcRktDwEqPd3RryzreDRp+IXhEk1q36E2q4xTk2WNmeAuUA==
X-Received: by 2002:a1c:9845:: with SMTP id a66mr3075141wme.121.1612524379488;
        Fri, 05 Feb 2021 03:26:19 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y18sm11881716wrt.19.2021.02.05.03.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:26:18 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 4/8] hashserv: Support read-only server
Date: Fri,  5 Feb 2021 11:26:07 +0000
Message-Id: <20210205112611.17167-5-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205112611.17167-1-pbarker@konsulko.com>
References: <20210205112611.17167-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -r/--readonly argument is added to the bitbake-hashserv app. If this
argument is given then clients may only perform read operations against
the server. The read-only mode is implemented by simply not installing
handlers for write operations, this keeps the permission model simple
and reduces the risk of accidentally allowing write operations.

As a sqlite database can be safely opened by multiple processes in
parallel, it's possible to start two hashserv instances against a single
database if you wish to export both a read-only port and a read-write
port.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 bin/bitbake-hashserv     |  3 ++-
 lib/hashserv/__init__.py |  4 ++--
 lib/hashserv/server.py   | 25 ++++++++++++++++++-------
 lib/hashserv/tests.py    | 33 +++++++++++++++++++++++++++++++--
 4 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index 1bc1f91f3..2669bbd13 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -33,6 +33,7 @@ def main():
     parser.add_argument('--bind', default=DEFAULT_BIND, help='Bind address (default "%(default)s")')
     parser.add_argument('--database', default='./hashserv.db', help='Database file (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
+    parser.add_argument('-r', '--read-only', action='store_true', help='Disallow write operations from clients')
 
     args = parser.parse_args()
 
@@ -47,7 +48,7 @@ def main():
     console.setLevel(level)
     logger.addHandler(console)
 
-    server = hashserv.create_server(args.bind, args.database)
+    server = hashserv.create_server(args.bind, args.database, read_only=args.read_only)
     server.serve_forever()
     return 0
 
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 55f48410d..5f2e101e5 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -94,10 +94,10 @@ def chunkify(msg, max_chunk):
         yield "\n"
 
 
-def create_server(addr, dbname, *, sync=True, upstream=None):
+def create_server(addr, dbname, *, sync=True, upstream=None, read_only=False):
     from . import server
     db = setup_database(dbname, sync=sync)
-    s = server.Server(db, upstream=upstream)
+    s = server.Server(db, upstream=upstream, read_only=read_only)
 
     (typ, a) = parse_address(addr)
     if typ == ADDR_TYPE_UNIX:
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index fa0d3410b..b1e8b2f89 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -112,6 +112,9 @@ class Stats(object):
 class ClientError(Exception):
     pass
 
+class ServerError(Exception):
+    pass
+
 def insert_task(cursor, data, ignore=False):
     keys = sorted(data.keys())
     query = '''INSERT%s INTO tasks_v2 (%s) VALUES (%s)''' % (
@@ -138,7 +141,7 @@ class ServerClient(object):
     FAST_QUERY = 'SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
     ALL_QUERY =  'SELECT *                         FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
 
-    def __init__(self, reader, writer, db, request_stats, backfill_queue, upstream):
+    def __init__(self, reader, writer, db, request_stats, backfill_queue, upstream, read_only):
         self.reader = reader
         self.writer = writer
         self.db = db
@@ -149,15 +152,19 @@ class ServerClient(object):
 
         self.handlers = {
             'get': self.handle_get,
-            'report': self.handle_report,
-            'report-equiv': self.handle_equivreport,
             'get-stream': self.handle_get_stream,
             'get-stats': self.handle_get_stats,
-            'reset-stats': self.handle_reset_stats,
             'chunk-stream': self.handle_chunk,
-            'backfill-wait': self.handle_backfill_wait,
         }
 
+        if not read_only:
+            self.handlers.update({
+                'report': self.handle_report,
+                'report-equiv': self.handle_equivreport,
+                'reset-stats': self.handle_reset_stats,
+                'backfill-wait': self.handle_backfill_wait,
+            })
+
     async def process_requests(self):
         if self.upstream is not None:
             self.upstream_client = await create_async_client(self.upstream)
@@ -455,7 +462,10 @@ class ServerClient(object):
 
 
 class Server(object):
-    def __init__(self, db, loop=None, upstream=None):
+    def __init__(self, db, loop=None, upstream=None, read_only=False):
+        if upstream and read_only:
+            raise ServerError("Read-only hashserv cannot pull from an upstream server")
+
         self.request_stats = Stats()
         self.db = db
 
@@ -467,6 +477,7 @@ class Server(object):
             self.close_loop = False
 
         self.upstream = upstream
+        self.read_only = read_only
 
         self._cleanup_socket = None
 
@@ -510,7 +521,7 @@ class Server(object):
     async def handle_client(self, reader, writer):
         # writer.transport.set_write_buffer_limits(0)
         try:
-            client = ServerClient(reader, writer, self.db, self.request_stats, self.backfill_queue, self.upstream)
+            client = ServerClient(reader, writer, self.db, self.request_stats, self.backfill_queue, self.upstream, self.read_only)
             await client.process_requests()
         except Exception as e:
             import traceback
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 77a19b807..6f04e30d6 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -6,6 +6,7 @@
 #
 
 from . import create_server, create_client
+from .client import HashConnectionError
 import hashlib
 import logging
 import multiprocessing
@@ -29,7 +30,7 @@ class HashEquivalenceTestSetup(object):
 
     server_index = 0
 
-    def start_server(self, dbpath=None, upstream=None):
+    def start_server(self, dbpath=None, upstream=None, read_only=False):
         self.server_index += 1
         if dbpath is None:
             dbpath = os.path.join(self.temp_dir.name, "db%d.sqlite" % self.server_index)
@@ -38,7 +39,10 @@ class HashEquivalenceTestSetup(object):
             thread.terminate()
             thread.join()
 
-        server = create_server(self.get_server_addr(self.server_index), dbpath, upstream=upstream)
+        server = create_server(self.get_server_addr(self.server_index),
+                               dbpath,
+                               upstream=upstream,
+                               read_only=read_only)
         server.dbpath = dbpath
 
         server.thread = multiprocessing.Process(target=_run_server, args=(server, self.server_index))
@@ -242,6 +246,31 @@ class HashEquivalenceCommonTests(object):
         self.assertClientGetHash(side_client, taskhash4, unihash4)
         self.assertClientGetHash(self.client, taskhash4, None)
 
+    def test_ro_server(self):
+        (ro_client, ro_server) = self.start_server(dbpath=self.server.dbpath, read_only=True)
+
+        # Report a hash via the read-write server
+        taskhash = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
+        outhash = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
+        unihash = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+
+        result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+        self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
+
+        # Check the hash via the read-only server
+        self.assertClientGetHash(ro_client, taskhash, unihash)
+
+        # Ensure that reporting via the read-only server fails
+        taskhash2 = 'c665584ee6817aa99edfc77a44dd853828279370'
+        outhash2 = '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076f5b14f7d39db44'
+        unihash2 = '90e9bc1d1f094c51824adca7f8ea79a048d68824'
+
+        with self.assertRaises(HashConnectionError):
+            ro_client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
+
+        # Ensure that the database was not modified
+        self.assertClientGetHash(self.client, taskhash2, None)
+
 
 class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def get_server_addr(self, server_idx):
-- 
2.26.2

