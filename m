Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DD9C4332F
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:37 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web10.10807.1698853356517266915
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VqhZupPE;
 spf=pass (domain: gmail.com, ip: 209.85.167.181, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b56b618217so893558b6e.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853354; x=1699458154; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh3crPrntZR6KdNJpuCAxMo16e+vBKZl2wShNtmMLFM=;
        b=VqhZupPE7K/bLusbzZpjuJJZ9zk44lOQBvkP3sSo2rGHSo8HHufIv1KbSfeuQ3vgNr
         CphrpqnVkePWenXBwKBeGDpGp0Y7qafTM3FrWJHTU8qCUS0Ri5yJr5M0qRPoy47ywrnG
         lecZsQpy0ssz5VBpcTXcE6lVJ0RF/kI+ItFJ5biP5qQplAiP8HeKNHuoH4Jf4PO4kAny
         uVqlBhXAghB0qUuKJEDmPu6m3LutzlLlFAw4Z7vqUNTaWZMaXP/DuXHgGPmAvgEq4Y86
         sT9fXu8a6poE78HrS0sU2NH0ICmo8cpmiI+wxeFyLQFT9qKAko61otYOItXlHDxVshgu
         2zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853354; x=1699458154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh3crPrntZR6KdNJpuCAxMo16e+vBKZl2wShNtmMLFM=;
        b=C2dlShNqNULM23mgbxMwpEHW6kq0QetTGcfULNGqrQf+ZrUQG/e3umogfgp50PCG/S
         +Mg/YWm6ZvpbLQdfPapuoTxVt8M6yMrIHcVmqfy5G5insLJ5/J8fcX5C6gK4lPX62K0O
         DENRz4xH4TnkmgnK/AX21c8QDFsZrtqpRW1dJD6SXj79Agv1ATxscvVEILXtPYAffwmn
         Jk8u1Kl5ex5QtUMor4b7CQc7Q+GYP7MfZO8b72B9Wi4xfJmBxKPfPakpAkmR4FQNQB3V
         LWFPadKeeOJ3Z/ak7QCIYpF2ezKhJL35U/Gy92nB1GvuLB8R5Jb+BF0dIUgxqsGeeUA2
         +a3Q==
X-Gm-Message-State: AOJu0YznHhtNTr/C6Bh+WoM6eWfnYc7S9TXUxIEk7TpnBzDp4MHsnpWw
	5huZ4AWpnmV03GpUJOoY4ip9CslymZE=
X-Google-Smtp-Source: AGHT+IFKgLKYlWyGNhjPnO/v53tr0fS643WONgNYE8LGmOfE5tBO1fbU4qnuLAjSlUfsK42HBmL8Xw==
X-Received: by 2002:a05:6808:602:b0:3ae:5c0c:df0f with SMTP id y2-20020a056808060200b003ae5c0cdf0fmr16487981oih.44.1698853354699;
        Wed, 01 Nov 2023 08:42:34 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:33 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 09/22] hashserv: Implement read-only version of "report" RPC
Date: Wed,  1 Nov 2023 09:42:03 -0600
Message-Id: <20231101154216.2758185-10-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15391

When the hash equivalence server is in read-only mode, it should still
return a unihash for a given "report" call if there is one.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 25 ++++++++++++++++++++++++-
 lib/hashserv/tests.py  |  4 ++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 12255cc2..2e6977cb 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -124,6 +124,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         self.max_chunk = bb.asyncrpc.DEFAULT_MAX_CHUNK
         self.backfill_queue = backfill_queue
         self.upstream = upstream
+        self.read_only = read_only
 
         self.handlers.update(
             {
@@ -131,13 +132,15 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 "get-outhash": self.handle_get_outhash,
                 "get-stream": self.handle_get_stream,
                 "get-stats": self.handle_get_stats,
+                # Not always read-only, but internally checks if the server is
+                # read-only
+                "report": self.handle_report,
             }
         )
 
         if not read_only:
             self.handlers.update(
                 {
-                    "report": self.handle_report,
                     "report-equiv": self.handle_equivreport,
                     "reset-stats": self.handle_reset_stats,
                     "backfill-wait": self.handle_backfill_wait,
@@ -283,7 +286,27 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
         return "ok"
 
+    async def report_readonly(self, data):
+        method = data["method"]
+        outhash = data["outhash"]
+        taskhash = data["taskhash"]
+
+        info = await self.get_outhash(method, outhash, taskhash)
+        if info:
+            unihash = info["unihash"]
+        else:
+            unihash = data["unihash"]
+
+        return {
+            "taskhash": taskhash,
+            "method": method,
+            "unihash": unihash,
+        }
+
     async def handle_report(self, data):
+        if self.read_only:
+            return await self.report_readonly(data)
+
         outhash_data = {
             "method": data["method"],
             "outhash": data["outhash"],
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 268b2700..e9a361dc 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -387,8 +387,8 @@ class HashEquivalenceCommonTests(object):
         outhash2 = '3c979c3db45c569f51ab7626a4651074be3a9d11a84b1db076f5b14f7d39db44'
         unihash2 = '90e9bc1d1f094c51824adca7f8ea79a048d68824'
 
-        with self.assertRaises(ConnectionError):
-            ro_client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
+        result = ro_client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
+        self.assertEqual(result['unihash'], unihash2)
 
         # Ensure that the database was not modified
         self.assertClientGetHash(rw_client, taskhash2, None)
-- 
2.34.1


