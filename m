Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E9BC4332F
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:58 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
 by mx.groups.io with SMTP id smtpd.web11.10736.1698853368000590685
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aKP/Vwqa;
 spf=pass (domain: gmail.com, ip: 209.85.210.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ce2988d62eso4444297a34.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853366; x=1699458166; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANo5r5R8pKIsVmsQt7esNuSZLSeNL88k3ML4dFRYHVY=;
        b=aKP/VwqaGR//5p56SObvjA9cTXbnis1YUKTlPu9l0bTctT7LAUQCxpKSIE/LqGc3KU
         95yQEyidmB4VgLjU+4AHiKXnSJ5Aug4MIEY8TgNb89zBv/QM7zaxZotptAe+y/VG38az
         USJF4QBneLTyDmFK0U+H5ik+a7LHkZ5bUhK/ryX04VpHeeQGUCkpoadn9kXaDBNHWsT3
         j9ZZ/N63PvopCsjavOVW+SZkzphsk6sSQG972hNIX6vPuUyzd+YGilpn8ewCXJoglVMM
         luALKBdKus9TWpFCQ5JR9iPeAb3+s4gkeXQoU2wpm3Ti9Wjt5M/PHuNm78+Hk6HCWls+
         m11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853366; x=1699458166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANo5r5R8pKIsVmsQt7esNuSZLSeNL88k3ML4dFRYHVY=;
        b=Oj4ORx7Jsp/I3LeAJudIG26KuxVDyW2SHQ5v2f9ZhO7zEUVQv/n5962oChKBBSkl+5
         5eDe6ciMQn6pd2UwCVhj22L4narjTrXp7G5mBqlzL1Hdz1muolNhCOcshN9xiBs7Usr+
         6lGWlRlK5PHW8/Xho/hVqqf1XPa+Mt2XNb0+3nP7hT+t0wXs4cEmRia5hUTOkp6+n8kM
         k8CmZsKhgIFmZcrQCHlzfWZF6c4g0ghRhTjXwDk93aUdfF3OK2ebJbyISW4w8EX1vexs
         slpOuFjZF+gS4ZEBWFKOug7PAxtgVXv33T3w67jOnZNaYp6t/lBHoflA841DvR3cubCc
         Gwsw==
X-Gm-Message-State: AOJu0Yz4PpvbJwZMkVDDaoiuzK4mBEr0/ng9pHXN0YmdkYHgeLJcETE5
	kSDpINSlkLJWDz7PQC2Of07mPGt3Ot0=
X-Google-Smtp-Source: AGHT+IGceSgKhHeItKuM8cOjcqyBfQbFACGpxE83JQ35Oj7tDDuB5raJFDQDRr/fKjt99/NUVX2P6g==
X-Received: by 2002:a05:6808:238e:b0:3ad:f86a:877b with SMTP id bp14-20020a056808238e00b003adf86a877bmr20761586oib.23.1698853366236;
        Wed, 01 Nov 2023 08:42:46 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:45 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 16/22] hashserv: Add database column query API
Date: Wed,  1 Nov 2023 09:42:10 -0600
Message-Id: <20231101154216.2758185-17-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15398

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


