Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1Rin6T-0001hp-D0
	for bitbake-devel@lists.openembedded.org;
	Thu, 05 Jan 2012 14:11:33 +0100
Received: by opal (Postfix, from userid 111)
	id EA21A10333; Thu,  5 Jan 2012 13:11:52 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120105131152.EA21A10333@opal>
Date: Thu,  5 Jan 2012 13:11:52 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : bitbake/runqueue: Improve the setscene logging
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
X-List-Received-Date: Thu, 05 Jan 2012 13:11:33 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: cff2c258b77fde01d530a5923e553e6111b15eb5
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=cff2c258b77fde01d530a5923e553e6111b15eb5

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Mon Nov 21 14:40:37 2011 +0000

bitbake/runqueue: Improve the setscene logging

When debugging setscene problems it was found that some extra debug messages were useful.
This patch adds them.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index f7e7ace..0e83d05 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1208,10 +1208,14 @@ class RunQueueExecuteTasks(RunQueueExecute):
             for task in xrange(self.stats.total):
                 if task in self.rq.scenequeue_covered:
                     continue
+                logger.debug(1, 'Considering %s (%s): %s' % (task, self.rqdata.get_user_idstring(task), str(self.rqdata.runq_revdeps[task])))
+
                 if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered):
                     ok = True
                     for revdep in self.rqdata.runq_revdeps[task]:
                         if self.rqdata.runq_fnid[task] != self.rqdata.runq_fnid[revdep]:
+                            logger.debug(1, 'Found "bad" dep %s (%s) for %s (%s)' % (revdep, self.rqdata.get_user_idstring(revdep), task, self.rqdata.get_user_idstring(task)))
+
                             ok = False
                             break
                     if ok:



