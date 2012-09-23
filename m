Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TFmDL-0006ob-SI
	for bitbake-devel@lists.openembedded.org;
	Sun, 23 Sep 2012 15:27:16 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 23 Sep 2012 06:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,469,1344236400"; d="scan'208";a="196020445"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.252])
	by azsmga001.ch.intel.com with ESMTP; 23 Sep 2012 06:14:27 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 23 Sep 2012 14:14:24 +0100
Message-Id: <1348406065-8828-1-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] lib/bb/runqueue.py: fix exceptions with -k and failed targets
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
X-List-Received-Date: Sun, 23 Sep 2012 13:27:16 -0000

If a target dependency is marked as failed and yet we are continuing on
because -k has been specified, don't try to access the dependency's data
in taskData.build_targets since it will have been removed. This fixes
"IndexError: list index out of range" errors in this situation.

Also, do not print the "unhandled exception" message when SystemExit is
raised since we will have reported the actual error already in this
case (e.g. when -k has been specified and some targets failed).

Fixes [YOCTO #3133].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/runqueue.py |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index bc2eb87..b90b7e7 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -466,7 +466,7 @@ class RunQueueData:
                 # (makes sure sometask runs after targetname's someothertask)
                 idepends = taskData.tasks_idepends[task]
                 for (depid, idependtask) in idepends:
-                    if depid in taskData.build_targets:
+                    if depid in taskData.build_targets and not depid in taskData.failed_deps:
                         # Won't be in build_targets if ASSUME_PROVIDED
                         depdata = taskData.build_targets[depid][0]
                         if depdata is not None:
@@ -932,6 +932,8 @@ class RunQueue:
             return self._execute_runqueue()
         except bb.runqueue.TaskFailure:
             raise
+        except SystemExit:
+            raise
         except:
             logger.error("An uncaught exception occured in runqueue, please see the failure below:")
             self.state = runQueueComplete
-- 
1.7.9.5



