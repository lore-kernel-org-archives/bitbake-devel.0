Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACAECA0EE0
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 15:15:42 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web10.104035.1755098134698805523
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Aug 2025 08:15:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eYXKKSJe;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459e1338565so62668925e9.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Aug 2025 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098133; x=1755702933; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKrEhNxBQ9MrYuEoqN/6pHSzfyl9m+Yfc4v93534cdE=;
        b=eYXKKSJeBITQiYd4wi0/YChQWVhk41ir6PrbnIhRIpQk2s7/BqGUHLG6s9E+RKIpvS
         u7OiTH3BMi+mNHjnG47ltvFkZS6EM+NWS3zNcfgVmVsLVL9hC1MplNAm7vLMwPUQQUCC
         mrNGa17EqeWMWMlMHfnSqTReAVuvSBA+FB/irrv4IyrRKPJQvXdopcptCwC/7Ny+N1H+
         bwSr9QNhXrFrj9x4p09ypTgLqreH/AGDuIq6w9pgIIdonFIDMD4/s3Q/C6tJ5DX09MZP
         QJ68xdRVHldJYJmlHsFFr+OjXnQ/hDRr3eQAfZNk8T0OLauvzG+Jyb+PmPwzvcHLmipW
         6Uhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098133; x=1755702933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKrEhNxBQ9MrYuEoqN/6pHSzfyl9m+Yfc4v93534cdE=;
        b=SgyF9V/Y+JFlYurLEdD+ZYesH/iviNthVo6Rm/g8mbOJ+bUY2PgkhtOWV3ACX3rLuz
         BFwWycVJTGJUGldph+cznWiKMs/3q4R/NQZlryZT4MNXtIA9qi1/MiZu2vs8p2hbej73
         TO8ONbl4lYG3axeEkaJ9pVzBuh5DKMolNtsuPlhjynIP6408NBJO/CVAkguEBHiqQ/v9
         OdgXezqb2q8Wn9cKcYVN+oipw4OTZUUfJeNHZ2tExdvUBFT6I/BLHOrsGwSFoSkEEER0
         8MUkIlKGzhQzRuVgxjscKBMG2HFv4ar1LoS5bRFsFkDguKoACL+k2WX+VtahdAxGppHk
         8Yvg==
X-Gm-Message-State: AOJu0Ywi1IkAvPF0ON3x7DU4TMTxazIujPuPp+f+fssGNE5u00SsJfuH
	4TNRXpvqUWtAIhF7waJ6t9ZiDfsmDXDy13olWoDqhB2/kmQT6YVP3s68cFXsyQ==
X-Gm-Gg: ASbGnctTNRkrZ0BSHdcWEE6XyucJppaU5qj4AMetMHnS7woIg+Nh5/wdHPZkHErV0vJ
	kNJV9UDtK+wG62XhD8otp63iQ/XTD+fRkaBaCft90MsE3zpqDtIZxm+j+lVX6SvA7BrqagYMAux
	YN9clhJE0z9xW+eIJjAhvHUe7CdAKqlccrEErTP0PfOohbRUf6p2/S+CFsrW6qlurSCwZvDXcJI
	wxODouXKKCLtHr4wJ7dGDgglIQk1YLeBRjaHMhmkxdOm2wwfJiN3Pd/huj0Y6o9R4s1nPmSe+vw
	tMAoH37an1Py5LVgjJ5+hgXJ9e70sFSQgGmbQ8SSrZIF3OoBj/H8d5nJtXa0WDXFztN96ZYXjzJ
	A+IaA86fmwczidn39QA3Kk+Ahw+almtBtSvj56mGMRWHsO4jtXuVl5NLCfJp1s7W0i7lebZlzm9
	74iVUJ
X-Google-Smtp-Source: AGHT+IFI3Jo/LiuSvYvrnIsE/EKVK/RODvlvqF+jfMmk0ohVam9nen661T4pqeOypWG6WWzY5BybRg==
X-Received: by 2002:a05:600c:4f8a:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45a165f7e8fmr34690545e9.31.1755098132599;
        Wed, 13 Aug 2025 08:15:32 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abeb2sm47959808f8f.11.2025.08.13.08.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:15:32 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/3] bitbake-setup: add tests to bitbake-selftest
Date: Wed, 13 Aug 2025 17:15:22 +0200
Message-Id: <20250813151523.1855287-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813151523.1855287-1-alex.kanavin@gmail.com>
References: <20250813151523.1855287-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Aug 2025 15:15:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17873

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
index 000000000..ec9a0a5b0
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


