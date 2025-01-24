Return-Path: <mark.hatle@kernel.crashing.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6179FC02182
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 02:50:29 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by mx.groups.io with SMTP id smtpd.web10.3296.1737687021718061770
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jan 2025 18:50:22 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.crashing.org, ip: 63.228.1.57, mailfrom: mark.hatle@kernel.crashing.org)
Received: from kernel.crashing.org.net (70-99-78-136.nuveramail.net [70.99.78.136] (may be forged))
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 50O2oJDq014671
	for <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 20:50:20 -0600
From: Mark Hatle <mark.hatle@kernel.crashing.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] runqueue: add 'default' mc translation to mcdepends
Date: Thu, 23 Jan 2025 20:50:18 -0600
Message-Id: <1737687019-22232-1-git-send-email-mark.hatle@kernel.crashing.org>
X-Mailer: git-send-email 1.8.3.1
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Jan 2025 02:50:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17073

From: Mark Hatle <mark.hatle@amd.com>

The default mc is '' (blank), however BB_CURRENT_MC returns 'default'.
Allow a user to specify a mcdepend such as:

  mc:${BB_CURRENT_MC}:m2:recipe:task

Both '' (blank) and 'default' are now supported and have equivalent
meaning.

Signed-off-by: Mark Hatle <mark.hatle@amd.com>
Signed-off-by: Mark Hatle <mark.hatle@kernel.crashing.org>
---
 bitbake/lib/bb/runqueue.py                        | 4 ++++
 bitbake/lib/bb/tests/runqueue-tests/recipes/g1.bb | 2 ++
 bitbake/lib/bb/tests/runqueue-tests/recipes/h1.bb | 0
 bitbake/lib/bb/tests/runqueue-tests/recipes/i1.bb | 0
 bitbake/lib/bb/tests/runqueue.py                  | 7 +++++++
 5 files changed, 13 insertions(+)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/g1.bb
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/h1.bb
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/i1.bb

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index ffb2d28494..f941749b0d 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -723,7 +723,11 @@ class RunQueueData:
                 mcdependency = dep.split(':')
                 pn = mcdependency[3]
                 frommc = mcdependency[1]
+                if frommc == 'default':
+                    frommc = ''
                 mcdep = mcdependency[2]
+                if mcdep == 'default':
+                    mcdep = ''
                 deptask = mcdependency[4]
                 if mcdep not in taskData:
                     bb.fatal("Multiconfig '%s' is referenced in multiconfig dependency '%s' but not enabled in BBMULTICONFIG?" % (mcdep, dep))
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/g1.bb b/bitbake/lib/bb/tests/runqueue-tests/recipes/g1.bb
new file mode 100644
index 0000000000..20ce8dd3ad
--- /dev/null
+++ b/bitbake/lib/bb/tests/runqueue-tests/recipes/g1.bb
@@ -0,0 +1,2 @@
+do_build[mcdepends] = "mc::mc-1:h1:do_build mc:default:mc_2:i1:do_build"
+
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/h1.bb b/bitbake/lib/bb/tests/runqueue-tests/recipes/h1.bb
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/i1.bb b/bitbake/lib/bb/tests/runqueue-tests/recipes/i1.bb
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/bitbake/lib/bb/tests/runqueue.py b/bitbake/lib/bb/tests/runqueue.py
index cc87e8d6a8..cea2ca13fe 100644
--- a/bitbake/lib/bb/tests/runqueue.py
+++ b/bitbake/lib/bb/tests/runqueue.py
@@ -314,6 +314,13 @@ class RunQueueTests(unittest.TestCase):
                        ["mc_2:a1:%s" % t for t in rerun_tasks]
             self.assertEqual(set(tasks), set(expected))
 
+            # Test that mc::... and mc:default:... both work
+            tasks = self.run_bitbakecmd(["bitbake", "g1"], tempdir, "", extraenv=extraenv, cleanup=True)
+            expected = ["g1:%s" % t for t in self.alltasks] + \
+                       ["mc-1:h1:%s" % t for t in self.alltasks] + \
+                       ["mc_2:i1:%s" % t for t in self.alltasks]
+            self.assertEqual(set(tasks), set(expected))
+
             self.shutdown(tempdir)
 
     def test_hashserv_single(self):
-- 
2.34.1


