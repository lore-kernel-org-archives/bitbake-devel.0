Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S37a8-0007re-5j
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Mar 2012 16:06:12 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 01 Mar 2012 06:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123711553"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.90])
	by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2012 06:57:41 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  1 Mar 2012 14:57:35 +0000
Message-Id: <10b72664e950de1784fe864188a02bcd212bb151.1330613733.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1330613733.git.paul.eggleton@linux.intel.com>
References: <cover.1330613733.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1330613733.git.paul.eggleton@linux.intel.com>
References: <cover.1330613733.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] bitbake/runqueue: fix python error on scenequeue task failure
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
X-List-Received-Date: Thu, 01 Mar 2012 15:06:12 -0000

Fixes a regression introduced in commit
e8a3499c95a6d4f2b8fed002fb9504733c5be3c6 which resulted in a
backtrace on setscene task failure due to trying to dereference
the setscene task ID twice.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/runqueue.py |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index d4b2cd4..d0e0892 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1606,8 +1606,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
     def task_fail(self, task, result):
         self.stats.taskFailed()
-        index = self.rqdata.runq_setscene[task]
-        bb.event.fire(sceneQueueTaskFailed(index, self.stats, result, self), self.cfgData)
+        bb.event.fire(sceneQueueTaskFailed(task, self.stats, result, self), self.cfgData)
         self.scenequeue_notcovered.add(task)
         self.scenequeue_updatecounters(task)
 
-- 
1.7.5.4



