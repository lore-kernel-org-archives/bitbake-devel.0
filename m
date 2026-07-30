Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68434C5516E
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:06 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18459.1785436382787261632
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 11:33:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=B7fvwpBD;
 spf=pass (domain: gmail.com, ip: 209.85.167.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4a4cb36ae00so138733b6e.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 11:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785436382; x=1786041182; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXOoiIo6MpQbxnd+cV8Xt/g9pqQj1tssA0PVLpXZyr8=;
        b=B7fvwpBDyOrhTQmZ1VhHtyAOUsqOPKshbZCgvPmoDCt0bmXSQhijY0viBGIQ3+UuPi
         8zLKU5PlNhqhzI1SczlnQlCdhfGXKMHbxlOy0zGTIBnW1TfgPIHHvZwHct8msf8aP/h3
         l508NnY7n1769/AUuIuXjXRuvyVYX+PW88NA41kx5ZNi2DLWWS5iBb0fsfVN8hYKleMh
         Ig1ZL+nlUIWg6NUISzmDCfsSpj/0TM5zYC6ATpbuwOs2RioVMpphHGy+AjEOhAbhPpW2
         j5E9m9LxTuxCQjIUNjdLCdYyXjDXgsguXd+KCDHblxKHdmJji4UqAfJBrIhcyWJzn5E8
         1H2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436382; x=1786041182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dXOoiIo6MpQbxnd+cV8Xt/g9pqQj1tssA0PVLpXZyr8=;
        b=PKeRk6Pe9Vx6St7ym79IMwa1w7ipSkgNcJP4GEgmRm2kwMmZ3EOqlSVZAfqDOMdYFg
         cvy/HUJWBTE6/jyI4XV33+9jcfq0zJmDB/3bR1VzNgQD7E/zUgC6E0KxbiToViYyNNF0
         jvFBgh457Qs78F5w0xVgDaW2f1y2HVVVd9Ap1b3ZFZrk9FPPB4fRQTtWVzN2kAvNbRFx
         9rg6A3ed3ej7uVIJfP9QFF9ghAyf0MWmOnoOgcMHia7nDgwFrBxUHIAwyaVNTcjamWlY
         xUmo+PPJr7fAOzPa2a1Qpmva4bh1F5rNNlx1DF1vGJ/zkhcHgca+tpMT3GrsASwvx7lv
         yOGw==
X-Gm-Message-State: AOJu0YyWeSquTILqZptZ9FSnJ+N7VkUYNV6TL0mZt/3KmYV9gM/JiNVB
	hHFd9vXXH/uJD9NECHeimZ4xLZKT6i/CLcpJPXmPL4v6f31RpnPm/nMZEGmNsg==
X-Gm-Gg: AR+sD13yhy1iCiTjTxXmMjzD9LZpH+rAwoTb/TDTGwNNoNyli5fltnm829feR0Qw6k7
	LznQO1RSnmjquSZeAj0zwujbhHeqAzYFLG1FZZHUg5MpMKzAzJ8cLxxJl/ywzEH5tyES3Xi5y4n
	P2s9B3pTiI92sNAuQOp4lqbrqz6+TRckNnKbO9ubA9Eftb6mlCnpaKYAaNwhPa5SnCdTDMmN/ob
	G47fbNBnrJwVdkaz8ZlQqrJtaoKGXAPylTfXcFHmJGusVMjaf3nakf7LaSeAbKlOvUf8qKaiaBR
	lt1e1zSu+h0X4ek/rEtZzxNWbywKlrCTIpZ+pGTuKSLbwYRYPKtite2t/ZCeGtva2UT/DFB+j4M
	9tRDzCI5O3p9blV0GkP+yeJuUgO11sPMZGKnSnDzgrfHH8AQmmxTLiQyuxQJsUvgVauX0Cmx2kJ
	QxynJDJjkkr5wzYo4iqrZrvuN2erku0GlEa7yaxzhnwYer1Q8/NxxVCLuCvCIZS7Pv5gsK/Q==
X-Received: by 2002:a05:6808:1718:b0:495:d7ec:b6be with SMTP id 5614622812f47-4ad877c8949mr2770904b6e.18.1785436381889;
        Thu, 30 Jul 2026 11:33:01 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::10c9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc5c3fsm4593047b6e.13.2026.07.30.11.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:33:01 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 07/10] hashserv: server: Use streaming and queue API for upstream unihash queries
Date: Thu, 30 Jul 2026 12:31:00 -0600
Message-ID: <20260730183254.793698-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730183254.793698-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
 <20260730183254.793698-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 18:33:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19887

Reworks the "get-unihash" handler to use the new server queue API and
client streaming API to efficiently stream requests to the upstream
server instead of having to wait for a roundtrip on the requests.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 52 ++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 14 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 0fa81e85d..d0e6f23fc 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -477,24 +477,48 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
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
+            await bb.asyncrpc.TaskGroup.run(
+                self._stream_queue_handler(upstream.handler, queue),
+                upstream.process_results(),
+            )
+        return self.NO_RESPONSE
 
     @permissions(READ_PERM)
     async def handle_exists_stream(self, request):
-- 
2.54.0


