Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B48C001DB
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:26 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
 by mx.groups.io with SMTP id smtpd.web10.53511.1699021639484104539
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=luoRegwp;
 spf=pass (domain: gmail.com, ip: 209.85.161.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-581edcde26cso1165279eaf.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021638; x=1699626438; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D256AHC20Vhv0FmZ740iYrbMxEt0lJKdhmt0w1eVLV0=;
        b=luoRegwpF318Uq6MfB1NgSilkr2PG98o4xC+zTtD68WKgrmrE+KnFyJ7reriS4yzTU
         og2c74+oPZ6hbZ0McShkZMwsvwMibLHcjeSQLZqfeaMx5qlJM6Am0XbAaVr+xWElyULA
         OSuYIbwT5IPL9LZnJjhDRgxIm/VtIeeg2J6e8Dbdn/ikjxvZ0eDi5JPKecBtjePeE0Vs
         spzfhQ7stGzGiuI8hojuWtjAlOBv50JH3ux4n66OzR7eeyQEXFVajZwSzk5Eru9HauIP
         HU1jHZt7A20II0LnM4QpQtHGnPjP4yV4d1aSdMjn8xB3vgmgioxKSNhnRIdKXE4GUWja
         dGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021638; x=1699626438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D256AHC20Vhv0FmZ740iYrbMxEt0lJKdhmt0w1eVLV0=;
        b=wW2idlf5Iq/kZtCGZEz4C/uhn70eb3dQFpYpAa9WHw9Kx92ztsNVjNV+tQHSA28jGO
         0k1uEae3P/CsVyQrkGn4KjKoc7vOc2VxYZg2SkpEuCbgiU19fDTverJW6AqFLcWV4YkC
         EbWfCX6TNNz86BDST7Qj2iBjQTqcQqg/YU3bpb9CI0SWq8sPR+0kzep/MZNqr58e6bbu
         XbXHrerKUAigQsM8rV0bZ0ZRuBo5SxZXR97+kJeF/pPaen7qHleLtxRYu9jRz422+s2D
         atGp3DHX8iNRLFQM4EEyn9f9S12U4YJatyirzPefzVlf1jxc45/TLpXMQhYwMWtzCNKV
         3FNQ==
X-Gm-Message-State: AOJu0Yyt/vAvcOJv7J7ZIG7fTY0BbdrIWc1LJzu4aabvRMz8BH1GSl3O
	sEWGaEy6yWvJ5HF3C1M/KCVaM3gpXbY=
X-Google-Smtp-Source: AGHT+IFYf4AbpcIJ1VNWlrzJ4k3Jwu8vbwgQDWdW1mlXSm+zKjkKC1bLQsGwka/IeRqEGQxtDkZ8xQ==
X-Received: by 2002:a05:6870:b14d:b0:1e9:88c2:ba80 with SMTP id a13-20020a056870b14d00b001e988c2ba80mr27759512oal.30.1699021638155;
        Fri, 03 Nov 2023 07:27:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:27:16 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 16/22] hashserv: Add database column query API
Date: Fri,  3 Nov 2023 08:26:34 -0600
Message-Id: <20231103142640.1936827-17-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15437

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
index 5e0a462b..35a97687 100644
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
index c5b9797e..8c3d20b6 100644
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
@@ -572,6 +573,10 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
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
index dfdccbba..f65036be 100644
--- a/lib/hashserv/sqlite.py
+++ b/lib/hashserv/sqlite.py
@@ -399,3 +399,10 @@ class Database(object):
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


