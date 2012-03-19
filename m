Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1S9dEx-0004kA-BJ
	for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 15:07:15 +0100
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1S9d6P-0003Qn-2J for bitbake-devel@lists.openembedded.org;
	Mon, 19 Mar 2012 09:58:25 -0400
Date: Mon, 19 Mar 2012 09:58:14 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1203190957160.617@oneiric>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: [PATCH] Typo: "nonexistant" -> "non-existent"
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
X-List-Received-Date: Mon, 19 Mar 2012 14:07:15 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index dcd6d1a..6970548 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -472,7 +472,7 @@ class RunQueueData:
                             dep = taskData.fn_index[depdata]
                             taskid = taskData.gettask_id(dep, idependtask, False)
                             if taskid is None:
-                                bb.msg.fatal("RunQueue", "Task %s in %s depends upon nonexistant task %s in %s" % (taskData.tasks_name[task], fn, idependtask, dep))
+                                bb.msg.fatal("RunQueue", "Task %s in %s depends upon non-existent task %s in %s" % (taskData.tasks_name[task], fn, idependtask, dep))
                             depends.append(taskid)
                             if depdata != fnid:
                                 tdepends_fnid[fnid].add(taskid)
@@ -1513,7 +1513,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     dep = self.rqdata.taskData.fn_index[depdata]
                     taskid = self.rqdata.get_task_id(self.rqdata.taskData.getfn_id(dep), idependtask.replace("_setscene", ""))
                     if taskid is None:
-                        bb.msg.fatal("RunQueue", "Task %s depends upon nonexistant task %s:%s" % (self.rqdata.taskData.tasks_name[realid], dep, idependtask))
+                        bb.msg.fatal("RunQueue", "Task %s depends upon non-existent task %s:%s" % (self.rqdata.taskData.tasks_name[realid], dep, idependtask))

                     sq_revdeps_squash[self.rqdata.runq_setscene.index(task)].add(self.rqdata.runq_setscene.index(taskid))
                     # Have to zero this to avoid circular dependencies

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


