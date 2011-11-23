Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RTCGx-0000Fc-4K for bitbake-devel@lists.openembedded.org;
	Wed, 23 Nov 2011 13:49:55 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pANChNcV012407
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Nov 2011 12:43:23 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 32443-09 for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Nov 2011 12:43:18 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pANChEo1012401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Nov 2011 12:43:15 GMT
Message-ID: <1322052201.18926.77.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 23 Nov 2011 12:43:21 +0000
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Ensure setscene tasks don't break dependency order
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
X-List-Received-Date: Wed, 23 Nov 2011 12:49:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If A depends upon B which depends upon C and the setscene for B
succeeds but C is going to get rebuilt, we should wait for C to
try and build A but currently we don't.

This is due to the timing of when we run the task_skip() as this
triggers other tasks to become buildable. This patch moves the timing
of that call to a more appropriate place allowing dependencies to
behave as expected.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index e00a299..acea8f2 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1243,9 +1243,6 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         logger.debug(1, 'Full skip list %s', self.rq.scenequeue_covered)
 
-        for task in self.rq.scenequeue_covered:
-            self.task_skip(task)
-
         event.fire(bb.event.StampUpdate(self.rqdata.target_pairs, self.rqdata.dataCache.stamp), self.cfgData)
 
         schedulers = self.get_schedulers()
@@ -1339,8 +1336,14 @@ class RunQueueExecuteTasks(RunQueueExecute):
         task = self.sched.next()
         if task is not None:
             fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[task]]
-
             taskname = self.rqdata.runq_task[task]
+
+            if task in self.rq.scenequeue_covered:
+                logger.debug(2, "Setscene covered task %s (%s)", task,
+                                self.rqdata.get_user_idstring(task))
+                self.task_skip(task)
+                return True
+
             if self.rq.check_stamp_task(task, taskname):
                 logger.debug(2, "Stamp current task %s (%s)", task,
                                 self.rqdata.get_user_idstring(task))




