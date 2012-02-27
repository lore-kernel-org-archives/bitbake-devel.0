Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S25qQ-0001wh-2s
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 20:02:46 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 27 Feb 2012 10:54:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="70898467"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.30])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Feb 2012 10:54:17 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Feb 2012 18:54:12 +0000
Message-Id: <5c4747691670e22e1b707a615e9c6f796387161d.1330368761.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1330368761.git.paul.eggleton@linux.intel.com>
References: <cover.1330368761.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1330368761.git.paul.eggleton@linux.intel.com>
References: <cover.1330368761.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] bitbake/runqueue: make dry-run do everything except execute
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
X-List-Received-Date: Mon, 27 Feb 2012 19:02:46 -0000

Make dry-run do everything except executing the task, instead of
cutting it off earlier. This fully tests the code path for running the
child task (parsing and fakeroot), as well as enabling future
functionality such as using dry-run to produce signature files.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/runqueue.py |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 0652c49..d4b2cd4 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1187,7 +1187,8 @@ class RunQueueExecute:
                     logger.critical(str(exc))
                 os._exit(1)
             try:
-                ret = bb.build.exec_task(fn, taskname, the_data)
+                if not self.cooker.configuration.dry_run:
+                    ret = bb.build.exec_task(fn, taskname, the_data)
                 os._exit(ret)
             except:
                 os._exit(1)
@@ -1370,12 +1371,6 @@ class RunQueueExecuteTasks(RunQueueExecute):
                                 self.rqdata.get_user_idstring(task))
                 self.task_skip(task)
                 return True
-            elif self.cooker.configuration.dry_run:
-                self.runq_running[task] = 1
-                self.runq_buildable[task] = 1
-                self.stats.taskActive()
-                self.task_complete(task)
-                return True
 
             taskdep = self.rqdata.dataCache.task_deps[fn]
             if 'noexec' in taskdep and taskname in taskdep['noexec']:
-- 
1.7.5.4



