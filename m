Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EDBC4167B
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:12 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.web10.1620.1698772923681099928
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KAB53zid;
 spf=pass (domain: gmail.com, ip: 209.85.160.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1e9bb3a0bfeso3917435fac.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772922; x=1699377722; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh3crPrntZR6KdNJpuCAxMo16e+vBKZl2wShNtmMLFM=;
        b=KAB53zidXAl5qhV6H0pTKyhoDeLiXPrBICNkq6gNB2ng7BAfIoAG1V3vDE1ZtY2QHk
         U2fzDyhRW5B7/YZkrFhFo6Lr5oWh7wcyEg52BIm8K1agrX154SCrpFj2q5Pdb8n9/N1X
         OninjDtJWI4tZA5+IGbMs++PsydBrZP9Qf36PG5LAwpY/FSn5nkR2ejx638F9QS1547U
         ITdUoTlkoXZ/l39fYQwXSREkfufCf0zzbEQ5t+UBNVdgwWKGamOgCfb0Dis4ZYR3wT7b
         t5bcxRnjT/T5r/hWTNsud3GpqpBLEoCFRZRpg/dShGAvfv7v9yc0t220wCSin7cUe0s/
         sK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772922; x=1699377722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh3crPrntZR6KdNJpuCAxMo16e+vBKZl2wShNtmMLFM=;
        b=fTay8wbuyYOsEZZYD3tIUzSiLD+bRjkbMfpLiPJYIahOTD6M0gDJ5qzOuzPTyQ16To
         r0uTeda8SGFtmRlMngmrDS3VMhNd9xvTqi/ku79pUucba3VePnyp5MuQbsKNfb9OqbIt
         N7xjvUb1dF0g6rTVsKNjErlbshJbKdqtIuonLbS5qAH0DrbshRuHdlqF+Lu2z9Jo+ZP/
         lorNXOIP4LzBuYmqdfTeGaSoDf/JdjPEqLpRbFhIOREhxjUpqg/veBwUp57xVG0UNOei
         2oms/W3v6DepcA90kOby5Bks5Th9rrD69dzOvH+F4pBRFPnzLFT5V+T4ZHWjfYj5C82D
         vOjA==
X-Gm-Message-State: AOJu0YxxB8sFbL/kz6iQqRU/dQ08/KxY6C7ZOD0bLMBcyfnysYrWpSHp
	vJQpPiq7GiEWRgEzPe7IDAHIIStA7+w=
X-Google-Smtp-Source: AGHT+IFjcHFLzBnbpyEkIj8Wc088W2WCjkDQ5WzqdeH+IyeCz2uZ49tOwCwRxFcL0UuuRgWWNoxeCA==
X-Received: by 2002:a05:6871:8785:b0:1ea:206e:cb10 with SMTP id td5-20020a056871878500b001ea206ecb10mr16442891oab.22.1698772922426;
        Tue, 31 Oct 2023 10:22:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:00 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 09/22] hashserv: Implement read-only version of "report" RPC
Date: Tue, 31 Oct 2023 11:21:25 -0600
Message-Id: <20231031172138.3577199-10-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:22:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15359

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


