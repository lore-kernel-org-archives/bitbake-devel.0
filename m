Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by mx.groups.io with SMTP id smtpd.web11.3973.1631747984007383249
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Sep 2021 16:19:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.151, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202605351"
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="202605351"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:44 -0700
X-IronPort-AV: E=Sophos;i="5.85,296,1624345200"; 
   d="scan'208";a="434303192"
Received: from chgan-mobl.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.238.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 16:19:43 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 1/5] runqueue: Avoid deadlock avoidance task graph corruption
Date: Thu, 16 Sep 2021 07:19:34 +0800
Message-Id: <0c95a8724b1b8d69b5c93aea4dbd1830cf161690.1631747835.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631747835.git.anuj.mittal@intel.com>
References: <cover.1631747835.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the deferred task deadlock avoidance code triggers, it could mark an executed
task as failed which leads to "covered and not covered" error messages. Improve
the logic so if the deadlock code is triggered, it doesn't cause the errors.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 51bdd6cb3bd9e2c02e261fb578bb945b86b82c75)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6c41fe6d4..014ee37bf 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2180,7 +2180,8 @@ class RunQueueExecute:
         if self.sq_deferred:
             tid = self.sq_deferred.pop(list(self.sq_deferred.keys())[0])
             logger.warning("Runqeueue deadlocked on deferred tasks, forcing task %s" % tid)
-            self.sq_task_failoutright(tid)
+            if tid not in self.runq_complete:
+                self.sq_task_failoutright(tid)
             return True
 
         if len(self.failed_tids) != 0:
-- 
2.31.1

