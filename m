Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RntI8-000693-MV
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jan 2012 15:48:40 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 19 Jan 2012 06:36:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="58007059"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.198])
	by AZSMGA002.ch.intel.com with ESMTP; 19 Jan 2012 06:36:06 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jan 2012 14:36:03 +0000
Message-Id: <a996be9518b7cd4a9fa50958be65dbd63380c8ca.1326982052.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1326982052.git.paul.eggleton@linux.intel.com>
References: <cover.1326982052.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1326982052.git.paul.eggleton@linux.intel.com>
References: <cover.1326982052.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake/runqueue: always log tasks summary
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 19 Jan 2012 14:48:40 -0000

It's unclear from the history but at some point we stopped logging the
"Tasks Summary" NOTE when tasks failed. Reinstate this for failure, and
also make the count of attempted tasks include the failed task.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/runqueue.py |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 054d36c..be6bbb1 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -959,6 +959,13 @@ class RunQueue:
         if self.state is runQueueCleanUp:
            self.rqexe.finish()
 
+        if self.state is runQueueComplete or self.state is runQueueFailed:
+            if self.rqexe.stats.failed:
+                logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and %d failed.", self.rqexe.stats.completed + self.rqexe.stats.failed, self.rqexe.stats.skipped, self.rqexe.stats.failed)
+            else:
+                # Let's avoid the word "failed" if nothing actually did
+                logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and all succeeded.", self.rqexe.stats.completed, self.rqexe.stats.skipped)
+
         if self.state is runQueueFailed:
             if not self.rqdata.taskData.tryaltconfigs:
                 raise bb.runqueue.TaskFailure(self.rqexe.failed_fnids)
@@ -968,11 +975,6 @@ class RunQueue:
 
         if self.state is runQueueComplete:
             # All done
-            if self.rqexe.stats.failed:
-                logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and %d failed.", self.rqexe.stats.completed, self.rqexe.stats.skipped, self.rqexe.stats.failed)
-            else:
-                # Let's avoid the word "failed" if nothing actually did
-                logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and all succeeded.", self.rqexe.stats.completed, self.rqexe.stats.skipped)
             return False
 
         if self.state is runQueueChildProcess:
-- 
1.7.5.4



