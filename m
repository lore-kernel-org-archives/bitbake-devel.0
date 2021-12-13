Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F02DC433F5
	for <webhook@archiver.kernel.org>; Mon, 13 Dec 2021 23:05:58 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web12.18988.1639436757134722578
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Dec 2021 15:05:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=f14voFHC;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id c4so29551573wrd.9
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Dec 2021 15:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rEYlcU5czkr5H2aVwOZrny8Em4R7dei3akMLDDhx79I=;
        b=f14voFHCC7tRKf59ljvawsCzRpBJnFOPbROxZgeabdtf4WL/4TL6ZthDIlC085ZzsV
         /pMe9UHEr9b0MbdhPQkeKPp+MnYGfn749fYbRkvZ1gCoYWzYk/5OCTMVKoaRv/bcQK1o
         sEvUfO5RheHb/w9PZt2inZkB+widUvWA4Vjes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rEYlcU5czkr5H2aVwOZrny8Em4R7dei3akMLDDhx79I=;
        b=B5MuBG5HLOEC9RO6M/AllEG3MPy51I6yVkiAvWB0IQq1SGrMCk/8sN//sy+C7/V5xN
         WQ1vfv+vBd3Cucp5aFjwr9/e/oOGQnZ2cFU9q+2dzOdNRzvZJaMEo2+Om20VbGFNSsnZ
         jm7cLx9H/mTbtCmwIuQ8eWydxp93L/ptOSaisRUJ4UBWOZY6hDcBu6zJoRqeKL0qRuwv
         oXzgYXBDPpvqpEKXMLxZCAedlWBvnMner8AALSinYR7mLZCBwB+uMziUX8ar5O3uId+2
         WxHLDnxj3+wfMQ776xr18qtLBD37TwKDY0VOvzDIBoy49rn+CwKwgpnKBA7tbKm5u21P
         zQkA==
X-Gm-Message-State: AOAM5300PTz2g2oFQoTHisBRBjQ6Z8syglfU4fg6dCHZ8yDPwiENsGi7
	aJxY+yIvv2VJjOSnE3Jksaw9goQ0jEZOLw==
X-Google-Smtp-Source: 
 ABdhPJzZn+K/xv7H+mQ9QEnDwHjPhVPA3v5AjupQ3unbugWPxWBM0mYHZQ9F2FY28dxqGv2fx17fgA==
X-Received: by 2002:a5d:4b45:: with SMTP id w5mr1611069wrs.272.1639436755278;
        Mon, 13 Dec 2021 15:05:55 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:aeee:ee3b:3dbf:6d62])
        by smtp.gmail.com with ESMTPSA id
 q26sm12035146wrc.39.2021.12.13.15.05.54
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:05:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/runqueue: Improve lockfile handling race
Date: Mon, 13 Dec 2021 23:05:54 +0000
Message-Id: <20211213230554.775706-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Dec 2021 23:05:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13152

Internal bitbake shutdown timings must have changed recently as we're
seeing race issues on the autobuilder around the removal of the bitbake.lock
file. Improve the lockfile race code to cover bitbake's lockfile too
and use it in all the tests.

[YOCTO #14658]
[YOCTO #14652]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/runqueue.py | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 2bf00dc62a..35d5a843ff 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -59,6 +59,8 @@ class RunQueueTests(unittest.TestCase):
             expected = ['a1:' + x for x in self.alltasks]
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_single_setscenevalid(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "a1"]
@@ -69,6 +71,8 @@ class RunQueueTests(unittest.TestCase):
                         'a1:populate_sysroot', 'a1:build']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_intermediate_setscenevalid(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "a1"]
@@ -78,6 +82,8 @@ class RunQueueTests(unittest.TestCase):
                         'a1:populate_sysroot_setscene', 'a1:build']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_intermediate_notcovered(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "a1"]
@@ -87,6 +93,8 @@ class RunQueueTests(unittest.TestCase):
                         'a1:package_qa_setscene', 'a1:build', 'a1:populate_sysroot_setscene']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_all_setscenevalid(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "a1"]
@@ -96,6 +104,8 @@ class RunQueueTests(unittest.TestCase):
                         'a1:package_qa_setscene', 'a1:build', 'a1:populate_sysroot_setscene']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_no_settasks(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "a1", "-c", "patch"]
@@ -104,6 +114,8 @@ class RunQueueTests(unittest.TestCase):
             expected = ['a1:fetch', 'a1:unpack', 'a1:patch']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_mix_covered_notcovered(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "a1:do_patch", "a1:do_populate_sysroot"]
@@ -112,6 +124,7 @@ class RunQueueTests(unittest.TestCase):
             expected = ['a1:fetch', 'a1:unpack', 'a1:patch', 'a1:populate_sysroot_setscene']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
 
     # Test targets with intermediate setscene tasks alongside a target with no intermediate setscene tasks
     def test_mixed_direct_tasks_setscene_tasks(self):
@@ -123,6 +136,8 @@ class RunQueueTests(unittest.TestCase):
                         'a1:package_qa_setscene', 'a1:build', 'a1:populate_sysroot_setscene']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     # This test slows down the execution of do_package_setscene until after other real tasks have
     # started running which tests for a bug where tasks were being lost from the buildable list of real
     # tasks if they weren't in tasks_covered or tasks_notcovered
@@ -137,6 +152,8 @@ class RunQueueTests(unittest.TestCase):
                         'a1:populate_sysroot', 'a1:build']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_setscenewhitelist(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "a1"]
@@ -150,6 +167,8 @@ class RunQueueTests(unittest.TestCase):
                         'a1:populate_sysroot_setscene', 'a1:package_setscene']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     # Tests for problems with dependencies between setscene tasks
     def test_no_setscenevalid_harddeps(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
@@ -163,6 +182,8 @@ class RunQueueTests(unittest.TestCase):
                         'd1:populate_sysroot', 'd1:build']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_no_setscenevalid_withdeps(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "b1"]
@@ -173,6 +194,8 @@ class RunQueueTests(unittest.TestCase):
             expected.remove('a1:package_qa')
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_single_a1_setscenevalid_withdeps(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "b1"]
@@ -183,6 +206,8 @@ class RunQueueTests(unittest.TestCase):
                         'a1:populate_sysroot'] + ['b1:' + x for x in self.alltasks]
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_single_b1_setscenevalid_withdeps(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "b1"]
@@ -194,6 +219,8 @@ class RunQueueTests(unittest.TestCase):
             expected.remove('b1:package')
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_intermediate_setscenevalid_withdeps(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "b1"]
@@ -204,6 +231,8 @@ class RunQueueTests(unittest.TestCase):
             expected.remove('b1:package')
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_all_setscenevalid_withdeps(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             cmd = ["bitbake", "b1"]
@@ -214,6 +243,8 @@ class RunQueueTests(unittest.TestCase):
                         'b1:packagedata_setscene', 'b1:package_qa_setscene', 'b1:populate_sysroot_setscene']
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_multiconfig_setscene_optimise(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
@@ -233,6 +264,8 @@ class RunQueueTests(unittest.TestCase):
                 expected.remove(x)
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_multiconfig_bbmask(self):
         # This test validates that multiconfigs can independently mask off
         # recipes they do not want with BBMASK. It works by having recipes
@@ -249,6 +282,8 @@ class RunQueueTests(unittest.TestCase):
             cmd = ["bitbake", "mc:mc-1:fails-mc2", "mc:mc_2:fails-mc1"]
             self.run_bitbakecmd(cmd, tempdir, "", extraenv=extraenv)
 
+            self.shutdown(tempdir)
+
     def test_multiconfig_mcdepends(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
@@ -279,6 +314,8 @@ class RunQueueTests(unittest.TestCase):
                        ["mc_2:a1:%s" % t for t in rerun_tasks]
             self.assertEqual(set(tasks), set(expected))
 
+            self.shutdown(tempdir)
+
     def test_hashserv_single(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
@@ -359,7 +396,6 @@ class RunQueueTests(unittest.TestCase):
 
     def shutdown(self, tempdir):
         # Wait for the hashserve socket to disappear else we'll see races with the tempdir cleanup
-        while (os.path.exists(tempdir + "/hashserve.sock") or os.path.exists(tempdir + "cache/hashserv.db-wal")):
+        while (os.path.exists(tempdir + "/hashserve.sock") or os.path.exists(tempdir + "cache/hashserv.db-wal") or os.path.exists(tempdir + "/bitbake.lock")):
             time.sleep(0.5)
 
-
-- 
2.32.0


