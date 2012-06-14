Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1Sf0ho-0006TD-Fg
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 05:26:44 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5E3G7Dn009251
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jun 2012 20:16:07 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 13 Jun 2012 20:16:07 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 13 Jun 2012 22:16:00 -0500
Message-ID: <1339643761-23149-3-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339643761-23149-1-git-send-email-jason.wessel@windriver.com>
References: <1339643761-23149-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/3] bitbake, runqueue.py: Add -i to invalidate a stamp and rebuild the target
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
X-List-Received-Date: Thu, 14 Jun 2012 03:26:44 -0000
Content-Type: text/plain

It is highly desirable to be able to invalidate a stamp used for
do_compile and to be able to continue on to build the entire
package's default target.

If invalidating a stamp, the setscene rules for the specified targets
should be automatically canceled so as to allow the full set of tasks
depending on any invalidated stap to run for the specified packages.
For example if you wanted to rebuild the "tinylogin" package and see
the results in a final image in one step for the core-image-minimal
you could do so with:

   bitbake -C compile tinylogin core-image-minimal

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 bin/bitbake        |    4 ++++
 lib/bb/runqueue.py |   29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/bin/bitbake b/bin/bitbake
index d178a38..1ac6e8a 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -118,6 +118,10 @@ Default BBFILES are the .bb files in the current directory.""")
     parser.add_option("-c", "--cmd", help = "Specify task to execute. Note that this only executes the specified task for the providee and the packages it depends on, i.e. 'compile' does not implicitly call stage for the dependencies (IOW: use only if you know what you are doing). Depending on the base.bbclass a listtasks tasks is defined and will show available tasks",
                action = "store", dest = "cmd")
 
+    parser.add_option("-C", "--clear-stamp", help = "Invalidate the specified stamp for a task such as 'compile' and run the default task for and specified packages",
+                action = "store", dest = "invalidate_stamp")
+
+
     parser.add_option("-r", "--read", help = "read the specified file before bitbake.conf",
                action = "append", dest = "prefile", default = [])
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6596e83..f1fabfa 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -719,6 +719,28 @@ class RunQueueData:
                         procdep.append(self.taskData.fn_index[self.runq_fnid[dep]] + "." + self.runq_task[dep])
                     self.runq_hash[task] = bb.parse.siggen.get_taskhash(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task], procdep, self.dataCache)
 
+        # Remove any setscene tasks from the queue for which we invalidated
+        # a stamp
+        try:
+            new_setscene = []
+            test_fns = []
+            if self.cooker.configuration.invalidate_stamp:
+                for tgt in self.target_pairs:
+                    test_fns.append(tgt[0])
+            for task in self.runq_setscene:
+                try:
+                    fn = self.taskData.fn_index[self.rq.rqdata.runq_fnid[task]]
+                    if (self.cooker.configuration.invalidate_stamp and fn in test_fns):
+                        logger.debug(2, 'Removing task %s due to invalidated build stamps', task)
+                    else:
+                        new_setscene.append(task)
+                except:
+                    logger.debug(2, 'Failed invalidate check for %s', task)
+            self.runq_setscene = new_setscene
+        except:
+            logger.debug(2, 'Failed to update runq_setscene')
+
+
         self.hashes = {}
         self.hash_deps = {}
         for task in xrange(len(self.runq_fnid)):
@@ -732,6 +754,13 @@ class RunQueueData:
                 deps.append(depidentifier)
             self.hash_deps[identifier] = deps
 
+        # Remove stamps for forced invalidation
+        if self.cooker.configuration.invalidate_stamp:
+            for (fn, target) in self.target_pairs:
+                for st in self.cooker.configuration.invalidate_stamp.split(','):
+                    logger.verbose("Remove stamp %s, %s", st, fn)
+                    bb.build.del_stamp("do_%s" % st, self.dataCache, fn)
+
         # Remove stamps for targets if force mode active
         if self.cooker.configuration.force:
             for (fn, target) in self.target_pairs:
-- 
1.7.10



