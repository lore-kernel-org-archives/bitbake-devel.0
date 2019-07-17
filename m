Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
	[209.85.128.50])
	by mail.openembedded.org (Postfix) with ESMTP id 746F07ED2F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jul 2019 23:14:27 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id w9so20204688wmd.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Jul 2019 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=++iTSjB4qi/RuPNhYT6Lb2BBiG2AM9f/Y4DIiNWoQeU=;
	b=PHeeG6ohNP2HXbOv803y0Z7UDqPsxmtYdzwZU80TQ9La8igQk9UjA777yz6upEOOtR
	WYTiHsCZUpB0LBlElyzuFnrV0iBYj/BJ5zHv2FwanHM+Y3cJ8Fs623LRRuGrKyjiwGQv
	JGssSDAkUHKko6r/PQOlghenIGL998z1NtZmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=++iTSjB4qi/RuPNhYT6Lb2BBiG2AM9f/Y4DIiNWoQeU=;
	b=fFSnuJfbUQ9j29LXAYfIfi1FGo/eowWFtCI+/YDY7nQkrqA1hGzh+6CdB8fUhoPTJW
	nEASWZUPouB7mNcYsM2a68F8tp1jk9lyC0iXe6weab2y36D5orrjbXADPhUQE4cvMAaV
	XNVhPmIKCLCW+lvM36ygIOppukNXwFHUjeA7e0q0ZvaWxd3q20FIJ5DHriRDkUUluibX
	pzpyrVfut2aQftIDjY/R+mX7oTGY/mqC2C8BzXnAiRnvTSsgrhEnXz7u4aPnhh+ZuGSQ
	7BB/ey9YFDv3LIN+JWTnGFxpNdpBQL4RXmfiHpTYzfblnXmjjp9IXTp19U6Cm69izgAA
	8nSw==
X-Gm-Message-State: APjAAAX8zrojU8tZX8pO+vY3SoDVC4AeIYBD0D4AgoEb5WlspsIqPcyc
	eZaBiP0Yt7vk3g4Yz5UY+3CQUzlU1OM=
X-Google-Smtp-Source: APXvYqzfaEUXA3TMsE7M/7L40owdUGln9vkqlMLlpkzp/bOpQrlDbk0Iu8j/NW8dPPd0qelhMpgrbQ==
X-Received: by 2002:a7b:c455:: with SMTP id l21mr39030353wmi.114.1563405267783;
	Wed, 17 Jul 2019 16:14:27 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	n9sm47315257wrp.54.2019.07.17.16.14.26
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 17 Jul 2019 16:14:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Jul 2019 00:14:25 +0100
Message-Id: <20190717231425.10185-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] runqueue: Fix non setscene tasks targets being lost
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
X-List-Received-Date: Wed, 17 Jul 2019 23:14:27 -0000
Content-Transfer-Encoding: 8bit

If you specify both setscene and non-setscene tasks on the commandline, the
non-setscene tasks could be missed, e.g. "bitbake X:do_patch X:do_populate_sysroot"
and do_patch would fail to run.

Fix the problem in runqueue and add a testcase.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py       | 10 +++++++++-
 lib/bb/tests/runqueue.py |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index fa848326d8..6a2de240cc 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2167,7 +2167,6 @@ class RunQueueExecute:
         return taskdepdata
 
     def scenequeue_process_notcovered(self, task):
-        logger.debug(1, 'Not skipping setscene task %s', task)
         if len(self.rqdata.runtaskentries[task].depends) == 0:
             self.setbuildable(task)
         notcovered = set([task])
@@ -2233,6 +2232,7 @@ class RunQueueExecute:
             self.scenequeue_process_unskippable(task)
 
         if task in self.scenequeue_notcovered:
+            logger.debug(1, 'Not skipping setscene task %s', task)
             self.scenequeue_process_notcovered(task)
         elif task in self.scenequeue_covered:
             logger.debug(1, 'Queued setscene task %s', task)
@@ -2243,6 +2243,14 @@ class RunQueueExecute:
                 logger.debug(1, 'Processing setscene task %s', task)
                 covered = self.sqdata.sq_covered_tasks[task]
                 covered.add(task)
+
+                # If a task is in target_tids and isn't a setscene task, we can't skip it.
+                cantskip = covered.intersection(self.rqdata.target_tids).difference(self.rqdata.runq_setscene_tids)
+                for tid in cantskip:
+                    self.tasks_notcovered.add(tid)
+                    self.scenequeue_process_notcovered(tid)
+                covered.difference_update(cantskip)
+
                 # Remove notcovered tasks
                 covered.difference_update(self.tasks_notcovered)
                 self.tasks_covered.update(covered)
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index f0cea6483f..f22ad4bd81 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -97,6 +97,15 @@ class RunQueueTests(unittest.TestCase):
             expected = ['a1:fetch', 'a1:unpack', 'a1:patch']
             self.assertEqual(set(tasks), set(expected))
 
+    def test_mix_covered_notcovered(self):
+        with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
+            cmd = ["bitbake", "a1:do_patch", "a1:do_populate_sysroot"]
+            sstatevalid = self.a1_sstatevalid
+            tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid)
+            expected = ['a1:fetch', 'a1:unpack', 'a1:patch', 'a1:populate_sysroot_setscene']
+            self.assertEqual(set(tasks), set(expected))
+
+
     # Test targets with intermediate setscene tasks alongside a target with no intermediate setscene tasks
     def test_mixed_direct_tasks_setscene_tasks(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
-- 
2.20.1


