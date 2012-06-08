Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1SczdL-0004i1-EW
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 15:54:01 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q58DhHOW015541
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 8 Jun 2012 06:43:17 -0700 (PDT)
Received: from ord-jrw.wrs.com (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 8 Jun 2012 06:43:16 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Jun 2012 08:41:50 -0500
Message-ID: <1339162913-23759-16-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
References: <1339162913-23759-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Subject: [PATCH v4 15/18] bitbake, runqueue.py: Add -i to invalidate a stamp and rebuild the target
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
X-List-Received-Date: Fri, 08 Jun 2012 13:54:01 -0000
Content-Type: text/plain

It is highly desirable to be able to invalidate a stamp used for
do_compile and to be able to continue on to build the entire
package's build rule.

If invalidating a stamp, the setscene rules for the specified targets
should be automatically canceled so as to allow a forced build
of an individual target.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
---
 bin/bitbake        |    3 +++
 lib/bb/runqueue.py |   13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake b/bin/bitbake
index 702d99c..bf81a0c 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -150,6 +150,9 @@ Default BBFILES are the .bb files in the current directory.""")
     parser.add_option("-I", "--ignore-deps", help = """Assume these dependencies don't exist and are already provided (equivalent to ASSUME_PROVIDED). Useful to make dependency graphs more appealing""",
                 action = "append", dest = "extra_assume_provided", default = [])
 
+    parser.add_option("-i", "--invalidate-stamp", help = "Invalidate the specified stamp for a command such as 'compile' and build",
+                action = "store", dest = "invalidate_stamp")
+
     parser.add_option("-l", "--log-domains", help = """Show debug logging for the specified logging domains""",
                 action = "append", dest = "debug_domains", default = [])
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6c802af..3dbfaad 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -720,10 +720,14 @@ class RunQueueData:
                     self.runq_hash[task] = bb.parse.siggen.get_taskhash(self.taskData.fn_index[self.runq_fnid[task]], self.runq_task[task], procdep, self.dataCache)
         try:
             new_setscene = []
+            test_fns = []
+            if self.cooker.configuration.invalidate_stamp:
+                for tgt in self.target_pairs:
+                    test_fns.append(tgt[0])
             for task in self.runq_setscene:
                 try:
                     fn = self.taskData.fn_index[self.rq.rqdata.runq_fnid[task]]
-                    if bb.build.exists_stamp("do_unpack", self.dataCache, fn):
+                    if bb.build.exists_stamp("do_unpack", self.dataCache, fn) or (self.cooker.configuration.invalidate_stamp and fn in test_fns):
                         logger.debug(2, 'Removing task %s from queue because do_unpack exists', task)
                     else:
                         new_setscene.append(task)
@@ -746,6 +750,13 @@ class RunQueueData:
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



