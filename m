Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CEAC87FCF
	for <webhook@archiver.kernel.org>; Wed, 13 Aug 2025 15:15:42 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.104036.1755098135342116150
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Aug 2025 08:15:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DOLyQJa+;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b792b0b829so6740810f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Aug 2025 08:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098134; x=1755702934; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVXYNgGnUZ5VT6Mw6YoouFHfpwAIlBvKpYCEJcWRwK0=;
        b=DOLyQJa+nk+p5DGseUwIpZce7MXq9jExrL438HS2ZuUx5Hj4xQtDr2N6foU9o2g7fQ
         GLprgDtTyMFd3uPEXXVW1S6mKW6o6LzWZqQU/kGegzebudU78QY7vBUugBbUtRx7QBlb
         bda2+8KJAevFH55OeaPn50mjeQv++5KsgT0fvksQByW0SxOPFn1O6StjS3S8esL9hhca
         CjEl8M1tEfA6o/UP7FZhXIGclMermwkJZSCOXOh0JJuJxJzcS+xFd9ZoAIfSQqpwL4Xw
         gOK/U25WX/k1CNtvrhMEegidEGuYjhE6ovImD7a3J0c6+zCy0sLI9diV4t/UrVt8y9m/
         R/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098134; x=1755702934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HVXYNgGnUZ5VT6Mw6YoouFHfpwAIlBvKpYCEJcWRwK0=;
        b=GOzD5am3nTkrv16C2NDMH56LV2LjAyxBV/5sBlnY7p5LA3Sp0n7sSfLpp99xk4lCsU
         nn0+JxV1dPgEhRMPYfVopMOwokuAjRybtTSkmkXYCo6JKsED4sPcHtLK+LK+GH0JoYO7
         +cSwrW2h6GErMMZ2W5CXLNSSNljD4HTB3SIrgkwY1EdUq2FsX2Bxt6PbaRUMLwW43ujl
         t7OoH2//e9MPV3/O+n5X/OU/bWwh0cA+Mu2MRto0apBUp/1f9DZIdcTp6uwUSwATQmsE
         jraDJBMNMbaGHuVhX1SNwPjb0G39NSY+zOc57st09w6KN5GfoK4cvHuCT7HPxAciQzuh
         vPAg==
X-Gm-Message-State: AOJu0YywcuJgZLIcvOkiH5V/SuYU/lUpjkWO8V8WNfbSEJLraUAW5PNa
	o3Ipu+Gnj0xznFjekmJFvbAszLSPqgQYMx26TcK+Js+GMkjCSQNPeXmhoq48lw==
X-Gm-Gg: ASbGncsq4Xpqxm3MQ7+Zv56g1vFJtz1jB/GKKOOuHhLEcM+1mtj70ccnfsCfMNgO+e3
	8sbymoETIw3EREV6zYke+9A5CgD9Yf1V16YcHTBmqlZoKKIgDuE/xvJj5QpK8qf9NVX7Xl5QpY+
	c5vzWuzsBpnTm4MCZwV1fd3bul+oMTPnCRxcktdRTjhaoXKw+HX5b3LlOMdIltwtxnrK9T0irJC
	7fnMPiIifR6vs0ourVGwJMROuelKavCXjr3283uClvA+Wqxf++2m/ItEsal0jW8nmUYEVRpnHu9
	STGpLrhvTY5nIx2XuQXu8DGiWYNoiJn/ulKgm8VuZwx9SVYy+pK19SlD76oJg1lQ/6c1E0fI0DC
	/EC0S/kam++JSRAUByyfU1a9573iiGnc9nN5/HaD+fkkp8OZznY41iAwgRYafKTmqwl0SYQ==
X-Google-Smtp-Source: AGHT+IFeEe2qarnc1HfD6uG4lj7liuV9k0sJv2j8oUMSrtRaZx4gt/AgqQNYCOeOyUaxDdH1hzm+lQ==
X-Received: by 2002:a05:6000:40dc:b0:3b9:1634:cac3 with SMTP id ffacd0b85a97d-3b917e93300mr2628180f8f.24.1755098133554;
        Wed, 13 Aug 2025 08:15:33 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abeb2sm47959808f8f.11.2025.08.13.08.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:15:32 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/3] bitbake-setup: add 'install-buildtools' command
Date: Wed, 13 Aug 2025 17:15:23 +0200
Message-Id: <20250813151523.1855287-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813151523.1855287-1-alex.kanavin@gmail.com>
References: <20250813151523.1855287-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Aug 2025 15:15:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17874

From: Alexander Kanavin <alex@linutronix.de>

This basically calls install-buildtools from oe-core/poky, but
it ensures via command line parameters that the installation
location is stable and the downloads are preserved for reproducibility:

$ bin/bitbake-setup install-buildtools
Loading settings from /home/alex/bitbake-builds/bitbake-setup.conf

======
Buildtools archive is downloaded into /home/alex/bitbake-builds/yocto-master-testing/buildtools-downloads/20250319141333 and its content installed into /home/alex/bitbake-builds/yocto-master-testing/buildtools

... (output from install-buildtools script)
======

It also detects when buildtools are already installed, and will direct
users what to do:
======
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup install-buildtools
Loading settings from /home/alex/bitbake-builds/bitbake-setup.conf

Buildtools are already installed in /home/alex/bitbake-builds/yocto-master-testing/buildtools.
If you wish to use them, you need to source the the environment setup script e.g.
$ . /home/alex/bitbake-builds/yocto-master-testing/buildtools/environment-setup-x86_64-pokysdk-linux
You can also re-run bitbake-setup install-buildtools with --force option to force a reinstallation
======
Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup     | 26 ++++++++++++++++++++++++++
 lib/bb/tests/setup.py | 20 ++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 11569e67d..80fab0e6b 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -16,6 +16,8 @@ import stat
 import tempfile
 import configparser
 import datetime
+import glob
+import subprocess
 
 default_registry = 'git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main'
 
@@ -514,6 +516,25 @@ def list_configs(settings, args, d):
             json.dump(json_data, f, sort_keys=True, indent=4)
         print("Available configurations written into {}".format(args.write_json))
 
+def install_buildtools(settings, args, d):
+    buildtools_install_dir = os.path.join(args.build_dir, 'buildtools')
+    if os.path.exists(buildtools_install_dir):
+        if not args.force:
+            print("Buildtools are already installed in {}.".format(buildtools_install_dir))
+            env_scripts = glob.glob(os.path.join(buildtools_install_dir, 'environment-setup-*'))
+            if env_scripts:
+                print("If you wish to use them, you need to source the the environment setup script e.g.")
+                for s in env_scripts:
+                    print("$ . {}".format(s))
+            print("You can also re-run bitbake-setup install-buildtools with --force option to force a reinstallation.")
+            return
+        shutil.rmtree(buildtools_install_dir)
+
+    install_buildtools = os.path.join(args.build_dir, 'layers/oe-scripts/install-buildtools')
+    buildtools_download_dir = os.path.join(args.build_dir, 'buildtools-downloads/{}'.format(time.strftime("%Y%m%d%H%M%S")))
+    print("Buildtools archive is downloaded into {} and its content installed into {}".format(buildtools_download_dir, buildtools_install_dir))
+    subprocess.check_call("{} -d {} --downloads-directory {}".format(install_buildtools, buildtools_install_dir, buildtools_download_dir), shell=True)
+
 def default_settings_path(top_dir):
     return os.path.join(top_dir, 'bitbake-setup.conf')
 
@@ -621,6 +642,11 @@ def main():
     add_build_dir_arg(parser_update)
     parser_update.set_defaults(func=build_update)
 
+    parser_install_buildtools = subparsers.add_parser('install-buildtools', help='Install buildtools which can help fulfil missing or incorrect dependencies on the host machine')
+    add_build_dir_arg(parser_install_buildtools)
+    parser_install_buildtools.add_argument('--force', action='store_true', help='Force a reinstall of buildtools over the previous installation.')
+    parser_install_buildtools.set_defaults(func=install_buildtools)
+
     parser_reset_settings = subparsers.add_parser('reset-settings', help='Write a settings file with default values into the top level directory (contains the location of build configuration registry, downloads directory and other global settings)')
     add_top_dir_arg(parser_reset_settings)
     parser_reset_settings.set_defaults(func=write_settings)
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index ec9a0a5b0..9c13c0838 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -51,6 +51,21 @@ with open(os.path.join(builddir, 'init-build-env'), 'w') as f:
 """
         self.add_file_to_testrepo('scripts/oe-setup-build', oesetupbuild, script=True)
 
+        installbuildtools = """#!/usr/bin/env python3
+import getopt
+import sys
+import os
+
+opts, args = getopt.getopt(sys.argv[1:], "d:", ["downloads-directory="])
+for option, value in opts:
+    if option == '-d':
+        installdir = value
+
+print("Buildtools installed into {}".format(installdir))
+os.makedirs(installdir)
+"""
+        self.add_file_to_testrepo('scripts/install-buildtools', installbuildtools, script=True)
+
         bitbakeconfigbuild = """#!/usr/bin/env python3
 import os
 import sys
@@ -217,6 +232,11 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             out = self.runbbsetup("update")
             self.assertIn("Configuration in {} has not changed".format(buildpath), out[0])
 
+        # install buildtools
+        out = self.runbbsetup("install-buildtools")
+        self.assertIn("Buildtools installed into", out[0])
+        self.assertTrue(os.path.exists(os.path.join(buildpath, 'buildtools')))
+
         # change a file in the test layer repo, make a new commit and
         # test that status/update correctly report the change and update the config
         prev_test_file_content = test_file_content
-- 
2.39.5


