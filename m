Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id C24036EA3F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Apr 2014 08:16:46 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s318Ggob009743 for <bitbake-devel@lists.openembedded.org>;
	Tue, 1 Apr 2014 09:16:42 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eBDLb1Uz90xB for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Apr 2014 09:16:42 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s318GZVM009739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 1 Apr 2014 09:16:37 +0100
Message-ID: <1396340190.14790.88.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 01 Apr 2014 09:16:30 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Address issues with incomplete sstate sets
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
X-List-Received-Date: Tue, 01 Apr 2014 08:16:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

The first part of the sstate code checks en-mass whether given checksums
are available. The next part of the code then either triggers those
setscene tasks either running them or skipping them if they've been
covered by others.

The problems was that this second part would always skip a task if it
was unavailable in the first part, even if it would have otherwise been
covered by other tasks.

This mean the mere presence of an artefact (or lack of presence) could
cause a different build failure.

The issue reproduces if you run a build and populate an sstate feed, then
run a second build off that feed, then run a third build off the sstate
feed of the second build (which is reduced in size).

The fix is rather than immediately skipping tasks if the checksum is
unavailable, create a list of missing tasks, then, if that task cannot
be covered by others we can skip it later. The deferral makes the
behaviour the same even when the cache is "incomplete".

[YOCTO #6081]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 1a19677..6372b65 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1779,6 +1779,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             if len(self.sq_revdeps[task]) == 0:
                 self.runq_buildable[task] = 1
 
+        self.outrightfail = []
         if self.rq.hashvalidate:
             sq_hash = []
             sq_hashfn = []
@@ -1829,7 +1830,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     realtask = self.rqdata.runq_setscene[task]
                     logger.debug(2, 'No package found, so skipping setscene task %s',
                                  self.rqdata.get_user_idstring(realtask))
-                    self.task_failoutright(task)
+                    self.outrightfail.append(task)
 
         logger.info('Executing SetScene Tasks')
 
@@ -1914,6 +1915,9 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                             self.task_skip(nexttask)
                             self.scenequeue_notneeded.add(nexttask)
                             return True
+                    if nexttask in self.outrightfail:
+                        self.task_failoutright(nexttask)
+                        return True
                     task = nexttask
                     break
         if task is not None:



