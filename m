Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.4397.1620465299971349171
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 08 May 2021 02:15:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cTYgMnRd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id s82so6465090wmf.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 08 May 2021 02:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4OjlbD1zCZLZ6FAhgEFvyrQUMys13PLJebxME5w6lQ=;
        b=cTYgMnRdLyU9dNAMfdIEQ6yBQ8QaN94Dg3bANTBZiTbfiypFFhakfi2b+tPu8JV6VY
         EgrfRKbHauxRMQVwKg9N0pq2Lcm4F70YvvczvvcDYCzhpYrFvw9fdE2sQX3plChuGl8a
         AwJ1jv85S2UxY/H9c21M8JIjaBMDhd855rAw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4OjlbD1zCZLZ6FAhgEFvyrQUMys13PLJebxME5w6lQ=;
        b=VPyDxGZ8+xUUUoL80ODcUF9vVP+ZUaMp2QV5UmeDta70jsZa4KQyQRj8rqm7ut7h2h
         xtDXt6kYTIurCRaMPcCn6/mnEh4hmQK9p5mtHLi+ozgo/pJms9XOMpdjS0ewDNJaka9r
         3pNT/0CIsmaHRaUGPOqtpuBZ0PnOxv1Ga2ck3VuKxKX64TFSildeHdanLHjWDSFL5lF7
         lZ29PIyGi3gKSUQPiQFalqky9mUjA6SQ8usdm0lzvoN86goU/hODbnfyE0ZBl8LrNxvG
         9KGtfPcZ2csqdcp0Y253zKMq9jOuBiYFXRpPJwIpq16jpczb60H/MeAqlK9vhwnbe5QI
         At2g==
X-Gm-Message-State: AOAM533dsdkKxrRiJkHlB4XXVAO0QzeFEuuC42lQP4pXDsA6We4DqaNj
	YdIRoH6I3eY+qdXR+megFICOWOw4czQIPQ==
X-Google-Smtp-Source: ABdhPJyd/z9q2wJ93r0W7A7Bvry9RK/I04Y+7dJT6UKIiERH5p74x/s88r3+n2cO5Sfyrc2RAiQkqA==
X-Received: by 2002:a7b:c196:: with SMTP id y22mr14959479wmi.1.1620465298316;
        Sat, 08 May 2021 02:14:58 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:8b6c:ea91:f112:97a5])
        by smtp.gmail.com with ESMTPSA id z9sm10243950wmi.17.2021.05.08.02.14.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 02:14:57 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Improve multiconfig deferred task issues
Date: Sat,  8 May 2021 10:14:57 +0100
Message-Id: <20210508091457.2084843-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 lib/bb/runqueue.py | 56 +++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6c41fe6d43..88983eba1a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2443,6 +2443,11 @@ class RunQueueExecute:
 
         if update_tasks:
             self.sqdone = False
+            for tid in [t[0] for t in update_tasks]:
+                h = pending_hash_index(tid, self.rqdata)
+                if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
+                    self.sq_deferred[tid] = self.sqdata.hashes[h]
+                    bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
             update_scenequeue_data([t[0] for t in update_tasks], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
 
         for (tid, harddepfail, origvalid) in update_tasks:
@@ -2786,6 +2791,19 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
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
 
     # Compute a list of 'stale' sstate tasks where the current hash does not match the one
@@ -2850,32 +2868,18 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
 
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
+        if tid in sqrq.sq_deferred:
+            continue
+        sqdata.outrightfail.add(tid)
 
 class TaskFailure(Exception):
     """
-- 
2.30.2

