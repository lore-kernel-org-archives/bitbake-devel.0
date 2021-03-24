Received: from mga14.intel.com (mga14.intel.com [])
 by mx.groups.io with SMTP id smtpd.web11.55.1616596422209368700
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Mar 2021 07:33:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=fail (domain: intel.com, ip: <nil>, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: k+wzQUOGyDoAfgXKwS5ntcWZT7C4p2djrc1AMejmsJPQFMB8sP4DR3nqtzgSLcp4RnMxw8FSQW
 bPnyGmSZdOJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190132812"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="190132812"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:33:44 -0700
IronPort-SDR: 6QoA/owmIO4fDAZbWzPTZmmbPp56h7aLzk6YxtxwV8RRjA+rxbpalqQf9LC7NjTLoPnnTMEKv2
 vTDe+kVnCxPg==
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="514213833"
Received: from alianabi-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.215.167.51])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:33:42 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.48][PATCH 2/3] runqueue: Add setscene task overlap sanity check
Date: Wed, 24 Mar 2021 22:33:06 +0800
Message-Id: <10d371f34dad1b6be26e3b80d2815690e8964bf4.1616596112.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616596112.git.anuj.mittal@intel.com>
References: <cover.1616596112.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We've seen hard to debug issues where a task ends up in both the
covered and notcovered list. Add a sanity check to ensure if this
happens in future, we see it in the logs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 6e001410854792f9bb66a0409a2ac176171b0507)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/runqueue.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index e22ca72ce..acc128ec4 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1942,6 +1942,10 @@ class RunQueueExecute:
             logger.error("Scenequeue had holdoff tasks: %s" % pprint.pformat(self.holdoff_tasks))
             err = True
 
+        for tid in self.scenequeue_covered.intersection(self.scenequeue_notcovered):
+            # No task should end up in both covered and uncovered, that is a bug.
+            logger.error("Setscene task %s in both covered and notcovered." % tid)
+
         for tid in self.rqdata.runq_setscene_tids:
             if tid not in self.scenequeue_covered and tid not in self.scenequeue_notcovered:
                 err = True
-- 
2.30.2

