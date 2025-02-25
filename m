Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584F3C021B8
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 18:38:59 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.16637.1740508735773616764
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 10:38:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 51PIcstx019114
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 12:38:54 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] bitbake: runqueue: Verify mcdepends are valid
Date: Tue, 25 Feb 2025 12:38:53 -0600
Message-Id: <1740508733-4989-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 18:38:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17321

From: Mark Hatle <mark.hatle@amd.com>

In order to avoid a potentially confusing backtrace, check that the mcdepend
is valid when we add it.

Add a test case to ensure invalid configurations are caught and trigger an
error.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 lib/bb/runqueue.py                        |  2 ++
 lib/bb/tests/runqueue-tests/recipes/g1.bb |  2 ++
 lib/bb/tests/runqueue-tests/recipes/h1.bb |  0
 lib/bb/tests/runqueue.py                  | 18 ++++++++++++++++++
 4 files changed, 22 insertions(+)
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/g1.bb
 create mode 100644 lib/bb/tests/runqueue-tests/recipes/h1.bb

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index ffb2d2849..539a6065f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -730,6 +730,8 @@ class RunQueueData:
                 if mc == frommc:
                     fn = taskData[mcdep].build_targets[pn][0]
                     newdep = '%s:%s' % (fn,deptask)
+                    if newdep not in taskData[mcdep].taskentries:
+                        bb.fatal("Task mcdepends on non-existent task %s" % (newdep))
                     taskData[mc].taskentries[tid].tdepends.append(newdep)
 
         for mc in taskData:
diff --git a/lib/bb/tests/runqueue-tests/recipes/g1.bb b/lib/bb/tests/runqueue-tests/recipes/g1.bb
new file mode 100644
index 000000000..3c7dca025
--- /dev/null
+++ b/lib/bb/tests/runqueue-tests/recipes/g1.bb
@@ -0,0 +1,2 @@
+do_build[mcdepends] = "mc::mc-1:h1:do_invalid"
+
diff --git a/lib/bb/tests/runqueue-tests/recipes/h1.bb b/lib/bb/tests/runqueue-tests/recipes/h1.bb
new file mode 100644
index 000000000..e69de29bb
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index cc87e8d6a..e15fdc330 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -314,6 +314,24 @@ class RunQueueTests(unittest.TestCase):
                        ["mc_2:a1:%s" % t for t in rerun_tasks]
             self.assertEqual(set(tasks), set(expected))
 
+            # AssertionError is raised by self.run_bitbakecmd in the event of a failure
+            # in thise case a failure is required, but we need to do further processing
+            # to tell if it's the RIGHT kind of failure.
+            with self.assertRaises(AssertionError):
+                try:
+                    self.run_bitbakecmd(["bitbake", "g1"], tempdir, "", extraenv=extraenv, cleanup=True)
+                except AssertionError as e:
+                    # If the word 'Traceback' or 'KeyError' is in the exception text,
+                    # we've regressed.  So verify it's NOT present, and pass the
+                    # exception to indicate a 'pass'.
+                    if not ('Traceback' in str(e) or 'KeyError' in str(e)):
+                        # Raising 'AssertionError' is a test pass
+                        raise e
+                    else:
+                        # Dump the output for triage, but don't raise an
+                        # exception, this indicates a test failure.
+                        print("%s: %s" % (type(e), e))
+
             self.shutdown(tempdir)
 
     def test_hashserv_single(self):
-- 
2.34.1


