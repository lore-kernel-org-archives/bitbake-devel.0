Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
 by mx.groups.io with SMTP id smtpd.web09.1011.1613673788626684984
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 10:43:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=emxvbSlR;
 spf=pass (domain: gmail.com, ip: 209.85.167.172, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f172.google.com with SMTP id v193so3069258oie.8
        for <bitbake-devel@lists.openembedded.org>; Thu, 18 Feb 2021 10:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hkxR6iGULaNTKBRgk+76Ri9TxaTf4xeelICDYrkXQ4=;
        b=emxvbSlRsWjiwg6yoTd+CoLxidnOVHOB47z+LCyqrmABzlWaxDBPAb/yHkkZYfD0cZ
         Rt6WdEBDfxun6bliT+wztob4Dvy0TMEOc0CKhYTNRkCr3T4/MfoplyCGfZqr0PhcZxHm
         QtmbUaGx9Y1zZsMGoZyuL5TdA5dyXYjP6AhGcLAaVUM+ZsBnRx2bnRHrh6oSnrILUSIc
         x70rpBhf2vevI3tUTllRglgnPtuR+Tz4rErwORD8a+gKA6COqWVDupBNy66QyN1dnVih
         +6Ui1WBMx3Ttu3XkZABtNC5a1wTUzXFEFau3lJ8FpZNfJZWsrJMAMpnGtpQz71t7HvZE
         icBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/hkxR6iGULaNTKBRgk+76Ri9TxaTf4xeelICDYrkXQ4=;
        b=HYWk7m+ui3QhdHLv9+PrhxSJAttHDMrvHm9vrje5BGqt4fjyYaBhjr7WgurYclKRzF
         wWq8gyqijOIQ2oKNeyobElAQvupdn4iRM9bQPWVHiepe/+kjIyE3AKKZTgxbU3c9eRBy
         DHqDp5zybWD6dGk9QNw54lDUHf9dxnGI4EyNqHbqL+i79S5OLC5WOjDQgrlNFZVeh2f/
         NYqeDUNMOWuHRqQCG/jB+0Ri3Gc8G5VFkPQmKuB/9s7qqNPx+vaskrE7qC191TXH48Zp
         10c+8N6KSwXIO+l15SuSoQpxm4pjr18yXzBuSZSKVgiwlF4S/Ej7PKu+DW5L0ri38zqg
         sp+w==
X-Gm-Message-State: AOAM5318yGIXDHxIlaYAa92cS0vdIVAYCKQvOMw+KFuhtCmCD15Tl6yx
	fYPUAP9+HBCMJYyA9LWj6De42fTA7ys=
X-Google-Smtp-Source: ABdhPJxpDUz+UgB7/+tMYlSerbYSmCPA71lOmfIp2Ctfyp1GmCtwyBiTyWi49yLn+GguZqPCApuEHw==
X-Received: by 2002:a54:4697:: with SMTP id k23mr3818068oic.17.1613673787663;
        Thu, 18 Feb 2021 10:43:07 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id z8sm1377439oib.36.2021.02.18.10.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 10:43:07 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: tomasz.dziendzielski@gmail.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] Fix broken builds when multiconfig has a hyphen in the name
Date: Thu, 18 Feb 2021 12:43:04 -0600
Message-Id: <20210218184304.30358-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5f7fdf7b2d ("bitbake: event: Prevent bitbake from executing event
handler for wrong multiconfig target") broke multiconfig builds contain
a hyphen, since it's attempt to use the multiconfig as part of a
function name and python functions are not allowed to contain a hyphen.

Rework the bitbake multiconfig test to test a multiconfig with a hyphen
and one with an underscore to validate this doesn't break in the future.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/event.py                       |  4 +-
 .../conf/multiconfig/{mc1.conf => mc-1.conf}  |  0
 .../conf/multiconfig/{mc2.conf => mc_2.conf}  |  0
 .../lib/bb/tests/runqueue-tests/recipes/f1.bb |  2 +-
 .../recipes/fails-mc/fails-mc1.bb             |  4 +-
 .../recipes/fails-mc/fails-mc2.bb             |  4 +-
 bitbake/lib/bb/tests/runqueue.py              | 38 +++++++++----------
 7 files changed, 26 insertions(+), 26 deletions(-)
 rename bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/{mc1.conf => mc-1.conf} (100%)
 rename bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/{mc2.conf => mc_2.conf} (100%)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index ff89959460..23e1f3187b 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -234,7 +234,7 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
 
     if data and data.getVar("BB_CURRENT_MC"):
         mc = data.getVar("BB_CURRENT_MC")
-        name = '%s%s' % (mc, name)
+        name = '%s%s' % (mc.replace('-', '_'), name)
 
     # already registered
     if name in _handlers:
@@ -286,7 +286,7 @@ def remove(name, handler, data=None):
     if data:
         if data.getVar("BB_CURRENT_MC"):
             mc = data.getVar("BB_CURRENT_MC")
-            name = '%s%s' % (mc, name)
+            name = '%s%s' % (mc.replace('-', '_'), name)
 
     _handlers.pop(name)
     if name in _catchall_handlers:
diff --git a/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf b/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc-1.conf
similarity index 100%
rename from bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf
rename to bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc-1.conf
diff --git a/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf b/bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc_2.conf
similarity index 100%
rename from bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf
rename to bitbake/lib/bb/tests/runqueue-tests/conf/multiconfig/mc_2.conf
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb b/bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb
index d45a4cff52..7b8fc592ab 100644
--- a/bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb
+++ b/bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb
@@ -1 +1 @@
-do_install[mcdepends] = "mc:mc1:mc2:a1:do_build"
+do_install[mcdepends] = "mc:mc-1:mc_2:a1:do_build"
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb b/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
index 17a181fffb..eed69c805a 100644
--- a/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
+++ b/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
@@ -1,5 +1,5 @@
 python () {
-    if d.getVar("BB_CURRENT_MC") == "mc1":
-        bb.fatal("Multiconfig is mc1")
+    if d.getVar("BB_CURRENT_MC") == "mc-1":
+        bb.fatal("Multiconfig is mc-1")
 }
 
diff --git a/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb b/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb
index cc69e7b82d..3c172ef974 100644
--- a/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb
+++ b/bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb
@@ -1,4 +1,4 @@
 python () {
-    if d.getVar("BB_CURRENT_MC") == "mc2":
-        bb.fatal("Multiconfig is mc2")
+    if d.getVar("BB_CURRENT_MC") == "mc_2":
+        bb.fatal("Multiconfig is mc_2")
 }
diff --git a/bitbake/lib/bb/tests/runqueue.py b/bitbake/lib/bb/tests/runqueue.py
index d3d62b98f9..3d51779d6c 100644
--- a/bitbake/lib/bb/tests/runqueue.py
+++ b/bitbake/lib/bb/tests/runqueue.py
@@ -216,66 +216,66 @@ class RunQueueTests(unittest.TestCase):
     def test_multiconfig_setscene_optimise(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
-                "BBMULTICONFIG" : "mc1 mc2",
+                "BBMULTICONFIG" : "mc-1 mc_2",
                 "BB_SIGNATURE_HANDLER" : "basic"
             }
-            cmd = ["bitbake", "b1", "mc:mc1:b1", "mc:mc2:b1"]
+            cmd = ["bitbake", "b1", "mc:mc-1:b1", "mc:mc_2:b1"]
             setscenetasks = ['package_write_ipk_setscene', 'package_write_rpm_setscene', 'packagedata_setscene',
                              'populate_sysroot_setscene', 'package_qa_setscene']
             sstatevalid = ""
             tasks = self.run_bitbakecmd(cmd, tempdir, sstatevalid, extraenv=extraenv)
             expected = ['a1:' + x for x in self.alltasks] + ['b1:' + x for x in self.alltasks] + \
-                       ['mc1:b1:' + x for x in setscenetasks] + ['mc1:a1:' + x for x in setscenetasks] + \
-                       ['mc2:b1:' + x for x in setscenetasks] + ['mc2:a1:' + x for x in setscenetasks] + \
-                       ['mc1:b1:build', 'mc2:b1:build']
-            for x in ['mc1:a1:package_qa_setscene', 'mc2:a1:package_qa_setscene', 'a1:build', 'a1:package_qa']:
+                       ['mc-1:b1:' + x for x in setscenetasks] + ['mc-1:a1:' + x for x in setscenetasks] + \
+                       ['mc_2:b1:' + x for x in setscenetasks] + ['mc_2:a1:' + x for x in setscenetasks] + \
+                       ['mc-1:b1:build', 'mc_2:b1:build']
+            for x in ['mc-1:a1:package_qa_setscene', 'mc_2:a1:package_qa_setscene', 'a1:build', 'a1:package_qa']:
                 expected.remove(x)
             self.assertEqual(set(tasks), set(expected))
 
     def test_multiconfig_bbmask(self):
         # This test validates that multiconfigs can independently mask off
         # recipes they do not want with BBMASK. It works by having recipes
-        # that will fail to parse for mc1 and mc2, then making each multiconfig
+        # that will fail to parse for mc-1 and mc_2, then making each multiconfig
         # build the one that does parse. This ensures that the recipes are in
         # each multiconfigs BBFILES, but each is masking only the one that
         # doesn't parse
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
-                "BBMULTICONFIG" : "mc1 mc2",
+                "BBMULTICONFIG" : "mc-1 mc_2",
                 "BB_SIGNATURE_HANDLER" : "basic",
                 "EXTRA_BBFILES": "${COREBASE}/recipes/fails-mc/*.bb",
             }
-            cmd = ["bitbake", "mc:mc1:fails-mc2", "mc:mc2:fails-mc1"]
+            cmd = ["bitbake", "mc:mc-1:fails-mc2", "mc:mc_2:fails-mc1"]
             self.run_bitbakecmd(cmd, tempdir, "", extraenv=extraenv)
 
     def test_multiconfig_mcdepends(self):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
-                "BBMULTICONFIG" : "mc1 mc2",
+                "BBMULTICONFIG" : "mc-1 mc_2",
                 "BB_SIGNATURE_HANDLER" : "TestMulticonfigDepends",
                 "EXTRA_BBFILES": "${COREBASE}/recipes/fails-mc/*.bb",
             }
-            tasks = self.run_bitbakecmd(["bitbake", "mc:mc1:f1"], tempdir, "", extraenv=extraenv, cleanup=True)
-            expected = ["mc1:f1:%s" % t for t in self.alltasks] + \
-                       ["mc2:a1:%s" % t for t in self.alltasks]
+            tasks = self.run_bitbakecmd(["bitbake", "mc:mc-1:f1"], tempdir, "", extraenv=extraenv, cleanup=True)
+            expected = ["mc-1:f1:%s" % t for t in self.alltasks] + \
+                       ["mc_2:a1:%s" % t for t in self.alltasks]
             self.assertEqual(set(tasks), set(expected))
 
             # A rebuild does nothing
-            tasks = self.run_bitbakecmd(["bitbake", "mc:mc1:f1"], tempdir, "", extraenv=extraenv, cleanup=True)
+            tasks = self.run_bitbakecmd(["bitbake", "mc:mc-1:f1"], tempdir, "", extraenv=extraenv, cleanup=True)
             self.assertEqual(set(tasks), set())
 
             # Test that a signature change in the dependent task causes
             # mcdepends to rebuild
-            tasks = self.run_bitbakecmd(["bitbake", "mc:mc2:a1", "-c", "compile", "-f"], tempdir, "", extraenv=extraenv, cleanup=True)
-            expected = ["mc2:a1:compile"]
+            tasks = self.run_bitbakecmd(["bitbake", "mc:mc_2:a1", "-c", "compile", "-f"], tempdir, "", extraenv=extraenv, cleanup=True)
+            expected = ["mc_2:a1:compile"]
             self.assertEqual(set(tasks), set(expected))
 
             rerun_tasks = self.alltasks[:]
             for x in ("fetch", "unpack", "patch", "prepare_recipe_sysroot", "configure", "compile"):
                 rerun_tasks.remove(x)
-            tasks = self.run_bitbakecmd(["bitbake", "mc:mc1:f1"], tempdir, "", extraenv=extraenv, cleanup=True)
-            expected = ["mc1:f1:%s" % t for t in rerun_tasks] + \
-                       ["mc2:a1:%s" % t for t in rerun_tasks]
+            tasks = self.run_bitbakecmd(["bitbake", "mc:mc-1:f1"], tempdir, "", extraenv=extraenv, cleanup=True)
+            expected = ["mc-1:f1:%s" % t for t in rerun_tasks] + \
+                       ["mc_2:a1:%s" % t for t in rerun_tasks]
             self.assertEqual(set(tasks), set(expected))
 
     @unittest.skipIf(sys.version_info < (3, 5, 0), 'Python 3.5 or later required')
-- 
2.30.0

