Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RqiPa-00041d-Fe
	for bitbake-devel@lists.openembedded.org;
	Fri, 27 Jan 2012 10:50:06 +0100
Received: by opal (Postfix, from userid 111)
	id 1D34510332; Fri, 27 Jan 2012 09:48:15 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120127094815.1D34510332@opal>
Date: Fri, 27 Jan 2012 09:48:15 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : runqueue.py: Fix missing setscene dependencies
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
X-List-Received-Date: Fri, 27 Jan 2012 09:50:07 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: b9b5b5129d066e1ff7d3effda116afc3c6657beb
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=b9b5b5129d066e1ff7d3effda116afc3c6657beb

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Jan 26 12:53:21 2012 +0000

runqueue.py: Fix missing setscene dependencies

When constructing the setscene inter-dependencies, we need to account for all task,
not just the last one found. This patch corrects this oversight and ensures all
dependencies are added, not just the first one found.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index defdd91..8256975 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1440,18 +1440,20 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             sq_revdeps.append(copy.copy(self.rqdata.runq_revdeps[task]))
             sq_revdeps_new.append(set())
             if (len(self.rqdata.runq_revdeps[task]) == 0) and task not in self.rqdata.runq_setscene:
-                endpoints[task] = None
+                endpoints[task] = set()
 
         for task in self.rqdata.runq_setscene:
             for dep in self.rqdata.runq_depends[task]:
-                    endpoints[dep] = task
+                    if dep not in endpoints:
+                        endpoints[dep] = set()
+                    endpoints[dep].add(task)
 
         def process_endpoints(endpoints):
             newendpoints = {}
             for point, task in endpoints.items():
                 tasks = set()
                 if task:
-                    tasks.add(task)
+                    tasks |= task
                 if sq_revdeps_new[point]:
                     tasks |= sq_revdeps_new[point]
                 sq_revdeps_new[point] = set()



