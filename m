Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5181EC41513
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:25 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web10.25784.1697149040260621736
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KCmKV5EM;
 spf=pass (domain: gmail.com, ip: 209.85.160.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1dd8304b980so858590fac.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149039; x=1697753839; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL3HYBqhnaYRY+C5+iQ36lUtqAuPpQYGlxKlziluuyY=;
        b=KCmKV5EMIbPPPTfiE0qMj96wI4qNNUGhT4UcL1cXXWFhx5VaZTJ1wQTckM5q4QJb3l
         70I1m0x6oaKP7GCakQnKnFtH2E1iNuibzAcuNb+/snvxXqWhxSHzz9DxurVFXI92aGxS
         euiFeNVZljkB6S1ARcvkDIWGsMoVHL0zLnYVxNICPyXexJdM/SXPBtdOVLaZX/QO4HXE
         hEMqQvdUCVokijNujszS2OE39H/rJKyWWZwQ3xWQ3s/3R2QbUpwakhbW2Ss46QLxoZJH
         JlWxdn9JqDwLWMPGxLHEhaPG2Otj+OBx2xDTjwOb6Iz97mChCPHjUehAumRfmWIgCzya
         tIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149039; x=1697753839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZL3HYBqhnaYRY+C5+iQ36lUtqAuPpQYGlxKlziluuyY=;
        b=tCUGemaxjKxN+IuMMh1K6l09aMsbZO1JJ6tV/44mHWGXDH7bjezRADFRDwbEDOAspR
         sJpua6ph7K7rEuwBK7GAC5BnymS++gK0WRllnldbMDcukH7xecn8KGdSJa7IL8H+IlZX
         53LPpY/bMnfoodgmdkJS8pB2dXBYj95vo5Zoas3kztJWnhTm7Z/fzBwy7gjasVfCDC/e
         zDHysbWbYcbaXftLr4GXpFpAisHCa+Lco6/JC/IzSeYIvuD+KM6070gZE3hqOWi1JdYu
         rUxjsFovhEIqRS8BrT8YZU+wZUYjTzVgB3QlyS4z792Z02hdnRsr38Q8Za5mLbq6eiep
         p45g==
X-Gm-Message-State: AOJu0YzViUkHxlVB5zh2+MTCuW3FaIrGF43bkkuKM3Aal2maRrnIgV7+
	Wc18t8OOX3l/K84fP1B9ZZ5CufJX08M=
X-Google-Smtp-Source: AGHT+IHk3c1KMEsecP0/vWYuWt66SQnrNKfsmcMNhUviUycLPcckwn8RnNHvKwbMkZU2g32sNntgDw==
X-Received: by 2002:a05:6870:1194:b0:1e9:bfe7:e842 with SMTP id 20-20020a056870119400b001e9bfe7e842mr2539538oau.32.1697149038982;
        Thu, 12 Oct 2023 15:17:18 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:17 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 11/18] hashserv: Implement read-only version of "report" RPC
Date: Thu, 12 Oct 2023 16:16:48 -0600
Message-Id: <20231012221655.632637-12-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
 <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15229

When the hash equivalence server is in read-only mode, it should still
return a unihash for a given "report" call if there is one.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 25 ++++++++++++++++++++++++-
 lib/hashserv/tests.py  |  4 ++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index f8ea649a..1299558e 100644
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


