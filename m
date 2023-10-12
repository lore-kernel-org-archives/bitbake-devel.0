Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931B7C46CA1
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:35 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.web10.25790.1697149049507714925
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DYUHvRKU;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6b9e478e122so989482a34.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149048; x=1697753848; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSDSG3Dg+JN4GnAyfTlVrpEEMpbAuqYRiYgrqeNE0B0=;
        b=DYUHvRKURtSCQTU37HZy3KIrZb+MxX8LRWU9Eknf1M5nYeckEAX0VQbVXAXit3sSBA
         XjN6N4pfffKTUTLVLJUxZeB4oAJc8xUFI0TWRcxlp56n8q92sJLGiNJniuxxI34G0S/n
         cdDevAv8pZxPn1GDdRYTWvy/52B/vT5W85e275/zuU7WqnXXwhTweJo8HXYdOFZU9lu7
         D/oBPMK0DZraBUO4jtqSel9PYKcQD68kUGKkiBoqZdrVH2ZxDOLN/2ml1JtNAiDe2lMR
         A6fygAAilfkzGtFsecnJXEeILKM128Ddc4Bs/K+FDw3c1USNUAbKKXnwwxTPJMtWqSrB
         sKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149048; x=1697753848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSDSG3Dg+JN4GnAyfTlVrpEEMpbAuqYRiYgrqeNE0B0=;
        b=MR7FfOUhrf5Amd5K8ZxGdO0wKy2pbB8M05dPVyVer0AQNtRIluQPQ/PRQuitxZ9B5v
         Bqh+bNDIxOzpHDT9yLyAh0az+GEid3CC6FivzPqCWrAlPQz4/kB2oLduH7XaWpwxxl13
         D+RgNFknXf8WRlvlhC+z2N0xHihnA52TU5uAF2dEhgZw3RGqeUfmY1dJRttfZuAe+Z4d
         oVzpSxdb9iF+CPdeLqCM708n7A7e736dpcwq8T8j5n3pOeka2I4JVeT+Xt8nQ0Yjq2Nd
         QzowoO2i+PLE4Ek3KgSAbNUgJIRCCT0dhjE2aUuwQ+7P1boG01Vmn1d8n5W/fFYXyqQN
         rHIg==
X-Gm-Message-State: AOJu0YxU0uOtYV1HRGYlGwNVokYxl07wPGgN+C7pjEM61ejb0w8SON8v
	/BsWkm5paXPPA5x2tOjiaZi0I8wENr4=
X-Google-Smtp-Source: AGHT+IHM5DwkA/F0BP9/Ftm1NRRMJ8X2/Q9YT1X2CLfB3zL1LZ4U+UALGOcfh1rlhFprWlHbnwQdQQ==
X-Received: by 2002:a05:6871:8905:b0:1e9:924a:7382 with SMTP id ti5-20020a056871890500b001e9924a7382mr6456010oab.3.1697149048055;
        Thu, 12 Oct 2023 15:17:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:26 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 17/18] hashserv: Add db-usage API
Date: Thu, 12 Oct 2023 16:16:54 -0600
Message-Id: <20231012221655.632637-18-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
 <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15235

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
index 4b3dfcd6..b9a6ba62 100755
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


