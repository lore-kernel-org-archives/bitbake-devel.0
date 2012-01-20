Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RoIG8-0005LB-R7
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 18:28:17 +0100
Received: by opal (Postfix, from userid 111)
	id 953C510331; Fri, 20 Jan 2012 16:50:58 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120120165058.953C510331@opal>
Date: Fri, 20 Jan 2012 16:50:58 +0000 (UTC)
From: git@git.openembedded.org
Subject: Paul Eggleton : bitbake/runqueue: always log tasks summary
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
X-List-Received-Date: Fri, 20 Jan 2012 17:28:17 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: e44d5be98fc5d2589cd929ce143638395936b936
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=e44d5be98fc5d2589cd929ce143638395936b936

Author: Paul Eggleton <paul.eggleton@linux.intel.com>
Date:   Thu Jan 19 14:36:03 2012 +0000

bitbake/runqueue: always log tasks summary

It's unclear from the history but at some point we stopped logging the
"Tasks Summary" NOTE when tasks failed. Reinstate this for failure, and
also make the count of attempted tasks include the failed task.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 12ebdf9..0db5377 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
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



