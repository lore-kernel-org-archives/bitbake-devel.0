Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SDEeT-00083w-BB
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:40:29 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Mar 2012 05:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="124781624"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 29 Mar 2012 05:31:24 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:54:54 +0800
Message-Id: <b0f25a4ae7b257c5e0631a3e5c1f90facf25aca6.1333025491.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
References: <ae31cc41fb985bdc59e784dbf973c522b666553a.1333025490.git.shane.wang@intel.com>
In-Reply-To: <cover.1333025490.git.shane.wang@intel.com>
References: <cover.1333025490.git.shane.wang@intel.com>
Subject: [PATCH 5/8] runqueue.py: check results[0] in keys of build_pids before being used to avoid exceptions
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
X-List-Received-Date: Thu, 29 Mar 2012 12:40:29 -0000

[Yocto #2186]

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/runqueue.py |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 6970548..67ad14b 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1049,17 +1049,21 @@ class RunQueueExecute:
         result = os.waitpid(-1, os.WNOHANG)
         if result[0] == 0 and result[1] == 0:
             return None
-        task = self.build_pids[result[0]]
-        del self.build_pids[result[0]]
-        self.build_pipes[result[0]].close()
-        del self.build_pipes[result[0]]
+        task = None
+        if result[0] in self.build_pids.keys():
+            task = self.build_pids[result[0]]
+            del self.build_pids[result[0]]
+        if result[0] in self.build_pipes.keys():
+            self.build_pipes[result[0]].close()
+            del self.build_pipes[result[0]]
         # self.build_stamps[result[0]] may not exist when use shared work directory.
         if result[0] in self.build_stamps.keys():
             del self.build_stamps[result[0]]
-        if result[1] != 0:
-            self.task_fail(task, result[1]>>8)
-        else:
-            self.task_complete(task)
+        if task:
+            if result[1] != 0:
+                self.task_fail(task, result[1]>>8)
+            else:
+                self.task_complete(task)
         return True
 
     def finish_now(self):
-- 
1.7.6



