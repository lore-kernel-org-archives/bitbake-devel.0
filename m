Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RinFl-0001yR-66
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Jan 2012 14:21:09 +0100
Received: by opal (Postfix, from userid 111)
	id AF85110332; Thu,  5 Jan 2012 13:21:29 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120105132129.AF85110332@opal>
Date: Thu,  5 Jan 2012 13:21:29 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : runqueue.py: Add notification of setscene tasks ( should be in knotty)
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
X-List-Received-Date: Thu, 05 Jan 2012 13:21:09 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master-poky
Commit: bca343b94a8ce555f3f697e610b735704486f421
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=bca343b94a8ce555f3f697e610b735704486f421

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Wed Jun  8 20:30:46 2011 +0100

runqueue.py: Add notification of setscene tasks (should be in knotty)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 15d3d00..86744fb 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1614,6 +1614,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 self.task_skip(task)
                 return True
 
+            logger.info("Running setscene task %d of %d (%s:%s)" % (self.stats.completed + self.stats.active + self.stats.failed + 1,
+                                                                         self.stats.total, fn, taskname))
+
             pid, pipein, pipeout = self.fork_off_task(fn, realtask, taskname)
 
             self.build_pids[pid] = task



