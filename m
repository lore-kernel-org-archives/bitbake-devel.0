Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2CEFC97F2
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:31 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34707.1774809263055080653
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=XWR9zeIA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-1329275-20260329183420de34f92b4200020707-pmg0pb@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260329183420de34f92b4200020707
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=bm4TVf7D3XJqxfBx165Dn9+QyV7c0mIQxIpap0W+Emc=;
 b=XWR9zeIATGBBISXUTeqINlsR/yJhdH+aAW01LL2zu/6Gxc1C6zLS0Q31yYGQ64Lhlo0IeI
 3Rv4iW4dwICp7RjiwnbmbyPeRNzg0UL/D859C60FbKxvqJfmuOk8D2JcaIgkZHuGaQlfq2YN
 fvLdcquWVY5qySbqy2Rac4hTROce4cPIVVtpFpFUAaBvfOxEyf38Rf9M8JgF/oi4wrmQr83X
 E3BJEL2I60maJRive07wcSE2Z2DlLHitBKtqtpEzuZ69a6GaMa+rXYd1EpjgGOEP69clZq5k
 HdbbNJRqIGMKKj6G2vxprXDxJkCYtNXZxFS9bSvs/BlHreIq7cEpskMA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 12/14] tests/setup: add test_update_rebase_conflicts_strategy
Date: Sun, 29 Mar 2026 20:32:59 +0200
Message-ID: <20260329183332.1996183-13-adrian.freihofer@siemens.com>
In-Reply-To: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2026 18:34:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19269

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add a dedicated test for the --rebase-conflicts-strategy option introduced in
'bitbake-setup: add --rebase-conflicts-strategy to the update command'.

Three scenarios are covered that are not exercised by the existing
test_setup:

1. Uncommitted tracked-file change (LocalModificationsError), default
   'abort' strategy: update must fail with an error that contains
   'has uncommitted changes' and the '--rebase-conflicts-strategy=backup'
   hint; no backup directory is created.

2. Same uncommitted change, 'backup' strategy: the layer directory is
   renamed to a timestamped backup, the layer is re-cloned from
   upstream, and the result is clean (upstream content, no local
   modifications).

3. Committed local change that conflicts with the next upstream commit
   (RebaseError):
   a. Default 'abort' strategy: update must fail with an error that
      contains 'Merge conflict' and the '--rebase-conflicts-strategy=backup'
      hint; no backup directory is created.
   b. 'backup' strategy: instead of the hard rebase-conflict failure,
      the conflicted directory is backed up and re-cloned successfully.

A small _count_layer_backups() helper is added to the class and reused
across scenarios.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/setup.py | 95 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 52120546c..638d56d3b 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -631,3 +631,98 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             content = f.read()
         self.assertEqual(content, '{invalid json',
                          "Corrupt workspace file should not be modified")
+
+    def _count_layer_backups(self, layers_path):
+        return len([f for f in os.listdir(layers_path) if 'backup' in f])
+
+    def test_update_rebase_conflicts_strategy(self):
+        """Test the --rebase-conflicts-strategy option for the update command.
+
+        Covers three scenarios not exercised by test_setup:
+        1. Uncommitted tracked-file change (LocalModificationsError) + default 'abort'
+           strategy → clean error message containing 'has uncommitted changes' and a
+           hint at --rebase-conflicts-strategy=backup; no backup directory is created.
+        2. Same uncommitted change + 'backup' strategy → directory is renamed to a
+           timestamped backup and the layer is re-cloned cleanly.
+        3. Committed local change that conflicts with an incoming upstream commit
+           (RebaseError):
+           a. Default 'abort' strategy → error containing 'Merge conflict' and the
+              --rebase-conflicts-strategy=backup hint; no backup directory is created.
+           b. 'backup' strategy → backup + re-clone instead of a hard failure.
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
+        # Scenario 1: uncommitted tracked change, default 'abort' strategy
+        # Advance upstream so an update is required.
+        self.add_file_to_testrepo('test-file', 'upstream-v2\n')
+        # Modify the same tracked file in the layer without committing.
+        with open(os.path.join(layer_path, 'test-file'), 'w') as f:
+            f.write('locally-modified\n')
+
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        with self.assertRaises(bb.process.ExecutionError) as ctx:
+            self.runbbsetup("update --update-bb-conf='no'")
+        self.assertIn('has uncommitted changes', str(ctx.exception))
+        self.assertIn('--rebase-conflicts-strategy=backup', str(ctx.exception))
+        # No backup directory must have been created.
+        self.assertEqual(self._count_layer_backups(layers_path), 0,
+                         "abort strategy must not create any backup")
+
+        # Scenario 2: same uncommitted change, 'backup' strategy
+        out = self.runbbsetup("update --update-bb-conf='no' --rebase-conflicts-strategy=backup")
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
+        # Default stop strategy must still fail with a conflict error and include
+        # the --rebase-conflicts-strategy=backup hint (same handler as LocalModificationsError).
+        with self.assertRaises(bb.process.ExecutionError) as ctx:
+            self.runbbsetup("update --update-bb-conf='no'")
+        self.assertIn('Merge conflict in test-file', str(ctx.exception))
+        self.assertIn('--rebase-conflicts-strategy=backup', str(ctx.exception))
+        self.assertEqual(self._count_layer_backups(conflict_layers), 0)
+
+        # Backup strategy must succeed: backup the conflicted dir and re-clone.
+        self.runbbsetup("update --update-bb-conf='no' --rebase-conflicts-strategy=backup")
+        self.assertEqual(self._count_layer_backups(conflict_layers), 1,
+                         "backup strategy must create exactly one backup after a conflict")
+        with open(os.path.join(conflict_layer, 'test-file')) as f:
+            self.assertEqual(f.read(), 'conflicting-upstream\n',
+                             "re-cloned layer must contain the upstream content after conflict backup")
+        del os.environ['BBPATH']
-- 
2.53.0


