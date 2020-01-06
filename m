Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
	[209.85.216.47])
	by mail.openembedded.org (Postfix) with ESMTP id 83AC47FD39
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:12 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id r67so7765026pjb.0
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Rg2aUlKmyk1Wq73V3NdktdULv2/Nq/lk0pdlVAb/jXg=;
	b=vMHxV4sfGmyZvOq2A/JogEDu2tN69YfY0NoqTk82KtCsgusSNQw/cM2q4Kb7Uz+pud
	S/uij9UuAIKX6LbMd9cB+SYDh5xjjtNEw4tJGHSPQZEn3Kj0VVU5PBLyEo5yVQ7tMZdn
	XmgQlv7DrRiDQIEgO3+XfIx6JUE/i7H8zBhWxhsUIZpL/m3sMWGZkjSgH8DO1g9QiE9C
	exwnCKRZJhJnPvCN1AV5YA1qI3393z2DE66BrsNAs/DWk180sIgRNxWd5jkhXXCqew13
	itJtRoCWEksXNFNcYiUMgSwW3vWporaTwrfLeBLutpcQg+/NfaF155qxWpehD0FqYkSi
	Ou3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Rg2aUlKmyk1Wq73V3NdktdULv2/Nq/lk0pdlVAb/jXg=;
	b=TK+VWOGClNE1i57rwPcg9PQY6L9d8HtgBkc0+NCFMZEiVJiG+U31Nebu7ApJkPM01t
	NvyO3CzXFmcQBzyBqnQCs5BYuF5cAd0xNffjV6HVuFy29VKc53t525c+22RyvRkclXsL
	feHGwzPQbVNNFRMNDRjVfDsnTroKaluYTqKwn+wXBJGqM1LlXYNorVFRhYB+TV2QLhj6
	spjXizJWRFqJpqUCkqcRwpAPa4Q7HqSOqTJD825ZagXkYDPAKG7tHoXaGbWFFUeABTBe
	R9L6sBr4ffL1rVsv40MXDBpCPGhIGNxfTt/6BPTUTC54/YrTpBUhsW3nCsx/D9WRXSEM
	i9eA==
X-Gm-Message-State: APjAAAWQ87AIXI1Ez1mRS/Q2OKSaLosTmqGE7Yn/Ly5hjwyFpzXcODPr
	VS0d1jLQX6b8YsxKGqWPF22js8NU
X-Google-Smtp-Source: APXvYqwTLJgLBir0LxOlLdtB6v9azJGZST2Wu7OLoZ/DNozTv64dI9soGxciBacYDH6sYufLv+k/3g==
X-Received: by 2002:a17:90a:30a4:: with SMTP id
	h33mr43737205pjb.50.1578328033453; 
	Mon, 06 Jan 2020 08:27:13 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.12
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:12 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:44 -0800
Message-Id: <39cc4930676970b2e51b99a778f5d5d9b5259991.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 23/25] runqueue: Fix task dependency corner case in sanity test
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:12 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

A corner case was identified where tasks with valid stamps from previous
builds need to be accounted for in the new sanity test in the migration
code. Add a variable to track such completed tasks to ensure the sanity
test works correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d517b1ef13ca7ab2fb4d761d3bd3b9fb7c591514)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/runqueue.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 56ca2529..6e3a91b8 100644
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
2.17.1


