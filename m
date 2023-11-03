Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786CBC4167D
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:26 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web10.53510.1699021638118239464
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JVPdcbXf;
 spf=pass (domain: gmail.com, ip: 209.85.160.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso1324725fac.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021636; x=1699626436; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb8iK/Y6YdNqremG9hKssbuZYvDNejD04JGcUDsq4KE=;
        b=JVPdcbXf3unhB5N8sprlUMzqByfxr4J+fmr+nig31RDbpFd8bLpGAxAsdkp7Jb+i/k
         UeSKz613KhqoTdovprnuFnAORhgITJq4W6g6YijOrQz4un7lXTrm6Z4isnskHEocArW0
         IOKAp6/wlhAmcwdkaPhDHEKzfeyXAQnZ/DhwlOLC/do6YkZaY2qBJOM83YqTlawQjAj3
         FegJKcMXNRGclzpjFn+Bx/R2Qm4cW70uXNygQrgINK5bG3Du8+zyaFDg9XxufMrP6CaD
         0XikYpwP+IewT26hA0MDqp5z1FjcwCzQqbEmq5WAplRDP3RhlO4PwcdaiqKA9Y6bqRgy
         0xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021636; x=1699626436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hb8iK/Y6YdNqremG9hKssbuZYvDNejD04JGcUDsq4KE=;
        b=cuv74g5rwM0NyfZTp0INp82oGUbEwzQJYeqnJhCXjDymA41fGncsConlfU6ScJoMoI
         JRLpTlQlWF27g6hw0SxUbBwXTlV6siApdtNYcHg7krYSvZVkddB1i1weCE697IjGBQBL
         PM3QbUmuVCfCXFEAXrUdN59dID8CVQmssCl0ra632n7UVVAp3EfsWqTo7pXnZjEoN800
         QCSfgCqbSRKDxyeqX58tU25mwbjjDNb/a7xSd+hir7fQpcrqpHgG9DkiKJ0VWHdRWwE9
         sPygVzQocs9JsI3H7BM1WnopAd9QrNrKEUIu/INb+hs+TLzU8fZKwbVnbgRf6R9mAZDe
         Wvsw==
X-Gm-Message-State: AOJu0YxTo+st3JrYZQswCM96DGtIUX74KFz99OOQxgMBJZG0Aiv1Ubr3
	i1QCQgk9Xboy+W1hOKNU+piBC4vwAfo=
X-Google-Smtp-Source: AGHT+IENkew9kaZ6TDj8X5t2G7HgfmDFGuU4yFFuQGaNlXlQa6V8AzayzoXTbHAvwtWLJrwhj/SDxQ==
X-Received: by 2002:a05:6870:bf0b:b0:1e9:54ef:4806 with SMTP id qh11-20020a056870bf0b00b001e954ef4806mr26153580oab.9.1699021636316;
        Fri, 03 Nov 2023 07:27:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:27:13 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 15/22] hashserv: Add db-usage API
Date: Fri,  3 Nov 2023 08:26:33 -0600
Message-Id: <20231103142640.1936827-16-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15436

Adds an API to query the server for the usage of the database (e.g. how
many rows are present in each table)

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashclient     | 16 ++++++++++++++++
 lib/hashserv/client.py     |  5 +++++
 lib/hashserv/server.py     |  5 +++++
 lib/hashserv/sqlalchemy.py | 14 ++++++++++++++
 lib/hashserv/sqlite.py     | 37 +++++++++++++++++++++++++++++++++++++
 lib/hashserv/tests.py      |  9 +++++++++
 6 files changed, 86 insertions(+)

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
index 4457f8e5..5e0a462b 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -186,6 +186,10 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
             self.saved_become_user = username
         return result
 
+    async def get_db_usage(self):
+        await self._set_mode(self.MODE_NORMAL)
+        return (await self.invoke({"get-db-usage": {}}))["usage"]
+
 
 class Client(bb.asyncrpc.Client):
     def __init__(self, username=None, password=None):
@@ -214,6 +218,7 @@ class Client(bb.asyncrpc.Client):
             "new_user",
             "delete_user",
             "become_user",
+            "get_db_usage",
         )
 
     def _get_async_client(self):
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index ca419a1a..c5b9797e 100644
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
@@ -567,6 +568,10 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
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
index 414ee8ff..dfdccbba 100644
--- a/lib/hashserv/sqlite.py
+++ b/lib/hashserv/sqlite.py
@@ -120,6 +120,18 @@ class Database(object):
         self.db = sqlite3.connect(self.dbname)
         self.db.row_factory = sqlite3.Row
 
+        with closing(self.db.cursor()) as cursor:
+            cursor.execute("SELECT sqlite_version()")
+
+            version = []
+            for v in cursor.fetchone()[0].split("."):
+                try:
+                    version.append(int(v))
+                except ValueError:
+                    version.append(v)
+
+            self.sqlite_version = tuple(version)
+
     async def __aenter__(self):
         return self
 
@@ -362,3 +374,28 @@ class Database(object):
             )
             self.db.commit()
             return cursor.rowcount != 0
+
+    async def get_usage(self):
+        usage = {}
+        with closing(self.db.cursor()) as cursor:
+            if self.sqlite_version >= (3, 33):
+                table_name = "sqlite_schema"
+            else:
+                table_name = "sqlite_master"
+
+            cursor.execute(
+                f"""
+                SELECT name FROM {table_name} WHERE type = 'table' AND name NOT LIKE 'sqlite_%'
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


