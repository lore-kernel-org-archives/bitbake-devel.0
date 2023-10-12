Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B493C41513
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:35 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
 by mx.groups.io with SMTP id smtpd.web11.25729.1697149051164487170
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WV6N/Gu4;
 spf=pass (domain: gmail.com, ip: 209.85.160.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1e9a757e04eso897202fac.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149050; x=1697753850; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLnqRVXlkCEBZuqEwTZJRcr0WSdiwPi58VmX8U/gu80=;
        b=WV6N/Gu46/Z6FhdT7GxYP2ElqD8o27ixeGXkhNfMgMR143qQfUcnWeEStOSXLzHGf/
         dWX28dH2/lorIEEsiKKjG+C4/PF0wnc15SYKXvzs7xsNt4raHnFFC+d51iXGOYYPmB5M
         PBrLIbqGQCJXAARyrPVcJoOgg9OIKeq/oqT/lip+AM4Fvy1YX1OotlA51NEiiKri6v3E
         OSB6170MOZM/XXDj+gAwvc2DY3/chpc4IOE0eVJpDk3RYs1mQUM5EReCevzuz1FMKBSv
         bYWHmiGbbpD7GHL7RFyLe8b8UOT2JkMPncmACKGbhVdJQjF8ZtYNJfgN+A8Z15gK7UVB
         1dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149050; x=1697753850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLnqRVXlkCEBZuqEwTZJRcr0WSdiwPi58VmX8U/gu80=;
        b=cROjdp9XkKnUkvpq38rPgZeLxduwu1pJFc/6pI5BbFgoXM15VdKIWUagwrfAg/qaOz
         Uc5GjTpV+W99SmPZkRwWyGrluG/qaQI3KSD8PGA3SCTWJUIVbyhk5kUnoiO7XKH6gZRF
         t7ErpDtcrFhxjsdpGNRwbzYJ67vNBPizAvv4HdsXmtVaKcc6BD11I9Zt7BifnGtQ60ay
         QUWFYMvf4gwGiFrqTELSiWhkA3onvVKfq9lNymHvbV928knPkhVmAchjDDaHAezs+GWi
         pOCC20WR5zQ3t4P2gdNRZLtqG1ORikyzWfbVlCKOlo9iD0f47lzfmonDwfxt0vQVKuRJ
         hdOA==
X-Gm-Message-State: AOJu0YzNbY7ePlDrOZlU49ANms5yU9mxjpiDariEbw3sis5EY5sKwlmp
	6q/sG2avcAPqaKeJhAkJ/RJfZ6tfiiw=
X-Google-Smtp-Source: AGHT+IENofNkK1PvgJtdWdgJBGNe49+sb+0kwKV/oPGUCjc53Ep3ZZ3++ffLh3gFyucdhWYEIspkEA==
X-Received: by 2002:a05:6870:9d18:b0:1e9:6bf2:19a4 with SMTP id pp24-20020a0568709d1800b001e96bf219a4mr4433743oab.2.1697149049671;
        Thu, 12 Oct 2023 15:17:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:28 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 18/18] hashserv: Add database column query API
Date: Thu, 12 Oct 2023 16:16:55 -0600
Message-Id: <20231012221655.632637-19-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15236

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
index b9a6ba62..70caf3fe 100755
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


