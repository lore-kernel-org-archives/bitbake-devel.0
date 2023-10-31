Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28134C00142
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:23 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web11.1684.1698772935682877983
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nopzWw51;
 spf=pass (domain: gmail.com, ip: 209.85.210.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6cd0963c61cso3432410a34.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772934; x=1699377734; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUnedVAxRmMAT3UbkWGY1JpPq9ofGhafvHwwR+X70e4=;
        b=nopzWw513go7PoJcmmsitaJawlci8yatEtZNJD9ZvIVq0RcgAcSFg70IX38K7MwpKG
         NWsQJpqv3iEwfWwu1Fh64BmORm9yqH7XTKZWH/e5BN9FTJBqNvcr4DhUfezTloD+b3dH
         X39Z7XhxUr1lXNlGvrKCqIm1vj5FX6301qkY3qZ8cQg+sSfQy59789nNk3BwSZExeL5P
         mmo73Icm2yxUALoDnI+1dvUDOFg+mkgPB8vBre1+lUFPL6bFloG5/6SOmzOHJ+/f8pxl
         Nw+MMa3+Z1Kao62z8jlvKYMg/8H/PwOugFv+TkoneSwkwhW1tg13YWFfex2sGcnTeAYL
         R7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772934; x=1699377734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUnedVAxRmMAT3UbkWGY1JpPq9ofGhafvHwwR+X70e4=;
        b=qUHvSHEw2+/BJ4c0V7oL6X5nFJgcI1+/J85SPenrq2QHKVxurg+7eNYX/RS7H161Bc
         AP5TQ5czYxkByDQciAUMpzM2B2W26ZQIutjXgaqdOLWhS8RxX8MqbZwe3okFtsLXIdzF
         wVRapf+O1i/a2ZlewnAfsMc+TpfDzU0q+KLJTWvMXiEmQiI6zm4Lb9rnc1UwAadPxvwR
         nAVlaFVPs4jYnkhngjVJax0tF73xKnEHRl+qNUsJBU7N3n6mNX6Rvx782T2JDtHawS+s
         9fqhU/pTGP8eqCLbRkOiOPSUe6CCJXTSvk5IXfIFABSnZ/0VbOU8nNlIV0ikiG3pwDNo
         ErQA==
X-Gm-Message-State: AOJu0YxflzcHnhp1G0DxfA+WuoA3fjrC5WotQGOEQXW5obgOd0uSRxFi
	4tr2w92gj7OlB9w9EDgq8h72eTeMQoM=
X-Google-Smtp-Source: AGHT+IGVn/FIWS5nPkgwgJeq1hQTlN8yHHgbTFx3Twirg8B2Vr+ewuTVBzKYlT8z1vSmca9QXqN0qQ==
X-Received: by 2002:a9d:7d8c:0:b0:6b9:9bcd:32fe with SMTP id j12-20020a9d7d8c000000b006b99bcd32femr11620106otn.17.1698772933874;
        Tue, 31 Oct 2023 10:22:13 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:12 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 16/22] hashserv: Add database column query API
Date: Tue, 31 Oct 2023 11:21:32 -0600
Message-Id: <20231031172138.3577199-17-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15366

Adds an API to retrieve the columns that can be queried on from the
database backend. This prevents front end applications from needing to
hardcode the query columns

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashclient     |  7 +++++++
 lib/hashserv/client.py     |  5 +++++
 lib/hashserv/server.py     |  5 +++++
 lib/hashserv/sqlalchemy.py | 10 ++++++++++
 lib/hashserv/sqlite.py     |  7 +++++++
 lib/hashserv/tests.py      |  8 ++++++++
 6 files changed, 42 insertions(+)

diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
index 5d65c7bc..58aa02ee 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -174,6 +174,10 @@ def main():
         total_rows = sum(t["rows"] for t in usage.values())
         print(f"Total rows: {total_rows}")
 
+    def handle_get_db_query_columns(args, client):
+        columns = client.get_db_query_columns()
+        print("\n".join(sorted(columns)))
+
     parser = argparse.ArgumentParser(description='Hash Equivalence Client')
     parser.add_argument('--address', default=DEFAULT_ADDRESS, help='Server address (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
@@ -239,6 +243,9 @@ def main():
     db_usage_parser = subparsers.add_parser('get-db-usage', help="Database Usage")
     db_usage_parser.set_defaults(func=handle_get_db_usage)
 
+    db_query_columns_parser = subparsers.add_parser('get-db-query-columns', help="Show columns that can be used in database queries")
+    db_query_columns_parser.set_defaults(func=handle_get_db_query_columns)
+
     args = parser.parse_args()
 
     logger = logging.getLogger('hashserv')
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 0c3f556a..319da2d9 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -190,6 +190,10 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         await self._set_mode(self.MODE_NORMAL)
         return (await self.invoke({"get-db-usage": {}}))["usage"]
 
+    async def get_db_query_columns(self):
+        await self._set_mode(self.MODE_NORMAL)
+        return (await self.invoke({"get-db-query-columns": {}}))["columns"]
+
 
 class Client(bb.asyncrpc.Client):
     def __init__(self, username=None, password=None):
@@ -219,6 +223,7 @@ class Client(bb.asyncrpc.Client):
             "delete_user",
             "become_user",
             "get_db_usage",
+            "get_db_query_columns",
         )
 
     def _get_async_client(self):
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 4fec1556..d2fd75df 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -250,6 +250,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 "get-stream": self.handle_get_stream,
                 "get-stats": self.handle_get_stats,
                 "get-db-usage": self.handle_get_db_usage,
+                "get-db-query-columns": self.handle_get_db_query_columns,
                 # Not always read-only, but internally checks if the server is
                 # read-only
                 "report": self.handle_report,
@@ -571,6 +572,10 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
     async def handle_get_db_usage(self, request):
         return {"usage": await self.db.get_usage()}
 
+    @permissions(DB_ADMIN_PERM)
+    async def handle_get_db_query_columns(self, request):
+        return {"columns": await self.db.get_query_columns()}
+
     # The authentication API is always allowed
     async def handle_auth(self, request):
         username = str(request["username"])
diff --git a/lib/hashserv/sqlalchemy.py b/lib/hashserv/sqlalchemy.py
index 818b5195..cee04bff 100644
--- a/lib/hashserv/sqlalchemy.py
+++ b/lib/hashserv/sqlalchemy.py
@@ -415,3 +415,13 @@ class Database(object):
                 }
 
         return usage
+
+    async def get_query_columns(self):
+        columns = set()
+        for table in (UnihashesV2, OuthashesV2):
+            for c in table.__table__.columns:
+                if not isinstance(c.type, Text):
+                    continue
+                columns.add(c.key)
+
+        return list(columns)
diff --git a/lib/hashserv/sqlite.py b/lib/hashserv/sqlite.py
index e9ef38a1..f5c451f4 100644
--- a/lib/hashserv/sqlite.py
+++ b/lib/hashserv/sqlite.py
@@ -382,3 +382,10 @@ class Database(object):
                     "rows": cursor.fetchone()[0],
                 }
         return usage
+
+    async def get_query_columns(self):
+        columns = set()
+        for name, typ, _ in UNIHASH_TABLE_DEFINITION + OUTHASH_TABLE_DEFINITION:
+            if typ.startswith("TEXT"):
+                columns.add(name)
+        return list(columns)
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 9d5bec24..fc69acaf 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -776,6 +776,14 @@ class HashEquivalenceCommonTests(object):
             self.assertIn("rows", usage[name])
             self.assertTrue(isinstance(usage[name]["rows"], int))
 
+    def test_get_db_query_columns(self):
+        columns = self.client.get_db_query_columns()
+
+        self.assertTrue(isinstance(columns, list))
+        self.assertTrue(len(columns) > 0)
+
+        for col in columns:
+            self.client.remove({col: ""})
 
 class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def get_server_addr(self, server_idx):
-- 
2.34.1


