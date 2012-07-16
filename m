Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Sqmuj-0004tM-6N for bitbake-devel@lists.openembedded.org;
	Mon, 16 Jul 2012 17:08:45 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6GEvR8O001259
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Jul 2012 15:57:27 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 31762-04 for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Jul 2012 15:57:23 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6GEvK41001253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Jul 2012 15:57:21 +0100
Message-ID: <1342450642.5019.20.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 16 Jul 2012 15:57:22 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] runqueue.py: Improve error output to be more useful when non-existent tasks are found
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
X-List-Received-Date: Mon, 16 Jul 2012 15:08:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index cb4ffb2..0a8c723 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1450,7 +1450,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     dep = self.rqdata.taskData.fn_index[depdata]
                     taskid = self.rqdata.get_task_id(self.rqdata.taskData.getfn_id(dep), idependtask.replace("_setscene", ""))
                     if taskid is None:
-                        bb.msg.fatal("RunQueue", "Task %s depends upon non-existent task %s:%s" % (self.rqdata.taskData.tasks_name[realid], dep, idependtask))
+                        bb.msg.fatal("RunQueue", "Task %s:%s depends upon non-existent task %s:%s" % (self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[realid]], self.rqdata.taskData.tasks_name[realid], dep, idependtask))
 
                     sq_revdeps_squash[self.rqdata.runq_setscene.index(task)].add(self.rqdata.runq_setscene.index(taskid))
                     # Have to zero this to avoid circular dependencies




