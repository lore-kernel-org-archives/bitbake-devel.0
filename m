Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
	[209.85.221.53])
	by mail.openembedded.org (Postfix) with ESMTP id 9CB527F318
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Aug 2019 15:20:55 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id n9so77690243wru.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Aug 2019 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=ZnUagrPBtg59gD0Mt3Lf2A53cgfqil5iWpwzg1XvGsA=;
	b=dnG51zMkt+EFG5iizHq+35bcvIcP0iWScyLvKvz+94SCQFj8yR9hhlbBdh14p0VZ47
	5n+KEFKREpNG2iYwBFsjE71cj/W8mNgqzXARnXeV4uVuehuK/wTcYugXNb/o4i1JaSKW
	7QFS+wXH2AXTSeZjobZVRFXJKfJgw3QCtBkbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ZnUagrPBtg59gD0Mt3Lf2A53cgfqil5iWpwzg1XvGsA=;
	b=TTu8LKBwIMA4MYP0irH2pWWQEMJG5KUvhIC2h30/XHPf5FKWIbsk2tESGIUC3ZtatU
	AkqmPLQKqi4L2KHO7YpiU2yBV4tAOMm+VHnuTUlwHJlY2S0dTqkbAyXH8ZT78bWOuwu6
	gmElR+GZGgPbduBBcLyYoiTQTVl7LcbntC1LtBzhTNgvCIK0ZVOS7qzifpkc9VeVT/I/
	56jd4bZrpc7cgJcx44Sh+5rc0OKNTRpalWfQiYNdGZYP2DWdevMNyOXCMoGci1YCcR/a
	PNNmN7ETSxPE0O+ikquEv87VCwspyqPNYmqO/7cYlH3Kq0rzkruKt6gFaAuAMGqexPk9
	d/7w==
X-Gm-Message-State: APjAAAWYdaKaZuVtMLUbGGaNfXpxmYxk9uSRXPdkhkdH22lDTrtdUjCW
	/5TTpkP5KYAG0sL9R0WjV7tvPuO3YiI=
X-Google-Smtp-Source: APXvYqwzggoOJ6DCYjyssKgERqKTzV2jM2QcqDbt337qhCmRvv23+RenTDVmhW/IWQ987TxvWTktAA==
X-Received: by 2002:adf:ce03:: with SMTP id p3mr6782903wrn.94.1564759255917;
	Fri, 02 Aug 2019 08:20:55 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	p14sm62491785wrx.17.2019.08.02.08.20.54
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 02 Aug 2019 08:20:55 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Aug 2019 16:20:39 +0100
Message-Id: <20190802152049.16529-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
References: <20190802152049.16529-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 06/16] runqueue: Enable dynamic task adjustment to hash equivalency
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
X-List-Received-Date: Fri, 02 Aug 2019 15:20:56 -0000
Content-Transfer-Encoding: 8bit

There is a compelling usecase for tasks being able to notify runqueue
that their "unihash" has changed. When this is recieved, the hashes of
all subsequent tasks should be recomputed and their new hashes checked
against existing setscene validity. Any newly available setscene tasks
should then be executed.

Making this work effectively needs several pieces. An event is added
which the cooker listen for. If a new hash becomes available it can
send an event to notify of this.

When such an event is seen, hash recomputations are made. A setscene
task can't be run until all the tasks it "covers" are stopped. The
notion of "holdoff" tasks is therefore added, these are removed from
the buildable list with the assumption that some setscene task will
run and cover them.

The workers need to be notified when taskhashes change to update their
own internal siggen data stores. A new worker command is added to do this
which will affect all newly spawned worker processes from that worker.

An example workflow which tests this code is:

Configuration:
BB_SIGNATURE_HANDLER = "OEEquivHash"
SSTATE_HASHEQUIV_SERVER = "http://localhost:8686"

$ bitbake-hashserv &
$ bitbake automake-native
$ bitbake autoconf-native automake-native -c clean
$ bitbake m4-native -c install -f
$ bitbake automake-native

with the test being whether automake-native is installed from sstate.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker |   6 ++
 lib/bb/runqueue.py | 163 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 160 insertions(+), 9 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index f63f060c57..3e502d5ca9 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -234,6 +234,8 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
                     the_data.setVar(varname, value)
 
                 bb.parse.siggen.set_taskdata(workerdata["sigdata"])
+                if "newhashes" in workerdata:
+                    bb.parse.siggen.set_taskhashes(workerdata["newhashes"])
                 ret = 0
 
                 the_data = bb_cache.loadDataFull(fn, appends)
@@ -377,6 +379,7 @@ class BitbakeWorker(object):
                 self.handle_item(b"cookerconfig", self.handle_cookercfg)
                 self.handle_item(b"extraconfigdata", self.handle_extraconfigdata)
                 self.handle_item(b"workerdata", self.handle_workerdata)
+                self.handle_item(b"newtaskhashes", self.handle_newtaskhashes)
                 self.handle_item(b"runtask", self.handle_runtask)
                 self.handle_item(b"finishnow", self.handle_finishnow)
                 self.handle_item(b"ping", self.handle_ping)
@@ -416,6 +419,9 @@ class BitbakeWorker(object):
         for mc in self.databuilder.mcdata:
             self.databuilder.mcdata[mc].setVar("PRSERV_HOST", self.workerdata["prhost"])
 
+    def handle_newtaskhashes(self, data):
+        self.workerdata["newhashes"] = pickle.loads(data)
+
     def handle_ping(self, _):
         workerlog_write("Handling ping\n")
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 519561c231..5b44df8188 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -149,7 +149,7 @@ class RunQueueScheduler(object):
         Return the id of the first task we find that is buildable
         """
         self.buildable = [x for x in self.buildable if x not in self.rq.runq_running]
-        buildable = [x for x in self.buildable if (x in self.rq.tasks_covered or x in self.rq.tasks_notcovered)]
+        buildable = [x for x in self.buildable if (x in self.rq.tasks_covered or x in self.rq.tasks_notcovered) and x not in self.rq.holdoff_tasks]
         if not buildable:
             return None
 
@@ -206,6 +206,9 @@ class RunQueueScheduler(object):
     def newbuildable(self, task):
         self.buildable.append(task)
 
+    def removebuildable(self, task):
+        self.buildable.remove(task)
+
     def describe_task(self, taskid):
         result = 'ID %s' % taskid
         if self.rev_prio_map:
@@ -1719,6 +1722,8 @@ class RunQueueExecute:
         self.sq_running = set()
         self.sq_live = set()
 
+        self.changed_setscene = set()
+
         self.runq_buildable = set()
         self.runq_running = set()
         self.runq_complete = set()
@@ -1730,6 +1735,7 @@ class RunQueueExecute:
 
         self.stampcache = {}
 
+        self.holdoff_tasks = set()
         self.sqdone = False
 
         self.stats = RunQueueStats(len(self.rqdata.runtaskentries))
@@ -1925,6 +1931,7 @@ class RunQueueExecute:
         """
 
         self.rq.read_workers()
+        self.process_possible_migrations()
 
         task = None
         if not self.sqdone and self.can_start_task():
@@ -2007,7 +2014,7 @@ class RunQueueExecute:
             if self.can_start_task():
                 return True
 
-        if not self.sq_live and not self.sqdone and not self.sq_deferred:
+        if not self.sq_live and not self.sqdone and not self.sq_deferred and not self.changed_setscene and not self.holdoff_tasks:
             logger.info("Setscene tasks completed")
             logger.debug(1, 'We could skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
 
@@ -2167,6 +2174,131 @@ class RunQueueExecute:
         #bb.note("Task %s: " % task + str(taskdepdata).replace("], ", "],\n"))
         return taskdepdata
 
+    def updated_taskhash(self, tid, unihash):
+        changed = set()
+        if unihash != self.rqdata.runtaskentries[tid].unihash:
+            logger.info("Task %s unihash changed to %s" % (tid, unihash))
+            self.rqdata.runtaskentries[tid].unihash = unihash
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+            bb.parse.siggen.set_unihash(taskfn + "." + taskname, unihash)
+
+            # Work out all tasks which depend on this one
+            total = set()
+            next = set(self.rqdata.runtaskentries[tid].revdeps)
+            while next:
+                current = next.copy()
+                total = total |next
+                next = set()
+                for ntid in current:
+                    next |= self.rqdata.runtaskentries[ntid].revdeps
+                    next.difference_update(total)
+
+            # Now iterate those tasks in dependency order to regenerate their taskhash/unihash
+            done = set()
+            next = set(self.rqdata.runtaskentries[tid].revdeps)
+            while next:
+                current = next.copy()
+                next = set()
+                for tid in current:
+                    if not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
+                        continue
+                    procdep = []
+                    for dep in self.rqdata.runtaskentries[tid].depends:
+                        procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
+                    (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+                    orighash = self.rqdata.runtaskentries[tid].hash
+                    self.rqdata.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.rqdata.dataCaches[mc])
+                    origuni = self.rqdata.runtaskentries[tid].unihash
+                    self.rqdata.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(taskfn + "." + taskname)
+                    logger.debug(1, "Task %s hash changes: %s->%s %s->%s" % (tid, orighash, self.rqdata.runtaskentries[tid].hash, origuni, self.rqdata.runtaskentries[tid].unihash))
+                    next |= self.rqdata.runtaskentries[tid].revdeps
+                    changed.add(tid)
+                    total.remove(tid)
+                    next.intersection_update(total)
+
+        if changed:
+            for mc in self.rq.worker:
+                self.rq.worker[mc].process.stdin.write(b"<newtaskhashes>" + pickle.dumps(bb.parse.siggen.get_taskhashes()) + b"</newtaskhashes>")
+            for mc in self.rq.fakeworker:
+                self.rq.fakeworker[mc].process.stdin.write(b"<newtaskhashes>" + pickle.dumps(bb.parse.siggen.get_taskhashes()) + b"</newtaskhashes>")
+
+        logger.debug(1, pprint.pformat("Tasks changed:\n%s" % (changed)))
+
+        for tid in changed:
+            if tid not in self.rqdata.runq_setscene_tids:
+                continue
+            valid = self.rq.validate_hashes(set([tid]), self.cooker.data, None, False)
+            if not valid:
+                continue
+            self.changed_setscene.add(tid)
+
+        if changed:
+            self.update_holdofftasks()
+
+    def update_holdofftasks(self):
+        self.holdoff_tasks = set(self.changed_setscene)
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
+    def process_possible_migrations(self):
+        changes = False
+        for tid in self.changed_setscene.copy():
+            if tid in self.runq_running:
+                self.changed_setscene.remove(tid)
+                continue
+
+            valid = True
+            # Check no tasks this covers are running
+            for dep in self.sqdata.sq_covered_tasks[tid]:
+                if dep in self.runq_running and dep not in self.runq_complete:
+                    logger.debug(2, "Task %s is running which blocks setscene for %s from running" % (dep, tid))
+                    valid = False
+                    break
+            if not valid:
+                continue
+
+            for dep in self.sqdata.sq_covered_tasks[tid]:
+                if dep not in self.runq_complete:
+                    if dep in self.tasks_scenequeue_done:
+                        self.tasks_scenequeue_done.remove(dep)
+                    if dep in self.tasks_notcovered:
+                        self.tasks_notcovered.remove(dep)
+
+            if tid in self.sq_buildable:
+                self.sq_buildable.remove(tid)
+            if tid in self.sq_running:
+                self.sq_running.remove(tid)
+            if self.sqdata.sq_revdeps[tid].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
+                if tid not in self.sq_buildable:
+                    self.sq_buildable.add(tid)
+
+            if tid in self.sqdata.outrightfail:
+                self.sqdata.outrightfail.remove(tid)
+            if tid in self.scenequeue_notcovered:
+                self.scenequeue_notcovered.remove(tid)
+
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+            self.sqdata.stamps[tid] = bb.build.stampfile(taskname + "_setscene", self.rqdata.dataCaches[mc], taskfn, noextra=True)
+
+            if tid in self.build_stamps:
+                del self.build_stamps[tid]
+
+            logger.info("Setscene task %s now valid and being rerun" % tid)
+            self.sqdone = False
+            self.changed_setscene.remove(tid)
+            changes = True
+
+        if changes:
+            self.update_holdofftasks()
+
     def scenequeue_process_notcovered(self, task):
         if len(self.rqdata.runtaskentries[task].depends) == 0:
             self.setbuildable(task)
@@ -2194,7 +2326,7 @@ class RunQueueExecute:
                 for deptask in self.rqdata.runtaskentries[t].revdeps:
                     if deptask in ready or deptask in new or deptask in self.tasks_scenequeue_done or deptask in self.rqdata.runq_setscene_tids:
                         continue
-                    if self.rqdata.runtaskentries[deptask].depends.issubset(self.tasks_scenequeue_done):
+                    if deptask in self.sqdata.unskippable:
                         new.add(deptask)
                         self.tasks_scenequeue_done.add(deptask)
                         self.tasks_notcovered.add(deptask)
@@ -2254,8 +2386,9 @@ class RunQueueExecute:
                 self.tasks_covered.update(covered)
                 self.coveredtopocess.remove(task)
                 for tid in covered:
-                    if len(self.rqdata.runtaskentries[tid].depends) == 0:
+                    if self.rqdata.runtaskentries[tid].depends.issubset(self.runq_complete):
                         self.setbuildable(tid)
+        self.update_holdofftasks()
 
     def sq_task_completeoutright(self, task):
         """
@@ -2454,8 +2587,8 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
 
     rqdata.init_progress_reporter.next_stage()
 
-    # Build a list of setscene tasks which are "unskippable"
-    # These are direct endpoints referenced by the build
+    # Build a list of tasks which are "unskippable"
+    # These are direct endpoints referenced by the build upto and including setscene tasks
     # Take the build endpoints (no revdeps) and find the sstate tasks they depend upon
     new = True
     for tid in rqdata.runtaskentries:
@@ -2463,10 +2596,10 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
             sqdata.unskippable.add(tid)
     while new:
         new = False
-        for tid in sqdata.unskippable.copy():
+        orig = sqdata.unskippable.copy()
+        for tid in orig:
             if tid in rqdata.runq_setscene_tids:
                 continue
-            sqdata.unskippable.remove(tid)
             if len(rqdata.runtaskentries[tid].depends) == 0:
                 # These are tasks which have no setscene tasks in their chain, need to mark as directly buildable
                 sqrq.tasks_notcovered.add(tid)
@@ -2474,7 +2607,8 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 sqrq.setbuildable(tid)
                 sqrq.scenequeue_process_unskippable(tid)
             sqdata.unskippable |= rqdata.runtaskentries[tid].depends
-            new = True
+            if sqdata.unskippable != orig:
+                new = True
 
     rqdata.init_progress_reporter.next_stage(len(rqdata.runtaskentries))
 
@@ -2710,6 +2844,15 @@ class runQueueTaskSkipped(runQueueEvent):
         runQueueEvent.__init__(self, task, stats, rq)
         self.reason = reason
 
+class taskUniHashUpdate(bb.event.Event):
+    """
+    Base runQueue event class
+    """
+    def __init__(self, task, unihash):
+        self.taskid = task
+        self.unihash = unihash
+        bb.event.Event.__init__(self)
+
 class runQueuePipe():
     """
     Abstraction for a pipe between a worker thread and the server
@@ -2752,6 +2895,8 @@ class runQueuePipe():
                 except ValueError as e:
                     bb.msg.fatal("RunQueue", "failed load pickle '%s': '%s'" % (e, self.queue[7:index]))
                 bb.event.fire_from_worker(event, self.d)
+                if isinstance(event, taskUniHashUpdate):
+                    self.rqexec.updated_taskhash(event.taskid, event.unihash)
                 found = True
                 self.queue = self.queue[index+8:]
                 index = self.queue.find(b"</event>")
-- 
2.20.1


