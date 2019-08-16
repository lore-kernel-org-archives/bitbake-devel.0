Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
	[209.85.221.47])
	by mail.openembedded.org (Postfix) with ESMTP id 1BFA57F356
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 16:16:38 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id g17so2067381wrr.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 09:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=0IdwtJ2o9pTDUr3Wvvkb6l/CLpJYN4IZUwYm2VeSZQ4=;
	b=gDqdanXB3LoiYXYr0mdxSDN20KxnH8i6l1+Vl3ts3s20HxRkDE54yXz2eeHuvEovaJ
	G2oKFfq5l6FPxIuirSnOdRN3/tiJ8Wz1yHsJYOGtGtZ+0h3bJ4F4HucmBBHRqv2k1fvq
	BLvEVK65iJguZOQjmW6wdyr/bgGcSLZDGmcOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=0IdwtJ2o9pTDUr3Wvvkb6l/CLpJYN4IZUwYm2VeSZQ4=;
	b=D23Q4xd5vIyXTKij6Ty0m95272+/zeCA+tP+cmay9ahTDm7Rqb7OBqzaCR0LPLLBYs
	VOJQnapL3sRodMqNbPTXrpGQRUb39PGGaMvesq2SkXcOQ01N23ALlAW4VZmTCUORrOyo
	aloA4YAk2M9B3GC3wX5gtd7ufR8U2phoM74bVSUtM2Ifb4Sc+QfyS8ikrJ3SRw0A36zW
	vyNSj3/BWDNqsGG/uU4JUwQZAOsTazT4n1AqsPW7/ryC4PMJXv2wnj6MbsOdkWKKzk/D
	bDEdxag9WtND1VH7lLNgAf/Bc0quhnXkTPgHvfnnL3jEWehkXnsPM+VoL5bCikv2J/x2
	hhIA==
X-Gm-Message-State: APjAAAWcBL1GzAieVSOxvhqmeOaSfC+hDz6tBk8/OP7tNbHGdXIcV75c
	hUuD+7QaFhRJLQlilab+SVGazn6Qp512ww==
X-Google-Smtp-Source: APXvYqx+eJtDemyeaLbZgTBVLgthOMQ6REflzVwi2qyKEGn10MgbhU9U/CNYpnvTi8Xocc0P64m1NA==
X-Received: by 2002:adf:cd08:: with SMTP id w8mr4369319wrm.147.1565972199551; 
	Fri, 16 Aug 2019 09:16:39 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	t8sm13108148wra.73.2019.08.16.09.16.38
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 16 Aug 2019 09:16:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2019 17:16:35 +0100
Message-Id: <20190816161637.25781-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/3] runqueue: Optimise holdoff task handling
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
X-List-Received-Date: Fri, 16 Aug 2019 16:16:39 -0000
Content-Transfer-Encoding: 8bit

We don't need to process the holdoff task list until we're executing tasks
which saves some data manipulation, at the cost of some data structures
not being correct at all times. This saves significant amounts of time
in various profile charts of larger builds.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 88212ca00c..0c17a23bdc 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1711,6 +1711,7 @@ class RunQueueExecute:
         self.stampcache = {}
 
         self.holdoff_tasks = set()
+        self.holdoff_need_update = True
         self.sqdone = False
 
         self.stats = RunQueueStats(len(self.rqdata.runtaskentries))
@@ -2057,6 +2058,8 @@ class RunQueueExecute:
                 self.rq.state = runQueueComplete
                 return True
 
+        self.update_holdofftasks()
+
         if self.cooker.configuration.setsceneonly:
             task = None
         else:
@@ -2194,6 +2197,9 @@ class RunQueueExecute:
         return taskdepdata
 
     def update_holdofftasks(self):
+
+        if not self.holdoff_need_update:
+            return
         self.holdoff_tasks = set()
 
         for tid in self.rqdata.runq_setscene_tids:
@@ -2205,6 +2211,8 @@ class RunQueueExecute:
                 if dep not in self.runq_complete:
                     self.holdoff_tasks.add(dep)
 
+        self.holdoff_need_update = False
+
     def process_possible_migrations(self):
 
         changed = set()
@@ -2324,7 +2332,7 @@ class RunQueueExecute:
             self.sqdone = False
 
         if changed:
-            self.update_holdofftasks()
+            self.holdoff_need_update = True
 
     def scenequeue_updatecounters(self, task, fail=False):
 
@@ -2373,7 +2381,7 @@ class RunQueueExecute:
         self.tasks_covered = covered
         self.tasks_notcovered = notcovered
 
-        self.update_holdofftasks()
+        self.holdoff_need_update = True
 
     def sq_task_completeoutright(self, task):
         """
-- 
2.20.1


