Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RqVkj-0003fi-JG for bitbake-devel@lists.openembedded.org;
	Thu, 26 Jan 2012 21:17:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0QK9Dd0027672
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jan 2012 20:09:13 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 26041-05 for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jan 2012 20:09:09 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0QK95FJ027666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Jan 2012 20:09:06 GMT
Message-ID: <1327608548.19643.395.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 26 Jan 2012 20:09:08 +0000
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Add inter setscene task dependency handling
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
X-List-Received-Date: Thu, 26 Jan 2012 20:17:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This is being added to resolve setscene race issues where we do have
particular dependencies required between setscene tasks. This allows
specific dependencies to be specified. This allows us to fix the races
in sstate with the useradd class in OE-Core.

Any tasks being depended upon have their reverse dependencies cleared to
ensure we don't have circular references.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index a4030b3..d477345 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1473,6 +1473,29 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             elif len(sq_revdeps_new[task]) != 0:
                 bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
 
+        # Resolve setscene inter-task dependencies
+        # e.g. do_sometask_setscene[depends] = "targetname:do_someothertask_setscene"
+        # Note that anything explicitly depended upon will have its reverse dependencies removed to avoid circular dependencies
+        for task in self.rqdata.runq_setscene:
+                realid = self.rqdata.taskData.gettask_id(self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]], self.rqdata.runq_task[task] + "_setscene", False)
+                idepends = self.rqdata.taskData.tasks_idepends[realid]
+                for (depid, idependtask) in idepends:
+                    bb.error("%s %s" % (depid, idependtask))
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
 




