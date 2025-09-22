Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6887DCAC5AD
	for <webhook@archiver.kernel.org>; Mon, 22 Sep 2025 09:27:48 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.47834.1758533260930617277
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Sep 2025 02:27:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=D3zHIZE9;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45ed646b656so36369155e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758533259; x=1759138059; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En8/S53bVZqbgh72oJYkQmt5PJQ5qPaKrhGbMJrHStY=;
        b=D3zHIZE9jrn/BgFinCz+p0KKtp4Kttpr2oirym1rMP3JdRZrUqVFQFO225PhTdlJxO
         jGNJETB5i0zcZawIh+Tcu0jgnw+5Mkf/dNtgROmF5+vJQjpCtSduSS96lnagzztTjcpU
         mYR4osjlvusU84zXt08B0AjHo4dVSsLNJuDFhlqg1BdSBYWZmCdwVo41dMYDfO63GnbO
         t8NxLzf0XIDyY/VD0bQ5vrG7dxOHHvPmkQ9DL+y5KxfcO+peJ0+ZiekD01FkE04nrxaG
         n7ziUJdN10ka9EsCxAqsua0w7Sg8tnCuUA7N9mgObYX29Jed869RWkJ9L8l4x8m9dw4b
         VLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533259; x=1759138059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=En8/S53bVZqbgh72oJYkQmt5PJQ5qPaKrhGbMJrHStY=;
        b=GM9L2ih9T0gqkZZWHfy9iJ6yOOoHpFoxM7kPx119Sg0Oz1IuEWdVVounWNNhDAPBNH
         zpWP52jSnFvYkE8uHVtPZQCXKHBKZqhffwTuBDhv1tunUUh47fRHet/nFTRBD5V2+P86
         dCAteMbgpcx5FyEFAyVN49uX916Mfko4l3KgLaypwuYhvXdYY9wlKX1ER9kkcK2aM/77
         wa6u4jfojApMstT8On3a/TuK6MCkdTNku0gWPFLzVx8098XHLUIABKncBkfmel1pPR4v
         chMXVM4vUZioQ+1Yjg02TGj/hWkfY+ep/ZcHYBOij0/+CETC3jd+E4yLyQSU0DcP4HKZ
         B56w==
X-Gm-Message-State: AOJu0YyvvBnGGCjWZY7jVtMjlENQz/UyTo90YC20XmbHTi6aeXrKv8QE
	G0YI31W82yLpBUglEF0RFN8hBGXOQh+K9oexlgByWpbj79VnvDTBuOkK5id2Kg==
X-Gm-Gg: ASbGncuEOY0HlAkBMNSSfeThlrQMUNAae3BNnngzqC03YTSVdlBMk+Bn+yF2ivRivVG
	ZWvc6QCSMPcSP+EiBFH5i+cKttM0uJhfYt86ID9ENQsyrAC4f8k9iUKgjdhiq70q+oqgIGQDsLp
	MRCF06jji0g0lMolfockIInbFbAh/mt1bG27HgnD5hgTbS+uBfuHtq0dd3pt1jtIew8sZ4PmsVC
	HYC6AstU7dovLhAtyhTUCo4h4COu247HiqCkDYFrUDLiAEdqIZbeGVtKqQSHlBZ/hTYt5hsYeaZ
	vS7QKNSskVC2pO8sFvtFRu1cGFvDXZIJoJVH2UHfjRMlTzs0PN38tl7kUc+eCvi97CLRpiq7vmc
	d2KRKyvjzc3Qty/1WE49UYTYNhUP0DEo69SKEtLkO62P0LV5+1zPFes3rDopbYpF5PBYehTA+Jf
	NIKbu59L6vdXAReN0fIRgFvHKJVIr+HVd9JZODrR9VWSvWx79IKoveRz+frg==
X-Google-Smtp-Source: AGHT+IGw5FOd0+IEOnGLtkLR+wUoaRxopMAnY9gTnLY0G3WjZePLz5SDiN9HJHwFv2AgIgLe/8yc1Q==
X-Received: by 2002:a05:600c:45c9:b0:45d:d1a3:ba6a with SMTP id 5b1f17b1804b1-467f15d405emr114337885e9.33.1758533258961;
        Mon, 22 Sep 2025 02:27:38 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee073f53c4sm19180194f8f.3.2025.09.22.02.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:27:38 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/4] bitbake-setup: add 'install-buildtools' command
Date: Mon, 22 Sep 2025 11:27:30 +0200
Message-Id: <20250922092731.1993813-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922092731.1993813-1-alex.kanavin@gmail.com>
References: <20250922092731.1993813-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Sep 2025 09:27:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18068

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


