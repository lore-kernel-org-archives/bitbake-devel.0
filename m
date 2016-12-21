Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D42EE77473
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Dec 2016 17:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH5ws1001272; Wed, 21 Dec 2016 17:06:34 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pANwq3Xibvt5; Wed, 21 Dec 2016 17:06:34 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBLH6TS1001591
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Dec 2016 17:06:30 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cJkLV-0006uQ-Fh; Wed, 21 Dec 2016 17:06:29 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Dec 2016 17:06:23 +0000
Message-Id: <1482339985-26495-5-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1482339985-26495-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 5/7] runqueue: Ensure setscene tasks with overlapping stamps don't parallel execute
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
X-List-Received-Date: Wed, 21 Dec 2016 17:06:36 -0000

In multiconfig, mutliple tasks can execute which share the same stamp file. These
must not execute in parallel, the idea is the first should execute, the subsequent
ones should see a valid stamp and get skipped.

The normal task execution code has stamps code to handle this, this adds similar
code to the setscene execute() function to handle the issue there too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 10c5c2e..ef14347 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1886,6 +1886,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         sq_revdeps_new = {}
         sq_revdeps_squash = {}
         self.sq_harddeps = {}
+        self.stamps = {}
 
         # We need to construct a dependency graph for the setscene functions. Intermediate
         # dependencies between the setscene tasks only complicate the code. This code
@@ -1999,6 +2000,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
                 realtid = tid + "_setscene"
                 idepends = self.rqdata.taskData[mc].taskentries[realtid].idepends
+                self.stamps[tid] = bb.build.stampfile(taskname + "_setscene", self.rqdata.dataCaches[mc], taskfn, noextra=True)
                 for (depname, idependtask) in idepends:
 
                     if depname not in self.rqdata.taskData[mc].build_targets:
@@ -2175,7 +2177,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         if self.stats.active < self.number_tasks:
             # Find the next setscene to run
             for nexttask in self.rqdata.runq_setscene_tids:
-                if nexttask in self.runq_buildable and nexttask not in self.runq_running:
+                if nexttask in self.runq_buildable and nexttask not in self.runq_running and self.stamps[nexttask] not in self.build_stamps.values():
                     if nexttask in self.unskippable:
                         logger.debug(2, "Setscene task %s is unskippable" % nexttask)
                     if nexttask not in self.unskippable and len(self.sq_revdeps[nexttask]) > 0 and self.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sq_revdeps[nexttask], True):
@@ -2227,6 +2229,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 self.rq.worker[mc].process.stdin.write(b"<runtask>" + pickle.dumps((taskfn, task, taskname, True, self.cooker.collection.get_file_appends(taskfn), taskdepdata, False)) + b"</runtask>")
                 self.rq.worker[mc].process.stdin.flush()
 
+            self.build_stamps[task] = bb.build.stampfile(taskname, self.rqdata.dataCaches[mc], taskfn, noextra=True)
+            self.build_stamps2.append(self.build_stamps[task])
             self.runq_running.add(task)
             self.stats.taskActive()
             if self.stats.active < self.number_tasks:
-- 
2.7.4


