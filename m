Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id CFC1660720
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 22:59:01 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v7VMx0wC020418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Thu, 31 Aug 2017 23:59:01 +0100
Received: from richard by hex with local (Exim 4.86_2)
	(envelope-from <richard@rpsys.net>)
	id 1dnYQO-0007TF-2Z; Thu, 31 Aug 2017 23:59:00 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 23:58:59 +0100
Message-Id: <1504220339-28679-1-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.7.4
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Thu, 31 Aug 2017 23:59:01 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: [PATCH] cookerdata/taskdata/runqueue: Drop remaining tryaltconfigs code and commandline option
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
X-List-Received-Date: Thu, 31 Aug 2017 22:59:02 -0000

I can't actually see how this was working, nothing connected the commandline option
to the data in TaskData(). Drop the remaining pieces of this option, it was a relic
from a decade ago and we want deterministic builds, not random tries until something
might work.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cookerdata.py | 2 +-
 lib/bb/main.py       | 5 -----
 lib/bb/runqueue.py   | 7 +------
 lib/bb/taskdata.py   | 3 +--
 4 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 2c9019f..fab47c7 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -69,7 +69,7 @@ class ConfigParameters(object):
 
     def updateToServer(self, server, environment):
         options = {}
-        for o in ["abort", "tryaltconfigs", "force", "invalidate_stamp",
+        for o in ["abort", "force", "invalidate_stamp",
                   "verbose", "debug", "dry_run", "dump_signatures",
                   "debug_domains", "extra_assume_provided", "profile",
                   "prefile", "postfile", "server_timeout"]:
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 6e6a346..a488c3d 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -150,11 +150,6 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                                "failed and anything depending on it cannot be built, as much as "
                                "possible will be built before stopping.")
 
-        parser.add_option("-a", "--tryaltconfigs", action="store_true",
-                          dest="tryaltconfigs", default=False,
-                          help="Continue with builds by trying to use alternative providers "
-                               "where possible.")
-
         parser.add_option("-f", "--force", action="store_true", dest="force", default=False,
                           help="Force the specified targets/task to run (invalidating any "
                                "existing stamp file).")
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index e1a15af..6b3a0fc 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1355,12 +1355,7 @@ class RunQueue:
                 logger.info("Tasks Summary: Attempted %d tasks of which %d didn't need to be rerun and all succeeded.", self.rqexe.stats.completed, self.rqexe.stats.skipped)
 
         if self.state is runQueueFailed:
-            if not self.rqdata.taskData[''].tryaltconfigs:
-                raise bb.runqueue.TaskFailure(self.rqexe.failed_tids)
-            for tid in self.rqexe.failed_tids:
-                (mc, fn, tn, _) = split_tid_mcfn(tid)
-                self.rqdata.taskData[mc].fail_fn(fn)
-            self.rqdata.reset()
+            raise bb.runqueue.TaskFailure(self.rqexe.failed_tids)
 
         if self.state is runQueueComplete:
             # All done
diff --git a/lib/bb/taskdata.py b/lib/bb/taskdata.py
index 8c96a56..0ea6c0b 100644
--- a/lib/bb/taskdata.py
+++ b/lib/bb/taskdata.py
@@ -47,7 +47,7 @@ class TaskData:
     """
     BitBake Task Data implementation
     """
-    def __init__(self, abort = True, tryaltconfigs = False, skiplist = None, allowincomplete = False):
+    def __init__(self, abort = True, skiplist = None, allowincomplete = False):
         self.build_targets = {}
         self.run_targets = {}
 
@@ -66,7 +66,6 @@ class TaskData:
         self.failed_fns = []
 
         self.abort = abort
-        self.tryaltconfigs = tryaltconfigs
         self.allowincomplete = allowincomplete
 
         self.skiplist = skiplist
-- 
2.7.4


