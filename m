Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA01C5AD5A
	for <webhook@archiver.kernel.org>; Sat, 15 Aug 2026 13:47:39 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9123.1786801649528231987
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 15 Aug 2026 06:47:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=RUIxe3MN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1329275-202608151347267bc178dd8f00020721-qzwogp@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202608151347267bc178dd8f00020721
        for <bitbake-devel@lists.openembedded.org>;
        Sat, 15 Aug 2026 15:47:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=7bQjlaX2icqv10ehUAghyIxmLksAJuTFScKPL1lsWP8=;
 b=RUIxe3MNvG6JoZech3Xvsa2Et76aoQYhNnINRPcx/1HZds6dGbR7zMm+DxHN7GBCziDcqe
 26CcwbqVveOgw9AVK2MFoFZvE8fBEAEibJkfeaZsJcmPHs0RP6SzbnSJ72G0Wga7B7XUrwN2
 pmQkjUPhClhF+BKvChLGrDhN+5jFcA8AJFK50NHyJjMJr3pEoZQcs/CiYQKTW5Ht9g89VAg+
 3nilenQFx4hb7Nmxw83yhySJlLTQ5R7BXpnis7UMjSOwr8ndjsBkU+7yLhV4sw02zMLyDYMK
 W6YlWsbI9PI5IYHZXEsq3cyhDVvC4++D9m7T2Ft/Dz7zAIkI5SdHP6lQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 6/7] tests/cooker: add TinfoilTests for run_prepared_task
Date: Sat, 15 Aug 2026 15:46:57 +0200
Message-ID: <20260815134722.497586-7-adrian.freihofer@siemens.com>
In-Reply-To: <20260815134722.497586-1-adrian.freihofer@siemens.com>
References: <20260815134722.497586-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 15 Aug 2026 13:47:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19956

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add TinfoilTests covering 'tinfoil: add a prepared task runner'. Each
test spawns a subprocess to isolate tinfoil's server lifecycle.

TestEquivHash is needed because the noop siggen's invalidate_task()
removes the base stamp path instead of the task-specific one, making
force=True a no-op otherwise.

Lives in cooker.py rather than runqueue.py since it tests Tinfoil's
Python API, not CLI-level runqueue behaviour.

AI-Generated: Uses GitHub Copilot

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/cooker.py | 159 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index 76ec65540..a08843e98 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -9,12 +9,171 @@
 import unittest
 import os
 import subprocess
+import sys
 import tempfile
+import time
 import bb, bb.cooker
 import re
 import logging
 
 # Cooker tests
+
+
+class TinfoilTests(unittest.TestCase):
+    """Tests for the Tinfoil API that require a running bitbake server."""
+
+    # Library directory containing bb.tinfoil
+    _bblib = os.path.realpath(os.path.join(os.path.dirname(__file__), '..', '..'))
+    # runqueue-tests BBPATH (provides the simple a1/b1/... test recipes)
+    _runqueuetests = os.path.realpath(os.path.join(os.path.dirname(__file__), 'runqueue-tests'))
+
+    failing_recipe = """\
+python do_install() {
+    bb.fatal("deliberate failure")
+}
+addtask install
+"""
+
+    def _make_env(self, builddir, extra=None):
+        env = os.environ.copy()
+        env['PYTHONPATH'] = self._bblib + (':' + env['PYTHONPATH'] if 'PYTHONPATH' in env else '')
+        env['BBPATH'] = self._runqueuetests
+        env['BB_ENV_PASSTHROUGH_ADDITIONS'] = 'SSTATEVALID SLOWTASKS TOPDIR BB_HASHSERVE BB_SIGNATURE_HANDLER EXTRA_BBFILES'
+        env['SSTATEVALID'] = ''
+        env['SLOWTASKS'] = ''
+        env['TOPDIR'] = builddir
+        # TestEquivHash creates taint files so that force=True actually
+        # invalidates the task hash; the default noop siggen cannot do this.
+        env['BB_HASHSERVE'] = 'auto'
+        env['BB_SIGNATURE_HANDLER'] = 'TestEquivHash'
+        if extra:
+            env.update(extra)
+        return env
+
+    def _run_script(self, builddir, script, extra=None):
+        """Run script in a subprocess to isolate tinfoil's server lifecycle."""
+        proc = subprocess.run(
+            [sys.executable, '-c', script],
+            env=self._make_env(builddir, extra),
+            stdout=subprocess.PIPE,
+            stderr=subprocess.STDOUT,
+            universal_newlines=True,
+            cwd=builddir,
+        )
+        if proc.returncode:
+            self.fail('tinfoil script failed: %s' % proc.stdout)
+        return proc.stdout
+
+    def _read_tasklog(self, builddir, cleanup=True):
+        tasklog = os.path.join(builddir, 'task.log')
+        tasks = []
+        if os.path.exists(tasklog):
+            with open(tasklog) as f:
+                tasks = [line.rstrip() for line in f]
+            if cleanup:
+                os.remove(tasklog)
+        return tasks
+
+    def _shutdown(self, builddir):
+        """Wait for the bitbake server and hashserv to release builddir.
+
+        Must run before the caller's TemporaryDirectory is removed, so it
+        cannot be a tearDown().
+        """
+        deadline = time.monotonic() + 30
+        while time.monotonic() < deadline:
+            if not any(os.path.exists(os.path.join(builddir, p))
+                       for p in ('hashserve.sock', 'bitbake.lock')):
+                return
+            time.sleep(0.5)
+
+    def test_run_prepared_task(self):
+        """tinfoil.run_prepared_task() reruns one task without resolving deps.
+
+        Uses do_install since that's the real devtool ide-sdk scenario: it
+        needs pseudo and so must run via bitbake, unlike do_compile which the
+        IDE invokes directly (e.g. via cmake/meson).
+
+        Builds a1 completely so all stamps/hashes are valid, then calls
+        run_prepared_task('a1', 'install') through the Python API and verifies
+        that only do_install re-runs while its intra-recipe predecessors
+        (fetch, unpack, patch, prepare_recipe_sysroot, configure, compile) are
+        skipped.
+        """
+        # The script runs inside a subprocess so that tinfoil's server
+        # lifecycle and environment modifications are isolated.
+        script = """
+import os, sys
+import bb.tinfoil
+
+builddir = os.environ['TOPDIR']
+tasklog  = os.path.join(builddir, 'task.log')
+
+with bb.tinfoil.Tinfoil() as tinfoil:
+    tinfoil.prepare(quiet=2)
+    # Full build so all stamps and hashes are valid.
+    tinfoil.build_targets(['a1'])
+    # Clear the log so only the run_prepared_task() entries are counted.
+    if os.path.exists(tasklog):
+        os.remove(tasklog)
+    # run_prepared_task() sets force=True (taint) and calls build_file_sync
+    # with the recipe file resolved via get_recipe_file(), bypassing the
+    # normal runqueue dependency resolver.
+    tinfoil.run_prepared_task('a1', 'install')
+"""
+        with tempfile.TemporaryDirectory(prefix='tinfoiltest') as builddir:
+            try:
+                self._run_script(builddir, script)
+
+                tasks = self._read_tasklog(builddir)
+                self.assertEqual(tasks, ['a1:install'],
+                                 'run_prepared_task should rerun only install, got: %s' % tasks)
+            finally:
+                self._shutdown(builddir)
+
+    def test_run_prepared_task_unbuilt(self):
+        """run_prepared_task() runs the task and nothing else.
+
+        The recipe was never built, so if any dependency task were still in
+        the runqueue it would have to run here.
+        """
+        script = """
+import bb.tinfoil
+
+with bb.tinfoil.Tinfoil() as tinfoil:
+    tinfoil.prepare(quiet=2)
+    assert tinfoil.run_prepared_task('a1', 'install') is True
+"""
+        with tempfile.TemporaryDirectory(prefix='tinfoiltest') as builddir:
+            try:
+                self._run_script(builddir, script)
+
+                tasks = self._read_tasklog(builddir)
+                self.assertEqual(tasks, ['a1:install'],
+                                 'run_prepared_task should run no dependency task, got: %s' % tasks)
+            finally:
+                self._shutdown(builddir)
+
+    def test_run_prepared_task_failure(self):
+        """A failing task makes run_prepared_task() return False, not raise."""
+        script = """
+import bb.tinfoil
+
+with bb.tinfoil.Tinfoil() as tinfoil:
+    tinfoil.prepare(quiet=2)
+    assert tinfoil.run_prepared_task('failer', 'install') is False
+"""
+        with tempfile.TemporaryDirectory(prefix='tinfoilrecipes') as recipes, \
+             tempfile.TemporaryDirectory(prefix='tinfoiltest') as builddir:
+            with open(os.path.join(recipes, 'failer.bb'), 'w') as f:
+                f.write(self.failing_recipe)
+            try:
+                self._run_script(builddir, script,
+                                 {'EXTRA_BBFILES': '%s/*.bb' % recipes})
+            finally:
+                self._shutdown(builddir)
+
+
 class CookerTest(unittest.TestCase):
     def setUp(self):
         # At least one variable needs to be set
-- 
2.55.0


