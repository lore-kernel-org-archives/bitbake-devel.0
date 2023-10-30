Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B93C4167D
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:24 +0000 (UTC)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web11.158499.1698693495870590823
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mln3jYdp;
 spf=pass (domain: gmail.com, ip: 209.85.210.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6cd33d51852so3338734a34.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693494; x=1699298294; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XgxxU3VW5xXLq9wLhPYxLaZh2B/Nc+SXIjCtknIZMg=;
        b=mln3jYdpTF/8M8ADqo8Hk6VmCnH+wQQuEJB8AP6Ea0Q6hVil2bpEt246lCc0D50Ssx
         c/fDrrmIS5uRmzMWNX0F+FWkBpu7Eaxpx1p48BCyJPeZ74nKbNtqQXUbHqFIcU8a1qYH
         +8K0p2YanBl4MUBHwcW4ACVhOogoUW7UdUocmFv0hilBJLE/Rggldj+i7p8ycV24oU14
         37j+O93EaMXOguc/VrgFrldZElxzc9OxB+rYYxlqNSL/u3fR/gU+XBtWbcc0/NUYeh8a
         jg1FEe1Zq6TCoLHUuH37RykBmMBXyysw/jxbFongOH5fOAqXZbNur85Q29OlZPCpsZri
         0kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693494; x=1699298294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XgxxU3VW5xXLq9wLhPYxLaZh2B/Nc+SXIjCtknIZMg=;
        b=ugJ29aaa68ESF/ZIRr/vq5VRa08vntgC66PEw2QqRtLnZQQy/bzwG9wY4D96JOnaO2
         TwxJezAivQ4d1OVgz3+ON8ny2Y/XRT2wkXTnUtq4MtNfE3x01THZBKfDNbfR4UufOVON
         kQOSn6/kz9rASnZ0XFOvii+ikpcuBzKt3kB20hDzY6FiCv3nzrrc+TO6kf9lXby9J1x7
         Hn61AHj9Mz/B9GGiusdCtbXinqS5AgfTJNF7IE+mgByE1MqN3+bxndU343wA1ftW7qjX
         wyXk3OVHwclS6ChAscglJaY2on3lvvi8S1Rm8jAOcbefIEaoxz++mg6wToIDnzTb3bKl
         4JEA==
X-Gm-Message-State: AOJu0YxYGuzjL7q48RgFkOWwankzEBEdwZXwCgBTfrNlxWAeWaLPzES+
	XVy7KQHXMP2ZaXKj4uP0EZsmCBZj/Mw=
X-Google-Smtp-Source: AGHT+IGTGD6BhGDh4hpWIB3S/uhAS5V9SZcf09breu/z8N2gyY76yQ2MXLWv8ErZ1USOEAG4/drz/Q==
X-Received: by 2002:a05:6830:3149:b0:6c4:be02:635f with SMTP id c9-20020a056830314900b006c4be02635fmr12713518ots.5.1698693494490;
        Mon, 30 Oct 2023 12:18:14 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:18:13 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 16/22] hashserv: Add database column query API
Date: Mon, 30 Oct 2023 13:17:22 -0600
Message-Id: <20231030191728.1276805-17-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15318

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
index 0fda376f..bdf60f86 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -198,6 +198,10 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         await self._set_mode(self.MODE_NORMAL)
         return (await self.invoke({"get-db-usage": {}}))["usage"]
 
+    async def get_db_query_columns(self):
+        await self._set_mode(self.MODE_NORMAL)
+        return (await self.invoke({"get-db-query-columns": {}}))["columns"]
+
 
 class Client(bb.asyncrpc.Client):
     def __init__(self, username=None, password=None):
@@ -227,6 +231,7 @@ class Client(bb.asyncrpc.Client):
             "delete_user",
             "become_user",
             "get_db_usage",
+            "get_db_query_columns",
         )
 
     def _get_async_client(self):
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 0e36d13c..3bbcfcf2 100644
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


