Return-Path: <giancarlo.cicellyn@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAE6C5DF86
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 12:07:27 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5480.1787141242197987769
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 05:07:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=H042wJlC;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: giancarlo.cicellyn@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so507806f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787141240; x=1787746040; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WToLFmgZQLFF0+YWV8jw4WkPmUUU7UjNyITIJybQgJY=;
        b=H042wJlCjamMIHaNLtqsdsMJPaqs+zpSCQyu7oaQpT0Y69q2eC4OTmgo1+pIjP96Aq
         2iu7AsIUIrS9L7BU0IXiRXtaDl44rPszY6KNIkhTM+KSQYt0fnHGJDMqKX5TYU4oDbS/
         EZxtl5lfg/n06dBjaAzD0FPxFjVUf7JCXqoZHhW6mmlV1jtc/RIVpz664zohPqGnCIel
         MdVJSWHXd3IWK9xaH3sGMGTzxp+zxky16tChuOqB0Iazx1yVdLb43SynT0B8LrjILNHn
         Dik9BQASMKX9xBqUUyuOQOZAm9ilHztf+M3NvEcmNyhjKQdS+yw8Sbujo5iaflJlmKW/
         jzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787141240; x=1787746040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WToLFmgZQLFF0+YWV8jw4WkPmUUU7UjNyITIJybQgJY=;
        b=q5UQXwxc4wnQ+1he6592KV8ErEuZ659fIokHL9tu74j5X/3PK0ldexwBrc/fIRMSnN
         Dt3xuDbKjfWb5CjMtt0imukkwps4EaXgwXF41SuPThrv9KuYkFkMLgTuyC8VO13WeD/I
         CHbYChppKQZyhM7xp2ZDmmIBbKZBfMbxA8bwesfEosBKDktse0408UhrJ6gYxv4i1Wch
         Q+mJ5OILnfFM+N2WnR+N7cBGkymOTi/Vm1RL8jDtaPxgUO4MXs0V0ti5FYzM4+7BmCcz
         1onzBueY9vCFGi41FVYvd/LBdQ1e4euexkM+YKeY91IBFlRylPyYS9MjgTWX4RTHgM6J
         LHcg==
X-Gm-Message-State: AFuF++n/5hWx1mfJukdYqbozjaCSlFsrw8IcJaCsNO7yeyF+6oAXzYDv
	al/XifiSp/S2SXUTqNmG46P7Qe8miSusoh0yK+bLOz4eYRS2tzBgqXy44yv5wivV
X-Gm-Gg: AR+sD13o9UAQRjXhypUzBeYF3opvqTtNcUoOuz8uav9XljdXgxFoDU5tQXhY2dtgU/3
	w4Tpk33E5H0wLRLSbt6Vd/dRjASiLaHFxCETX8eWxKe9dVZ5p9iZF/NIvE2rxwpJQryF+FIqwTa
	x0ffcw43+B8yDVe017/A7nwxZG8FJyeXCBd1q1aYRWz4WPToxl0FdNW9BECeo7/3k+JxJBTZgYG
	S00QfnuaZ21Q4LSZ0LLOVoLkGT0vhddQEZDypJ08BcBy9EyNHBN2EsT87FbK69QIsn89vt2qtMI
	ClWv9pI/b83KQgtlXYZi5owLq0/4m6HcFr31SBHRbvNiSpiHAA0v5JBV+jTRue0r2kZMoeFST3t
	BT1w44wA53EKXxEl2rwFwgHXQkp3MCuz4bF+kuDDkFaz8Ws7F4kKsBAHXoDD9snCS2pEA+kOXiT
	cWmd+azvzQqzLqNsxVACSkHPTpToXEjiGug4holHmIx4Yts9OZw2JfKN2CgTGyMqueHOwWGkN/p
	4PJF0jQzrWHEvXZBniv15e0ZQx6HbL4lLkYEoGKw4FGCqoVTp5AumyLiV/OgN+cH88fdfkJ6IO8
	Wm/wY83f9XJ4PAyDJp8MKm30UV/p6STHmPUjU+EoYG2wFqu6ZXhP8fk8AmD13n9Af0nBqQ9rHRk
	HZHrIGMsvHhi9dGSodIiiSusmcpGKsfCD2ilnr+o=
X-Received: by 2002:a05:6000:60c:b0:47f:71a6:970e with SMTP id ffacd0b85a97d-482b1e84686mr7811902f8f.2.1787141240132;
        Wed, 19 Aug 2026 05:07:20 -0700 (PDT)
Received: from localhost.localdomain (93-45-67-79.ip101.fastwebnet.it. [93.45.67.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1441725sm4927878f8f.3.2026.08.19.05.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 05:07:19 -0700 (PDT)
From: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com,
	Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
Subject: [PATCH v2] bitbake-setup: preserve build config when init script is missing
Date: Wed, 19 Aug 2026 14:06:44 +0200
Message-ID: <20260819120644.23750-1-giancarlo.cicellyn@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 12:07:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19996

Source revisions can change during bitbake-setup updates. If an updated
source still provides scripts/oe-setup-build but no longer provides
oe-init-build-env, checkout_layers() continues to select that source as
the build environment provider.

setup_bitbake_build() currently discovers the missing init script only
after moving the active build/conf aside and creating replacement
configuration files. It then logs an error and returns, allowing
update_build() to continue writing fixed revisions and committing
configuration state despite the failed environment initialization.

Check for oe-init-build-env before modifying build/conf and raise an
exception when it is unavailable.

The regression test changes the configured source from master to another
branch that retains scripts/oe-setup-build but removes oe-init-build-env,
matching the supported source revision update mechanism. It verifies that
the failed update is reported and leaves the active local.conf unchanged.

Tests:
  LC_ALL=C LANG=C ./bin/bitbake-selftest bb.tests.setup

AI-Generated: Uses OpenAI ChatGPT
Signed-off-by: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
---
Changes in v2:
- model the failure through a supported source revision update instead of
  removing oe-init-build-env from the already configured revision
- make the regression test retain scripts/oe-setup-build while the updated
  revision removes oe-init-build-env
- clarify that the failed initialization replaces the active build/conf
  before returning success to update_build()
- verify the regression on unmodified origin/master and validate the revised
  patch with the full bb.tests.setup suite
---
 bin/bitbake-setup     |  8 +++---
 lib/bb/tests/setup.py | 67 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 34260139c..d214ad568 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -354,6 +354,10 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
     if template and not os.path.exists(oesetupbuild):
         raise Exception("Cannot complete setting up a bitbake build directory from OpenEmbedded template '{}' as oe-setup-build was not found in any layers; please use oe-init-build-env manually.".format(template))
 
+    oeinitbuildenvdir = os.path.join(layerdir, 'oe-init-build-env-dir')
+    if not template and not os.path.exists(os.path.join(oeinitbuildenvdir, "oe-init-build-env")):
+        raise Exception("Could not find oe-init-build-env in any of the layers; please use another mechanism to initialize the bitbake environment")
+
     bitbake_confdir = os.path.join(bitbake_builddir, 'conf')
     backup_bitbake_confdir = add_unique_timestamp_to_path(os.path.join(bitbake_builddir, 'conf-backup'))
     upstream_bitbake_confdir = add_unique_timestamp_to_path(os.path.join(bitbake_builddir, 'conf-upstream'))
@@ -368,10 +372,6 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
     if template:
         bb.process.run([oesetupbuild, "setup", "-c", template, "-b", bitbake_builddir, "--no-shell"])
     else:
-        oeinitbuildenvdir = os.path.join(layerdir, 'oe-init-build-env-dir')
-        if not os.path.exists(os.path.join(oeinitbuildenvdir, "oe-init-build-env")):
-            logger.error("Could not find oe-init-build-env in any of the layers; please use another mechanism to initialize the bitbake environment")
-            return
         _make_init_build_env(bitbake_builddir, os.path.realpath(oeinitbuildenvdir))
 
     _prepend_passthrough_to_init_build_env(bitbake_builddir)
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 53a07ee3a..33ceaf3ce 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -578,6 +578,73 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         out = self.runbbsetup(["init", "--non-interactive", "-L", "test-repo", self.testrepopath, "--setup-dir-name", custom_setup_dir, "test-config-1", "gadget"])
         _check_local_sources(custom_setup_dir)
 
+    def test_update_preserves_build_conf_when_init_build_env_missing(self):
+        if 'BBPATH' in os.environ:
+            del os.environ['BBPATH']
+        os.chdir(self.tempdir)
+
+        self.runbbsetup([
+            "settings", "set", "default", "registry",
+            "'git://{};protocol=file;branch=master;rev=master'".format(
+                self.registrypath
+            ),
+        ])
+        self.add_file_to_testrepo('test-file', 'initial\n')
+        self.add_json_config_to_registry(
+            'test-config-1.conf.json', 'master', 'master'
+        )
+
+        self.runbbsetup([
+            "init",
+            "--non-interactive",
+            "test-config-1",
+            "gadget-notemplate",
+        ])
+
+        setuppath = self.get_setup_path(
+            'test-config-1', 'gadget-notemplate'
+        )
+        local_conf = os.path.join(
+            setuppath, 'build', 'conf', 'local.conf'
+        )
+
+        user_content = 'USER_SETTING = "preserve-me"\n'
+        with open(local_conf, 'w') as f:
+            f.write(user_content)
+
+        branch = 'missing-init-build-env'
+        self.git(['checkout', '-b', branch], cwd=self.testrepopath)
+
+        self.assertTrue(os.path.exists(os.path.join(
+            self.testrepopath, 'scripts', 'oe-setup-build'
+        )))
+        os.remove(os.path.join(self.testrepopath, 'oe-init-build-env'))
+        self.git(['add', '-u'], cwd=self.testrepopath)
+        self.git(
+            ['commit', '-m', 'Remove oe-init-build-env'],
+            cwd=self.testrepopath,
+        )
+
+        self.add_json_config_to_registry(
+            'test-config-1.conf.json', branch, branch
+        )
+
+        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
+        try:
+            with self.assertRaisesRegex(
+                bb.process.ExecutionError,
+                "Could not find oe-init-build-env",
+            ):
+                self.runbbsetup([
+                    "update",
+                    "--update-bb-conf=yes",
+                ])
+        finally:
+            del os.environ['BBPATH']
+
+        with open(local_conf) as f:
+            self.assertEqual(f.read(), user_content)
+
     def test_vscode(self):
         if 'BBPATH' in os.environ:
             del os.environ['BBPATH']
-- 
2.43.0


