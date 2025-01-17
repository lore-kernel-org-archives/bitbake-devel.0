Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2580EC02188
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 14:11:49 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.11385.1737123099611655222
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 06:11:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ib5Rn+Dk;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43635796b48so13752005e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 06:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737123098; x=1737727898; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idKk+1LGLB2E/xtS8UI60rPwcq8bK/mnFVBVj6aSq7Y=;
        b=Ib5Rn+DkdMGiPAVM3IKrS57dTWSgyUgdIoPg3oNeA/NGL9ATyrklat8NRJc+o6KrbF
         v6m/Bkyg4wvc5rjoAY21My48gMwHlvUdpmDKwWQ4Ca2aXKA2kr2UD3wWYXWwLsG7PYuu
         334dR2eqvnNZzHzMeIVaN8G9OhyHQzwL7yM80R0Wp4TN+wUV4Jj2pluKrvibmsmtVTXN
         ncdD1pqo2LaLscZaz0+1EgUNcEX4xztll8oCnjWVqTjpvKjw9w2d2+AgX5+KLBbcV/T6
         R4IpslKbmPjgeuVsRsK91EBVbiEafdl7RSjL/kJEp8yJqhxiNVmAjt57vTdBNf7s1Gyi
         y1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737123098; x=1737727898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idKk+1LGLB2E/xtS8UI60rPwcq8bK/mnFVBVj6aSq7Y=;
        b=tOqZMfEYTfLBEVJd0eisvEDgGEwLU7jMOwfYfiXz9RejMBzaFYl/lzyRswCkk7UWUj
         seSFR4vCo7OOU0oM0OHYs8dk+iALu19OG0J6aNh1abl4lWczKaCr6tn1FmLXt17Yhs8v
         fDtxNUZpwZSdzgWsf9mu//y6epYgd3T5Z3lZ/I6Lmbygc0qifkfGpa83vcx3G9BsyDD8
         RDR5+VrwdPg5iOy5YdokLgvtYlqTWe3skS4YNQLi8iFJaMQ0NfvTRSDnuAlGLJ2rQ4Tq
         T7on7Ek5a+f510zYv67IL8qxNEg+LElpznlzKv4VdW6M1ZNMqQAjv2QlRmHx1G6XBZoc
         YX9A==
X-Gm-Message-State: AOJu0Yxn1n80BxLnknZ9ORdGix/IqvMh2bUSlbAv1VFCGRAZ6SNSCpPK
	zTqxUz699bT+pqQWDdU6hrmiU8Fx95XC+5O8mWud5W1nwjZMQPdHZUy7uw==
X-Gm-Gg: ASbGncvBb88NqEb+lRrUsuFK/bmKAvTIjybOtq8z531rnsHZb8ccDsbzWmHexU6KLfZ
	3rC9CoIb1RC0Tu52FS+zgzTkHElb4E1jLKUrwkQrYSMNXCjOfGey3XeWEJVTeEFJLnELQN2/Y20
	ZL+oXRo+NWqzbz3sCZCfWjhMqMbqsR5XO32brmnpp+Cb8sUttSiWhRTIOlPoLy6d+glSHyIFWRl
	7UdJ2ezaAZYumRtuxrScnD63FutTuEpoXcZYdDlmZbrusn5BL5LuQ928x0QZYo6mdd3IsvxwF8b
	0VadbhYT7n1ojAJr5A==
X-Google-Smtp-Source: AGHT+IG1Sx9B0BgyYK3ap9VwTpbZH+MUAe6Ku/EYytbs2vu31rd66L2aJEyYhwmcZeUL4VpyZhnkhA==
X-Received: by 2002:a05:600c:348c:b0:436:1b86:f05 with SMTP id 5b1f17b1804b1-438918f61acmr25333665e9.11.1737123096075;
        Fri, 17 Jan 2025 06:11:36 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890468c67sm35105845e9.34.2025.01.17.06.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 06:11:35 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [RFC PATCH 2/2] bitbake-setup: add tests to bitbake-selftest
Date: Fri, 17 Jan 2025 15:11:27 +0100
Message-Id: <20250117141127.255295-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117141127.255295-1-alex.kanavin@gmail.com>
References: <20250117141127.255295-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 14:11:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17034

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
 lib/bb/tests/setup.py | 222 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 223 insertions(+)
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
index 000000000..ff4bb92e7
--- /dev/null
+++ b/lib/bb/tests/setup.py
@@ -0,0 +1,222 @@
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
+        configpath = os.path.join(self.tempdir, '.bitbake-setup', 'config')
+        os.environ["BITBAKE_SETUP_CONFIG"] = configpath
+
+        self.builddirprefix = os.path.join(self.tempdir, "builds")
+
+        self.configrepopath = os.path.join(self.tempdir, "bitbake-setup-configurations")
+
+        configdata = """
+[default]
+registry = git://{};protocol=file;branch=master;rev=master
+cache-dir = {}/.bitbake-setup
+build-dir-prefix = {}
+""".format(self.configrepopath, self.tempdir, self.builddirprefix)
+        os.makedirs(os.path.dirname(configpath))
+        with open(configpath, 'w') as f:
+            f.write(configdata)
+
+        os.makedirs(self.configrepopath)
+        self.git_init(cwd=self.configrepopath)
+        self.git('commit --allow-empty -m "Initial commit"', cwd=self.configrepopath)
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
+        self.commit_testrepo_file('scripts/oe-setup-build', oesetupbuild, script=True)
+
+        bitbakeconfigbuild = """#!/usr/bin/env python3
+import os
+import sys
+confdir = os.path.join(os.environ['BBPATH'], 'conf')
+fragment = sys.argv[2]
+with open(os.path.join(confdir, fragment), 'w') as f:
+    f.write('')
+"""
+        self.commit_testrepo_file('scripts/bitbake-config-build', bitbakeconfigbuild, script=True)
+
+        sometargetexecutable_template = """#!/usr/bin/env python3
+import os
+print("This is {}")
+print("BBPATH is {{}}".format(os.environ["BBPATH"]))
+"""
+        for e_name in ("some-target-executable-1", "some-target-executable-2"):
+            sometargetexecutable = sometargetexecutable_template.format(e_name)
+            self.commit_testrepo_file('scripts/{}'.format(e_name), sometargetexecutable, script=True)
+
+    def runbbsetup(self, cmd):
+        bbsetup = os.path.abspath(os.path.dirname(__file__) +  "/../../../bin/bitbake-setup")
+        return bb.process.run("{} {}".format(bbsetup, cmd))
+
+    def add_json_config(self, name, rev):
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
+    "configuration": {
+        "bitbake-setup": {
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
+        os.makedirs(os.path.join(self.configrepopath, os.path.dirname(name)), exist_ok=True)
+        with open(os.path.join(self.configrepopath, name), 'w') as f:
+            f.write(config)
+        self.git('add {}'.format(name), cwd=self.configrepopath)
+        self.git('commit -m "Adding {}"'.format(name), cwd=self.configrepopath)
+        import json
+        return json.loads(config)
+
+    def commit_testrepo_file(self, name, content, script=False):
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
+        for c,v in json_config["configuration"]["bitbake-setup"].items():
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
+
+    def test_setup(self):
+        # check that --help works
+        self.runbbsetup("--help")
+
+        # check that list produces correct output with no configs, one config and two configs
+        out = self.runbbsetup("list")
+        self.assertNotIn("test-config-1", out[0])
+        self.assertNotIn("test-config-2", out[0])
+
+        json_1 = self.add_json_config('test-config-1.conf.json', 'master')
+        out = self.runbbsetup("list")
+        self.assertIn("test-config-1", out[0])
+        self.assertNotIn("test-config-2", out[0])
+
+        json_2 = self.add_json_config('config-2/test-config-2.conf.json', 'master')
+        out = self.runbbsetup("list")
+        self.assertIn("test-config-1", out[0])
+        self.assertIn("test-config-2", out[0])
+
+        # check that init/status/update work
+        # (the latter two should do nothing and say that config hasn't changed)
+        test_file_content = 'initial\n'
+        self.commit_testrepo_file('test-file', test_file_content)
+        out = self.runbbsetup("init test-config-1")
+        buildpath = os.path.join(self.builddirprefix, 'test-config-1')
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
+        self.commit_testrepo_file('test-file', test_file_content)
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
+        self.commit_testrepo_file('test-file', test_file_content)
+        json_1 = self.add_json_config('test-config-1.conf.json', branch)
+        out = self.runbbsetup("status")
+        self.assertIn("Top level configuration in {} has changed:".format(buildpath), out[0])
+        self.assertIn('-                "rev": "master"\n+                "rev": "another-branch"', out[0])
+        out = self.runbbsetup("update")
+        self.assertIn("Existing bitbake configuration directory renamed to {}/build-gadget/conf-backup.".format(buildpath), out[0])
+        self.assertIn("Existing bitbake configuration directory renamed to {}/build-gizmo/conf-backup.".format(buildpath), out[0])
+        self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
+        self.check_builddir_files(buildpath, test_file_content, json_1)
-- 
2.39.5


