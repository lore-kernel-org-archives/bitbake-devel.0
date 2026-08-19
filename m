Return-Path: <giancarlo.cicellyn@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81D5C5B572
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 04:24:49 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.188.1787113479791583387
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Aug 2026 21:24:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=izmddO3z;
 spf=pass (domain: gmail.com, ip: 209.85.221.44, mailfrom: giancarlo.cicellyn@gmail.com)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4815b8781c7so216080f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 18 Aug 2026 21:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787113478; x=1787718278; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yYzrf4HLQ2rSUU/22UciTZdGAfzU5lSfk3t79hN4lH4=;
        b=izmddO3z1XgPzvoIkzaJxygncmWsc1YlnzX/9pT9fz/BuaZQdxM6YOf2Nb8P9LvUMY
         PX3LRakajKLu3nuEX2EGa8kHi5CSlNHU9YQRJECmmxKtKKmeT2QqHleXupUtgu0TxSKw
         +v6gmVS8azTpywRgmdcLT0a1WMnHRzWe4J7gHcAZOp42pDy1Wh5dx49ZFKPx4l/dbPK5
         NtYAwbA6zfaeeJgPrLAVbhhPyvBcgbgWxjpLnexe1Md2TkomVDpxrdNo0aVcN9PBjQI9
         JI+1YXGeyISEA5/fSChQEF7cs6Waoq2nKm4QR9IpsABSQMR/qBHScXFywt+VLTwipAQZ
         Icfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787113478; x=1787718278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yYzrf4HLQ2rSUU/22UciTZdGAfzU5lSfk3t79hN4lH4=;
        b=gtGw3iSk1Ldst4By6Ut8ph4RDIYnuU93RHG9Pbewu64FsfN+Ht8LQVXm24dvUDI7zH
         0vIFSQy4Uyz0WZCHR2XzEVff+1q0pmp+tLonXzFsTKq6zA3LkwQjUEPHNFZhIEJkN+In
         esjCzjXtZrCPSyiC0nBkuUCi1rClnO9Cj7/LHG7UXS36TiBWIH3aqvr+m9ix+AKboBYk
         0RRAF3KQ7O37l9CEiPR8/bMHt9BGVF3yFRRuhQO3Nlia+NvfQEFtApcjujtEQUhTxjcs
         P0nxPvHPAMtJaKbnzml8ki+PE8osB1bQcw85PpofYD3Jk4gRo2UTsh0aUWHzqhwZUsNc
         /65w==
X-Gm-Message-State: AOJu0Yw0TMJKzmjXi3ReCXTcLorV0i8UjFXmVhYGZck+VB2eRAScbmvf
	eXBYnwerwNKHkeTmTo4LAeqFlWi5C5Xy6xvMrH8vrUTdOsUGqFXe4DS5Y5DZ+2o/
X-Gm-Gg: AR+sD131+MziLViEtssJMWQhGs5DoiQzoqYZWy0khcE9vbSaumlGNhIT6LTpnlSCoR2
	VcmIY2cJynlTU457LuHYNTVrmNq6KUoWrpOtCSOVRXxPeDALYDdrDgWxUNVCcQev6g6xDIjrSzY
	Fh85zXWfcFzGkJE9UnzU24Ds9vH6U9gDt3RygImnLCRMmk5Yb84Ukd8H3SuA5XAHMyA75V2sr9g
	kMI8o0GGAPBQk4qEMQIm80yFom+rSx1OJC1fJJf1kJ4ppXyS/A/KjU40dOVekWpm6Xj1BN6qji+
	u8OaytBOe/66eTHanll3C9J1X3IJNFMzGwECnh4wcsdtdoKjI2ncilS36+VlHNleZdX1p8+VAr0
	U9W+No7KDaKakD48h8WW8G5t96icX3S9Weuvm9wU/cQpc3mGyE1yQqd+86C87pvdorJp7/bK4d6
	HqAE1yVlfOZDYNwNqQkXDiRYgVTW9U3orYakngZPmiSAdXkRJmjhNAQoUS/IIrNs6bH90SprPF+
	gE7VlZs60zyTbFahHkvkVnVj8naI8cmF5C/+/O9Kx4TofWK3S7hwQPvcKU9YCXNon6726jxGiHB
	ygKtjoj1nohx3hf1l7r0OEyRFc/chjaopiaSHPCu+gMoDD4zLfOyDoS9ZKmxE93ZZp+sgLFpwYZ
	mMpN1LEG7JG4dj+KpdRLzbR8GDgkqlNcLHQMxhA8=
X-Received: by 2002:a05:6000:4a06:b0:47f:eb80:ff42 with SMTP id ffacd0b85a97d-482b1e875c4mr2434036f8f.4.1787113477769;
        Tue, 18 Aug 2026 21:24:37 -0700 (PDT)
Received: from localhost.localdomain (93-45-67-79.ip101.fastwebnet.it. [93.45.67.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8050sm2246721f8f.19.2026.08.18.21.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 21:24:37 -0700 (PDT)
From: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
Subject: [PATCH] bitbake-setup: preserve build config when init script is missing
Date: Wed, 19 Aug 2026 06:24:17 +0200
Message-ID: <20260819042417.22411-1-giancarlo.cicellyn@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 04:24:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19987

setup_bitbake_build() moves an existing build/conf aside before checking whether oe-init-build-env is available.

If the script disappears between setup and update, the update currently returns without restoring the previous configuration, leaving a freshly generated build/conf in place and reporting success.

Check for oe-init-build-env before modifying build/conf and fail explicitly when it is unavailable. Add a regression test verifying that the update fails and preserves the user's local.conf.

Tests:
  LC_ALL=C LANG=C ./bin/bitbake-selftest bb.tests.setup

AI-Generated: Uses OpenAI ChatGPT
Signed-off-by: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
---
 bin/bitbake-setup     |  8 +++---
 lib/bb/tests/setup.py | 57 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 4 deletions(-)

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
index 53a07ee3a..ab18abd0a 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -578,6 +578,63 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
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
+        os.remove(os.path.join(self.testrepopath, 'oe-init-build-env'))
+        self.git(['add', '-u'], cwd=self.testrepopath)
+        self.git(
+            ['commit', '-m', 'Remove oe-init-build-env'],
+            cwd=self.testrepopath,
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


