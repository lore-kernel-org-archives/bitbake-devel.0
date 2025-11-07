Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93315CCF9F8
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 08:00:48 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6650.1762502440201629490
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 00:00:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZVQL/6ij;
 spf=pass (domain: gmail.com, ip: 209.85.128.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4775ae77516so4766475e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 00:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502438; x=1763107238; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCYBCojf+nM8JmCvJaUEJeQuZ8fCzNNO2nBK011bOZo=;
        b=ZVQL/6ijNl4jILrP0842VTv93bIO4e3oQFhhGGmtPZXk7tahUEbM+QyxuNNset3de+
         CB2P3/mNWJe95TwrywSIdW23mATR7DlK5cu7qWTuT/8LKAbhT3vzjA81g4DEMDZ1utmY
         7ZI/YyyeptsZ1sjGdzWpNEoYzTbWo0ctY1jJgXvBlf80VektgpkxzpBYvbdBAURM9RsX
         av5ahbBBXJNqwZkWa6AT7j26HbL+teq6DsPfnj/1JlW78Scor+A7E+J7xuzd6ev0TmEY
         gzkndp6H112aN/mVnBvq4+zL/3LPL3kqZrUc0wtPIhU8zDTHWt4S9vb0iFo4YKpz6Un7
         DJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502438; x=1763107238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sCYBCojf+nM8JmCvJaUEJeQuZ8fCzNNO2nBK011bOZo=;
        b=pqtFz9iXCUR9ahrFa4NdV9L/5/qxge6+jjMPcFvM0feXZjbpHO3tVOCvY1Mn7O8eYQ
         bLz3SyrBu0X3wInghYL5WMQBxQeJcRayHvLVMswblBcS5ldcPTJoNmzrR/71QRHc8sL9
         t1mbvr/kc6912naOuk5M+nPPpB50DxHCBBaYQGZbD1avpwGKB4NFPT4v+fJkoo1V7wta
         f8xWfthlSgyUcWdElR5MOoqsJKsJ+5X39iIOHzVYydt4tpStrgGbZyRHENKtPwAraR+p
         +nLR56/+xcS0ZRrATvN1navB2A3NbM7mY8hyd4lLsBv2U/KlsQoVvRHWRKsd/PLJry1x
         lb0w==
X-Gm-Message-State: AOJu0YwLC6UlrX+ds1TTPzQ60Dj2DmALdnb+4QW3FAfm/vcYejrLdlEw
	IIlJuTP6f/4576yA900HC1eGMfmyjzK/VH4Xr148eWZhoucyEDhOOhoJyevMlw==
X-Gm-Gg: ASbGncvaiBk1H1f4Yw0C4ktyFmqpt7AENkfhBHpmb3PhrH+tkT5oyQfplfc55XXD+DV
	ieJZIJIWySOVUkchjN9QmFN3ReRtApp39IH/uVRPd1RgQlkm7p+/cY1csWuI4kwefQLXbWwtUwe
	75165QCgeXQWD3BG8yeMru5VttbOR0j7Aya5xMnkaYBn9lM5BZ6MkAwQN7cOw8+EuzydEXcIcOe
	9uHCvGJ+S8YVYwkPFgactd5RPwlVutY5sYpRlevJCyCHS8FBz3gu26zgma1PPycx1ZW2ewEGlOB
	c4h5uV/gSA0vU7r9hcjbZqmbFIhnIKU+J/8TbEPbPKS+pWwrxl2GzzP2flO2O9YnLmWoFf7pULs
	WADilBISRkqrkB6db6XyTqEt4EZ3/bRWWAA8Bj4LjMlHYo4JYOL3npOOluVXU7jwp793vSvSVqI
	TPakjSm4TV1TU6eV1/54kKb2gK9Ly5MaM+Rdy6f12BV4uAfBR7+Nl8W4e3cQ==
X-Google-Smtp-Source: AGHT+IF/kNTN+Dg9dihJjxPWcgAHEBYwhkGz5vxul2i0yN1oRWXanaWOdWrZIWHikYXvojzDR5cDkA==
X-Received: by 2002:a05:600c:8b38:b0:475:da13:256b with SMTP id 5b1f17b1804b1-4776bcca1ddmr15655265e9.38.1762502438161;
        Fri, 07 Nov 2025 00:00:38 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm161484025e9.6.2025.11.07.00.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:00:37 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/2] bitbake-setup: unpack sources (e.g. layers and bitbake) into 'sources' rather than 'layers'
Date: Fri,  7 Nov 2025 09:00:26 +0100
Message-Id: <20251107080026.2599821-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251107080026.2599821-1-alex.kanavin@gmail.com>
References: <20251107080026.2599821-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 08:00:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18297

From: Alexander Kanavin <alex@linutronix.de>

'layers' is not a good directory name, as it contains bitbake, or repositories
that can contain multiple layers or no layers at all (e.g. yocto-docs).

While there's a chance, let's name it right: 'sources'. This aligns nicely
with both the 'sources' property in the json configs, and oe-core's unpack dir
which also 'sources'.

Then the setup directory contains:

- build (bitbake's build directory)
- config (bitbake-setup's configuration data under version control)
- sources (everything that was fetched and unpacked)

A patch to correct everything in yocto-autobuilder-helper will be sent
shortly.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup     | 8 ++++----
 lib/bb/tests/setup.py | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 50b7f1488..a9674a527 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -461,7 +461,7 @@ def init_config(top_dir, settings, args, d):
     print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
     setupdir = os.path.join(os.path.abspath(top_dir), args.setup_dir_name or "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
-    if os.path.exists(os.path.join(setupdir, "layers")):
+    if os.path.exists(os.path.join(setupdir, "sources")):
         print(f"Setup already initialized in:\n    {setupdir}\nUse 'bitbake-setup status' to check if it needs to be updated, or 'bitbake-setup update' to perform the update.\nIf you would like to start over and re-initialize in this directory, remove it, and run 'bitbake-setup init' again.")
         return
 
@@ -475,7 +475,7 @@ def init_config(top_dir, settings, args, d):
     os.makedirs(setupdir, exist_ok=True)
 
     confdir = os.path.join(setupdir, "config")
-    layerdir = os.path.join(setupdir, "layers")
+    layerdir = os.path.join(setupdir, "sources")
 
     os.makedirs(confdir)
     os.makedirs(layerdir)
@@ -535,7 +535,7 @@ def build_status(top_dir, settings, args, d, update=False):
     setupdir = args.setup_dir
 
     confdir = os.path.join(setupdir, "config")
-    layerdir = os.path.join(setupdir, "layers")
+    layerdir = os.path.join(setupdir, "sources")
 
     current_upstream_config = json.load(open(os.path.join(confdir, "config-upstream.json")))
 
@@ -648,7 +648,7 @@ def install_buildtools(top_dir, settings, args, d):
             return
         shutil.rmtree(buildtools_install_dir)
 
-    install_buildtools = os.path.join(args.setup_dir, 'layers/oe-scripts/install-buildtools')
+    install_buildtools = os.path.join(args.setup_dir, 'sources/oe-scripts/install-buildtools')
     buildtools_download_dir = os.path.join(args.setup_dir, 'buildtools-downloads/{}'.format(time.strftime("%Y%m%d%H%M%S")))
     print("Buildtools archive is downloaded into {} and its content installed into {}".format(buildtools_download_dir, buildtools_install_dir))
     subprocess.check_call("{} -d {} --downloads-directory {}".format(install_buildtools, buildtools_install_dir, buildtools_download_dir), shell=True)
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index b8a5a03ad..9eebd709e 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -181,7 +181,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
     def check_setupdir_files(self, setuppath, test_file_content):
         with open(os.path.join(setuppath, 'config', "config-upstream.json")) as f:
             config_upstream = json.load(f)
-        with open(os.path.join(setuppath, 'layers', 'test-repo', 'test-file')) as f:
+        with open(os.path.join(setuppath, 'sources', 'test-repo', 'test-file')) as f:
             self.assertEqual(f.read(), test_file_content)
         bitbake_config = config_upstream["bitbake-config"]
         bb_build_path = os.path.join(setuppath, 'build')
@@ -205,7 +205,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             with open(os.path.join(bb_conf_path, 'bblayers.conf')) as f:
                 bblayers = f.read()
                 for l in bitbake_config["bb-layers-in-sources"]:
-                    self.assertIn(os.path.join(setuppath, "layers", l), bblayers)
+                    self.assertIn(os.path.join(setuppath, "sources", l), bblayers)
                 for l in bitbake_config.get("bb-layers-in-this-dir") or []:
                     thisdir_layer = os.path.join(
                             os.path.dirname(config_upstream["path"]),
@@ -328,7 +328,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             out = self.runbbsetup("status")
-            self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, setuppath), out[0])
+            self.assertIn("Layer repository file://{} checked out into {}/sources/test-repo updated revision master from".format(self.testrepopath, setuppath), out[0])
             out = self.runbbsetup("update")
             if c in ('gadget', 'gizmo'):
                 self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
-- 
2.39.5


