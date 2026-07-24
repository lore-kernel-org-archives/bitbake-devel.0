Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E773C531FC
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 21:28:31 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28978.1784928508300628099
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jul 2026 14:28:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=n/unC41h;
 spf=pass (domain: gmail.com, ip: 209.85.160.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-448479e0eb6so464784fac.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784928507; x=1785533307; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m6B/k+wGcWhzzpYrSeOAg49ZYJraXxDiY7Tsj1AzqJ4=;
        b=n/unC41hhUphPKFuELGTkm/yihlEUbGD/ybW4GS2xLmaadpO5TGzyhyGQgwEB7NQu/
         239vvpa86zQ9a5HPCnmE9Tu1O1o6rPsHqGbxkscQsU0G1VvlvbyAkoNu/ZlWjI0mPfFP
         BKDXO9N9VgiE5lmSV3NmifiVgw5qJoBIM2ynR5i2PNsn9tUTTXxjfP2HL4KXZrdX/hv8
         9SeDGVm0i/MOY7je1sfui7ZmsBjRQ4H4G09ZXt2EO+D90coV4uD2FhBnbbkGXYe2rT3k
         HqEsJudusERweWHXFmte4xUtL6W7UBdEV1GvYYcDUOfcNPnxSpIoQslmF/QnHAko032w
         4GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928507; x=1785533307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m6B/k+wGcWhzzpYrSeOAg49ZYJraXxDiY7Tsj1AzqJ4=;
        b=iqXSLlS8vABL65iskws9VpyYsaMs6KrS/ht47yx/kMkZp2Z7anSuRIq/Yg312+oR8k
         Pwt6GWeizFb1ZkPnGhA8bWZ2r2oHz5NZ03PASnJ57rtZumqN7ENQKjsw9Lgq93BV5DmN
         vNUxkyz0MUvw/KJ3HF6HIWh5zZXfmQkp6BE7nexzkP7pZjY7omjTRl6qT7gTlzWIpkN9
         /t10k08itSVzQxiaMEnqumulELFFCAoZl4X5rTAqkaovKmzis9Kpu7lvHWyTaE6pAT1X
         j1yAdm/DiZb0zsz2Xzpe21QvZx8MVWq3iGCXceS9jhyJu7mFq6vzd+YoMHr2GJXhk9jK
         sECg==
X-Gm-Message-State: AOJu0YyQmNeH7KOl/caDERuvuI9LnD2flm7cF415mOrYmnz3G7aEcBH7
	A/4WkfUKIoYBxxIdaSf1qj/ePz6BkFKnxKJuVj5zXvxo3byiphqf3xSJyqzF5Q==
X-Gm-Gg: AR+sD111AfFLcF1V7D6+kaTXPJQWbdiyqKwPuwp8WYQ3Mwmgh6vZBkgmL1Jg122Rgko
	GPlVlCF2+TpI/J5AX/I35zkjMyq2yMKlklNEUBn5+ZM5SFX/frH/TZPiDijeKcuBspTvg5s/xuZ
	Zduy5g7AaLIqRNqL8GdR1yjXrNQYQN1lWMeTMoumvLFr9TcsvH2b/1ZqCzVRSQI/Y0u7dnpv7jR
	9xcKRpFkGf5tlbJkAh8DJsxgs9smvS4KnLaFKCWtl9qQVkxsGl22f9lDHveGP0w/f1cf/3QFWU6
	J6IQj5HFyg8HehqY6hM5EdFNr6b159j8NqxCbVDFy1X+2Asc26i/Vwju7Cn4Q8dOs43NBDFwp1V
	gJWxr81k56G+oA7lwEWMdeaVdAl5/rfH/Cb69pscWCSkVIWaSo29UzsFXQEg4prX4RSYS0OrDmQ
	A=
X-Received: by 2002:a05:6870:524d:b0:448:9a86:aff9 with SMTP id 586e51a60fabf-457f247a42fmr175175fac.15.1784928507323;
        Fri, 24 Jul 2026 14:28:27 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::5d97])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457673d2dc1sm8183883fac.10.2026.07.24.14.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:28:27 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michal.sieron@nokia.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 2/6] hashserv: server: Fix formatting
Date: Fri, 24 Jul 2026 15:25:10 -0600
Message-ID: <20260724212822.1165552-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724212822.1165552-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 21:28:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19852

Reformats the file with `black`

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 3ff434785..e7e79196f 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -424,7 +424,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
     @permissions(READ_PERM)
     async def handle_get_stream(self, request):
         async def handler(l):
-            (method, taskhash) = l.split()
+            method, taskhash = l.split()
             # self.logger.debug('Looking up %s %s' % (method, taskhash))
             row = await self.db.get_equivalent(method, taskhash)
 
@@ -646,7 +646,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
     @permissions(DB_ADMIN_PERM)
     async def handle_gc_status(self, request):
-        (keep_rows, remove_rows, current_mark) = await self.db.gc_status()
+        keep_rows, remove_rows, current_mark = await self.db.gc_status()
         return {
             "keep": keep_rows,
             "remove": remove_rows,
@@ -903,7 +903,9 @@ class Server(bb.asyncrpc.AsyncServer):
                 d = await client.get_taskhash(method, taskhash)
                 if d is not None:
                     if is_valid_unihash(d.get("unihash")):
-                        await db.insert_unihash(d["method"], d["taskhash"], d["unihash"])
+                        await db.insert_unihash(
+                            d["method"], d["taskhash"], d["unihash"]
+                        )
                     else:
                         self.logger.warning("Upstream server returned invalid unihash")
                 self.backfill_queue.task_done()
-- 
2.54.0


