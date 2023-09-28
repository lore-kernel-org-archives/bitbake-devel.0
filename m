Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553FCE732F4
	for <webhook@archiver.kernel.org>; Thu, 28 Sep 2023 17:06:09 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web11.18861.1695920760363124549
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Sep 2023 10:06:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Mmx575o+;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6c6368a1a97so207809a34.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 28 Sep 2023 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695920759; x=1696525559; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mniGGYwxo14cEdvMYuiYDZFic/qIn7vlBumgwms2QPY=;
        b=Mmx575o+nH3jPTW1TvZfQqC1Y4VQwoFritgXDdX3nQPo8Q7Vlilsbqt37PVkjF5Jlt
         KV5XjIJMdzOx1u3fVPLHtkLWusPCzYhTtLzDhX6MnRHuli2nvpv1bhUP3E+z9/qlYF18
         gVK0gagpitIYE8N8qRi78pAHrDnhVq0uk16qwbZ1BeosfCCWOF8w9ekDFLBQ47K/du6x
         +1/Da0yMOdHcDakPRA2c2UDl/krgyY9U4lEvwk8ufiPDhccm8S7mmttsDsbPQJawDD8G
         gEbrsNMyt7Se/qjvXZPG1gEpr6ITBVFLoQnfCWZlXAl8LIJeOPr+ZnITbPBWCcOteZpd
         +98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695920759; x=1696525559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mniGGYwxo14cEdvMYuiYDZFic/qIn7vlBumgwms2QPY=;
        b=XenBk+lEzfxSNB1IoVmaIR3pqI3r/SxDHAyd4TMDobmzkmMTEmwdoSfYcOssYbEMV3
         tAkTGmshQmt4ItjJVRgMet1JtnX0EEw/IKxLraEblKWnJzJTTLQUfpMP9lWgzxLu+xWe
         tz31teAtVUwplsICgQ5DwGArENf6n/ftf8kqJVDTiQdGxoLJf2DrNBKpbev3CSwKwaLV
         TYHRJZJDdO9bgFoz/X3lySxDNchJAa7Ux/CO78BvFFx+GkOshhhXAuorZWpypPdVglsH
         gZYckpvjQdcPtL9Hi8xm+Onubf3HJ0bsDCFsik9xManEbhxWJEFAvGFUY3bxmiGJpkKQ
         o90Q==
X-Gm-Message-State: AOJu0YyNQFzXvDBx16BoZ6WV6ZTyqF4oLxmyl5E7WzhZnfhjBcmBwmFo
	dP3Cohp9Oe2xI9iZwUcH1xtm+Orig2w=
X-Google-Smtp-Source: AGHT+IE6nGwy/GvBhyvP4r7kyl4rQXTC0k35j9phIplPcVYYJXq/mWGlCbRKSfTdSGcRebI1bfKpuQ==
X-Received: by 2002:a05:6870:e40e:b0:1b0:3f7f:673a with SMTP id n14-20020a056870e40e00b001b03f7f673amr1302319oag.25.1695920758903;
        Thu, 28 Sep 2023 10:05:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::f27c])
        by smtp.gmail.com with ESMTPSA id h3-20020a056870860300b001dd533c4bd1sm1389772oal.1.2023.09.28.10.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 10:05:57 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC 2/5] hashserv: Add remove API
Date: Thu, 28 Sep 2023 11:05:48 -0600
Message-Id: <20230928170551.4193224-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928170551.4193224-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Sep 2023 17:06:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15144

Adds a `remove` API to the client and server that can be used to remove
hash equivalence entries that match a particular critera

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py |  5 +++++
 bitbake/lib/hashserv/server.py | 25 +++++++++++++++++++++++++
 bitbake/lib/hashserv/tests.py  | 29 +++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 2a3c1b662b6..7d2b9cb394f 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -97,6 +97,10 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         await self._set_mode(self.MODE_NORMAL)
         return (await self.invoke({"backfill-wait": None}))["tasks"]
 
+    async def remove(self, where):
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.invoke({"remove": {"where": where}})
+
 
 class Client(bb.asyncrpc.Client):
     def __init__(self):
@@ -111,6 +115,7 @@ class Client(bb.asyncrpc.Client):
             "get_stats",
             "reset_stats",
             "backfill_wait",
+            "remove",
         )
 
     def _get_async_client(self):
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index d40a2ab8f88..7e8aeefef30 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -186,6 +186,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 'report-equiv': self.handle_equivreport,
                 'reset-stats': self.handle_reset_stats,
                 'backfill-wait': self.handle_backfill_wait,
+                'remove': self.handle_remove,
             })
 
     def validate_proto_version(self):
@@ -499,6 +500,30 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
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
+                print(query)
+                cursor.execute(query, where)
+
+        with closing(self.db.cursor()) as cursor:
+            do_remove(OUTHASH_TABLE_COLUMNS, "outhashes_v2", cursor)
+            do_remove(UNIHASH_TABLE_COLUMNS, "unihashes_v2", cursor)
+            self.db.commit()
+
+        self.write_message({})
+
     def query_equivalent(self, cursor, method, taskhash):
         # This is part of the inner loop and must be as fast as possible
         cursor.execute(
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index f6b85aed85a..5f1ad585072 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -84,6 +84,7 @@ class HashEquivalenceCommonTests(object):
 
         result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
+        return taskhash, outhash, unihash
 
     def test_create_equivalent(self):
         # Tests that a second reported task with the same outhash will be
@@ -125,6 +126,34 @@ class HashEquivalenceCommonTests(object):
 
         self.assertClientGetHash(self.client, taskhash, unihash)
 
+    def test_remove_taskhash(self):
+        taskhash, outhash, unihash = self.test_create_hash()
+        self.client.remove({"taskhash": taskhash})
+        self.assertClientGetHash(self.client, taskhash, None)
+
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash)
+        self.assertIsNone(result_outhash)
+
+    def test_remove_unihash(self):
+        taskhash, outhash, unihash = self.test_create_hash()
+        self.client.remove({"unihash": unihash})
+        self.assertClientGetHash(self.client, taskhash, None)
+
+    def test_remove_outhash(self):
+        taskhash, outhash, unihash = self.test_create_hash()
+        self.client.remove({"outhash": outhash})
+
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash)
+        self.assertIsNone(result_outhash)
+
+    def test_remove_method(self):
+        taskhash, outhash, unihash = self.test_create_hash()
+        self.client.remove({"method": self.METHOD})
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


