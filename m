Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 15C386E6B7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Feb 2014 15:01:40 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1DF1aXN001855 for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Feb 2014 15:01:36 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xrTenFZU72I0 for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Feb 2014 15:01:36 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1DF1V3f001851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Feb 2014 15:01:32 GMT
Message-ID: <1392303685.14081.19.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 13 Feb 2014 15:01:25 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] runqueue: Ensure we do run 'masked' setscene tasks if specified as targets
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
X-List-Received-Date: Thu, 13 Feb 2014 15:01:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you specify multiple targets on bitbake's commandline and some of them are
setscene tasks which are "masked" by other tasks they may not get run.

For example <image>:do_rootfs <kernel>:do_populate_sysroot

the rootfs tasks "masks" the populate_sysroot task so bitbake would currently
decide not to run it. In this case, we do really want it to be run.

The fix is not to skip anything which has been given as an explict target.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index a83fc6a..2475fd1 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1899,10 +1899,18 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     if nexttask in self.unskippable:
                         logger.debug(2, "Setscene task %s is unskippable" % self.rqdata.get_user_idstring(self.rqdata.runq_setscene[nexttask]))                      
                     if nexttask not in self.unskippable and len(self.sq_revdeps[nexttask]) > 0 and self.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sq_revdeps[nexttask], True):
-                        logger.debug(2, "Skipping setscene for task %s" % self.rqdata.get_user_idstring(self.rqdata.runq_setscene[nexttask]))
-                        self.task_skip(nexttask)
-                        self.scenequeue_notneeded.add(nexttask)
-                        return True
+                        realtask = self.rqdata.runq_setscene[nexttask]
+                        fn = self.rqdata.taskData.fn_index[self.rqdata.runq_fnid[realtask]]
+                        target = False
+                        for target in self.rqdata.target_pairs:
+                            if target[0] == fn and target[1] == self.rqdata.runq_task[realtask]:
+                                target = True
+                                break
+                        if not target:
+                            logger.debug(2, "Skipping setscene for task %s" % self.rqdata.get_user_idstring(self.rqdata.runq_setscene[nexttask]))
+                            self.task_skip(nexttask)
+                            self.scenequeue_notneeded.add(nexttask)
+                            return True
                     task = nexttask
                     break
         if task is not None:



