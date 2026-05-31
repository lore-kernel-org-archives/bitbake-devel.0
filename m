Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31CBCD6E57
	for <webhook@archiver.kernel.org>; Sun, 31 May 2026 18:27:58 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12306.1780252071164155015
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 May 2026 11:27:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BEVFmIJi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so2077490f8f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1780252069; x=1780856869; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgkY1c4SH1o2j9Ws4g2wN/hm1tta5es9Igq45ztapDM=;
        b=BEVFmIJiHMcM5eTZcmzt0/noI2HOKXSr/lPDotyAd1TbbK57Anoe+OMJw2vXOzfEJs
         dEYVPKEHCLM3+EyqgUspMDwsXq4qGTte45dAcZEc6o8TEvU8MbC21HlemHh2t7Jak8Ys
         i8q0MqwVe4n2FGY2utb04hSdfvAJPHWgKCldA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780252069; x=1780856869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VgkY1c4SH1o2j9Ws4g2wN/hm1tta5es9Igq45ztapDM=;
        b=R/9Gcd7pZdWFvAkebzYKiLcmUd63D4shLGuZh7oqtxZHa2ZVMBW9xNN/CkmHIbShvx
         lyA/1eMat1eIXj1O5WXAtC6UL7dcz6+hOCV181meZEyfDt79RB2Ep0mrNXSE/6CSZo9D
         bK7jlJ2h65NSLHbvnhUpZtxaCsHnHUTVHCEBTx/Z6pC3j5BN/r2SY1XWOhE31GaX2Wlt
         blIdwqtSke3bngTu+WzGjAqZcx2qkqWQ25xzjGts1v7ePd7Ca//gtKnYQTRttMy2tcXC
         0LXZcxJh36NOF98PrqFOzzRW+FRjQQVI9ApKZKWguEKkS802Bt7aWDv0bqWRknS3Zu3S
         MeQw==
X-Gm-Message-State: AOJu0YxgdW6CVO4XgUoERqCh5JMuv99yHdp8g4V9SY2vh1DOsuKdj8uX
	47bepP5gEu0bPF3QHn0YmiKQugx1A2vvb3g8N13cTeJ5sKCQUK+ewc7jycAp0Kw2kfOUWY1Pn5p
	TUCqu
X-Gm-Gg: Acq92OF0WdWeTd3Z+E6Xd6Orb/HN534jQ+cQdZViWJIaPSa+Y0wfH9RNHg/MXoNWhnB
	U8Q4GGbsQVACqqWpYOZh7GKCFJwBLCLUBS5kz+92mKaIwsqilBLoWAPiLS4MQgLl7F2VG+ZRzqE
	yGXFCraIB8GdOLVV7U+QPBj5cdxkJmZLHefBOEj0fN3SxOw2wroDAi8qSppMXu+YQ+9b55tmv08
	w1aWbPlFcnPlSmspe+fMQ7YoFk+SpO3Tbqz9/HUioCChUlUZgnL0iZPYw2a/OuKKAQ5XnMqZbpp
	myVCYKjeBcxHaFVLAaO5UPCgRqsT99x7VJfpeRj4qtbX9OBhwTSqNjQ2j+lrlqTIr9caoFgqn72
	OmLYArXFYhSJnjl/OF8ejM4q9jjaa9NIA+fwLBmOVHhS4zWT6YuuZ+igMLA/ZB6YDh1ocS0NncY
	sNE4YAr/bgIUIYsd4/2YNWd4+Js5rakadCMjhKg+zaODE9yphsN97FQPRVJTqZnAs=
X-Received: by 2002:adf:f80b:0:b0:460:118f:7a73 with SMTP id ffacd0b85a97d-460118f7f2cmr568707f8f.18.1780252069231;
        Sun, 31 May 2026 11:27:49 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:229e:2449:eb7c:dbd2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb62sm18563488f8f.19.2026.05.31.11.27.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 11:27:48 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/6] tests/setup: Convert string commands to lists where possible for runbbsetup
Date: Sun, 31 May 2026 19:27:41 +0100
Message-ID: <20260531182743.2412946-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531182743.2412946-1-richard.purdie@linuxfoundation.org>
References: <20260531182743.2412946-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 May 2026 18:27:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19575

String commands have to be processed by subprocess using shell=True which
is suboptimal for all kinds of reasons, including quoting. Convert to use
a list where possible to improve efficiency and the robustness of code. It
also means copy and paste will be more likely to use the preferred form.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/setup.py | 76 +++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 57d5752b0ed..b30168ed61d 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -219,9 +219,9 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 
     def config_is_unchanged(self, setuppath):
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
-        out = self.runbbsetup("status")
+        out = self.runbbsetup(["status"])
         self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
-        out = self.runbbsetup("update --update-bb-conf='yes'")
+        out = self.runbbsetup(["update", "--update-bb-conf=yes"])
         self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
         del os.environ['BBPATH']
 
@@ -286,50 +286,50 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             del os.environ['BBPATH']
 
         # check that no arguments works
-        self.runbbsetup("")
+        self.runbbsetup([])
 
         # check that --help works
-        self.runbbsetup("--help")
+        self.runbbsetup(["--help"])
 
         # change to self.tempdir to work with cwd-based default settings
         os.chdir(self.tempdir)
 
         # check that the default top-dir-prefix is cwd (now self.tempdir) with no global settings
-        out = self.runbbsetup("settings list")
+        out = self.runbbsetup(["settings", "list"])
         self.assertIn("default top-dir-prefix {}".format(os.getcwd()), out[0])
 
         # set up global location for dl-dir
         settings_path = "{}/global-config".format(self.tempdir)
-        out = self.runbbsetup("settings set --global default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')))
+        out = self.runbbsetup(["settings", "set", "--global", "default", "dl-dir", os.path.join(self.tempdir, 'downloads')])
         self.assertIn("From section 'default' the setting 'dl-dir' was changed to", out[0])
         self.assertIn("Settings written to".format(settings_path), out[0])
 
         # check that writing settings works and then adjust them to point to
         # test registry repo
-        out = self.runbbsetup("settings set default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
+        out = self.runbbsetup(["settings", "set", "default", "registry", "'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath)])
         settings_path = "{}/bitbake-builds/settings.conf".format(self.tempdir)
         self.assertIn(settings_path, out[0])
         self.assertIn("From section 'default' the setting 'registry' was changed to", out[0])
         self.assertIn("Settings written to".format(settings_path), out[0])
 
         # check that listing settings works
-        out = self.runbbsetup("settings list")
+        out = self.runbbsetup(["settings", "list"])
         self.assertIn("default top-dir-prefix {}".format(self.tempdir), out[0])
         self.assertIn("default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')), out[0])
         self.assertIn("default registry {}".format('git://{};protocol=file;branch=master;rev=master'.format(self.registrypath)), out[0])
 
         # check that 'list' produces correct output with no configs, one config and two configs
-        out = self.runbbsetup("list")
+        out = self.runbbsetup(["list"])
         self.assertNotIn("test-config-1", out[0])
         self.assertNotIn("test-config-2", out[0])
 
         json_1 = self.add_json_config_to_registry('test-config-1.conf.json', 'master', 'master')
-        out = self.runbbsetup("list")
+        out = self.runbbsetup(["list"])
         self.assertIn("test-config-1", out[0])
         self.assertNotIn("test-config-2", out[0])
 
         json_2 = self.add_json_config_to_registry('config-2/test-config-2.conf.json', 'master', 'master')
-        out = self.runbbsetup("list --write-json={}".format(os.path.join(self.tempdir, "test-configs.json")))
+        out = self.runbbsetup(["list", "--write-json={}".format(os.path.join(self.tempdir, "test-configs.json"))])
         self.assertIn("test-config-1", out[0])
         self.assertIn("test-config-2", out[0])
         with open(os.path.join(self.tempdir, "test-configs.json")) as f:
@@ -364,14 +364,14 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         try:
             for v in test_configurations:
                 for c in v['buildconfigs']:
-                    out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
+                    out = self.runbbsetup(["init", "--non-interactive", v['cmdline']] + c.split())
                     setuppath = self.get_setup_path(v['name'], c)
                     self.check_setupdir_files(setuppath, test_file_content)
         finally:
             server.stop()
 
         # install buildtools
-        out = self.runbbsetup("install-buildtools --setup-dir {}".format(setuppath))
+        out = self.runbbsetup(["install-buildtools", "--setup-dir", setuppath])
         self.assertIn("Buildtools installed into", out[0])
         self.assertTrue(os.path.exists(os.path.join(setuppath, 'buildtools')))
 
@@ -383,9 +383,9 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         for c in variants:
             setuppath = self.get_setup_path('test-config-1', c)
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
-            out = self.runbbsetup("status")
+            out = self.runbbsetup(["status"])
             self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, setuppath), out[0])
-            out = self.runbbsetup("update --update-bb-conf='yes'")
+            out = self.runbbsetup(["update", "--update-bb-conf=yes"])
             if c in ('gadget', 'gizmo'):
                 self.assertIn("Leaving the previous configuration in {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
@@ -403,10 +403,10 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         for c in variants:
             setuppath = self.get_setup_path('test-config-1', c)
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
-            out = self.runbbsetup("status")
+            out = self.runbbsetup(["status"])
             self.assertIn("Configuration in {} has changed:".format(setuppath), out[0])
             self.assertIn('-                    "rev": "master"\n+                    "rev": "another-branch"', out[0])
-            out = self.runbbsetup("update --update-bb-conf='yes'")
+            out = self.runbbsetup(["update", "--update-bb-conf=yes"])
             if c in ('gadget', 'gizmo'):
                 self.assertIn("Leaving the previous configuration in {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
@@ -438,7 +438,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 with open(f"{setuppath}/build/conf/{f}", "w") as fd:
                     fd.write("deadbeef")
             sums_before = _conf_chksum(f"{setuppath}/build/conf")
-            out = self.runbbsetup("update --update-bb-conf='no'")
+            out = self.runbbsetup(["update", "--update-bb-conf=no"])
             sums_after = _conf_chksum(f"{setuppath}/build/conf")
             self.assertEqual(sums_before, sums_after)
 
@@ -467,7 +467,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 
         json_1 = self.add_local_json_config_to_registry('test-config-1.conf.json', self.testrepopath)
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
-        out = self.runbbsetup("update --update-bb-conf='yes'")
+        out = self.runbbsetup(["update", "--update-bb-conf=yes"])
         _check_local_sources(setuppath)
         _check_layer_backups(layers_path, 1)
 
@@ -476,14 +476,14 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.git(['clone', prev_path, self.testrepopath], cwd=self.tempdir)
         json_1 = self.add_local_json_config_to_registry('test-config-1.conf.json', self.testrepopath)
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
-        out = self.runbbsetup("update --update-bb-conf='yes'")
+        out = self.runbbsetup(["update", "--update-bb-conf=yes"])
         _check_local_sources(setuppath)
         _check_layer_backups(layers_path, 1)
 
         self.testrepopath = prev_path
         json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
-        out = self.runbbsetup("update --update-bb-conf='yes'")
+        out = self.runbbsetup(["update", "--update-bb-conf=yes"])
         self.check_setupdir_files(setuppath, test_file_content)
         _check_layer_backups(layers_path, 1)
 
@@ -493,7 +493,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         test_file_content = "modified-again\n"
         self.add_file_to_testrepo('test-file', test_file_content)
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
-        out = self.runbbsetup("update --update-bb-conf='yes'")
+        out = self.runbbsetup(["update", "--update-bb-conf=yes"])
         _check_layer_backups(layers_path, 1)
 
         ## edit a file and make a commit such that no rebase conflicts occur
@@ -503,7 +503,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.git(['commit', '-m', 'Adding a local modification'], cwd=layer_path)
         test_file_content = "modified-again-and-again\n"
         self.add_file_to_testrepo('test-file', test_file_content)
-        out = self.runbbsetup("update --update-bb-conf='yes'")
+        out = self.runbbsetup(["update", "--update-bb-conf=yes"])
         _check_layer_backups(layers_path, 1)
 
         ## edit a file and make a commit in a way that causes a rebase conflict
@@ -514,7 +514,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         test_file_content = "remotely-modified\n"
         self.add_file_to_testrepo('test-file', test_file_content)
         with self.assertRaisesRegex(bb.process.ExecutionError, "Merge conflict in test-file"):
-            out = self.runbbsetup("update --update-bb-conf='yes'")
+            out = self.runbbsetup(["update", "--update-bb-conf=yes"])
         _check_layer_backups(layers_path, 1)
 
         # check source overrides, local sources provided with symlinks, and custom setup dir name
@@ -531,12 +531,12 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         override_filename = 'source-overrides.json'
         custom_setup_dir = 'special-setup-dir'
         self.add_file_to_testrepo(override_filename, source_override_content)
-        out = self.runbbsetup("init --non-interactive --source-overrides {} --setup-dir-name {} test-config-1 gadget".format(os.path.join(self.testrepopath, override_filename), custom_setup_dir))
+        out = self.runbbsetup(["init", "--non-interactive", "--source-overrides", os.path.join(self.testrepopath, override_filename), "--setup-dir-name", custom_setup_dir, "test-config-1", "gadget"])
         _check_local_sources(custom_setup_dir)
 
         # same but use command line options to specify local overrides
         custom_setup_dir = 'special-setup-dir-with-cmdline-overrides'
-        out = self.runbbsetup("init --non-interactive -L test-repo {} --setup-dir-name {} test-config-1 gadget".format(self.testrepopath, custom_setup_dir))
+        out = self.runbbsetup(["init", "--non-interactive", "-L", "test-repo", self.testrepopath, "--setup-dir-name", custom_setup_dir, "test-config-1", "gadget"])
         _check_local_sources(custom_setup_dir)
 
     def test_vscode(self):
@@ -544,12 +544,12 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             del os.environ['BBPATH']
         os.chdir(self.tempdir)
 
-        self.runbbsetup("settings set default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
+        self.runbbsetup(["settings", "set", "default", "registry", "'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath)])
         self.add_file_to_testrepo('test-file', 'initial\n')
         self.add_json_config_to_registry('test-config-1.conf.json', 'master', 'master')
 
         # --init-vscode should create bitbake.code-workspace
-        self.runbbsetup("init --non-interactive --init-vscode test-config-1 gadget")
+        self.runbbsetup(["init", "--non-interactive", "--init-vscode", "test-config-1", "gadget"])
         setuppath = self.get_setup_path('test-config-1', 'gadget')
         workspace_file = os.path.join(setuppath, 'bitbake.code-workspace')
         self.assertTrue(os.path.exists(workspace_file),
@@ -595,7 +595,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                          settings.get('python.autoComplete.extraPaths'))
 
         # --no-init-vscode should NOT create a workspace file
-        self.runbbsetup("init --non-interactive --no-init-vscode test-config-1 gadget-notemplate")
+        self.runbbsetup(["init", "--non-interactive", "--no-init-vscode", "test-config-1", "gadget-notemplate"])
         notemplate_path = self.get_setup_path('test-config-1', 'gadget-notemplate')
         self.assertFalse(
             os.path.exists(os.path.join(notemplate_path, 'bitbake.code-workspace')),
@@ -610,7 +610,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 
         self.add_file_to_testrepo('test-file', 'updated\n')
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
-        self.runbbsetup("update --update-bb-conf='no'")
+        self.runbbsetup(["update", "--update-bb-conf=no"])
         del os.environ['BBPATH']
 
         with open(workspace_file) as f:
@@ -625,7 +625,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         with open(workspace_file, 'w') as f:
             f.write('{invalid json')
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
-        self.runbbsetup("update --update-bb-conf='no'")
+        self.runbbsetup(["update", "--update-bb-conf=no"])
         del os.environ['BBPATH']
         with open(workspace_file) as f:
             content = f.read()
@@ -654,10 +654,10 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             del os.environ['BBPATH']
         os.chdir(self.tempdir)
 
-        self.runbbsetup("settings set default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
+        self.runbbsetup(["settings", "set", "default", "registry", "'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath)])
         self.add_file_to_testrepo('test-file', 'initial\n')
         self.add_json_config_to_registry('test-config-1.conf.json', 'master', 'master')
-        self.runbbsetup("init --non-interactive test-config-1 gadget")
+        self.runbbsetup(["init", "--non-interactive", "test-config-1", "gadget"])
 
         setuppath = self.get_setup_path('test-config-1', 'gadget')
         layer_path = os.path.join(setuppath, 'layers', 'test-repo')
@@ -672,7 +672,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 
         os.environ['BBPATH'] = os.path.join(setuppath, 'build')
         with self.assertRaises(bb.process.ExecutionError) as ctx:
-            self.runbbsetup("update --update-bb-conf='no'")
+            self.runbbsetup(["update", "--update-bb-conf=no"])
         self.assertIn('has uncommitted changes', str(ctx.exception))
         self.assertIn('--rebase-conflicts-strategy=backup', str(ctx.exception))
         # No backup directory must have been created.
@@ -680,7 +680,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                          "abort strategy must not create any backup")
 
         # Scenario 2: same uncommitted change, 'backup' strategy
-        out = self.runbbsetup("update --update-bb-conf='no' --rebase-conflicts-strategy=backup")
+        out = self.runbbsetup(["update", "--update-bb-conf=no", "--rebase-conflicts-strategy=backup"])
         # One backup directory must now exist.
         self.assertEqual(self._count_layer_backups(layers_path), 1,
                          "backup strategy must create exactly one backup")
@@ -695,7 +695,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 
         # Scenario 3: committed conflicting change, 'backup' strategy
         # Re-initialise a fresh setup so we start from a clean state.
-        self.runbbsetup("init --non-interactive --setup-dir-name rebase-conflict-setup test-config-1 gadget")
+        self.runbbsetup(["init", "--non-interactive", "--setup-dir-name", "rebase-conflict-setup", "test-config-1", "gadget"])
         conflict_setup = os.path.join(self.tempdir, 'bitbake-builds', 'rebase-conflict-setup')
         conflict_layer = os.path.join(conflict_setup, 'layers', 'test-repo')
         conflict_layers = os.path.join(conflict_setup, 'layers')
@@ -713,13 +713,13 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         # Default stop strategy must still fail with a conflict error and include
         # the --rebase-conflicts-strategy=backup hint (same handler as LocalModificationsError).
         with self.assertRaises(bb.process.ExecutionError) as ctx:
-            self.runbbsetup("update --update-bb-conf='no'")
+            self.runbbsetup(["update", "--update-bb-conf=no"])
         self.assertIn('Merge conflict in test-file', str(ctx.exception))
         self.assertIn('--rebase-conflicts-strategy=backup', str(ctx.exception))
         self.assertEqual(self._count_layer_backups(conflict_layers), 0)
 
         # Backup strategy must succeed: backup the conflicted dir and re-clone.
-        self.runbbsetup("update --update-bb-conf='no' --rebase-conflicts-strategy=backup")
+        self.runbbsetup(["update", "--update-bb-conf=no", "--rebase-conflicts-strategy=backup"])
         self.assertEqual(self._count_layer_backups(conflict_layers), 1,
                          "backup strategy must create exactly one backup after a conflict")
         with open(os.path.join(conflict_layer, 'test-file')) as f:

