Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
	[209.85.216.43])
	by mail.openembedded.org (Postfix) with ESMTP id 031107FA28
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:33 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id r67so5244013pjb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Rg2aUlKmyk1Wq73V3NdktdULv2/Nq/lk0pdlVAb/jXg=;
	b=he4uKHj3mYGJZEU8uQXq7vwfojZiDzw7whquOIlm2gVU2byBo/hIrZYqkmHPF0MnT0
	pxxEIK2jpkrVEDiKK5SvpX7j+0Cgjt3QcYYBC5DBUM8ecygJ3pRfI4cDRS85uT7zFVou
	94BaK8UltP58Xoy2i/J86cgP7uh/cuIrCUL1erG35b5v9LcCupxD9ZG9AtuRx14Fw6uH
	gM/FhJyvV/5DJ4HDZR8hlYwGaRaBYx91O9TvCgwlz/frM1oW1mzm790SFDQCcNuCXCXP
	CUHIMJizzu6PZ29aH3puQv154JOCrmeawstP/44advB9Q75uEjn05bB7ed94G0eORvNR
	IGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Rg2aUlKmyk1Wq73V3NdktdULv2/Nq/lk0pdlVAb/jXg=;
	b=sncyVFY+cUF8NRdVzJFa/y0vbg2FkvUexFkjucz1KsPOA8EsdkiYIzX2+rFywxkvp6
	LsfB4J2MBNsINRuZ5UY0o05AlfvKEOZozAMVfNfdQfwKKn2DAOy+jIAHPxrdqmdy22LN
	iGOyewTtMFv57ofFb2QpmOueGPNdveL5ITZzBib9YK6wTQ9ADLRGlHVT+U/D+e00Tr70
	Gn6rDLsrpAynu4aPlRJmLSQFIm3Cpa75yhS3A1rq72EA3fBClLNpp3eEW9WYMNVbak44
	YS4f+fiEBr7Alqugr1KwG5oNme2314K5CaajgMCxJQ5roX4QtKfXFu1JFRbaDXp85Ug9
	VmoA==
X-Gm-Message-State: APjAAAVM2v/ttAabX3AOVJT20L302vPR0GV8y6lZxqiFcvi1/b0MstLb
	8+8+0AWHZX+WKTKtiRAtuFNlumygGIs=
X-Google-Smtp-Source: APXvYqw+xGPMA7l0MUjbx42kCs0fAZL/phNDKz4fMPYR8bPuPv3Bgm3V7MTlyQc6xWDJ0MD6cJ/3kw==
X-Received: by 2002:a17:902:9302:: with SMTP id
	bc2mr78676405plb.328.1578104614877; 
	Fri, 03 Jan 2020 18:23:34 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.34
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:34 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:23:08 -0800
Message-Id: <39cc4930676970b2e51b99a778f5d5d9b5259991.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578104305.git.akuster808@gmail.com>
References: <cover.1578104305.git.akuster808@gmail.com>
Subject: [PATCH 23/25] runqueue: Fix task dependency corner case in sanity test
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:34 -0000

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


