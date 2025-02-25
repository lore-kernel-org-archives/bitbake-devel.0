Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30479C021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 12:11:41 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
 by mx.groups.io with SMTP id smtpd.web11.6646.1740485493711081619
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 04:11:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Yt/i22yU;
 spf=pass (domain: gmail.com, ip: 209.85.218.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abb7f539c35so1071097966b.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 04:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740485492; x=1741090292; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDldUfTx+VcpKLF50v56vPyR2766yu8yAIKTWLtRt+Q=;
        b=Yt/i22yUaDf0DXF8+ASa5qd/REcbwZCPZWlYSHcMEUgpnit+s4ZCJbPRaLEMQSzw1Y
         ZWl11rWezIgnoo/XiswJlI7tzLRdmhuI55HgKRW4/lMAWY9Q19ZfPCf9NmAABuCTlDcT
         D6eTvmFt3OSBjNsY4kR7e4oGE24QAakCZ9hOPdzIYMOoNYMDHfQ1jiqfcFQ8c+1iR1it
         5++K6Byjn8Zux0m5l2cScBWeb/zNwW/99D046Tk6HyOB/LhMxi4bPzaDEGxRA9v/fnOF
         /i/clvQAE2A25cqjla1GTim1gJJfSA5jS3R+YkzTp1muAT/22fttfN2ldUbXAUkZyy8S
         /GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740485492; x=1741090292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDldUfTx+VcpKLF50v56vPyR2766yu8yAIKTWLtRt+Q=;
        b=mVYLzYD28Czut3SPEiXI8WKccM03B09zlREbGZQRmTL4Ec8WjqAj7Ab3CF8fmsSGJv
         ntWMxlUgWDTRnKEzzL0GgiqFKzAm2TxxbQ8U7Xt+ijZ3obkHD31gOdyJd8wQLWtIQBNK
         qzUoSDu0MjSlZzXYJqhEgIgEr7GBPMGNa8upxxM5QEPevl+9//HROzLrPVSy2KjDm6gk
         UlU/Fwu1usNB+xivlzgQ3+HpxQw8VRDoWxAWEokqWOS9leyG9iroqYd27UCgIdlB6iHz
         6u3XyRWpiw2YaaUuSeDHSqybLuEtp5oYYrhw3CmB38P80/ltUznkB2PIWow6vEKgRa7b
         dbrw==
X-Gm-Message-State: AOJu0YzoKUBtX6ZJgU3i6zOIFp5qi8Af4Jffjq1yox0QuIOX4MCMGeSn
	FVyCk7pJ/ak6uCBIuOUHglMNmKZMxvXJHK0lti01aKSAU/HWonx09UPdhw==
X-Gm-Gg: ASbGncuV9OIscPnvBn5XvFMrvQL/V4A3hqrN68hB/NPt7YvfzhO/G20IIs7OTDNSXnb
	Qr3TGlDZtL0bfhSE9W9Ss4f6R2+SCrwpxz02UIYkbMOvsFyXCAU7Nxb5fFXBQM4StJLRobSQcJJ
	a7r9rNzDHw/hkCI0wbgs/gGaXH1zcDjPKDMb4I3DLfswrr27Lr+5i43NZDLXNllNdOnfiDd4pES
	utbn7f36t0gwnLQiI6dPoaO0AdtPYB1AGG1/cHeYooYPEaUImj8hwrKFhabuUpHQleHarmetGEE
	yWf+qdXeUriJHokUg5BGO+t9LRj0rv3h2Xqqs950YtxlkzQQhoTK/JSfAo629Xw=
X-Google-Smtp-Source: AGHT+IEKu4sTEC+xUF0hrdT+XKneXVxB2VNM9v+2nsVFR2TOVrdz2BMIAK2w/4bmldbsd3gtwn+HEQ==
X-Received: by 2002:a17:907:7753:b0:abb:e7ed:d603 with SMTP id a640c23a62f3a-abed0c76db8mr290937066b.9.1740485491616;
        Tue, 25 Feb 2025 04:11:31 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdb131sm130587066b.7.2025.02.25.04.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:11:31 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/2] bitbake-setup: add tests to bitbake-selftest
Date: Tue, 25 Feb 2025 13:11:24 +0100
Message-Id: <20250225121124.172151-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225121124.172151-1-alex.kanavin@gmail.com>
References: <20250225121124.172151-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 12:11:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17316

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
 lib/bb/tests/setup.py | 221 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 lib/bb/tests/setup.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 1b7a783fd..8c1e6d3e7 100755
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
index 000000000..54583c365
--- /dev/null
+++ b/lib/bb/tests/setup.py
@@ -0,0 +1,221 @@
+#
+# Copyright BitBake Contributors
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+from bb.tests.fetch import FetcherTest
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
+        oesetupbuild = """#!/usr/bin/env python3
+import getopt
+import sys
+import os
+import shutil
+opts, args = getopt.getopt(sys.argv[2:], "c:b:", "no-shell")
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
+        "configuration": {
+            "gadget": {
+                "description": "Gadget build configuration",
+                "oe-template": "test-configuration-gadget",
+                "oe-fragments": ["test-fragment-1"],
+                "targets": ["some-target-executable-1"]
+            },
+            "gizmo": {
+                "description": "Gizmo build configuration",
+                "oe-template": "test-configuration-gizmo",
+                "oe-fragments": ["test-fragment-2"],
+                "targets": ["some-target-executable-2"]
+            }
+        }
+    },
+    "version": "1.0"
+}
+""" % (self.testrepopath, rev)
+        os.makedirs(os.path.join(self.registrypath, os.path.dirname(name)), exist_ok=True)
+        with open(os.path.join(self.registrypath, name), 'w') as f:
+            f.write(config)
+        self.git('add {}'.format(name), cwd=self.registrypath)
+        self.git('commit -m "Adding {}"'.format(name), cwd=self.registrypath)
+        import json
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
+        for c,v in json_config["bitbake-setup"]["configuration"].items():
+            bb_build_path = os.path.join(buildpath, 'build-{}'.format(c))
+            bb_conf_path = os.path.join(bb_build_path, 'conf')
+            self.assertTrue(os.path.exists(os.path.join(bb_build_path, 'init-build-env')))
+
+            out = bb.process.run(os.path.join(bb_build_path, 'build-targets'))
+            for t in v["targets"]:
+                self.assertIn("This is {}".format(t), out[0])
+            self.assertIn("BBPATH is {}".format(bb_build_path), out[0])
+
+            with open(os.path.join(bb_conf_path, 'conf-summary.txt')) as f:
+                self.assertEqual(f.read(), v["oe-template"])
+
+            for f in v["oe-fragments"]:
+                self.assertTrue(os.path.exists(os.path.join(bb_conf_path, f)))
+
+            with open(os.path.join(bb_conf_path, 'test-file')) as f:
+                self.assertEqual(f.read(), test_file_content)
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
+        out = self.runbbsetup("reset-settings --top-dir {}".format(self.topdir))
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
+        out = self.runbbsetup("list --top-dir {}".format(self.topdir))
+        self.assertIn("test-config-1", out[0])
+        self.assertIn("test-config-2", out[0])
+
+        # check that init/status/update work
+        # (the latter two should do nothing and say that config hasn't changed)
+        test_file_content = 'initial\n'
+        self.add_file_to_testrepo('test-file', test_file_content)
+        out = self.runbbsetup("init test-config-1 --top-dir {}".format(self.topdir))
+        buildpath = os.path.join(self.topdir, 'test-config-1')
+        self.check_builddir_files(buildpath, test_file_content, json_1)
+        os.environ['BBPATH'] = os.path.join(buildpath, 'build')
+        out = self.runbbsetup("status")
+        self.assertIn("Configuration in {} has not changed".format(buildpath), out[0])
+        out = self.runbbsetup("update")
+        self.assertIn("Configuration in {} has not changed".format(buildpath), out[0])
+
+        # change a file in the test layer repo, make a new commit and
+        # test that status/update correctly report the change and update the config
+        prev_test_file_content = test_file_content
+        test_file_content = 'modified\n'
+        self.add_file_to_testrepo('test-file', test_file_content)
+        out = self.runbbsetup("status")
+        self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, buildpath), out[0])
+        out = self.runbbsetup("update")
+        self.assertIn("Existing bitbake configuration directory renamed to {}/build-gadget/conf-backup.".format(buildpath), out[0])
+        self.assertIn("Existing bitbake configuration directory renamed to {}/build-gizmo/conf-backup.".format(buildpath), out[0])
+        self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
+        self.check_builddir_files(buildpath, test_file_content, json_1)
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
+        out = self.runbbsetup("status")
+        self.assertIn("Configuration in {} has changed:".format(buildpath), out[0])
+        self.assertIn('-                "rev": "master"\n+                "rev": "another-branch"', out[0])
+        out = self.runbbsetup("update")
+        self.assertIn("Existing bitbake configuration directory renamed to {}/build-gadget/conf-backup.".format(buildpath), out[0])
+        self.assertIn("Existing bitbake configuration directory renamed to {}/build-gizmo/conf-backup.".format(buildpath), out[0])
+        self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
+        self.check_builddir_files(buildpath, test_file_content, json_1)
-- 
2.39.5


