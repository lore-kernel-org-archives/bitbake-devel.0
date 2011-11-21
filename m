Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RSXBd-0000A2-Jo for bitbake-devel@lists.openembedded.org;
	Mon, 21 Nov 2011 17:57:41 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pALGpDgk009107
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2011 16:51:13 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08521-06 for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2011 16:51:08 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pALGp5UN009101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2011 16:51:05 GMT
Message-ID: <1321894270.18926.36.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 Nov 2011 16:51:10 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: bitbake/runqueue.py: Add BB_SETSCENE_VERIFY_FUNCTION hook
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
X-List-Received-Date: Mon, 21 Nov 2011 16:57:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The OE metadata has cases where it needs to prevent some setscene
functions from running. An example of this is where we know a task
is going to run do_configure (which would clean out do_populate_sysroot)
and hence we don't want do_populate_sysroot_setscene to run.

This change adds in a hook so that the metadata can allow any
such policy decision to filter back up to bitbake.

It removes the existing code which attempted to do this in a generic
way but failed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 54b1c86..de2cfb9 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -767,6 +767,7 @@ class RunQueue:
 
         self.stamppolicy = bb.data.getVar("BB_STAMP_POLICY", cfgData, True) or "perfile"
         self.hashvalidate = bb.data.getVar("BB_HASHCHECK_FUNCTION", cfgData, True) or None
+        self.setsceneverify = bb.data.getVar("BB_SETSCENE_VERIFY_FUNCTION", cfgData, True) or None
 
         self.state = runQueuePrepare
 
@@ -1220,23 +1221,20 @@ class RunQueueExecuteTasks(RunQueueExecute):
                         found = True
                         self.rq.scenequeue_covered.add(task)
 
-        # Detect when the real task needs to be run anyway by looking to see
-        # if any of its dependencies within the same package are scheduled
-        # to be run.
+        logger.debug(1, 'Skip list (pre setsceneverify) %s', sorted(self.rq.scenequeue_covered))
+
+        # Allow the metadata to elect for setscene tasks to run anyway
         covered_remove = set()
-        for task in self.rq.scenequeue_covered:
-            task_fnid = self.rqdata.runq_fnid[task]
-            for dep in self.rqdata.runq_depends[task]:
-                if self.rqdata.runq_fnid[dep] == task_fnid:
-                    if dep not in self.rq.scenequeue_covered:
-                        covered_remove.add(task)
-                        break
+        if self.rq.setsceneverify:
+            call = self.rq.setsceneverify + "(covered, tasknames, fnids, fns, d)"
+            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : self.rqdata.runq_task, "fnids" : self.rqdata.runq_fnid, "fns" : self.rqdata.taskData.fn_index, "d" : self.cooker.configuration.data }
+            covered_remove = bb.utils.better_eval(call, locs)
 
         for task in covered_remove:
             fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
             taskname = self.rqdata.runq_task[task] + '_setscene'
             bb.build.del_stamp(taskname, self.rqdata.dataCache, fn)
-            logger.debug(1, 'Not skipping task %s because it will have to be run anyway', task)
+            logger.debug(1, 'Not skipping task %s due to setsceneverify', task)
             self.rq.scenequeue_covered.remove(task)
 
         logger.debug(1, 'Full skip list %s', self.rq.scenequeue_covered)




