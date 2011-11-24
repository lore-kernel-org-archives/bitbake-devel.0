Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RThYL-0002Ai-8S
	for bitbake-devel@lists.openembedded.org;
	Thu, 24 Nov 2011 23:13:57 +0100
Received: by opal (Postfix, from userid 111)
	id 4E87E10331; Thu, 24 Nov 2011 22:09:55 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111124220955.4E87E10331@opal>
Date: Thu, 24 Nov 2011 22:09:55 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : runqueue.py: Fix debug message to reference the correct task
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
X-List-Received-Date: Thu, 24 Nov 2011 22:13:57 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 035c673c463ca450245acf824e7b7e8f889bdc89
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=035c673c463ca450245acf824e7b7e8f889bdc89

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Nov 24 14:14:55 2011 +0000

runqueue.py: Fix debug message to reference the correct task

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f5598ca..1800634 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1524,8 +1524,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
 
             for task in xrange(len(self.sq_revdeps)):
                 if task not in valid_new and task not in noexec:
+                    realtask = self.rqdata.runq_setscene[task]
                     logger.debug(2, 'No package found, so skipping setscene task %s',
-                                 self.rqdata.get_user_idstring(task))
+                                 self.rqdata.get_user_idstring(realtask))
                     self.task_failoutright(task)
 
         logger.info('Executing SetScene Tasks')



