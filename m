Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B482C4332F
	for <webhook@archiver.kernel.org>; Mon, 21 Nov 2022 13:58:57 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.38913.1669039130786754484
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 21 Nov 2022 05:58:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MwGMD3It;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5so8525920wmo.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 21 Nov 2022 05:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3OqJpMh7iRp92vRFK91yx8pOBdPwYcN5SyKgsNe7XE=;
        b=MwGMD3Itu9CRiy0Ch3wHc6k6bfRKaHQcfaijOercGZb9fncPzzKjzIDjbGc7bbXDou
         ZUpiyrMDmRLijeMACFWkZ6t03CluGudWlpIhj6NdMjVl0R57z0+RYBUrzcAZvkFq3Qno
         cZYN1ZYP7AUsZZlXJd+5ns5jgKaT3ipyk75yY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3OqJpMh7iRp92vRFK91yx8pOBdPwYcN5SyKgsNe7XE=;
        b=jcoGdJSldOLcAyqLw0pZkbZfn9J4X3keDiZ4eh1jclvz12hXY2vn+Zp6TyXTJGN/Lp
         XKACZhTJt6KlINZI4gvsTQ1MzLOQGbk70uKg0vaH4RBiTA5qwSCAdKlE6yaMZrBml8uh
         1g16LKfVtGnx/aMO6GGONvwApKq1qmFFGN/f0kBxQ9ybWnIAqMyqznvGVf+rTO3+ayyg
         EJ61EwQoHtr97deZIc1st/x3zoTp12KZ+PK/A2s+9l5B/4P96T5G/DP5Jtvi/zvnr8Rq
         I0PJ0fAlXLtOCwqUKEqITxNJRNI8uSClD7KQXtcAMVDPZqRmYDpD7QcFtAGaZMzU4pR2
         hU6Q==
X-Gm-Message-State: ANoB5pm2fqBwYpGCW3yNeEtQDTzuKGgBvXZCr4ydGq2tzhmm9L53Y+DE
	ahc3pmW9CO43tjlK3qgUO8P/W9Nhl96IWA==
X-Google-Smtp-Source: AA0mqf4HLIC6+mI/sV5euu4EJYMOz/aXkR9M2q6C321VOxr4xZoCuSQ3f56X1/o+BxeaBuu0d3zCxw==
X-Received: by 2002:a05:600c:3507:b0:3cf:8e62:f907 with SMTP id h7-20020a05600c350700b003cf8e62f907mr3714018wmq.7.1669039128743;
        Mon, 21 Nov 2022 05:58:48 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:fff0:8f62:27ca:adb5])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bc04a000000b003c6bd12ac27sm13480083wmc.37.2022.11.21.05.58.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:58:48 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] runqueue: Fix race issues around hash equivalence and sstate reuse
Date: Mon, 21 Nov 2022 13:58:45 +0000
Message-Id: <20221121135845.3428466-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221121135845.3428466-1-richard.purdie@linuxfoundation.org>
References: <20221121135845.3428466-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 21 Nov 2022 13:58:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14096

We identified a use case where a native recipe (autoconf) was rebuilt
 with no change in output yet the sstate for do_package tasks wasn't
being used.

The issue is that do_package tasks have a hard dependency on
pseudo-native:do_populate_sysroot. That task was one of the many
tasks being rehashed when autoconf's hash was changed.

If update_tasks processed a recipe before it had processed pseudo-native,
that recipe would be marked as not possible from sstate and would
run the full tasks.

The fix is to split the processing into two passes, first to handle
the existing covered/notcovered updates, then in the second pass,
check whether there are "harddep" issues.

This defers the do_package tasks until after pseudo-native is installed
from sstate as expected and everything works well again.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index bcaaf70abd..2c1714da9d 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2508,17 +2508,6 @@ class RunQueueExecute:
                 self.sq_buildable.remove(tid)
             if tid in self.sq_running:
                 self.sq_running.remove(tid)
-            harddepfail = False
-            for t in self.sqdata.sq_harddeps:
-                if tid in self.sqdata.sq_harddeps[t] and t in self.scenequeue_notcovered:
-                    harddepfail = True
-                    break
-            if not harddepfail and self.sqdata.sq_revdeps[tid].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
-                if tid not in self.sq_buildable:
-                    self.sq_buildable.add(tid)
-            if not self.sqdata.sq_revdeps[tid]:
-                self.sq_buildable.add(tid)
-
             if tid in self.sqdata.outrightfail:
                 self.sqdata.outrightfail.remove(tid)
             if tid in self.scenequeue_notcovered:
@@ -2537,21 +2526,36 @@ class RunQueueExecute:
             if tid in self.build_stamps:
                 del self.build_stamps[tid]
 
-            update_tasks.append((tid, harddepfail, tid in self.sqdata.valid))
+            update_tasks.append(tid)
+
+        update_tasks2 = []
+        for tid in update_tasks:
+            harddepfail = False
+            for t in self.sqdata.sq_harddeps:
+                if tid in self.sqdata.sq_harddeps[t] and t in self.scenequeue_notcovered:
+                    harddepfail = True
+                    break
+            if not harddepfail and self.sqdata.sq_revdeps[tid].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
+                if tid not in self.sq_buildable:
+                    self.sq_buildable.add(tid)
+            if not self.sqdata.sq_revdeps[tid]:
+                self.sq_buildable.add(tid)
+
+            update_tasks2.append((tid, harddepfail, tid in self.sqdata.valid))
 
-        if update_tasks:
+        if update_tasks2:
             self.sqdone = False
             for mc in sorted(self.sqdata.multiconfigs):
-                for tid in sorted([t[0] for t in update_tasks]):
+                for tid in sorted([t[0] for t in update_tasks2]):
                     if mc_from_tid(tid) != mc:
                         continue
                     h = pending_hash_index(tid, self.rqdata)
                     if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
                         self.sq_deferred[tid] = self.sqdata.hashes[h]
                         bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
-            update_scenequeue_data([t[0] for t in update_tasks], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
+            update_scenequeue_data([t[0] for t in update_tasks2], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
 
-        for (tid, harddepfail, origvalid) in update_tasks:
+        for (tid, harddepfail, origvalid) in update_tasks2:
             if tid in self.sqdata.valid and not origvalid:
                 hashequiv_logger.verbose("Setscene task %s became valid" % tid)
             if harddepfail:
-- 
2.34.1


