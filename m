Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FCDC77B7F
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 09:52:27 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.4632.1750758743443626602
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Jun 2025 02:52:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=T9xgXEg3;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a57c8e247cso4096598f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 24 Jun 2025 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750758742; x=1751363542; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLo+kvZxD5Jbn5duq8KEch6pKsVxpqzGnkVPj4ssRLs=;
        b=T9xgXEg3ANQhq+AimdOWUYsmSwc6SKrVRJui2Ia1NE+RnGW2Q958nCUMHAjJhPKcNy
         f/CDUyoBUaHiBrjklO8JcASryIVTh3YkE9QpFoKkTKIG8xt+SNjZAvtTwFgtIh8muSmh
         897TRZF2s0Rcbr2I3IIKErLm6KP06g7JNPX0kvET5UeXPrDalylwgLiKBbTqxCsBfqRH
         e+3yTHGG5BIKt4NI81u20s2S/MHV64nAmikMVILxf2hlR+Gc7dBmSrEnTjzZSmqMXlii
         DZ3Y9wZpvgsdY37ndHykIHKZJnWKI0U2M+ytAAnhzuLrMikt3GoNPIR7fdM+F8fq1ZsE
         SCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750758742; x=1751363542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLo+kvZxD5Jbn5duq8KEch6pKsVxpqzGnkVPj4ssRLs=;
        b=UQgWwRuHa58vp6QBvHADLg9HpQH/iK3sEilWaYu2CAQmQruqri0EcYkqwJAn6TqQBt
         5u8Z1xlRuVraKMADUfoXmFRa/hDrSyH4FZcrDi4zeeNZzwT51W2veM9Vj5NTCbT6/TEA
         g05sG8/7Fq2YwuTF15GJaCUqqSuVUfNb4u6sKKfYR1goLOLXj5O7XrGgOnp0X+v5QECA
         gxde1Ew1Nqqgik7p99/COOJMXFqbr7HU0Ghv1n0sn736HVZzcOph5/If+W1Co2hOEiqc
         ooX+S3/gcCwPuvf67Yd7BPlUDkaArqTf/P9+U0ldDh9ByB7Q7iAnxlDiLFVuyDGA6pEB
         lBNw==
X-Gm-Message-State: AOJu0YxPaKze4heZAxOswXiccvU974yfEnpAHR+EtXJtAUGZcvco6iF5
	rwt2uGcfldTK8cjdfnEnV6eT8K2I6h3KWPsQJGBwGfUrOo+Kw9K8tM64i8Q4LQ==
X-Gm-Gg: ASbGnctj5ukMI5dlCWqfeGBA6ISvTf2XNsOVuR5LiwOzGKOBGOVMMAi18jXW5th5R/h
	GriudrvC4xOU5z7K22ux2Zxs1IntGnZiQ/sQ64sflzLw18UBelGVw3avPamjUsqw49y31uLQTLr
	/CK+3FQQ6nsFpLkGyg7asaPG1HChxbTKFYqzTQwllvc00GdKSZ02zvAqUD9ZEOOgdJjrQp+C4K5
	QprBiZBcWZrcT4prnpI9poxnNIqGFID7GNmoxFHUJ6vn6gCPxWeKjf8k1JPPamLsYlzw/BTVz/q
	HVjCsmhmjSwQV5FbObyeFMFQtjebeU1tIp1PT+eU6PGgRpMcpK1HlVQOM38WCUz3sK3930v4pEl
	ut9aWHGElHNNJb6kRNn7d9cg=
X-Google-Smtp-Source: AGHT+IEmSd7TQqoptLcurMbiNPcX+pp34xFwguwJIZWzpwSBfbze21lfTEaVXFevRnydzR8sKEOpBQ==
X-Received: by 2002:a05:6000:23c1:b0:3a4:fcc3:4a14 with SMTP id ffacd0b85a97d-3a6d13176fbmr8373838f8f.34.1750758741523;
        Tue, 24 Jun 2025 02:52:21 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ead2a84sm170970575e9.32.2025.06.24.02.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 02:52:21 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/2] bitbake-setup: add tests to bitbake-selftest
Date: Tue, 24 Jun 2025 11:52:11 +0200
Message-Id: <20250624095211.3313078-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624095211.3313078-1-alex.kanavin@gmail.com>
References: <20250624095211.3313078-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Jun 2025 09:52:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17712

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
 lib/bb/tests/setup.py | 224 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+)
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
index 000000000..82a117b98
--- /dev/null
+++ b/lib/bb/tests/setup.py
@@ -0,0 +1,224 @@
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
+        out = self.runbbsetup("list --top-dir {} --write-json={}".format(self.topdir, os.path.join(self.tempdir, "test-configs.json")))
+        self.assertIn("test-config-1", out[0])
+        self.assertIn("test-config-2", out[0])
+        json_configs = json.load(open(os.path.join(self.tempdir, "test-configs.json")))
+        self.assertIn("test-config-1", json_configs)
+        self.assertIn("test-config-2", json_configs)
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


