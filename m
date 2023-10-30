Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FA4C001B0
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:14 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web11.158494.1698693486366593524
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Px0dHi9m;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce2de8da87so3205271a34.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693485; x=1699298285; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL3HYBqhnaYRY+C5+iQ36lUtqAuPpQYGlxKlziluuyY=;
        b=Px0dHi9mQyXG2oy59THIvi1L4AlaKg55p/irDR/wkIV8D3ydVaK+lmFh3FzK27ldO0
         OKcy3bY/XKA2GbEkjshzMQ+xdNADatMVtcpgkUgTm7oJzJk+BlJTubP0Ubcft0nAONfL
         On1aPEunG1UfrYOjqzrl8MUWKNhkMP+pmTNU+9Xyb1CCPdodhWDNZncRSwh0NWInAJGa
         mchwidTHgVdHxJyWmEGog+guRdRM4mLaoqi6Tv3loGCWFFFiHxuMM+N0NVf6VWrXu9XX
         F0q0Dk+lB3umg/8k60r2kdj4i/3PypML/deIy4e8878L8fcVOht/w7Caef6Mud5uaXZc
         8L0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693485; x=1699298285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZL3HYBqhnaYRY+C5+iQ36lUtqAuPpQYGlxKlziluuyY=;
        b=NsFSNenvcbyYpP1cblGBoBii17FqF+qZE8nQl5KehblRYjMXYC0WggnKkPfwGuyN32
         GZf9D5bQV5lt1H/IAXtZ4YXsF6ugMzcu6yOLvG8X/rsZmqDfbRUps3ILwS/hpShcuTob
         viphSdfV8jF5uir19LHx9pegsBxG4N6iKUBp7gIVlBLK5ndSXHsbUsWWqjSS8g15Eb1v
         5ELwHUE2HHb53poO2785Dg/IL8VX95NvQH0FV4wPQnR6HaHqkDGIne6E7dM6EERYPo4z
         epkxXjKxU3W0OD3r3pVoQG4HOttXTalskoR1NGOeTncxaKDOOh3uaeK4mKQFSCRreiyD
         fe1g==
X-Gm-Message-State: AOJu0YxKTET1eLTgDtkorKEAmm0Zr4RoY83gxLJQWSNR5Qstlew7Vfu5
	FUCWb8RciwYbEHN6hdURGjy2V6ce2x8=
X-Google-Smtp-Source: AGHT+IEU34iK1N7f1FSYlnR/c5gKI1+DiLpXvkBwutBJhhv6iDIeZSMYK3NlvI9Qkg4PMkt19jrNvA==
X-Received: by 2002:a9d:3e09:0:b0:6d2:e1fd:9f5e with SMTP id a9-20020a9d3e09000000b006d2e1fd9f5emr9347124otd.6.1698693485001;
        Mon, 30 Oct 2023 12:18:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:18:03 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 09/22] hashserv: Implement read-only version of "report" RPC
Date: Mon, 30 Oct 2023 13:17:15 -0600
Message-Id: <20231030191728.1276805-10-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15311

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


