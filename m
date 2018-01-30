Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 78A1078825
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Jan 2018 12:10:12 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w0UCABOi029013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 30 Jan 2018 12:10:12 GMT
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1egUjr-0006gz-FY; Tue, 30 Jan 2018 12:10:11 +0000
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Jan 2018 12:10:07 +0000
Message-Id: <1517314210-25684-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH 1/4] runqueue: Fix recidepends handling
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

Currently we only run through the recidepends/recrdepends code once. This
means that we can miss some expansions of dependency trees where one
rec{r,i}depends tasks depends on another rec{r,i}depends task.

In reality we need to iterate over the data until we stop adding
dependencies.

In doing this we can't show quite so granular progress information since
we don't know how many times we'll need to do this.

This does slow down the runqueue prepare phase however some optimisations
are possible and can be handled in subsequent patches.

This fix means some missing dependencies, such as:

<image>:do_fetchall -> <image>:do_rootfs -> <pkgs>:do_package_write_X
  -> <ca-certs>:do_package_write_X -> debianutils-native
(via PAKAGE_WRITE_DEPS)

are now found/added.

[YOCTO #12510]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 92 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 41 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b7be102..2543d4e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -681,49 +681,59 @@ class RunQueueData:
         # e.g. do_sometask[recrdeptask] = "do_someothertask"
         # (makes sure sometask runs after someothertask of all DEPENDS, RDEPENDS and intertask dependencies, recursively)
         # We need to do this separately since we need all of runtaskentries[*].depends to be complete before this is processed
-        self.init_progress_reporter.next_stage(len(recursivetasks))
-        extradeps = {}
-        for taskcounter, tid in enumerate(recursivetasks):
-            extradeps[tid] = set(self.runtaskentries[tid].depends)
-
-            tasknames = recursivetasks[tid]
-            seendeps = set()
-
-            def generate_recdeps(t):
-                newdeps = set()
-                (mc, fn, taskname, _) = split_tid_mcfn(t)
-                add_resolved_dependencies(mc, fn, tasknames, newdeps)
-                extradeps[tid].update(newdeps)
-                seendeps.add(t)
-                newdeps.add(t)
-                for i in newdeps:
-                    if i not in self.runtaskentries:
-                        # Not all recipes might have the recrdeptask task as a task
-                        continue
-                    task = self.runtaskentries[i].task
-                    for n in self.runtaskentries[i].depends:
-                        if n not in seendeps:
-                             generate_recdeps(n)
-            generate_recdeps(tid)
-
-            if tid in recursiveitasks:
-                for dep in recursiveitasks[tid]:
-                    generate_recdeps(dep)
-            self.init_progress_reporter.update(taskcounter)
+        self.init_progress_reporter.next_stage()
+        extradeps = True
+        # Loop here since recrdeptasks can depend upon other recrdeptasks and we have to
+        # resolve these recursively until we aren't adding any further extra dependencies
+        while extradeps:
+            extradeps = {}
+
+            for taskcounter, tid in enumerate(recursivetasks):
+                extradeps[tid] = set(self.runtaskentries[tid].depends)
+
+                tasknames = recursivetasks[tid]
+                seendeps = set()
+
+                def generate_recdeps(t):
+                    newdeps = set()
+                    (mc, fn, taskname, _) = split_tid_mcfn(t)
+                    add_resolved_dependencies(mc, fn, tasknames, newdeps)
+                    extradeps[tid].update(newdeps)
+                    seendeps.add(t)
+                    newdeps.add(t)
+                    for i in newdeps:
+                        if i not in self.runtaskentries:
+                            # Not all recipes might have the recrdeptask task as a task
+                            continue
+                        task = self.runtaskentries[i].task
+                        for n in self.runtaskentries[i].depends:
+                            if n not in seendeps:
+                                 generate_recdeps(n)
+                generate_recdeps(tid)
 
-        # Remove circular references so that do_a[recrdeptask] = "do_a do_b" can work
-        for tid in recursivetasks:
-            extradeps[tid].difference_update(recursivetasksselfref)
+                if tid in recursiveitasks:
+                    for dep in recursiveitasks[tid]:
+                        generate_recdeps(dep)
 
-        for tid in self.runtaskentries:
-            task = self.runtaskentries[tid].task
-            # Add in extra dependencies
-            if tid in extradeps:
-                 self.runtaskentries[tid].depends = extradeps[tid]
-            # Remove all self references
-            if tid in self.runtaskentries[tid].depends:
-                logger.debug(2, "Task %s contains self reference!", tid)
-                self.runtaskentries[tid].depends.remove(tid)
+            for tid in self.runtaskentries:
+                task = self.runtaskentries[tid].task
+                # Add in extra dependencies
+                if tid in extradeps:
+                     extradeps[tid].difference_update(self.runtaskentries[tid].depends)
+                     self.runtaskentries[tid].depends.update(extradeps[tid])
+                     # Remove circular references so that do_a[recrdeptask] = "do_a do_b" can work
+                     self.runtaskentries[tid].depends.difference_update(recursivetasksselfref)
+                     extradeps[tid].difference_update(recursivetasksselfref)
+                     if not len(extradeps[tid]):
+                         del extradeps[tid]
+                     if tid not in recursivetasks:
+                        bb.warn(tid)
+                # Remove all self references
+                if tid in self.runtaskentries[tid].depends:
+                    logger.debug(2, "Task %s contains self reference!", tid)
+                    self.runtaskentries[tid].depends.remove(tid)
+
+            bb.debug(1, "Added %s recursive dependencies in this loop" % len(extradeps))
 
         self.init_progress_reporter.next_stage()
 
-- 
2.7.4


