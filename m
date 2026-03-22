Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B143D58CA3
	for <webhook@archiver.kernel.org>; Sun, 22 Mar 2026 19:35:08 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1830.1774208105449436469
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Mar 2026 12:35:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=ctN8yv/l;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1329275-20260322193502b02f621e720002070f-wg7ysu@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260322193502b02f621e720002070f
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 22 Mar 2026 20:35:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ciAU+qIK3242iL4jjD6jZvg+8bknGkNoiz2QpRlcNF0=;
 b=ctN8yv/lmFQUkQ/SnEGJIKIeYwJLRR9KszOJUZGCOBhq3LBro2orBsZdDtsO6eXk+TbACG
 T+iC0AOSB1z1+AVvW03c74mvGpBY/tXryg2h7LMMlpqRnaFRpLd9V6i2ltDOmO/q4PgCoJ1I
 zW6UnOsHbDC22oPSED0MtHQEHdVRqxtvJPXC3AmUTlq1xtWv/XyP+gV9ockUM9H+rpHxdn25
 aOdhUebegQSUICjduGUab/Ytiza073o7CXpGNvtp4qqBXcCTa5knobkGmYy7mkt8tg5NT2bn
 mJ0s/w/Ul9h2xBlMJfPG3KnqcJGLoG2MiGIInbQ23n/bO1cga2Lmrfjg==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 9/9] tests/setup: add test_update_rebase_strategy
Date: Sun, 22 Mar 2026 20:34:20 +0100
Message-ID: <20260322193440.870120-10-adrian.freihofer@siemens.com>
In-Reply-To: <20260322193440.870120-1-adrian.freihofer@siemens.com>
References: <20260322193440.870120-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 22 Mar 2026 19:35:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19202

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add a dedicated test for the --rebase-strategy option introduced in
'bitbake-setup: add --rebase-strategy to the update command'.

Three scenarios are covered that are not exercised by the existing
test_setup:

1. Uncommitted tracked-file change, default 'stop' strategy: update
   must fail with an error message that names the source and hints at
   --rebase-strategy=backup; no backup directory is created.

2. Same uncommitted change, 'backup' strategy: the layer directory is
   renamed to a timestamped backup, the layer is re-cloned from
   upstream, and the result is clean (upstream content, no local
   modifications).

3. Committed local change that conflicts with the next upstream commit,
   'backup' strategy: instead of the hard rebase-conflict failure that
   occurs with the default strategy, the conflicted directory is backed
   up and re-cloned successfully.

A small _count_layer_backups() helper is added to the class and reused
across scenarios.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/setup.py | 88 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 1bcefd698..6339fd5ac 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -640,3 +640,91 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         del os.environ['BBPATH']
         self.assertTrue(os.path.exists(workspace_file),
                         "bitbake.code-workspace should be recreated by update --init-vscode even when nothing changed")
+
+    def _count_layer_backups(self, layers_path):
+        return len([f for f in os.listdir(layers_path) if 'backup' in f])
+
+    def test_update_rebase_strategy(self):
+        """Test the --rebase-strategy option for the update command.
+
+        Covers three scenarios not exercised by test_setup:
+        1. Uncommitted tracked-file change + default 'stop' strategy → clean error
+           message that names the source and mentions --rebase-strategy=backup.
+        2. Uncommitted tracked-file change + 'backup' strategy → directory is
+           renamed to a timestamped backup and the layer is re-cloned cleanly.
+        3. Committed local change that would cause a rebase conflict + 'backup'
+           strategy → backup + re-clone instead of a hard failure.
+        """
+        if 'BBPATH' in os.environ:
+            del os.environ['BBPATH']
+        os.chdir(self.tempdir)
+
+        self.runbbsetup("settings set default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
+        self.add_file_to_testrepo('test-file', 'initial\n')
+        self.add_json_config_to_registry('test-config-1.conf.json', 'master', 'master')
+        self.runbbsetup("init --non-interactive test-config-1 gadget")
+
+        setuppath = self.get_setup_path('test-config-1', 'gadget')
+        layer_path = os.path.join(setuppath, 'layers', 'test-repo')
+        layers_path = os.path.join(setuppath, 'layers')
+
+        # Scenario 1: uncommitted tracked change, default 'stop' strategy
+        # Advance upstream so an update is required.
+        self.add_file_to_testrepo('test-file', 'upstream-v2\n')
+        # Modify the same tracked file in the layer without committing.
+        with open(os.path.join(layer_path, 'test-file'), 'w') as f:
+            f.write('locally-modified\n')
+
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        with self.assertRaises(bb.process.ExecutionError) as ctx:
+            self.runbbsetup("update --update-bb-conf='no'")
+        self.assertIn('has local modifications', str(ctx.exception))
+        self.assertIn('--rebase-strategy=backup', str(ctx.exception))
+        # No backup directory must have been created.
+        self.assertEqual(self._count_layer_backups(layers_path), 0,
+                         "stop strategy must not create any backup")
+
+        # Scenario 2: same uncommitted change, 'backup' strategy
+        out = self.runbbsetup("update --update-bb-conf='no' --rebase-strategy=backup")
+        # One backup directory must now exist.
+        self.assertEqual(self._count_layer_backups(layers_path), 1,
+                         "backup strategy must create exactly one backup")
+        # The re-cloned layer must be clean and at the upstream revision.
+        with open(os.path.join(layer_path, 'test-file')) as f:
+            self.assertEqual(f.read(), 'upstream-v2\n',
+                             "re-cloned layer must contain the upstream content")
+        status = self.git('status --porcelain', cwd=layer_path).strip()
+        self.assertEqual(status, '',
+                         "re-cloned layer must have no local modifications")
+        del os.environ['BBPATH']
+
+        # Scenario 3: committed conflicting change, 'backup' strategy
+        # Re-initialise a fresh setup so we start from a clean state.
+        self.runbbsetup("init --non-interactive --setup-dir-name rebase-conflict-setup test-config-1 gadget")
+        conflict_setup = os.path.join(self.tempdir, 'bitbake-builds', 'rebase-conflict-setup')
+        conflict_layer = os.path.join(conflict_setup, 'layers', 'test-repo')
+        conflict_layers = os.path.join(conflict_setup, 'layers')
+
+        # Commit a local change that touches the same file as the next upstream commit.
+        with open(os.path.join(conflict_layer, 'test-file'), 'w') as f:
+            f.write('conflicting-local\n')
+        self.git('add test-file', cwd=conflict_layer)
+        self.git('commit -m "Local conflicting change"', cwd=conflict_layer)
+
+        # Advance upstream with a conflicting edit.
+        self.add_file_to_testrepo('test-file', 'conflicting-upstream\n')
+
+        os.environ['BBPATH'] = os.path.join(conflict_setup, 'build')
+        # Default stop strategy must still fail with a conflict error.
+        with self.assertRaisesRegex(bb.process.ExecutionError, "Merge conflict in test-file"):
+            self.runbbsetup("update --update-bb-conf='no'")
+        self.assertEqual(self._count_layer_backups(conflict_layers), 0)
+
+        # Backup strategy must succeed: backup the conflicted dir and re-clone.
+        self.runbbsetup("update --update-bb-conf='no' --rebase-strategy=backup")
+        self.assertEqual(self._count_layer_backups(conflict_layers), 1,
+                         "backup strategy must create exactly one backup after a conflict")
+        with open(os.path.join(conflict_layer, 'test-file')) as f:
+            self.assertEqual(f.read(), 'conflicting-upstream\n',
+                             "re-cloned layer must contain the upstream content after conflict backup")
+        del os.environ['BBPATH']
-- 
2.53.0


