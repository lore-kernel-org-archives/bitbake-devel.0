Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356E4C4167B
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:06 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
 by mx.groups.io with SMTP id smtpd.web10.53498.1699021625215561440
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hjWDJq/V;
 spf=pass (domain: gmail.com, ip: 209.85.167.171, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b565722c0eso1252531b6e.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021623; x=1699626423; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8Xwg4jcVAbaTF/RS5lq0ebYMPWd8462CpU7mMbsAzo=;
        b=hjWDJq/Vvf8DUaMUKUlOtrcMED17SNDE/o0dylEHr8i5+6nHJd7ckp1aQbq+7JLUXL
         ZFKoUhUtmd7AW9H8vQPNa52O3sHaFe78TzPHW4ZQ6l9nn76tyu9oSUfxoSPLmCEIyrpG
         wk5ZDds2FQ5bnj35E7WG1g3MOO2qeNeap9ocxWutTM6ypzlNU3R3vZxZbX+2aRntCpw/
         MxM5ddFKF50iEEMFg292+HfMWoevHnV15rPzvFVDtkzxlKnmjoKgV0TMFngJcaKHaXjN
         OPob1RCBJ07xah8QAnBURwuS8m/5gRiTDDi5b6E2Q6UUr+Wh1pCcsj7WZiOTbuudKukv
         4tzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021623; x=1699626423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8Xwg4jcVAbaTF/RS5lq0ebYMPWd8462CpU7mMbsAzo=;
        b=A5kfZKb1UVas732epWo+4utQPEYT/9sy2WGyrwEw2jh6dnIiH1oureRXh8eRecCRXH
         064PNBE/ysvnxNfdIsFyZ6/GULoVRVQaQdxIvhDTPZ+575DyIExiNAaxXcnTFs5+K1PS
         eavzkPA8wqrl91QIHiS+B7waSBzK51UqyTF58XPqvgtOEMXgH94mWiAVgdO+OkBjdYUI
         rnCFTCJ79MCPQYvscxsqlEhgyzfcxFIxOYSQgKU9VZS+aTfF37BxzlMe6GTnazs1Mx4m
         ApAl4Wd4txKXF87222gmad6SBFBIomJm1S3m+152CZBm7Vbpny4gEikyfzGKGhdWk66O
         6ieQ==
X-Gm-Message-State: AOJu0YylNHOw1YoWkiVwtUEFFuejsIk2x6NQBg7fs8cv1yV+k3yneC6u
	VMLJENy8wu8c0/qgS5l53/D/VBItFZ0=
X-Google-Smtp-Source: AGHT+IHZETAW1s8ujp0k9cS6bAiljs9rByywkGNrFftspT7zyHavqkkeUSwxpcNgbbiSt1OLj9lGpA==
X-Received: by 2002:a05:6870:6f0e:b0:1d6:b7aa:c6ed with SMTP id qw14-20020a0568706f0e00b001d6b7aac6edmr22320002oab.56.1699021623128;
        Fri, 03 Nov 2023 07:27:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:27:00 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 08/22] hashserv: Add SQLalchemy backend
Date: Fri,  3 Nov 2023 08:26:26 -0600
Message-Id: <20231103142640.1936827-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15429

Adds an SQLAlchemy backend to the server. While this database backend is
slower than the more direct sqlite backend, it easily supports just
about any SQL server, which is useful for large scale deployments.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashserv          |  12 ++
 lib/bb/asyncrpc/connection.py |  11 +-
 lib/hashserv/__init__.py      |  21 ++-
 lib/hashserv/sqlalchemy.py    | 304 ++++++++++++++++++++++++++++++++++
 lib/hashserv/tests.py         |  19 ++-
 5 files changed, 362 insertions(+), 5 deletions(-)
 create mode 100644 lib/hashserv/sqlalchemy.py

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index a916a90c..59b8b07f 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -69,6 +69,16 @@ To bind to all addresses, leave the ADDRESS empty, e.g. "--bind :8686" or
         action="store_true",
         help="Disallow write operations from clients ($HASHSERVER_READ_ONLY)",
     )
+    parser.add_argument(
+        "--db-username",
+        default=os.environ.get("HASHSERVER_DB_USERNAME", None),
+        help="Database username ($HASHSERVER_DB_USERNAME)",
+    )
+    parser.add_argument(
+        "--db-password",
+        default=os.environ.get("HASHSERVER_DB_PASSWORD", None),
+        help="Database password ($HASHSERVER_DB_PASSWORD)",
+    )
 
     args = parser.parse_args()
 
@@ -90,6 +100,8 @@ To bind to all addresses, leave the ADDRESS empty, e.g. "--bind :8686" or
         args.database,
         upstream=args.upstream,
         read_only=read_only,
+        db_username=args.db_username,
+        db_password=args.db_password,
     )
     server.serve_forever()
     return 0
diff --git a/lib/bb/asyncrpc/connection.py b/lib/bb/asyncrpc/connection.py
index a10628f7..7f0cf6ba 100644
--- a/lib/bb/asyncrpc/connection.py
+++ b/lib/bb/asyncrpc/connection.py
@@ -7,6 +7,7 @@
 import asyncio
 import itertools
 import json
+from datetime import datetime
 from .exceptions import ClientError, ConnectionClosedError
 
 
@@ -30,6 +31,12 @@ def chunkify(msg, max_chunk):
         yield "\n"
 
 
+def json_serialize(obj):
+    if isinstance(obj, datetime):
+        return obj.isoformat()
+    raise TypeError("Type %s not serializeable" % type(obj))
+
+
 class StreamConnection(object):
     def __init__(self, reader, writer, timeout, max_chunk=DEFAULT_MAX_CHUNK):
         self.reader = reader
@@ -42,7 +49,7 @@ class StreamConnection(object):
         return self.writer.get_extra_info("peername")
 
     async def send_message(self, msg):
-        for c in chunkify(json.dumps(msg), self.max_chunk):
+        for c in chunkify(json.dumps(msg, default=json_serialize), self.max_chunk):
             self.writer.write(c.encode("utf-8"))
         await self.writer.drain()
 
@@ -105,7 +112,7 @@ class WebsocketConnection(object):
         return ":".join(str(s) for s in self.socket.remote_address)
 
     async def send_message(self, msg):
-        await self.send(json.dumps(msg))
+        await self.send(json.dumps(msg, default=json_serialize))
 
     async def recv_message(self):
         m = await self.recv()
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index 90d8cff1..9a8ee4e8 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -35,15 +35,32 @@ def parse_address(addr):
         return (ADDR_TYPE_TCP, (host, int(port)))
 
 
-def create_server(addr, dbname, *, sync=True, upstream=None, read_only=False):
+def create_server(
+    addr,
+    dbname,
+    *,
+    sync=True,
+    upstream=None,
+    read_only=False,
+    db_username=None,
+    db_password=None
+):
     def sqlite_engine():
         from .sqlite import DatabaseEngine
 
         return DatabaseEngine(dbname, sync)
 
+    def sqlalchemy_engine():
+        from .sqlalchemy import DatabaseEngine
+
+        return DatabaseEngine(dbname, db_username, db_password)
+
     from . import server
 
-    db_engine = sqlite_engine()
+    if "://" in dbname:
+        db_engine = sqlalchemy_engine()
+    else:
+        db_engine = sqlite_engine()
 
     s = server.Server(db_engine, upstream=upstream, read_only=read_only)
 
diff --git a/lib/hashserv/sqlalchemy.py b/lib/hashserv/sqlalchemy.py
new file mode 100644
index 00000000..3216621f
--- /dev/null
+++ b/lib/hashserv/sqlalchemy.py
@@ -0,0 +1,304 @@
+#! /usr/bin/env python3
+#
+# Copyright (C) 2023 Garmin Ltd.
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import logging
+from datetime import datetime
+
+from sqlalchemy.ext.asyncio import create_async_engine
+from sqlalchemy.pool import NullPool
+from sqlalchemy import (
+    MetaData,
+    Column,
+    Table,
+    Text,
+    Integer,
+    UniqueConstraint,
+    DateTime,
+    Index,
+    select,
+    insert,
+    exists,
+    literal,
+    and_,
+    delete,
+)
+import sqlalchemy.engine
+from sqlalchemy.orm import declarative_base
+from sqlalchemy.exc import IntegrityError
+
+logger = logging.getLogger("hashserv.sqlalchemy")
+
+Base = declarative_base()
+
+
+class UnihashesV2(Base):
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
+class OuthashesV2(Base):
+    __tablename__ = "outhashes_v2"
+    id = Column(Integer, primary_key=True, autoincrement=True)
+    method = Column(Text, nullable=False)
+    taskhash = Column(Text, nullable=False)
+    outhash = Column(Text, nullable=False)
+    created = Column(DateTime)
+    owner = Column(Text)
+    PN = Column(Text)
+    PV = Column(Text)
+    PR = Column(Text)
+    task = Column(Text)
+    outhash_siginfo = Column(Text)
+
+    __table_args__ = (
+        UniqueConstraint("method", "taskhash", "outhash"),
+        Index("outhash_lookup_v3", "method", "outhash"),
+    )
+
+
+class DatabaseEngine(object):
+    def __init__(self, url, username=None, password=None):
+        self.logger = logger
+        self.url = sqlalchemy.engine.make_url(url)
+
+        if username is not None:
+            self.url = self.url.set(username=username)
+
+        if password is not None:
+            self.url = self.url.set(password=password)
+
+    async def create(self):
+        self.logger.info("Using database %s", self.url)
+        self.engine = create_async_engine(self.url, poolclass=NullPool)
+
+        async with self.engine.begin() as conn:
+            # Create tables
+            logger.info("Creating tables...")
+            await conn.run_sync(Base.metadata.create_all)
+
+    def connect(self, logger):
+        return Database(self.engine, logger)
+
+
+def map_row(row):
+    if row is None:
+        return None
+    return dict(**row._mapping)
+
+
+class Database(object):
+    def __init__(self, engine, logger):
+        self.engine = engine
+        self.db = None
+        self.logger = logger
+
+    async def __aenter__(self):
+        self.db = await self.engine.connect()
+        return self
+
+    async def __aexit__(self, exc_type, exc_value, traceback):
+        await self.close()
+
+    async def close(self):
+        await self.db.close()
+        self.db = None
+
+    async def get_unihash_by_taskhash_full(self, method, taskhash):
+        statement = (
+            select(
+                OuthashesV2,
+                UnihashesV2.unihash.label("unihash"),
+            )
+            .join(
+                UnihashesV2,
+                and_(
+                    UnihashesV2.method == OuthashesV2.method,
+                    UnihashesV2.taskhash == OuthashesV2.taskhash,
+                ),
+            )
+            .where(
+                OuthashesV2.method == method,
+                OuthashesV2.taskhash == taskhash,
+            )
+            .order_by(
+                OuthashesV2.created.asc(),
+            )
+            .limit(1)
+        )
+        self.logger.debug("%s", statement)
+        async with self.db.begin():
+            result = await self.db.execute(statement)
+            return map_row(result.first())
+
+    async def get_unihash_by_outhash(self, method, outhash):
+        statement = (
+            select(OuthashesV2, UnihashesV2.unihash.label("unihash"))
+            .join(
+                UnihashesV2,
+                and_(
+                    UnihashesV2.method == OuthashesV2.method,
+                    UnihashesV2.taskhash == OuthashesV2.taskhash,
+                ),
+            )
+            .where(
+                OuthashesV2.method == method,
+                OuthashesV2.outhash == outhash,
+            )
+            .order_by(
+                OuthashesV2.created.asc(),
+            )
+            .limit(1)
+        )
+        self.logger.debug("%s", statement)
+        async with self.db.begin():
+            result = await self.db.execute(statement)
+            return map_row(result.first())
+
+    async def get_outhash(self, method, outhash):
+        statement = (
+            select(OuthashesV2)
+            .where(
+                OuthashesV2.method == method,
+                OuthashesV2.outhash == outhash,
+            )
+            .order_by(
+                OuthashesV2.created.asc(),
+            )
+            .limit(1)
+        )
+
+        self.logger.debug("%s", statement)
+        async with self.db.begin():
+            result = await self.db.execute(statement)
+            return map_row(result.first())
+
+    async def get_equivalent_for_outhash(self, method, outhash, taskhash):
+        statement = (
+            select(
+                OuthashesV2.taskhash.label("taskhash"),
+                UnihashesV2.unihash.label("unihash"),
+            )
+            .join(
+                UnihashesV2,
+                and_(
+                    UnihashesV2.method == OuthashesV2.method,
+                    UnihashesV2.taskhash == OuthashesV2.taskhash,
+                ),
+            )
+            .where(
+                OuthashesV2.method == method,
+                OuthashesV2.outhash == outhash,
+                OuthashesV2.taskhash != taskhash,
+            )
+            .order_by(
+                OuthashesV2.created.asc(),
+            )
+            .limit(1)
+        )
+        self.logger.debug("%s", statement)
+        async with self.db.begin():
+            result = await self.db.execute(statement)
+            return map_row(result.first())
+
+    async def get_equivalent(self, method, taskhash):
+        statement = select(
+            UnihashesV2.unihash,
+            UnihashesV2.method,
+            UnihashesV2.taskhash,
+        ).where(
+            UnihashesV2.method == method,
+            UnihashesV2.taskhash == taskhash,
+        )
+        self.logger.debug("%s", statement)
+        async with self.db.begin():
+            result = await self.db.execute(statement)
+            return map_row(result.first())
+
+    async def remove(self, condition):
+        async def do_remove(table):
+            where = {}
+            for c in table.__table__.columns:
+                if c.key in condition and condition[c.key] is not None:
+                    where[c] = condition[c.key]
+
+            if where:
+                statement = delete(table).where(*[(k == v) for k, v in where.items()])
+                self.logger.debug("%s", statement)
+                async with self.db.begin():
+                    result = await self.db.execute(statement)
+                return result.rowcount
+
+            return 0
+
+        count = 0
+        count += await do_remove(UnihashesV2)
+        count += await do_remove(OuthashesV2)
+
+        return count
+
+    async def clean_unused(self, oldest):
+        statement = delete(OuthashesV2).where(
+            OuthashesV2.created < oldest,
+            ~(
+                select(UnihashesV2.id)
+                .where(
+                    UnihashesV2.method == OuthashesV2.method,
+                    UnihashesV2.taskhash == OuthashesV2.taskhash,
+                )
+                .limit(1)
+                .exists()
+            ),
+        )
+        self.logger.debug("%s", statement)
+        async with self.db.begin():
+            result = await self.db.execute(statement)
+            return result.rowcount
+
+    async def insert_unihash(self, method, taskhash, unihash):
+        statement = insert(UnihashesV2).values(
+            method=method,
+            taskhash=taskhash,
+            unihash=unihash,
+        )
+        self.logger.debug("%s", statement)
+        try:
+            async with self.db.begin():
+                await self.db.execute(statement)
+            return True
+        except IntegrityError:
+            logger.debug(
+                "%s, %s, %s already in unihash database", method, taskhash, unihash
+            )
+            return False
+
+    async def insert_outhash(self, data):
+        outhash_columns = set(c.key for c in OuthashesV2.__table__.columns)
+
+        data = {k: v for k, v in data.items() if k in outhash_columns}
+
+        if "created" in data and not isinstance(data["created"], datetime):
+            data["created"] = datetime.fromisoformat(data["created"])
+
+        statement = insert(OuthashesV2).values(**data)
+        self.logger.debug("%s", statement)
+        try:
+            async with self.db.begin():
+                await self.db.execute(statement)
+            return True
+        except IntegrityError:
+            logger.debug(
+                "%s, %s already in outhash database", data["method"], data["outhash"]
+            )
+            return False
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 4c98a280..268b2700 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -33,7 +33,7 @@ class HashEquivalenceTestSetup(object):
     def start_server(self, dbpath=None, upstream=None, read_only=False, prefunc=server_prefunc):
         self.server_index += 1
         if dbpath is None:
-            dbpath = os.path.join(self.temp_dir.name, "db%d.sqlite" % self.server_index)
+            dbpath = self.make_dbpath()
 
         def cleanup_server(server):
             if server.process.exitcode is not None:
@@ -53,6 +53,9 @@ class HashEquivalenceTestSetup(object):
 
         return server
 
+    def make_dbpath(self):
+        return os.path.join(self.temp_dir.name, "db%d.sqlite" % self.server_index)
+
     def start_client(self, server_address):
         def cleanup_client(client):
             client.close()
@@ -517,6 +520,20 @@ class TestHashEquivalenceWebsocketServer(HashEquivalenceTestSetup, HashEquivalen
         return "ws://%s:0" % host
 
 
+class TestHashEquivalenceWebsocketsSQLAlchemyServer(TestHashEquivalenceWebsocketServer):
+    def setUp(self):
+        try:
+            import sqlalchemy
+            import aiosqlite
+        except ImportError as e:
+            self.skipTest(str(e))
+
+        super().setUp()
+
+    def make_dbpath(self):
+        return "sqlite+aiosqlite:///%s" % os.path.join(self.temp_dir.name, "db%d.sqlite" % self.server_index)
+
+
 class TestHashEquivalenceExternalServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def start_test_server(self):
         if 'BB_TEST_HASHSERV' not in os.environ:
-- 
2.34.1


