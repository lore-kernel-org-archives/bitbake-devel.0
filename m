Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF2DC4332F
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:24 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.web11.158497.1698693494446206101
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nGFZ0Njm;
 spf=pass (domain: gmail.com, ip: 209.85.160.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1e19cb7829bso2990804fac.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693493; x=1699298293; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQsBo0WyvHA4AgVi0IMOtsw3HbxNSWPhOVqH6gtRtFE=;
        b=nGFZ0NjmlFe4FQpYbmXYjq2D5miuypkFl/9gfoWOhideUH/sI9z9swHOPY6vZF6Egl
         YyfSymCKw91pOUZvq1zfGieist4MKiJf2VsYUAYW0ITcsRZoNI8r+BZSwGvetNUuUobV
         lqtOhUmG/R60WR2iBPjPbyYUg26zFsZ+M/OH8sqHeFf+vr9JLN9bYnx3PI8eB3FogPk+
         wslDtflc/Q3E3xuj3n/HTQ9QNCV+vX2MRqh76pbSU40pgu93Tr6VwvPWtBsZLgrv8xsn
         F30zlwNKV3che2F2OlM43AU+zTeX4BzDbekagJAi7xGb00SgiwEI5xnx2+4vDe+3ywVo
         x3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693493; x=1699298293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQsBo0WyvHA4AgVi0IMOtsw3HbxNSWPhOVqH6gtRtFE=;
        b=Ix2ZwgSUDyB4BCHhkRyHhm+bVCrV2R1KXveatYdRtc07Ts8KQ+J7jufyvkVh3NnFWQ
         nSPJCuDqf57Kjdrfk78GQPXvM2YyO12tYsixSmLB2QwnVc+ycJirH1CI7wGBI+XXXn2K
         ZD4SiYXnR2t7Cpp/WAeWwTbNZT9A2icb5hHkAUsbdF+ASiw48j+UtoRsnCEkpAxswf+p
         L3H9ZiWpUQJu3gbrTVW++IbuwzRtafZwXnF4NnmvIFGgfx4Jnou8I7yMvk14XyNtfUu9
         AkHayO9IVjbirfLnm2wyeI78De18PYElc8ErS98IsPmbGXu1cjU1bWwMe2L0l0JllRio
         +iHA==
X-Gm-Message-State: AOJu0YzuXkUEeu5OlTfxqloMgipqoXWlcqTUmYSVsvne7hRyCFQzoN0G
	QLscb9s3QRwZ2f4uKEBTb7G+hWSzN78=
X-Google-Smtp-Source: AGHT+IGN/Y1TPh/xEUoRqdIwCQhRoHtuDysKJLfOMLPpuQuL8MLbS8z5y9Uaq3F6IRAECXDDwKK+oQ==
X-Received: by 2002:a05:6870:b8b:b0:1d6:cbcd:80f8 with SMTP id lg11-20020a0568700b8b00b001d6cbcd80f8mr15201661oab.54.1698693493142;
        Mon, 30 Oct 2023 12:18:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:18:12 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 15/22] hashserv: Add db-usage API
Date: Mon, 30 Oct 2023 13:17:21 -0600
Message-Id: <20231030191728.1276805-16-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15317

Adds an API to query the server for the usage of the database (e.g. how
many rows are present in each table)

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashclient     | 16 ++++++++++++++++
 lib/hashserv/client.py     |  5 +++++
 lib/hashserv/server.py     |  5 +++++
 lib/hashserv/sqlalchemy.py | 14 ++++++++++++++
 lib/hashserv/sqlite.py     | 20 ++++++++++++++++++++
 lib/hashserv/tests.py      |  9 +++++++++
 6 files changed, 69 insertions(+)

diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
index cfbc197e..5d65c7bc 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -161,6 +161,19 @@ def main():
         r = client.delete_user(args.username)
         print_user(r)
 
+    def handle_get_db_usage(args, client):
+        usage = client.get_db_usage()
+        print(usage)
+        tables = sorted(usage.keys())
+        print("{name:20}| {rows:20}".format(name="Table name", rows="Rows"))
+        print(("-" * 20) + "+" + ("-" * 20))
+        for t in tables:
+            print("{name:20}| {rows:<20}".format(name=t, rows=usage[t]["rows"]))
+        print()
+
+        total_rows = sum(t["rows"] for t in usage.values())
+        print(f"Total rows: {total_rows}")
+
     parser = argparse.ArgumentParser(description='Hash Equivalence Client')
     parser.add_argument('--address', default=DEFAULT_ADDRESS, help='Server address (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
@@ -223,6 +236,9 @@ def main():
     delete_user_parser.add_argument("--username", "-u", help="Username", required=True)
     delete_user_parser.set_defaults(func=handle_delete_user)
 
+    db_usage_parser = subparsers.add_parser('get-db-usage', help="Database Usage")
+    db_usage_parser.set_defaults(func=handle_get_db_usage)
+
     args = parser.parse_args()
 
     logger = logging.getLogger('hashserv')
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 0a281a9b..0fda376f 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -194,6 +194,10 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
             self.saved_become_user = username
         return result
 
+    async def get_db_usage(self):
+        await self._set_mode(self.MODE_NORMAL)
+        return (await self.invoke({"get-db-usage": {}}))["usage"]
+
 
 class Client(bb.asyncrpc.Client):
     def __init__(self, username=None, password=None):
@@ -222,6 +226,7 @@ class Client(bb.asyncrpc.Client):
             "new_user",
             "delete_user",
             "become_user",
+            "get_db_usage",
         )
 
     def _get_async_client(self):
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 7bac7ab3..0e36d13c 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -249,6 +249,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 "get-outhash": self.handle_get_outhash,
                 "get-stream": self.handle_get_stream,
                 "get-stats": self.handle_get_stats,
+                "get-db-usage": self.handle_get_db_usage,
                 # Not always read-only, but internally checks if the server is
                 # read-only
                 "report": self.handle_report,
@@ -566,6 +567,10 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         oldest = datetime.now() - timedelta(seconds=-max_age)
         return {"count": await self.db.clean_unused(oldest)}
 
+    @permissions(DB_ADMIN_PERM)
+    async def handle_get_db_usage(self, request):
+        return {"usage": await self.db.get_usage()}
+
     # The authentication API is always allowed
     async def handle_auth(self, request):
         username = str(request["username"])
diff --git a/lib/hashserv/sqlalchemy.py b/lib/hashserv/sqlalchemy.py
index bfd8a844..818b5195 100644
--- a/lib/hashserv/sqlalchemy.py
+++ b/lib/hashserv/sqlalchemy.py
@@ -27,6 +27,7 @@ from sqlalchemy import (
     and_,
     delete,
     update,
+    func,
 )
 import sqlalchemy.engine
 from sqlalchemy.orm import declarative_base
@@ -401,3 +402,16 @@ class Database(object):
         async with self.db.begin():
             result = await self.db.execute(statement)
             return result.rowcount != 0
+
+    async def get_usage(self):
+        usage = {}
+        async with self.db.begin() as session:
+            for name, table in Base.metadata.tables.items():
+                statement = select(func.count()).select_from(table)
+                self.logger.debug("%s", statement)
+                result = await self.db.execute(statement)
+                usage[name] = {
+                    "rows": result.scalar(),
+                }
+
+        return usage
diff --git a/lib/hashserv/sqlite.py b/lib/hashserv/sqlite.py
index 414ee8ff..e9ef38a1 100644
--- a/lib/hashserv/sqlite.py
+++ b/lib/hashserv/sqlite.py
@@ -362,3 +362,23 @@ class Database(object):
             )
             self.db.commit()
             return cursor.rowcount != 0
+
+    async def get_usage(self):
+        usage = {}
+        with closing(self.db.cursor()) as cursor:
+            cursor.execute(
+                """
+                SELECT name FROM sqlite_schema WHERE type = 'table' AND name NOT LIKE 'sqlite_%'
+                """
+            )
+            for row in cursor.fetchall():
+                cursor.execute(
+                    """
+                    SELECT COUNT() FROM %s
+                    """
+                    % row["name"],
+                )
+                usage[row["name"]] = {
+                    "rows": cursor.fetchone()[0],
+                }
+        return usage
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 311b7b77..9d5bec24 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -767,6 +767,15 @@ class HashEquivalenceCommonTests(object):
         with self.auth_perms("@user-admin") as client:
             become = client.become_user(client.username)
 
+    def test_get_db_usage(self):
+        usage = self.client.get_db_usage()
+
+        self.assertTrue(isinstance(usage, dict))
+        for name in usage.keys():
+            self.assertTrue(isinstance(usage[name], dict))
+            self.assertIn("rows", usage[name])
+            self.assertTrue(isinstance(usage[name]["rows"], int))
+
 
 class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def get_server_addr(self, server_idx):
-- 
2.34.1


