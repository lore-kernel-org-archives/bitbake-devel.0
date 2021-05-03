Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by mx.groups.io with SMTP id smtpd.web08.34519.1620052568707992183
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 May 2021 07:36:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.24, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: AoUk1J2nQah2Rw8Tod1CDVKPzc37vfGuaN1l9sBezbWW4osAGzC6YeOpOs4NI/X6ApGwJwbvmK
 hHgi8LY/av8g==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="197849346"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="197849346"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 07:36:06 -0700
IronPort-SDR: 0SNuhxu8Rp18QoY63gryUg7pPALQxGN0nXnNVqsOTi5ON9yp+eiy6dG3E5cMrebkgIggXj+5Le
 zbnU4sN9eYeQ==
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="405696751"
Received: from semohdyu-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.249.72.206])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 07:36:05 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.48][PATCH 1/3] runqueue: Fix deferred task issues
Date: Mon,  3 May 2021 22:35:52 +0800
Message-Id: <aa3b9ad1d7e97def61f0f1b191b69c4e85d89aec.1620052467.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620052467.git.anuj.mittal@intel.com>
References: <cover.1620052467.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

In a multiconfig situation there are circumstances where firstly, tasks
are deferred when they shouldn't be, then later, tasks can end up as
both covered and not covered.

This patch fixes two related issues. Firstly, the stamp validity checking
is done up front in the build and not reevaulated. When rebuilding the
deferred task list after scenequeue hash change updates, we need therefore
need to check if a task was in notcovered *or* covered when deciding to
defer it. This avoids strange logs like:

NOTE: Running setscene task X of Y (mc:initrfs_guest:/A/alsa-state.bb:do_deploy_source_date_epoch_setscene)
NOTE: Deferring mc:initrfs_guest:/A/alsa-state.bb:do_deploy_source_date_epoch after mc:host:/A/alsa-state.bb:do_deploy_source_date_epoch

where tasks have run but are then deferred.

Since we're recalculating the whole list, we also need to clear it before
iterating to rebuild it. By ensuring covered tasks aren't added to the
deferred queue, the covered + notcovered issue should also be avoided.
in the task deadlock forcing code.

[YOCTO #14342]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 3c8717fb9ee1114dd80fc1ad22ee6c9e312bdac7)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index acc128ec4..aa1d6b271 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2798,6 +2798,7 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
     sqdata.valid |= rq.validate_hashes(tocheck, cooker.data, len(sqdata.stamppresent), False, summary=summary)
 
     sqdata.hashes = {}
+    sqrq.sq_deferred = {}
     for mc in sorted(sqdata.multiconfigs):
         for tid in sorted(sqdata.sq_revdeps):
             if mc_from_tid(tid) != mc:
@@ -2810,6 +2811,9 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
                 continue
             if tid in sqrq.scenequeue_notcovered:
                 continue
+            if tid in sqrq.scenequeue_covered:
+                continue
+
             sqdata.outrightfail.add(tid)
 
             h = pending_hash_index(tid, rqdata)
-- 
2.30.2

