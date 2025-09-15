Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724C5CAC592
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 14:38:12 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.35320.1757947083280857531
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 07:38:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VzmevMlH;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so2091925f8f.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 07:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757947082; x=1758551882; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE6bV5O9OR91IWqszTeTMEwd16u9cnl3d//ToqloT0c=;
        b=VzmevMlHBOvPzRnv4J8TixqHPLhYxWPhfilV4JlJPg3kBaZMxgWwtcUnrB6FiUd1Vr
         UgXnwoxF54ESgimmJRtj3uL5q02SaGLnHpP2iTDudHn53+XSX9fdiEwC/E9X2ppYItqR
         RRWGTdng/GQpPtRuWy62hsCT7gjNZWAOCO7VwDEmx/yE/zfw23VSXWDsWzNGOwTIB2gu
         ZFm5zDCj5SBS+c/s8HoM6/7FtpnosuqAQHzT3qRfWMTfdwmKwtbBf0SyKLtiFI/9OJ/m
         DRJwMex/tZsvij7X9KQHEf4G2rJXGyPLuQcuZbUioAQfzuQqBdCwnA9AB0HnuE+0yTd+
         VL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757947082; x=1758551882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE6bV5O9OR91IWqszTeTMEwd16u9cnl3d//ToqloT0c=;
        b=UajvK72ivWgZDxzFgINV3ltZNlxa+SUyzk/tAZgtyBJNokqa4/IqXV3xFDhkGvMtsF
         LBKJjkUVpoUfwZ2xp5jWXdIJVBfnY0WlIPy445e7+XiaFAYwD0u6UjbqjExFvlluLHnV
         q+6QKNNnrmWofyAfVHMV/c0YyPJjJLG8rOQoMG4a97UV5lwcbt1VjvHCIfCjot9ruYAA
         CqGQ6koQqPNq0SBL+UDdmS5pUGcMFtHuUB8sZNbts0U6URRkIz8ugkyOptOA/u+qeh1h
         0cciitfaocS1WDBAZ0xnPbOzsb4GgaO8hlUQj8eSSUSmHt2BMFt+GLO4AygtW28Cnmf3
         oToQ==
X-Gm-Message-State: AOJu0Yw9DPEskHk8PFDcFjN7NOedk8IPxhov+MBmkgbFFFVa75JKQKNQ
	191wox+2fLjcWB+C5GgAxUKNKq0T0Kn/9i6pHSAg86GgCmCha4+lo18oXgYw8A==
X-Gm-Gg: ASbGnctr2nZc8JYhytHJXRT3Y7em457438O/gS74tZBHrFCqHKFZbceZhUo3ZX2738O
	97Ikz4mzb+/jNChjPofuSDswqTY4U2GCBcMZNwuu8ZbLmvyc9nj70/IFw83u9fIjwwxt/EOGnBG
	PM3yogLoUResUutHEWvtOyDC+hXjEQ5r+lqxC0xcJvjbOuT7+U+GFdYiwURzc0P5WYS26YGmczP
	4mIsFLCJU3KNBgrNujgLtbJ5YyKu+jcbz/mqxcio6YeScB40lfOP/sdXsaExfXQeCECSbw7rHwI
	mxjJ+PfUW8CpxISqfXaP7koP072hoHl/++szTncSaKK7wcp0prYlipOr0Dga9DoO3ssV9jWZR3w
	aaMLnlBcJs5L9iHcks07TK75QYz0OnW9mWOVNAEm7oJDcNv6rhuDMaJXGVRCFUY8Bo2qJjbORC+
	f2zbaXyrxOoP2TsyonqZrLdaAHLEoqI5QZ9yLS0Yml8Pn42tttZ75LLfc39Nyf7nbYzUUQ
X-Google-Smtp-Source: AGHT+IEYl1yzGrPYM69Nswv7wZH+aemdJz7fVufSK0dNuKsyEfq34pW9imNeTx9E0K+9/iSZIfC3Rg==
X-Received: by 2002:a05:6000:605:b0:3ea:4e8b:c96a with SMTP id ffacd0b85a97d-3ea4e8bd10cmr3483271f8f.57.1757947081505;
        Mon, 15 Sep 2025 07:38:01 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea103f90e4sm6118493f8f.53.2025.09.15.07.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:38:00 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/3] bitbake-setup: add tests to bitbake-selftest
Date: Mon, 15 Sep 2025 16:37:54 +0200
Message-Id: <20250915143755.737161-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915143755.737161-1-alex.kanavin@gmail.com>
References: <20250915143755.737161-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 14:38:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18033

From: Alexander Kanavin <alex@linutronix.de>

Run like this:

alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-selftest -v bb.tests.setup
test_setup (bb.tests.setup.BitbakeSetupTest.test_setup) ... ok

----------------------------------------------------------------------
Ran 1 test in 9.223s

OK

The test does a basic run-through of init, then status/update
on an unchanged configuration, then status/update on a
configuration changed via new commits to the test layer,
then status/update on configuration changed via the top
level json config file.

Note that nothing whatsoever is fetched from the network;
the test relies entirely on synthetic data contained inside
itself, including minimal stubs for oe-setup-build and
bitbake-config-build. This data is used to create temporary
git repositories then clone them via local filesystem URIs.

Later on this can be supplemented by an oe-selftest that
tests bitbake-setup against real config files in the
official configuration repository and real layers,
templates and fragments.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-selftest  |   1 +
 lib/bb/tests/setup.py | 266 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 267 insertions(+)
 create mode 100644 lib/bb/tests/setup.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index d45c2d406..fb7c57dd8 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -29,6 +29,7 @@ tests = ["bb.tests.codeparser",
          "bb.tests.fetch",
          "bb.tests.parse",
          "bb.tests.runqueue",
+         "bb.tests.setup",
          "bb.tests.siggen",
          "bb.tests.utils",
          "bb.tests.compression",
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
new file mode 100644
index 000000000..ab4dbf762
--- /dev/null
+++ b/lib/bb/tests/setup.py
@@ -0,0 +1,266 @@
+#
+# Copyright BitBake Contributors
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+from bb.tests.fetch import FetcherTest
+import json
+
+class BitbakeSetupTest(FetcherTest):
+    def setUp(self):
+        super(BitbakeSetupTest, self).setUp()
+
+        self.registrypath = os.path.join(self.tempdir, "bitbake-setup-configurations")
+
+        os.makedirs(self.registrypath)
+        self.git_init(cwd=self.registrypath)
+        self.git('commit --allow-empty -m "Initial commit"', cwd=self.registrypath)
+
+        self.testrepopath = os.path.join(self.tempdir, "test-repo")
+        os.makedirs(self.testrepopath)
+        self.git_init(cwd=self.testrepopath)
+        self.git('commit --allow-empty -m "Initial commit"', cwd=self.testrepopath)
+
+        oeinitbuildenv = """BBPATH=$1
+export BBPATH
+PATH={}:$PATH
+""".format(os.path.join(self.testrepopath, 'scripts'))
+        self.add_file_to_testrepo('oe-init-build-env',oeinitbuildenv, script=True)
+
+        oesetupbuild = """#!/usr/bin/env python3
+import getopt
+import sys
+import os
+import shutil
+opts, args = getopt.getopt(sys.argv[2:], "c:b:", ["no-shell"])
+for option, value in opts:
+    if option == '-c':
+        template = value
+    if option == '-b':
+        builddir = value
+confdir = os.path.join(builddir, 'conf')
+os.makedirs(confdir, exist_ok=True)
+with open(os.path.join(confdir, 'conf-summary.txt'), 'w') as f:
+    f.write(template)
+shutil.copy(os.path.join(os.path.dirname(__file__), 'test-repo/test-file'), confdir)
+with open(os.path.join(builddir, 'init-build-env'), 'w') as f:
+    f.write("BBPATH={}\\nexport BBPATH\\nPATH={}:$PATH".format(builddir, os.path.join(os.path.dirname(__file__), 'test-repo/scripts')))
+"""
+        self.add_file_to_testrepo('scripts/oe-setup-build', oesetupbuild, script=True)
+
+        bitbakeconfigbuild = """#!/usr/bin/env python3
+import os
+import sys
+confdir = os.path.join(os.environ['BBPATH'], 'conf')
+fragment = sys.argv[2]
+with open(os.path.join(confdir, fragment), 'w') as f:
+    f.write('')
+"""
+        self.add_file_to_testrepo('scripts/bitbake-config-build', bitbakeconfigbuild, script=True)
+
+        sometargetexecutable_template = """#!/usr/bin/env python3
+import os
+print("This is {}")
+print("BBPATH is {{}}".format(os.environ["BBPATH"]))
+"""
+        for e_name in ("some-target-executable-1", "some-target-executable-2"):
+            sometargetexecutable = sometargetexecutable_template.format(e_name)
+            self.add_file_to_testrepo('scripts/{}'.format(e_name), sometargetexecutable, script=True)
+
+    def runbbsetup(self, cmd):
+        bbsetup = os.path.abspath(os.path.dirname(__file__) +  "/../../../bin/bitbake-setup")
+        return bb.process.run("{} --global-settings {} {}".format(bbsetup, os.path.join(self.tempdir, 'global-config'), cmd))
+
+    def add_json_config_to_registry(self, name, rev):
+        config = """
+{
+    "sources": {
+        "test-repo": {
+            "git-remote": {
+                "remotes": {
+                    "origin": {
+                        "uri": "file://%s"
+                    }
+                },
+                "rev": "%s"
+            },
+            "path": "test-repo"
+        }
+    },
+    "description": "Test configuration",
+    "bitbake-setup": {
+        "configurations": [
+            {
+                "name": "gadget",
+                "description": "Gadget build configuration",
+                "oe-template": "test-configuration-gadget",
+                "oe-fragments": ["test-fragment-1"]
+            },
+            {
+                "name": "gizmo",
+                "description": "Gizmo build configuration",
+                "oe-template": "test-configuration-gizmo",
+                "oe-fragments": ["test-fragment-2"]
+            },
+            {
+                "name": "gadget-notemplate",
+                "description": "Gadget notemplate build configuration",
+                "bb-layers": ["layerA","layerB/meta-layer"],
+                "oe-fragments": ["test-fragment-1"]
+            },
+            {
+                "name": "gizmo-notemplate",
+                "description": "Gizmo notemplate build configuration",
+                "bb-layers": ["layerC","layerD/meta-layer"],
+                "oe-fragments": ["test-fragment-2"]
+            }
+        ]
+    },
+    "version": "1.0"
+}
+""" % (self.testrepopath, rev)
+        os.makedirs(os.path.join(self.registrypath, os.path.dirname(name)), exist_ok=True)
+        with open(os.path.join(self.registrypath, name), 'w') as f:
+            f.write(config)
+        self.git('add {}'.format(name), cwd=self.registrypath)
+        self.git('commit -m "Adding {}"'.format(name), cwd=self.registrypath)
+        return json.loads(config)
+
+    def add_file_to_testrepo(self, name, content, script=False):
+        fullname = os.path.join(self.testrepopath, name)
+        os.makedirs(os.path.join(self.testrepopath, os.path.dirname(name)), exist_ok=True)
+        with open(fullname, 'w') as f:
+            f.write(content)
+        if script:
+            import stat
+            st = os.stat(fullname)
+            os.chmod(fullname, st.st_mode | stat.S_IEXEC)
+        self.git('add {}'.format(name), cwd=self.testrepopath)
+        self.git('commit -m "Adding {}"'.format(name), cwd=self.testrepopath)
+
+    def check_builddir_files(self, buildpath, test_file_content, json_config):
+        with open(os.path.join(buildpath, 'layers', 'test-repo', 'test-file')) as f:
+            self.assertEqual(f.read(), test_file_content)
+        bitbake_config = json_config["bitbake-config"]
+        bb_build_path = os.path.join(buildpath, 'build')
+        bb_conf_path = os.path.join(bb_build_path, 'conf')
+        self.assertTrue(os.path.exists(os.path.join(bb_build_path, 'init-build-env')))
+
+        if "oe-template" in bitbake_config:
+            with open(os.path.join(bb_conf_path, 'conf-summary.txt')) as f:
+                self.assertEqual(f.read(), bitbake_config["oe-template"])
+            with open(os.path.join(bb_conf_path, 'test-file')) as f:
+                self.assertEqual(f.read(), test_file_content)
+        else:
+            with open(os.path.join(bb_conf_path, 'conf-summary.txt')) as f:
+                self.assertIn(bitbake_config["description"], f.read())
+            with open(os.path.join(bb_conf_path, 'bblayers.conf')) as f:
+                bblayers = f.read()
+                for l in bitbake_config["bb-layers"]:
+                    self.assertIn(os.path.join(buildpath, 'layers', l), bblayers)
+
+        for f in bitbake_config["oe-fragments"]:
+            self.assertTrue(os.path.exists(os.path.join(bb_conf_path, f)))
+
+
+    def test_setup(self):
+        # check that no arguments works
+        self.runbbsetup("")
+
+        # check that --help works
+        self.runbbsetup("--help")
+
+        # set up global location for top-dir-prefix
+        out = self.runbbsetup("install-global-settings")
+        settings_path = "{}/global-config".format(self.tempdir)
+        self.assertIn(settings_path, out[0])
+        out = self.runbbsetup("change-global-setting default top-dir-prefix {}".format(self.tempdir))
+        self.assertIn("Setting 'top-dir-prefix' in section 'default' is changed to", out[0])
+        self.assertIn("New global settings written to".format(settings_path), out[0])
+
+        # check that writing settings works and then adjust them to point to
+        # test registry repo
+        out = self.runbbsetup("install-settings")
+        settings_path = "{}/bitbake-builds/bitbake-setup.conf".format(self.tempdir)
+        self.assertIn(settings_path, out[0])
+        out = self.runbbsetup("change-setting default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
+        self.assertIn("Setting 'registry' in section 'default' is changed to", out[0])
+        self.assertIn("New settings written to".format(settings_path), out[0])
+
+        # check that 'list' produces correct output with no configs, one config and two configs
+        out = self.runbbsetup("list")
+        self.assertNotIn("test-config-1", out[0])
+        self.assertNotIn("test-config-2", out[0])
+
+        json_1 = self.add_json_config_to_registry('test-config-1.conf.json', 'master')
+        out = self.runbbsetup("list")
+        self.assertIn("test-config-1", out[0])
+        self.assertNotIn("test-config-2", out[0])
+
+        json_2 = self.add_json_config_to_registry('config-2/test-config-2.conf.json', 'master')
+        out = self.runbbsetup("list --write-json={}".format(os.path.join(self.tempdir, "test-configs.json")))
+        self.assertIn("test-config-1", out[0])
+        self.assertIn("test-config-2", out[0])
+        with open(os.path.join(self.tempdir, "test-configs.json")) as f:
+            json_configs = json.load(f)
+        self.assertIn("test-config-1", json_configs)
+        self.assertIn("test-config-2", json_configs)
+
+        # check that init/status/update work
+        # (the latter two should do nothing and say that config hasn't changed)
+        test_file_content = 'initial\n'
+        self.add_file_to_testrepo('test-file', test_file_content)
+        for cf in ('test-config-1', 'test-config-2'):
+            for c in ('gadget','gizmo','gadget-notemplate','gizmo-notemplate'):
+                out = self.runbbsetup("init --non-interactive {} {}".format(os.path.join(self.registrypath,'config-2/test-config-2.conf.json') if cf == 'test-config-2' else cf, c))
+                buildpath = os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
+                with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
+                    config_upstream = json.load(f)
+                self.check_builddir_files(buildpath, test_file_content, config_upstream)
+                os.environ['BBPATH'] = os.path.join(buildpath, 'build')
+                out = self.runbbsetup("status")
+                self.assertIn("Configuration in {} has not changed".format(buildpath), out[0])
+                out = self.runbbsetup("update")
+                self.assertIn("Configuration in {} has not changed".format(buildpath), out[0])
+
+        # change a file in the test layer repo, make a new commit and
+        # test that status/update correctly report the change and update the config
+        prev_test_file_content = test_file_content
+        test_file_content = 'modified\n'
+        self.add_file_to_testrepo('test-file', test_file_content)
+        for c in ('gadget','gizmo','gadget-notemplate','gizmo-notemplate'):
+            buildpath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
+            os.environ['BBPATH'] = os.path.join(buildpath, 'build')
+            out = self.runbbsetup("status")
+            self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, buildpath), out[0])
+            out = self.runbbsetup("update")
+            if c in ('gadget','gizmo'):
+                self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(buildpath), out[0])
+                self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
+            with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
+                config_upstream = json.load(f)
+            self.check_builddir_files(buildpath, test_file_content, config_upstream)
+
+        # make a new branch in the test layer repo, change a file on that branch,
+        # make a new commit, update the top level json config to refer to that branch,
+        # and test that status/update correctly report the change and update the config
+        prev_test_file_content = test_file_content
+        test_file_content = 'modified-in-branch\n'
+        branch = "another-branch"
+        self.git('checkout -b {}'.format(branch), cwd=self.testrepopath)
+        self.add_file_to_testrepo('test-file', test_file_content)
+        json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch)
+        for c in ('gadget','gizmo','gadget-notemplate','gizmo-notemplate'):
+            buildpath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
+            os.environ['BBPATH'] = os.path.join(buildpath, 'build')
+            out = self.runbbsetup("status")
+            self.assertIn("Configuration in {} has changed:".format(buildpath), out[0])
+            self.assertIn('-                    "rev": "master"\n+                    "rev": "another-branch"', out[0])
+            out = self.runbbsetup("update")
+            if c in ('gadget','gizmo'):
+                self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(buildpath), out[0])
+                self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
+            with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
+                config_upstream = json.load(f)
+            self.check_builddir_files(buildpath, test_file_content, config_upstream)
-- 
2.39.5


