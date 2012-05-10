Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SSOmm-0004ec-5g for bitbake-devel@lists.openembedded.org;
	Thu, 10 May 2012 10:31:44 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4A8LoWV008138
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2012 09:21:50 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25795-07 for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2012 09:21:45 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4A8LgtJ008131
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2012 09:21:43 +0100
Message-ID: <1336638101.2494.120.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 10 May 2012 09:21:41 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: bitbake/runqueue: Fix 'full' stamp checking to be more efficient and cache results
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
X-List-Received-Date: Thu, 10 May 2012 08:31:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This should fix issues where bitbake would seemingly lock up when checking
certain configurations of stampfiles.

The cache is kept within the runqueue since that feels like the right
place to associate this cache data.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index b870caf..0eed9ee 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -875,7 +875,7 @@ class RunQueue:
             bb.msg.fatal("RunQueue", "check_stamps fatal internal error")
         return current
 
-    def check_stamp_task(self, task, taskname = None, recurse = False):
+    def check_stamp_task(self, task, taskname = None, recurse = False, cache = None):
         def get_timestamp(f):
             try:
                 if not os.access(f, os.F_OK):
@@ -911,10 +911,16 @@ class RunQueue:
         if taskname != "do_setscene" and taskname.endswith("_setscene"):
             return True
 
+        if cache is None:
+            cache = {}
+
         iscurrent = True
         t1 = get_timestamp(stampfile)
         for dep in self.rqdata.runq_depends[task]:
             if iscurrent:
+                if dep in cache:
+                    iscurrent = cache[dep]
+                    continue
                 fn2 = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[dep]]
                 taskname2 = self.rqdata.runq_task[dep]
                 stampfile2 = bb.build.stampfile(taskname2, self.rqdata.dataCache, fn2)
@@ -931,7 +937,9 @@ class RunQueue:
                         logger.debug(2, 'Stampfile %s < %s', stampfile, stampfile2)
                         iscurrent = False
                     if recurse and iscurrent:
-                        iscurrent = self.check_stamp_task(dep, recurse=True)
+                        iscurrent = self.check_stamp_task(dep, recurse=True, cache=cache)
+                        cache[dep] = iscurrent
+        cache[task] = iscurrent
         return iscurrent
 
     def execute_runqueue(self):
@@ -1041,6 +1049,8 @@ class RunQueueExecute:
         self.build_stamps = {}
         self.failed_fnids = []
 
+        self.stampcache = {}
+
     def runqueue_process_waitpid(self):
         """
         Return none is there are no processes awaiting result collection, otherwise
@@ -1373,7 +1383,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 self.task_skip(task)
                 return True
 
-            if self.rq.check_stamp_task(task, taskname):
+            if self.rq.check_stamp_task(task, taskname, cache=self.stampcache):
                 logger.debug(2, "Stamp current task %s (%s)", task,
                                 self.rqdata.get_user_idstring(task))
                 self.task_skip(task)
@@ -1557,7 +1567,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     bb.build.make_stamp(taskname + "_setscene", self.rqdata.dataCache, fn)
                     continue
 
-                if self.rq.check_stamp_task(realtask, taskname + "_setscene"):
+                if self.rq.check_stamp_task(realtask, taskname + "_setscene", cache=self.stampcache):
                     logger.debug(2, 'Setscene stamp current for task %s(%s)', task, self.rqdata.get_user_idstring(realtask))
                     stamppresent.append(task)
                     self.task_skip(task)
@@ -1650,7 +1660,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[realtask]]
 
             taskname = self.rqdata.runq_task[realtask] + "_setscene"
-            if self.rq.check_stamp_task(realtask, self.rqdata.runq_task[realtask], recurse = True):
+            if self.rq.check_stamp_task(realtask, self.rqdata.runq_task[realtask], recurse = True, cache=self.stampcache):
                 logger.debug(2, 'Stamp for underlying task %s(%s) is current, so skipping setscene variant',
                              task, self.rqdata.get_user_idstring(realtask))
                 self.task_failoutright(task)
@@ -1662,7 +1672,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                         self.task_failoutright(task)
                         return True
 
-            if self.rq.check_stamp_task(realtask, taskname):
+            if self.rq.check_stamp_task(realtask, taskname, cache=self.stampcache):
                 logger.debug(2, 'Setscene stamp current task %s(%s), so skip it and its dependencies',
                              task, self.rqdata.get_user_idstring(realtask))
                 self.task_skip(task)




