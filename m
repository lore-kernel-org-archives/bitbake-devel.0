Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id 294EE73D11
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Apr 2015 22:04:13 +0000 (UTC)
Received: by patj18 with SMTP id j18so128158127pat.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Apr 2015 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id;
	bh=RewaBkAIP+PYRHXpsnEo2s6Ge/1LuvJQq26tamNT3OQ=;
	b=qsa0Peh2K9gEECqVvFEqaZJV6V6Fld6r38laysDUfCZX45H+AZekpz9E1O2oL5pIa8
	NrzWdlHIidUv5mTPAv1FyQH/fPAYbM/+pJ6QMCmBV50TVytQjAdDE5UWgJEpNAr0oIEf
	iPwyCV2KLIS3GU4TpIIwdOPZPY0M3quUju88eMXowv8Xja4BVGTYDlDrrO3Nh4GSwG57
	+GHTe5V27avEt30cYQSaG1603H4OC2KFivg2KGowgEB7tTAZT1u4VBIGZM72GpFP+kJw
	d5iPsLc122ZI63oB8ee5GSW2Wu/pXKNEYDJCsxDNf6VXe02iHWLd4KcYSmn5DnM37RqU
	8Tng==
X-Received: by 10.68.69.45 with SMTP id b13mr7523113pbu.150.1428098655342;
	Fri, 03 Apr 2015 15:04:15 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPSA id xj1sm8998608pbb.92.2015.04.03.15.04.13
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 03 Apr 2015 15:04:14 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Apr 2015 15:04:10 -0700
Message-Id: <1428098650-2345-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
Subject: [PATCH] runqueue: pass finalized metadata to scenequeue callbacks
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
X-List-Received-Date: Fri, 03 Apr 2015 22:04:14 -0000

This ensures that _append, _prepend, overrides, etc are functional when used
on sstate variables (e.g. SSTATE_DIR).

[YOCTO #7564]

Signed-off-by: Christopher Larson <kergoth@gmail.com>
---
 lib/bb/runqueue.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index c503980..b1fe6b8 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1155,7 +1155,7 @@ class RunQueue:
             sq_taskname.append(taskname)
             sq_task.append(task)
         call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
-        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
+        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.expanded_data }
         valid = bb.utils.better_eval(call, locs)
         for v in valid:
             valid_new.add(sq_task[v])
@@ -1331,7 +1331,7 @@ class RunQueueExecute:
             taskname = self.rqdata.runq_task[depid]
             taskdata[dep] = [pn, taskname, fn]
         call = self.rq.depvalidate + "(task, taskdata, notneeded, d)"
-        locs = { "task" : task, "taskdata" : taskdata, "notneeded" : self.scenequeue_notneeded, "d" : self.cooker.data }
+        locs = { "task" : task, "taskdata" : taskdata, "notneeded" : self.scenequeue_notneeded, "d" : self.cooker.expanded_data }
         valid = bb.utils.better_eval(call, locs)
         return valid
 
@@ -1400,7 +1400,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
             call = self.rq.setsceneverify + "(covered, tasknames, fnids, fns, d, invalidtasks=invalidtasks)"
             call2 = self.rq.setsceneverify + "(covered, tasknames, fnids, fns, d)"
-            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : self.rqdata.runq_task, "fnids" : self.rqdata.runq_fnid, "fns" : self.rqdata.taskData.fn_index, "d" : self.cooker.data, "invalidtasks" : invalidtasks }
+            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : self.rqdata.runq_task, "fnids" : self.rqdata.runq_fnid, "fns" : self.rqdata.taskData.fn_index, "d" : self.cooker.expanded_data, "invalidtasks" : invalidtasks }
             # Backwards compatibility with older versions without invalidtasks
             try:
                 covered_remove = bb.utils.better_eval(call, locs)
@@ -1820,7 +1820,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 sq_taskname.append(taskname)
                 sq_task.append(task)
             call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
-            locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
+            locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.expanded_data }
             valid = bb.utils.better_eval(call, locs)
 
             valid_new = stamppresent
-- 
2.2.1


