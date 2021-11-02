Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080DEC433EF
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 14:57:46 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web12.930.1635865065151467615
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:57:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Nr8BJ0gL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id
 77-20020a1c0450000000b0033123de3425so2218540wme.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7bIiIjj7XRyvIgRH59hhSHt09mzTiBSfoghtMqdNKo=;
        b=Nr8BJ0gLFsrlh/IGUtg4PzksENSGRBeD5CEpAa73aIcbVQJFP90HZNKlBy+OV7uUVc
         Ix+2GOolpbSy9JPESe3S6IHILGmpfyfCWXRNPCIa69AdkFPTxTKOxHhxlGefMlK5aKqu
         HSarIe4zQfz+5/bSrYH3GHfnppAMzY4+OwTEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E7bIiIjj7XRyvIgRH59hhSHt09mzTiBSfoghtMqdNKo=;
        b=wgOtyijZe8Of7+mG3ZHCYau6ZllIO1JyWRX0ob8Bga/nVv6X++hoHFoY7fQIr5e85k
         eWwR6qX14FwhYaajDRyOc8p7OmKqtVIY8VODNHqd70ouWHAGW4UlAaacqGgDKdw0tf2D
         Ebn8vkBOdBeLD7nGoE1WYN13Ui9skRwggePvf7DM9r0NtOHrx7+BdylJ5D5Bat22dkkE
         3lSw8i5JgrKNDRhudl+t/cAl5mwJahRndf6dye7XWz/rm/z7rk3VxIxDBJEyNxOVLj7R
         jai+Z6x0gNKVXt47B1cbgiBCadfa+A8QRuR9g5AsIOjn3eQU1mCeXFKZTvaW8eugVLzy
         27WQ==
X-Gm-Message-State: AOAM530QGsec63dBJvueJqrM4HPrAAbVeeogTvZg3GZ4peg4L5ngKlxH
	KoFUOve223UpGUhpzRrmVO3G7gXEhQSRfg==
X-Google-Smtp-Source: 
 ABdhPJwrGHflmyhRcgrPHJt4ytoCx1e/pC3mV5j30no2m/3fbFiaTewfV85VzWFyzOZPJBUq527+NQ==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr7798264wmj.36.1635865063043;
        Tue, 02 Nov 2021 07:57:43 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:e05:60cd:475e:19f5])
        by smtp.gmail.com with ESMTPSA id
 q26sm14916634wrc.39.2021.11.02.07.57.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 07:57:42 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/5] lib/bb: Clean up use of len()
Date: Tue,  2 Nov 2021 14:57:38 +0000
Message-Id: <20211102145742.3550251-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 14:57:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12863

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-diffsigs         |  4 +--
 lib/bb/cooker.py             |  6 ++--
 lib/bb/cookerdata.py         |  2 +-
 lib/bb/fetch2/__init__.py    |  4 +--
 lib/bb/fetch2/gitsm.py       |  2 +-
 lib/bb/runqueue.py           | 66 ++++++++++++++++++------------------
 lib/bb/taskdata.py           |  4 +--
 lib/bb/ui/buildinfohelper.py | 20 +++++------
 lib/bb/ui/uievent.py         |  4 +--
 9 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 6646dccdfa..cf4cc706a2 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -60,7 +60,7 @@ def find_siginfo_task(bbhandler, pn, taskname, sig1=None, sig2=None):
 
     if sig1 and sig2:
         sigfiles = find_siginfo(bbhandler, pn, taskname, [sig1, sig2])
-        if len(sigfiles) == 0:
+        if not sigfiles:
             logger.error('No sigdata files found matching %s %s matching either %s or %s' % (pn, taskname, sig1, sig2))
             sys.exit(1)
         elif not sig1 in sigfiles:
@@ -86,7 +86,7 @@ def recursecb(key, hash1, hash2):
     hashfiles = find_siginfo(tinfoil, key, None, hashes)
 
     recout = []
-    if len(hashfiles) == 0:
+    if not hashfiles:
         recout.append("Unable to find matching sigdata for %s with hashes %s or %s" % (key, hash1, hash2))
     elif not hash1 in hashfiles:
         recout.append("Unable to find matching sigdata for %s with hash %s" % (key, hash1))
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index af794b4c42..194595ce8b 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1656,7 +1656,7 @@ class BBCooker:
         # Return a copy, don't modify the original
         pkgs_to_build = pkgs_to_build[:]
 
-        if len(pkgs_to_build) == 0:
+        if not pkgs_to_build:
             raise NothingToBuild
 
         ignore = (self.data.getVar("ASSUME_PROVIDED") or "").split()
@@ -1795,10 +1795,10 @@ class CookerCollectFiles(object):
         files.sort( key=lambda fileitem: self.calc_bbfile_priority(fileitem)[0] )
         config.setVar("BBFILES_PRIORITIZED", " ".join(files))
 
-        if not len(files):
+        if not files:
             files = self.get_bbfiles()
 
-        if not len(files):
+        if not files:
             collectlog.error("no recipe files to build, check your BBPATH and BBFILES?")
             bb.event.fire(CookerExit(), eventdata)
 
diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index ba657c03b6..592bc2968e 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -86,7 +86,7 @@ class ConfigParameters(object):
                 action['msg'] = "Only one target can be used with the --environment option."
             elif self.options.buildfile and len(self.options.pkgs_to_build) > 0:
                 action['msg'] = "No target should be used with the --environment and --buildfile options."
-            elif len(self.options.pkgs_to_build) > 0:
+            elif self.options.pkgs_to_build:
                 action['action'] = ["showEnvironmentTarget", self.options.pkgs_to_build]
             else:
                 action['action'] = ["showEnvironment", self.options.buildfile]
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 000b49a500..1d6e4e0964 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -770,7 +770,7 @@ def get_srcrev(d, method_name='sortable_revision'):
         if urldata[u].method.supports_srcrev():
             scms.append(u)
 
-    if len(scms) == 0:
+    if not scms:
         raise FetchError("SRCREV was used yet no valid SCM was found in SRC_URI")
 
     if len(scms) == 1 and len(urldata[scms[0]].names) == 1:
@@ -1636,7 +1636,7 @@ class Fetch(object):
         if localonly and cache:
             raise Exception("bb.fetch2.Fetch.__init__: cannot set cache and localonly at same time")
 
-        if len(urls) == 0:
+        if not urls:
             urls = d.getVar("SRC_URI").split()
         self.urls = urls
         self.d = d
diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index a7110a988d..c5c23d5260 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -163,7 +163,7 @@ class GitSM(Git):
         else:
             self.process_submodules(ud, ud.clonedir, need_update_submodule, d)
 
-        if len(need_update_list) > 0:
+        if need_update_list:
             logger.debug('gitsm: Submodules requiring update: %s' % (' '.join(need_update_list)))
             return True
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 10511a09dc..87c00462c1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -547,7 +547,7 @@ class RunQueueData:
                         next_points.append(revdep)
                         task_done[revdep] = True
             endpoints = next_points
-            if len(next_points) == 0:
+            if not next_points:
                 break
 
         # Circular dependency sanity check
@@ -589,7 +589,7 @@ class RunQueueData:
 
         found = False
         for mc in self.taskData:
-            if len(taskData[mc].taskentries) > 0:
+            if taskData[mc].taskentries:
                 found = True
                 break
         if not found:
@@ -773,7 +773,7 @@ class RunQueueData:
         # Find the dependency chain endpoints
         endpoints = set()
         for tid in self.runtaskentries:
-            if len(deps[tid]) == 0:
+            if not deps[tid]:
                 endpoints.add(tid)
         # Iterate the chains collating dependencies
         while endpoints:
@@ -784,11 +784,11 @@ class RunQueueData:
                     cumulativedeps[dep].update(cumulativedeps[tid])
                     if tid in deps[dep]:
                         deps[dep].remove(tid)
-                    if len(deps[dep]) == 0:
+                    if not deps[dep]:
                         next.add(dep)
             endpoints = next
         #for tid in deps:
-        #    if len(deps[tid]) != 0:
+        #    if deps[tid]:
         #        bb.warn("Sanity test failure, dependencies left for %s (%s)" % (tid, deps[tid]))
 
         # Loop here since recrdeptasks can depend upon other recrdeptasks and we have to
@@ -958,7 +958,7 @@ class RunQueueData:
                     delcount[tid] = self.runtaskentries[tid]
                     del self.runtaskentries[tid]
 
-            if len(self.runtaskentries) == 0:
+            if not self.runtaskentries:
                 bb.msg.fatal("RunQueue", "Could not find any tasks with the tasknames %s to run within the recipes of the taskgraphs of the targets %s" % (str(self.cooker.configuration.runall), str(self.targets)))
 
         self.init_progress_reporter.next_stage()
@@ -983,7 +983,7 @@ class RunQueueData:
                     delcount[tid] = self.runtaskentries[tid]
                     del self.runtaskentries[tid]
 
-            if len(self.runtaskentries) == 0:
+            if not self.runtaskentries:
                 bb.msg.fatal("RunQueue", "Could not find any tasks with the tasknames %s to run within the taskgraphs of the targets %s" % (str(self.cooker.configuration.runonly), str(self.targets)))
 
         #
@@ -991,7 +991,7 @@ class RunQueueData:
         #
 
         # Check to make sure we still have tasks to run
-        if len(self.runtaskentries) == 0:
+        if not self.runtaskentries:
             if not taskData[''].abort:
                 bb.msg.fatal("RunQueue", "All buildable tasks have been run but the build is incomplete (--continue mode). Errors for the tasks that failed will have been printed above.")
             else:
@@ -1015,7 +1015,7 @@ class RunQueueData:
         endpoints = []
         for tid in self.runtaskentries:
             revdeps = self.runtaskentries[tid].revdeps
-            if len(revdeps) == 0:
+            if not revdeps:
                 endpoints.append(tid)
             for dep in revdeps:
                 if dep in self.runtaskentries[tid].depends:
@@ -1188,9 +1188,9 @@ class RunQueueData:
         # Iterate over the task list and call into the siggen code
         dealtwith = set()
         todeal = set(self.runtaskentries)
-        while len(todeal) > 0:
+        while todeal:
             for tid in todeal.copy():
-                if len(self.runtaskentries[tid].depends - dealtwith) == 0:
+                if not (self.runtaskentries[tid].depends - dealtwith):
                     dealtwith.add(tid)
                     todeal.remove(tid)
                     self.prepare_task_hash(tid)
@@ -1500,10 +1500,10 @@ class RunQueue:
             self.rqexe = RunQueueExecute(self)
 
             # If we don't have any setscene functions, skip execution
-            if len(self.rqdata.runq_setscene_tids) == 0:
+            if not self.rqdata.runq_setscene_tids:
                 logger.info('No setscene tasks')
                 for tid in self.rqdata.runtaskentries:
-                    if len(self.rqdata.runtaskentries[tid].depends) == 0:
+                    if not self.rqdata.runtaskentries[tid].depends:
                         self.rqexe.setbuildable(tid)
                     self.rqexe.tasks_notcovered.add(tid)
                 self.rqexe.sqdone = True
@@ -1780,7 +1780,7 @@ class RunQueueExecute:
             bb.fatal("Invalid scheduler '%s'.  Available schedulers: %s" %
                      (self.scheduler, ", ".join(obj.name for obj in schedulers)))
 
-        #if len(self.rqdata.runq_setscene_tids) > 0:
+        #if self.rqdata.runq_setscene_tids:
         self.sqdata = SQData()
         build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
 
@@ -1821,7 +1821,7 @@ class RunQueueExecute:
                 # worker must have died?
                 pass
 
-        if len(self.failed_tids) != 0:
+        if self.failed_tids:
             self.rq.state = runQueueFailed
             return
 
@@ -1837,7 +1837,7 @@ class RunQueueExecute:
             self.rq.read_workers()
             return self.rq.active_fds()
 
-        if len(self.failed_tids) != 0:
+        if self.failed_tids:
             self.rq.state = runQueueFailed
             return True
 
@@ -2001,7 +2001,7 @@ class RunQueueExecute:
             if x not in self.tasks_scenequeue_done:
                 logger.error("Task %s was never processed by the setscene code" % x)
                 err = True
-            if len(self.rqdata.runtaskentries[x].depends) == 0 and x not in self.runq_buildable:
+            if not self.rqdata.runtaskentries[x].depends and x not in self.runq_buildable:
                 logger.error("Task %s was never marked as buildable by the setscene code" % x)
                 err = True
         return err
@@ -2025,7 +2025,7 @@ class RunQueueExecute:
             # Find the next setscene to run
             for nexttask in self.sorted_setscene_tids:
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values():
-                    if nexttask not in self.sqdata.unskippable and len(self.sqdata.sq_revdeps[nexttask]) > 0 and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
+                    if nexttask not in self.sqdata.unskippable and self.sqdata.sq_revdeps[nexttask] and self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and self.check_dependencies(nexttask, self.sqdata.sq_revdeps[nexttask]):
                         if nexttask not in self.rqdata.target_tids:
                             logger.debug2("Skipping setscene for task %s" % nexttask)
                             self.sq_task_skip(nexttask)
@@ -2189,7 +2189,7 @@ class RunQueueExecute:
             if self.can_start_task():
                 return True
 
-        if self.stats.active > 0 or len(self.sq_live) > 0:
+        if self.stats.active > 0 or self.sq_live:
             self.rq.read_workers()
             return self.rq.active_fds()
 
@@ -2201,7 +2201,7 @@ class RunQueueExecute:
                 self.sq_task_failoutright(tid)
             return True
 
-        if len(self.failed_tids) != 0:
+        if self.failed_tids:
             self.rq.state = runQueueFailed
             return True
 
@@ -2280,7 +2280,7 @@ class RunQueueExecute:
         covered.intersection_update(self.tasks_scenequeue_done)
 
         for tid in notcovered | covered:
-            if len(self.rqdata.runtaskentries[tid].depends) == 0:
+            if not self.rqdata.runtaskentries[tid].depends:
                 self.setbuildable(tid)
             elif self.rqdata.runtaskentries[tid].depends.issubset(self.runq_complete):
                  self.setbuildable(tid)
@@ -2339,7 +2339,7 @@ class RunQueueExecute:
         # Now iterate those tasks in dependency order to regenerate their taskhash/unihash
         next = set()
         for p in total:
-            if len(self.rqdata.runtaskentries[p].depends) == 0:
+            if not self.rqdata.runtaskentries[p].depends:
                 next.add(p)
             elif self.rqdata.runtaskentries[p].depends.isdisjoint(total):
                 next.add(p)
@@ -2349,7 +2349,7 @@ class RunQueueExecute:
             current = next.copy()
             next = set()
             for tid in current:
-                if len(self.rqdata.runtaskentries[p].depends) and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
+                if self.rqdata.runtaskentries[p].depends and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
                 orighash = self.rqdata.runtaskentries[tid].hash
                 dc = bb.parse.siggen.get_data_caches(self.rqdata.dataCaches, mc_from_tid(tid))
@@ -2436,7 +2436,7 @@ class RunQueueExecute:
             if not harddepfail and self.sqdata.sq_revdeps[tid].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
                 if tid not in self.sq_buildable:
                     self.sq_buildable.add(tid)
-            if len(self.sqdata.sq_revdeps[tid]) == 0:
+            if not self.sqdata.sq_revdeps[tid]:
                 self.sq_buildable.add(tid)
 
             if tid in self.sqdata.outrightfail:
@@ -2652,7 +2652,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     for tid in rqdata.runtaskentries:
         sq_revdeps[tid] = copy.copy(rqdata.runtaskentries[tid].revdeps)
         sq_revdeps_squash[tid] = set()
-        if (len(sq_revdeps[tid]) == 0) and tid not in rqdata.runq_setscene_tids:
+        if not sq_revdeps[tid] and tid not in rqdata.runq_setscene_tids:
             #bb.warn("Added endpoint %s" % (tid))
             endpoints[tid] = set()
 
@@ -2693,9 +2693,9 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                     sq_revdeps[dep].remove(point)
                 if tasks:
                     sq_revdeps_squash[dep] |= tasks
-                if len(sq_revdeps[dep]) == 0 and dep not in rqdata.runq_setscene_tids:
+                if not sq_revdeps[dep] and dep not in rqdata.runq_setscene_tids:
                     newendpoints[dep] = task
-        if len(newendpoints) != 0:
+        if newendpoints:
             process_endpoints(newendpoints)
 
     process_endpoints(endpoints)
@@ -2707,7 +2707,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     # Take the build endpoints (no revdeps) and find the sstate tasks they depend upon
     new = True
     for tid in rqdata.runtaskentries:
-        if len(rqdata.runtaskentries[tid].revdeps) == 0:
+        if not rqdata.runtaskentries[tid].revdeps:
             sqdata.unskippable.add(tid)
     sqdata.unskippable |= sqrq.cantskip
     while new:
@@ -2716,7 +2716,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
         for tid in sorted(orig, reverse=True):
             if tid in rqdata.runq_setscene_tids:
                 continue
-            if len(rqdata.runtaskentries[tid].depends) == 0:
+            if not rqdata.runtaskentries[tid].depends:
                 # These are tasks which have no setscene tasks in their chain, need to mark as directly buildable
                 sqrq.setbuildable(tid)
             sqdata.unskippable |= rqdata.runtaskentries[tid].depends
@@ -2731,7 +2731,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     for taskcounter, tid in enumerate(rqdata.runtaskentries):
         if tid in rqdata.runq_setscene_tids:
             pass
-        elif len(sq_revdeps_squash[tid]) != 0:
+        elif sq_revdeps_squash[tid]:
             bb.msg.fatal("RunQueue", "Something went badly wrong during scenequeue generation, aborting. Please report this problem.")
         else:
             del sq_revdeps_squash[tid]
@@ -2796,7 +2796,7 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
     sqdata.multiconfigs = set()
     for tid in sqdata.sq_revdeps:
         sqdata.multiconfigs.add(mc_from_tid(tid))
-        if len(sqdata.sq_revdeps[tid]) == 0:
+        if not sqdata.sq_revdeps[tid]:
             sqrq.sq_buildable.add(tid)
 
     rqdata.init_progress_reporter.finish()
@@ -3050,7 +3050,7 @@ class runQueuePipe():
                 raise
         end = len(self.queue)
         found = True
-        while found and len(self.queue):
+        while found and self.queue:
             found = False
             index = self.queue.find(b"</event>")
             while index != -1 and self.queue.startswith(b"<event>"):
@@ -3088,7 +3088,7 @@ class runQueuePipe():
     def close(self):
         while self.read():
             continue
-        if len(self.queue) > 0:
+        if self.queue:
             print("Warning, worker left partial message: %s" % self.queue)
         self.input.close()
 
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 47bad6d1fa..7bfcdb8414 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -451,12 +451,12 @@ class TaskData:
         for target in self.build_targets:
             if fn in self.build_targets[target]:
                 self.build_targets[target].remove(fn)
-                if len(self.build_targets[target]) == 0:
+                if not self.build_targets[target]:
                     self.remove_buildtarget(target, missing_list)
         for target in self.run_targets:
             if fn in self.run_targets[target]:
                 self.run_targets[target].remove(fn)
-                if len(self.run_targets[target]) == 0:
+                if not self.run_targets[target]:
                     self.remove_runtarget(target, missing_list)
 
     def remove_buildtarget(self, target, missing_list=None):
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 43aa592842..8588849dd4 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -483,11 +483,11 @@ class ORMWrapper(object):
 
             # we already created the root directory, so ignore any
             # entry for it
-            if len(path) == 0:
+            if not path:
                 continue
 
             parent_path = "/".join(path.split("/")[:len(path.split("/")) - 1])
-            if len(parent_path) == 0:
+            if not parent_path:
                 parent_path = "/"
             parent_obj = self._cached_get(Target_File, target = target_obj, path = parent_path, inodetype = Target_File.ITYPE_DIRECTORY)
             tf_obj = Target_File.objects.create(
@@ -633,7 +633,7 @@ class ORMWrapper(object):
                         packagefile_objects.append(Package_File( package = packagedict[p]['object'],
                             path = targetpath,
                             size = targetfilesize))
-                    if len(packagefile_objects):
+                    if packagefile_objects:
                         Package_File.objects.bulk_create(packagefile_objects)
                 except KeyError as e:
                     errormsg += "  stpi: Key error, package %s key %s \n" % ( p, e )
@@ -673,7 +673,7 @@ class ORMWrapper(object):
                     logger.warning("Could not add dependency to the package %s "
                                    "because %s is an unknown package", p, px)
 
-        if len(packagedeps_objs) > 0:
+        if packagedeps_objs:
             Package_Dependency.objects.bulk_create(packagedeps_objs)
         else:
             logger.info("No package dependencies created")
@@ -767,7 +767,7 @@ class ORMWrapper(object):
             packagefile_objects.append(Package_File( package = bp_object,
                                         path = path,
                                         size = package_info['FILES_INFO'][path] ))
-        if len(packagefile_objects):
+        if packagefile_objects:
             Package_File.objects.bulk_create(packagefile_objects)
 
         def _po_byname(p):
@@ -809,7 +809,7 @@ class ORMWrapper(object):
                 packagedeps_objs.append(Package_Dependency(  package = bp_object,
                     depends_on = _po_byname(p), dep_type = Package_Dependency.TYPE_RCONFLICTS))
 
-        if len(packagedeps_objs) > 0:
+        if packagedeps_objs:
             Package_Dependency.objects.bulk_create(packagedeps_objs)
 
         return bp_object
@@ -826,7 +826,7 @@ class ORMWrapper(object):
                     desc = vardump[root_var]['doc']
             if desc is None:
                 desc = ''
-            if len(desc):
+            if desc:
                 HelpText.objects.get_or_create(build=build_obj,
                                                area=HelpText.VARIABLE,
                                                key=k, text=desc)
@@ -846,7 +846,7 @@ class ORMWrapper(object):
                                 file_name = vh['file'],
                                 line_number = vh['line'],
                                 operation = vh['op']))
-                if len(varhist_objects):
+                if varhist_objects:
                     VariableHistory.objects.bulk_create(varhist_objects)
 
 
@@ -1069,7 +1069,7 @@ class BuildInfoHelper(object):
         for t in self.internal_state['targets']:
             buildname = self.internal_state['build'].build_name
             pe, pv = task_object.recipe.version.split(":",1)
-            if len(pe) > 0:
+            if pe:
                 package = task_object.recipe.name + "-" + pe + "_" + pv
             else:
                 package = task_object.recipe.name + "-" + pv
@@ -1618,7 +1618,7 @@ class BuildInfoHelper(object):
 
         if 'backlog' in self.internal_state:
             # if we have a backlog of events, do our best to save them here
-            if len(self.internal_state['backlog']):
+            if self.internal_state['backlog']:
                 tempevent = self.internal_state['backlog'].pop()
                 logger.debug("buildinfohelper: Saving stored event %s "
                              % tempevent)
diff --git a/lib/bb/ui/uievent.py b/lib/bb/ui/uievent.py
index 8607d0523b..e19c770bc9 100644
--- a/lib/bb/ui/uievent.py
+++ b/lib/bb/ui/uievent.py
@@ -73,13 +73,13 @@ class BBUIEventQueue:
 
         self.eventQueueLock.acquire()
 
-        if len(self.eventQueue) == 0:
+        if not self.eventQueue:
             self.eventQueueLock.release()
             return None
 
         item = self.eventQueue.pop(0)
 
-        if len(self.eventQueue) == 0:
+        if not self.eventQueue:
             self.eventQueueNotify.clear()
 
         self.eventQueueLock.release()
-- 
2.32.0


