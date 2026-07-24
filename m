Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCA0C5321A
	for <webhook@archiver.kernel.org>; Fri, 24 Jul 2026 21:28:31 +0000 (UTC)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28920.1784928510597662444
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Jul 2026 14:28:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=q3MtA4ib;
 spf=pass (domain: gmail.com, ip: 209.85.160.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4513435cdd2so399346fac.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784928510; x=1785533310; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPuFqV+fsZTcQsNuHhGmmdXtXVUrpvyQg/hP39CHzIA=;
        b=q3MtA4ibSne1DNBv12rNwcIMKAnbhwaQLG0iGcS/Zw/7DdSrCuQExKs+I2wEObXQLa
         dqYEqzyT/D9EMH7c1wzkeI3P1GXTNoSyYaGACr0vj6UrDQD610Vx5O6ZXG7n93bn/ewx
         YJG1wirUJxm7aNOJcYaFDrbNi+hg4LJeR15w80+Npbv4jHarra8VmnBqheq0J/dVuN/w
         ETRoyCHNrAi/eHxfXjKtQkxYuNiHyU4fwlQpr1OtS87valr46m+hPuGhwF5eI2q634/+
         X7LrA6kSe1gkvSzvGiIYS8FSOShhvm5/aLLfyMI1ksTXCMd0Rna9sOy/Jz0SX6sBQ8kr
         1mdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784928510; x=1785533310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IPuFqV+fsZTcQsNuHhGmmdXtXVUrpvyQg/hP39CHzIA=;
        b=jF68Ah/RhrEExOFOJTvzU6JQY3kjqF4+Ux331HgFhjz/seEdtxIznupoQN96pWC0go
         zBFp5FaEsf1tdrdwwFwkQBQolDQTqwWb3KkHz3+ZZhONzdPi/WMZZYNe6Eh+o8J3eUPF
         XdI1XIG2Mu5Hhl282tqW7udRC5u44FRdu8Pza98BDEFES9xHKvj7vI/CC+XPEljXeAsb
         h3vmNQUaNSDXSQ5wQH7zTqX9upwxBPf8IM5WAUoLwPro/OR8xE7/eVT4DN1Cm33/r4da
         bUyk2HBewMX+VTMkzwdRpDgWxCyMCvo2ir3E0cDpDph3yvwL9/77FNfcwVsCzCHfM6Uv
         eunw==
X-Gm-Message-State: AOJu0YzzfoGx7y+LYLoInf3dy/Our/kPh+ZYhQx0zpyKG+IM5llGMBB4
	6AoWMiuGiYy+91FPdgWDsGf4DuENAp4mTIWbuasXa9+TkkEZDf4K2KstlC8Z/Q==
X-Gm-Gg: AR+sD11JHnUzt8HEq0TlbAO+JTKDNyJXjYqyqCui5d56QVo59Yk7pK92EqkqjA49e+0
	TrugHok7rFQybMrmKeBnbB3NhxqR2god3VNeM3OhNVnbBJwlr9DF4uH2qaqeXlfC41CFKOwdNl2
	nc8tPQgFARmI1mfRgkDkenzZJhaVx3oKPTwxNDPvr60pEhv1YX1gXh3LFTZrpSm+CunbZxLm5Ys
	4X/34Zj/pq9z1U48DCE5HoY9xzlNdbW0fP6A2Cz6cZxXKil0xdhTkIrbKZ9MRtD3Inx8J3vj5cB
	NRC1YzZW0XvHglakp/YDY+M3fZW2zZlEtp9SwtcK+fd1dsHJ2Rlt+JSYKN2Bnmfajdu66+VXmI4
	VNum/sfGzCsafDjxjpX6qKzj1moPHjOdPr6B06MASbi+aAclMJsgKOYhfQa9EzAE3vMeknH/H7v
	fxqBvftFIQYA==
X-Received: by 2002:a05:6870:488:b0:448:a0cf:5afd with SMTP id 586e51a60fabf-457f23900bfmr182899fac.4.1784928509681;
        Fri, 24 Jul 2026 14:28:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::5d97])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457673d2dc1sm8183883fac.10.2026.07.24.14.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:28:29 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Michal Sieron <michal.sieron@nokia.com>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 5/6] hashserv: server: Use streaming and queue API for upstream exist queries
Date: Fri, 24 Jul 2026 15:25:13 -0600
Message-ID: <20260724212822.1165552-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724212822.1165552-1-JPEWhacker@gmail.com>
References: <20260724212822.1165552-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jul 2026 21:28:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19855

Reworks the "unihash-exists" handler to use the new server queue API and
client streaming API to efficiently stream requests to the upstream
server instead of having to wait for a roundtrip on the requests.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 31 ++++++++++++++++++++++++++-----
 lib/hashserv/tests.py  |  5 +++++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index d392ac19f..5017320c1 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -526,17 +526,38 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
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
+            await asyncio.gather(
+                self._stream_queue_handler(upstream.handler, queue),
+                upstream.process_results(),
+            )
+        return self.NO_RESPONSE
 
     async def report_readonly(self, data):
         method = data["method"]
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 3acfdcd8c..0fbc19c1d 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -372,20 +372,25 @@ class HashEquivalenceCommonTests(object):
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
2.54.0


