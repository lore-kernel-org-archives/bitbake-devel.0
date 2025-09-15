Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D056CAC59C
	for <webhook@archiver.kernel.org>; Mon, 15 Sep 2025 14:38:12 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web11.35548.1757947084317177334
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Sep 2025 07:38:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jmP3MDZu;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e9c5faa858so1708635f8f.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757947083; x=1758551883; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uImzv2S4mttVJop5aopxdlsaPjpHF/FiUPr02ZYhCAo=;
        b=jmP3MDZuP6Da5RUNZz2H7fiQKorwoTsS7QNgA36xxHpIVaf4YjRi6fJUZ4m0gfVeXg
         mYgyBjD4cWCOhyxnn8LJ3LTPS7jTHPKbqUiZZkc6bONP7RfwRN7LeBqkCktMbJrg16pr
         lGDjD2zv8aafZVvIc9dhlJor4ZiNtY0iQea3hSQS27y6bVoQhp3G82HG/2was/xQXV17
         ckEe5hvJpCXvpi3us8TlOQgmcOua2H5hjjqvTe9BZraUxmiBBj0hFSZqrP64G82XEg38
         T0IlHFlKf/fsZtxAWhKX8ialZZgRz7K461lYt67bvrNgzZkEwdh5Jf4scatCsp4Vqvgp
         dkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757947083; x=1758551883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uImzv2S4mttVJop5aopxdlsaPjpHF/FiUPr02ZYhCAo=;
        b=BngpllmxHxCbDQ5EI3nnWAkMVNf6MDYfGRS1AuebI1nmQZNfsvQyqtFVles4j0jf4v
         1RDIvq4kXYvg+9kWShQn5gIG9unKFfxfGY79OtcM8ljUusELSeaqIstPTZbSg1ejgFqu
         RCTBzb3zpNgMxv6xUMWqDFbn1BkF6OOK/PgBIWOXxpK4KouPtTe/AzChE92o1yZ7Co/H
         lxsuTTj6IF9c9ze6P7Wve9tHyFYIsg4AAL48M4CEHNfMNgJWbaKvEl36G06t8B7q1t/7
         bOk47/2Vf+NkM6zQgQRfTVFiVYMw0aOBTvNI8SbmKt704+A0xftpv7L0wZH8QPUnH4XM
         /XmA==
X-Gm-Message-State: AOJu0YxhHn9eiyoKl5SD/6vVEeUcBtfPTOjcSDwBbG9ORCJ09cdyXYMY
	T7+7j12faQKGMqC3cN1HGKo/qzCmav+F7TJU5cb2kFNgtXUBSVZoh80EZZ5WlQ==
X-Gm-Gg: ASbGncv2GwMRbMeATqQQEpFKJWG7WC6xu/DcyF8UcPyT3gOTKjDb3zO+p94neSoGzy5
	CetKIuDrpRW2t591GR9xqjch/c+PtjoCkBPfi2nKPjVannNvC5Ov+99Ml/foqJxP9cjS7qM2SA0
	/PElYuW6vlNJRdApQadr4PrDXgXyxrTzVLt7U8rA8o1XW1VaBbAV+liC7oF+dor6NneYbwSrR10
	xraYpcuz4pjbLMmyD3Q8DYmZrM/xVtgVwzbd1CMYNcu8Qvx57SpW7PYMWSaQEGl/IMkNDfqfwHS
	y3gZ+6eysTmb5LwhLdfM4o/dXavzVX0f2YZ18k1nUizYZaXnFoWJDyta/QGjdatKvc3rcL+KVbK
	iKS7MSTKJjOEKhg5NCQ7ct6y+j7cr+ughzf7posnWNxyCTZSjv+dV9f2m7mOt9Rqf+IC6c5S5Is
	4wZ63y4IT815muZSjUbwwO07mlRFo3DqYthOiBRS6CXTKkM5zDBrVDa9w08Q==
X-Google-Smtp-Source: AGHT+IHJcByvJUl72pfU3vHvR1ISRdQ5sVEAkSn6Trp/gtkF4BjuJbvcLrVTaPZTabmu4A/waH/9IQ==
X-Received: by 2002:a5d:5f54:0:b0:3ea:9042:e676 with SMTP id ffacd0b85a97d-3ea9042ec13mr3439598f8f.53.1757947082341;
        Mon, 15 Sep 2025 07:38:02 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea103f90e4sm6118493f8f.53.2025.09.15.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:38:01 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/3] bitbake-setup: add 'install-buildtools' command
Date: Mon, 15 Sep 2025 16:37:55 +0200
Message-Id: <20250915143755.737161-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250915143755.737161-1-alex.kanavin@gmail.com>
References: <20250915143755.737161-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Sep 2025 14:38:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18034

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

This commits includes fixes by Gyorgy Sarvari <skandigraun@gmail.com>
https://github.com/kanavin/bitbake/pull/2

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup     | 26 ++++++++++++++++++++++++++
 lib/bb/tests/setup.py | 20 ++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 650f9ab1e..ebaeafd8d 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -16,6 +16,8 @@ import stat
 import tempfile
 import configparser
 import datetime
+import glob
+import subprocess
 
 default_registry = 'git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main'
 
@@ -555,6 +557,25 @@ def list_configs(settings, args, d):
             json.dump(json_data, f, sort_keys=True, indent=4)
         print("Available configurations written into {}".format(args.write_json))
 
+def install_buildtools(settings, args, d):
+    buildtools_install_dir = os.path.join(args.build_dir, 'buildtools')
+    if os.path.exists(buildtools_install_dir):
+        if not args.force:
+            print("Buildtools are already installed in {}.".format(buildtools_install_dir))
+            env_scripts = glob.glob(os.path.join(buildtools_install_dir, 'environment-setup-*'))
+            if env_scripts:
+                print("If you wish to use them, you need to source the environment setup script e.g.")
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
 
@@ -739,6 +760,11 @@ def main():
     add_build_dir_arg(parser_update)
     parser_update.set_defaults(func=build_update)
 
+    parser_install_buildtools = subparsers.add_parser('install-buildtools', help='Install buildtools which can help fulfil missing or incorrect dependencies on the host machine')
+    add_build_dir_arg(parser_install_buildtools)
+    parser_install_buildtools.add_argument('--force', action='store_true', help='Force a reinstall of buildtools over the previous installation.')
+    parser_install_buildtools.set_defaults(func=install_buildtools)
+
     parser_install_settings = subparsers.add_parser('install-settings', help='Write a settings file with default values into the top level directory (contains the location of build configuration registry, downloads directory and other settings specific to a top directory)')
     add_top_dir_arg(parser_install_settings)
     parser_install_settings.set_defaults(func=write_settings)
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index ab4dbf762..fb2c15f54 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -49,6 +49,21 @@ with open(os.path.join(builddir, 'init-build-env'), 'w') as f:
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
@@ -224,6 +239,11 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
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


