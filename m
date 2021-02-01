Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.32770.1612180419859379180
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:53:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZvFv05RL;
 spf=pass (domain: konsulko.com, ip: 209.85.221.41, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f41.google.com with SMTP id 7so16276085wrz.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Feb 2021 03:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iH3JVZoPqfJr1nsd/Q3TKhNrhXruLWwQoLaPE+fsH9w=;
        b=ZvFv05RL4skzEidrK3hKbmAeQPVg2atDpspVY7Xpd6xSfTcjL8Kni4xSaPFpHer4ne
         DvlVxQ0FWwpdeTE29/P4kuhDDUFvrBI9tvGHZDnoZR1/EdyT+5SFyb6T9nG1e6Ecf67F
         cE/jgxkkxT+eLg1BH1NAMK9FvbMqnbDH+d+xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iH3JVZoPqfJr1nsd/Q3TKhNrhXruLWwQoLaPE+fsH9w=;
        b=geKR6SAJXwmGs4Ppi22J7tjPm/qWUa+x+Up6TAzoVLy1WFfnNwr9h/j+fk0rvQCKR5
         bi7fAODlv7xCU3ubL2aDvuYMQqsw6U6wyC24SefV3DYLe2Hui87Lvlhc3sJCfzkCwvfh
         yoGypN/zrdnQgfoTIRns6tZn5M0VhWSh4ZkFid4ONrZ6dsm7yDCBH9TrsK8Xalofn80B
         Wasb0JWcYufn4g1mFatSj536K1gpXeQhH/4vKNApb0BOr66S8A2tZZouHAdAkbElZGSd
         X+fIEY75U0M0MGWmE9cwU+OM6gOASppb1XIKkLmPvS1SCa5ooIFKTmko28Zy/Z5qAgic
         DxaA==
X-Gm-Message-State: AOAM533yZXb8hik0ELMCcotMAgjpRI3sUM8CFOoweOERcPzQfbcMaLi9
	9ZKuUO+bMsHrSDBdFARSsViz8k630Wlep5OZ
X-Google-Smtp-Source: ABdhPJzAi5a2TNLi5HVYrRtvMUAnVZUJh3gjs4X9ObuzxBxBKo+DfwbSgwyEsD8n1NrJ7f6dqxK7+w==
X-Received: by 2002:adf:8295:: with SMTP id 21mr17540890wrc.32.1612180418211;
        Mon, 01 Feb 2021 03:53:38 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id u6sm28120514wro.75.2021.02.01.03.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:53:37 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 4/8] hashserv: Support read-only server
Date: Mon,  1 Feb 2021 11:53:27 +0000
Message-Id: <20210201115331.13510-5-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201115331.13510-1-pbarker@konsulko.com>
References: <20210201115331.13510-1-pbarker@konsulko.com>
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
 3 files changed, 22 insertions(+), 10 deletions(-)

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
-- 
2.26.2

