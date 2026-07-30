Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E50CC55171
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 18:33:06 +0000 (UTC)
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18460.1785436383590465317
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 11:33:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Zfsf+Zgb;
 spf=pass (domain: gmail.com, ip: 209.85.160.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-45133d2974fso145932fac.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785436383; x=1786041183; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qqrE/iXHsvexr2oIZF73UCyKJJ2N2jIRTQf2CjxnnlA=;
        b=Zfsf+ZgbiQ+ejP+HGYUdWhJIQBWaK6gMWbIJVE57LrdJea78VM7RMb4RwQnCNZtiW7
         XY109JUJpLWeeJoO41FqAGyRTWOK/lV7jZgThozoh5q14OYAoIzApc6W2Z06dbUPDyW1
         LdJX02OD7Ezo4WJZ7c8/rZP8XeuAWbtBEqO8X/xlHL3vJCfSYXeFTceT3eVYNH1t7p1U
         QA1O/LPRZwYM/olnqnplCb5EM/4oDbhmBxDUgfEsJHsMn3v0Nt5a30qpY9oQuVFbK7fz
         GWa5Zua0jF2EhLK0584XM0rTn2shuU88sToWXti3WnH/AFSXPHQSgzW7QQSDdGLhTbOf
         oFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436383; x=1786041183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qqrE/iXHsvexr2oIZF73UCyKJJ2N2jIRTQf2CjxnnlA=;
        b=rYLHWAQcp4WXqalWGcHJ++pt5AOSa0g1GtVoZdOMTuPrchAdufOPOmziJYwHihv2fk
         roSsAFbQ6KTopFI0/4zY8fTAucOK1+OVIG3okYT5ic//9OIApEyUWGgR3WN9K52SuW+/
         wro/TkD+YDYWPzCCZVJj6s979YSZ7nvgZ827KAdWDOB7n+fojCKHnuFQJXeP4ujI6i7T
         oo13kauVrmfKXhZvK/eHW5/ZYXGgZ0lutLlnps4l2nYEoI/GB4o6Ojj9KrSmwAfh44r0
         SncP7qveCHhhqjfn32v/8W8FfRHgyDuPyXe556u7+c85j55AYuckH+itRtrlakgVlwFJ
         rWvQ==
X-Gm-Message-State: AOJu0YwwVbEsgZfOk5KeOSJusgkat08Af8a3+zpvjDQf40Q+nNvSKuc7
	hI7U+eo2ctSVv/yjbTCZxPB59fMFByJHKdokIxMmPZvILDDdLtcIA7MHzL2bKQ==
X-Gm-Gg: AR+sD13/rXFCnR92cjoMQz7oVGKqcAJg3RgrYY+tuCZytBOVkVwPls5GSCTYwabXKo7
	801BQ00tsz7DSGsE3Lgit4wfhCpwRoK/8vJcouhiY4LqXUY/jdNLARJCdbwePyqnpWvpMlpB11p
	fAGRPyb8a1l5rIKGNlPicTjU1B4RUyrIOsgSjE3LC1JToWfykT99MxoyOeIaAEkyDzHP2tOAhY+
	kaDBPDXHO/IsgSOk5Cx7lKigmbsPoM4rkTFs0luOgalIcrbTXrlrNjVSqxeObRL0t8uC9hBRIJV
	/B36z5b7dcDtxV06Jj8tkLamCZlPAeAdgoRd6mMm8xiR4F8b0oJAs49dko217/9X4ElvKeM5xtK
	crMtSruZLy9kDzuGrQBNIlZZeExXciedpd4OkRaDpSYriFF+efmrGMRx0qN630NpQgRXLFOy6L6
	n0nTGtqG0H9AFRLFrBc0y2NL0BzlxgAfEIA4A/CP/tbVTafBa8FvwOoUSo8Q==
X-Received: by 2002:a05:6808:1246:b0:497:8f1:df07 with SMTP id 5614622812f47-4ad87782704mr2593976b6e.7.1785436382710;
        Thu, 30 Jul 2026 11:33:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:283:4b02:22d0::10c9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ad6efc5c3fsm4593047b6e.13.2026.07.30.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:33:02 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 08/10] hashserv: server: Use streaming and queue API for upstream exist queries
Date: Thu, 30 Jul 2026 12:31:01 -0600
Message-ID: <20260730183254.793698-9-JPEWhacker@gmail.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19888

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
2.54.0


