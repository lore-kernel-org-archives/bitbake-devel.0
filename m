Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EF5C4332F
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:16 +0000 (UTC)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web10.53501.1699021626949490201
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KABHuV3a;
 spf=pass (domain: gmail.com, ip: 209.85.210.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ce353df504so1127188a34.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021625; x=1699626425; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/82KivEWLwiKIQtjUTe0YlniKSHuDFQUpznI9gfsIs=;
        b=KABHuV3a6zfvVYZmVTEaDPbX6lGJtE/NMUyu0GspH8NRYTMJdM4FFeCEPzWH7HP6BS
         w1OhxbTHRlA+IvpfjB93kz7Ih0JMq8rE5b1lV9ye48u1g33efZ4QZoSLumQUWKEDOSIy
         zYK1EI/N/Sqe/PkitKI1gBIf98GLePezjx8OsOGIBccz2bS+0cp6ivtwQrrg9Oumt9je
         QrTr2pBAr/WvBgDq8TbFdVzrCNRXK1wj47RcmqQePGBsk/ekvjD2EqC7/sedeAENTNwx
         jBUexi6zqGTpfaDWXhTJCpPrbYIAEeplfvthTY+eFPpr83WlYOg8pPeVA6whw5jWluEk
         XKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021625; x=1699626425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/82KivEWLwiKIQtjUTe0YlniKSHuDFQUpznI9gfsIs=;
        b=IhLgcn78ipblNmvE3AvgKrT7N3ysRbKMz3mQugG+ULDutswdBWlWycrMedNuJN/9Cu
         7jFEZF/q+dhqQbGPeYQtwpLcehtA/C9vLIMYvbjZyYX/BOzdwZfqfyUIbqwEVO22CLw0
         Gt+zYFTgkINRKM1NaUyfOk84Gw6kJvj7RV3YQBkdKVpiQ7+qT8Hex+tr9vJS9maiNI2S
         CdxiLCRM4dOlBwJraD9JguojBSozKRSrrUMImtwR35FuEohRRkHJbKQ3+JldvMyEecvA
         dPol3g1QTRUWKomUbg5KlPRFRyuEZkZCWJe/JkFcb2sjFPeFUdq14XWQ/UbRTu9MG70t
         9uUA==
X-Gm-Message-State: AOJu0Yz5+5nSs0nKM+tYo38yZsfZ9Bkgo+EeH7UYukBrWSg0dCMMenCL
	VWv6odf8zBjL0yDhIrhcseZ7cfhW78c=
X-Google-Smtp-Source: AGHT+IHJkql4xfXA3AuXeh73oNrF/473b+N8aDvvE0geTS+I72XeR9kUoBS46Nxde/b2eBA4kG6OYg==
X-Received: by 2002:a05:6870:9120:b0:1f0:3b3f:8686 with SMTP id o32-20020a056870912000b001f03b3f8686mr7620658oae.54.1699021625525;
        Fri, 03 Nov 2023 07:27:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:27:03 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 09/22] hashserv: Implement read-only version of "report" RPC
Date: Fri,  3 Nov 2023 08:26:27 -0600
Message-Id: <20231103142640.1936827-10-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15430

When the hash equivalence server is in read-only mode, it should still
return a unihash for a given "report" call if there is one.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 25 ++++++++++++++++++++++++-
 lib/hashserv/tests.py  |  4 ++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 84cf4f22..c691df76 100644
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
@@ -284,7 +287,27 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         await self.socket.send("ok")
         return self.NO_RESPONSE
 
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


