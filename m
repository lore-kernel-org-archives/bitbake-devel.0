Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RSsRV-0004VG-6d
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Nov 2011 16:39:29 +0100
Received: by opal (Postfix, from userid 111)
	id 73FE910330; Tue, 22 Nov 2011 13:08:39 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111122130839.73FE910330@opal>
Date: Tue, 22 Nov 2011 13:08:39 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : bitbake/runqueue.py: Fix incorrect task number reference in debug message
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
X-List-Received-Date: Tue, 22 Nov 2011 15:39:29 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 94c97534adef000559fd97aa51da6a7f35840bbd
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=94c97534adef000559fd97aa51da6a7f35840bbd

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Mon Nov 21 14:39:29 2011 +0000

bitbake/runqueue.py: Fix incorrect task number reference in debug message

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a725388..69a703d 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1596,7 +1596,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             taskname = self.rqdata.runq_task[realtask] + "_setscene"
             if self.rq.check_stamp_task(realtask, self.rqdata.runq_task[realtask]):
                 logger.debug(2, 'Stamp for underlying task %s(%s) is current, so skipping setscene variant',
-                             task, self.rqdata.get_user_idstring(task))
+                             task, self.rqdata.get_user_idstring(realtask))
                 self.task_failoutright(task)
                 return True
 



