Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id A219678412
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 14:22:08 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w4EEM9la017544
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 May 2018 07:22:09 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.361.1;
	Mon, 14 May 2018 07:22:08 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 14 May 2018 10:21:39 -0400
Message-ID: <20180514142139.165484-3-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20180514142139.165484-1-mark.hatle@windriver.com>
References: <20180514142139.165484-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] runqueue.py: Initial implementation of per task process limits
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
X-List-Received-Date: Mon, 14 May 2018 14:22:08 -0000
Content-Type: text/plain

On high core machines, in do_fetch, it is possible to DDoS your own machine.
A method to limit any arbitrary task type to a certain number of simultaneous
threads is needed.  (Similar to how BB_NUMBER_THREADS works in the general
case.)  The format of this new limitation is:

    do_fetch[number_threads] = "2"

This should be set globally.  If it is set in individual recipes it could
result in unpredictable behavior.

Note: a value for number_threads > BB_NUMBER_THREADS will have no effect.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/runqueue.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a937a0b..2d9e18d 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -134,6 +134,7 @@ class RunQueueScheduler(object):
         self.prio_map = [self.rqdata.runtaskentries.keys()]
 
         self.buildable = []
+        self.skip_maxthread = {}
         self.stamps = {}
         for tid in self.rqdata.runtaskentries:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
@@ -150,8 +151,25 @@ class RunQueueScheduler(object):
         self.buildable = [x for x in self.buildable if x not in self.rq.runq_running]
         if not self.buildable:
             return None
+
+        # Filter out tasks that have a max number of threads that have been exceeded
+        skip_buildable = {}
+        for running in self.rq.runq_running.difference(self.rq.runq_complete):
+            rtaskname = taskname_from_tid(running)
+            if rtaskname not in self.skip_maxthread:
+                self.skip_maxthread[rtaskname] = self.rq.cfgData.getVarFlag(rtaskname, "number_threads")
+            if not self.skip_maxthread[rtaskname]:
+                continue
+            if rtaskname in skip_buildable:
+                skip_buildable[rtaskname] += 1
+            else:
+                skip_buildable[rtaskname] = 1
+
         if len(self.buildable) == 1:
             tid = self.buildable[0]
+            taskname = taskname_from_tid(tid)
+            if taskname in skip_buildable and skip_buildable[taskname] >= int(self.skip_maxthread[taskname]):
+                return None
             stamp = self.stamps[tid]
             if stamp not in self.rq.build_stamps.values():
                 return tid
@@ -164,6 +182,9 @@ class RunQueueScheduler(object):
         best = None
         bestprio = None
         for tid in self.buildable:
+            taskname = taskname_from_tid(tid)
+            if taskname in skip_buildable and skip_buildable[taskname] >= int(self.skip_maxthread[taskname]):
+                continue
             prio = self.rev_prio_map[tid]
             if bestprio is None or bestprio > prio:
                 stamp = self.stamps[tid]
-- 
1.8.3.1


