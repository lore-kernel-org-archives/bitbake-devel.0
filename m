Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D71C0218B
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 02:50:29 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web11.3378.1737687021764524614
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jan 2025 18:50:22 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 50O2oJDr014671
	for <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 20:50:20 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] runqueue: Verify mcdepends are valid
Date: Thu, 23 Jan 2025 20:50:19 -0600
Message-Id: <1737687019-22232-2-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1737687019-22232-1-git-send-email-mark.hatle@kernel.crashing.org>
References: <1737687019-22232-1-git-send-email-mark.hatle@kernel.crashing.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 02:50:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17074

From: Mark Hatle <mark.hatle@amd.com>

In order to avoid a potentially confusing backtrace, check that the mcdepend
is valid when we add it.

Add a test case to ensure invalid configurations are caught and trigger an
error.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 bitbake/lib/bb/runqueue.py                        | 2 ++
 bitbake/lib/bb/tests/runqueue-tests/recipes/j1.bb | 2 ++
 bitbake/lib/bb/tests/runqueue.py                  | 9 +++++++++
 3 files changed, 13 insertions(+)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/j1.bb

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f941749b0d..90f606469b 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -734,6 +734,8 @@ class RunQueueData:
                 if mc == frommc:
                     fn = taskData[mcdep].build_targets[pn][0]
                     newdep = '%s:%s' % (fn,deptask)
+                    if newdep not in taskData[mcdep].taskentries:
+                        bb.fatal("Task mcdepends on non-existent task %s" % (newdep))
                     taskData[mc].taskentries[tid].tdepends.append(newdep)
 
         for mc in taskData:
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/j1.bb b/bitbake/lib/bb/tests/runqueue-tests/recipes/j1.bb
new file mode 100644
index 0000000000..3c7dca0257
--- /dev/null
+++ b/bitbake/lib/bb/tests/runqueue-tests/recipes/j1.bb
@@ -0,0 +1,2 @@
+do_build[mcdepends] = "mc::mc-1:h1:do_invalid"
+
diff --git a/bitbake/lib/bb/tests/runqueue.py b/bitbake/lib/bb/tests/runqueue.py
index cea2ca13fe..4662efbf55 100644
--- a/bitbake/lib/bb/tests/runqueue.py
+++ b/bitbake/lib/bb/tests/runqueue.py
@@ -321,6 +321,15 @@ class RunQueueTests(unittest.TestCase):
                        ["mc_2:i1:%s" % t for t in self.alltasks]
             self.assertEqual(set(tasks), set(expected))
 
+            # Check what happens with an invalid task depednency
+            passed = False
+            try:
+                self.run_bitbakecmd(["bitbake", "j1"], tempdir, "", extraenv=extraenv, cleanup=True)
+            except AssertionError as e:
+                print("Expected failure: %s" % e)
+                passed = True
+            self.assertEqual(True, passed)
+
             self.shutdown(tempdir)
 
     def test_hashserv_single(self):
-- 
2.34.1


