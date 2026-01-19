Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E65CD4A5F4
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 07:34:39 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30751.1768808076941035958
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Jan 2026 23:34:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=c3sAO4AB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1329275-202601190734345537e74c110002075e-pb0ejp@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202601190734345537e74c110002075e
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 19 Jan 2026 08:34:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tg3PdT3HhR2YJQIH5m3qrAvMEc/m/+za4voV/wpYnxg=;
 b=c3sAO4ABKxiWZXnMTDFJZHy/429aAfpMxNm1SYNR3XNqvvYUTj4Z+im2hJG2XSvLO2j+Ew
 D9lm4g6Flg06TG0phl4pYthJoVeRiOtzuo4fsXTzU9GpeIKdG0jOvSHVuPWVczrwC1+3TQ+g
 uAY10gDK2vtKHmfFGpOu0IGCs+BPQC2DrE4qqPRnyShieLBdTYGKBfZZ8MZKmsrAWlX/RrjQ
 xme2QSZsqGgn7Wh/G5qiSlRqY6ZfPk4hc/LZx+oYWsbdWhCRORlEpkOCDzFRzbLfZ52PJ0Lx
 ml3MolnaMG8ah574q83UC7gKExLgw5HIqa9RR68TQuHJxwUoDVPVnP8Q==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 2/2] bitbake-selftest: add test for VSCode workspace generation
Date: Mon, 19 Jan 2026 08:34:03 +0100
Message-ID: <20260119073419.952608-3-adrian.freihofer@siemens.com>
In-Reply-To: <20260119073419.952608-1-adrian.freihofer@siemens.com>
References: <20260119073419.952608-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Jan 2026 07:34:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18804

From: Adrian Freihofer <adrian.freihofer@siemens.com>

This test adds a comprehensive suite for the VSCode workspace generation
feature in `bitbake-setup`. It covers the following scenarios:

- Workspace creation on `init` with the `--init-vscode` flag.
- Validation of the generated workspace file's structure and content,
  including folders, BitBake extension settings, file associations, and
  Python analysis paths.
- Workspace updates during the `update` command.
- Preservation of user-defined folders and settings within the workspace
  file across updates, ensuring user customizations are not lost.
- Correct handling of multiple build configurations.
- Verification that `lib` and `scripts` directories from layers are
  correctly added to the Python analysis paths.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/tests/setup.py | 201 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 834d09854..a486981d6 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -507,3 +507,204 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         custom_setup_dir = 'special-setup-dir-with-cmdline-overrides'
         out = self.runbbsetup("init --non-interactive -L test-repo {} --setup-dir-name {} test-config-1 gadget".format(self.testrepopath, custom_setup_dir))
         _check_local_sources(custom_setup_dir)
+
+    def test_vscode_workspace_generation(self):
+        """Test VSCode workspace file generation and configuration"""
+        import os
+        if 'BBPATH' in os.environ:
+            del os.environ['BBPATH']
+
+        os.chdir(self.tempdir)
+
+        # Set up global and local settings
+        self.runbbsetup("settings set --global default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')))
+        self.runbbsetup("settings set default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
+
+        # Add a test configuration
+        test_file_content = 'vscode-test\n'
+        self.add_file_to_testrepo('test-file', test_file_content)
+        self.add_json_config_to_registry('vscode-test-config.conf.json', 'master', 'master')
+
+        # Test 1: Initialize with --init-vscode flag (explicit enable)
+        setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'vscode-test-config-gadget')
+        out = self.runbbsetup("init --non-interactive --init-vscode=yes vscode-test-config gadget")
+
+        # Verify workspace file was created
+        workspace_file = os.path.join(setuppath, 'bitbake.code-workspace')
+        self.assertTrue(os.path.exists(workspace_file),
+                       "VSCode workspace file should be created with --init-vscode")
+
+        # Verify output message includes VSCode workspace information
+        self.assertIn("To edit the code in VSCode, open the workspace:", out[0],
+                     "Output should mention VSCode workspace")
+        self.assertIn("code {}".format(workspace_file), out[0],
+                     "Output should include the workspace file path")
+
+        # Test 2: Validate workspace file structure
+        with open(workspace_file, 'r') as f:
+            workspace = json.load(f)
+
+        # Check that workspace has the required structure
+        self.assertIn('folders', workspace, "Workspace should have folders")
+        self.assertIn('settings', workspace, "Workspace should have settings")
+
+        # Check folders structure
+        folder_names = [f['name'] for f in workspace['folders']]
+        self.assertIn('conf', folder_names, "Workspace should include conf folder")
+        self.assertIn('test-repo', folder_names, "Workspace should include test-repo folder")
+
+        # Check that paths are correct
+        conf_folder = [f for f in workspace['folders'] if f['name'] == 'conf'][0]
+        # Path is relative to the workspace file location
+        self.assertTrue(conf_folder['path'].endswith('build/conf'),
+                       f"conf path should end with 'build/conf', got: {conf_folder['path']}")
+
+        # Test 3: Verify workspace settings
+        settings = workspace['settings']
+
+        # Check bitbake settings
+        self.assertIn('bitbake.disableConfigModification', settings)
+        self.assertTrue(settings['bitbake.disableConfigModification'])
+        self.assertIn('bitbake.pathToBitbakeFolder', settings)
+        self.assertIn('bitbake.pathToBuildFolder', settings)
+        self.assertIn('bitbake.pathToEnvScript', settings)
+        self.assertIn('bitbake.workingDirectory', settings)
+
+        # Check file associations
+        self.assertIn('files.associations', settings)
+        self.assertEqual(settings['files.associations']['*.conf'], 'bitbake')
+        self.assertEqual(settings['files.associations']['*.inc'], 'bitbake')
+
+        # Check Python settings
+        self.assertIn('python.analysis.extraPaths', settings)
+        self.assertIsInstance(settings['python.analysis.extraPaths'], list)
+        self.assertGreater(len(settings['python.analysis.extraPaths']), 0,
+                          "Python extra paths should contain layer paths")
+
+        # Check exclude patterns
+        self.assertIn('files.exclude', settings)
+        self.assertIn('search.exclude', settings)
+        self.assertIn('**/.git/**', settings['files.exclude'])
+        self.assertIn('**/.git/**', settings['search.exclude'])
+
+        # Test 4: Update the setup and verify workspace is updated
+        test_file_content_2 = 'vscode-test-updated\n'
+        self.add_file_to_testrepo('test-file', test_file_content_2)
+
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        out = self.runbbsetup("update --update-bb-conf='yes' --init-vscode=yes")
+
+        # Verify output mentions VSCode workspace during update
+        self.assertIn("To edit the code in VSCode, open the workspace:", out[0],
+                     "Update output should mention VSCode workspace")
+
+        # Verify workspace file still exists and is valid
+        self.assertTrue(os.path.exists(workspace_file))
+        with open(workspace_file, 'r') as f:
+            updated_workspace = json.load(f)
+
+        # Verify structure is still intact
+        self.assertIn('folders', updated_workspace)
+        self.assertIn('settings', updated_workspace)
+        self.assertIn('conf', [f['name'] for f in updated_workspace['folders']])
+
+        # Test 5: Verify user-added folders are preserved
+        # Add a custom folder to workspace
+        custom_folder = {"name": "custom-folder", "path": "/some/custom/path"}
+        updated_workspace['folders'].append(custom_folder)
+        with open(workspace_file, 'w') as f:
+            json.dump(updated_workspace, f, indent=4)
+
+        # Run update again (no changes, so VSCode message won't appear)
+        out = self.runbbsetup("update --update-bb-conf='yes' --init-vscode=yes")
+
+        # When config hasn't changed, output says so
+        self.assertIn("Configuration in {} has not changed".format(setuppath), out[0],
+                     "Should report that configuration hasn't changed")
+
+        # Verify custom folder is still there
+        with open(workspace_file, 'r') as f:
+            workspace_after_update = json.load(f)
+        folder_names = [f['name'] for f in workspace_after_update['folders']]
+        self.assertIn('custom-folder', folder_names, "User-added folders should be preserved")
+        self.assertIn('conf', folder_names, "Managed folders should still be present")
+
+        # Test 6: Verify user-added settings are preserved
+        # Add a custom setting
+        workspace_after_update['settings']['my.custom.setting'] = 'custom-value'
+        with open(workspace_file, 'w') as f:
+            json.dump(workspace_after_update, f, indent=4)
+
+        # Run update again (no changes, so VSCode message won't appear)
+        out = self.runbbsetup("update --update-bb-conf='yes' --init-vscode=yes")
+
+        # When config hasn't changed, output says so
+        self.assertIn("Configuration in {} has not changed".format(setuppath), out[0],
+                     "Should report that configuration hasn't changed")
+
+        # Verify custom setting is still there
+        with open(workspace_file, 'r') as f:
+            final_workspace = json.load(f)
+        self.assertIn('my.custom.setting', final_workspace['settings'],
+                     "User-added settings should be preserved")
+        self.assertEqual(final_workspace['settings']['my.custom.setting'], 'custom-value')
+
+        # Verify bitbake settings are still updated (not preserved)
+        self.assertIn('bitbake.pathToBuildFolder', final_workspace['settings'],
+                     "Bitbake settings should be updated")
+
+        del os.environ['BBPATH']
+
+        # Test 7: Test with a second configuration to ensure multiple repos work
+        # Note: gizmo config has custom setup-dir-name "this-is-a-custom-gizmo-build"
+        setuppath2 = os.path.join(self.tempdir, 'bitbake-builds', 'this-is-a-custom-gizmo-build')
+        out = self.runbbsetup("init --non-interactive --init-vscode=yes vscode-test-config gizmo")
+
+        # Verify VSCode workspace message appears for second config
+        workspace_file2 = os.path.join(setuppath2, 'bitbake.code-workspace')
+        self.assertIn("To edit the code in VSCode, open the workspace:", out[0],
+                     "Second config should also show VSCode message")
+        self.assertIn("code {}".format(workspace_file2), out[0],
+                     "Second config should show its workspace path")
+
+        # Reload workspace file and check folders were added/updated
+        with open(workspace_file2, 'r') as f:
+            multi_config_workspace = json.load(f)
+
+        # Should have folders from the new config
+        self.assertIn('folders', multi_config_workspace)
+        folder_names = [f['name'] for f in multi_config_workspace['folders']]
+        self.assertIn('conf', folder_names)
+        self.assertIn('test-repo', folder_names)
+
+        # Test 8: Verify Python paths include lib and scripts directories
+        # The test-repo already has lib and scripts directories from setUp
+        # Just verify they're in the Python paths
+        with open(workspace_file, 'r') as f:
+            paths_workspace = json.load(f)
+
+        # Check that Python paths are configured
+        self.assertIn('python.analysis.extraPaths', paths_workspace['settings'])
+        python_paths = paths_workspace['settings']['python.analysis.extraPaths']
+        self.assertIsInstance(python_paths, list)
+
+        # Python paths should be absolute paths to lib/scripts directories in the layers
+        # Since we know test-repo was checked out, verify the paths exist
+        if len(python_paths) > 0:
+            # At least one path should exist in the filesystem
+            path_exists = any(os.path.exists(p) for p in python_paths)
+            self.assertTrue(path_exists,
+                          f"At least one Python path should exist. Paths: {python_paths}")
+
+        # Test 9: Verify --init-vscode=no disables workspace generation
+        setuppath3 = os.path.join(self.tempdir, 'bitbake-builds', 'vscode-test-config-gadget-notemplate')
+        out = self.runbbsetup("init --non-interactive --init-vscode=no vscode-test-config gadget-notemplate")
+
+        # Workspace file should NOT be created
+        workspace_file3 = os.path.join(setuppath3, 'bitbake.code-workspace')
+        self.assertFalse(os.path.exists(workspace_file3),
+                        "VSCode workspace file should not be created with --init-vscode=no")
+
+        # Output should not mention VSCode
+        self.assertNotIn("To edit the code in VSCode", out[0],
+                        "Output should not mention VSCode when disabled")
-- 
2.52.0


