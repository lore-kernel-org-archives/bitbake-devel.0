Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842DFCA1006
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 13:58:50 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web10.52453.1756735125510590384
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 06:58:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IT4u6Tjc;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0415e03e25so180195666b.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756735124; x=1757339924; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nm781LfaLfIxwhkNwszFvYlERkd11CO7+FWdmA3zOLo=;
        b=IT4u6Tjc6gH1WnPitX3ziYnMUAFD4VdUzWl+BdSYFcRX/GAT/nJJQI5r2g/n9tBN5s
         9L4nU3e/3VhqdMCCpvWcZE0JIdsNm61BZS8FexhAjFIKs5sjtEWHhg5u+M5RCnwPqckn
         jpl0ORjJn8o+YPaJT3YhIgc46f7HMghbv3T0Yow5EeIXQPKwaZe2qUaHVNCZH3XFIfV3
         S+ciuGQ4kBQWwZbpshYhPFdAhRXZ4M4+siZVBVV5x1RmpuOa5K5jyJ1KbSgKTXad3zqT
         zh12bHdqV1FsTbSRHOXuFFk4qXKolHr6zDpNU+bN68/pGx6LcIBOCvVdCoqmOWN3UQUU
         qBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735124; x=1757339924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nm781LfaLfIxwhkNwszFvYlERkd11CO7+FWdmA3zOLo=;
        b=H4ZoGiZu/71w5C/kNSklXQ2WtVjBzo29S1/XFS3p6tmRhLPQpBrriUBE9VfmDcrSW3
         XpbGi+2ZWZzt6FeWqcd3VUnwi9N24nUD57UhXArAWCjz51s2d5I80uGsDKarmX+f/5h/
         cz9N6bESpK5MQ0lKljOrXTgW/q8RmwoL/SPlSLlCoKRnEHNclHruxNv5EJuOVQn4HCNN
         OJm2hOQ0l/NSkS8bxjwoyg0D/Ky5oXQV2a0sVey7yyFJtug6LYvLtmyzd+k9hJZ+lctL
         QWNPwG4yUjLzQ3Y/IhCUnEdYjjMl3sEr8lgh/KqAj3/7fqBvwhI6df2fJbM+T5a0fQQg
         A/Qw==
X-Gm-Message-State: AOJu0YxwiaTEAaAZB08RspdJ9ZUIFsOyK/PclkPuW5T1BU1P3fXavYC4
	TYsaGErmOY8cT+Vw8ImB0L8BrlfFH3eP1IMV68VqR/7q7SHO3BlfAC6Eu2/bJQ==
X-Gm-Gg: ASbGncsMDaT/pjJq0b6r86P0laAWTcv5mjiv9tw+LI71TzGbs8g4/csSbZvia9rVCQp
	UXaU9A1pP0mDa21qWxSubfWcaTmYUHawNafaNLIdERXWTdw5y2H5KF3rMQ50TQdJYJv1BwlgomM
	MV1vINi5qS6Ep33u2DByXv9TyA0RSyBZn5c00zEVaTeQ85iJpBrGoOTbptr5KZaxDMCmb8rs/st
	jOkmhGtTycuNrMQyPlP1ambOOjUZefo6Baelvrgwryab77zyV9fck04kh3DDa7R4fXDWLhXmZ4R
	Eh/RSwsJzwbgWJoxYc4uP9oK1Ggh44WPEu1LHg7Phs/TTs/cJ3k28CvON9AWAr6XCpl4hp9ZLtx
	OBnbvtko37pB4W4vUedVdSbrLJEUgE6LtkYhuu1vOJ1XOHWfclSQsTC4wzDF19IYXmwWGUdneEX
	xX2Ly2LgwV9xEhQCV2RebjlhQBHSRAOE/1Sj/zIqEGyGnZI7VfK8PEzm7xuWWhX/ifAyII
X-Google-Smtp-Source: AGHT+IGi39cMsXVLgNz/6Yxcq+nZpzxgI0n9a9tbKEJ7LnYMYWiGQuRdlSZRCEKhcZ5+lSDsgwRAwA==
X-Received: by 2002:a17:907:3f10:b0:af6:2f1d:a73f with SMTP id a640c23a62f3a-b01d976e782mr811674966b.53.1756735123604;
        Mon, 01 Sep 2025 06:58:43 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c6fdsm873503166b.75.2025.09.01.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:58:43 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/6] bitbake-setup: add tests to bitbake-selftest
Date: Mon,  1 Sep 2025 15:58:32 +0200
Message-Id: <20250901135836.2927686-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250901135836.2927686-1-alex.kanavin@gmail.com>
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 13:58:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17914

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
 lib/bb/tests/setup.py | 257 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 258 insertions(+)
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
index 000000000..370a1badb
--- /dev/null
+++ b/lib/bb/tests/setup.py
@@ -0,0 +1,257 @@
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
+        self.topdir = os.path.join(self.tempdir, "bitbake-builds")
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
+        return bb.process.run("{} {}".format(bbsetup, cmd))
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
+        # check that writing settings works and then adjust them to point to
+        # test registry repo
+        out = self.runbbsetup("install-settings --top-dir {}".format(self.topdir))
+        settings_path = "{}/bitbake-setup.conf".format(self.topdir)
+        self.assertIn(settings_path, out[0])
+        out = self.runbbsetup("change-setting --top-dir {} default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.topdir, self.registrypath))
+        self.assertIn("Setting 'registry' in section 'default' is changed to", out[0])
+        self.assertIn("New settings written to".format(settings_path), out[0])
+
+        # check that 'list' produces correct output with no configs, one config and two configs
+        out = self.runbbsetup("list --top-dir {}".format(self.topdir))
+        self.assertNotIn("test-config-1", out[0])
+        self.assertNotIn("test-config-2", out[0])
+
+        json_1 = self.add_json_config_to_registry('test-config-1.conf.json', 'master')
+        out = self.runbbsetup("list --top-dir {}".format(self.topdir))
+        self.assertIn("test-config-1", out[0])
+        self.assertNotIn("test-config-2", out[0])
+
+        json_2 = self.add_json_config_to_registry('config-2/test-config-2.conf.json', 'master')
+        out = self.runbbsetup("list --top-dir {} --write-json={}".format(self.topdir, os.path.join(self.tempdir, "test-configs.json")))
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
+        for c in ('gadget','gizmo','gadget-notemplate','gizmo-notemplate'):
+            out = self.runbbsetup("init --non-interactive test-config-1 {} --top-dir {}".format(c, self.topdir))
+            buildpath = os.path.join(self.topdir, 'test-config-1-{}'.format(c))
+            with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
+                config_upstream = json.load(f)
+            self.check_builddir_files(buildpath, test_file_content, config_upstream)
+            os.environ['BBPATH'] = os.path.join(buildpath, 'build')
+            out = self.runbbsetup("status")
+            self.assertIn("Configuration in {} has not changed".format(buildpath), out[0])
+            out = self.runbbsetup("update")
+            self.assertIn("Configuration in {} has not changed".format(buildpath), out[0])
+
+        # change a file in the test layer repo, make a new commit and
+        # test that status/update correctly report the change and update the config
+        prev_test_file_content = test_file_content
+        test_file_content = 'modified\n'
+        self.add_file_to_testrepo('test-file', test_file_content)
+        for c in ('gadget','gizmo'):
+            buildpath = os.path.join(self.topdir, 'test-config-1-{}'.format(c))
+            os.environ['BBPATH'] = os.path.join(buildpath, 'build')
+            out = self.runbbsetup("status")
+            self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, buildpath), out[0])
+            out = self.runbbsetup("update")
+            self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(buildpath), out[0])
+            self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
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
+        for c in ('gadget','gizmo'):
+            buildpath = os.path.join(self.topdir, 'test-config-1-{}'.format(c))
+            os.environ['BBPATH'] = os.path.join(buildpath, 'build')
+            out = self.runbbsetup("status")
+            self.assertIn("Configuration in {} has changed:".format(buildpath), out[0])
+            self.assertIn('-                    "rev": "master"\n+                    "rev": "another-branch"', out[0])
+            out = self.runbbsetup("update")
+            self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(buildpath), out[0])
+            self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
+            with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
+                config_upstream = json.load(f)
+            self.check_builddir_files(buildpath, test_file_content, config_upstream)
-- 
2.39.5


