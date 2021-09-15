Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mx.groups.io with SMTP id smtpd.web11.3973.1631747984007383249
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Sep 2021 16:19:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.151, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202605374"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="202605374"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:49 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="434303215"
Received: from chgan-mobl.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:48 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 4/5] runqueue: Improve multiconfig deferred task issues
Date: Thu, 16 Sep 2021 07:19:37 +0800
Message-Id: <f6ff6689dfddaf8c566b4e7d8f5926e43d277a6c.1631747835.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631747835.git.anuj.mittal@intel.com>
References: <cover.1631747835.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/runqueue.py | 58 +++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f67981309..5ccf755f1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2450,6 +2450,11 @@ class RunQueueExecute:
 
         if update_tasks:
             self.sqdone = False
+            for tid in [t[0] for t in update_tasks]:
+                h = pending_hash_index(tid, self.rqdata)
+                if h in self.sqdata.hashes and tid != self.sqdata.hashes[h]:
+                    self.sq_deferred[tid] = self.sqdata.hashes[h]
+                    bb.note("Deferring %s after %s" % (tid, self.sqdata.hashes[h]))
             update_scenequeue_data([t[0] for t in update_tasks], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
 
         for (tid, harddepfail, origvalid) in update_tasks:
@@ -2793,6 +2798,19 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
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
@@ -2857,32 +2875,20 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
 
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
2.31.1

