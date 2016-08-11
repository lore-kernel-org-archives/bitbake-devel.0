Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id A3D4C75CF1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Aug 2016 03:37:32 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga104.fm.intel.com with ESMTP; 10 Aug 2016 20:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,503,1464678000"; d="scan'208";a="863452245"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.171.53])
	by orsmga003.jf.intel.com with ESMTP; 10 Aug 2016 20:37:31 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Aug 2016 15:36:57 +1200
Message-Id: <6aeaed72459f6c9d533bcea0b0d63605e1cef12a.1470886482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1470886482.git.paul.eggleton@linux.intel.com>
References: <cover.1470886482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1470886482.git.paul.eggleton@linux.intel.com>
References: <cover.1470886482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/4] runqueue: fix two minor issues with the initialising tasks progress
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
X-List-Received-Date: Thu, 11 Aug 2016 03:37:36 -0000

A couple of fixes for the "Initialising tasks" progress bar behaviour:
* Properly finish the progress bar when using bitbake -S
* Finish the progress bar before calling BB_HASHCHECK_FUNCTION (so that
  in OE when that shows its own "Checking sstate mirror object
  availability"  progress bar it gets shown on the next line as it
  should).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/runqueue.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index aa939d0..3a593b6 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1148,6 +1148,7 @@ class RunQueue:
         if self.state is runQueueSceneInit:
             dump = self.cooker.configuration.dump_signatures
             if dump:
+                self.rqdata.init_progress_reporter.finish()
                 if 'printdiff' in dump:
                     invalidtasks = self.print_diffscenetasks()
                 self.dump_signatures(dump)
@@ -1967,6 +1968,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             if len(self.sq_revdeps[tid]) == 0:
                 self.runq_buildable.add(tid)
 
+        self.rqdata.init_progress_reporter.finish()
+
         self.outrightfail = []
         if self.rq.hashvalidate:
             sq_hash = []
@@ -2018,8 +2021,6 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                     logger.debug(2, 'No package found, so skipping setscene task %s', tid)
                     self.outrightfail.append(tid)
 
-        self.rqdata.init_progress_reporter.finish()
-
         logger.info('Executing SetScene Tasks')
 
         self.rq.state = runQueueSceneRun
-- 
2.5.5


