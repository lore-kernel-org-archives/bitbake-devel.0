Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C973CAC586
	for <webhook@archiver.kernel.org>; Mon,  8 Sep 2025 12:34:54 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.12145.1757334886171832983
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Sep 2025 05:34:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=f/ZX4jkg;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45ddddbe31fso11428975e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Sep 2025 05:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757334884; x=1757939684; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGCjRpcwhv8dXsA+bbENjoKJB0GSXAnov7wJvgeyuPQ=;
        b=f/ZX4jkgUn6wUP5HkyZeH43eMfHmTaH0hUDnvxFWdHfspO++mAbBKDiIauOGJBVFok
         3LmAr7CUzNcq67eeM8LAtXoHs80DsPY41R40/6RL6avXYYKI1Ir4rGlW73EoIQuAiZ38
         2nl2vC2i5Jh5kkp+AXcquR7sfENpK95iqNg6/xYkkZZDYHQgkRZLOGKTH7wL+kGBPP3O
         JzcVqzp615QHdN++cSa03iupmU322MqNr39+Jw6Qp+uuLdDm1dOOiRPPaK4fisbsMB9Q
         NFE/BzEdzXdU5OpvnEvdFtRY45cXdePDelFUOOrClW/askwPAYlc0j6aRBsC9/BD/+1B
         Kf0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757334884; x=1757939684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGCjRpcwhv8dXsA+bbENjoKJB0GSXAnov7wJvgeyuPQ=;
        b=hWpaeM96KD4uHMxP+XEYDOZ02omBcYw4IWk+StM/z5R31FLKHcql4Td0h85euAUdqt
         2PaUEeVaWw6qYFCQ9qf96MfqvbW1cc2XnISqVNQvBomjvHlv6BulNPiEAJ+5HyQNrmCd
         uS231M+tIX+rRL3LRVRNukzOu2URmH+nfje8wIKddRj+iZ/79SkQTiqKdqG5lvToF0l/
         9JF80BfyWX7GDU+ePMk1Cv+2Oa9smmQCuFwAF0mfefhihyDtWoEFKShhcswYR6/+Ih/Z
         M/XbseE4JnatnGcrq9gSu5OA6nCwTO+2gR9h+HHbEWAfAZ6ZucAX2DsvaR4Lc0KdaNdI
         syCg==
X-Gm-Message-State: AOJu0Yyg52MsLzFvKzNnbbxd9xJHLVGTIUaI6XBg69uDzgnHIh80/NlH
	GzBEh3ECsHfoDuLOLbW8VNSi6E2Tl00VwL5/2yCDFJbIZ4499Lz208kB8wUB9Q==
X-Gm-Gg: ASbGnctqaNraOyFcJnNmG/vU9W4H8FfxieXRWKRS7sfunsPHicd/3PVZjgqXW52sFqm
	zNPSaMz0KKSG6IfHhX8Jw/347D3DeGkTLe/tA987m8howYXMEShzRnQtENQvDcEhtSPizVughGC
	1af6e2WthXo3FhMHfNZmeP8v5bV7GOZzTFfcj2b2uQJspuateIP9ICBHdGawIVosmOG+5L9bydl
	9U98pMWcF+nXMHAvhScrCsnJ7FA92DqXl+KsM+5MkvKU77QaEY1hpuZJmEp7qxBgkOftnYPMNdC
	AM1m0knQImcjZPPc+nwP5uaiSjnj+CSM4ibDaJEzD6tthgESwN7fwj+nCWNQGKMTzlEbrBrMYOR
	NGlQrVia/lBrtKbaiv8Zwycf7OW05iX8eA4TrKgfGSgkvIOsfWJrXQrro8DnjXVfhp1uGeiuhRZ
	Er8/OXVR9loV8ARyr+l7bnd6sFZGB3rtXtPdR94OSitizWLpiWpXJ1DK6xYLRXN9LGi89O
X-Google-Smtp-Source: AGHT+IEMz7V3v/Nkae1HX/fYd5+4kJAY2hKPlVmSBW4gk2iXwb41uK+8/JM7SsC4/91BN6FQasYoLw==
X-Received: by 2002:a05:600c:16c4:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-45dde040511mr51247665e9.18.1757334884335;
        Mon, 08 Sep 2025 05:34:44 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de15de2b7sm82998205e9.14.2025.09.08.05.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:34:43 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/3] bitbake-setup: add 'install-buildtools' command
Date: Mon,  8 Sep 2025 14:34:37 +0200
Message-Id: <20250908123437.1728264-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250908123437.1728264-1-alex.kanavin@gmail.com>
References: <20250908123437.1728264-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Sep 2025 12:34:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17990

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
index ef7ce35b4..694e68c09 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -16,6 +16,8 @@ import stat
 import tempfile
 import configparser
 import datetime
+import glob
+import subprocess
 
 default_registry = 'git://github.com/kanavin/bitbake-setup-configurations.git;protocol=https;branch=main;rev=main'
 
@@ -537,6 +539,25 @@ def list_configs(settings, args, d):
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
 
@@ -721,6 +742,11 @@ def main():
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


