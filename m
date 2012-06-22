Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Si2ZB-0000Rm-UZ for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jun 2012 14:02:22 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5MBpZsc001105
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:51:35 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27315-09 for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:51:32 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5MBpR34001094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jun 2012 12:51:29 +0100
Message-ID: <1340365889.394.13.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 22 Jun 2012 12:51:29 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: taskdata.py: Add support for rdepends task flag
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
X-List-Received-Date: Fri, 22 Jun 2012 12:02:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently its not possible to add arbitrary RDEPENDS to a specific task.
This can be useful and this patch adds functionality equivalent to the
'depends' task flag.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
index 828daa1..5e6b68d 100644
--- a/bitbake/lib/bb/build.py
+++ b/bitbake/lib/bb/build.py
@@ -567,6 +567,7 @@ def add_tasks(tasklist, d):
                 deptask = data.expand(flags[name], d)
                 task_deps[name][task] = deptask
         getTask('depends')
+        getTask('rdepends')
         getTask('deptask')
         getTask('rdeptask')
         getTask('recrdeptask')
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 608aff8..1d9bdf0 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -476,7 +476,19 @@ class RunQueueData:
                             depends.append(taskid)
                             if depdata != fnid:
                                 tdepends_fnid[fnid].add(taskid)
-
+                irdepends = taskData.tasks_irdepends[task]
+                for (depid, idependtask) in irdepends:
+                    if depid in taskData.run_targets:
+                        # Won't be in run_targets if ASSUME_PROVIDED
+                        depdata = taskData.run_targets[depid][0]
+                        if depdata is not None:
+                            dep = taskData.fn_index[depdata]
+                            taskid = taskData.gettask_id(dep, idependtask, False)
+                            if taskid is None:
+                                bb.msg.fatal("RunQueue", "Task %s in %s rdepends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, dep))
+                            depends.append(taskid)
+                            if depdata != fnid:
+                                tdepends_fnid[fnid].add(taskid)
 
                 # Resolve recursive 'recrdeptask' dependencies (A)
                 #
diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index ee1a723..8bc447c 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -55,6 +55,7 @@ class TaskData:
         self.tasks_name = []
         self.tasks_tdepends = []
         self.tasks_idepends = []
+        self.tasks_irdepends = []
         # Cache to speed up task ID lookups
         self.tasks_lookup = {}
 
@@ -134,6 +135,7 @@ class TaskData:
         self.tasks_fnid.append(fnid)
         self.tasks_tdepends.append([])
         self.tasks_idepends.append([])
+        self.tasks_irdepends.append([])
 
         listid = len(self.tasks_name) - 1
 
@@ -178,6 +180,15 @@ class TaskData:
                             bb.msg.fatal("TaskData", "Error for %s, dependency %s does not contain ':' character\n. Task 'depends' should be specified in the form 'packagename:task'" % (fn, dep))
                         ids.append(((self.getbuild_id(dep.split(":")[0])), dep.split(":")[1]))
                 self.tasks_idepends[taskid].extend(ids)
+            if 'rdepends' in task_deps and task in task_deps['rdepends']:
+                ids = []
+                for dep in task_deps['rdepends'][task].split():
+                    if dep:
+                        if ":" not in dep:
+                            bb.msg.fatal("TaskData", "Error for %s, dependency %s does not contain ':' character\n. Task 'rdepends' should be specified in the form 'packagename:task'" % (fn, dep))
+                        ids.append(((self.getrun_id(dep.split(":")[0])), dep.split(":")[1]))
+                self.tasks_irdepends[taskid].extend(ids)
+
 
         # Work out build dependencies
         if not fnid in self.depids:
@@ -533,6 +544,11 @@ class TaskData:
         dependees = self.get_rdependees(targetid)
         for fnid in dependees:
             self.fail_fnid(fnid, missing_list)
+        for taskid in xrange(len(self.tasks_irdepends)):
+            irdepends = self.tasks_irdepends[taskid]
+            for (idependid, idependtask) in irdepends:
+                if idependid == targetid:
+                    self.fail_fnid(self.tasks_fnid[taskid], missing_list)
 
     def add_unresolved(self, cfgData, dataCache):
         """




