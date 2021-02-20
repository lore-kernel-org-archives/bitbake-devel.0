Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web09.2275.1613788625844420217
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Feb 2021 18:37:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZPv0Q1i2;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id 80so6939845oty.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 19 Feb 2021 18:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84GcM9f4GvjelkndbbhPqokoGllLGJIAeIOurRVWa6U=;
        b=ZPv0Q1i2NqubGWcw6lZLjApxRjeSxUdWmeRXgQXYiO5RkQMlJJ/DjcuCHRnCCP5sol
         57yKwRjKPkLPCNWsWEVZZBYSVhqx7Z4WUL5B4eK51CAAfYdoUNG1TbWvJAvUUpiFl1p8
         gOTPBZyDCwJmsaZaRU9kAmj0vCRXisD4Slrr9JxH5uC8HBlRTk+2DrC8GXtSrXCVUkO3
         SCP61qAyQCeZCDsj6oyYhvdayGpmnTO8+kdkM7+PAS2d6v2TAj11cjPd9sQkA/gV1tb3
         rNsNVu3efSBWH66tyimTxewSnl6LC50ZQSWEuvF35IyCMiTEoOH/zaqODh0hKAdYxVTo
         a09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84GcM9f4GvjelkndbbhPqokoGllLGJIAeIOurRVWa6U=;
        b=g3Wzje+1c1PumbTdECPWeKyHWk2UWdiLfA5/OdZM5yFDWmhOvvFb2+n3ooWZ4sb3w3
         0qMjNH+1KKdZQDJefEFLv6XTM7b7MFQ4lTFM37YHCUPD6SipL/7Sgp7wz+sp/BYu4rsA
         JgxNpHP8eNvC/j3nNZMctmtDhyH53uRNPixG62pjzrxvtno+X2vxgFaRGy728DXImMCC
         2xzqCEw6byyfhFW1I7U+M9x5qjAb3hOOWAIYeTiIvleKXssX89plLfeyBqhknXAGEDCK
         XXS6yrpOWbnS+67y8rXua4GSP0wNwfAsXo0OO9JIG7g3IyHJFq7ZGX1T3WFO615VweS8
         LUvQ==
X-Gm-Message-State: AOAM5316vR1v8pPz44fq77jXZryBQffW9ImmJItzsCdXa+CMO4KJi3dA
	MI6sEVIDZJGYOlLtvPBSOGawS5M5LsY=
X-Google-Smtp-Source: ABdhPJzYMHN2g2Q3nJO4efQWaCYQ3r6QNtf4y+lJ7MPEK6fJK8RKQIoOYpvugbZsw9NxtpgD6GWBSg==
X-Received: by 2002:a9d:7845:: with SMTP id c5mr262452otm.192.1613788624837;
        Fri, 19 Feb 2021 18:37:04 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id n1sm2041325oog.31.2021.02.19.18.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 18:37:04 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: tomasz.dziendzielski@gmail.com,
	richard.purdie@linuxfoundation.org,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2] Fix broken builds when multiconfig has a hyphen in the name
Date: Fri, 19 Feb 2021 20:37:00 -0600
Message-Id: <20210220023700.29803-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210218184304.30358-1-JPEWhacker@gmail.com>
References: <20210218184304.30358-1-JPEWhacker@gmail.com>
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
 lib/bb/event.py                               |  4 +-
 .../conf/multiconfig/{mc1.conf => mc-1.conf}  |  0
 .../conf/multiconfig/{mc2.conf => mc_2.conf}  |  0
 lib/bb/tests/runqueue-tests/recipes/f1.bb     |  2 +-
 .../recipes/fails-mc/fails-mc1.bb             |  4 +-
 .../recipes/fails-mc/fails-mc2.bb             |  4 +-
 lib/bb/tests/runqueue.py                      | 38 +++++++++----------
 7 files changed, 26 insertions(+), 26 deletions(-)
 rename lib/bb/tests/runqueue-tests/conf/multiconfig/{mc1.conf => mc-1.conf} (100%)
 rename lib/bb/tests/runqueue-tests/conf/multiconfig/{mc2.conf => mc_2.conf} (100%)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index ff899594..23e1f318 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
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
diff --git a/lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf b/lib/bb/tests/runqueue-tests/conf/multiconfig/mc-1.conf
similarity index 100%
rename from lib/bb/tests/runqueue-tests/conf/multiconfig/mc1.conf
rename to lib/bb/tests/runqueue-tests/conf/multiconfig/mc-1.conf
diff --git a/lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf b/lib/bb/tests/runqueue-tests/conf/multiconfig/mc_2.conf
similarity index 100%
rename from lib/bb/tests/runqueue-tests/conf/multiconfig/mc2.conf
rename to lib/bb/tests/runqueue-tests/conf/multiconfig/mc_2.conf
diff --git a/lib/bb/tests/runqueue-tests/recipes/f1.bb b/lib/bb/tests/runqueue-tests/recipes/f1.bb
index d45a4cff..7b8fc592 100644
--- a/lib/bb/tests/runqueue-tests/recipes/f1.bb
+++ b/lib/bb/tests/runqueue-tests/recipes/f1.bb
@@ -1 +1 @@
-do_install[mcdepends] = "mc:mc1:mc2:a1:do_build"
+do_install[mcdepends] = "mc:mc-1:mc_2:a1:do_build"
diff --git a/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb b/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
index 17a181ff..eed69c80 100644
--- a/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
+++ b/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
@@ -1,5 +1,5 @@
 python () {
-    if d.getVar("BB_CURRENT_MC") == "mc1":
-        bb.fatal("Multiconfig is mc1")
+    if d.getVar("BB_CURRENT_MC") == "mc-1":
+        bb.fatal("Multiconfig is mc-1")
 }
 
diff --git a/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb b/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb
index cc69e7b8..3c172ef9 100644
--- a/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb
+++ b/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb
@@ -1,4 +1,4 @@
 python () {
-    if d.getVar("BB_CURRENT_MC") == "mc2":
-        bb.fatal("Multiconfig is mc2")
+    if d.getVar("BB_CURRENT_MC") == "mc_2":
+        bb.fatal("Multiconfig is mc_2")
 }
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index d3d62b98..3d51779d 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
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

