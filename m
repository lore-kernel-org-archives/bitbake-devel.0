Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
	[209.85.221.43])
	by mail.openembedded.org (Postfix) with ESMTP id 489827FC02
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jan 2020 11:03:10 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id t2so36816699wrr.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 Jan 2020 03:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=AnPwVh9MIR6rSupelb+iaAWRRFV1KT1AkH15l4qa7e0=;
	b=WbGCT/VimafRXeS+VSRi+yZ40rcOxgu7n571CuRWBzzt+A5K/avcDGcGoLesbe2cV6
	GWsLThGHoWsrOr90AsjL1nNiXiAV+SxgAq+wuRLXTC2RMJjkB8tu/I7ZNSEs83KwXA1q
	EOzQT7nbj2PUNKnAaPjEYPZlucp98cvcuiOHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=AnPwVh9MIR6rSupelb+iaAWRRFV1KT1AkH15l4qa7e0=;
	b=cH350hvmJ5IPTH8smiOvQjZIJBI3jsA0yEaWHPUkgb/511bRkpvRHZ28wD+CyoWm3C
	M3KJxAsqDKBebZCx9F/aK/buwdZGP3LqY9YIXyT1tLMhSw+imLfV4vdu4L1kKBei6CQZ
	0B8mrjV6a4nnUBQH2ydszTIr64LjFEFoxPF1c/GX1QzCnKN7YItwrQ1C0noROzjaLeH/
	E0uNwoLv9leU9HLzN0qfBNoqkDnnieL2do19HZjS22x1e944Xj0iYrNhVBPUZuMWKd9/
	a+D+R/pTwOmoigJo+rL6Rzk/6lxEsOMxhA0LOq9BS4Y/DO5de4v++s7jEwz3g7LIA8tu
	xcSg==
X-Gm-Message-State: APjAAAVo3XDgLoMuQ3JiqRk5/dUx+YOTLArvrgjqM96WepXdc+FSZBJL
	E6Lq9oZRo0/dJ+EUtWlb70VrLB6U7xk=
X-Google-Smtp-Source: APXvYqwH1IJa2BxMO/kjoCzKFsBRQY+82oGi/7O7KtsFMzx+0t8BlSCfqVSqezJLZM0RnbGzOQIx6g==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr74287891wrm.135.1577876590680;
	Wed, 01 Jan 2020 03:03:10 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	a1sm5250672wmj.40.2020.01.01.03.03.09
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 01 Jan 2020 03:03:10 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jan 2020 11:03:03 +0000
Message-Id: <20200101110305.12317-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200101110305.12317-1-richard.purdie@linuxfoundation.org>
References: <20200101110305.12317-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/5] runqueue: Fix task dependency corner case in sanity test
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
X-List-Received-Date: Wed, 01 Jan 2020 11:03:10 -0000
Content-Transfer-Encoding: 8bit

A corner case was identified where tasks with valid stamps from previous
builds need to be accounted for in the new sanity test in the migration
code. Add a variable to track such completed tasks to ensure the sanity
test works correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 56ca2529ca..6e3a91b850 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1708,6 +1708,7 @@ class RunQueueExecute:
         self.runq_buildable = set()
         self.runq_running = set()
         self.runq_complete = set()
+        self.runq_tasksrun = set()
 
         self.build_stamps = {}
         self.build_stamps2 = []
@@ -1893,6 +1894,7 @@ class RunQueueExecute:
         self.stats.taskCompleted()
         bb.event.fire(runQueueTaskCompleted(task, self.stats, self.rq), self.cfgData)
         self.task_completeoutright(task)
+        self.runq_tasksrun.add(task)
 
     def task_fail(self, task, exitcode):
         """
@@ -2092,6 +2094,7 @@ class RunQueueExecute:
                 logger.debug(2, "Stamp current task %s", task)
 
                 self.task_skip(task, "existing")
+                self.runq_tasksrun.add(task)
                 return True
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
@@ -2353,7 +2356,7 @@ class RunQueueExecute:
             if tid in self.tasks_scenequeue_done:
                 self.tasks_scenequeue_done.remove(tid)
             for dep in self.sqdata.sq_covered_tasks[tid]:
-                if dep in self.runq_complete:
+                if dep in self.runq_complete and dep not in self.runq_tasksrun:
                     bb.error("Task %s marked as completed but now needing to rerun? Aborting build." % dep)
                     self.failed_tids.append(tid)
                     self.rq.state = runQueueCleanUp
-- 
2.20.1


