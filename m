Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 80B5F7BE3C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2019 08:26:10 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x8I8Pp6q013340
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Sep 2019 01:26:01 -0700
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Wed, 18 Sep 2019 01:25:39 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 18 Sep 2019 16:51:48 +0800
Message-ID: <4e0c92990453e4bc7cae058ca7e6cfde28d0d5d9.1568796682.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1568796682.git.liezhi.yang@windriver.com>
References: <cover.1568796682.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] runqueue: validate_hashes(): currentcount should be a number
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
X-List-Received-Date: Wed, 18 Sep 2019 08:26:10 -0000
Content-Type: text/plain

According to sstate_checkhashes which is defined in sstate.bbclass, the
currentcoun should be a number (0, not None).

Fixed:
$ bitbake base-files -Sprintdiff
    >    bb.plain("Sstate summary: Wanted %d Found %d Missed %d Current %d (%d%% match, %d%% complete)" % (total, len(found), len(missed), currentcount, match, complete))

TypeError: %d format: a number is required, not NoneType

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/runqueue.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 45bfec8..b8ca129 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1394,7 +1394,7 @@ class RunQueue:
             cache[tid] = iscurrent
         return iscurrent
 
-    def validate_hashes(self, tocheck, data, currentcount=None, siginfo=False):
+    def validate_hashes(self, tocheck, data, currentcount=0, siginfo=False):
         valid = set()
         if self.hashvalidate:
             sq_data = {}
@@ -1601,7 +1601,7 @@ class RunQueue:
 
             tocheck.add(tid)
 
-        valid_new = self.validate_hashes(tocheck, self.cooker.data, None, True)
+        valid_new = self.validate_hashes(tocheck, self.cooker.data, 0, True)
 
         # Tasks which are both setscene and noexec never care about dependencies
         # We therefore find tasks which are setscene and noexec and mark their
@@ -1982,7 +1982,7 @@ class RunQueueExecute:
                             continue
                         logger.debug(1, "Task %s no longer deferred" % nexttask)
                         del self.sq_deferred[nexttask]
-                        valid = self.rq.validate_hashes(set([nexttask]), self.cooker.data, None, False)
+                        valid = self.rq.validate_hashes(set([nexttask]), self.cooker.data, 0, False)
                         if not valid:
                             logger.debug(1, "%s didn't become valid, skipping setscene" % nexttask)
                             self.sq_task_failoutright(nexttask)
@@ -2299,7 +2299,7 @@ class RunQueueExecute:
         for tid in changed:
             if tid not in self.rqdata.runq_setscene_tids:
                 continue
-            valid = self.rq.validate_hashes(set([tid]), self.cooker.data, None, False)
+            valid = self.rq.validate_hashes(set([tid]), self.cooker.data, 0, False)
             if not valid:
                 continue
             if tid in self.runq_running:
-- 
2.7.4


