Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
	[209.85.221.54])
	by mail.openembedded.org (Postfix) with ESMTP id 978DA74598
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:22 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id j8so133259wrj.9
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=xiUyQmgGuhWWog0XF9OVeMRFKirlhDpfVwREpj0lEM0=;
	b=M3h5eR0yORILvwvwRgNGqTbQJKPsvRaNSTqwMx1rU6jG1pu0OIvhJg2cdgy7H2tpMc
	5+G2quWpwxJvwHFOfWQKE43voI/BNeyu076MVmuSLGlaDw5bHkor7qAPuFUL0KZI7pFN
	btCAGMDmiBrDyOH9fq6HkM+qpnQz8sqEBL4Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=xiUyQmgGuhWWog0XF9OVeMRFKirlhDpfVwREpj0lEM0=;
	b=FIWs/aqgyyNR1mZcdhmdNUUjnJ7bUuGz28j9K1jtZTeU39hJnUWYJNJoMyG0NzlOuH
	m5NF9dMD8LoT9RJbbmoiAv/pkiNSClpp3k5XJveMmbbUn5uo/eBF/x9ayw73YDz5c47o
	yNgBNXWonYqJXw248QNnXEw0MMmbo4vE7ml7odYWJpUcp9Fiy8M70PsEc5RdGl4VO7dd
	HdnrJLbuFUOgx8G/MBfFhN7jA3TeCTDb9g5Ee35SLlheiM/b5xnsm4/ugrxvCIwHmKb5
	OliM9a0xUY0QLHKjHr8d2pjjPZIUP5DO+cXapJx0EPsbF6DKgPGJa8L/TGKpCfwuhPsC
	xnlg==
X-Gm-Message-State: APjAAAVJ93kVgjmqqJyiZbI1Bes5avbDstOju8v22Vw+VFyKp+boW5pJ
	yuLrEsBZdUBofjdOqkTeyAa48lXjl68=
X-Google-Smtp-Source: APXvYqyAEeOPgiRY3syLScHGrB2zwQAsfYH5T71uImV+yYl2e1A+Y8eb4olpjss6e3OoIP1dg3hcrQ==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr228612wrw.276.1562802863263; 
	Wed, 10 Jul 2019 16:54:23 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.22
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:22 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:53:56 +0100
Message-Id: <20190710235420.23825-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 02/26] runqueue: Drop unused BB_SETSCENE_VERIFY_FUNCTION2
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:22 -0000
Content-Transfer-Encoding: 8bit

Nothing in OE-Core uses this and hasn't since 2017. It wasn't needed by core
metadata since the switch to recipe specific sysroots.

Since this function would be hard to implement with the planned changes to
runqueue, drop it which allows simplification and further code cleanup.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b19b524e77..19af73cb3c 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1194,7 +1194,6 @@ class RunQueue:
 
         self.stamppolicy = cfgData.getVar("BB_STAMP_POLICY") or "perfile"
         self.hashvalidate = cfgData.getVar("BB_HASHCHECK_FUNCTION") or None
-        self.setsceneverify = cfgData.getVar("BB_SETSCENE_VERIFY_FUNCTION2") or None
         self.depvalidate = cfgData.getVar("BB_SETSCENE_DEPVALID") or None
 
         self.state = runQueuePrepare
@@ -1819,32 +1818,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
                     found = True
                     self.rq.scenequeue_covered.add(tid)
 
-        logger.debug(1, 'Skip list (pre setsceneverify) %s', sorted(self.rq.scenequeue_covered))
-
-        # Allow the metadata to elect for setscene tasks to run anyway
-        covered_remove = set()
-        if self.rq.setsceneverify:
-            invalidtasks = []
-            tasknames = {}
-            fns = {}
-            for tid in self.rqdata.runtaskentries:
-                (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-                taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
-                fns[tid] = taskfn
-                tasknames[tid] = taskname
-                if 'noexec' in taskdep and taskname in taskdep['noexec']:
-                    continue
-                if self.rq.check_stamp_task(tid, taskname + "_setscene", cache=self.stampcache):
-                    logger.debug(2, 'Setscene stamp current for task %s', tid)
-                    continue
-                if self.rq.check_stamp_task(tid, taskname, recurse = True, cache=self.stampcache):
-                    logger.debug(2, 'Normal stamp current for task %s', tid)
-                    continue
-                invalidtasks.append(tid)
-
-            call = self.rq.setsceneverify + "(covered, tasknames, fns, d, invalidtasks=invalidtasks)"
-            locs = { "covered" : self.rq.scenequeue_covered, "tasknames" : tasknames, "fns" : fns, "d" : self.cooker.data, "invalidtasks" : invalidtasks }
-            covered_remove = bb.utils.better_eval(call, locs)
+        logger.debug(1, 'Skip list %s', sorted(self.rq.scenequeue_covered))
 
         def removecoveredtask(tid):
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
@@ -1852,9 +1826,9 @@ class RunQueueExecuteTasks(RunQueueExecute):
             bb.build.del_stamp(taskname, self.rqdata.dataCaches[mc], taskfn)
             self.rq.scenequeue_covered.remove(tid)
 
-        toremove = covered_remove | self.rq.scenequeue_notcovered
+        toremove = self.rq.scenequeue_notcovered
         for task in toremove:
-            logger.debug(1, 'Not skipping task %s due to setsceneverify', task)
+            logger.debug(1, 'Not skipping task %s', task)
         while toremove:
             covered_remove = []
             for task in toremove:
@@ -1871,7 +1845,6 @@ class RunQueueExecuteTasks(RunQueueExecute):
 
         logger.debug(1, 'Full skip list %s', self.rq.scenequeue_covered)
 
-
         for mc in self.rqdata.dataCaches:
             target_pairs = []
             for tid in self.rqdata.target_tids:
-- 
2.20.1


