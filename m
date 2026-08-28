Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2D3C61DDC
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 15:59:55 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4204.1787932793070333061
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 08:59:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=L+uWBUS8;
 spf=pass (domain: gmail.com, ip: 209.85.210.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7f4f53975e6so1100018a34.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 08:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787932792; x=1788537592; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WH/3ShpehcTLl333LvMRdyNhjlZdFl/NOwoXJHGc7fo=;
        b=L+uWBUS8EiwtxKCdygMi3gTZtHB+CEa0nPEf8f74Gbz37ERiQgBGNz1mgNnql4fqCp
         TPlLh5XvqzghjNgjrBv3SdLpiTHvbUA5yasVFRAA52efGjto6LJl8LYZm13yndmcxnpc
         f3p+MRdAI2qmgCahW4/VgUi5gz/0UxU4/rOq9Jym32/4CHLAJHDCcEk9+k+7TuR2D3E5
         n+5wAIPk/4DgHMMqCzzuO7IrCjo+QFGrP2SkQ9PZdS2A/9V3J9dkPoRMlA8Gm9y56KT6
         VTSlhhzUWdMxjV7xUa+k+MYN7+2nd1NxDbQg9ZE8JKS7uuU4Tr/9sU2rE1aeNhrd5L5T
         HlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932792; x=1788537592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WH/3ShpehcTLl333LvMRdyNhjlZdFl/NOwoXJHGc7fo=;
        b=inmpk79pwXAgQaVxOhopdhZr1caXkcvC46rm+2MZj5ijNy1mQ0VYcOjYKBBDQeYDTk
         zQI7zGJazZlE5qdO/UJbL0ibOY4y0721yZP8Bwrckbcg7iW2taiWe7hrAvBENtQd/6g4
         WuT50vLIfscBPGWAXRM7otHp6yYaG6ToaNrc4J2OZ4Q+1M6J/2Mb2t0WC7hIQxslR2QM
         rhriz4YO0FHvSIExxXZJIoJUrd+WOzFNBSzZbqw48gMRf+6VVQCJkjo+LmAgiWarfwzJ
         7XUWjdDX38w1LM1V64o97kJJBnyoFwvYFBfR5Ac9ozrZ8M08eln9/wakWM2Ewv21Lt9w
         NPrA==
X-Gm-Message-State: AFuF++n4WZRP/ALvp00qRuQ+ZvMcpDFLUYpI1UUJfnls+QhmjSrEIbLB
	HTtJRAoUcGivGC2IjObYuNA9EnWsH2fihxVAHBjZXn7bgwHmymPToRKBvgeZzA==
X-Gm-Gg: AR+sD11pzr8PpJfA17aO0jIlHIHxXrmw5ofLZudGpVBTMp/CAiEq15i7RiE6U/rRAUV
	uxe77EjMp/rBoAJzsgcypXRCahciyMG84HSIFjfar9wEvfU6Pav+VSNN6o8xswKmKYlJgEodSxQ
	mroyGnOeuzaDUedvi0BN3O+iYm0mzBYJgurgLjWcRL78VBTsDoVbw7yM4EH8ctdZm8r1czEZxfR
	ilik1yb/8h4F/LcGCYG1ZY0H/WPSBPDxJM+ibnv22L1a+UMGd79vApZI5fDkr7LlQiV78CBgUVZ
	WR+o5AUXn5XTXhyPb6HPijnIbz6CTTcVlyfE/EdKGUnK+pnbQIKkgbTWpk3juitTuvvMk4x78Dt
	C3SYCDrVL+lfcu1UzacH17dttdv/o8yKOMm6aOhq9ORwsarD0GqtIOriBHXqVN50bwnF3+gWKQ1
	Y986KK5mbYkpRmTz3uxNduyFQMVsGtv6IJSODSIBLqPKfBrl80MifqQO4akw==
X-Received: by 2002:a05:6830:700e:b0:7eb:d848:c856 with SMTP id 46e09a7af769-7f4f227a851mr10195792a34.4.1787932792024;
        Fri, 28 Aug 2026 08:59:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b01:ba50::50d4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4fa96ce0dsm1506165a34.13.2026.08.28.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 08:59:51 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 08/11] hashserv: server: Use streaming and queue API for upstream exist queries
Date: Fri, 28 Aug 2026 09:58:15 -0600
Message-ID: <20260828155942.1219468-9-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20114

Reworks the "unihash-exists" handler to use the new server queue API and
client streaming API to efficiently stream requests to the upstream
server instead of having to wait for a roundtrip on the requests.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 31 ++++++++++++++++++++++++++-----
 lib/hashserv/tests.py  |  5 +++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index d0e6f23fc..0153730fa 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -522,17 +522,38 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
     @permissions(READ_PERM)
     async def handle_exists_stream(self, request):
-        async def handler(l):
+        async def exists_handler(l):
             if await self.db.unihash_exists(l):
                 return "true"
+            return "false"
+
+        if not self.upstream_client:
+            return await self._stream_handler(exists_handler)
 
-            if self.upstream_client is not None:
-                if await self.upstream_client.unihash_exists(l):
+        async with self.upstream_client.unihash_exists_stream() as stream:
+
+            async def get_local_result(m):
+                if await self.db.unihash_exists(m):
                     return "true"
+                return None
 
-            return "false"
+            async def get_upstream_result(m):
+                exists = await stream.get_result()
+                return "true" if exists else "false"
 
-        return await self._stream_handler(handler)
+            queue = asyncio.Queue()
+            upstream = UpstreamQueue(
+                queue,
+                get_local_result,
+                stream.send_query,
+                get_upstream_result,
+            )
+
+            await bb.asyncrpc.TaskGroup.run(
+                self._stream_queue_handler(upstream.handler, queue),
+                upstream.process_results(),
+            )
+        return self.NO_RESPONSE
 
     async def report_readonly(self, data):
         method = data["method"]
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index e24bdcacb..a7ce7425e 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -374,20 +374,25 @@ class HashEquivalenceCommonTests(object):
             nonlocal side_client
 
             # check upstream server
+            self.assertTrue(self.client.unihash_exists(unihash))
             self.assertClientGetHash(self.client, taskhash, unihash)
 
             # Hash should *not* be present on the side server
+            if old_sidehash and unihash != old_sidehash:
+                self.assertFalse(side_client.unihash_exists(unihash))
             self.assertClientGetHash(side_client, taskhash, old_sidehash)
 
             # Hash should be present on the downstream server, since it
             # will defer to the upstream server. This will trigger
             # the backfill in the downstream server
+            self.assertTrue(down_client.unihash_exists(unihash))
             self.assertClientGetHash(down_client, taskhash, unihash)
 
             # After waiting for the downstream client to finish backfilling the
             # task from the upstream server, it should appear in the side server
             # since the database is populated
             down_client.backfill_wait()
+            self.assertTrue(side_client.unihash_exists(unihash))
             self.assertClientGetHash(side_client, taskhash, unihash)
 
         # Basic report
-- 
2.55.0


