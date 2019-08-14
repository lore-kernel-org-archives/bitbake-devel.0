Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
	[209.85.221.54])
	by mail.openembedded.org (Postfix) with ESMTP id 242377E6F8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 13:53:26 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id p17so111161140wrf.11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=8bOybw4W1MOl5ocULStL1TX++MthjwFaYSO6hhbzBlw=;
	b=c0IrgYttYx5TXabiO5uzQVvfzbItOozmWLViJtSSFEp9iCxqOowfE9vnN6gMO/e8ro
	X+jMQlatxN1tX9P5O97f3DTVw1LT8shb1pWXgzNCI0TZJOAxCA7RMOJp6UJpHtIjSHyb
	cKB8TrZJroS40DHTWzk4MgoPtv8Pxc1WDtmUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8bOybw4W1MOl5ocULStL1TX++MthjwFaYSO6hhbzBlw=;
	b=hosxqQicC7qevRWYxw0DpRPlnyCPZoW70uHcE2bvsu+Lg0ZFtSVhw0tVRKz7+xb2cJ
	Wc/6KO/0EpWAjKsB8Um6NokNNXcXgMfIusn8YckqkzwnegPlSKGf3ahM+/7Ajb9bjOmd
	tCznj97hfv3kS6EwF227oC0Qp6Xa6aC1j3rHNf1yY6OkmTXIUkcw9W8bIdGnZALYUNWM
	PxwUA3K3sveb8tmhVhaMehYpmcmw5CcaawnZOKVM+cWwI5phfqw430cfXzV2BB+/rXtR
	0DWBsD5ONomWUZwKHjVqM/BIgXUuv46VzzxiBkUqPCG6rYBBzsXE9NHSJpPsQcZ0xHBl
	jJFQ==
X-Gm-Message-State: APjAAAXt+rG710FyVH2I/pr5+25utICRn9TTkufGdVlEgk4h+ZdgJN5W
	BvY3R6PHHYZzIeda/hUE/1lq8yyKCGalYA==
X-Google-Smtp-Source: APXvYqwJgXiPZy0dCznlPdeobC2HeYkvLPo2g/NdnXYTBsYXg8ndZmQm7oOpQRX1QDin01j+1KMi0g==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr9604130wrp.189.1565790806469; 
	Wed, 14 Aug 2019 06:53:26 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm1859275wrr.14.2019.08.14.06.53.25
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 06:53:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 14:53:16 +0100
Message-Id: <20190814135317.28887-9-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
References: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 09/10] runqueue: Fix event timing race
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
X-List-Received-Date: Wed, 14 Aug 2019 13:53:26 -0000
Content-Transfer-Encoding: 8bit

The event from the task notifiing of hash equivalency should only be processed
when the task completes. This can otherwise result in a race where a dependent
task may run before the original task completes causing various failures.

To make this work reliably, the code had to be restructured quite a bit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py       | 141 ++++++++++++++++++++-------------------
 lib/bb/tests/runqueue.py |   4 +-
 2 files changed, 74 insertions(+), 71 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index eb8e342761..a04703c870 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1696,7 +1696,8 @@ class RunQueueExecute:
         self.sq_running = set()
         self.sq_live = set()
 
-        self.changed_setscene = set()
+        self.updated_taskhash_queue = []
+        self.pending_migrations = set()
 
         self.runq_buildable = set()
         self.runq_running = set()
@@ -1910,8 +1911,8 @@ class RunQueueExecute:
         if self.sq_deferred:
             logger.error("Scenequeue had deferred entries: %s" % pprint.pformat(self.sq_deferred))
             err = True
-        if self.changed_setscene:
-            logger.error("Scenequeue had unprocessed changed entries: %s" % pprint.pformat(self.changed_setscene))
+        if self.updated_taskhash_queue:
+            logger.error("Scenequeue had unprocessed changed taskhash entries: %s" % pprint.pformat(self.updated_taskhash_queue))
             err = True
         if self.holdoff_tasks:
             logger.error("Scenequeue had holdoff tasks: %s" % pprint.pformat(self.holdoff_tasks))
@@ -2023,7 +2024,7 @@ class RunQueueExecute:
             if self.can_start_task():
                 return True
 
-        if not self.sq_live and not self.sqdone and not self.sq_deferred and not self.changed_setscene and not self.holdoff_tasks:
+        if not self.sq_live and not self.sqdone and not self.sq_deferred and not self.updated_taskhash_queue and not self.holdoff_tasks:
             logger.info("Setscene tasks completed")
 
             err = self.summarise_scenequeue_errors()
@@ -2177,45 +2178,66 @@ class RunQueueExecute:
         #bb.note("Task %s: " % task + str(taskdepdata).replace("], ", "],\n"))
         return taskdepdata
 
-    def updated_taskhash(self, tid, unihash):
+    def update_holdofftasks(self):
+        self.holdoff_tasks = set()
+
+        for tid in self.rqdata.runq_setscene_tids:
+            if tid not in self.scenequeue_covered and tid not in self.scenequeue_notcovered:
+                self.holdoff_tasks.add(tid)
+
+        for tid in self.holdoff_tasks.copy():
+            for dep in self.sqdata.sq_covered_tasks[tid]:
+                if dep not in self.runq_complete:
+                    self.holdoff_tasks.add(dep)
+        logger.debug(2, "Holding off tasks %s" % pprint.pformat(self.holdoff_tasks))
+
+
+    def process_possible_migrations(self):
+
         changed = set()
-        if unihash != self.rqdata.runtaskentries[tid].unihash:
-            logger.info("Task %s unihash changed to %s" % (tid, unihash))
-            self.rqdata.runtaskentries[tid].unihash = unihash
-            bb.parse.siggen.set_unihash(tid, unihash)
-
-            # Work out all tasks which depend on this one
-            total = set()
-            next = set(self.rqdata.runtaskentries[tid].revdeps)
-            while next:
-                current = next.copy()
-                total = total |next
-                next = set()
-                for ntid in current:
-                    next |= self.rqdata.runtaskentries[ntid].revdeps
-                    next.difference_update(total)
-
-            # Now iterate those tasks in dependency order to regenerate their taskhash/unihash
-            done = set()
-            next = set(self.rqdata.runtaskentries[tid].revdeps)
-            while next:
-                current = next.copy()
-                next = set()
-                for tid in current:
-                    if not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
-                        continue
-                    procdep = []
-                    for dep in self.rqdata.runtaskentries[tid].depends:
-                        procdep.append(dep)
-                    orighash = self.rqdata.runtaskentries[tid].hash
-                    self.rqdata.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
-                    origuni = self.rqdata.runtaskentries[tid].unihash
-                    self.rqdata.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
-                    logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, self.rqdata.runtaskentries[tid].hash, origuni, self.rqdata.runtaskentries[tid].unihash))
-                    next |= self.rqdata.runtaskentries[tid].revdeps
-                    changed.add(tid)
-                    total.remove(tid)
-                    next.intersection_update(total)
+        for tid, unihash in self.updated_taskhash_queue.copy():
+            if tid in self.runq_running and tid not in self.runq_complete:
+                continue
+
+            self.updated_taskhash_queue.remove((tid, unihash))
+
+            if unihash != self.rqdata.runtaskentries[tid].unihash:
+                logger.info("Task %s unihash changed to %s" % (tid, unihash))
+                self.rqdata.runtaskentries[tid].unihash = unihash
+                bb.parse.siggen.set_unihash(tid, unihash)
+
+                # Work out all tasks which depend on this one
+                total = set()
+                next = set(self.rqdata.runtaskentries[tid].revdeps)
+                while next:
+                    current = next.copy()
+                    total = total |next
+                    next = set()
+                    for ntid in current:
+                        next |= self.rqdata.runtaskentries[ntid].revdeps
+                        next.difference_update(total)
+
+                # Now iterate those tasks in dependency order to regenerate their taskhash/unihash
+                done = set()
+                next = set(self.rqdata.runtaskentries[tid].revdeps)
+                while next:
+                    current = next.copy()
+                    next = set()
+                    for tid in current:
+                        if not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
+                            continue
+                        procdep = []
+                        for dep in self.rqdata.runtaskentries[tid].depends:
+                            procdep.append(dep)
+                        orighash = self.rqdata.runtaskentries[tid].hash
+                        self.rqdata.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, procdep, self.rqdata.dataCaches[mc_from_tid(tid)])
+                        origuni = self.rqdata.runtaskentries[tid].unihash
+                        self.rqdata.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
+                        logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, self.rqdata.runtaskentries[tid].hash, origuni, self.rqdata.runtaskentries[tid].unihash))
+                        next |= self.rqdata.runtaskentries[tid].revdeps
+                        changed.add(tid)
+                        total.remove(tid)
+                        next.intersection_update(total)
 
         if changed:
             for mc in self.rq.worker:
@@ -2223,7 +2245,7 @@ class RunQueueExecute:
             for mc in self.rq.fakeworker:
                 self.rq.fakeworker[mc].process.stdin.write(b"<newtaskhashes>" + pickle.dumps(bb.parse.siggen.get_taskhashes()) + b"</newtaskhashes>")
 
-        logger.debug(1, pprint.pformat("Tasks changed:\n%s" % (changed)))
+            logger.debug(1, pprint.pformat("Tasks changed:\n%s" % (changed)))
 
         for tid in changed:
             if tid not in self.rqdata.runq_setscene_tids:
@@ -2231,31 +2253,12 @@ class RunQueueExecute:
             valid = self.rq.validate_hashes(set([tid]), self.cooker.data, None, False)
             if not valid:
                 continue
-            self.changed_setscene.add(tid)
-
-        if changed:
-            self.update_holdofftasks()
-
-    def update_holdofftasks(self):
-        self.holdoff_tasks = set()
-
-        for tid in self.rqdata.runq_setscene_tids:
-            if tid not in self.scenequeue_covered and tid not in self.scenequeue_notcovered:
-                self.holdoff_tasks.add(tid)
-
-        for tid in self.holdoff_tasks.copy():
-            for dep in self.sqdata.sq_covered_tasks[tid]:
-                if dep not in self.runq_complete:
-                    self.holdoff_tasks.add(dep)
-        logger.debug(2, "Holding off tasks %s" % pprint.pformat(self.holdoff_tasks))
-
-    def process_possible_migrations(self):
-        changes = False
-        for tid in self.changed_setscene.copy():
             if tid in self.runq_running:
-                self.changed_setscene.remove(tid)
                 continue
+            if tid not in self.pending_migrations:
+                self.pending_migrations.add(tid)
 
+        for tid in self.pending_migrations.copy():
             valid = True
             # Check no tasks this covers are running
             for dep in self.sqdata.sq_covered_tasks[tid]:
@@ -2266,6 +2269,8 @@ class RunQueueExecute:
             if not valid:
                 continue
 
+            self.pending_migrations.remove(tid)
+
             if tid in self.tasks_scenequeue_done:
                 self.tasks_scenequeue_done.remove(tid)
             for dep in self.sqdata.sq_covered_tasks[tid]:
@@ -2296,10 +2301,8 @@ class RunQueueExecute:
 
             logger.info("Setscene task %s now valid and being rerun" % tid)
             self.sqdone = False
-            self.changed_setscene.remove(tid)
-            changes = True
 
-        if changes:
+        if changed:
             self.update_holdofftasks()
 
     def scenequeue_updatecounters(self, task, fail=False):
@@ -2854,7 +2857,7 @@ class runQueuePipe():
                     bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[7:index]))
                 bb.event.fire_from_worker(event, self.d)
                 if isinstance(event, taskUniHashUpdate):
-                    self.rqexec.updated_taskhash(event.taskid, event.unihash)
+                    self.rqexec.updated_taskhash_queue.append((event.taskid, event.unihash))
                 found = True
                 self.queue = self.queue[index+8:]
                 index = self.queue.find(b"</event>")
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 1103f905f9..493516355d 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -384,8 +384,8 @@ class RunQueueTests(unittest.TestCase):
             with open(tempdir + "/stamps/b1.do_install.taint", "w") as f:
                f.write("ed36d46a-2977-458a-b3de-eef885bc1817")
             cmd = ["bitbake", "e1", "-DD"]
-            sstatevalid = "e1:do_package:b710f6312ffed900b4b2761cc05538645f4ff3e7e0b70d688c70c0f3bcc2e1a2"
-            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True, slowtasks="e1:fetch")
+            sstatevalid = "e1:do_package:f9aa46d63cb63d70a09712b6bc7fab57e4966cf8e8b52ff5ad1ba23823aec7d4 e1:do_package:b710f6312ffed900b4b2761cc05538645f4ff3e7e0b70d688c70c0f3bcc2e1a2"
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv, cleanup=True, slowtasks="e1:fetch b1:install")
             expected = ['a1:package', 'a1:install', 'b1:package', 'b1:install', 'a1:populate_sysroot', 'b1:populate_sysroot',
                         'a1:package_write_ipk_setscene', 'b1:packagedata_setscene', 'b1:package_write_rpm_setscene',
                         'a1:package_write_rpm_setscene', 'b1:package_write_ipk_setscene', 'a1:packagedata_setscene',
-- 
2.20.1


