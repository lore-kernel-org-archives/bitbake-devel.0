Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D1C5DF75
	for <webhook@archiver.kernel.org>; Sat, 15 Aug 2026 13:47:41 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9198.1786801649527888987
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 15 Aug 2026 06:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=QpL3cbpL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1329275-20260815134726beef1a040d00020773-biozip@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260815134726beef1a040d00020773
        for <bitbake-devel@lists.openembedded.org>;
        Sat, 15 Aug 2026 15:47:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eDAW/NRXcnVWIpAut/yBjXCarUXs9aJPm7pLPDIt1nI=;
 b=QpL3cbpL/Z3HVZOlKH5ytcu8N3o6TSlelE2gAULJNNxWB6jdG2puD0BgIiNmsGqBhNVEM+
 AcuX4Xr4ZDJ9YRWHTPwukDi3edmTQ4mkyZt82MR1rOj4psIqIkjYBi1kDupme2pD4ziUPJOI
 MQ5Izd2LVcv4FKqvdOBtOHziMUXry2xhGfvK9Q6Uy3K1ZCXl4yWNM7LJPKWAgP5Dm6N/61O+
 8K1HrcbdrayXw+bYC1Vu6EKYE0gZw9XNts4tKWy+838g8XW/IB093qkw+VqSg3wG52eEaU+s
 h2qusHERWkCJ1Z0SE4LGgVz3Bslusr6AXFDYRnyh2oNjmPFXXyTpiwsQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 2/7] tests/cooker: add a bitbake -b bbappend test
Date: Sat, 15 Aug 2026 15:46:53 +0200
Message-ID: <20260815134722.497586-3-adrian.freihofer@siemens.com>
In-Reply-To: <20260815134722.497586-1-adrian.freihofer@siemens.com>
References: <20260815134722.497586-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 15 Aug 2026 13:47:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19949

From: Adrian Freihofer <adrian.freihofer@siemens.com>

The buildfile ("bitbake -b") mode had no test coverage at all. Add
BuildFileTest.test_buildfile_applies_bbappends(), which writes a recipe
plus a matching .bbappend to a temporary directory, points EXTRA_BBFILES
at both and runs a task recording a variable the bbappend overrides.

It uses the parse-tests BBPATH because that bitbake.conf already globs
*.bbappend. Without the preceding fix the recipe's own default is
recorded, i.e. -b dropped the bbappend silently.

If the previous commit is reverted, this test faila with:

    AssertionError: 'no-bbappend' != 'bbappend-applied'
    - no-bbappend
    + bbappend-applied

AI-Generated: Uses GitHub Copilot

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/cooker.py | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index 9e524ae34..76ec65540 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -8,6 +8,8 @@
 
 import unittest
 import os
+import subprocess
+import tempfile
 import bb, bb.cooker
 import re
 import logging
@@ -69,3 +71,53 @@ class CookerTest(unittest.TestCase):
         expected = []
 
         self.assertEqual(log_handler.logdata, expected)
+
+
+class BuildFileTest(unittest.TestCase):
+    """Tests for the buildfile ("bitbake -b") mode."""
+
+    # parse-tests BBPATH: minimal bitbake.conf whose BBFILES honours
+    # EXTRA_BBFILES and already includes *.bbappend
+    _parsetests = os.path.realpath(os.path.join(os.path.dirname(__file__), "parse-tests"))
+
+    recipe = """\
+MARKER ??= "no-bbappend"
+python do_marker() {
+    with open(d.expand("${TOPDIR}/marker.log"), "w") as f:
+        f.write(d.getVar("MARKER"))
+}
+addtask marker
+"""
+
+    bbappend = 'MARKER = "bbappend-applied"\n'
+
+    def test_buildfile_applies_bbappends(self):
+        """bitbake -b must build the recipe with its bbappends applied.
+
+        buildFileInternal() looks the appends up in self.collections[mc], which
+        on the -b path is only ever populated by matchFiles().
+        """
+        with tempfile.TemporaryDirectory(prefix="buildfilerecipes") as recipes, \
+             tempfile.TemporaryDirectory(prefix="buildfiletest") as builddir:
+            recipe = os.path.join(recipes, "appendtest.bb")
+            with open(recipe, "w") as f:
+                f.write(self.recipe)
+            with open(os.path.join(recipes, "appendtest.bbappend"), "w") as f:
+                f.write(self.bbappend)
+
+            env = os.environ.copy()
+            env["BBPATH"] = self._parsetests
+            env["BB_ENV_PASSTHROUGH_ADDITIONS"] = "TOPDIR EXTRA_BBFILES"
+            env["TOPDIR"] = builddir
+            env["EXTRA_BBFILES"] = "%s/*.bb %s/*.bbappend" % (recipes, recipes)
+
+            cmd = ["bitbake", "-b", recipe, "-c", "marker"]
+            try:
+                subprocess.check_output(cmd, env=env, stderr=subprocess.STDOUT,
+                                        universal_newlines=True, cwd=builddir)
+            except subprocess.CalledProcessError as e:
+                self.fail("Command %s failed with %s" % (cmd, e.output))
+
+            with open(os.path.join(builddir, "marker.log")) as f:
+                self.assertEqual(f.read(), "bbappend-applied",
+                                 "bitbake -b did not apply the recipe's bbappend")
-- 
2.55.0


