Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
	[209.85.128.52])
	by mail.openembedded.org (Postfix) with ESMTP id ACFF97F33A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 16:16:40 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id g67so4515574wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Aug 2019 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=+/133Re6hhnwVxEokFkjenn2Wi/8DXKGUZx86/hWH4Q=;
	b=Wm0eTXpI5oYAAW+VeHMHk0D3Hx5vSAFiH2bQ8/j4Iw8vTHmrmiuZdNp1J0Rp5FI38d
	67TUWr7DYFWVMhCBaaaa8lhBm4GaN6bnpWhh7+YWdbEB+RHF8mcSho1f/V9Xq0owE1dJ
	3rs0rhoPkSPwrEJ7xa1OBGJKRzuJ/FOkU8gzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+/133Re6hhnwVxEokFkjenn2Wi/8DXKGUZx86/hWH4Q=;
	b=A4cq4jcwTphg5rJTHzu4r3ybbtd1JLTAVLqKTWDPJCRAZxtue+briQdJrYTAWMkI8I
	LdL6JQg+2++rtXD6uIcYtyAwoIy0iCRIbLlPMbSLGD2cpUa9js1E7DNYOxODJBjFzgNM
	IxRUozpRzluUi2NSEkksG921LtnTaeVfrpjTAu9ozbkPAhQiUCar/2YmtoywKPT+TgSZ
	9JgH9owGfBtH0gaaIzj6rY6y7khAU6ee5yEVNjpZ/NKN81Tn8qds+79jSHhZ+7217sYs
	doMyCqs2F8nyx0dVjHuVXv8KJkLPacPSrnU6Id5p14KyAkgk5mFHGd8Z1alz35UL9bxR
	MmUg==
X-Gm-Message-State: APjAAAUsqJWVfZGx9qH2S3Qaz1JKwb1rFnA10I8LF7efSRcpSAcyLEYr
	PjVvvAFvLECb3UCba50ZHWwzBrqh2LHvbg==
X-Google-Smtp-Source: APXvYqxV54rV2c5Zg3GOFNmN1QkIgQBYn5KrK3A7BtSrkD44HsDvvryyIhVA4ZhDecylXAoNSUVmmA==
X-Received: by 2002:a7b:ca54:: with SMTP id m20mr7336341wml.102.1565972201009; 
	Fri, 16 Aug 2019 09:16:41 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	t8sm13108148wra.73.2019.08.16.09.16.39
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 16 Aug 2019 09:16:40 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Aug 2019 17:16:36 +0100
Message-Id: <20190816161637.25781-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816161637.25781-1-richard.purdie@linuxfoundation.org>
References: <20190816161637.25781-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/3] runqueue: Further optimise holdoff tasks
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
X-List-Received-Date: Fri, 16 Aug 2019 16:16:41 -0000
Content-Transfer-Encoding: 8bit

There are other data structures which can be reprocessed at the same
time as holdoff_tasks, further improving build efficiency in various
places.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 49 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 0c17a23bdc..a98ccddd09 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2040,6 +2040,8 @@ class RunQueueExecute:
             if self.can_start_task():
                 return True
 
+        self.update_holdofftasks()
+
         if not self.sq_live and not self.sqdone and not self.sq_deferred and not self.updated_taskhash_queue and not self.holdoff_tasks:
             logger.info("Setscene tasks completed")
 
@@ -2058,8 +2060,6 @@ class RunQueueExecute:
                 self.rq.state = runQueueComplete
                 return True
 
-        self.update_holdofftasks()
-
         if self.cooker.configuration.setsceneonly:
             task = None
         else:
@@ -2200,6 +2200,29 @@ class RunQueueExecute:
 
         if not self.holdoff_need_update:
             return
+
+        notcovered = set(self.scenequeue_notcovered)
+        notcovered |= self.cantskip
+        for tid in self.scenequeue_notcovered:
+            notcovered |= self.sqdata.sq_covered_tasks[tid]
+        notcovered |= self.sqdata.unskippable.difference(self.rqdata.runq_setscene_tids)
+        notcovered.intersection_update(self.tasks_scenequeue_done)
+
+        covered = set(self.scenequeue_covered)
+        for tid in self.scenequeue_covered:
+            covered |= self.sqdata.sq_covered_tasks[tid]
+        covered.difference_update(notcovered)
+        covered.intersection_update(self.tasks_scenequeue_done)
+
+        for tid in notcovered | covered:
+            if len(self.rqdata.runtaskentries[tid].depends) == 0:
+                self.setbuildable(tid)
+            elif self.rqdata.runtaskentries[tid].depends.issubset(self.runq_complete):
+                 self.setbuildable(tid)
+
+        self.tasks_covered = covered
+        self.tasks_notcovered = notcovered
+
         self.holdoff_tasks = set()
 
         for tid in self.rqdata.runq_setscene_tids:
@@ -2359,28 +2382,6 @@ class RunQueueExecute:
                         new.add(dep)
             next = new
 
-        notcovered = set(self.scenequeue_notcovered)
-        notcovered |= self.cantskip
-        for tid in self.scenequeue_notcovered:
-            notcovered |= self.sqdata.sq_covered_tasks[tid]
-        notcovered |= self.sqdata.unskippable.difference(self.rqdata.runq_setscene_tids)
-        notcovered.intersection_update(self.tasks_scenequeue_done)
-
-        covered = set(self.scenequeue_covered)
-        for tid in self.scenequeue_covered:
-            covered |= self.sqdata.sq_covered_tasks[tid]
-        covered.difference_update(notcovered)
-        covered.intersection_update(self.tasks_scenequeue_done)
-
-        for tid in notcovered | covered:
-            if len(self.rqdata.runtaskentries[tid].depends) == 0:
-                self.setbuildable(tid)
-            elif self.rqdata.runtaskentries[tid].depends.issubset(self.runq_complete):
-                 self.setbuildable(tid)
-
-        self.tasks_covered = covered
-        self.tasks_notcovered = notcovered
-
         self.holdoff_need_update = True
 
     def sq_task_completeoutright(self, task):
-- 
2.20.1


