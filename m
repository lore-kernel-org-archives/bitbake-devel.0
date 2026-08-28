Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EC8C61DD9
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:55 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4203.1787932792309588629
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=ZtAczjl0;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9eaf04bfaso513870a34.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932791; x=1788537591; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xvj+eveOAyyIuwPOF9snYwI44PrD8WXGB8NyChgMC+4=;
        b=ZtAczjl0tYCIXNbHcEsRWnlmg1csOjRDpAQRpI/VV0pgJbwnmaRJVGCXhzXyyg9xoU
         L/HBT5miD9qJ26OuVP66JxoA31zhhbdg7ceXA09e/NyZj7yNxhwDw2nZljHyNGJyYztD
         CymXRSedxyx+a+J3j5ZpH7mE7D3rYC/KWSH6mRuEzX5BfA9xUiCNvTiVxQ/z9FrpQR0g
         cv74mb1dI7iMI1Pw33GnjUh8BFUiLaHx++XECAQNFUbrhYfGraMkVfxfM53H/nVoZOW3
         +yHrOq7r+w9h5Wy74kSe+eXeu7HO2+5wiaNyMJwKZpv+UJAW6y3OGGsGd0Q9I1/QLbrE
         Q2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932791; x=1788537591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xvj+eveOAyyIuwPOF9snYwI44PrD8WXGB8NyChgMC+4=;
        b=XtBp/XKqmwqgRMvq6L33VEQo5bIQwAeVWiJcNwn3WZvqwuNN1lXtTlE5TCXdlG2bxW
         ZViC7UJ8I/kgLHK0/+AD5jvZvdOMcAemU4nz4DM8ipz0drL4a17dYoKl0aw6noUB4HUG
         vyfpmCtoWDovfAeXQP+vqdaVm3zTpYq//JTDxNS8Vdn+SCZRe21EigBMDz9lU6HnB5k8
         k8/xI83SL41mOz0qPiiSt1+hQP317IEXpRTtrpqQuHHzpsRL5XMj1jjcERH5GSbWokP0
         VJMCrOasEbZG7XsFsKzlX7+Yw/Fw1pHg6dxYHpy1Utqa8fX7d4Fh9+n8rjQ12IIoCseL
         xaNA==
X-Gm-Message-State: AFuF++mDmct7IyPkSXJ2bvHtHzBP9ezNZ4uxcaGFdozBoTuwa1JKVosu
	NQMfnVUyID0CzkiRhwJhBSgRyTtO9OgR7W3MTnujaM0079eBIfanJyO3ZjlBlA==
X-Gm-Gg: AR+sD10nHuKqKZs44ueWuWzin274vv6LixUbCBeI8ymV9zyTSoBQTYujsODDhIwxprk
	22wM9PqQCWpA5Jx3azhWHJ+eWVsFa1GpqvdsXdpFgpS1qcSAwEmbpEE+M46F/ujWW8ydr82uPec
	JZeY4evEgox128GlanOzG8VEj+CueazsFHzcDRtQ4iSUT1e/MFHLWtXLe8x30pOf46kLEU3wYaA
	4zdOPX0OvW+SaVk/ptW/D7Pyn1YHOxlMx8nzle1LU2xC06wuQ7M7YCxzqehVtYAyvplpgyse2Kx
	y2b21zwImb9OSiR+5sj2cNx0O+7GhJ75KpBg9l/lvCwPdRarv+wGo+HpeUrrBYv6HcNv2vdP5y3
	O1RPa3u8jVrAJmQwuLeTZN9l3zcpN3+2EhPAGqY89RSn3DWwtLqirq1eGORBdwnFHxXQsgCgz94
	ANDnUHJo2cKVt4kwVqTiKgJUdud2oIfol/Pi6n60JZm7Fus4iedAC7OnaiNA==
X-Received: by 2002:a05:6830:4984:b0:7f4:eb76:8820 with SMTP id 46e09a7af769-7f4f24e6456mr9454246a34.13.1787932791294;
        Fri, 28 Aug 2026 08:59:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:50 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 07/11] hashserv: server: Use streaming and queue API for upstream unihash queries
Date: Fri, 28 Aug 2026 09:58:14 -0600
Message-ID: <20260828155942.1219468-8-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828155942.1219468-1-JPEWhacker@gmail.com>
References: <20260730183254.793698-1-JPEWhacker@gmail.com>
 <20260828155942.1219468-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 15:59:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20113

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
2.55.0


