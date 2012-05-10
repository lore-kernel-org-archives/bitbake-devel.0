Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SSOoF-0004gp-F5 for bitbake-devel@lists.openembedded.org;
	Thu, 10 May 2012 10:33:16 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4A8NMn6008158
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2012 09:23:22 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25795-08 for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2012 09:23:18 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4A8NCbe008152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 May 2012 09:23:13 +0100
Message-ID: <1336638191.2494.122.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 10 May 2012 09:23:11 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/runqueue: Drop check_stamp_fn, its obsolete and should not be used
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
X-List-Received-Date: Thu, 10 May 2012 08:33:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This function was used by old code such as packaged staging but is thankfully
obsolete now and replaced with better mechanisms. Its time to remove it and
the horrible internal only variables associated with it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 8d56331..5bf9056 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1080,8 +1080,6 @@ class RunQueueExecute:
                 os.umask(umask)
 
             self.cooker.configuration.data.setVar("BB_WORKERCONTEXT", "1")
-            self.cooker.configuration.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY", self)
-            self.cooker.configuration.data.setVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY2", fn)
             bb.parse.siggen.set_taskdata(self.rqdata.hashes, self.rqdata.hash_deps)
             ret = 0
             try:
@@ -1692,15 +1690,6 @@ class runQueueTaskCompleted(runQueueEvent):
     Event notifing a task completed
     """
 
-def check_stamp_fn(fn, taskname, d):
-    rqexe = d.getVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY")
-    fn = d.getVar("__RUNQUEUE_DO_NOT_USE_EXTERNALLY2")
-    fnid = rqexe.rqdata.taskData.getfn_id(fn)
-    taskid = rqexe.rqdata.get_task_id(fnid, taskname)
-    if taskid is not None:
-        return rqexe.rq.check_stamp_task(taskid)
-    return None
-
 class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server




