Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310C1E81E0D
	for <webhook@archiver.kernel.org>; Fri,  6 Oct 2023 15:36:52 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
 by mx.groups.io with SMTP id smtpd.web11.16219.1696606611272205649
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Oct 2023 08:36:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FdGTVD8o;
 spf=pass (domain: gmail.com, ip: 209.85.160.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1dceb2b8823so1142170fac.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696606610; x=1697211410; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vClnEF6TsFaqvx7Nu15ggYBbXirYCuUUUmR4LIkyv0=;
        b=FdGTVD8oK98gbhI3PhH5/ushlpQ7UXRFxHgMBYC1TuDeC/C+ZTa2AgYz5chKlkBeWY
         bNm/XvpVbfRSNnjN1ebw7FeO56wvKqpn3Qffk+KafDbUKfbbyry4geoBnLL0eJPvaSnU
         hhNczj8c43em5KbhZvw3lM2O9teZp7bsBfp9i4Q77GrPpaVdnV9AR0yh7XWvWQH5yWb3
         1azV6e7cMoFFgNoWm1M1zZXssTthGVoQMbn11y1zlKov1ySLRLPz2BQVHl1fzZMsSxVR
         UHnbpolrRvM1aFgHAH9RJHHpBsCF4UmLO1VuO6olBvloyXdaLtqu5KsV+UhohLThA1om
         Mp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606610; x=1697211410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vClnEF6TsFaqvx7Nu15ggYBbXirYCuUUUmR4LIkyv0=;
        b=FYY0QisTwLQw2OiOy52i4nvDSDt0mSq3OGJ7knVWyrxvTbRE44fjfOY3KKAtZ3sca7
         kxd90GHXDksn6K+Dyrif7qqtU+dbWxWyIaqw9L6r2uVUTY71FdTlpgyQ5KmnatY+7GQF
         zo3MN5QNIYmk6DVhbbyHeYEGpaJ+XZlyUXdA/NXIQo85VfXQ0fjodsNBcv1cwDk7fGNp
         vax7OPlgbOFE5szuwnrfgbhRKMIX6oe16YaGKcd68sYJArJDucIcwi2b/ZYZvrgvNyr+
         LvWu0O7rmN1rnI+3s2xoGh4Mjl4vEIHgj7wyvvACI2bLuMjNngk0Nw7PYzhrJEV/Zwkx
         X9SQ==
X-Gm-Message-State: AOJu0YxIOi9g81eFifOm5GZ619TKRqV5abc8ZDQyt5CReV9DRQT7Qjri
	r5Xpj7AAxPZXfbzc0ioXuCK3XEYFAaA=
X-Google-Smtp-Source: AGHT+IHFq56CzkTlDXLYM7Qf6vxvLPU+Qx7/AI6jLbIFqIOEFjFzwrIujKHDtoCNGJg4i/gQH3Ib9w==
X-Received: by 2002:a05:6870:231c:b0:1d4:eefb:3ae5 with SMTP id w28-20020a056870231c00b001d4eefb3ae5mr2693864oao.15.1696606609920;
        Fri, 06 Oct 2023 08:36:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id 26-20020a056870135a00b001dd395339c3sm780426oac.19.2023.10.06.08.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:36:48 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 1/5] hashserv: Add remove API
Date: Fri,  6 Oct 2023 09:36:41 -0600
Message-Id: <20231006153645.1609760-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006153645.1609760-1-JPEWhacker@gmail.com>
References: <20231006153645.1609760-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 15:36:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15188

Adds a `remove` API to the client and server that can be used to remove
hash equivalence entries that match a particular critera

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py |  5 +++++
 bitbake/lib/hashserv/server.py | 28 ++++++++++++++++++++++++++++
 bitbake/lib/hashserv/tests.py  | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index b2aa1026ac9..7446e4c9f67 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -101,6 +101,10 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         await self._set_mode(self.MODE_NORMAL)
         return (await self.send_message({"backfill-wait": None}))["tasks"]
 
+    async def remove(self, where):
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.send_message({"remove": {"where": where}})
+
 
 class Client(bb.asyncrpc.Client):
     def __init__(self):
@@ -115,6 +119,7 @@ class Client(bb.asyncrpc.Client):
             "get_stats",
             "reset_stats",
             "backfill_wait",
+            "remove",
         )
 
     def _get_async_client(self):
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index d40a2ab8f88..daf1ffacbb9 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -186,6 +186,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 'report-equiv': self.handle_equivreport,
                 'reset-stats': self.handle_reset_stats,
                 'backfill-wait': self.handle_backfill_wait,
+                'remove': self.handle_remove,
             })
 
     def validate_proto_version(self):
@@ -499,6 +500,33 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         await self.backfill_queue.join()
         self.write_message(d)
 
+    async def handle_remove(self, request):
+        condition = request["where"]
+        if not isinstance(condition, dict):
+            raise TypeError("Bad condition type %s" % type(condition))
+
+        def do_remove(columns, table_name, cursor):
+            nonlocal condition
+            where = {}
+            for c in columns:
+                if c in condition and condition[c] is not None:
+                    where[c] = condition[c]
+
+            if where:
+                query = ('DELETE FROM %s WHERE ' % table_name) + ' AND '.join("%s=:%s" % (k, k) for k in where.keys())
+                cursor.execute(query, where)
+                return cursor.rowcount
+
+            return 0
+
+        count = 0
+        with closing(self.db.cursor()) as cursor:
+            count += do_remove(OUTHASH_TABLE_COLUMNS, "outhashes_v2", cursor)
+            count += do_remove(UNIHASH_TABLE_COLUMNS, "unihashes_v2", cursor)
+            self.db.commit()
+
+        self.write_message({"count": count})
+
     def query_equivalent(self, cursor, method, taskhash):
         # This is part of the inner loop and must be as fast as possible
         cursor.execute(
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index f6b85aed85a..a3e066406e3 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -84,6 +84,7 @@ class HashEquivalenceCommonTests(object):
 
         result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
+        return taskhash, outhash, unihash
 
     def test_create_equivalent(self):
         # Tests that a second reported task with the same outhash will be
@@ -125,6 +126,38 @@ class HashEquivalenceCommonTests(object):
 
         self.assertClientGetHash(self.client, taskhash, unihash)
 
+    def test_remove_taskhash(self):
+        taskhash, outhash, unihash = self.test_create_hash()
+        result = self.client.remove({"taskhash": taskhash})
+        self.assertGreater(result["count"], 0)
+        self.assertClientGetHash(self.client, taskhash, None)
+
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash)
+        self.assertIsNone(result_outhash)
+
+    def test_remove_unihash(self):
+        taskhash, outhash, unihash = self.test_create_hash()
+        result = self.client.remove({"unihash": unihash})
+        self.assertGreater(result["count"], 0)
+        self.assertClientGetHash(self.client, taskhash, None)
+
+    def test_remove_outhash(self):
+        taskhash, outhash, unihash = self.test_create_hash()
+        result = self.client.remove({"outhash": outhash})
+        self.assertGreater(result["count"], 0)
+
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash)
+        self.assertIsNone(result_outhash)
+
+    def test_remove_method(self):
+        taskhash, outhash, unihash = self.test_create_hash()
+        result = self.client.remove({"method": self.METHOD})
+        self.assertGreater(result["count"], 0)
+        self.assertClientGetHash(self.client, taskhash, None)
+
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash)
+        self.assertIsNone(result_outhash)
+
     def test_huge_message(self):
         # Simple test that hashes can be created
         taskhash = 'c665584ee6817aa99edfc77a44dd853828279370'
-- 
2.34.1


