Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3921AE81E0F
	for <webhook@archiver.kernel.org>; Fri,  6 Oct 2023 15:37:02 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web11.16221.1696606616146265124
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Oct 2023 08:36:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MgAuX4Po;
 spf=pass (domain: gmail.com, ip: 209.85.167.179, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3af64a4c97eso1375001b6e.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696606615; x=1697211415; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVW3VRzH/4UqT044Xh0YM0w1oLYVoESPuAAjcL81a/c=;
        b=MgAuX4PogqqyO2TEuYJv5Jq9bcNVdrEY29MCoziDsUErgMcoctfcPFsGV6oWKjM3xr
         Vh6J7FHbo3iyYBjKuLHDK4XRgacK2gewSNhVGaXgEAekugauUXd0VhyWzzhOH5lqXf5y
         BkSAjTCDUh/38DHp7jnGxiLow1z4vXTKnwm5HQXCCCThjfY085dLi0zTGckHcsNAfe4k
         UwkOnei39Y6yKJrXBmutnbGV0B8+2OUHVkdoprnBPWs1oWQeCaEWyXcLA5Hf27zDpMN4
         efS9msNEIwDSUlt5i91+jufdH+2S+nlha7i98my+6cv1wbpSjo6UkpkAVCezjCDMKbNV
         xf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606615; x=1697211415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lVW3VRzH/4UqT044Xh0YM0w1oLYVoESPuAAjcL81a/c=;
        b=ACJVeRWtxonpzxBVJIuRS68+Wtujf5JpLcTV7Y6/W68fddhRPhHRQh0Lhl09lyNH/8
         IIP9kuI2sPAKl4PMFVt4M8TjHGJy06dbiwh+PFgdpvzLIZvBCfxhfZSpwGg3GE6GMwoK
         6LLhtBcmhU6s7SppQ+8Bvsu2GDSV91ZTORHsCabb44yEryp7JaMzHBxue0NNgnLu1Lg7
         7UC6Ae3rLJSqrfb9XoPrdfoY3EYSHxk1c0OT7ZeguRxHQujltG6r1tsp40Y38D8xvI0H
         i/t6XgDHUKKESzVg16zge/V9pjXgyKnVdqH7gOuBRMSKZ9JtfArqyTQLMyjHkv1TO02E
         ZACA==
X-Gm-Message-State: AOJu0Yx9dzIjEZ2CAFqnk/zFaWCGSc8SurqGBR5AeInpAI8HHiQ1lTMw
	lFQKdXWN0iVoSxzIUgngQjeVCgra+10=
X-Google-Smtp-Source: AGHT+IHbmDpu2bya1vXrW0fMZ2RoJWiwyMfqN5LKoAsLL9QA4RyK7kbJIqO+YYiC0g2jD8KevOgGBg==
X-Received: by 2002:a05:6870:8a0b:b0:1bf:5b4:4a51 with SMTP id p11-20020a0568708a0b00b001bf05b44a51mr8883625oaq.58.1696606614706;
        Fri, 06 Oct 2023 08:36:54 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id 26-20020a056870135a00b001dd395339c3sm780426oac.19.2023.10.06.08.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 08:36:53 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 4/5] hashserv: Add API to clean unused entries
Date: Fri,  6 Oct 2023 09:36:44 -0600
Message-Id: <20231006153645.1609760-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006153645.1609760-1-JPEWhacker@gmail.com>
References: <20231006153645.1609760-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Oct 2023 15:37:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15191

Adds an API to remove unused entries in the outhash database based on
age and if they are referenced by any unihash

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py |  5 +++++
 bitbake/lib/hashserv/server.py | 20 +++++++++++++++++++-
 bitbake/lib/hashserv/tests.py  | 19 +++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index eeafeabda05..d5c981864a2 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -105,6 +105,10 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         await self._set_mode(self.MODE_NORMAL)
         return await self.send_message({"remove": {"where": where}})
 
+    async def clean_unused(self, max_age):
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.send_message({"clean_unused": {"max_age_seconds": max_age}})
+
 
 class Client(bb.asyncrpc.Client):
     def __init__(self):
@@ -120,6 +124,7 @@ class Client(bb.asyncrpc.Client):
             "reset_stats",
             "backfill_wait",
             "remove",
+            "clean_unused",
         )
 
     def _get_async_client(self):
diff --git a/bitbake/lib/hashserv/server.py b/bitbake/lib/hashserv/server.py
index d52e1d46df5..b2ca357b2b1 100644
--- a/bitbake/lib/hashserv/server.py
+++ b/bitbake/lib/hashserv/server.py
@@ -4,7 +4,7 @@
 #
 
 from contextlib import closing, contextmanager
-from datetime import datetime
+from datetime import datetime, timedelta
 import enum
 import asyncio
 import logging
@@ -187,6 +187,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 'reset-stats': self.handle_reset_stats,
                 'backfill-wait': self.handle_backfill_wait,
                 'remove': self.handle_remove,
+                'clean_unused': self.handle_clean_unused,
             })
 
     def validate_proto_version(self):
@@ -542,6 +543,23 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
         self.write_message({"count": count})
 
+    async def handle_clean_unused(self, request):
+        max_age = request["max_age_seconds"]
+        with closing(self.db.cursor()) as cursor:
+            cursor.execute(
+                """
+                DELETE FROM outhashes_v2 WHERE created<:oldest AND NOT EXISTS (
+                    SELECT unihashes_v2.id FROM unihashes_v2 WHERE unihashes_v2.method=outhashes_v2.method AND unihashes_v2.taskhash=outhashes_v2.taskhash LIMIT 1
+                )
+                """,
+                {
+                    "oldest": datetime.now() - timedelta(seconds=-max_age)
+                }
+            )
+            count = cursor.rowcount
+
+        self.write_message({"count": count})
+
     def query_equivalent(self, cursor, method, taskhash):
         # This is part of the inner loop and must be as fast as possible
         cursor.execute(
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index a3e066406e3..f343c586b5d 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -158,6 +158,25 @@ class HashEquivalenceCommonTests(object):
         result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash)
         self.assertIsNone(result_outhash)
 
+    def test_clean_unused(self):
+        taskhash, outhash, unihash = self.test_create_hash()
+
+        # Clean the database, which should not remove anything because all hashes an in-use
+        result = self.client.clean_unused(0)
+        self.assertEqual(result["count"], 0)
+        self.assertClientGetHash(self.client, taskhash, unihash)
+
+        # Remove the unihash. The row in the outhash table should still be present
+        self.client.remove({"unihash": unihash})
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash, False)
+        self.assertIsNotNone(result_outhash)
+
+        # Now clean with no minimum age which will remove the outhash
+        result = self.client.clean_unused(0)
+        self.assertEqual(result["count"], 1)
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash, False)
+        self.assertIsNone(result_outhash)
+
     def test_huge_message(self):
         # Simple test that hashes can be created
         taskhash = 'c665584ee6817aa99edfc77a44dd853828279370'
-- 
2.34.1


