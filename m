Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
	[209.85.221.67])
	by mail.openembedded.org (Postfix) with ESMTP id 3190C7F023
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:40 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id j8so133693wrj.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=g3aMOXWcFF8siAIuiKNEfjE6Z4bkHn4SHq72ymV6b8U=;
	b=H6Z/L2KIklEQPfqS2M0pY7+Ww1RFhLCmJ1DTsXrIDp2bsApuMtpjQXC0QjjyXXUAFP
	sbEqOmgVWRqLdMMmSmdFCQvnd413WORrZ+/trC1JSHaY7kqQoV7mbrw/XMeAbuKtUAYE
	LZxWLU9MsHiX4QD+bQYRToDak3qPYHwkyYA1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=g3aMOXWcFF8siAIuiKNEfjE6Z4bkHn4SHq72ymV6b8U=;
	b=RJUI4DOkP/do7Cwf8aLvCohHQAbYYiew488NfUYppjcRpOaHrgdcVsLOj/lTO20Otu
	/MpKa+WTI/OffyIGR4vgl44ieWWnFxfVwXCT2f9bkkohPBZeiklN0AP/c0SUlr4iJvpM
	SMDSPMIxWklJ0yqVP15UBBYEOomfr9Im9Q3xFwwFqAoTxlQL60C397bZKaKJ6JDXHJqn
	Jo7vwVHNO6POk+nZlGJqmn/YEx3Gc0hm6kJ4o4H9/PQcFpU/5RYAtT4NnOTVxSu4/vwo
	PKqof10nEZMKet1KiaBe3BgNdWpGpiyjGelsfOOzlwB49qCSIcnqmM4HkCwfhTsvFM6t
	uqCQ==
X-Gm-Message-State: APjAAAVRxqHyOctVgCJwzY1YUUrHtVhqsaUbi6hPsArnPZHVoHTGyoux
	+zscuBXkWuQvxT6ieMuGQ/mnZuPcO58=
X-Google-Smtp-Source: APXvYqwNRQUJXIAWnApT8xNjrdGIs/7XF1tDzQSqGf34r1B4gKiWaYnbHQk21HDbJDx26G8WwaCMhQ==
X-Received: by 2002:adf:de90:: with SMTP id w16mr217292wrl.217.1562802880854; 
	Wed, 10 Jul 2019 16:54:40 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.40
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:40 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:15 +0100
Message-Id: <20190710235420.23825-21-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 21/26] runqueue: Clarify scenequeue_covered vs. tasks_covered
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:40 -0000
Content-Transfer-Encoding: 8bit

It wasn't clear whether the variable contained just setscene covered
tasks or all covered tasks. We need both sets of data so lets just have
two clearly named variables.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 580323f285..53cf4c5c82 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1693,7 +1693,7 @@ def process_setscene_whitelist(rq, rqdata, stampcache, sched, rqex):
     def check_norun_task(tid, showerror=False):
         (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
         # Ignore covered tasks
-        if tid in rqex.scenequeue_covered:
+        if tid in rqex.tasks_covered:
             return False
         # Ignore stamped tasks
         if rq.check_stamp_task(tid, taskname, cache=stampcache):
@@ -1768,7 +1768,10 @@ class RunQueueExecute:
         if self.number_tasks <= 0:
              bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
 
+        # List of setscene tasks which we've covered
         self.scenequeue_covered = set()
+        # List of tasks which are covered (including setscene ones)
+        self.tasks_covered = set()
         self.scenequeue_notcovered = set()
         self.scenequeue_notneeded = set()
 
@@ -1958,7 +1961,7 @@ class RunQueueExecute:
         if task is not None:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(task)
 
-            if task in self.scenequeue_covered:
+            if task in self.tasks_covered:
                 logger.debug(2, "Setscene covered task %s", task)
                 self.task_skip(task, "covered")
                 return True
@@ -2089,6 +2092,7 @@ class RunQueueExecute:
 
         logger.debug(1, 'Found task %s which could be accelerated', task)
         self.scenequeue_covered.add(task)
+        self.tasks_covered.add(task)
         self.scenequeue_updatecounters(task)
 
     def sq_check_taskfail(self, task):
@@ -2489,24 +2493,24 @@ def start_runqueue_tasks(rqexec):
         for tid in rqexec.rqdata.runtaskentries:
             if len(rqexec.rqdata.runtaskentries[tid].depends) == 0:
                 rqexec.setbuildable(tid)
-            if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.scenequeue_covered):
-                rqexec.scenequeue_covered.add(tid)
+            if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.tasks_covered):
+                rqexec.tasks_covered.add(tid)
 
         found = True
         while found:
             found = False
             for tid in rqexec.rqdata.runtaskentries:
-                if tid in rqexec.scenequeue_covered:
+                if tid in rqexec.tasks_covered:
                     continue
                 logger.debug(1, 'Considering %s: %s' % (tid, str(rqexec.rqdata.runtaskentries[tid].revdeps)))
 
-                if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.scenequeue_covered):
+                if len(rqexec.rqdata.runtaskentries[tid].revdeps) > 0 and rqexec.rqdata.runtaskentries[tid].revdeps.issubset(rqexec.tasks_covered):
                     if tid in rqexec.scenequeue_notcovered:
                         continue
                     found = True
-                    rqexec.scenequeue_covered.add(tid)
+                    rqexec.tasks_covered.add(tid)
 
-        logger.debug(1, 'Skip list %s', sorted(rqexec.scenequeue_covered))
+        logger.debug(1, 'Skip list %s', sorted(rqexec.tasks_covered))
 
         for task in self.rq.scenequeue_notcovered:
             logger.debug(1, 'Not skipping task %s', task)
-- 
2.20.1


