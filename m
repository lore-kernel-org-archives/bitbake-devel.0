Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web11.2990.1620264865302596597
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 May 2021 18:34:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.88, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: CvIX7wuyG9j1cUSswbh6P5fibV/uXABJFIiazqa25pSbDmC0SDPLHqzQueReBZLRZbjLO8bEkX
 /MLbU8XgUuxQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="219222917"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="219222917"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 18:34:21 -0700
IronPort-SDR: u8FR+2rEUEOgeXyVQM518oCKpldEyv5KU6DYPkJryvBbb1oAbw+sIe9fmr24EuZt2/YBRC5hSP
 4F9XfomPrBxw==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="459046414"
Received: from hanpinon-mobl.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.213.47.180])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 18:34:20 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 1/2] runqueue: Fix multiconfig deferred task sstate validity caching issue
Date: Thu,  6 May 2021 09:34:13 +0800
Message-Id: <0300719681de0c670025ea9e7e11e563fe6cf189.1620264737.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620264737.git.anuj.mittal@intel.com>
References: <cover.1620264737.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We were testing the validity of deferred tasks setscene status "up front" which
is very unlikely to succeed and leads to cache invalidation issues. With the
change to rebuild the deferred task list, this status becomes out of sync. The
result was tasks being executed when they should not have been leading to extra
work for the build unnecessarily.

Instead, don't process validity status for deferred tasks and assume their
data will become available. If it doesn't, this will now result in a build
error as the setscene task will fail and the main task will run instead.

In theory we could try and track the state changes in the deferred list and
re-test validity then but I'm not sure it is worth the effort when the other
code path and errors in setscene tasks will give a pretty good idea of what
is happening anyway.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit edcafac13b3b241b6687419e59018d21811507a1)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/runqueue.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index feb42d3e6..78e576eb2 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2030,8 +2030,6 @@ class RunQueueExecute:
                             logger.debug("%s didn't become valid, skipping setscene" % nexttask)
                             self.sq_task_failoutright(nexttask)
                             return True
-                        else:
-                            self.sqdata.outrightfail.remove(nexttask)
                     if nexttask in self.sqdata.outrightfail:
                         logger.debug2('No package found, so skipping setscene task %s', nexttask)
                         self.sq_task_failoutright(nexttask)
@@ -2827,6 +2825,8 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
             sqdata.stamppresent.remove(tid)
         if tid in sqdata.valid:
             sqdata.valid.remove(tid)
+        if tid in sqdata.outrightfail:
+            sqdata.outrightfail.remove(tid)
 
         noexec, stamppresent = check_setscene_stamps(tid, rqdata, rq, stampcache, noexecstamp=True)
 
@@ -2861,10 +2861,10 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
             if tid in sqrq.scenequeue_covered:
                 continue
 
-            sqdata.outrightfail.add(tid)
-
             h = pending_hash_index(tid, rqdata)
             if h not in sqdata.hashes:
+                if tid in tids:
+                    sqdata.outrightfail.add(tid)
                 sqdata.hashes[h] = tid
             else:
                 sqrq.sq_deferred[tid] = sqdata.hashes[h]
-- 
2.30.2

