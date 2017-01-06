Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com
	[209.85.214.41])
	by mail.openembedded.org (Postfix) with ESMTP id F22DB60107
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jan 2017 09:51:09 +0000 (UTC)
Received: by mail-it0-f41.google.com with SMTP id x2so12281368itf.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Jan 2017 01:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=HSDfDzNd+3A9rgGgXTkUPvN7eyd7UhhDYemsxe+hrus=;
	b=RjOStWDLMGUDURE60tXcLNbdUbIibwh+uzuYc7regG1MEhGgEOtJuDQCXBRSCfCiPF
	5Q/srSVldE/HYv798IqGYvMgpHfFaS9OHyFSJpjWdHpXDBy6RQHXIfWzrgY5G6kZIxVf
	iEa7LNs5g2qUhI+COT1j2VeNL1moCQOcKYvClz9HryF4y6t1fD5HBGAK629UZE/knnYJ
	8kgUCnJxzILUqSiylxlvLuOSQw1hOpdaTWS74laT/7I1sYI0C62b0onqoR/G3KxUouhT
	iDkZ1dZ5+jFglbOkuQ1WTC+j+yN+I9cW6oLR+DrnoinHuA2zIWV3s0Oo5GTH4ofLcSSr
	lKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=HSDfDzNd+3A9rgGgXTkUPvN7eyd7UhhDYemsxe+hrus=;
	b=mL9wtO3/qATsr2dD0Ad+j4tlSoBRQggsGB7Ia6m1OtavLNWY+kkQxxj29/kUs5kfht
	ryESvOptzrF6djVT7YeZHKnjbxHV7L7VDJL+QnjlRVGVCGxPXApmX+3Z8ay1QEEDW1+q
	DrPLq6ziR2D14TfNWxk+viGLo8qTmraWxz0Gsu2QctYOPGwSDaF29S2EAWLc2r56PIWg
	HkJDJX4c2qrCO48kdQy4j9poG+kJlh+K1TD7C0B0BUTywDoKOKR22dNK24ytLBXsLD3v
	EwYeHrhc2AAuF9KoiMY6GKyDOZauro6+PqXE1uIHtTmVmlr8sH6K88TkeWVSToLZbKAx
	jFKQ==
X-Gm-Message-State: AIkVDXLBlTNu6Yew3GCf2jqznNSOy7aKYlrpMBnxvse4Mv7uxaEzS6dQLQ8Qz5QDDyIHU1Y2
X-Received: by 10.36.238.133 with SMTP id b127mr1743696iti.20.1483696269629;
	Fri, 06 Jan 2017 01:51:09 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8F5BD.dip0.t-ipconnect.de.
	[93.232.245.189]) by smtp.gmail.com with ESMTPSA id
	w192sm1171819itw.3.2017.01.06.01.51.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 06 Jan 2017 01:51:08 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2017 10:50:49 +0100
Message-Id: <10afe815db0b6c591a2045a53f004c70e1df92bd.1483696010.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1483696010.git.patrick.ohly@intel.com>
References: <cover.1483696010.git.patrick.ohly@intel.com>
Subject: [PATCH 3/3] runqueue.py: alternative rm_work scheduler
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
X-List-Received-Date: Fri, 06 Jan 2017 09:51:10 -0000

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

The new scheduler has to be picked explicitly with
   BB_SCHEDULER = "rm_work"

Signed-off-by: Patrick Ohly <patrick.ohly@intel.com>
---
 lib/bb/runqueue.py | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 48c6a79..bf5b65d 100644
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
@@ -242,6 +254,101 @@ class RunQueueSchedulerCompletion(RunQueueSchedulerSpeed):
             for idx in todel:
                 del basemap[idx]
 
+class RunQueueSchedulerRmwork(RunQueueSchedulerSpeed):
+    """
+    A scheduler optimised to complete .bb files are quickly as possible. The
+    priority map is sorted by task weight, but then reordered so that once a given
+    .bb file starts to build, it's completed as quickly as possible by
+    running all tasks related to the same .bb file one after the after.
+    """
+    name = "rm_work"
+
+    def __init__(self, runqueue, rqdata):
+        super(RunQueueSchedulerRmwork, self).__init__(runqueue, rqdata)
+
+        # Extract list of tasks for each recipe, with tasks sorted
+        # ascending from "must run first" (typically do_fetch) to
+        # "runs last" (do_rm_work). Both the speed and completion
+        # schedule prioritize tasks that must run first before the ones
+        # that run later; this is what we depend on here.
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
+        # is now so that do_rm_work[_all] is most important.
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
+        self.dump_prio('rm_work priorities')
+
 class RunTaskEntry(object):
     def __init__(self):
         self.depends = set()
-- 
2.1.4


