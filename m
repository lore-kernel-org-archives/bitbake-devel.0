Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B93CAC5B5
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 12:56:45 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.52696.1759150595382387511
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Sep 2025 05:56:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mK62DeKV;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso9554865a12.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 05:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759150594; x=1759755394; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hHrQGbXOAOF6NziVlc4Sok8BrCa5xqiNxmYZDr/QWE=;
        b=mK62DeKVzJxA7xDjidCm/CnwxHZYLHBGK6d1KCti+lysZws4FVt/bxzL+srKOv8I1F
         38+AIDEydPxbhhstj6ajvbs0zUDuUpNjrpQmKoqHnaZrpyuxzMJMQ5OU4OTUceYIMrvK
         6YiQmFaEe59X6BS5csllSTfdXK4KBVqapxlz+BGHO/S9KJ+/Esco6WULKKqeOAGTQWyC
         jZjUWe86yvxmXer492T8/VJSwtK5qzxpkSe6rM1p9ENgLqm84+iwob5V8lSeQhcwaf4R
         v4bPkd8bgPPy5mw22yGvUfL8GxBOQj5egl2Wgi4lVX6sxRbBiTEhf8zjJTDJu6r0O0JP
         u9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759150594; x=1759755394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hHrQGbXOAOF6NziVlc4Sok8BrCa5xqiNxmYZDr/QWE=;
        b=LAMv/2yyt9AJrzEAl+Pm8Zovshhl4oQeEzugq+xQnXgznFfpP/WdZzVRrRnfj4cZ2P
         vKaAvFsoGMg1+TG8YB3711DmLLoOmN5vRGiA0nSxgjR2vudjolCYSLxqhl4khNlGkkz9
         dqpnH90guxga+Vy0XQAFMzDeghmZvTwmPtWf2/+LBx5RnlV/K+WMdrrZVMoATBkQZ8/x
         MGENgfD7zy0hqQUBblrPYKW3yErSOiHjrdP2ATrTWhp5Lx6UjfVoXzr6J2XLMlF8JF8p
         D65xiRK2Kmvc0eBKbUzGgWy9g9NMvJOFNxBJ5afWOvFKPjF6Od+OFqJAmJDzeAVSiUTz
         A85w==
X-Gm-Message-State: AOJu0Yze3eGelgD+zYUabvMSBQ4VZDQFQojcaGFPTD4jJ1Ir7s3WH7hD
	zAT+v7EpiygJa4qW6C3pym2B1on4ckH9pFEJLvIbtwUnoQYAvGl/7E/jY3F5uw==
X-Gm-Gg: ASbGncth1j4l9gTkgsXs1p/Y0gPohiwxpWdkQYh+cJ4l9fYKMo8R0IXuvs6hnVrV46Y
	IUtEzfZe8iYG9tIOj1SnTOGBBrL2n+VyLtNaJGKaSQVOJ1FMjGs7CU1tV2YAVjt0URiFvCuFJmt
	kCfkCR2qRRBGP5RfyUFvRSmquY0CsvEBwPiGfRLP28aeBavvN6YqiI8EMTXUbJmMxSMZtsh8FjC
	i6PbOTd50mQmUk9m2CfZnPn3N7BT5jRtbqUyWDZN2elsMeW4HAR7hbeTmVq4At3bz3OJCgUOK2d
	r2wzWOQXEOcm63dLAzHv0hwduMlD8uCnVxu6ydHIBsTVLsTr3stnGjNRv0fHRyFBE7pKod08uHQ
	hvM5Fr4/7DsKJMEEuTswRMySNnrec0bEWR2CVfftXlSrgbS3mKAuLSX88OUaFMekcwCdP22WC9z
	mbfwUzey5+NzI6Sb2WwJ3k7OCSiAppRww9FqawXCu/YTJfDVQkwolfqeEwszGuxGtkJtHQ
X-Google-Smtp-Source: AGHT+IEAeJrLR2ZE8CYZBEt3JQU5e2EVnEVTsYUrP2BHr1ea7wRra/KFCST19fUwoNj49j8qsv79/Q==
X-Received: by 2002:a05:6402:40c2:b0:634:cb54:8115 with SMTP id 4fb4d7f45d1cf-634cb548583mr9512708a12.7.1759150593527;
        Mon, 29 Sep 2025 05:56:33 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634b46dca59sm6575915a12.8.2025.09.29.05.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 05:56:33 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [PATCH 03/10] bitbake-setup: add 'install-buildtools' command
Date: Mon, 29 Sep 2025 14:56:09 +0200
Message-Id: <20250929125616.1751116-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250929125616.1751116-1-alex.kanavin@gmail.com>
References: <20250929125616.1751116-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Sep 2025 12:56:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18102

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
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-setup     | 26 ++++++++++++++++++++++++++
 lib/bb/tests/setup.py | 20 ++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 739474003..d6509500d 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -16,6 +16,8 @@ import stat
 import tempfile
 import configparser
 import datetime
+import glob
+import subprocess
 
 default_registry = 'git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main'
 
@@ -554,6 +556,25 @@ def list_configs(settings, args, d):
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


