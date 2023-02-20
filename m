Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18FDC61DA3
	for <webhook@archiver.kernel.org>; Mon, 20 Feb 2023 22:25:42 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.28210.1676931941392833706
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Feb 2023 14:25:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=qfDOkUep;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.178, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f178.google.com with SMTP id a7so1495889pfx.10
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 14:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNokp74Z/PaUvtcKBm8xvcXLVcgZ5ABJeQ8g4YVb9xg=;
        b=qfDOkUepDG6KOGnuvucl+Pzy9B+PdGCBmPVrgtg6ri0CZhC2Wi0M9midf67p+WXHPD
         HTCivrM5Cb6XcHaXA/XXiObL/HjNJB/AS4xJsBmYzo3r02gAQQ9kS2MlUyF2pK5s0VEl
         qvWMhZOkbcvwof9zg8X5T3vTp3hzSWvRExoECHkY7zVGfS8xBSiabtAOTD7T+EXb3t+2
         MtkJ1YorCj5+CBiY/QwMShOW1TIXkTtXUaa8o1trITWtUfAb5TPvNBJ/v9Uqdg4INGCi
         PPX4ZWATkXRPIC7LDx3qE9fJQei2wHripXRER1ixAN2k6wNhHr6sS6d1/dzfkdKdzMcV
         xKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNokp74Z/PaUvtcKBm8xvcXLVcgZ5ABJeQ8g4YVb9xg=;
        b=gTlrX9RQPjDcrjfsPbKKzElcv0WxWxFmlOQ48LFXbPlUIbRPaOrkApDghHuTaLoizv
         0OxHLnVa1nFIInkZUPWkbDHemoQ0QwRQd6CJyXgwiX4/f5txvx0Aivnmso3CV1hlUDok
         sc4No22x65kwhh1B4z4R4e8P9c8yTeuJvTsJ+Msx02fMEgg1RSb1m8USqyyr6Fj4Oiyp
         XpGB7T5IIlWFEzF4V8zIugvyve27zDoT4cbijuXTTyhF7kiJIk31nljqr+T/sT4nyBZ7
         8p51OZslZcu54uX8DbxuJdwsz7tR4p3epBEhZ3zO66aG6smfbEWtObAO/AWy07C0gyUj
         MiVg==
X-Gm-Message-State: AO0yUKWZGk8xt5bkwH1gtCv/AgOusQrF9Hit4QQ8h09XpJZTciXWSmLl
	BdxaM9WUwFmS/8i+47HzQwKUfv7K0NQmYB9Y39E=
X-Google-Smtp-Source: AK7set8yVtvFvVtMURBbvfQJXHulsc4Xs79WTCJIQxsAmBgUhcFB5aS3E3bB4gMkKQoIuRYJBPgQYA==
X-Received: by 2002:a62:1dd0:0:b0:5aa:6125:dbf4 with SMTP id d199-20020a621dd0000000b005aa6125dbf4mr1634678pfd.11.1676931940298;
        Mon, 20 Feb 2023 14:25:40 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b005a9131b6668sm8191447pff.2.2023.02.20.14.25.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:25:39 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 3/7] runqueue: Improve multiconfig deferred task issues
Date: Mon, 20 Feb 2023 12:25:19 -1000
Message-Id: <4316e9f60ce5fd250a16586a1772dcc0adfeb932.1676931822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676931822.git.steve@sakoman.com>
References: <cover.1676931822.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 22:25:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14470

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The previous patches have exposed new issues with this code path,
the issues being around what should happen when the hash of a task
changes and the task is or is not on the deferred task list.

Rather than rebuilding the deferred task list during each rehash
event, build it once at the start of a build. This avoids the problem
of tasks being added back after they have run and also avoids problems
of always ensuring the same task is deferred. It also allows the
'outrightfail' codepath to be handled separately as the conditions
are subtly differnt.

One significant win for the new approch is the build is not continually
printing out lists of deferred tasks, that list remains fairly static
from the start of the build. Logic is added in to ensure a rehashed
task with a hash matching other deferred tasks is deferred along with
them as a small optimization.

An interesting test case for this code was reported by Mark Hatle
with four multiconfigs, each the same apart from TMPDIR and running a
build of:

bitbake buildtools-tarball mc:{one,two,three,four}:core-image-minimal

which is interesting in that the build of buildtools partially overlaps
core-image-minimal and the build has a rehash event for qemuwrapper-cross
even without any external hash equivalence server or preexisting data.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit bb424e0a6d274d398f434f7df63951da9ce305b3)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 58 +++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a437aeef..9efd1c86 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2496,6 +2496,11 @@ class RunQueueExecute:
 
         if update_tasks:
             self.sqdone = False
+            for tid in [t[0] for t in update_tasks]:
+                h = pending_hash_index(tid, self.rqdata)
+                if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
+                    self.sq_deferred[tid] = self.sqdata.hashes[h]
+                    bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
             update_scenequeue_data([t[0] for t in update_tasks], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
 
         for (tid, harddepfail, origvalid) in update_tasks:
@@ -2836,6 +2841,19 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     sqdata.stamppresent = set()
     sqdata.valid = set()
 
+    sqdata.hashes = {}
+    sqrq.sq_deferred = {}
+    for mc in sorted(sqdata.multiconfigs):
+        for tid in sorted(sqdata.sq_revdeps):
+            if mc_from_tid(tid) != mc:
+                continue
+            h = pending_hash_index(tid, rqdata)
+            if h not in sqdata.hashes:
+                sqdata.hashes[h] = tid
+            else:
+                sqrq.sq_deferred[tid] = sqdata.hashes[h]
+                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]))
+
     update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker, stampcache, sqrq, summary=True)
 
 def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, summary=True):
@@ -2876,32 +2894,20 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
 
     sqdata.valid |= rq.validate_hashes(tocheck, cooker.data, len(sqdata.stamppresent), False, summary=summary)
 
-    sqdata.hashes = {}
-    sqrq.sq_deferred = {}
-    for mc in sorted(sqdata.multiconfigs):
-        for tid in sorted(sqdata.sq_revdeps):
-            if mc_from_tid(tid) != mc:
-                continue
-            if tid in sqdata.stamppresent:
-                continue
-            if tid in sqdata.valid:
-                continue
-            if tid in sqdata.noexec:
-                continue
-            if tid in sqrq.scenequeue_notcovered:
-                continue
-            if tid in sqrq.scenequeue_covered:
-                continue
-
-            h = pending_hash_index(tid, rqdata)
-            if h not in sqdata.hashes:
-                if tid in tids:
-                    sqdata.outrightfail.add(tid)
-                sqdata.hashes[h] = tid
-            else:
-                sqrq.sq_deferred[tid] = sqdata.hashes[h]
-                bb.note("Deferring %s after %s" % (tid, sqdata.hashes[h]))
-
+    for tid in tids:
+        if tid in sqdata.stamppresent:
+            continue
+        if tid in sqdata.valid:
+            continue
+        if tid in sqdata.noexec:
+            continue
+        if tid in sqrq.scenequeue_covered:
+            continue
+        if tid in sqrq.scenequeue_notcovered:
+            continue
+        if tid in sqrq.sq_deferred:
+            continue
+        sqdata.outrightfail.add(tid)
 
 class TaskFailure(Exception):
     """
-- 
2.34.1


