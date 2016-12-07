Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4B2C871AAF
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Dec 2016 12:31:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uB7CVR2d009223; Wed, 7 Dec 2016 12:31:27 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rYcGmeSy7dcJ; Wed,  7 Dec 2016 12:31:27 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uB7CVOfY009219
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Dec 2016 12:31:25 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cEbNc-0000ra-GK; Wed, 07 Dec 2016 12:31:24 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Dec 2016 12:31:21 +0000
Message-Id: <1481113881-3280-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] cooker: Fix world taskgraph generation issue
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
X-List-Received-Date: Wed, 07 Dec 2016 12:31:28 -0000

The processing of the "do_" prefix to tasks is currently inconsistent
and has resulted in "bitbake world -g" being broken as task prefixes
don't get handled correctly.

Make the "do_" task prefix handling consistent through various codepaths.

[YOCTO #10651]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/cooker.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 4810fe3..1fe693c 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -657,6 +657,8 @@ class BBCooker:
         # A task of None means use the default task
         if task is None:
             task = self.configuration.cmd
+        if not task.startswith("do_"):
+            task = "do_%s" % task
 
         fulltargetlist = self.checkPackages(pkgs_to_build, task)
         taskdata = {}
@@ -715,6 +717,9 @@ class BBCooker:
         Create a dependency graph of pkgs_to_build including reverse dependency
         information.
         """
+        if not task.startswith("do_"):
+            task = "do_%s" % task
+
         runlist, taskdata = self.prepareTreeData(pkgs_to_build, task)
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
         rq.rqdata.prepare()
@@ -818,6 +823,9 @@ class BBCooker:
         """
         Create a dependency tree of pkgs_to_build, returning the data.
         """
+        if not task.startswith("do_"):
+            task = "do_%s" % task
+
         _, taskdata = self.prepareTreeData(pkgs_to_build, task)
 
         seen_fns = []
@@ -1322,6 +1330,8 @@ class BBCooker:
         # If we are told to do the None task then query the default task
         if (task == None):
             task = self.configuration.cmd
+        if not task.startswith("do_"):
+            task = "do_%s" % task
 
         fn, cls, mc = bb.cache.virtualfn2realfn(buildfile)
         fn = self.matchFile(fn)
@@ -1358,8 +1368,6 @@ class BBCooker:
         # Invalidate task for target if force mode active
         if self.configuration.force:
             logger.verbose("Invalidate task %s, %s", task, fn)
-            if not task.startswith("do_"):
-                task = "do_%s" % task
             bb.parse.siggen.invalidate_task(task, self.recipecaches[mc], fn)
 
         # Setup taskdata structure
@@ -1371,8 +1379,6 @@ class BBCooker:
         bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.expanded_data)
 
         # Execute the runqueue
-        if not task.startswith("do_"):
-            task = "do_%s" % task
         runlist = [[mc, item, task, fn]]
 
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
-- 
2.7.4


