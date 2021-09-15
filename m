Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mx.groups.io with SMTP id smtpd.web11.3973.1631747984007383249
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Sep 2021 16:19:46 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.151, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202605362"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="202605362"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:46 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="434303195"
Received: from chgan-mobl.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:45 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 2/5] runqueue: Fix issues with multiconfig deferred task deadlock messages
Date: Thu, 16 Sep 2021 07:19:35 +0800
Message-Id: <3984d33fa32e4bc064f94b9c08e965a368251b42.1631747835.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631747835.git.anuj.mittal@intel.com>
References: <cover.1631747835.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

In multiconfig builds with large numbers of identical tasks, builds were
deadlocking after recent runqueue changes upon rebuilds where there was
heavy sstate usage (i.e. on second builds after a first completed).

The issue was that deferred tasks were being left indefinitely on
the deferred list. The deadlock handler was then "breaking" things
by failing tasks that had already succeeded, leading to the task
being on both covered and not covered lists, giving a further error.

The fix is to clean up the deferred task list when each setscene task
completes. I'd previously been hoping to avoid iterating that list
but it appears unavoidable.

[YOCTO #14342]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ae24a0f2d2d8b4b5ec10efabd0e9362e560832ea)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/runqueue.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 014ee37bf..f67981309 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1904,6 +1904,12 @@ class RunQueueExecute:
                 self.setbuildable(revdep)
                 logger.debug("Marking task %s as buildable", revdep)
 
+        for t in self.sq_deferred.copy():
+            if self.sq_deferred[t] == task:
+                logger.debug2("Deferred task %s now buildable" % t)
+                del self.sq_deferred[t]
+                update_scenequeue_data([t], self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=False)
+
     def task_complete(self, task):
         self.stats.taskCompleted()
         bb.event.fire(runQueueTaskCompleted(task, self.stats, self.rq), self.cfgData)
-- 
2.31.1

