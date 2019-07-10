Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
	[209.85.221.54])
	by mail.openembedded.org (Postfix) with ESMTP id 5778374598
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:23 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id n9so4262448wru.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=8gRz8vznfUylRO/Dw6ZjEmO8nsM4VZHbZ5yA2aQzVJ4=;
	b=HAFUQjXjhlvjZBKm65hwvuwPLq1+L0z3MJYUebnKThINUNkknH/tG9JvZ1o/FKXe1Z
	oC1ImmGsGi/QXqayVMHAeBHCWCkTwxHdISa7bNB4wc1Mjdmm8ZavPNdZnFoUwsOrez5y
	ZtmEY5LIVPX0GbVSMgBtPomZwmI2y8EHCH3zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8gRz8vznfUylRO/Dw6ZjEmO8nsM4VZHbZ5yA2aQzVJ4=;
	b=pkMRwrVAi5X1JwJ7m0eLs6psVgFDT8+638vTepnNSUdnDviVUExMFiWn6UDIU/h8Kn
	BI25CcnouTHLilqx5tEV0QjBL4sG8MlIiyERSyg25bwWdlz+rOuviV0MDCFk6F6+G75n
	BTBsyZVAp830IRFAdhzpwWM3ViWuY8D/vT5WLZBelnrWJRkwa7nLbYveERzmoyJfIKf/
	Y2j8wyUwuJeetzPBoC+IRx+aUzdcuCbIuJpH1JpGiKJh4O6bNOOdR6D4drFuxg3Ppk4Z
	QO+/vmTXOfuTDbA6fddiIYXPeC918gnwqMNCIkifOMtNRVt08pey3KXPYOiq2r+BZp6F
	xD5g==
X-Gm-Message-State: APjAAAW8dkfQXIr809Vo/nJqIfi2RQ9xwa6xJ1UiM8U1Eg98jb92ij4t
	uopNppEoGuoa+Brad6SCJzqWUd4/cUI=
X-Google-Smtp-Source: APXvYqxilfdliZzB0/h+x8GUX+ywzRutYTQ4M1W9HjbsCHDcefJVC4qb0gKKern3fu6hdQaAQTHR0Q==
X-Received: by 2002:a5d:66c9:: with SMTP id k9mr215559wrw.354.1562802864027;
	Wed, 10 Jul 2019 16:54:24 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.23
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:53:57 +0100
Message-Id: <20190710235420.23825-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 03/26] runqueue: Remove now uneeded code
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:23 -0000
Content-Transfer-Encoding: 8bit

With the removal of the setcene verify code, this additional code block
is also now unneeded since tasks can't be forced at this point in the code
any move. This effectively reverts f21910157d873c030b149c4cdc5b57c5062ab5a6.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 19af73cb3c..6ac9fb1678 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1795,8 +1795,6 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         self.stampcache = {}
 
-        initial_covered = self.rq.scenequeue_covered.copy()
-
         # Mark initial buildable tasks
         for tid in self.rqdata.runtaskentries:
             if len(self.rqdata.runtaskentries[tid].depends) == 0:
@@ -1820,30 +1818,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         logger.debug(1, 'Skip list %s', sorted(self.rq.scenequeue_covered))
 
-        def removecoveredtask(tid):
-            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-            taskname = taskname + '_setscene'
-            bb.build.del_stamp(taskname, self.rqdata.dataCaches[mc], taskfn)
-            self.rq.scenequeue_covered.remove(tid)
-
-        toremove = self.rq.scenequeue_notcovered
-        for task in toremove:
+        for task in self.rq.scenequeue_notcovered:
             logger.debug(1, 'Not skipping task %s', task)
-        while toremove:
-            covered_remove = []
-            for task in toremove:
-                if task in self.rq.scenequeue_covered:
-                    removecoveredtask(task)
-                for deptask in self.rqdata.runtaskentries[task].depends:
-                    if deptask not in self.rq.scenequeue_covered:
-                        continue
-                    if deptask in toremove or deptask in covered_remove or deptask in initial_covered:
-                        continue
-                    logger.debug(1, 'Task %s depends on task %s so not skipping' % (task, deptask))
-                    covered_remove.append(deptask)
-            toremove = covered_remove
-
-        logger.debug(1, 'Full skip list %s', self.rq.scenequeue_covered)
 
         for mc in self.rqdata.dataCaches:
             target_pairs = []
-- 
2.20.1


