Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A30DE7AD64
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 14:53:02 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web11.110205.1696344775757067197
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 07:52:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fOp5eAhr;
 spf=pass (domain: gmail.com, ip: 209.85.210.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6c4b9e09521so659791a34.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344774; x=1696949574; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClqoDI2mxfMuajwgDhoxUn9MOoi3nfXxSOV09GnRprw=;
        b=fOp5eAhrtIY9MQw1fA++IdUQRXAMl5OncDfp6NkcyLh+aNa6A0NYCZA+WY1zuCSFnH
         bRe/M8t6jtVtUJTVh2439ji/vb5JMFFpGzVt7wyscPe0XpY5Mwe1VXXfhkj7+hzSR4O5
         uQOljsqs1W773vWRLbsRUBq1xfiIv0REMK6rZ2Lfi2j1nimi9dxPfrsaXEqSUtGG/QK7
         7ZpgnUcGEYNdz9f4CV507mPu4MQMF+AiixWNJ/RY6Be5zc57qDiKzM092eWyqe0SbaPm
         YsTDFhBJFgholk8Qmgc29RdviVsiNM4VeqWZiPnQkUaF+mOuLOQrpSTfgHLvPoAiIXwy
         uahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344774; x=1696949574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClqoDI2mxfMuajwgDhoxUn9MOoi3nfXxSOV09GnRprw=;
        b=SOslbF63AwdvjZl2tHBT7NY3TCLyaX8jU2LenYgPKhkjgg0akz4deZcMZPtNNRHIUF
         XfLFhC0AytMuBTLvHZ3XoYN6yxMc8NbMdQ26hQ6eqLZ+OsPf5IAJdzbBcgtY/m9Hmhrv
         3W+rkOKkGwCPLTqiZ2vPjFNSAvRwiIxKlIuKBnshvGYcIsEenlkhFv3G7Mk3PWsGXM0r
         zF9gmdAmEPvbMuGMfSgDF75Rf/wwl4X+xAhUpyLUdasBavJBiB+n6LuVLukoLahC8IOo
         Wo6duyNe5dJb/05BjnFbftsTGJ/25glAOQ7LHGQ3rAXqYdlRMs2BXj0E5aZI29hWQX5E
         lsRA==
X-Gm-Message-State: AOJu0YyrxuGSdoqBvNjGTqbjY3ujjPTySxxrCZcjtXLeInkyzuRevsCM
	cp8wpX+YBcPUNNZ2mP1xiERi8yQdIt0=
X-Google-Smtp-Source: AGHT+IHQgcbij8CShV9nDdg2+4cn15EDUVUeuSS06kKL1Zi3eSk7mrhXtxfo1W8kdR1euabw6b/6Kw==
X-Received: by 2002:a05:6870:a454:b0:1dc:7e33:4b8c with SMTP id n20-20020a056870a45400b001dc7e334b8cmr17568247oal.27.1696344774334;
        Tue, 03 Oct 2023 07:52:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::589])
        by smtp.gmail.com with ESMTPSA id du28-20020a0568703a1c00b001dd2b869a26sm253477oab.17.2023.10.03.07.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:52:53 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 02/12] hashserv: Add remove API
Date: Tue,  3 Oct 2023 08:52:39 -0600
Message-Id: <20231003145249.1166276-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003145249.1166276-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
 <20231003145249.1166276-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 14:53:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15163

Adds a `remove` API to the client and server that can be used to remove
hash equivalence entries that match a particular critera

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py |  5 +++++
 bitbake/lib/hashserv/server.py | 28 ++++++++++++++++++++++++++++
 bitbake/lib/hashserv/tests.py  | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 47e118c4583..d11d0ca29d0 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -105,6 +105,10 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         await self._set_mode(self.MODE_NORMAL)
         return (await self.invoke({"backfill-wait": None}))["tasks"]
 
+    async def remove(self, where):
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.invoke({"remove": {"where": where}})
+
 
 class Client(bb.asyncrpc.Client):
     def __init__(self):
@@ -119,6 +123,7 @@ class Client(bb.asyncrpc.Client):
             "get_stats",
             "reset_stats",
             "backfill_wait",
+            "remove",
         )
 
     def _get_async_client(self):
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index 43eddc5d9f6..35465240ae9 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -186,6 +186,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 'report-equiv': self.handle_equivreport,
                 'reset-stats': self.handle_reset_stats,
                 'backfill-wait': self.handle_backfill_wait,
+                'remove': self.handle_remove,
             })
 
     def validate_proto_version(self):
@@ -490,6 +491,33 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         await self.backfill_queue.join()
         return d
 
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
+        return {"count": count}
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


