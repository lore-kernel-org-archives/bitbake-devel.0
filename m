Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SgeKx-0000gd-BW
	for bitbake-devel@lists.openembedded.org;
	Mon, 18 Jun 2012 17:57:55 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 18 Jun 2012 08:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="167049120"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.122])
	by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2012 08:45:45 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jun 2012 16:45:36 +0100
Message-Id: <c6118ee20c4c4dcaf068f15db8a3606604a3bccd.1340034255.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1340034255.git.paul.eggleton@linux.intel.com>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1340034255.git.paul.eggleton@linux.intel.com>
References: <cover.1340034255.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] bitbake: add -C option to invalidate a task and rebuild the target
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 18 Jun 2012 15:57:55 -0000

This new command line option forces the specified task and all dependent
tasks up to the default task to re-run. This means that the following
single step:

bitbake -C compile somerecipe

is equivalent to the following two steps (with the recent change to -f):

bitbake -c compile -f somerecipe
bitbake somerecipe

Note that to work this option needs full hashing enabled (i.e.
BB_SIGNATURE_HANDLER must be set to a signature handler that inherits
from BasicHash). If this is not the case, -C effectively does nothing.

Based on a previous implementation of this option by Jason Wessel
<jason.wessel@windriver.com>.

Implements [YOCTO #2615].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake        |    3 +++
 bitbake/lib/bb/runqueue.py |   20 ++++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
index 478ac06..f23673f 100755
--- a/bitbake/bin/bitbake
+++ b/bitbake/bin/bitbake
@@ -118,6 +118,9 @@ Default BBFILES are the .bb files in the current directory.""")
     parser.add_option("-c", "--cmd", help = "Specify task to execute. Note that this only executes the specified task for the providee and the packages it depends on, i.e. 'compile' does not implicitly call stage for the dependencies (IOW: use only if you know what you are doing). Depending on the base.bbclass a listtasks tasks is defined and will show available tasks",
                action = "store", dest = "cmd")
 
+    parser.add_option("-C", "--clear-stamp", help = "Invalidate the specified stamp for a task such as 'compile' and run the default task for the specified target(s)",
+                action = "store", dest = "invalidate_stamp")
+
     parser.add_option("-r", "--read", help = "read the specified file before bitbake.conf",
                action = "append", dest = "prefile", default = [])
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 28eb072..608aff8 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -705,11 +705,27 @@ class RunQueueData:
                 continue
             self.runq_setscene.append(task)
 
+        def invalidate_task(fn, taskname, error_nostamp):
+            taskdep = self.dataCache.task_deps[fn]
+            if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
+                if error_nostamp:
+                    bb.fatal("Task %s is marked nostamp, cannot invalidate this task" % taskname)
+                else:
+                    bb.debug(1, "Task %s is marked nostamp, cannot invalidate this task" % taskname)
+            else:
+                logger.verbose("Invalidate task %s, %s", taskname, fn)
+                bb.parse.siggen.invalidate_task(taskname, self.dataCache, fn)
+
         # Invalidate task if force mode active
         if self.cooker.configuration.force:
             for (fn, target) in self.target_pairs:
-                logger.verbose("Invalidate task %s, %s", target, fn)
-                bb.parse.siggen.invalidate_task(target, self.dataCache, fn)
+                invalidate_task(fn, target, False)
+
+        # Invalidate task if invalidate mode active
+        if self.cooker.configuration.invalidate_stamp:
+            for (fn, target) in self.target_pairs:
+                for st in self.cooker.configuration.invalidate_stamp.split(','):
+                    invalidate_task(fn, "do_%s" % st, True)
 
         # Interate over the task list and call into the siggen code
         dealtwith = set()
-- 
1.7.9.5



