Received: from tortoise.home.b5net.uk (tortoise.home.b5net.uk [80.7.160.81])
 by mx.groups.io with SMTP id smtpd.web10.32504.1612179954061990392
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:45:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: tortoise.home.b5net.uk, ip: 80.7.160.81, mailfrom: pbarker@tortoise.home.b5net.uk)
Received: by tortoise.home.b5net.uk (Postfix, from userid 1000)
	id 0555C5BBD; Mon,  1 Feb 2021 11:45:52 +0000 (GMT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 4/8] hashserv: Support read-only server
Date: Mon,  1 Feb 2021 11:45:47 +0000
Message-Id: <20210201114551.11475-5-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201114551.11475-1-pbarker@konsulko.com>
References: <20210201114551.11475-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
     parser.add_argument('--bind', default=3DDEFAULT_BIND, help=3D'Bind a=
ddress (default "%(default)s")')
     parser.add_argument('--database', default=3D'./hashserv.db', help=3D=
'Database file (default "%(default)s")')
     parser.add_argument('--log', default=3D'WARNING', help=3D'Set loggin=
g level')
+    parser.add_argument('-r', '--read-only', action=3D'store_true', help=
=3D'Disallow write operations from clients')
=20
     args =3D parser.parse_args()
=20
@@ -47,7 +48,7 @@ def main():
     console.setLevel(level)
     logger.addHandler(console)
=20
-    server =3D hashserv.create_server(args.bind, args.database)
+    server =3D hashserv.create_server(args.bind, args.database, read_onl=
y=3Dargs.read_only)
     server.serve_forever()
     return 0
=20
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 55f48410d..5f2e101e5 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -94,10 +94,10 @@ def chunkify(msg, max_chunk):
         yield "\n"
=20
=20
-def create_server(addr, dbname, *, sync=3DTrue, upstream=3DNone):
+def create_server(addr, dbname, *, sync=3DTrue, upstream=3DNone, read_on=
ly=3DFalse):
     from . import server
     db =3D setup_database(dbname, sync=3Dsync)
-    s =3D server.Server(db, upstream=3Dupstream)
+    s =3D server.Server(db, upstream=3Dupstream, read_only=3Dread_only)
=20
     (typ, a) =3D parse_address(addr)
     if typ =3D=3D ADDR_TYPE_UNIX:
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index fa0d3410b..b1e8b2f89 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -112,6 +112,9 @@ class Stats(object):
 class ClientError(Exception):
     pass
=20
+class ServerError(Exception):
+    pass
+
 def insert_task(cursor, data, ignore=3DFalse):
     keys =3D sorted(data.keys())
     query =3D '''INSERT%s INTO tasks_v2 (%s) VALUES (%s)''' % (
@@ -138,7 +141,7 @@ class ServerClient(object):
     FAST_QUERY =3D 'SELECT taskhash, method, unihash FROM tasks_v2 WHERE=
 method=3D:method AND taskhash=3D:taskhash ORDER BY created ASC LIMIT 1'
     ALL_QUERY =3D  'SELECT *                         FROM tasks_v2 WHERE=
 method=3D:method AND taskhash=3D:taskhash ORDER BY created ASC LIMIT 1'
=20
-    def __init__(self, reader, writer, db, request_stats, backfill_queue=
, upstream):
+    def __init__(self, reader, writer, db, request_stats, backfill_queue=
, upstream, read_only):
         self.reader =3D reader
         self.writer =3D writer
         self.db =3D db
@@ -149,15 +152,19 @@ class ServerClient(object):
=20
         self.handlers =3D {
             'get': self.handle_get,
-            'report': self.handle_report,
-            'report-equiv': self.handle_equivreport,
             'get-stream': self.handle_get_stream,
             'get-stats': self.handle_get_stats,
-            'reset-stats': self.handle_reset_stats,
             'chunk-stream': self.handle_chunk,
-            'backfill-wait': self.handle_backfill_wait,
         }
=20
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
             self.upstream_client =3D await create_async_client(self.upst=
ream)
@@ -455,7 +462,10 @@ class ServerClient(object):
=20
=20
 class Server(object):
-    def __init__(self, db, loop=3DNone, upstream=3DNone):
+    def __init__(self, db, loop=3DNone, upstream=3DNone, read_only=3DFal=
se):
+        if upstream and read_only:
+            raise ServerError("Read-only hashserv cannot pull from an up=
stream server")
+
         self.request_stats =3D Stats()
         self.db =3D db
=20
@@ -467,6 +477,7 @@ class Server(object):
             self.close_loop =3D False
=20
         self.upstream =3D upstream
+        self.read_only =3D read_only
=20
         self._cleanup_socket =3D None
=20
@@ -510,7 +521,7 @@ class Server(object):
     async def handle_client(self, reader, writer):
         # writer.transport.set_write_buffer_limits(0)
         try:
-            client =3D ServerClient(reader, writer, self.db, self.reques=
t_stats, self.backfill_queue, self.upstream)
+            client =3D ServerClient(reader, writer, self.db, self.reques=
t_stats, self.backfill_queue, self.upstream, self.read_only)
             await client.process_requests()
         except Exception as e:
             import traceback
--=20
2.26.2

