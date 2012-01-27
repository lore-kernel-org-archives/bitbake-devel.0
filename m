Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RqiNH-00040l-LJ
	for bitbake-devel@lists.openembedded.org;
	Fri, 27 Jan 2012 10:45:39 +0100
Received: by opal (Postfix, from userid 111)
	id 3560610334; Fri, 27 Jan 2012 09:48:15 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120127094815.3560610334@opal>
Date: Fri, 27 Jan 2012 09:48:15 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : runqueue.py: Add inter setscene task dependency handling
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
X-List-Received-Date: Fri, 27 Jan 2012 09:45:39 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: e1b157d26374a70e6274edcb4c0b9f3bc48f765c
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=e1b157d26374a70e6274edcb4c0b9f3bc48f765c

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Jan 26 20:09:08 2012 +0000

runqueue.py: Add inter setscene task dependency handling

This is being added to resolve setscene race issues where we do have
particular dependencies required between setscene tasks. This allows
specific dependencies to be specified. This allows us to fix the races
in sstate with the useradd class in OE-Core.

Any tasks being depended upon have their reverse dependencies cleared to
ensure we don't have circular references.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/runqueue.py |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 8256975..00e9981 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1478,6 +1478,28 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             elif len(sq_revdeps_new[task]) != 0:
                 bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
 
+        # Resolve setscene inter-task dependencies
+        # e.g. do_sometask_setscene[depends] = "targetname:do_someothertask_setscene"
+        # Note that anything explicitly depended upon will have its reverse dependencies removed to avoid circular dependencies
+        for task in self.rqdata.runq_setscene:
+                realid = self.rqdata.taskData.gettask_id(self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]], self.rqdata.runq_task[task] + "_setscene", False)
+                idepends = self.rqdata.taskData.tasks_idepends[realid]
+                for (depid, idependtask) in idepends:
+                    if depid not in self.rqdata.taskData.build_targets:
+                        continue
+
+                    depdata = self.rqdata.taskData.build_targets[depid][0]
+                    if depdata is None:
+                         continue
+                    dep = self.rqdata.taskData.fn_index[depdata]
+                    taskid = self.rqdata.get_task_id(self.rqdata.taskData.getfn_id(dep), idependtask.replace("_setscene", ""))
+                    if taskid is None:
+                        bb.msg.fatal("RunQueue", "Task %s depends upon nonexistant task %s:%s" % (self.rqdata.taskData.tasks_name[realid], dep, idependtask))
+
+                    sq_revdeps_squash[self.rqdata.runq_setscene.index(task)].add(self.rqdata.runq_setscene.index(taskid))
+                    # Have to zero this to avoid circular dependencies
+                    sq_revdeps_squash[self.rqdata.runq_setscene.index(taskid)] = set()
+
         #for task in xrange(len(sq_revdeps_squash)):
         #    print "Task %s: %s.%s is %s " % (task, self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[self.rqdata.runq_setscene[task]]], self.rqdata.runq_task[self.rqdata.runq_setscene[task]] + "_setscene", sq_revdeps_squash[task])
 



