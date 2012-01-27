Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RqiPS-00040t-Fi
	for bitbake-devel@lists.openembedded.org;
	Fri, 27 Jan 2012 10:47:56 +0100
Received: by opal (Postfix, from userid 111)
	id 059751032F; Fri, 27 Jan 2012 09:48:14 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120127094815.059751032F@opal>
Date: Fri, 27 Jan 2012 09:48:15 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : data/runqueue.py: Fix commented out test code after variable name changes
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
X-List-Received-Date: Fri, 27 Jan 2012 09:47:56 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 175c5c8a5e51365aa127562e8598e84f5cd36495
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=175c5c8a5e51365aa127562e8598e84f5cd36495

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Jan 26 12:52:04 2012 +0000

data/runqueue.py: Fix commented out test code after variable name changes

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/data.py     |    2 +-
 lib/bb/runqueue.py |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index e5c408c..c0636e1 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -333,7 +333,7 @@ def generate_dependencies(d):
                     deps[dep], values[dep] = build_dependencies(dep, keys, shelldeps, vardepvals, d)
                 newdeps |=  deps[dep]
             newdeps -= seen
-        #print "For %s: %s" % (task, str(taskdeps[task]))
+        #print "For %s: %s" % (task, str(deps[task]))
     return tasklist, deps, values
 
 def inherits_class(klass, d):
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 0db5377..defdd91 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1477,7 +1477,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
 
         #for task in xrange(len(sq_revdeps_squash)):
-        #    print "Task %s: %s.%s is %s " % (task, self.taskData.fn_index[self.runq_fnid[self.runq_setscene[task]]], self.runq_task[self.runq_setscene[task]] + "_setscene", sq_revdeps_squash[task])
+        #    print "Task %s: %s.%s is %s " % (task, self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[self.rqdata.runq_setscene[task]]], self.rqdata.runq_task[self.rqdata.runq_setscene[task]] + "_setscene", sq_revdeps_squash[task])
 
         self.sq_deps = []
         self.sq_revdeps = sq_revdeps_squash



