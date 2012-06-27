Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SjpH9-0007Xa-Pp for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jun 2012 12:15:08 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RA4Dfs010461
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 11:04:13 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06198-02 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 11:04:06 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RA43oM010454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 11:04:05 +0100
Message-ID: <1340791446.23146.12.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Jun 2012 11:04:06 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] taskdata: Add gettask_id_fromfnid helper function
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
X-List-Received-Date: Wed, 27 Jun 2012 10:15:08 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This is like gettask_id but doesn't require translation of fnid -> fn
first which the function then translates back. This gives a sizeable
performance improvement since a significant number of lookups are avoided.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 03766ad..e09e8c8 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -406,9 +406,8 @@ class RunQueueData:
                 depdata = taskData.build_targets[depid][0]
                 if depdata is None:
                     continue
-                dep = taskData.fn_index[depdata]
                 for taskname in tasknames:
-                    taskid = taskData.gettask_id(dep, taskname, False)
+                    taskid = taskData.gettask_id_fromfnid(depdata, taskname)
                     if taskid is not None:
                         depends.append(taskid)
 
@@ -419,9 +418,8 @@ class RunQueueData:
                 depdata = taskData.run_targets[depid][0]
                 if depdata is None:
                     continue
-                dep = taskData.fn_index[depdata]
                 for taskname in tasknames:
-                    taskid = taskData.gettask_id(dep, taskname, False)
+                    taskid = taskData.gettask_id_fromfnid(depdata, taskname)
                     if taskid is not None:
                         depends.append(taskid)
 
@@ -469,8 +467,7 @@ class RunQueueData:
                         # Won't be in build_targets if ASSUME_PROVIDED
                         depdata = taskData.build_targets[depid][0]
                         if depdata is not None:
-                            dep = taskData.fn_index[depdata]
-                            taskid = taskData.gettask_id(dep, idependtask, False)
+                            taskid = taskData.gettask_id_fromfnid(depdata, idependtask)
                             if taskid is None:
                                 bb.msg.fatal("RunQueue", "Task %s in %s depends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, dep))
                             depends.append(taskid)
@@ -482,8 +479,7 @@ class RunQueueData:
                         # Won't be in run_targets if ASSUME_PROVIDED
                         depdata = taskData.run_targets[depid][0]
                         if depdata is not None:
-                            dep = taskData.fn_index[depdata]
-                            taskid = taskData.gettask_id(dep, idependtask, False)
+                            taskid = taskData.gettask_id_fromfnid(depdata, idependtask)
                             if taskid is None:
                                 bb.msg.fatal("RunQueue", "Task %s in %s rdepends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, dep))
                             depends.append(taskid)
diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index 8bc447c..55cdde5 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -116,6 +116,16 @@ class TaskData:
                 ids.append(self.tasks_lookup[fnid][task])
         return ids
 
+    def gettask_id_fromfnid(self, fnid, task):
+        """
+        Return an ID number for the task matching fnid and task.
+        """
+        if fnid in self.tasks_lookup:
+            if task in self.tasks_lookup[fnid]:
+                return self.tasks_lookup[fnid][task]
+
+        return None
+
     def gettask_id(self, fn, task, create = True):
         """
         Return an ID number for the task matching fn and task.




