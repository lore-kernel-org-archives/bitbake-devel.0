Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D5EE56017E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 13:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6AD5JJo010258 for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 14:05:19 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QNtALctiHTAy for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 14:05:19 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t6AD56lt010224
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 14:05:17 +0100
Message-ID: <1436533506.3310.1.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 10 Jul 2015 14:05:06 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] cooker/taskdata: Make NoProvider errors non-fatal to -e/-g options
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
X-List-Received-Date: Fri, 10 Jul 2015 13:05:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If you have a situation where you are getting a "Nothing PROVIDES" error
(for example when something you request to build DEPENDS on something
that has been skipped or doesn't exist) it would be useful to be able to
use bitbake -g or bitbake -e to debug it, but currently both of those
are blocked by the error.

This patch adds an "allowincomplete" option to taskdata and uses this
for the -e/-g bitbake options. The NoProvider errors are still
printed and bitbake does return an error exist code but the environment
and task graph files are generated.

[YOCTO #7623]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 58137f6..46e5560 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -581,7 +581,7 @@ class BBCooker:
             if pkgs_to_build[0] in set(ignore.split()):
                 bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
 
-            taskdata, runlist, pkgs_to_build = self.buildTaskData(pkgs_to_build, None, self.configuration.abort)
+            taskdata, runlist, pkgs_to_build = self.buildTaskData(pkgs_to_build, None, self.configuration.abort, allowincomplete=True)
 
             targetid = taskdata.getbuild_id(pkgs_to_build[0])
             fnid = taskdata.build_targets[targetid][0]
@@ -614,7 +614,7 @@ class BBCooker:
                 logger.plain("\npython %s () {\n%s}\n", e, envdata.getVar(e, True))
 
 
-    def buildTaskData(self, pkgs_to_build, task, abort):
+    def buildTaskData(self, pkgs_to_build, task, abort, allowincomplete=False):
         """
         Prepare a runqueue and taskdata object for iteration over pkgs_to_build
         """
@@ -629,7 +629,7 @@ class BBCooker:
         localdata = data.createCopy(self.data)
         bb.data.update_data(localdata)
         bb.data.expandKeys(localdata)
-        taskdata = bb.taskdata.TaskData(abort, skiplist=self.skiplist)
+        taskdata = bb.taskdata.TaskData(abort, skiplist=self.skiplist, allowincomplete=allowincomplete)
 
         current = 0
         runlist = []
@@ -654,7 +654,7 @@ class BBCooker:
 
         # We set abort to False here to prevent unbuildable targets raising
         # an exception when we're just generating data
-        taskdata, runlist, pkgs_to_build = self.buildTaskData(pkgs_to_build, task, False)
+        taskdata, runlist, pkgs_to_build = self.buildTaskData(pkgs_to_build, task, False, allowincomplete=True)
 
         return runlist, taskdata
 
diff --git a/bitbake/lib/bb/taskdata.py b/bitbake/lib/bb/taskdata.py
index af72a1f..ca58e17 100644
--- a/bitbake/lib/bb/taskdata.py
+++ b/bitbake/lib/bb/taskdata.py
@@ -41,7 +41,7 @@ class TaskData:
     """
     BitBake Task Data implementation
     """
-    def __init__(self, abort = True, tryaltconfigs = False, skiplist = None):
+    def __init__(self, abort = True, tryaltconfigs = False, skiplist = None, allowincomplete = False):
         self.build_names_index = []
         self.run_names_index = []
         self.fn_index = []
@@ -70,6 +70,7 @@ class TaskData:
 
         self.abort = abort
         self.tryaltconfigs = tryaltconfigs
+        self.allowincomplete = allowincomplete
 
         self.skiplist = skiplist
 
@@ -594,9 +595,10 @@ class TaskData:
                     added = added + 1
                 except bb.providers.NoProvider:
                     targetid = self.getbuild_id(target)
-                    if self.abort and targetid in self.external_targets:
+                    if self.abort and targetid in self.external_targets and not self.allowincomplete:
                         raise
-                    self.remove_buildtarget(targetid)
+                    if not self.allowincomplete:
+                        self.remove_buildtarget(targetid)
             for target in self.get_unresolved_run_targets(dataCache):
                 try:
                     self.add_rprovider(cfgData, dataCache, target)



