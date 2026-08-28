Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA224C61DE1
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:56 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4138.1787932791392230838
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=svLmxYSB;
 spf=pass (domain: gmail.com, ip: 209.85.210.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f0167e59a3so741631a34.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932790; x=1788537590; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jb1Dzfauv3VZlZPygDmNfwFlNe3kwbtyFp5vbhuxCh0=;
        b=svLmxYSBy2UE7G2czAGTmJkeO+3kB2jG1QdvUA4tmkdb8WgTVrvP+Bo5zYijifrZ/4
         gDqvq4UdjcJjqKFpPu9AyRZez8IK5klu1ioO7n+uABenERLgmRCaIcwu6sOuNrXwh1f0
         uzTRsTGjI9BwtqYatAbI/7IigGB+pjcTKUvR8A6bnARFElJM6/WsNv0nLN/wuDCu3gP4
         cW+YPSc+5U66Zfim98RsRkM8wdqeeQes45rIuI7Ypy/BrLJSNed9uSfqqYppevOicqJr
         b/uctVi/oPgVmsDUu81ksAXb8ghI82WUFP/abIBEzzK2zYL47ABqIVVSjmFTVFoiSTXp
         9vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932790; x=1788537590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jb1Dzfauv3VZlZPygDmNfwFlNe3kwbtyFp5vbhuxCh0=;
        b=DNZi66NjdaYkbfCOtpJINAcoa9l3InNButOX3koelMU90Gc/71ROFqDQ52jC17B5ER
         N28yhEhchUSvLhvujb/dKggNMpJ0QymJY2vBuCqnpTUKvW16HZ7DACM7WexNK9rdZiAK
         zGR9Xr/Ol6rmjQlJoBXU9BmwUFrTpI3OCbaDFidsU3lsslrZ+Sl2JbIasoW7JQwv0adt
         BSwZLBLp6ZCvwktqyCfvY6QhB9XOPc8Gt8YH9oJEFqCG2fsgHfpAN1FPpzvOJBneffgD
         Potm7aqR2x+4u6nZAS5Wjsn0mF3nnARMusFHAqziFH9Mc9orxCKi3haqB2hFWn2PFBY8
         KjqQ==
X-Gm-Message-State: AFuF++nLHcYHWGenHxBh+SaYVSJQOgrLwdo1TlTjNEdB4vuIce0AyzbS
	dCSoAqrD6CrKNbn2LuajHfHUK9F1j4syyxat5COHw/VDugVkXVabdbgAHlsZIg==
X-Gm-Gg: AR+sD12kU15nCwdOrm0C6dFM2fLVYnAvUgu/n8BR5hGPv3pM7KZffgpAPK1zKaQF5fn
	WCga13ho8zY9ZPwmdP1se6YaK6TJT7ka2K1LACPAiGxnE3XecZ8FcKDKguKx6b1flpW7KIvyRoU
	mPG0M3mYdKLpjzBOH851kZLh/NyD7XgpTZMbf2bS7cLM3bEnZzeCowL6UUvBjLzii9yXvqbuYtC
	1EJipKjal7wLAF8C+7DBx1woYck1pl78wH5dBj1FwbZ9vZtxV7rIwA3Y+QGYyzwgZ9DWqP9ibi8
	c+LmTZLgSm6XDMICVK89s5L+/JkhnCHk4AGSt07J63gTjZxYEVaOHGHAHYpMtiL1mViYHJ/jq3L
	CUALm+0RDx6h4KN1O6AfcwF2spqfuc81T1q4RTPLGTmG/b+nXu6GTjMmzQd8TSS8LergpXvWFPE
	SqXkkOae8k5pdJB1s7u2bXSK2WX+0vSx2u5Z852cAh+XLvv30lj4ACNrMSeQ==
X-Received: by 2002:a05:6830:4406:b0:7e6:cfd0:42de with SMTP id 46e09a7af769-7f4f2624dc3mr9607954a34.15.1787932790452;
        Fri, 28 Aug 2026 08:59:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:49 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 06/11] hashserv: server: Add queued streaming API
Date: Fri, 28 Aug 2026 09:58:13 -0600
Message-ID: <20260828155942.1219468-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828155942.1219468-1-JPEWhacker@gmail.com>
References: <20260730183254.793698-1-JPEWhacker@gmail.com>
 <20260828155942.1219468-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 15:59:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20112

Adds an API that allows a stream handler to more precisely control when
a response is sent to the client. The new API does not directly send the
response from the handler to the remote client, but instead the handler
is expected to put the result in a provided queue when the response is
ready. In particular, this allows a stream handler to defer to an
upstream server (utilizing the new client streaming API) in an efficient
way that does not require waiting on a roundtrip with the upstream
server. Instead, several queries to the upstream can be in-flight at
once.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 96 +++++++++++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 21 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index e7e79196f..0fa81e85d 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -229,6 +229,54 @@ def permissions(*permissions, allow_anon=True, allow_self_service=False):
     return wrapper
 
 
+class UpstreamQueue(object):
+    UPSTREAM_NONCE = object()
+
+    def __init__(self, queue, get_local_result, send_upstream, get_upstream_result):
+        self.queue = queue
+        self.pending = []
+        self.cond = asyncio.Condition()
+        self.done = False
+        self.get_local_result = get_local_result
+        self.send_upstream = send_upstream
+        self.get_upstream_result = get_upstream_result
+
+    async def process_results(self):
+        try:
+            while True:
+                async with self.cond:
+                    await self.cond.wait_for(lambda: self.pending or self.done)
+                    if not self.pending:
+                        if self.done:
+                            return
+                        continue
+
+                    value, m = self.pending.pop(0)
+
+                if value is self.UPSTREAM_NONCE:
+                    value = await self.get_upstream_result(m)
+
+                await self.queue.put(value)
+        finally:
+            await self.queue.put(None)
+
+    async def handler(self, m):
+        if m is None:
+            async with self.cond:
+                self.done = True
+                self.cond.notify_all()
+            return
+
+        value = await self.get_local_result(m)
+        if value is None:
+            await self.send_upstream(m)
+            value = self.UPSTREAM_NONCE
+
+        async with self.cond:
+            self.pending.append((value, m))
+            self.cond.notify_all()
+
+
 class ServerClient(bb.asyncrpc.AsyncServerConnection):
     def __init__(self, socket, server):
         super().__init__(socket, "OEHASHEQUIV", server.logger)
@@ -390,35 +438,41 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         validate_unihash(unihash)
         return await self.db.insert_unihash(method, taskhash, unihash)
 
-    async def _stream_handler(self, handler):
+    async def _stream_queue_handler(self, handler, queue):
         await self.socket.send_message("ok")
 
-        while True:
-            upstream = None
+        async def recv():
+            try:
+                while True:
+                    m = await self.socket.recv()
+                    if not m or m == "END":
+                        break
 
-            l = await self.socket.recv()
-            if not l:
-                break
+                    await handler(m)
+            finally:
+                await handler(None)
 
-            try:
-                # This inner loop is very sensitive and must be as fast as
-                # possible (which is why the request sample is handled manually
-                # instead of using 'with', and also why logging statements are
-                # commented out.
-                self.request_sample = self.server.request_stats.start_sample()
-                request_measure = self.request_sample.measure()
-                request_measure.start()
-
-                if l == "END":
+        async def process():
+            while True:
+                m = await queue.get()
+                if m is None:
                     break
 
-                msg = await handler(l)
-                await self.socket.send(msg)
-            finally:
-                request_measure.end()
-                self.request_sample.end()
+                await self.socket.send(m)
 
+        await bb.asyncrpc.TaskGroup.run(recv(), process())
         await self.socket.send("ok")
+
+    async def _stream_handler(self, handler):
+        queue = asyncio.Queue(1000)
+
+        async def h(m):
+            if m is None:
+                await queue.put(None)
+            else:
+                await queue.put(await handler(m))
+
+        await self._stream_queue_handler(h, queue)
         return self.NO_RESPONSE
 
     @permissions(READ_PERM)
-- 
2.55.0


