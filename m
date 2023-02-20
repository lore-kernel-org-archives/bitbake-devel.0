Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00F5C6379F
	for <webhook@archiver.kernel.org>; Mon, 20 Feb 2023 22:25:52 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.27833.1676931946832947150
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Feb 2023 14:25:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=uFbPYdm6;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.182, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f182.google.com with SMTP id g12so1332658pfi.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 14:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=748QVKVjh4beT3M0e9KWd8EDGteCuKv1wpKxSdgS41A=;
        b=uFbPYdm6ZvDWfFCGnpnda7XjxTv0JNDSHKVz5ykthtd7UdNdrS/RJ3B04lq012sEa9
         OXfjPy8MBEwRFMIdRwJ+5y8ZDGcIWFrVQLY7z5sCFSbqjcHW67D0N8QMKSKRFkxxXasX
         DrCn0TYB0Zb697rUT/FBM9zVx43/tD5jd4pwmXCcoUj+sDyal42iBNEYSd8Uw6vhJ7BZ
         4Ymw9kq6peO8Llwo6+JE07j52gDHG4p6CLLKK42xql0R5Jweg+sEQVnd4/qeNJLFp4Qm
         sz/Ct1fx4zdh0f0mEHDle5tAXO6nL5ypqoDQXbmB9fXfTlP/yEEBj2ooiDIzbPVA/pcX
         UGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=748QVKVjh4beT3M0e9KWd8EDGteCuKv1wpKxSdgS41A=;
        b=XNi6w/KOHArIh9v7uvQSNg/PqwIu7pzjqXmQHgj6cuHSioh/f3TdDQPyoVHEsv1Djr
         2n+4FEyyp5RsJRbFMFllluMDve3GpsjRyNLX6YivT71VVGw8+Zx2zninOOnPBhha8kfU
         tiyH32uFNX/z4+GBKxKgeg8lIGmVkNq4r+Un2Ex6fmTrVdyFaJPf//49kSQBUeNgh4Ku
         puDgjRhwWZZmx8U0Q8MgSM2cx3kKzv4iWkY+kKF+dCp2MvBp5ytO/ajySMB0Q1yL2ugJ
         tF3IcBfxSMWfM/on5g/ZzhDIQ4hSRpQOiM3rtbN1ZUuwDVRLSvGZDYnkgt+0Yuf36CZ+
         UEog==
X-Gm-Message-State: AO0yUKUn2QDdpGmfMvKj+mZyK4jt/0uXFhZHJbdrgVaq8Rg0n+IBvkAi
	uBBhQEx7/5Q8iOZcgTm09tsskkJgeMvL/mknOMY=
X-Google-Smtp-Source: AK7set8hSSywINr9oElQvSaAghQpLaVivNEDsyf8gOs5cc8geJsqJQzNG82CoH4V2AzKOnQ/2TkSLw==
X-Received: by 2002:aa7:9543:0:b0:5a9:c797:a1d6 with SMTP id w3-20020aa79543000000b005a9c797a1d6mr2853310pfq.2.1676931945890;
        Mon, 20 Feb 2023 14:25:45 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b005a9131b6668sm8191447pff.2.2023.02.20.14.25.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:25:45 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 6/7] runqueue: Ensure deferred tasks are sorted by multiconfig
Date: Mon, 20 Feb 2023 12:25:22 -1000
Message-Id: <657940c7c2a9dea4963a5063e4bf900d6b454903.1676931822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676931822.git.steve@sakoman.com>
References: <cover.1676931822.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 22:25:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14473

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We have to prefer one multiconfig over another when deferring tasks, else
we'll have cross-linked build trees and nothing will be able to build.

In the original population code, we sort like this but we don't after
rehashing. Ensure we have the same sorting after rehashing toa void
deadlocks.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 27228c7f026acb8ae9e1211d0486ffb7338123a2)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f63a2191..2a1299db 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2503,11 +2503,14 @@ class RunQueueExecute:
 
         if update_tasks:
             self.sqdone = False
-            for tid in [t[0] for t in update_tasks]:
-                h = pending_hash_index(tid, self.rqdata)
-                if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
-                    self.sq_deferred[tid] = self.sqdata.hashes[h]
-                    bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
+            for mc in sorted(self.sqdata.multiconfigs):
+                for tid in sorted([t[0] for t in update_tasks]):
+                    if mc_from_tid(tid) != mc:
+                        continue
+                    h = pending_hash_index(tid, self.rqdata)
+                    if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
+                        self.sq_deferred[tid] = self.sqdata.hashes[h]
+                        bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
             update_scenequeue_data([t[0] for t in update_tasks], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
 
         for (tid, harddepfail, origvalid) in update_tasks:
-- 
2.34.1


