Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60991D58CA0
	for <webhook@archiver.kernel.org>; Sun, 22 Mar 2026 19:35:08 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1831.1774208105449775212
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Mar 2026 12:35:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=Kxrn9Pv+;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1329275-20260322193502a90c4320fa00020745-jn9jkx@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260322193502a90c4320fa00020745
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 22 Mar 2026 20:35:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JYqenwduu29YHus0kS7l40H5FOOZA3Wj0p0HJBu2N6A=;
 b=Kxrn9Pv+UfKX4K4WcDosBelm66QlPnDjo3ZKV/y3WFO/PdvqPX57Co8PsGu22+3Nqe+KNv
 pG7+WwSvJ2lu2tvAhNFziR+SnTGE0OKloR7LK4Xp/w3TljdKgXDe8KTKQgraN2kppf58Zja9
 4/dE0/MJi6ADzddNz0a+qIGUewd/DC8ECO5KfeSuQS3DvWttDCNVjTWdOhk6LWjx3ojyuw/j
 bMCHJOZxOp8IJggdGTxK+V89Q674/hiOTRGI4XZuVf8qaLFo7YZaHpQO6OMXibK0VybR+IYK
 9c6XBxwCwYhFHjOTiaL8ZgDIWkBc8wKr6r4E4J6xmCZc0m8o92GPNqKg==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 7/9] tests/setup: add test_vscode for VSCode workspace generation
Date: Sun, 22 Mar 2026 20:34:18 +0100
Message-ID: <20260322193440.870120-8-adrian.freihofer@siemens.com>
In-Reply-To: <20260322193440.870120-1-adrian.freihofer@siemens.com>
References: <20260322193440.870120-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 22 Mar 2026 19:35:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19203

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add test_vscode to BitbakeSetupTest covering the --init-vscode
option introduced in 'bitbake-setup: generate config files for VSCode':

- init --init-vscode creates bitbake.code-workspace with the
  expected top-level structure (folders, settings, extensions).
- Folders list conf and each non-symlink git repo in layers/;
  all paths are relative.
- Bitbake extension settings (pathToBuildFolder, pathToEnvScript,
  disableConfigModification) are set correctly.
- file associations (*.conf, *.inc) and python.analysis.extraPaths /
  python.autoComplete.extraPaths are populated.
- init --no-init-vscode does not create a workspace file.
- update --init-vscode after a layer change preserves user-added
  folders and settings while updating managed ones.
- update --init-vscode with a corrupt workspace file logs an error
  and leaves the file unchanged.
- update --init-vscode recreates the workspace file when it was
  manually deleted.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/setup.py | 102 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 1af3d8b50..1bcefd698 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -538,3 +538,105 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         custom_setup_dir = 'special-setup-dir-with-cmdline-overrides'
         out = self.runbbsetup("init --non-interactive -L test-repo {} --setup-dir-name {} test-config-1 gadget".format(self.testrepopath, custom_setup_dir))
         _check_local_sources(custom_setup_dir)
+
+    def test_vscode(self):
+        if 'BBPATH' in os.environ:
+            del os.environ['BBPATH']
+        os.chdir(self.tempdir)
+
+        self.runbbsetup("settings set default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
+        self.add_file_to_testrepo('test-file', 'initial\n')
+        self.add_json_config_to_registry('test-config-1.conf.json', 'master', 'master')
+
+        # --init-vscode should create bitbake.code-workspace
+        self.runbbsetup("init --non-interactive --init-vscode test-config-1 gadget")
+        setuppath = self.get_setup_path('test-config-1', 'gadget')
+        workspace_file = os.path.join(setuppath, 'bitbake.code-workspace')
+        self.assertTrue(os.path.exists(workspace_file),
+                        "bitbake.code-workspace should be created with --init-vscode")
+
+        with open(workspace_file) as f:
+            workspace = json.load(f)
+
+        # top-level structure
+        self.assertIn('folders', workspace)
+        self.assertIn('settings', workspace)
+        self.assertIn('extensions', workspace)
+        self.assertIn('yocto-project.yocto-bitbake',
+                      workspace['extensions']['recommendations'])
+
+        # folders: conf dir + test-repo (symlinks like oe-init-build-env-dir are skipped)
+        folder_names = {f['name'] for f in workspace['folders']}
+        self.assertIn('conf', folder_names)
+        self.assertIn('test-repo', folder_names)
+
+        # folder paths must be relative so the workspace is portable
+        for f in workspace['folders']:
+            self.assertFalse(os.path.isabs(f['path']),
+                             "Folder path should be relative, got: {}".format(f['path']))
+
+        # bitbake extension settings
+        settings = workspace['settings']
+        self.assertTrue(settings.get('bitbake.disableConfigModification'))
+        self.assertEqual(settings['bitbake.pathToBuildFolder'],
+                         os.path.join(setuppath, 'build'))
+        self.assertEqual(settings['bitbake.pathToEnvScript'],
+                         os.path.join(setuppath, 'build', 'init-build-env'))
+
+        # file associations
+        self.assertIn('*.conf', settings.get('files.associations', {}))
+        self.assertIn('*.inc', settings.get('files.associations', {}))
+
+        # python extra paths: test-repo/scripts/ exists and should be listed
+        extra_paths = settings.get('python.analysis.extraPaths', [])
+        self.assertTrue(any('scripts' in p for p in extra_paths),
+                        "python.analysis.extraPaths should include the scripts dir")
+        self.assertEqual(settings.get('python.analysis.extraPaths'),
+                         settings.get('python.autoComplete.extraPaths'))
+
+        # --no-init-vscode should NOT create a workspace file
+        self.runbbsetup("init --non-interactive --no-init-vscode test-config-1 gadget-notemplate")
+        notemplate_path = self.get_setup_path('test-config-1', 'gadget-notemplate')
+        self.assertFalse(
+            os.path.exists(os.path.join(notemplate_path, 'bitbake.code-workspace')),
+            "bitbake.code-workspace should not be created with --no-init-vscode")
+
+        # update with --init-vscode after a layer change should preserve
+        # user-added folders and settings while still rewriting managed ones
+        workspace['folders'].append({"name": "user-folder", "path": "user/custom"})
+        workspace['settings']['my.user.setting'] = 'preserved'
+        with open(workspace_file, 'w') as f:
+            json.dump(workspace, f, indent=4)
+
+        self.add_file_to_testrepo('test-file', 'updated\n')
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        self.runbbsetup("update --update-bb-conf='no' --init-vscode")
+        del os.environ['BBPATH']
+
+        with open(workspace_file) as f:
+            updated = json.load(f)
+        self.assertIn('user/custom', {f['path'] for f in updated['folders']},
+                      "User-added folder was removed during update")
+        self.assertIn('my.user.setting', updated['settings'],
+                      "User-added setting was removed during update")
+
+        # update with a corrupt workspace file should log an error and leave it unchanged
+        self.add_file_to_testrepo('test-file', 'updated-again\n')
+        with open(workspace_file, 'w') as f:
+            f.write('{invalid json')
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        self.runbbsetup("update --update-bb-conf='no' --init-vscode")
+        del os.environ['BBPATH']
+        with open(workspace_file) as f:
+            content = f.read()
+        self.assertEqual(content, '{invalid json',
+                         "Corrupt workspace file should not be modified")
+
+        # update with --init-vscode when nothing has changed should still
+        # regenerate the workspace file (e.g. after manual deletion)
+        os.remove(workspace_file)
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        self.runbbsetup("update --update-bb-conf='no' --init-vscode")
+        del os.environ['BBPATH']
+        self.assertTrue(os.path.exists(workspace_file),
+                        "bitbake.code-workspace should be recreated by update --init-vscode even when nothing changed")
-- 
2.53.0


