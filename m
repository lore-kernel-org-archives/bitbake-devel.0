Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6730EC5DF70
	for <webhook@archiver.kernel.org>; Sun, 16 Aug 2026 22:15:19 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18660.1786918513787562090
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 16 Aug 2026 15:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=Rm21FPUu;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-20260816221511cf92ef957c0002072e-rlrtpe@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260816221511cf92ef957c0002072e
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 17 Aug 2026 00:15:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=a0wK4tx14p+YFg+kNynKwjPGsq8o+Rx393o4g4x8gYo=;
 b=Rm21FPUuHg58/aci32F0gpJhUGe7gJu9aAyuOuYPeq+8EV9CNF/a0Wzy0eAiSVkJgo9t7o
 TS/DK3F+Bw6ryL5jfNKLOozjHhH8YpOg6qhFD0+gIRHOyyuy2CSewr/z6AYi8e8oPGtEJJ1/
 R+lkhqkzVNCC+CKsIFMHI/WEqzbuTRJxBEbYM9etu9BUrx9FMqOl9kDLHhudwCmqMmLQkHxO
 0K7BuXhCPUdizlSK+08Ah50Z8yIPjHxdcr81/XO+7rA/TnbhIHZm/XT0L3ledOCJ/LmUN1w8
 XfgXwy1k+hMOzqgF6R3CG/wClRZvBPdAl1Ku3eDJwQ6wLrekLkfER2XQ==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 7/8] tests/cooker: add TinfoilTests for run_prepared_task
Date: Mon, 17 Aug 2026 00:14:46 +0200
Message-ID: <20260816221507.155861-8-adrian.freihofer@siemens.com>
In-Reply-To: <20260816221507.155861-1-adrian.freihofer@siemens.com>
References: <20260816221507.155861-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 16 Aug 2026 22:15:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19965

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add TinfoilTests, built on _BitbakeSubprocessTestCase, covering
'tinfoil: add a prepared task runner'. Each test spawns a subprocess to
isolate tinfoil's server lifecycle.

TestEquivHash is needed because the noop siggen's invalidate_task()
removes the base stamp path instead of the task-specific one, making
force=True a no-op otherwise.

test_run_prepared_task_recipecache_self_heals additionally proves that
run_prepared_task() (like "bitbake -b" before it) only wipes and
repopulates the recipe cache for the one recipe it touches as a
transient footprint: a subsequent normal, full parse restores the
complete recipe set again.

Lives in cooker.py rather than runqueue.py since it tests Tinfoil's
Python API, not CLI-level runqueue behaviour.

AI-Generated: Uses GitHub Copilot

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/cooker.py | 244 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/lib/bb/tests/cooker.py b/lib/bb/tests/cooker.py
index c32694cc5..db4104d40 100644
--- a/lib/bb/tests/cooker.py
+++ b/lib/bb/tests/cooker.py
@@ -63,6 +63,250 @@ class _BitbakeSubprocessTestCase(unittest.TestCase):
                 self._shutdown(builddir)
 
 
+class TinfoilTests(_BitbakeSubprocessTestCase):
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
+    # do_install genuinely depends on do_compile's output, unlike the
+    # a1 fixture recipe's dummy stamptask() tasks.
+    dependent_recipe = """\
+python do_compile() {
+    with open(d.expand("${TOPDIR}/compiled"), "w") as f:
+        f.write("compiled")
+}
+addtask compile
+
+python do_install() {
+    if not os.path.exists(d.expand("${TOPDIR}/compiled")):
+        bb.fatal("do_install ran without do_compile's output being present")
+}
+addtask install after do_compile
+"""
+
+    # Same contract as dependent_recipe, but with shell tasks, since a real
+    # recipe's do_install is usually shell (e.g. install/cp under pseudo)
+    # rather than a python function.
+    shell_dependent_recipe = """\
+do_compile() {
+    echo compiled > "${TOPDIR}/compiled"
+}
+addtask compile
+
+do_install() {
+    if [ ! -e "${TOPDIR}/compiled" ]; then
+        echo "do_install ran without do_compile's output being present" >&2
+        exit 1
+    fi
+}
+addtask install after do_compile
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
+        return self._run_subprocess([sys.executable, '-c', script],
+                                    self._make_env(builddir, extra), builddir)
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
+    def test_run_prepared_task(self):
+        """tinfoil.run_prepared_task() reruns one task without resolving deps.
+
+        Uses do_install since that's the real devtool ide-sdk scenario: it
+        needs pseudo and so must run via bitbake, unlike the compile step which
+        the IDE invokes directly (e.g. via cmake/meson).
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
+        with self._build_dir() as builddir:
+            self._run_script(builddir, script)
+
+            tasks = self._read_tasklog(builddir)
+            self.assertEqual(tasks, ['a1:install'],
+                             'run_prepared_task should rerun only install, got: %s' % tasks)
+
+    def test_run_prepared_task_unbuilt(self):
+        """run_prepared_task() does not pull any dependency task into the runqueue.
+
+        buildFileInternal()'s taskonly=True clears task_deps['parents'] for
+        every task of the recipe, so do_install's intra-recipe predecessors
+        (fetch, unpack, patch, ...) are never added to the runqueue at all.
+        The recipe was never built here (no stamps exist for any of them), so
+        this is the case that would actually catch a regression: without
+        taskonly, those missing-stamp tasks would have to run to satisfy the
+        runqueue, and the tasklog assertion below would show more than just
+        'a1:install'.
+
+        Whether do_install itself then succeeds or fails is a separate matter
+        that does depend on the recipe: this fixture's do_install has no real
+        prerequisites, so it succeeds here; test_run_prepared_task_unbuilt_dependent_fails()
+        uses a recipe whose do_install does have one, and fails instead.
+        """
+        script = """
+import bb.tinfoil
+
+with bb.tinfoil.Tinfoil() as tinfoil:
+    tinfoil.prepare(quiet=2)
+    assert tinfoil.run_prepared_task('a1', 'install') is True
+"""
+        with self._build_dir() as builddir:
+            self._run_script(builddir, script)
+
+            tasks = self._read_tasklog(builddir)
+            self.assertEqual(tasks, ['a1:install'],
+                             'run_prepared_task should run no dependency task, got: %s' % tasks)
+
+    def test_run_prepared_task_unbuilt_dependent_fails(self):
+        """A task with a genuine dependency on a predecessor's output fails
+        when that predecessor never ran.
+
+        Unlike test_run_prepared_task_unbuilt()'s fixture recipe, whose tasks
+        are dummy stamptask() calls with no real prerequisites,
+        dependent_recipe's do_install actually needs do_compile's output.
+        run_prepared_task() only skips bitbake's own dependency resolution;
+        it does not make the prerequisites appear, exactly as documented:
+        "everything the task consumes must already be in place".
+        """
+        script = """
+import bb.tinfoil
+
+with bb.tinfoil.Tinfoil() as tinfoil:
+    tinfoil.prepare(quiet=2)
+    assert tinfoil.run_prepared_task('dependent', 'install') is False
+"""
+        with tempfile.TemporaryDirectory(prefix='tinfoilrecipes') as recipes, \
+             self._build_dir() as builddir:
+            with open(os.path.join(recipes, 'dependent.bb'), 'w') as f:
+                f.write(self.dependent_recipe)
+            self._run_script(builddir, script,
+                             {'EXTRA_BBFILES': '%s/*.bb' % recipes})
+
+    def test_run_prepared_task_unbuilt_dependent_fails_shell(self):
+        """Same as test_run_prepared_task_unbuilt_dependent_fails(), but with
+        shell do_compile/do_install tasks instead of python ones, matching how
+        a real recipe's do_install is usually written.
+        """
+        script = """
+import bb.tinfoil
+
+with bb.tinfoil.Tinfoil() as tinfoil:
+    tinfoil.prepare(quiet=2)
+    assert tinfoil.run_prepared_task('shelldependent', 'install') is False
+"""
+        with tempfile.TemporaryDirectory(prefix='tinfoilrecipes') as recipes, \
+             self._build_dir() as builddir:
+            with open(os.path.join(recipes, 'shelldependent.bb'), 'w') as f:
+                f.write(self.shell_dependent_recipe)
+            self._run_script(builddir, script,
+                             {'EXTRA_BBFILES': '%s/*.bb' % recipes})
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
+             self._build_dir() as builddir:
+            with open(os.path.join(recipes, 'failer.bb'), 'w') as f:
+                f.write(self.failing_recipe)
+            self._run_script(builddir, script,
+                             {'EXTRA_BBFILES': '%s/*.bb' % recipes})
+
+    def test_run_prepared_task_recipecache_self_heals(self):
+        """A normal full parse after run_prepared_task() sees every recipe.
+
+        run_prepared_task() -> buildFileInternal() -> parseConfiguration()
+        wipes and repopulates self.recipecaches[mc]/self.collections[mc]
+        for just the one recipe it builds - that has always been true of
+        "bitbake -b" too. Prove this is only a transient footprint: a
+        subsequent normal, full parse (as any non -b build would trigger)
+        must see the complete recipe set again, not just the one recipe
+        run_prepared_task() touched.
+        """
+        script = """
+import bb.tinfoil
+
+with bb.tinfoil.Tinfoil() as tinfoil:
+    tinfoil.prepare(quiet=2)
+    tinfoil.parse_recipes()
+    recipes_before = tinfoil.run_command('getRecipes')
+    assert len(recipes_before) > 1, 'test fixture should have more than one recipe'
+
+    tinfoil.run_prepared_task('a1', 'install')
+
+    tinfoil.parse_recipes()
+    recipes_after = tinfoil.run_command('getRecipes')
+    assert len(recipes_after) == len(recipes_before), (
+        'recipe cache not fully restored after run_prepared_task(): '
+        'before=%d after=%d' % (len(recipes_before), len(recipes_after)))
+"""
+        with self._build_dir() as builddir:
+            self._run_script(builddir, script)
+
+
 class CookerTest(unittest.TestCase):
     def setUp(self):
         # At least one variable needs to be set
-- 
2.55.0


