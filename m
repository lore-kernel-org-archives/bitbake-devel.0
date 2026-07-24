Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC22C531F9
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 21:28:31 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28919.1784928508896857307
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jul 2026 14:28:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=F5XdI5AD;
 spf=pass (domain: gmail.com, ip: 209.85.210.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7eb9b427da2so1172301a34.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 14:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784928508; x=1785533308; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJgDGOKrgOhO4GqIerRQ7ja2rXw7cSOKtYqO0XqDjnU=;
        b=F5XdI5AD5GF5e+t9fXticu+COuALLT/1pwBAV8DGno2qdwolxDfwpmecE7s8K69oGx
         N9noCJw3UoG+alXHQna40J+u8UJ/mX8d9/seEF4rD+GV8uynbdERNnzyosNacsxfRfLG
         uevOcitlca/1p2Vfnk0FzwA2qNZ+8slJlgc5+JYqErGUxhuaISR1douKzJAjMAT0FiT3
         LWVv0wwQoZQXfqFbRu+GrgbPq2SOORoAnmKjO7P4xbUVwizSJLtldKJv0rkloqcfm0Eg
         fET6ZUZRLB9e4lPiVaEe27cjYo6HytoeanscbAq6JLNI0x/Z2Ndg/+HWXFDlQndXOLxR
         zrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928508; x=1785533308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cJgDGOKrgOhO4GqIerRQ7ja2rXw7cSOKtYqO0XqDjnU=;
        b=pJte5n346JBuFFbGYyJHRvfYvAQfyjplhzZ7AXjbC4h8/rJf+e1Llx4FNe0AXCW5xz
         EMF/0MKp0pEE1Q5t3NLHmtb+W0DNwANMoSefBo2XGDZOzWnqfD6LqFJTcMy33A7AiY3V
         dBCZvNbRC+Ket0VMi9dDGokzL8JtGYmkmrvSaDKEDGhkfqVH+itmq616fpkTKYADPntY
         zVYgQfJYM86wtwbcNjB5YPE2yk2k1astkV2uI5+qz9Z4VfiKivVJ4yIGjuXbMHCRRLq3
         qB8g6nud1q86djNhtvjxPzkndfivEAKmUrX8cRbSjcAU0xnCFq4ZdVtdZGMPcQ+DctfG
         rR8g==
X-Gm-Message-State: AOJu0YzEG/5OEqzL9uB821R3LVW7LDP9z9kVriZiWz/B00RqkhB2IxGQ
	rbtjYbGJAQgkODbqa3Vp+wsZn6zCDwG+d3leM8PFxgCV/1oviBhqYeE7sYw4Kg==
X-Gm-Gg: AR+sD12B7RZKs47IQcsmIURVpsgxiMFYK/Nd1MpW+yNPjGZavmpdRyuqzROayjNB/8z
	J7NxXCCzUQmjWm6NMKMrDP8N4Eh0JduL5CDjkMpqRC/qH8RBzTj6xQRQjznKF4o/nQJ8YTVuC9o
	M8y1tMSzhAC3f5EVd1IYFDS+/q3KVXX4AgTWVNvTzEzwaNu+2EPfDaM+dnG7CIaDOdZmVXyb61l
	R6dTrU8QGJB0QhkZQjPlyIpENnP1dfC/6C3v4kLrGuKBUZ5uojcVlhQvpuqM1gVSf9KhVH9rk7w
	khno0UjDqELghkYI9XeUVeYijeA1isjglNQVphzIw6/oxiVynJyPRnAzbTCzVCJuUG7AMZWBbud
	x0ir/zT9ddhviebMa6RGfM+x2abcVvjnkW0k7l4tijz4BNe4eQz3PUajCiLB2cJgeXgBn3bNiUY
	U=
X-Received: by 2002:a05:6808:c2b8:b0:496:9ee:e538 with SMTP id 5614622812f47-4ab5e33b438mr2336213b6e.5.1784928508048;
        Fri, 24 Jul 2026 14:28:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::5d97])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457673d2dc1sm8183883fac.10.2026.07.24.14.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:28:27 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michal.sieron@nokia.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 3/6] hashserv: server: Add queued streaming API
Date: Fri, 24 Jul 2026 15:25:11 -0600
Message-ID: <20260724212822.1165552-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724212822.1165552-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 21:28:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19853

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
 lib/hashserv/server.py | 100 ++++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 21 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index e7e79196f..991b99b86 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -229,6 +229,58 @@ def permissions(*permissions, allow_anon=True, allow_self_service=False):
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
+        try:
+            if m is None:
+                return
+
+            value = await self.get_local_result(m)
+            if value is None:
+                await self.send_upstream(m)
+                value = self.UPSTREAM_NONCE
+
+            async with self.cond:
+                self.pending.append((value, m))
+                self.cond.notify_all()
+
+        finally:
+            async with self.cond:
+                self.done = True
+                self.cond.notify_all()
+                # await stream.done()
+
+
 class ServerClient(bb.asyncrpc.AsyncServerConnection):
     def __init__(self, socket, server):
         super().__init__(socket, "OEHASHEQUIV", server.logger)
@@ -390,35 +442,41 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
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
 
+        await asyncio.gather(recv(), process())
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
2.54.0


