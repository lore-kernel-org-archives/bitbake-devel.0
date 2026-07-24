Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDA2C531C9
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 21:28:31 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28980.1784928509707117223
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jul 2026 14:28:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nNKu7csa;
 spf=pass (domain: gmail.com, ip: 209.85.160.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-451d8064238so505670fac.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 14:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784928509; x=1785533309; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kzMNtYN/R/LBgC0qMvBwsXC6aLcsl21fA5MMzT99uNg=;
        b=nNKu7csaUiU1QfdD7V6BwcuLfpuhw1xQvbPdhqNbmgBctzXpznwkAurfa4z65Zpv2C
         EskCM88NJpP2qAW8+R+FrUIO7urSCm8n8yD1stgezaQXT7eKcoKt8oqbKfPeSgHP/y6M
         1ezrn+poYt7GOVv0hYrVYRCMSnCn1TOv+LRr9BmCxuHTdo16zTF+pb9krhAOrev8NTlp
         k8dB/TbJAfvqTviRTAS55sdRmurlhXydweYZU81w+ru4OZ8IbBzOaKGPr4PDatJ8TR34
         dsRwPWccCwBuH3eZqEMFPA9DvB7nGAD4uwIkMww4lCv4/9TuGPEplWIeOuRP8diPHWm/
         K4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928509; x=1785533309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kzMNtYN/R/LBgC0qMvBwsXC6aLcsl21fA5MMzT99uNg=;
        b=mEfb9vvOuYO5P/FMdD9A3PUygLlkIlhXlShV3lwHZsOuQ8dpFPfaAwf/OMl1LAa6n0
         gbz1zplw6j4DDaySGxNtZbcZUNxqCgEuDSm+4CGNRSOBV1B68FAokBkyCLw8S7hZqNsc
         2+J2ua77J/p+1px/HzHodCqHxFZGCcxRbRN/yLSq/T8HPdKyFpk3ho/FjyyQihWLbwNP
         Mk5g9qE6t0pvqCFfuGeDPbnT0TO6MJiayp7tms31J1dGgWrOmTwAlSuB8N+Jqll55WHv
         a1r15dB8hacMSJZhB8coSDOS711fT6Y+zo0eEjTP08l3M0O5EynyOFMR8FR0P9rbAM+r
         RUEg==
X-Gm-Message-State: AOJu0YyN5U1JJrwpv9uMlN4UEeP3ATE+SVOQlD39i7nNLWOZ8P3rw4Mx
	T6+Gq61AiGaug+CqQheDbsv21TYF8k/yvIvu1+TFEaRyCE8h6D9wdnIaBveDJg==
X-Gm-Gg: AR+sD11E9M9kG+PKiOry3P8/yD1fNHT9NnrJafaI+pfzXc04G4j6sGY810Sd6fn+P+4
	ldYwW9hPvQgOZGUy/2crv3LiUoeM2WXARO/7LtNCu80JRjLIKFogzOqYgWCQRjHbs9CUHgJMFRe
	8ip3y/4Aj18524SMgjFFWshb4aWfaeem8UI3W5f6xcKg6z0tXolFVA0tl3vSPo/GDztD7jjskjO
	9homjxc0v3DXlwbahXudj6nCsnFE8UKHGiGYH4XT4oASCbPVztuO/vVuXVyID/rSTLvEm9Pr/rm
	qXOkqeFZ3ZB9qvwEj0PLt02L+xPSTtBJy0Tdfwf2oZE68jZ89gB0AvRHCIofPyqL9Ns1XgJuOs+
	62MOJjXOUQ4XzvUo+ocAVVfm7BkYNT+h+LGRiTyTowFqg3Lf5TBVjl9bCmSo6ZEvYgT2gIpo8LU
	o=
X-Received: by 2002:a05:6870:3195:b0:448:c1f5:90f7 with SMTP id 586e51a60fabf-457f24df7d7mr207095fac.19.1784928508864;
        Fri, 24 Jul 2026 14:28:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::5d97])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457673d2dc1sm8183883fac.10.2026.07.24.14.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:28:28 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michal.sieron@nokia.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 4/6] hashserv: server: Use streaming and queue API for upstream unihash queries
Date: Fri, 24 Jul 2026 15:25:12 -0600
Message-ID: <20260724212822.1165552-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724212822.1165552-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 21:28:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19854

Reworks the "get-unihash" handler to use the new server queue API and
client streaming API to efficiently stream requests to the upstream
server instead of having to wait for a roundtrip on the requests.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 52 ++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 991b99b86..d392ac19f 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -481,24 +481,48 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
     @permissions(READ_PERM)
     async def handle_get_stream(self, request):
-        async def handler(l):
-            method, taskhash = l.split()
-            # self.logger.debug('Looking up %s %s' % (method, taskhash))
-            row = await self.db.get_equivalent(method, taskhash)
-
-            if row is not None:
-                # self.logger.debug('Found equivalent task %s -> %s', (row['taskhash'], row['unihash']))
+        async def get_unihash(m):
+            method, taskhash = m.split()
+            if (row := await self.db.get_equivalent(method, taskhash)) is not None:
                 return row["unihash"]
 
-            if self.upstream_client is not None:
-                upstream = await self.upstream_client.get_unihash(method, taskhash)
-                if upstream:
-                    await self.server.backfill_queue.put((method, taskhash))
-                    return upstream
-
             return ""
 
-        return await self._stream_handler(handler)
+        if not self.upstream_client:
+            return await self._stream_handler(get_unihash)
+
+        async with self.upstream_client.get_unihash_stream() as stream:
+
+            async def get_local_result(m):
+                method, taskhash = m.split()
+                if (row := await self.db.get_equivalent(method, taskhash)) is not None:
+                    return row["unihash"]
+                return None
+
+            async def send_upstream(m):
+                method, taskhash = m.split()
+                await stream.send_query(method, taskhash)
+
+            async def get_upstream_result(m):
+                unihash = await stream.get_result()
+                if unihash:
+                    method, taskhash = m.split()
+                    await self.server.backfill_queue.put((method, taskhash))
+                return unihash
+
+            queue = asyncio.Queue()
+            upstream = UpstreamQueue(
+                queue,
+                get_local_result,
+                send_upstream,
+                get_upstream_result,
+            )
+
+            await asyncio.gather(
+                self._stream_queue_handler(upstream.handler, queue),
+                upstream.process_results(),
+            )
+        return self.NO_RESPONSE
 
     @permissions(READ_PERM)
     async def handle_exists_stream(self, request):
-- 
2.54.0


