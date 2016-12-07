Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C0CA460806
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Dec 2016 12:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uB7C4tLW006366; Wed, 7 Dec 2016 12:04:55 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id vSyd8-QFM9jK; Wed,  7 Dec 2016 12:04:55 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uB7C4r8Q006359
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Dec 2016 12:04:54 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cEaxx-0008NR-4I; Wed, 07 Dec 2016 12:04:53 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Dec 2016 12:04:45 +0000
Message-Id: <1481112285-32150-3-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1481112285-32150-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1481112285-32150-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 3/3] runqueue: Send BB_TASKDEPDATA for setscene tasks
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
X-List-Received-Date: Wed, 07 Dec 2016 12:04:56 -0000

We now have code in OE that needs BB_TASKDEPDATA for setscene tasks. Therefore
generate and send this data. In this case its a "pre collapsed" tree
but that is fine for the use cases in question.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/runqueue.py | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 41e4768..75060e5 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -2211,14 +2211,16 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             startevent = sceneQueueTaskStarted(task, self.stats, self.rq)
             bb.event.fire(startevent, self.cfgData)
 
+            taskdepdata = self.build_taskdepdata(task)
+
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
             if 'fakeroot' in taskdep and taskname in taskdep['fakeroot'] and not self.cooker.configuration.dry_run:
                 if not self.rq.fakeworker:
                     self.rq.start_fakeworker(self)
-                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), None)) + b"</runtask>")
+                self.rq.fakeworker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata)) + b"</runtask>")
                 self.rq.fakeworker[mc].process.stdin.flush()
             else:
-                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), None)) + b"</runtask>")
+                self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
             self.runq_running.add(task)
@@ -2251,6 +2253,44 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
     def runqueue_process_waitpid(self, task, status):
         RunQueueExecute.runqueue_process_waitpid(self, task, status)
 
+
+    def build_taskdepdata(self, task):
+        def getsetscenedeps(tid):
+            deps = set()
+            (mc, fn, taskname, _) = split_tid_mcfn(tid)
+            realtid = fn + ":" + taskname + "_setscene"
+            idepends = self.rqdata.taskData[mc].taskentries[realtid].idepends
+            for (depname, idependtask) in idepends:
+                if depname not in self.rqdata.taskData[mc].build_targets:
+                    continue
+
+                depfn = self.rqdata.taskData[mc].build_targets[depname][0]
+                if depfn is None:
+                     continue
+                deptid = depfn + ":" + idependtask.replace("_setscene", "")
+                deps.add(deptid)
+            return deps
+
+        taskdepdata = {}
+        next = getsetscenedeps(task)
+        next.add(task)
+        while next:
+            additional = []
+            for revdep in next:
+                (mc, fn, taskname, taskfn) = split_tid_mcfn(revdep)
+                pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
+                deps = getsetscenedeps(revdep)
+                provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
+                taskhash = self.rqdata.runtaskentries[revdep].hash
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
+                for revdep2 in deps:
+                    if revdep2 not in taskdepdata:
+                        additional.append(revdep2)
+            next = additional
+
+        #bb.note("Task %s: " % task + str(taskdepdata).replace("], ", "],\n"))
+        return taskdepdata
+
 class TaskFailure(Exception):
     """
     Exception raised when a task in a runqueue fails
-- 
2.7.4


