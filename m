Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 7BE6478846
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jan 2018 12:10:12 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w0UCABbP029016
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 30 Jan 2018 12:10:12 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1egUjr-0006hC-HD; Tue, 30 Jan 2018 12:10:11 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jan 2018 12:10:10 +0000
Message-Id: <1517314210-25684-4-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 4/4] runqueue: Rewrite and optimize recrdepends handling
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
X-List-Received-Date: Tue, 30 Jan 2018 12:10:14 -0000

This is a performance sensitive piece of code and the shear number
of recursive loops is causing a significant and unscalable performance
pain point.

This change moves to a two step approach, firstly generating a list of recursive
dependencies for any task, then applying this to the recursive tasks, iterating
over things until no further dependencies are added.

It was noticed an optimisation is possible and the list of recursive tasks need not
contain the taskname, only the base task id. This allows a significant performance
improvement and limits the size of the resursive task lists, improving speed.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 134 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 83 insertions(+), 51 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index bbfe9ee..d7acfab 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -74,9 +74,6 @@ def build_tid(mc, fn, taskname):
         return "multiconfig:" + mc + ":" + fn + ":" + taskname
     return fn + ":" + taskname
 
-def tid_replacetask(tid, taskname):
-    return tid.rsplit(":", 1)[0] + ":" + taskname
-
 class RunQueueStats:
     """
     Holds statistics on the tasks handled by the associated runQueue
@@ -670,71 +667,106 @@ class RunQueueData:
                             recursiveitasks[tid].append(newdep)
 
                 self.runtaskentries[tid].depends = depends
+                # Remove all self references
+                self.runtaskentries[tid].depends.discard(tid)
 
         #self.dump_data()
 
+        self.init_progress_reporter.next_stage()
+
         # Resolve recursive 'recrdeptask' dependencies (Part B)
         #
         # e.g. do_sometask[recrdeptask] = "do_someothertask"
         # (makes sure sometask runs after someothertask of all DEPENDS, RDEPENDS and intertask dependencies, recursively)
         # We need to do this separately since we need all of runtaskentries[*].depends to be complete before this is processed
-        self.init_progress_reporter.next_stage()
-        extradeps = True
+
+        # Generating/interating recursive lists of dependencies is painful and potentially slow
+        # Precompute recursive task dependencies here by:
+        #     a) create a temp list of reverse dependencies (revdeps)
+        #     b) walk up the ends of the chains (when a given task no longer has dependencies i.e. len(deps) == 0)
+        #     c) combine the total list of dependencies in cumulativedeps
+        #     d) optimise by pre-truncating 'task' off the items in cumulativedeps (keeps items in sets lower)
+
+
+        revdeps = {}
+        deps = {}
+        cumulativedeps = {}
+        for tid in self.runtaskentries:
+            deps[tid] = set(self.runtaskentries[tid].depends)
+            revdeps[tid] = set()
+            cumulativedeps[tid] = set()
+        # Generate a temp list of reverse dependencies
+        for tid in self.runtaskentries:
+            for dep in self.runtaskentries[tid].depends:
+                revdeps[dep].add(tid)
+        # Find the dependency chain endpoints
+        endpoints = set()
+        for tid in self.runtaskentries:
+            if len(deps[tid]) == 0:
+                endpoints.add(tid)
+        # Iterate the chains collating dependencies
+        while endpoints:
+            next = set()
+            for tid in endpoints:
+                for dep in revdeps[tid]:
+                    cumulativedeps[dep].add(fn_from_tid(tid))
+                    cumulativedeps[dep].update(cumulativedeps[tid])
+                    if tid in deps[dep]:
+                        deps[dep].remove(tid)
+                    if len(deps[dep]) == 0:
+                        next.add(dep)
+            endpoints = next
+        #for tid in deps:
+        #    if len(deps[tid]) != 0:
+        #        bb.warn("Sanity test failure, dependencies left for %s (%s)" % (tid, deps[tid]))
+
         # Loop here since recrdeptasks can depend upon other recrdeptasks and we have to
         # resolve these recursively until we aren't adding any further extra dependencies
+        extradeps = True
         while extradeps:
-            extradeps = {}
-
-            for taskcounter, tid in enumerate(recursivetasks):
-                extradeps[tid] = set()
-
+            extradeps = 0
+            for tid in recursivetasks:
                 tasknames = recursivetasks[tid]
-                seendeps = set()
-                seenbasedeps = set()
-
-                def generate_recdeps(t):
-                    newdeps = set()
-                    basetid = fn_from_tid(t)
-                    if basetid not in seenbasedeps:
-                        for taskname in tasknames:
-                            newtid = tid_replacetask(t, taskname)
-                            if newtid in self.runtaskentries and newtid not in seendeps:
-                                newdeps.add(newtid)
-                                extradeps[tid].add(newtid)
-                        seenbasedeps.add(basetid)
-                    seendeps.add(t)
-                    newdeps.add(t)
-                    for i in newdeps:
-                        if i not in self.runtaskentries:
-                            # Not all recipes might have the recrdeptask task as a task
-                            continue
-                        for n in self.runtaskentries[i].depends:
-                            if n not in seendeps:
-                                 generate_recdeps(n)
-                generate_recdeps(tid)
 
+                totaldeps = set(self.runtaskentries[tid].depends)
                 if tid in recursiveitasks:
+                    totaldeps.update(recursiveitasks[tid])
                     for dep in recursiveitasks[tid]:
-                        generate_recdeps(dep)
+                        if dep not in self.runtaskentries:
+                            continue
+                        totaldeps.update(self.runtaskentries[dep].depends)
 
-            for tid in self.runtaskentries:
-                # Add in extra dependencies
-                if tid in extradeps:
-                     extradeps[tid].difference_update(self.runtaskentries[tid].depends)
-                     self.runtaskentries[tid].depends.update(extradeps[tid])
-                     # Remove circular references so that do_a[recrdeptask] = "do_a do_b" can work
-                     self.runtaskentries[tid].depends.difference_update(recursivetasksselfref)
-                     extradeps[tid].difference_update(recursivetasksselfref)
-                     if not len(extradeps[tid]):
-                         del extradeps[tid]
-                     if tid not in recursivetasks:
-                        bb.warn(tid)
-                # Remove all self references
-                if tid in self.runtaskentries[tid].depends:
-                    logger.debug(2, "Task %s contains self reference!", tid)
-                    self.runtaskentries[tid].depends.remove(tid)
+                deps = set()
+                for dep in totaldeps:
+                    if dep in cumulativedeps:
+                        deps.update(cumulativedeps[dep])
+
+                for t in deps:
+                    for taskname in tasknames:
+                        newtid = t + ":" + taskname
+                        if newtid == tid:
+                            continue
+                        if newtid in self.runtaskentries and newtid not in self.runtaskentries[tid].depends:
+                            extradeps += 1
+                            self.runtaskentries[tid].depends.add(newtid)
 
-            bb.debug(1, "Added %s recursive dependencies in this loop" % len(extradeps))
+                # Handle recursive tasks which depend upon other recursive tasks
+                deps = set()
+                for dep in self.runtaskentries[tid].depends.intersection(recursivetasks):
+                    deps.update(self.runtaskentries[dep].depends.difference(self.runtaskentries[tid].depends))
+                for newtid in deps:
+                    for taskname in tasknames:
+                        if not newtid.endswith(":" + taskname):
+                            continue
+                        if newtid in self.runtaskentries:
+                            extradeps += 1
+                            self.runtaskentries[tid].depends.add(newtid)
+
+            bb.debug(1, "Added %s recursive dependencies in this loop" % extradeps)
+
+        # Remove recrdeptask circular references so that do_a[recrdeptask] = "do_a do_b" can work
+        for tid in self.runtaskentries:
+            self.runtaskentries[tid].depends.difference_update(recursivetasksselfref)
 
         self.init_progress_reporter.next_stage()
 
-- 
2.7.4


