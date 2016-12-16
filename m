Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3BCBB77293
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Dec 2016 10:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBGA5SdO010113; Fri, 16 Dec 2016 10:05:28 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id iCiI-89N_V42; Fri, 16 Dec 2016 10:05:28 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uBGA5QKE010110
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 16 Dec 2016 10:05:27 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1cHpOI-0004dj-MS; Fri, 16 Dec 2016 10:05:26 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Dec 2016 10:05:21 +0000
Message-Id: <1481882722-17796-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 1/2] cooker/command: Drop expanded_data
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
X-List-Received-Date: Fri, 16 Dec 2016 10:05:30 -0000

Some of our metadata assumes that BuildStarted and BuildCompleted events
see the same data store. This is the case for buildTarget but not for
buildFile and recent changes mean this is now a problem.

The update_data() call is now an empty operation and there is no difference
between the expanded_data and data so we can simply remove the expanded_data
and its references and use data everywhere. This has been inteded for a while
but the above issue makes this more pressing to finally clean up.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py  |  6 +++---
 lib/bb/cooker.py   | 26 ++++++++++++--------------
 lib/bb/runqueue.py |  8 ++++----
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 5bce796..db20f3f 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -133,11 +133,11 @@ class Command:
 
     def finishAsyncCommand(self, msg=None, code=None):
         if msg or msg == "":
-            bb.event.fire(CommandFailed(msg), self.cooker.expanded_data)
+            bb.event.fire(CommandFailed(msg), self.cooker.data)
         elif code:
-            bb.event.fire(CommandExit(code), self.cooker.expanded_data)
+            bb.event.fire(CommandExit(code), self.cooker.data)
         else:
-            bb.event.fire(CommandCompleted(), self.cooker.expanded_data)
+            bb.event.fire(CommandCompleted(), self.cooker.data)
         self.currentAsyncCommand = None
         self.cooker.finishcommand()
 
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 620ff9f..30131fb 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -367,9 +367,7 @@ class BBCooker:
         # Copy of the data store which has been expanded.
         # Used for firing events and accessing variables where expansion needs to be accounted for
         #
-        self.expanded_data = bb.data.createCopy(self.data)
-        bb.data.update_data(self.expanded_data)
-        bb.parse.init_parser(self.expanded_data)
+        bb.parse.init_parser(self.data)
 
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.disableDataTracking()
@@ -619,7 +617,7 @@ class BBCooker:
             fn = self.matchFile(fn)
             fn = bb.cache.realfn2virtual(fn, cls, mc)
         elif len(pkgs_to_build) == 1:
-            ignore = self.expanded_data.getVar("ASSUME_PROVIDED") or ""
+            ignore = self.data.getVar("ASSUME_PROVIDED") or ""
             if pkgs_to_build[0] in set(ignore.split()):
                 bb.fatal("%s is in ASSUME_PROVIDED" % pkgs_to_build[0])
 
@@ -1090,7 +1088,7 @@ class BBCooker:
     def findBestProvider(self, pn, mc=''):
         if pn in self.recipecaches[mc].providers:
             filenames = self.recipecaches[mc].providers[pn]
-            eligible, foundUnique = bb.providers.filterProviders(filenames, pn, self.expanded_data, self.recipecaches[mc])
+            eligible, foundUnique = bb.providers.filterProviders(filenames, pn, self.data, self.recipecaches[mc])
             filename = eligible[0]
             return None, None, None, filename
         elif pn in self.recipecaches[mc].pkg_pn:
@@ -1304,7 +1302,7 @@ class BBCooker:
             bf = os.path.abspath(bf)
 
         self.collection = CookerCollectFiles(self.bbfile_config_priorities)
-        filelist, masked = self.collection.collect_bbfiles(self.data, self.expanded_data)
+        filelist, masked = self.collection.collect_bbfiles(self.data, self.data)
         try:
             os.stat(bf)
             bf = os.path.abspath(bf)
@@ -1339,7 +1337,7 @@ class BBCooker:
         """
         Build the file matching regexp buildfile
         """
-        bb.event.fire(bb.event.BuildInit(), self.expanded_data)
+        bb.event.fire(bb.event.BuildInit(), self.data)
 
         if not hidewarning:
             # Too many people use -b because they think it's how you normally
@@ -1399,7 +1397,7 @@ class BBCooker:
         taskdata[mc].add_provider(self.data, self.recipecaches[mc], item)
 
         buildname = self.data.getVar("BUILDNAME")
-        bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.expanded_data)
+        bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.data)
 
         # Execute the runqueue
         runlist = [[mc, item, task, fn]]
@@ -1429,7 +1427,7 @@ class BBCooker:
                 return False
 
             if not retval:
-                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, item, failures, interrupted), self.expanded_data)
+                bb.event.fire(bb.event.BuildCompleted(len(rq.rqdata.runtaskentries), buildname, item, failures, interrupted), self.data)
                 self.command.finishAsyncCommand(msg)
                 return False
             if retval is True:
@@ -1484,7 +1482,7 @@ class BBCooker:
 
         packages = [target if ':' in target else '%s:%s' % (target, task) for target in targets]
 
-        bb.event.fire(bb.event.BuildInit(packages), self.expanded_data)
+        bb.event.fire(bb.event.BuildInit(packages), self.data)
 
         taskdata, runlist = self.buildTaskData(targets, task, self.configuration.abort)
 
@@ -1622,7 +1620,7 @@ class BBCooker:
                     self.recipecaches[mc].ignored_dependencies.add(dep)
 
             self.collection = CookerCollectFiles(self.bbfile_config_priorities)
-            (filelist, masked) = self.collection.collect_bbfiles(self.data, self.expanded_data)
+            (filelist, masked) = self.collection.collect_bbfiles(self.data, self.data)
 
             self.parser = CookerParser(self, filelist, masked)
             self.parsecache_valid = True
@@ -1656,7 +1654,7 @@ class BBCooker:
         if len(pkgs_to_build) == 0:
             raise NothingToBuild
 
-        ignore = (self.expanded_data.getVar("ASSUME_PROVIDED") or "").split()
+        ignore = (self.data.getVar("ASSUME_PROVIDED") or "").split()
         for pkg in pkgs_to_build:
             if pkg in ignore:
                 parselog.warning("Explicit target \"%s\" is in ASSUME_PROVIDED, ignoring" % pkg)
@@ -1689,13 +1687,13 @@ class BBCooker:
         try:
             self.prhost = prserv.serv.auto_start(self.data)
         except prserv.serv.PRServiceConfigError:
-            bb.event.fire(CookerExit(), self.expanded_data)
+            bb.event.fire(CookerExit(), self.data)
             self.state = state.error
         return
 
     def post_serve(self):
         prserv.serv.auto_shutdown(self.data)
-        bb.event.fire(CookerExit(), self.expanded_data)
+        bb.event.fire(CookerExit(), self.data)
         lockfile = self.lock.name
         self.lock.close()
         self.lock = None
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2ad8aad..da75021 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1341,7 +1341,7 @@ class RunQueue:
             sq_hash.append(self.rqdata.runtaskentries[tid].hash)
             sq_taskname.append(taskname)
             sq_task.append(tid)
-        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.expanded_data }
+        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
         try:
             call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=True)"
             valid = bb.utils.better_eval(call, locs)
@@ -1525,7 +1525,7 @@ class RunQueueExecute:
             pn = self.rqdata.dataCaches[mc].pkg_fn[fn]
             taskdata[dep] = [pn, taskname, fn]
         call = self.rq.depvalidate + "(task, taskdata, notneeded, d)"
-        locs = { "task" : task, "taskdata" : taskdata, "notneeded" : self.scenequeue_notneeded, "d" : self.cooker.expanded_data }
+        locs = { "task" : task, "taskdata" : taskdata, "notneeded" : self.scenequeue_notneeded, "d" : self.cooker.data }
         valid = bb.utils.better_eval(call, locs)
         return valid
 
@@ -1593,7 +1593,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 invalidtasks.append(tid)
 
             call = self.rq.setsceneverify + "(covered, tasknames, fns, d, invalidtasks=invalidtasks)"
-            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : tasknames, "fns" : fns, "d" : self.cooker.expanded_data, "invalidtasks" : invalidtasks }
+            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : tasknames, "fns" : fns, "d" : self.cooker.data, "invalidtasks" : invalidtasks }
             covered_remove = bb.utils.better_eval(call, locs)
 
         def removecoveredtask(tid):
@@ -2086,7 +2086,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 sq_taskname.append(taskname)
                 sq_task.append(tid)
             call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
-            locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.expanded_data }
+            locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
             valid = bb.utils.better_eval(call, locs)
 
             valid_new = stamppresent
-- 
2.7.4


