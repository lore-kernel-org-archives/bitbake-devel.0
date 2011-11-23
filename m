Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RTFJw-0006Li-1R
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 Nov 2011 17:05:12 +0100
Received: by opal (Postfix, from userid 111)
	id 686E91032F; Wed, 23 Nov 2011 16:00:59 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111123160059.686E91032F@opal>
Date: Wed, 23 Nov 2011 16:00:59 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : runqueue.py: Ensure we fully process the covered list
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
X-List-Received-Date: Wed, 23 Nov 2011 16:05:12 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 61017fc5d30b7a13308d038872ec92efc1a84cef
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=61017fc5d30b7a13308d038872ec92efc1a84cef

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Mon Nov 21 14:02:00 2011 +0000

runqueue.py: Ensure we fully process the covered list

The existing looping code can mask an existing "found = True"
by forcing it to False each time. This can lead to dependency
lists not being fully searched and results in dependency errors.

An exmaple of this was the autobuilder building linux-yocto from
sstate but then rebuilding some of the recipe's tasks for no
apparent reason. Separating the logic into two variables solves this
problem since any "found = True" value is now always preserved.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index bea6f9c..f5598ca 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1209,12 +1209,13 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 if task in self.rq.scenequeue_covered:
                     continue
                 if len(self.rqdata.runq_revdeps[task]) > 0 and self.rqdata.runq_revdeps[task].issubset(self.rq.scenequeue_covered):
-                    found = True
+                    ok = True
                     for revdep in self.rqdata.runq_revdeps[task]:
                         if self.rqdata.runq_fnid[task] != self.rqdata.runq_fnid[revdep]:
-                            found = False
+                            ok = False
                             break
-                    if found:
+                    if ok:
+                        found = True
                         self.rq.scenequeue_covered.add(task)
 
         logger.debug(1, 'Skip list (pre setsceneverify) %s', sorted(self.rq.scenequeue_covered))



