Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com
	[209.85.214.50])
	by mail.openembedded.org (Postfix) with ESMTP id A02B471DC9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 14:51:35 +0000 (UTC)
Received: by mail-it0-f50.google.com with SMTP id x2so9480743itf.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Jan 2017 06:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=9ztU4TEypw7azOO2gAqERxZCd/1zZAQekxAPjQ0aAS8=;
	b=YQgNEVLzrSr/3HLhknhkwJibVRoLDJDu7bJv2+1lBLmqFSPpUJaVQH4R1GN0ghJ4J4
	qn1/EqWwd/VsKZyjBV/f3mu1SljEGbywZnGiNoGm4gJkgu88qgxfIS/5tj0y+YlD8pg+
	Az3zKUxXJgsI3VNSsCn+seADbu/kKAuNvmUNf8/hZpd+9wj9mE/W1AlaG4JJ/qjytm4d
	yqksW11tN/153OkRs6oFE6faUh2PsYBJ5E/vHBGY6Mr1+FCVHMDuzLUVn1VU7+DUF89m
	qew1s5Z1QqYssmv/1ASTHm6dscvAePwtk0+NR9RtsMMIwDX7Vq7ZDQChnEAw7dTcGa6Z
	0Hfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=9ztU4TEypw7azOO2gAqERxZCd/1zZAQekxAPjQ0aAS8=;
	b=TN1X8fI4FptYugDRb3YHW31YNhkLOOFukzfWxJ8+g8oOU1FKB3cQCR/NuRLYOxADS2
	tkCE/f6UB2D3dne/KQZ2xzVy8X3I4pq+IKohki0MeDG355achoXPc7GUHQFhbYXCj8Rl
	3tWAO0qMA2BB662TIWPY32G92Ea16kKH1oHzu8BqxW/v80qx7EKuYjGEm77zEVA0Xceh
	jcopwKlPn9CBjd7CH3ONWFA4EqdkLJOMDvG2do4SUus2to+oQsdB5b78eDDv9pgfCOc+
	wTpZ5E/Yurov4ElUznHjmhXtR80Bou0YfugdXo/8tixeDeqZNN5ZoACc+ApIBdsIYJam
	FfPg==
X-Gm-Message-State: AIkVDXJB4rxRQ9ZL4qFoK2C9fVzr/PRw9wdObG+uzywMnu8byHWj5UrZH6XfMdFPXd+qfdTG
X-Received: by 10.36.39.6 with SMTP id g6mr2799125ita.94.1484319095186;
	Fri, 13 Jan 2017 06:51:35 -0800 (PST)
Received: from pohly-desktop.fritz.box (p57A56056.dip0.t-ipconnect.de.
	[87.165.96.86]) by smtp.gmail.com with ESMTPSA id
	r203sm1006974itc.5.2017.01.13.06.51.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 13 Jan 2017 06:51:34 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Jan 2017 15:51:21 +0100
Message-Id: <8f61859759b1fe66f1e649ff341582bc51c93161.1484318890.git-series.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
References: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
In-Reply-To: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
References: <cover.5e5ac9bdeea438c2ba58f3b9b20503181c9f5340.1484318890.git-series.patrick.ohly@intel.com>
Subject: [PATCH v2 3/3] runqueue.py: revised completion scheduler
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
X-List-Received-Date: Fri, 13 Jan 2017 14:51:35 -0000

The idea is that tasks which complete building a recipe (like
do_package_qa) are more important than tasks which start building new
recipes (do_fetch) or those which increase disk usage
(do_compile). Therefore tasks get ordered like this (most important
first, do_rm_work before do_build because the enhanced rm_work.bbclass
was used):

1. ID /work/poky/meta/recipes-support/popt/popt_1.16.bb:do_build
2. ID /work/poky/meta/recipes-core/readline/readline_6.3.bb:do_build
3. ID /work/poky/meta/recipes-connectivity/libnss-mdns/libnss-mdns_0.10.bb:do_build
...
464. ID /work/poky/meta/recipes-sato/images/core-image-sato.bb:do_build
465. ID /work/poky/meta/recipes-graphics/xorg-proto/inputproto_2.3.2.bb:do_rm_work
466. ID /work/poky/meta/recipes-devtools/python/python3_3.5.2.bb:do_rm_work
467. ID /work/poky/meta/recipes-core/packagegroups/packagegroup-base.bb:do_rm_work
...
3620. ID virtual:native:/work/poky/meta/recipes-extended/pbzip2/pbzip2_1.1.13.bb:do_install
3621. ID /work/poky/meta/recipes-devtools/qemu/qemu-helper-native_1.0.bb:do_install
3622. ID /work/poky/meta/recipes-core/zlib/zlib_1.2.8.bb:do_compile_ptest_base
3623. ID /work/poky/meta/recipes-extended/bzip2/bzip2_1.0.6.bb:do_compile_ptest_base
...
3645. ID /work/poky/meta/recipes-support/libevent/libevent_2.0.22.bb:do_compile_ptest_base
3646. ID /work/poky/meta/recipes-core/busybox/busybox_1.24.1.bb:do_compile_ptest_base
3647. ID /work/poky/meta/recipes-kernel/linux/linux-yocto_4.8.bb:do_uboot_mkimage
3648. ID /work/poky/meta/recipes-kernel/linux/linux-yocto_4.8.bb:do_sizecheck
3649. ID /work/poky/meta/recipes-kernel/linux/linux-yocto_4.8.bb:do_strip
3650. ID /work/poky/meta/recipes-kernel/linux/linux-yocto_4.8.bb:do_compile_kernelmodules
3651. ID /work/poky/meta/recipes-kernel/linux/linux-yocto_4.8.bb:do_shared_workdir
3652. ID /work/poky/meta/recipes-kernel/linux/linux-yocto_4.8.bb:do_kernel_link_images
3653. ID /work/poky/meta/recipes-devtools/quilt/quilt-native_0.64.bb:do_compile
3654. ID /work/poky/meta/recipes-extended/texinfo-dummy-native/texinfo-dummy-native.bb:do_compile
...

The order of the same task between different recipes is the same as
with the speed scheduler, i.e. more important recipes come first.

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/runqueue.py | 125 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 101 insertions(+), 24 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 48c6a79..0c4f286 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -183,6 +183,18 @@ class RunQueueScheduler(object):
     def newbuilable(self, task):
         self.buildable.append(task)
 
+    def describe_task(self, taskid):
+        result = 'ID %s' % taskid
+        if self.rev_prio_map:
+            result = result + (' pri %d' % self.rev_prio_map[taskid])
+        return result
+
+    def dump_prio(self, comment):
+        bb.debug(3, '%s (most important first):\n%s' %
+                 (comment,
+                  '\n'.join(['%d. %s' % (index + 1, self.describe_task(taskid)) for
+                             index, taskid in enumerate(self.prio_map)])))
+
 class RunQueueSchedulerSpeed(RunQueueScheduler):
     """
     A scheduler optimised for speed. The priority map is sorted by task weight,
@@ -212,35 +224,100 @@ class RunQueueSchedulerSpeed(RunQueueScheduler):
 
 class RunQueueSchedulerCompletion(RunQueueSchedulerSpeed):
     """
-    A scheduler optimised to complete .bb files are quickly as possible. The
+    A scheduler optimised to complete .bb files as quickly as possible. The
     priority map is sorted by task weight, but then reordered so once a given
-    .bb file starts to build, it's completed as quickly as possible. This works
-    well where disk space is at a premium and classes like OE's rm_work are in
-    force.
+    .bb file starts to build, it's completed as quickly as possible by
+    running all tasks related to the same .bb file one after the after.
+    This works well where disk space is at a premium and classes like OE's
+    rm_work are in force.
     """
     name = "completion"
 
     def __init__(self, runqueue, rqdata):
-        RunQueueSchedulerSpeed.__init__(self, runqueue, rqdata)
-
-        #FIXME - whilst this groups all fns together it does not reorder the
-        #fn groups optimally.
-
-        basemap = copy.deepcopy(self.prio_map)
-        self.prio_map = []
-        while (len(basemap) > 0):
-            entry = basemap.pop(0)
-            self.prio_map.append(entry)
-            fn = fn_from_tid(entry)
-            todel = []
-            for entry in basemap:
-                entry_fn = fn_from_tid(entry)
-                if entry_fn == fn:
-                    todel.append(basemap.index(entry))
-                    self.prio_map.append(entry)
-            todel.reverse()
-            for idx in todel:
-                del basemap[idx]
+        super(RunQueueSchedulerRmwork, self).__init__(runqueue, rqdata)
+
+        # Extract list of tasks for each recipe, with tasks sorted
+        # ascending from "must run first" (typically do_fetch) to
+        # "runs last" (do_build). The speed scheduler prioritizes
+        # tasks that must run first before the ones that run later;
+        # this is what we depend on here.
+        task_lists = {}
+        for taskid in self.prio_map:
+            fn, taskname = taskid.rsplit(':', 1)
+            task_lists.setdefault(fn, []).append(taskname)
+
+        # Now unify the different task lists. The strategy is that
+        # common tasks get skipped and new ones get inserted after the
+        # preceeding common one(s) as they are found. Because task
+        # lists should differ only by their number of tasks, but not
+        # the ordering of the common tasks, this should result in a
+        # deterministic result that is a superset of the individual
+        # task ordering.
+        all_tasks = []
+        for recipe, new_tasks in task_lists.items():
+            index = 0
+            old_task = all_tasks[index] if index < len(all_tasks) else None
+            for new_task in new_tasks:
+                if old_task == new_task:
+                    # Common task, skip it. This is the fast-path which
+                    # avoids a full search.
+                    index += 1
+                    old_task = all_tasks[index] if index < len(all_tasks) else None
+                else:
+                    try:
+                        index = all_tasks.index(new_task)
+                        # Already present, just not at the current
+                        # place. We re-synchronized by changing the
+                        # index so that it matches again. Now
+                        # move on to the next existing task.
+                        index += 1
+                        old_task = all_tasks[index] if index < len(all_tasks) else None
+                    except ValueError:
+                        # Not present. Insert before old_task, which
+                        # remains the same (but gets shifted back).
+                        all_tasks.insert(index, new_task)
+                        index += 1
+        bb.debug(3, 'merged task list: %s'  % all_tasks)
+
+        # Now reverse the order so that tasks that finish the work on one
+        # recipe are considered more imporant (= come first). The ordering
+        # is now so that do_build is most important.
+        all_tasks.reverse()
+
+        # Group tasks of the same kind before tasks of less important
+        # kinds at the head of the queue (because earlier = lower
+        # priority number = runs earlier), while preserving the
+        # ordering by recipe. If recipe foo is more important than
+        # bar, then the goal is to work on foo's do_populate_sysroot
+        # before bar's do_populate_sysroot and on the more important
+        # tasks of foo before any of the less important tasks in any
+        # other recipe (if those other recipes are more important than
+        # foo).
+        #
+        # All of this only applies when tasks are runable. Explicit
+        # dependencies still override this ordering by priority.
+        #
+        # Here's an example why this priority re-ordering helps with
+        # minimizing disk usage. Consider a recipe foo with a higher
+        # priority than bar where foo DEPENDS on bar. Then the
+        # implicit rule (from base.bbclass) is that foo's do_configure
+        # depends on bar's do_populate_sysroot. This ensures that
+        # bar's do_populate_sysroot gets done first. Normally the
+        # tasks from foo would continue to run once that is done, and
+        # bar only gets completed and cleaned up later. By ordering
+        # bar's task that depend on bar's do_populate_sysroot before foo's
+        # do_configure, that problem gets avoided.
+        task_index = 0
+        self.dump_prio('original priorities')
+        for task in all_tasks:
+            for index in range(task_index, self.numTasks):
+                taskid = self.prio_map[index]
+                taskname = taskid.rsplit(':', 1)[1]
+                if taskname == task:
+                    del self.prio_map[index]
+                    self.prio_map.insert(task_index, taskid)
+                    task_index += 1
+        self.dump_prio('completion priorities')
 
 class RunTaskEntry(object):
     def __init__(self):
-- 
git-series 0.9.1

