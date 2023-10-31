Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBCAC4167D
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:23 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web10.1625.1698772933719837323
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iztlls60;
 spf=pass (domain: gmail.com, ip: 209.85.210.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ce2c71c61fso3428065a34.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772932; x=1699377732; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D16wZJQUUheeclWS5b/Afohjd7R2MAChGFIfCVFmAS4=;
        b=iztlls60AW0wc+Xc5W0MaW3bSgmvCDceKoS98yGlirwhDPcbPbn1Tp0TdlDJy9PL8A
         N1EJ8/jxbZmZEMejLzRZgYCrZfSS248BnyfH7yjEhhJTSyvGko0ckPlE+Tsw+qgrHHp6
         xJPV6WkwbkTo4spT3BA0XX97pZ0JzbKfPmf1oNAkHhpRuiiznowUCZYzgPCMNhkEgIjJ
         rzjCDAGVba+TV7I+oxs6HXvj2oPyoJjXUDX3GcHUdJ7GqFfj1PealStVoIUlz1XZt3J4
         XQNOIb0K4Mg/GxBqn6LQU9n5Sg/N47qaRHhDQ0GexDg+SpVBKX1vEVBgMfcf/0SFVIjw
         bFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772932; x=1699377732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D16wZJQUUheeclWS5b/Afohjd7R2MAChGFIfCVFmAS4=;
        b=n/we4Y+HQqJ1Tm7h3D4MQD5LouN0GFt2N+FFrFVrQs1/WXgxcOJCdAP5VNV8IN/esX
         ElxMlzlazdFb2huNHpgZRKdQ3/3C3zOp6wBN8dwDnKrm94XS0iwaidU36Kd5qlI0dLjB
         JHn9UttrN87JGMyhWNOnmHcMLcG8JwdXot+YUQPBgsjXYQxI9UnfaF5l6gPG+ODDCaav
         75vqatXPb32UMuzCWwlzR+6ZhNewwFeNs6dzVyzMj9ynjeNkmTX2d3T9OqjT7zqooYrN
         UOPQRZmhQlF0Na1+lKdtNbumHL8fLAIE4fj3OvjugSKLbdukqxgfLLQ5+gg2zuAtU1FK
         bKWA==
X-Gm-Message-State: AOJu0YwAG14h6FaxOqZi1ePuAePUhRMROi0MbPSrlryJjxOLe0xMQS2L
	fS+zkrSba+vfJFqoKbIcYu8og2MjqFU=
X-Google-Smtp-Source: AGHT+IFWaFiOMfHEjHI6R3KbzrVjuJiTYpioACUNKMg9j+TZaEOFlb7jHntfuedYNduc7z59jY0sLg==
X-Received: by 2002:a05:6830:4ac:b0:6ce:25a2:67cf with SMTP id l12-20020a05683004ac00b006ce25a267cfmr11627874otd.26.1698772932444;
        Tue, 31 Oct 2023 10:22:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:10 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 15/22] hashserv: Add db-usage API
Date: Tue, 31 Oct 2023 11:21:31 -0600
Message-Id: <20231031172138.3577199-16-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:22:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15365

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
index 90f1dd71..0c3f556a 100644
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
index d506088e..4fec1556 100644
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


