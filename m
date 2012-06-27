Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SjpHn-0007Yd-Hm for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jun 2012 12:15:47 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RA4sMu010472
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 11:04:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06021-03 for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 11:04:50 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q5RA4iLp010465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Jun 2012 11:04:45 +0100
Message-ID: <1340791488.23146.13.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Jun 2012 11:04:48 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Convert depends variable to use sets
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
X-List-Received-Date: Wed, 27 Jun 2012 10:15:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This gives some small performance gains and sets the scene for other
improvements by removing the need for duplicate detection code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index e09e8c8..c45287d 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -409,7 +409,7 @@ class RunQueueData:
                 for taskname in tasknames:
                     taskid = taskData.gettask_id_fromfnid(depdata, taskname)
                     if taskid is not None:
-                        depends.append(taskid)
+                        depends.add(taskid)
 
         def add_runtime_dependencies(depids, tasknames, depends):
             for depid in depids:
@@ -421,10 +421,10 @@ class RunQueueData:
                 for taskname in tasknames:
                     taskid = taskData.gettask_id_fromfnid(depdata, taskname)
                     if taskid is not None:
-                        depends.append(taskid)
+                        depends.add(taskid)
 
         for task in xrange(len(taskData.tasks_name)):
-            depends = []
+            depends = set()
             recrdepends = []
             fnid = taskData.tasks_fnid[task]
             fn = taskData.fn_index[fnid]
@@ -437,7 +437,7 @@ class RunQueueData:
                 # Resolve task internal dependencies
                 #
                 # e.g. addtask before X after Y
-                depends = taskData.tasks_tdepends[task]
+                depends = set(taskData.tasks_tdepends[task])
 
                 # Resolve 'deptask' dependencies
                 #
@@ -470,7 +470,7 @@ class RunQueueData:
                             taskid = taskData.gettask_id_fromfnid(depdata, idependtask)
                             if taskid is None:
                                 bb.msg.fatal("RunQueue", "Task %s in %s depends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, dep))
-                            depends.append(taskid)
+                            depends.add(taskid)
                             if depdata != fnid:
                                 tdepends_fnid[fnid].add(taskid)
                 irdepends = taskData.tasks_irdepends[task]
@@ -482,7 +482,7 @@ class RunQueueData:
                             taskid = taskData.gettask_id_fromfnid(depdata, idependtask)
                             if taskid is None:
                                 bb.msg.fatal("RunQueue", "Task %s in %s rdepends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, dep))
-                            depends.append(taskid)
+                            depends.add(taskid)
                             if depdata != fnid:
                                 tdepends_fnid[fnid].add(taskid)
 
@@ -499,16 +499,12 @@ class RunQueueData:
 
                 # Rmove all self references
                 if task in depends:
-                    newdep = []
                     logger.debug(2, "Task %s (%s %s) contains self reference! %s", task, taskData.fn_index[taskData.tasks_fnid[task]], taskData.tasks_name[task], depends)
-                    for dep in depends:
-                        if task != dep:
-                            newdep.append(dep)
-                    depends = newdep
+                    depends.remove(task)
 
             self.runq_fnid.append(taskData.tasks_fnid[task])
             self.runq_task.append(taskData.tasks_name[task])
-            self.runq_depends.append(set(depends))
+            self.runq_depends.append(depends)
             self.runq_revdeps.append(set())
             self.runq_hash.append("")
 




