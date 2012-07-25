Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Su7If-0000YV-OY for bitbake-devel@lists.openembedded.org;
	Wed, 25 Jul 2012 21:31:13 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PJJi0F014166
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:19:44 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14144-01 for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:19:40 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6PJJ0hv014158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Jul 2012 20:19:28 +0100
Message-ID: <1343243932.27838.18.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 25 Jul 2012 20:18:52 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Allow the setsceneverify function to have a list of tasks that are invalid and need to run
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
X-List-Received-Date: Wed, 25 Jul 2012 19:31:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There was some odd behaviour if some task was run from setscene whilst there were
existing valid stamps for a dependency. For example, do_populate_sysroot might
be installed at setscene time but if there were other tasks not installed from
setscene such as do_populate_lic which depend on do_configure, the setsceneverify
function would think that do_configure needed to be rerun and would hence void the
do_populate_sysroot and force that to rerun too.

The setsceneverify function needs to know which tasks are going to be rerun, not just
what the overall task list is and what setscene functions have run. This patch adds
that information and maintains backwards compatibility in a slightly ugly but effective
way. The metadata needs updating to take advantage of this change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index a4009d4..ca5fe97 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1206,9 +1206,30 @@ class RunQueueExecuteTasks(RunQueueExecute):
         # Allow the metadata to elect for setscene tasks to run anyway
         covered_remove = set()
         if self.rq.setsceneverify:
-            call = self.rq.setsceneverify + "(covered, tasknames, fnids, fns, d)"
-            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : self.rqdata.runq_task, "fnids" : self.rqdata.runq_fnid, "fns" : self.rqdata.taskData.fn_index, "d" : self.cooker.configuration.data }
-            covered_remove = bb.utils.better_eval(call, locs)
+            invalidtasks = []
+            for task in xrange(len(self.rqdata.runq_task)):
+                fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
+                taskname = self.rqdata.runq_task[task]
+                taskdep = self.rqdata.dataCache.task_deps[fn]
+
+                if 'noexec' in taskdep and taskname in taskdep['noexec']:
+                    continue
+                if self.rq.check_stamp_task(task, taskname + "_setscene", cache=self.stampcache):
+                    logger.debug(2, 'Setscene stamp current for task %s(%s)', task, self.rqdata.get_user_idstring(task))
+                    continue
+                if self.rq.check_stamp_task(task, taskname, recurse = True, cache=self.stampcache):
+                    logger.debug(2, 'Normal stamp current for task %s(%s)', task, self.rqdata.get_user_idstring(task))
+                    continue
+                invalidtasks.append(task)
+
+            call = self.rq.setsceneverify + "(covered, tasknames, fnids, fns, d, invalidtasks=invalidtasks)"
+            call2 = self.rq.setsceneverify + "(covered, tasknames, fnids, fns, d)"
+            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : self.rqdata.runq_task, "fnids" : self.rqdata.runq_fnid, "fns" : self.rqdata.taskData.fn_index, "d" : self.cooker.configuration.data, "invalidtasks" : invalidtasks }
+            # Backwards compatibility with older versions without invalidtasks
+            try:
+                covered_remove = bb.utils.better_eval(call, locs)
+            except TypeError:
+                covered_remove = bb.utils.better_eval(call2, locs)
 
         for task in covered_remove:
             fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]




