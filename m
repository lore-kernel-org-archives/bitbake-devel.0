Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RSsRV-0004VY-R5
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 Nov 2011 16:39:30 +0100
Received: by opal (Postfix, from userid 111)
	id 8C84D10332; Tue, 22 Nov 2011 13:08:39 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111122130839.8C84D10332@opal>
Date: Tue, 22 Nov 2011 13:08:39 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : bitbake/runqueue.py: Sort the list of skipped tasks as it makes searching the list easier when debugging
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
X-List-Received-Date: Tue, 22 Nov 2011 15:39:30 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 78c02276c7d445403af285f8870a7a2d5a8f4a4b
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=78c02276c7d445403af285f8870a7a2d5a8f4a4b

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Mon Nov 21 14:40:21 2011 +0000

bitbake/runqueue.py: Sort the list of skipped tasks as it makes searching the list easier when debugging

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 69a703d..6cc6ab2 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1635,7 +1635,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         for task in oldcovered:
             self.rq.scenequeue_covered.add(self.rqdata.runq_setscene[task])
 
-        logger.debug(1, 'We can skip tasks %s', self.rq.scenequeue_covered)
+        logger.debug(1, 'We can skip tasks %s', sorted(self.rq.scenequeue_covered))
 
         self.rq.state = runQueueRunInit
         return True



