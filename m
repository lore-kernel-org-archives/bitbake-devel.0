Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926BACA100B
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 13:58:50 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web10.52454.1756735126448323100
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 06:58:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MtwyyMbt;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-affc2eb83c5so358152666b.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756735125; x=1757339925; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+ZnrXJF6+k7F5TENY/yTbtIRHQyZzBFbxoX/AcwhC0=;
        b=MtwyyMbteC6Mbgszm07Pu7ITbEX3Yg/vuAcewyVJH4BE7ww689hkbwhv8KRrBA8N4a
         6UXRZRhGxtotunoqoDmJR/BRgz2qpC1YSIoah+wKBVGtjfaYOBP2Z59HWMJhl3QyUpWz
         ddp8OAt/EFuvPzJTkMOSk1GYnEpEROFzTwn8gkbR59MTOLKVLkvjEY1HY0FRNATpGfe7
         lSlwmAYD2hG73wGpY6VLJrzss/Z7AdIShRNLh772zYvqB6pheC/NQ8sgF9w3C3tjH1J2
         d1lthMhYZHEwCTsHmjESa3bkCJVQz25rXfuV7V7ao2vrEqBBOmMHSLzFCua4thF3qz4/
         YEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735125; x=1757339925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+ZnrXJF6+k7F5TENY/yTbtIRHQyZzBFbxoX/AcwhC0=;
        b=VaJ5u6OQ/YehvZPpv+kSwNjMzFXIzzzSE0pEI2yoRNTcVAmjlfETVB8McUlWOllQiP
         TiHhX13zu++Vpd16KjPiGVfe0OkfWOawnCJan4QzwkszBdnJwDJDQA9lbywO8CyYi8fe
         5N1SluQYgBv0GE/GaUvu6E44FJL+dA+l8CAZaSwlNCMDSyhw/4HTK5CvNWLZoUSrQ1L6
         pddBVz45csYok2QOR2NJIaqxlkpNgEQG3PO0WctuvOHElEMMOnrAYARz9X+HNkkNZWgv
         iPe+9O5HeAFkLnRBF3Un90vWwfkEli3JGI2c3j/W7BlUyAy5VKc7nprg5imDRO2MsJq2
         vCmQ==
X-Gm-Message-State: AOJu0Yy9TCtTQPd7ITEJ4vG7q3OA1dlDrNGNH7ulqdNti6tfB9yII3yR
	lEMe/5JkQx9FfFQaG2xeZqaG9zge6g9zBmLii5+YgDmIBH61UrnXe5Pdk3qZGg==
X-Gm-Gg: ASbGnctK1QrYg5TpyZTYu0hKM0p3phgZqxbkjk4uzsvsh29PkWmT6JKzkJRs4vt5ydG
	xOP8tNHZmDock2aVGXAmuzhC2GCokTDn0wpq7ybdE3bQwvKOh5qI4q8sEdjylsHFyoAHh2blMAC
	/BXBmTsiSw8IaWVvMLjHMBDHmUoswWazViTXeGKS88xi/mvTT0mVv01ypo4hwsB9ajZKVNNgUKU
	8ZQA4vObMVvYuPW1OJic/gl35tqrcnqT5qk4SPeGZ6jmC3c/IwFP6NpTvoOBCZd7r8YgY6/33nI
	Qi/+DXLOc39p1Fdrz0brQupJEUKMZ8L/PKOWXbxqd3ThrHN0rnBgU4uBbXgJEAvLr0tlzyIZUN8
	4NCBloRRSXupa+4gZwmw9/802giYOxNITIu3Nb+rWJqtuNWhgYz74FYWeks+9/AuZTxT/6Shoyx
	Ysu0ev/HSO88t96jel2YlzHDhamOxSTFnnBGF9QUKDVbV6h9zY1tKqvCDeSm7zUR1UfG4p
X-Google-Smtp-Source: AGHT+IEhpbgAa9peT2XbERfP4TqdlwXyyLKJ+Fjwn6CTaauruyyKFT4p4CXqF2DdVmTfel2Uz1dHuQ==
X-Received: by 2002:a17:907:724c:b0:afe:c1bd:b6d6 with SMTP id a640c23a62f3a-b01d8a327damr672820566b.5.1756735124571;
        Mon, 01 Sep 2025 06:58:44 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1c6fdsm873503166b.75.2025.09.01.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:58:44 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/6] bitbake-setup: add 'install-buildtools' command
Date: Mon,  1 Sep 2025 15:58:33 +0200
Message-Id: <20250901135836.2927686-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250901135836.2927686-1-alex.kanavin@gmail.com>
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Sep 2025 13:58:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17915

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
index a05433206..596c9885a 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -16,6 +16,8 @@ import stat
 import tempfile
 import configparser
 import datetime
+import glob
+import subprocess
 
 default_registry = 'git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main'
 
@@ -530,6 +532,25 @@ def list_configs(settings, args, d):
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
 
@@ -656,6 +677,11 @@ def main():
     add_build_dir_arg(parser_update)
     parser_update.set_defaults(func=build_update)
 
+    parser_install_buildtools = subparsers.add_parser('install-buildtools', help='Install buildtools which can help fulfil missing or incorrect dependencies on the host machine')
+    add_build_dir_arg(parser_install_buildtools)
+    parser_install_buildtools.add_argument('--force', action='store_true', help='Force a reinstall of buildtools over the previous installation.')
+    parser_install_buildtools.set_defaults(func=install_buildtools)
+
     parser_install_settings = subparsers.add_parser('install-settings', help='Write a settings file with default values into the top level directory (contains the location of build configuration registry, downloads directory and other global settings)')
     add_top_dir_arg(parser_install_settings)
     parser_install_settings.set_defaults(func=write_settings)
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 370a1badb..f360efaca 100644
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


