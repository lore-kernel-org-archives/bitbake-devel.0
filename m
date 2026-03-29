Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3A3FC72A1
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:30 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34485.1774809263058022126
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=LlcPhtzO;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-20260329183420f7371f9b24000207ac-3gp3tg@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260329183420f7371f9b24000207ac
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=5slPa932EOIuwdVa2QjpcXBG0NCAeGQZyZ5bVhsu8sk=;
 b=LlcPhtzOUHUcpDQ5Qqf3JU9AbhrahdHfdZZVMkFVftbHrNxWaRQmU4H5mVczlGwNV4GOrC
 I2zJu3XLtotqatXeHzB9wJRc6IUAjtyfKgbctVm9OKOtmd9QAr9wGp/v1Y/aP9F9GJFNVyMS
 4CfEHQiUNm67t4HXtbxK9FnfytIbdSqBy+Bb1R+T6reAb7DKYYE3KkFCrnp6LGsmcVDCP9E7
 3xSmmhhO5o8RlxIYgUSBEjR6NRClrYKBo+MdYEnXismuDT4A5D1lNP2oo39GGpxzQ2DDrjwu
 bV8Ca80/xDegU0r0vJI4vRTIfaiIJQoilePGIMUO8VPrYEq6NW2XN5iw==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 10/14] tests/setup: add test_vscode for VSCode workspace generation
Date: Sun, 29 Mar 2026 20:32:57 +0200
Message-ID: <20260329183332.1996183-11-adrian.freihofer@siemens.com>
In-Reply-To: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2026 18:34:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19275

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add test_vscode to BitbakeSetupTest covering the --init-vscode
option introduced in 'bitbake-setup: generate config files for VSCode':

- init --init-vscode creates bitbake.code-workspace with the
  expected top-level structure (folders, settings, extensions).
- Folders list conf and each non-symlink git repo in layers/;
  all paths are relative.
- Bitbake extension settings (pathToBuildFolder, pathToEnvScript,
  disableConfigModification) are set correctly.
- File associations (*.conf, *.inc) and python.analysis.extraPaths /
  python.autoComplete.extraPaths are populated.
- init --no-init-vscode does not create a workspace file.
- update after a layer change preserves user-added folders and
  settings while updating managed ones.
- update with a corrupt workspace file logs an error and leaves the
  file unchanged.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/setup.py | 93 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 1af3d8b50..52120546c 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -538,3 +538,96 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
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
+        self.runbbsetup("update --update-bb-conf='no'")
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
+        self.runbbsetup("update --update-bb-conf='no'")
+        del os.environ['BBPATH']
+        with open(workspace_file) as f:
+            content = f.read()
+        self.assertEqual(content, '{invalid json',
+                         "Corrupt workspace file should not be modified")
-- 
2.53.0


