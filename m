Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
	[209.85.214.65])
	by mail.openembedded.org (Postfix) with ESMTP id 7D68078589
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Mar 2018 18:35:35 +0000 (UTC)
Received: by mail-it0-f65.google.com with SMTP id z7-v6so16884184iti.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Mar 2018 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ZGv8GW7vh09s3PMi6WA+WPq8vgWd9bryFERF6ps1rVY=;
	b=QixcSDiHyRvH0iWGOpRaNMgw7XkKJ9crTqthS7NOzwUvm2V8dzQkMoZsyPwKN5LUM2
	Dzdnom+E8gukkDbTBTModI2x9OwdtWcTfYzVna4ryjLyqRMjksFddLxp1PsiNTa8ASH0
	TTSCeZUtdCQsfW7mbKpwswXtOnD0TeJBfoLKpb9pk/LdZimq3EXYjcSRp84BVMBNCmFe
	ywZ4lWCzsvod9pH3dR8zkkSYA/4yD0LPcYL2ADsNvb5iS2EJKsK26Z/786aYWcYWuIse
	dM4FkfwG/5XeQ8U15j4vimjGtTpMR4OLC5UckAm6Zl6/JLaFKUQCCQf/XHs0pevPSFRK
	2mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ZGv8GW7vh09s3PMi6WA+WPq8vgWd9bryFERF6ps1rVY=;
	b=GnqmilFC1C9dHt0VRKppBypDfAp1dbiMapHxZQTwrxAijkQDxlCbQapVj1I0OIqEhs
	AvV5uwVzAqtymf9RRa9uHDgaw004mAdbkKY8zH63YAeKQLJBoPsIMqhJDZc/7otS1Lld
	NKkcrH13Hg6ny7+lMd7h5AcTLT2AGVhzQhnv5S2Cmo0XlNlf8GOndfJA0ejoLEihCLGe
	7OZ5EeDMg8b/BkUDaF0U32nuM00x9bWqe9ngOqELKX5OzM/HtnnBnaVrc2+1mXzmMbxP
	hWbkMNFHhoNA/8NFs98s7LzaxYuUEiz6BEmB6no4ax6g3fU4H9XYVYCz/Tgeakr+nWml
	vIhw==
X-Gm-Message-State: AElRT7EiIaIMWweua8ktpGRVVqhY1VS3CE+yGcnc3KJQD9hoZtou9tN+
	dazsvdStEzVblLMQYzL5ONKDfyY8
X-Google-Smtp-Source: AIpwx497yhhOuhuiyiKT6cbjNdjbmM3XTLfa9xf4XzUtoXvFXON0c2yWmlMBS4EM10pTCaVOcSAvig==
X-Received: by 2002:a24:40ca:: with SMTP id
	n193-v6mr366614ita.61.1522175736203; 
	Tue, 27 Mar 2018 11:35:36 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.googlemail.com with ESMTPSA id
	p142-v6sm1465070itb.24.2018.03.27.11.35.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 27 Mar 2018 11:35:35 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Mar 2018 13:34:27 -0500
Message-Id: <20180327183427.13983-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180327183427.13983-1-JPEWhacker@gmail.com>
References: <20180327183427.13983-1-JPEWhacker@gmail.com>
Subject: [RFC] bitbake: respect force flag in runall and runonly
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
X-List-Received-Date: Tue, 27 Mar 2018 18:35:35 -0000

Specifying the force flag will now cause runall and runonly to
invalidate the tasks before running them.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f2e52cf758c..9ae5c9cb177 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -795,6 +795,21 @@ class RunQueueData:
             for depend in depends:
                 mark_active(depend, depth+1)
 
+        def invalidate_task(tid, error_nostamp):
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+            taskdep = self.dataCaches[mc].task_deps[taskfn]
+            if fn + ":" + taskname not in taskData[mc].taskentries:
+                logger.warning("Task %s does not exist, invalidating this task will have no effect" % taskname)
+            if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
+                if error_nostamp:
+                    bb.fatal("Task %s is marked nostamp, cannot invalidate this task" % taskname)
+                else:
+                    bb.debug(1, "Task %s is marked nostamp, cannot invalidate this task" % taskname)
+            else:
+                logger.verbose("Invalidate task %s, %s", taskname, fn)
+                bb.parse.siggen.invalidate_task(taskname, self.dataCaches[mc], fn)
+
+
         self.target_tids = []
         for (mc, target, task, fn) in self.targets:
 
@@ -863,6 +878,8 @@ class RunQueueData:
 
                 for tid in list(runall_tids):
                     mark_active(tid,1)
+                    if self.cooker.configuration.force:
+                        invalidate_task(tid, False)
 
             for tid in list(self.runtaskentries.keys()):
                 if tid not in runq_build:
@@ -884,6 +901,8 @@ class RunQueueData:
 
                 for tid in list(runonly_tids):
                     mark_active(tid,1)
+                    if self.cooker.configuration.force:
+                        invalidate_task(tid, False)
 
             for tid in list(self.runtaskentries.keys()):
                 if tid not in runq_build:
@@ -1040,7 +1059,7 @@ class RunQueueData:
 
         # Create a whitelist usable by the stamp checks
         self.stampfnwhitelist = {}
-        for mc in self.taskData: 
+        for mc in self.taskData:
             self.stampfnwhitelist[mc] = []
             for entry in self.stampwhitelist.split():
                 if entry not in self.taskData[mc].build_targets:
@@ -1060,20 +1079,6 @@ class RunQueueData:
                     continue
                 self.runq_setscene_tids.append(tid)
 
-        def invalidate_task(tid, error_nostamp):
-            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-            taskdep = self.dataCaches[mc].task_deps[taskfn]
-            if fn + ":" + taskname not in taskData[mc].taskentries:
-                logger.warning("Task %s does not exist, invalidating this task will have no effect" % taskname)
-            if 'nostamp' in taskdep and taskname in taskdep['nostamp']:
-                if error_nostamp:
-                    bb.fatal("Task %s is marked nostamp, cannot invalidate this task" % taskname)
-                else:
-                    bb.debug(1, "Task %s is marked nostamp, cannot invalidate this task" % taskname)
-            else:
-                logger.verbose("Invalidate task %s, %s", taskname, fn)
-                bb.parse.siggen.invalidate_task(taskname, self.dataCaches[mc], fn)
-
         self.init_progress_reporter.next_stage()
 
         # Invalidate task if force mode active
-- 
2.14.3


