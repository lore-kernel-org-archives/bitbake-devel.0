Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5220C48BC4
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 23:00:15 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
 by mx.groups.io with SMTP id smtpd.web10.29042.1708297207051272272
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 15:00:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h99oRWV5;
 spf=pass (domain: gmail.com, ip: 209.85.166.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7bed9fb159fso186861839f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 15:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708297205; x=1708902005; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrCuFy6+4gYFmAiuLcexX0nwZGYSdwdswkjWCbd1NAk=;
        b=h99oRWV5619zIS+ICnVvPJEAF5z6EAInnwPF5aszYGkDg0p6weuPFbvIGw+yh9/Ced
         5sh2nIzc5hJHJS+X8B/y8o513LzlItfejvJZX836fOi0SNIdzCpEVQc0EH1jHxdn88IR
         W78TlXucFLZTRHYhPHnFnNzVA/L/TrCQKhrRaf9lVb8VTGQtmLqpdIbPBTM9n9NWY6Ue
         511xF5MtjHwAmyudPltH5SP7yOQH9R6foPTp8eT2fNz9sLCm2ownlkkNA0DDw50ChF59
         kO1mm++aoNNKoDval3t/A5Ns+/vfAEBW5yd8/yLJYsd1uchhd14hQtwVZAcPOKORhKL2
         t2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297205; x=1708902005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrCuFy6+4gYFmAiuLcexX0nwZGYSdwdswkjWCbd1NAk=;
        b=siJoUnqUGa+js1BXFj0u4IzPW2FZSRm1i/07cGxhGTYpvWF11BU3cKmTHt3pkM0EuW
         Al5cLIdUV0UxFyZZPCjzDv71VwzGE5um07B+lTIVML5ruv3PvEEjQaM5nCXPj1VpErzh
         vIThWjqsVfNzmyGZ9xgk6fheAmgnOygR1bNdIdpGSkI+iGEmkCbWIjWOGOkiqvkiRh1F
         aFJpOkEdomEV0peVGEyPiO8sSIm/ZlMogLsbEuMxYD9GG1kXiziXclEeSbk6QIz6bs5q
         Q48NoQw+uG9DkvH9mAao4dzOg7yuyhM+eWZnAbhJZf2RY1fgOkQ6GJqHeIQDjqMqxdjU
         i8wA==
X-Gm-Message-State: AOJu0YxXbHhDdWnS8ti0MjopHG+9E/d7X/BBj96bYLL+slHhfE3b3uA1
	fMuVIj/DyZjlD1/XjwzCGkQ/UNDcnBkOf2a2S7M6PsNEcodYzQhWxWUCPnTG
X-Google-Smtp-Source: AGHT+IGo4eSc91Tw2KkgiOnt3VxImQ0j76+HcTc4dTO8guYRBtyBMd8OuDbFinotq9F8rv5W6x0bIg==
X-Received: by 2002:a6b:c90e:0:b0:7c4:2053:813d with SMTP id z14-20020a6bc90e000000b007c42053813dmr12452587iof.14.1708297204619;
        Sun, 18 Feb 2024 15:00:04 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id n3-20020a02cc03000000b004712a778fb4sm1214848jap.28.2024.02.18.15.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 15:00:02 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 1/8] hashserv: Add Unihash Garbage Collection
Date: Sun, 18 Feb 2024 15:59:46 -0700
Message-Id: <20240218225953.2997239-2-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15923

Adds support for removing unused unihashes from the database. This is
done using a "mark and sweep" style of garbage collection where a
collection is started by marking which unihashes should be kept in the
database, then performing a sweep to remove any unmarked hashes.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashclient     |  35 +++++
 bitbake/lib/hashserv/client.py     |  31 ++++
 bitbake/lib/hashserv/server.py     | 105 ++++++++------
 bitbake/lib/hashserv/sqlalchemy.py | 226 ++++++++++++++++++++++++-----
 bitbake/lib/hashserv/sqlite.py     | 205 +++++++++++++++++++++-----
 bitbake/lib/hashserv/tests.py      | 198 +++++++++++++++++++++++++
 6 files changed, 684 insertions(+), 116 deletions(-)

diff --git a/bitbake/bin/bitbake-hashclient b/bitbake/bin/bitbake-hashclient
index 2cb63386662..f71b87404ae 100755
--- a/bitbake/bin/bitbake-hashclient
+++ b/bitbake/bin/bitbake-hashclient
@@ -195,6 +195,28 @@ def main():
         columns = client.get_db_query_columns()
         print("\n".join(sorted(columns)))
 
+    def handle_gc_status(args, client):
+        result = client.gc_status()
+        if not result["mark"]:
+            print("No Garbage collection in progress")
+            return 0
+
+        print("Current Mark: %s" % result["mark"])
+        print("Total hashes to keep: %d" % result["keep"])
+        print("Total hashes to remove: %s" % result["remove"])
+        return 0
+
+    def handle_gc_mark(args, client):
+        where = {k: v for k, v in args.where}
+        result = client.gc_mark(args.mark, where)
+        print("New hashes marked: %d" % result["count"])
+        return 0
+
+    def handle_gc_sweep(args, client):
+        result = client.gc_sweep(args.mark)
+        print("Removed %d rows" % result["count"])
+        return 0
+
     parser = argparse.ArgumentParser(description='Hash Equivalence Client')
     parser.add_argument('--address', default=DEFAULT_ADDRESS, help='Server address (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
@@ -274,6 +296,19 @@ def main():
     db_query_columns_parser = subparsers.add_parser('get-db-query-columns', help="Show columns that can be used in database queries")
     db_query_columns_parser.set_defaults(func=handle_get_db_query_columns)
 
+    gc_status_parser = subparsers.add_parser("gc-status", help="Show garbage collection status")
+    gc_status_parser.set_defaults(func=handle_gc_status)
+
+    gc_mark_parser = subparsers.add_parser('gc-mark', help="Mark hashes to be kept for garbage collection")
+    gc_mark_parser.add_argument("mark", help="Mark for this garbage collection operation")
+    gc_mark_parser.add_argument("--where", "-w", metavar="KEY VALUE", nargs=2, action="append", default=[],
+                             help="Keep entries in table where KEY == VALUE")
+    gc_mark_parser.set_defaults(func=handle_gc_mark)
+
+    gc_sweep_parser = subparsers.add_parser('gc-sweep', help="Perform garbage collection and delete any entries that are not marked")
+    gc_sweep_parser.add_argument("mark", help="Mark for this garbage collection operation")
+    gc_sweep_parser.set_defaults(func=handle_gc_sweep)
+
     args = parser.parse_args()
 
     logger = logging.getLogger('hashserv')
diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 35a97687fbe..e6dc4179126 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -194,6 +194,34 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         await self._set_mode(self.MODE_NORMAL)
         return (await self.invoke({"get-db-query-columns": {}}))["columns"]
 
+    async def gc_status(self):
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.invoke({"gc-status": {}})
+
+    async def gc_mark(self, mark, where):
+        """
+        Starts a new garbage collection operation identified by "mark". If
+        garbage collection is already in progress with "mark", the collection
+        is continued.
+
+        All unihash entries that match the "where" clause are marked to be
+        kept. In addition, any new entries added to the database after this
+        command will be automatically marked with "mark"
+        """
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.invoke({"gc-mark": {"mark": mark, "where": where}})
+
+    async def gc_sweep(self, mark):
+        """
+        Finishes garbage collection for "mark". All unihash entries that have
+        not been marked will be deleted.
+
+        It is recommended to clean unused outhash entries after running this to
+        cleanup any dangling outhashes
+        """
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.invoke({"gc-sweep": {"mark": mark}})
+
 
 class Client(bb.asyncrpc.Client):
     def __init__(self, username=None, password=None):
@@ -224,6 +252,9 @@ class Client(bb.asyncrpc.Client):
             "become_user",
             "get_db_usage",
             "get_db_query_columns",
+            "gc_status",
+            "gc_mark",
+            "gc_sweep",
         )
 
     def _get_async_client(self):
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index a86507830e8..5ed852d1f30 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -199,7 +199,7 @@ def permissions(*permissions, allow_anon=True, allow_self_service=False):
             if not self.user_has_permissions(*permissions, allow_anon=allow_anon):
                 if not self.user:
                     username = "Anonymous user"
-                    user_perms = self.anon_perms
+                    user_perms = self.server.anon_perms
                 else:
                     username = self.user.username
                     user_perms = self.user.permissions
@@ -223,25 +223,11 @@ def permissions(*permissions, allow_anon=True, allow_self_service=False):
 
 
 class ServerClient(bb.asyncrpc.AsyncServerConnection):
-    def __init__(
-        self,
-        socket,
-        db_engine,
-        request_stats,
-        backfill_queue,
-        upstream,
-        read_only,
-        anon_perms,
-    ):
-        super().__init__(socket, "OEHASHEQUIV", logger)
-        self.db_engine = db_engine
-        self.request_stats = request_stats
+    def __init__(self, socket, server):
+        super().__init__(socket, "OEHASHEQUIV", server.logger)
+        self.server = server
         self.max_chunk = bb.asyncrpc.DEFAULT_MAX_CHUNK
-        self.backfill_queue = backfill_queue
-        self.upstream = upstream
-        self.read_only = read_only
         self.user = None
-        self.anon_perms = anon_perms
 
         self.handlers.update(
             {
@@ -261,13 +247,16 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
             }
         )
 
-        if not read_only:
+        if not self.server.read_only:
             self.handlers.update(
                 {
                     "report-equiv": self.handle_equivreport,
                     "reset-stats": self.handle_reset_stats,
                     "backfill-wait": self.handle_backfill_wait,
                     "remove": self.handle_remove,
+                    "gc-mark": self.handle_gc_mark,
+                    "gc-sweep": self.handle_gc_sweep,
+                    "gc-status": self.handle_gc_status,
                     "clean-unused": self.handle_clean_unused,
                     "refresh-token": self.handle_refresh_token,
                     "set-user-perms": self.handle_set_perms,
@@ -282,10 +271,10 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
     def user_has_permissions(self, *permissions, allow_anon=True):
         permissions = set(permissions)
         if allow_anon:
-            if ALL_PERM in self.anon_perms:
+            if ALL_PERM in self.server.anon_perms:
                 return True
 
-            if not permissions - self.anon_perms:
+            if not permissions - self.server.anon_perms:
                 return True
 
         if self.user is None:
@@ -303,10 +292,10 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         return self.proto_version > (1, 0) and self.proto_version <= (1, 1)
 
     async def process_requests(self):
-        async with self.db_engine.connect(self.logger) as db:
+        async with self.server.db_engine.connect(self.logger) as db:
             self.db = db
-            if self.upstream is not None:
-                self.upstream_client = await create_async_client(self.upstream)
+            if self.server.upstream is not None:
+                self.upstream_client = await create_async_client(self.server.upstream)
             else:
                 self.upstream_client = None
 
@@ -323,7 +312,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 if "stream" in k:
                     return await self.handlers[k](msg[k])
                 else:
-                    with self.request_stats.start_sample() as self.request_sample, self.request_sample.measure():
+                    with self.server.request_stats.start_sample() as self.request_sample, self.request_sample.measure():
                         return await self.handlers[k](msg[k])
 
         raise bb.asyncrpc.ClientError("Unrecognized command %r" % msg)
@@ -404,7 +393,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 # possible (which is why the request sample is handled manually
                 # instead of using 'with', and also why logging statements are
                 # commented out.
-                self.request_sample = self.request_stats.start_sample()
+                self.request_sample = self.server.request_stats.start_sample()
                 request_measure = self.request_sample.measure()
                 request_measure.start()
 
@@ -435,7 +424,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
             # Post to the backfill queue after writing the result to minimize
             # the turn around time on a request
             if upstream is not None:
-                await self.backfill_queue.put((method, taskhash))
+                await self.server.backfill_queue.put((method, taskhash))
 
         await self.socket.send("ok")
         return self.NO_RESPONSE
@@ -461,7 +450,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
     # report is made inside the function
     @permissions(READ_PERM)
     async def handle_report(self, data):
-        if self.read_only or not self.user_has_permissions(REPORT_PERM):
+        if self.server.read_only or not self.user_has_permissions(REPORT_PERM):
             return await self.report_readonly(data)
 
         outhash_data = {
@@ -538,24 +527,24 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
     @permissions(READ_PERM)
     async def handle_get_stats(self, request):
         return {
-            "requests": self.request_stats.todict(),
+            "requests": self.server.request_stats.todict(),
         }
 
     @permissions(DB_ADMIN_PERM)
     async def handle_reset_stats(self, request):
         d = {
-            "requests": self.request_stats.todict(),
+            "requests": self.server.request_stats.todict(),
         }
 
-        self.request_stats.reset()
+        self.server.request_stats.reset()
         return d
 
     @permissions(READ_PERM)
     async def handle_backfill_wait(self, request):
         d = {
-            "tasks": self.backfill_queue.qsize(),
+            "tasks": self.server.backfill_queue.qsize(),
         }
-        await self.backfill_queue.join()
+        await self.server.backfill_queue.join()
         return d
 
     @permissions(DB_ADMIN_PERM)
@@ -566,6 +555,46 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
         return {"count": await self.db.remove(condition)}
 
+    @permissions(DB_ADMIN_PERM)
+    async def handle_gc_mark(self, request):
+        condition = request["where"]
+        mark = request["mark"]
+
+        if not isinstance(condition, dict):
+            raise TypeError("Bad condition type %s" % type(condition))
+
+        if not isinstance(mark, str):
+            raise TypeError("Bad mark type %s" % type(mark))
+
+        return {"count": await self.db.gc_mark(mark, condition)}
+
+    @permissions(DB_ADMIN_PERM)
+    async def handle_gc_sweep(self, request):
+        mark = request["mark"]
+
+        if not isinstance(mark, str):
+            raise TypeError("Bad mark type %s" % type(mark))
+
+        current_mark = await self.db.get_current_gc_mark()
+
+        if not current_mark or mark != current_mark:
+            raise bb.asyncrpc.InvokeError(
+                f"'{mark}' is not the current mark. Refusing to sweep"
+            )
+
+        count = await self.db.gc_sweep()
+
+        return {"count": count}
+
+    @permissions(DB_ADMIN_PERM)
+    async def handle_gc_status(self, request):
+        (keep_rows, remove_rows, current_mark) = await self.db.gc_status()
+        return {
+            "keep": keep_rows,
+            "remove": remove_rows,
+            "mark": current_mark,
+        }
+
     @permissions(DB_ADMIN_PERM)
     async def handle_clean_unused(self, request):
         max_age = request["max_age_seconds"]
@@ -779,15 +808,7 @@ class Server(bb.asyncrpc.AsyncServer):
         )
 
     def accept_client(self, socket):
-        return ServerClient(
-            socket,
-            self.db_engine,
-            self.request_stats,
-            self.backfill_queue,
-            self.upstream,
-            self.read_only,
-            self.anon_perms,
-        )
+        return ServerClient(socket, self)
 
     async def create_admin_user(self):
         admin_permissions = (ALL_PERM,)
diff --git a/bitbake/lib/hashserv/sqlalchemy.py b/bitbake/lib/hashserv/sqlalchemy.py
index cee04bffb03..89a6b86d9d8 100644
--- a/bitbake/lib/hashserv/sqlalchemy.py
+++ b/bitbake/lib/hashserv/sqlalchemy.py
@@ -28,6 +28,7 @@ from sqlalchemy import (
     delete,
     update,
     func,
+    inspect,
 )
 import sqlalchemy.engine
 from sqlalchemy.orm import declarative_base
@@ -36,16 +37,17 @@ from sqlalchemy.exc import IntegrityError
 Base = declarative_base()
 
 
-class UnihashesV2(Base):
-    __tablename__ = "unihashes_v2"
+class UnihashesV3(Base):
+    __tablename__ = "unihashes_v3"
     id = Column(Integer, primary_key=True, autoincrement=True)
     method = Column(Text, nullable=False)
     taskhash = Column(Text, nullable=False)
     unihash = Column(Text, nullable=False)
+    gc_mark = Column(Text, nullable=False)
 
     __table_args__ = (
         UniqueConstraint("method", "taskhash"),
-        Index("taskhash_lookup_v3", "method", "taskhash"),
+        Index("taskhash_lookup_v4", "method", "taskhash"),
     )
 
 
@@ -79,6 +81,36 @@ class Users(Base):
     __table_args__ = (UniqueConstraint("username"),)
 
 
+class Config(Base):
+    __tablename__ = "config"
+    id = Column(Integer, primary_key=True, autoincrement=True)
+    name = Column(Text, nullable=False)
+    value = Column(Text)
+    __table_args__ = (
+        UniqueConstraint("name"),
+        Index("config_lookup", "name"),
+    )
+
+
+#
+# Old table versions
+#
+DeprecatedBase = declarative_base()
+
+
+class UnihashesV2(DeprecatedBase):
+    __tablename__ = "unihashes_v2"
+    id = Column(Integer, primary_key=True, autoincrement=True)
+    method = Column(Text, nullable=False)
+    taskhash = Column(Text, nullable=False)
+    unihash = Column(Text, nullable=False)
+
+    __table_args__ = (
+        UniqueConstraint("method", "taskhash"),
+        Index("taskhash_lookup_v3", "method", "taskhash"),
+    )
+
+
 class DatabaseEngine(object):
     def __init__(self, url, username=None, password=None):
         self.logger = logging.getLogger("hashserv.sqlalchemy")
@@ -91,6 +123,9 @@ class DatabaseEngine(object):
             self.url = self.url.set(password=password)
 
     async def create(self):
+        def check_table_exists(conn, name):
+            return inspect(conn).has_table(name)
+
         self.logger.info("Using database %s", self.url)
         self.engine = create_async_engine(self.url, poolclass=NullPool)
 
@@ -99,6 +134,24 @@ class DatabaseEngine(object):
             self.logger.info("Creating tables...")
             await conn.run_sync(Base.metadata.create_all)
 
+            if await conn.run_sync(check_table_exists, UnihashesV2.__tablename__):
+                self.logger.info("Upgrading Unihashes V2 -> V3...")
+                statement = insert(UnihashesV3).from_select(
+                    ["id", "method", "unihash", "taskhash", "gc_mark"],
+                    select(
+                        UnihashesV2.id,
+                        UnihashesV2.method,
+                        UnihashesV2.unihash,
+                        UnihashesV2.taskhash,
+                        literal("").label("gc_mark"),
+                    ),
+                )
+                self.logger.debug("%s", statement)
+                await conn.execute(statement)
+
+                await conn.run_sync(Base.metadata.drop_all, [UnihashesV2.__table__])
+                self.logger.info("Upgrade complete")
+
     def connect(self, logger):
         return Database(self.engine, logger)
 
@@ -118,6 +171,15 @@ def map_user(row):
     )
 
 
+def _make_condition_statement(table, condition):
+    where = {}
+    for c in table.__table__.columns:
+        if c.key in condition and condition[c.key] is not None:
+            where[c] = condition[c.key]
+
+    return [(k == v) for k, v in where.items()]
+
+
 class Database(object):
     def __init__(self, engine, logger):
         self.engine = engine
@@ -135,17 +197,52 @@ class Database(object):
         await self.db.close()
         self.db = None
 
+    async def _execute(self, statement):
+        self.logger.debug("%s", statement)
+        return await self.db.execute(statement)
+
+    async def _set_config(self, name, value):
+        while True:
+            result = await self._execute(
+                update(Config).where(Config.name == name).values(value=value)
+            )
+
+            if result.rowcount == 0:
+                self.logger.debug("Config '%s' not found. Adding it", name)
+                try:
+                    await self._execute(insert(Config).values(name=name, value=value))
+                except IntegrityError:
+                    # Race. Try again
+                    continue
+
+            break
+
+    def _get_config_subquery(self, name, default=None):
+        if default is not None:
+            return func.coalesce(
+                select(Config.value).where(Config.name == name).scalar_subquery(),
+                default,
+            )
+        return select(Config.value).where(Config.name == name).scalar_subquery()
+
+    async def _get_config(self, name):
+        result = await self._execute(select(Config.value).where(Config.name == name))
+        row = result.first()
+        if row is None:
+            return None
+        return row.value
+
     async def get_unihash_by_taskhash_full(self, method, taskhash):
         statement = (
             select(
                 OuthashesV2,
-                UnihashesV2.unihash.label("unihash"),
+                UnihashesV3.unihash.label("unihash"),
             )
             .join(
-                UnihashesV2,
+                UnihashesV3,
                 and_(
-                    UnihashesV2.method == OuthashesV2.method,
-                    UnihashesV2.taskhash == OuthashesV2.taskhash,
+                    UnihashesV3.method == OuthashesV2.method,
+                    UnihashesV3.taskhash == OuthashesV2.taskhash,
                 ),
             )
             .where(
@@ -164,12 +261,12 @@ class Database(object):
 
     async def get_unihash_by_outhash(self, method, outhash):
         statement = (
-            select(OuthashesV2, UnihashesV2.unihash.label("unihash"))
+            select(OuthashesV2, UnihashesV3.unihash.label("unihash"))
             .join(
-                UnihashesV2,
+                UnihashesV3,
                 and_(
-                    UnihashesV2.method == OuthashesV2.method,
-                    UnihashesV2.taskhash == OuthashesV2.taskhash,
+                    UnihashesV3.method == OuthashesV2.method,
+                    UnihashesV3.taskhash == OuthashesV2.taskhash,
                 ),
             )
             .where(
@@ -208,13 +305,13 @@ class Database(object):
         statement = (
             select(
                 OuthashesV2.taskhash.label("taskhash"),
-                UnihashesV2.unihash.label("unihash"),
+                UnihashesV3.unihash.label("unihash"),
             )
             .join(
-                UnihashesV2,
+                UnihashesV3,
                 and_(
-                    UnihashesV2.method == OuthashesV2.method,
-                    UnihashesV2.taskhash == OuthashesV2.taskhash,
+                    UnihashesV3.method == OuthashesV2.method,
+                    UnihashesV3.taskhash == OuthashesV2.taskhash,
                 ),
             )
             .where(
@@ -234,12 +331,12 @@ class Database(object):
 
     async def get_equivalent(self, method, taskhash):
         statement = select(
-            UnihashesV2.unihash,
-            UnihashesV2.method,
-            UnihashesV2.taskhash,
+            UnihashesV3.unihash,
+            UnihashesV3.method,
+            UnihashesV3.taskhash,
         ).where(
-            UnihashesV2.method == method,
-            UnihashesV2.taskhash == taskhash,
+            UnihashesV3.method == method,
+            UnihashesV3.taskhash == taskhash,
         )
         self.logger.debug("%s", statement)
         async with self.db.begin():
@@ -248,13 +345,9 @@ class Database(object):
 
     async def remove(self, condition):
         async def do_remove(table):
-            where = {}
-            for c in table.__table__.columns:
-                if c.key in condition and condition[c.key] is not None:
-                    where[c] = condition[c.key]
-
+            where = _make_condition_statement(table, condition)
             if where:
-                statement = delete(table).where(*[(k == v) for k, v in where.items()])
+                statement = delete(table).where(*where)
                 self.logger.debug("%s", statement)
                 async with self.db.begin():
                     result = await self.db.execute(statement)
@@ -263,19 +356,74 @@ class Database(object):
             return 0
 
         count = 0
-        count += await do_remove(UnihashesV2)
+        count += await do_remove(UnihashesV3)
         count += await do_remove(OuthashesV2)
 
         return count
 
+    async def get_current_gc_mark(self):
+        async with self.db.begin():
+            return await self._get_config("gc-mark")
+
+    async def gc_status(self):
+        async with self.db.begin():
+            gc_mark_subquery = self._get_config_subquery("gc-mark", "")
+
+            result = await self._execute(
+                select(func.count())
+                .select_from(UnihashesV3)
+                .where(UnihashesV3.gc_mark == gc_mark_subquery)
+            )
+            keep_rows = result.scalar()
+
+            result = await self._execute(
+                select(func.count())
+                .select_from(UnihashesV3)
+                .where(UnihashesV3.gc_mark != gc_mark_subquery)
+            )
+            remove_rows = result.scalar()
+
+            return (keep_rows, remove_rows, await self._get_config("gc-mark"))
+
+    async def gc_mark(self, mark, condition):
+        async with self.db.begin():
+            await self._set_config("gc-mark", mark)
+
+            where = _make_condition_statement(UnihashesV3, condition)
+            if not where:
+                return 0
+
+            result = await self._execute(
+                update(UnihashesV3)
+                .values(gc_mark=self._get_config_subquery("gc-mark", ""))
+                .where(*where)
+            )
+            return result.rowcount
+
+    async def gc_sweep(self):
+        async with self.db.begin():
+            result = await self._execute(
+                delete(UnihashesV3).where(
+                    # A sneaky conditional that provides some errant use
+                    # protection: If the config mark is NULL, this will not
+                    # match any rows because No default is specified in the
+                    # select statement
+                    UnihashesV3.gc_mark
+                    != self._get_config_subquery("gc-mark")
+                )
+            )
+            await self._set_config("gc-mark", None)
+
+            return result.rowcount
+
     async def clean_unused(self, oldest):
         statement = delete(OuthashesV2).where(
             OuthashesV2.created < oldest,
             ~(
-                select(UnihashesV2.id)
+                select(UnihashesV3.id)
                 .where(
-                    UnihashesV2.method == OuthashesV2.method,
-                    UnihashesV2.taskhash == OuthashesV2.taskhash,
+                    UnihashesV3.method == OuthashesV2.method,
+                    UnihashesV3.taskhash == OuthashesV2.taskhash,
                 )
                 .limit(1)
                 .exists()
@@ -287,15 +435,17 @@ class Database(object):
             return result.rowcount
 
     async def insert_unihash(self, method, taskhash, unihash):
-        statement = insert(UnihashesV2).values(
-            method=method,
-            taskhash=taskhash,
-            unihash=unihash,
-        )
-        self.logger.debug("%s", statement)
         try:
             async with self.db.begin():
-                await self.db.execute(statement)
+                await self._execute(
+                    insert(UnihashesV3).values(
+                        method=method,
+                        taskhash=taskhash,
+                        unihash=unihash,
+                        gc_mark=self._get_config_subquery("gc-mark", ""),
+                    )
+                )
+
             return True
         except IntegrityError:
             self.logger.debug(
@@ -418,7 +568,7 @@ class Database(object):
 
     async def get_query_columns(self):
         columns = set()
-        for table in (UnihashesV2, OuthashesV2):
+        for table in (UnihashesV3, OuthashesV2):
             for c in table.__table__.columns:
                 if not isinstance(c.type, Text):
                     continue
diff --git a/bitbake/lib/hashserv/sqlite.py b/bitbake/lib/hashserv/sqlite.py
index f93cb2c1dd9..608490730d7 100644
--- a/bitbake/lib/hashserv/sqlite.py
+++ b/bitbake/lib/hashserv/sqlite.py
@@ -15,6 +15,7 @@ UNIHASH_TABLE_DEFINITION = (
     ("method", "TEXT NOT NULL", "UNIQUE"),
     ("taskhash", "TEXT NOT NULL", "UNIQUE"),
     ("unihash", "TEXT NOT NULL", ""),
+    ("gc_mark", "TEXT NOT NULL", ""),
 )
 
 UNIHASH_TABLE_COLUMNS = tuple(name for name, _, _ in UNIHASH_TABLE_DEFINITION)
@@ -44,6 +45,14 @@ USERS_TABLE_DEFINITION = (
 USERS_TABLE_COLUMNS = tuple(name for name, _, _ in USERS_TABLE_DEFINITION)
 
 
+CONFIG_TABLE_DEFINITION = (
+    ("name", "TEXT NOT NULL", "UNIQUE"),
+    ("value", "TEXT", ""),
+)
+
+CONFIG_TABLE_COLUMNS = tuple(name for name, _, _ in CONFIG_TABLE_DEFINITION)
+
+
 def _make_table(cursor, name, definition):
     cursor.execute(
         """
@@ -71,6 +80,35 @@ def map_user(row):
     )
 
 
+def _make_condition_statement(columns, condition):
+    where = {}
+    for c in columns:
+        if c in condition and condition[c] is not None:
+            where[c] = condition[c]
+
+    return where, " AND ".join("%s=:%s" % (k, k) for k in where.keys())
+
+
+def _get_sqlite_version(cursor):
+    cursor.execute("SELECT sqlite_version()")
+
+    version = []
+    for v in cursor.fetchone()[0].split("."):
+        try:
+            version.append(int(v))
+        except ValueError:
+            version.append(v)
+
+    return tuple(version)
+
+
+def _schema_table_name(version):
+    if version >= (3, 33):
+        return "sqlite_schema"
+
+    return "sqlite_master"
+
+
 class DatabaseEngine(object):
     def __init__(self, dbname, sync):
         self.dbname = dbname
@@ -82,9 +120,10 @@ class DatabaseEngine(object):
         db.row_factory = sqlite3.Row
 
         with closing(db.cursor()) as cursor:
-            _make_table(cursor, "unihashes_v2", UNIHASH_TABLE_DEFINITION)
+            _make_table(cursor, "unihashes_v3", UNIHASH_TABLE_DEFINITION)
             _make_table(cursor, "outhashes_v2", OUTHASH_TABLE_DEFINITION)
             _make_table(cursor, "users", USERS_TABLE_DEFINITION)
+            _make_table(cursor, "config", CONFIG_TABLE_DEFINITION)
 
             cursor.execute("PRAGMA journal_mode = WAL")
             cursor.execute(
@@ -96,17 +135,38 @@ class DatabaseEngine(object):
             cursor.execute("DROP INDEX IF EXISTS outhash_lookup")
             cursor.execute("DROP INDEX IF EXISTS taskhash_lookup_v2")
             cursor.execute("DROP INDEX IF EXISTS outhash_lookup_v2")
+            cursor.execute("DROP INDEX IF EXISTS taskhash_lookup_v3")
 
             # TODO: Upgrade from tasks_v2?
             cursor.execute("DROP TABLE IF EXISTS tasks_v2")
 
             # Create new indexes
             cursor.execute(
-                "CREATE INDEX IF NOT EXISTS taskhash_lookup_v3 ON unihashes_v2 (method, taskhash)"
+                "CREATE INDEX IF NOT EXISTS taskhash_lookup_v4 ON unihashes_v3 (method, taskhash)"
             )
             cursor.execute(
                 "CREATE INDEX IF NOT EXISTS outhash_lookup_v3 ON outhashes_v2 (method, outhash)"
             )
+            cursor.execute("CREATE INDEX IF NOT EXISTS config_lookup ON config (name)")
+
+            sqlite_version = _get_sqlite_version(cursor)
+
+            cursor.execute(
+                f"""
+                SELECT name FROM {_schema_table_name(sqlite_version)} WHERE type = 'table' AND name = 'unihashes_v2'
+                """
+            )
+            if cursor.fetchone():
+                self.logger.info("Upgrading Unihashes V2 -> V3...")
+                cursor.execute(
+                    """
+                    INSERT INTO unihashes_v3 (id, method, unihash, taskhash, gc_mark)
+                    SELECT id, method, unihash, taskhash, '' FROM unihashes_v2
+                    """
+                )
+                cursor.execute("DROP TABLE unihashes_v2")
+                db.commit()
+                self.logger.info("Upgrade complete")
 
     def connect(self, logger):
         return Database(logger, self.dbname, self.sync)
@@ -126,16 +186,7 @@ class Database(object):
                 "PRAGMA synchronous = %s" % ("NORMAL" if sync else "OFF")
             )
 
-            cursor.execute("SELECT sqlite_version()")
-
-            version = []
-            for v in cursor.fetchone()[0].split("."):
-                try:
-                    version.append(int(v))
-                except ValueError:
-                    version.append(v)
-
-            self.sqlite_version = tuple(version)
+            self.sqlite_version = _get_sqlite_version(cursor)
 
     async def __aenter__(self):
         return self
@@ -143,6 +194,30 @@ class Database(object):
     async def __aexit__(self, exc_type, exc_value, traceback):
         await self.close()
 
+    async def _set_config(self, cursor, name, value):
+        cursor.execute(
+            """
+            INSERT OR REPLACE INTO config (id, name, value) VALUES
+            ((SELECT id FROM config WHERE name=:name), :name, :value)
+            """,
+            {
+                "name": name,
+                "value": value,
+            },
+        )
+
+    async def _get_config(self, cursor, name):
+        cursor.execute(
+            "SELECT value FROM config WHERE name=:name",
+            {
+                "name": name,
+            },
+        )
+        row = cursor.fetchone()
+        if row is None:
+            return None
+        return row["value"]
+
     async def close(self):
         self.db.close()
 
@@ -150,8 +225,8 @@ class Database(object):
         with closing(self.db.cursor()) as cursor:
             cursor.execute(
                 """
-                SELECT *, unihashes_v2.unihash AS unihash FROM outhashes_v2
-                INNER JOIN unihashes_v2 ON unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash
+                SELECT *, unihashes_v3.unihash AS unihash FROM outhashes_v2
+                INNER JOIN unihashes_v3 ON unihashes_v3.method=outhashes_v2.method AND unihashes_v3.taskhash=outhashes_v2.taskhash
                 WHERE outhashes_v2.method=:method AND outhashes_v2.taskhash=:taskhash
                 ORDER BY outhashes_v2.created ASC
                 LIMIT 1
@@ -167,8 +242,8 @@ class Database(object):
         with closing(self.db.cursor()) as cursor:
             cursor.execute(
                 """
-                SELECT *, unihashes_v2.unihash AS unihash FROM outhashes_v2
-                INNER JOIN unihashes_v2 ON unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash
+                SELECT *, unihashes_v3.unihash AS unihash FROM outhashes_v2
+                INNER JOIN unihashes_v3 ON unihashes_v3.method=outhashes_v2.method AND unihashes_v3.taskhash=outhashes_v2.taskhash
                 WHERE outhashes_v2.method=:method AND outhashes_v2.outhash=:outhash
                 ORDER BY outhashes_v2.created ASC
                 LIMIT 1
@@ -200,8 +275,8 @@ class Database(object):
         with closing(self.db.cursor()) as cursor:
             cursor.execute(
                 """
-                SELECT outhashes_v2.taskhash AS taskhash, unihashes_v2.unihash AS unihash FROM outhashes_v2
-                INNER JOIN unihashes_v2 ON unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash
+                SELECT outhashes_v2.taskhash AS taskhash, unihashes_v3.unihash AS unihash FROM outhashes_v2
+                INNER JOIN unihashes_v3 ON unihashes_v3.method=outhashes_v2.method AND unihashes_v3.taskhash=outhashes_v2.taskhash
                 -- Select any matching output hash except the one we just inserted
                 WHERE outhashes_v2.method=:method AND outhashes_v2.outhash=:outhash AND outhashes_v2.taskhash!=:taskhash
                 -- Pick the oldest hash
@@ -219,7 +294,7 @@ class Database(object):
     async def get_equivalent(self, method, taskhash):
         with closing(self.db.cursor()) as cursor:
             cursor.execute(
-                "SELECT taskhash, method, unihash FROM unihashes_v2 WHERE method=:method AND taskhash=:taskhash",
+                "SELECT taskhash, method, unihash FROM unihashes_v3 WHERE method=:method AND taskhash=:taskhash",
                 {
                     "method": method,
                     "taskhash": taskhash,
@@ -229,15 +304,9 @@ class Database(object):
 
     async def remove(self, condition):
         def do_remove(columns, table_name, cursor):
-            where = {}
-            for c in columns:
-                if c in condition and condition[c] is not None:
-                    where[c] = condition[c]
-
+            where, clause = _make_condition_statement(columns, condition)
             if where:
-                query = ("DELETE FROM %s WHERE " % table_name) + " AND ".join(
-                    "%s=:%s" % (k, k) for k in where.keys()
-                )
+                query = f"DELETE FROM {table_name} WHERE {clause}"
                 cursor.execute(query, where)
                 return cursor.rowcount
 
@@ -246,17 +315,80 @@ class Database(object):
         count = 0
         with closing(self.db.cursor()) as cursor:
             count += do_remove(OUTHASH_TABLE_COLUMNS, "outhashes_v2", cursor)
-            count += do_remove(UNIHASH_TABLE_COLUMNS, "unihashes_v2", cursor)
+            count += do_remove(UNIHASH_TABLE_COLUMNS, "unihashes_v3", cursor)
             self.db.commit()
 
         return count
 
+    async def get_current_gc_mark(self):
+        with closing(self.db.cursor()) as cursor:
+            return await self._get_config(cursor, "gc-mark")
+
+    async def gc_status(self):
+        with closing(self.db.cursor()) as cursor:
+            cursor.execute(
+                """
+                SELECT COUNT() FROM unihashes_v3 WHERE
+                    gc_mark=COALESCE((SELECT value FROM config WHERE name='gc-mark'), '')
+                """
+            )
+            keep_rows = cursor.fetchone()[0]
+
+            cursor.execute(
+                """
+                SELECT COUNT() FROM unihashes_v3 WHERE
+                    gc_mark!=COALESCE((SELECT value FROM config WHERE name='gc-mark'), '')
+                """
+            )
+            remove_rows = cursor.fetchone()[0]
+
+            current_mark = await self._get_config(cursor, "gc-mark")
+
+            return (keep_rows, remove_rows, current_mark)
+
+    async def gc_mark(self, mark, condition):
+        with closing(self.db.cursor()) as cursor:
+            await self._set_config(cursor, "gc-mark", mark)
+
+            where, clause = _make_condition_statement(UNIHASH_TABLE_COLUMNS, condition)
+
+            new_rows = 0
+            if where:
+                cursor.execute(
+                    f"""
+                    UPDATE unihashes_v3 SET
+                        gc_mark=COALESCE((SELECT value FROM config WHERE name='gc-mark'), '')
+                    WHERE {clause}
+                    """,
+                    where,
+                )
+                new_rows = cursor.rowcount
+
+            self.db.commit()
+            return new_rows
+
+    async def gc_sweep(self):
+        with closing(self.db.cursor()) as cursor:
+            # NOTE: COALESCE is not used in this query so that if the current
+            # mark is NULL, nothing will happen
+            cursor.execute(
+                """
+                DELETE FROM unihashes_v3 WHERE
+                    gc_mark!=(SELECT value FROM config WHERE name='gc-mark')
+                """
+            )
+            count = cursor.rowcount
+            await self._set_config(cursor, "gc-mark", None)
+
+            self.db.commit()
+            return count
+
     async def clean_unused(self, oldest):
         with closing(self.db.cursor()) as cursor:
             cursor.execute(
                 """
                 DELETE FROM outhashes_v2 WHERE created<:oldest AND NOT EXISTS (
-                    SELECT unihashes_v2.id FROM unihashes_v2 WHERE unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash LIMIT 1
+                    SELECT unihashes_v3.id FROM unihashes_v3 WHERE unihashes_v3.method=outhashes_v2.method AND unihashes_v3.taskhash=outhashes_v2.taskhash LIMIT 1
                 )
                 """,
                 {
@@ -271,7 +403,13 @@ class Database(object):
             prevrowid = cursor.lastrowid
             cursor.execute(
                 """
-                INSERT OR IGNORE INTO unihashes_v2 (method, taskhash, unihash) VALUES(:method, :taskhash, :unihash)
+                INSERT OR IGNORE INTO unihashes_v3 (method, taskhash, unihash, gc_mark) VALUES
+                    (
+                    :method,
+                    :taskhash,
+                    :unihash,
+                    COALESCE((SELECT value FROM config WHERE name='gc-mark'), '')
+                    )
                 """,
                 {
                     "method": method,
@@ -383,14 +521,9 @@ class Database(object):
     async def get_usage(self):
         usage = {}
         with closing(self.db.cursor()) as cursor:
-            if self.sqlite_version >= (3, 33):
-                table_name = "sqlite_schema"
-            else:
-                table_name = "sqlite_master"
-
             cursor.execute(
                 f"""
-                SELECT name FROM {table_name} WHERE type = 'table' AND name NOT LIKE 'sqlite_%'
+                SELECT name FROM {_schema_table_name(self.sqlite_version)} WHERE type = 'table' AND name NOT LIKE 'sqlite_%'
                 """
             )
             for row in cursor.fetchall():
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index 869f7636c53..aeedab3575e 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -810,6 +810,27 @@ class HashEquivalenceCommonTests(object):
         with self.auth_perms("@user-admin") as client:
             become = client.become_user(client.username)
 
+    def test_auth_gc(self):
+        admin_client = self.start_auth_server()
+
+        with self.auth_perms() as client, self.assertRaises(InvokeError):
+            client.gc_mark("ABC", {"unihash": "123"})
+
+        with self.auth_perms() as client, self.assertRaises(InvokeError):
+            client.gc_status()
+
+        with self.auth_perms() as client, self.assertRaises(InvokeError):
+            client.gc_sweep("ABC")
+
+        with self.auth_perms("@db-admin") as client:
+            client.gc_mark("ABC", {"unihash": "123"})
+
+        with self.auth_perms("@db-admin") as client:
+            client.gc_status()
+
+        with self.auth_perms("@db-admin") as client:
+            client.gc_sweep("ABC")
+
     def test_get_db_usage(self):
         usage = self.client.get_db_usage()
 
@@ -837,6 +858,147 @@ class HashEquivalenceCommonTests(object):
             data = client.get_taskhash(self.METHOD, taskhash, True)
             self.assertEqual(data["owner"], user["username"])
 
+    def test_gc(self):
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
+        # Mark the first unihash to be kept
+        ret = self.client.gc_mark("ABC", {"unihash": unihash, "method": self.METHOD})
+        self.assertEqual(ret, {"count": 1})
+
+        ret = self.client.gc_status()
+        self.assertEqual(ret, {"mark": "ABC", "keep": 1, "remove": 1})
+
+        # Second hash is still there; mark doesn't delete hashes
+        self.assertClientGetHash(self.client, taskhash2, unihash2)
+
+        ret = self.client.gc_sweep("ABC")
+        self.assertEqual(ret, {"count": 1})
+
+        # Hash is gone. Taskhash is returned for second hash
+        self.assertClientGetHash(self.client, taskhash2, None)
+        # First hash is still present
+        self.assertClientGetHash(self.client, taskhash, unihash)
+
+    def test_gc_switch_mark(self):
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
+        # Mark the first unihash to be kept
+        ret = self.client.gc_mark("ABC", {"unihash": unihash, "method": self.METHOD})
+        self.assertEqual(ret, {"count": 1})
+
+        ret = self.client.gc_status()
+        self.assertEqual(ret, {"mark": "ABC", "keep": 1, "remove": 1})
+
+        # Second hash is still there; mark doesn't delete hashes
+        self.assertClientGetHash(self.client, taskhash2, unihash2)
+
+        # Switch to a different mark and mark the second hash. This will start
+        # a new collection cycle
+        ret = self.client.gc_mark("DEF", {"unihash": unihash2, "method": self.METHOD})
+        self.assertEqual(ret, {"count": 1})
+
+        ret = self.client.gc_status()
+        self.assertEqual(ret, {"mark": "DEF", "keep": 1, "remove": 1})
+
+        # Both hashes are still present
+        self.assertClientGetHash(self.client, taskhash2, unihash2)
+        self.assertClientGetHash(self.client, taskhash, unihash)
+
+        # Sweep with the new mark
+        ret = self.client.gc_sweep("DEF")
+        self.assertEqual(ret, {"count": 1})
+
+        # First hash is gone, second is kept
+        self.assertClientGetHash(self.client, taskhash2, unihash2)
+        self.assertClientGetHash(self.client, taskhash, None)
+
+    def test_gc_switch_sweep_mark(self):
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
+        # Mark the first unihash to be kept
+        ret = self.client.gc_mark("ABC", {"unihash": unihash, "method": self.METHOD})
+        self.assertEqual(ret, {"count": 1})
+
+        ret = self.client.gc_status()
+        self.assertEqual(ret, {"mark": "ABC", "keep": 1, "remove": 1})
+
+        # Sweeping with a different mark raises an error
+        with self.assertRaises(InvokeError):
+            self.client.gc_sweep("DEF")
+
+        # Both hashes are present
+        self.assertClientGetHash(self.client, taskhash2, unihash2)
+        self.assertClientGetHash(self.client, taskhash, unihash)
+
+    def test_gc_new_hashes(self):
+        taskhash = '53b8dce672cb6d0c73170be43f540460bfc347b4'
+        outhash = '5a9cb1649625f0bf41fc7791b635cd9c2d7118c7f021ba87dcd03f72b67ce7a8'
+        unihash = 'f37918cc02eb5a520b1aff86faacbc0a38124646'
+
+        result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+        self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
+
+        # Start a new garbage collection
+        ret = self.client.gc_mark("ABC", {"unihash": unihash, "method": self.METHOD})
+        self.assertEqual(ret, {"count": 1})
+
+        ret = self.client.gc_status()
+        self.assertEqual(ret, {"mark": "ABC", "keep": 1, "remove": 0})
+
+        # Add second hash. It should inherit the mark from the current garbage
+        # collection operation
+
+        taskhash2 = '3bf6f1e89d26205aec90da04854fbdbf73afe6b4'
+        outhash2 = '77623a549b5b1a31e3732dfa8fe61d7ce5d44b3370f253c5360e136b852967b4'
+        unihash2 = 'af36b199320e611fbb16f1f277d3ee1d619ca58b'
+
+        result = self.client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
+        self.assertClientGetHash(self.client, taskhash2, unihash2)
+
+        # Sweep should remove nothing
+        ret = self.client.gc_sweep("ABC")
+        self.assertEqual(ret, {"count": 0})
+
+        # Both hashes are present
+        self.assertClientGetHash(self.client, taskhash2, unihash2)
+        self.assertClientGetHash(self.client, taskhash, unihash)
+
 
 class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
     def get_server_addr(self, server_idx):
@@ -1086,6 +1248,42 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
             "get-db-query-columns",
         ], check=True)
 
+    def test_gc(self):
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
+        # Mark the first unihash to be kept
+        self.run_hashclient([
+            "--address", self.server_address,
+            "gc-mark", "ABC",
+            "--where", "unihash", unihash,
+            "--where", "method", self.METHOD
+        ], check=True)
+
+        # Second hash is still there; mark doesn't delete hashes
+        self.assertClientGetHash(self.client, taskhash2, unihash2)
+
+        self.run_hashclient([
+            "--address", self.server_address,
+            "gc-sweep", "ABC",
+        ], check=True)
+
+        # Hash is gone. Taskhash is returned for second hash
+        self.assertClientGetHash(self.client, taskhash2, None)
+        # First hash is still present
+        self.assertClientGetHash(self.client, taskhash, unihash)
+
 
 class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def get_server_addr(self, server_idx):
-- 
2.34.1


