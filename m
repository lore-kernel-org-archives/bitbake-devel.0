Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF6CA0EF8
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 13:07:32 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.8910.1755781647552352047
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 Aug 2025 06:07:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZuBmU6yI;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso5485975e9.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755781646; x=1756386446; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+ZnrXJF6+k7F5TENY/yTbtIRHQyZzBFbxoX/AcwhC0=;
        b=ZuBmU6yIEkqiFJzwk/LGHM9jjrZO4EZ74/s7eGPoDq3uCf442g8ohkhZHshX94Pu38
         ykTWmxE02JFknlh4t8YpauIhE63sZ9rPiXWPO3CNQbZsx/c1Foem4t7QVAeef9/JCkvF
         2g1RLSZq0CDLouhB1CKFhZ0kIAy4nmbzfrPcP9f+XVlom087QU766US9kEJScG2QfLhk
         +tOvqrbYhgbf57weVDfzK382am8siEb7NeY/tJijsIFkbta/ZOY3aHbH2eUSll5b8i0o
         62cYCYXt6tflGVNIF4vGgygc3S1zJwHXbOw+e7eKPkaA91SSaa8kzQwj63B78i4VCUf9
         ZD7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755781646; x=1756386446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+ZnrXJF6+k7F5TENY/yTbtIRHQyZzBFbxoX/AcwhC0=;
        b=VNybCj6YUIsIh6vLOjj4eKID2/gdNF4f6ke89ZKA943txawEwxuyKQ2Dv4u+cL7cS8
         0SyLHNvpAdUB4+I5LuQTRpkX2VcKFy7c+M2uKvJzngz/KbRYUK3J3tBkXKg4bQ4QjG8Y
         kXKu4MN9rvSQRv9CyiAW89zzOQU3qhqHC84ItD2i+DQdI5VsQ2n0CjP42TGI7F1BgY/Z
         BnQ3tJJELUPg1o0hfhP2K1hVWdqqCjCTPIKPUknHDlN5Mf1pnjJNRvQSTz965WMSml/A
         RPmzQ4yE2FUjfqL1O3Nwu5V2SUEjCQoQlzzbKLYg58Hh267E034h7WdcXBRujCaqws6R
         9BNQ==
X-Gm-Message-State: AOJu0Yw3cfLif36UMW+/gbtCXudMCNc7rkJXhygkVoEQoSIe7skyKVYm
	EU8nG/Hiz1oABOW/013o57W2mzhNhultjjBKkh6qTfc8VJW2v4YDjGmlgQIXSQ==
X-Gm-Gg: ASbGnctbnnvV+z35/IQz9olBjH/LolVilMxxBgCmokcwpWHqOTaXyzp12oa1LT2cmJf
	tNxyx8O+MTRBgiB9EJiSlorp/ggEW/WUxn6N1prd2ZTGlDS7RjmdIorYYtKq2wp3LQLhI5wBFMC
	TlaQbOR9Yk7CoS6rsP7cZxfR4ZpWvmU5qvrvcK3iqkJS779VHjm0caedmjwnYy7jWkLN2sr5V7e
	UJW4tdRR00fw8fFZ51rdOtPPH+nIMswaCv45gX94PiDuqK0FQgKj+IGoX3KwBTD1BlD7HY03K+Q
	uJBJVU/vln0J5EnAFaCYDtVEe0UL9Rt6JhKGE7xgZ1uV5qCR5wF5UjORjrj5BsTiJikEjgJU/Kl
	C/h+WZz3OS1x5+VrwCZU19WbHtz/oxbPqRica6aLkVOchm6EooA+5jLlUIZu3FVwHnmp+TWKxvM
	S9vMzI
X-Google-Smtp-Source: AGHT+IHYQnI45jN4BbXb4DhccWbYbNlffoU02V96Vb1p5IQlmkpUnSTf/6d/GuhJBwjHVJR+Z+Axqw==
X-Received: by 2002:a05:600c:630d:b0:456:1a69:94fa with SMTP id 5b1f17b1804b1-45b4d7f59d9mr18858275e9.13.1755781645714;
        Thu, 21 Aug 2025 06:07:25 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2aa09sm27832815e9.9.2025.08.21.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:07:24 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/3] bitbake-setup: add 'install-buildtools' command
Date: Thu, 21 Aug 2025 15:07:15 +0200
Message-Id: <20250821130715.1904574-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821130715.1904574-1-alex.kanavin@gmail.com>
References: <20250821130715.1904574-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Aug 2025 13:07:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17905

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


