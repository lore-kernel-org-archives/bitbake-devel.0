Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by mx.groups.io with SMTP id smtpd.web10.2320.1619407680398067934
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 25 Apr 2021 20:28:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.115, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: UgWOJuGHTn9lJ7Q+7BITtHvrEbzZkDedpuMikBD7bkH22/MNVjaH95uHAS04sO+hzvSU3vqEbK
 McvgAuYH6FGA==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="195828053"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="195828053"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:28:00 -0700
IronPort-SDR: +JwNO5oFyi4llT+Y+RIiy1WBnbAdiRNWmZJDoYfApgL52SrptAlfI5fZsaIpQEVhF4GBf3h5GB
 5MgP3wKv2huQ==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="464923221"
Received: from wsan-mobl1.ccr.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.213.45.138])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 20:27:58 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 1/5] runqueue: Fix deferred task issues
Date: Mon, 26 Apr 2021 11:27:48 +0800
Message-Id: <c09436f7c719c4341611bb4df91524738d272440.1619407547.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619407547.git.anuj.mittal@intel.com>
References: <cover.1619407547.git.anuj.mittal@intel.com>
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
index cd56a5547..feb42d3e6 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2845,6 +2845,7 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
     sqdata.valid |= rq.validate_hashes(tocheck, cooker.data, len(sqdata.stamppresent), False, summary=summary)
 
     sqdata.hashes = {}
+    sqrq.sq_deferred = {}
     for mc in sorted(sqdata.multiconfigs):
         for tid in sorted(sqdata.sq_revdeps):
             if mc_from_tid(tid) != mc:
@@ -2857,6 +2858,9 @@ def update_scenequeue_data(tids, sqdata, rqdata, rq, cooker, stampcache, sqrq, s
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

