Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9160DC55172
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:06 +0000 (UTC)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18458.1785436381830164031
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 11:33:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=PoCJYjwc;
 spf=pass (domain: gmail.com, ip: 209.85.167.172, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-495b98b4f6aso98261b6e.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785436381; x=1786041181; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJ9d+Yy8ysHYMM9q9YAN46OY943/I3hmMwBY4dTdLzs=;
        b=PoCJYjwcnwZkt4XV0ymEzG5hH9h2gTZA2mauaMqCeXlv2eApGOAeuB/onMqBOT/0u+
         0tSvqKljRc67iOU1NLp0UguaYIPqKmW9XBxDomuL0kjVnh050kdRsTfCIglpAek9yK2X
         VaVvQvnkHrK3QF1WZVnaA+WOqiRwGY+LmkVWngHtGDgS5eo8xQ5a9wJ8nqvMw/TZbV6v
         dA0P7YIag1/B+Opm7gxZizRqR/kGUVNRJgCAPGL23foaA1Xf4L0R8Wh/VT4QM6u/gzD8
         JuRph/kZ5YILdYgpc2wKwzUhzU310WQPgvgbbLiRvZDImOZOiShYSefPUyvyCCcRGXC0
         RiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436381; x=1786041181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GJ9d+Yy8ysHYMM9q9YAN46OY943/I3hmMwBY4dTdLzs=;
        b=QQLmqL5Bqev80n9Q1bX3eT/lL65ezMX/Zs0OEG/ZCi9ffTuI9asD3onyAE+71413tt
         cIOJY9s1We2T0BNjRJU98m3Y1GDYgWYXK/xKvb1boOTPFp7SmxQa/GYL6VIIGHRxpQpE
         URxFR7Z54+XKCbvtC2YJ7PZXOg3ugZ4qfOJRTc6EKfIBGrpX/Ku73E4Xwo43tcAn3Soz
         BDrd1LW2guIz6bvOrjQvO84KB4nWG2gFDR3+oAiffZ9ZudPyM/8o6JM6qeXMn+6kTzNX
         r4NWT/LQ+Y5s6/UfW18tcNNI5HhXe8kcAlbY/81S6K6RT8jUuGDpj2dmvpk8h1zsQ7EI
         3Q8g==
X-Gm-Message-State: AOJu0YzaYWJQ6m22KgFHdGEPxv9ciefUjBGsLnNyz7oO0aS6KdSf9C/Q
	lZxiVBEqAslo5znpsWNRdUNhoAmnrRLDhzP5i0elXFLIAC+UUwbsInYMmpoUbw==
X-Gm-Gg: AR+sD12d/c8qXFsEl5cO3M4xOwy5i0N11o/KGssRoFbz8lZfRf0vTa9KIHTgFUUQEBu
	baDtQKDu2LG/JBo3rrby+EMvfML6ylpUHc4TjteczbdgZdlOJ3ErrWo54H5cyKBy3QvGYnoRdbW
	BbL2+j/1aydp2wr8OcsafnRUt/QwFci3SxSOYd9vCDHhEXFbTRHHGZUtfg713lLT1SzcK+9ttJ4
	3HnjOyGjuElgIinWegUiB5gAXxe+DpM1+XJBef8LRqfy1i8qOdbpUx8wm/MigrvwgHSv9PW7+E8
	mr6NOq4krkzmQP0JId/ikpY1Nc7m99+o6+qa2dHzVPpz6SgnGp21Pcw5Z3dkS0i6sStWcCXJV6Y
	g+tzIx4dmA5ge+Wl88yoo9kDzNzZnFI2lzUPiKawoq44gFDoGRHYDAuiBvBcutzECFWBySdn+3E
	CiSL6JG9NZOhY+eb67MvqCXV8DhSw7+z8b90bjRA6dBaXsQtm86f5hfkJang==
X-Received: by 2002:a05:6808:309b:b0:495:f79d:b08e with SMTP id 5614622812f47-4ad878c4c59mr3125464b6e.21.1785436380881;
        Thu, 30 Jul 2026 11:33:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::10c9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc5c3fsm4593047b6e.13.2026.07.30.11.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:33:00 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 06/10] hashserv: server: Add queued streaming API
Date: Thu, 30 Jul 2026 12:30:59 -0600
Message-ID: <20260730183254.793698-7-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19886

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
2.54.0


