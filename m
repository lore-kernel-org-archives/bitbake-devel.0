Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 69A2677494
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Dec 2016 17:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6YRN001647; Wed, 21 Dec 2016 17:06:34 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id O5b_mmG0qVoB; Wed, 21 Dec 2016 17:06:34 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6Tc2001590
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Dec 2016 17:06:30 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cJkLV-0006uL-FA; Wed, 21 Dec 2016 17:06:29 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Dec 2016 17:06:22 +0000
Message-Id: <1482339985-26495-4-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 4/7] runqueue: Fix setscene issues with multiconfig
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 21 Dec 2016 17:06:37 -0000

setscene was being entirelu skipped for multiconfig variants as the tasks
were simply not being spotted. If the default config was also being built
it masked the problem. When this was fixed by using taskfn instead of fn
in lookups against dataCache, several other instances of this problem were
highlighted.

This goes through and corrects the setscene code to correclty use taskfn
instead of fn in the appropriate places meaning setscene tasks for multiconfig
now work correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 25a2684..10c5c2e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -290,8 +290,8 @@ class RunQueueData:
         return tid + task_name_suffix
 
     def get_short_user_idstring(self, task, task_name_suffix = ""):
-        (mc, fn, taskname, _) = split_tid_mcfn(task)
-        pn = self.dataCaches[mc].pkg_fn[fn]
+        (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
+        pn = self.dataCaches[mc].pkg_fn[taskfn]
         taskname = taskname_from_tid(task) + task_name_suffix
         return "%s:%s" % (pn, taskname)
 
@@ -885,14 +885,14 @@ class RunQueueData:
         if not self.cooker.configuration.nosetscene:
             for tid in self.runtaskentries:
                 (mc, fn, taskname, _) = split_tid_mcfn(tid)
-                setscenetid = fn + ":" + taskname + "_setscene"
+                setscenetid = tid + "_setscene"
                 if setscenetid not in taskData[mc].taskentries:
                     continue
                 self.runq_setscene_tids.append(tid)
 
         def invalidate_task(tid, error_nostamp):
-            (mc, fn, taskname, _) = split_tid_mcfn(tid)
-            taskdep = self.dataCaches[mc].task_deps[fn]
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+            taskdep = self.dataCaches[mc].task_deps[taskfn]
             if fn + ":" + taskname not in taskData[mc].taskentries:
                 logger.warning("Task %s does not exist, invalidating this task will have no effect" % taskname)
             if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
@@ -1339,7 +1339,7 @@ class RunQueue:
                 continue
 
             sq_fn.append(fn)
-            sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[fn])
+            sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
             sq_hash.append(self.rqdata.runtaskentries[tid].hash)
             sq_taskname.append(taskname)
             sq_task.append(tid)
@@ -1419,8 +1419,8 @@ class RunQueue:
 
 
         for tid in invalidtasks:
-            (mc, fn, taskname, _) = split_tid_mcfn(tid)
-            pn = self.rqdata.dataCaches[mc].pkg_fn[fn]
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+            pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
             h = self.rqdata.runtaskentries[tid].hash
             matches = bb.siggen.find_siginfo(pn, taskname, [], self.cfgData)
             match = None
@@ -1523,8 +1523,8 @@ class RunQueueExecute:
         taskdata = {}
         taskdeps.add(task)
         for dep in taskdeps:
-            (mc, fn, taskname, _) = split_tid_mcfn(dep)
-            pn = self.rqdata.dataCaches[mc].pkg_fn[fn]
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(dep)
+            pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
             taskdata[dep] = [pn, taskname, fn]
         call = self.rq.depvalidate + "(task, taskdata, notneeded, d)"
         locs = { "task" : task, "taskdata" : taskdata, "notneeded" : self.scenequeue_notneeded, "d" : self.cooker.data }
@@ -1724,7 +1724,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
             # Check tasks that are going to run against the whitelist
             def check_norun_task(tid, showerror=False):
-                (mc, fn, taskname, _) = split_tid_mcfn(tid)
+                (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
                 # Ignore covered tasks
                 if tid in self.rq.scenequeue_covered:
                     return False
@@ -1732,11 +1732,11 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 if self.rq.check_stamp_task(tid, taskname, cache=self.stampcache):
                     return False
                 # Ignore noexec tasks
-                taskdep = self.rqdata.dataCaches[mc].task_deps[fn]
+                taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
                 if 'noexec' in taskdep and taskname in taskdep['noexec']:
                     return False
 
-                pn = self.rqdata.dataCaches[mc].pkg_fn[fn]
+                pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
                 if not check_setscene_enforce_whitelist(pn, taskname, self.rqdata.setscenewhitelist):
                     if showerror:
                         if tid in self.rqdata.runq_setscene_tids:
@@ -1996,8 +1996,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         # e.g. do_sometask_setscene[depends] = "targetname:do_someothertask_setscene"
         # Note that anything explicitly depended upon will have its reverse dependencies removed to avoid circular dependencies
         for tid in self.rqdata.runq_setscene_tids:
-                (mc, fn, taskname, _) = split_tid_mcfn(tid)
-                realtid = fn + ":" + taskname + "_setscene"
+                (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+                realtid = tid + "_setscene"
                 idepends = self.rqdata.taskData[mc].taskentries[realtid].idepends
                 for (depname, idependtask) in idepends:
 
@@ -2062,7 +2062,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             for tid in self.sq_revdeps:
                 (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
 
-                taskdep = self.rqdata.dataCaches[mc].task_deps[fn]
+                taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
 
                 if 'noexec' in taskdep and taskname in taskdep['noexec']:
                     noexec.append(tid)
@@ -2083,7 +2083,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     continue
 
                 sq_fn.append(fn)
-                sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[fn])
+                sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
                 sq_hash.append(self.rqdata.runtaskentries[tid].hash)
                 sq_taskname.append(taskname)
                 sq_task.append(tid)
@@ -2131,8 +2131,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
     def check_taskfail(self, task):
         if self.rqdata.setscenewhitelist:
             realtask = task.split('_setscene')[0]
-            (mc, fn, taskname, _) = split_tid_mcfn(realtask)
-            pn = self.rqdata.dataCaches[mc].pkg_fn[fn]
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(realtask)
+            pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
             if not check_setscene_enforce_whitelist(pn, taskname, self.rqdata.setscenewhitelist):
                 logger.error('Task %s.%s failed' % (pn, taskname + "_setscene"))
                 self.rq.state = runQueueCleanUp
@@ -2262,7 +2262,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         def getsetscenedeps(tid):
             deps = set()
             (mc, fn, taskname, _) = split_tid_mcfn(tid)
-            realtid = fn + ":" + taskname + "_setscene"
+            realtid = tid + "_setscene"
             idepends = self.rqdata.taskData[mc].taskentries[realtid].idepends
             for (depname, idependtask) in idepends:
                 if depname not in self.rqdata.taskData[mc].build_targets:
-- 
2.7.4


