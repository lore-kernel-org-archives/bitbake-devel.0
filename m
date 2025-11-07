Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0296CCF9E3
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 08:00:48 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6652.1762502440858194368
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 00:00:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Hu22MHWB;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4711b95226dso3971625e9.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 00:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502439; x=1763107239; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOS7AvY1cCyi4UMiJ52TVNTJV6yNtuUD64W10VKsPMQ=;
        b=Hu22MHWB4cP6gA+oTCNyxTIJH/OCvuhRnPPjPZu2ykWZMy2lFaqimTKMyYJ7dtMf00
         hcSj7ZqMzqO/H5RJ4MurljYPsWN15q3p/YKCugaBH6P/6/M7H583lbxWi9e/scywpgrU
         Ce/2zum+sr5Rl25lGL6Shf5TNcYmjd/6Y8ynDWcp6G1qvs55rmGLv4+FZrgJnr/a40aj
         1UoQlaSMZEcoNxV8gFPVSyV4jmKnR+TWMQe6E6qUfDF1KhsHaJidbNG5L6Ckbqdch0Mx
         ESTqr2Qw7uJCcsSwqOtZV5E8HiMkNcm7ZflizE7ax2CRynYQM26cJGG4MGoMYakEEX+R
         /hGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502439; x=1763107239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOS7AvY1cCyi4UMiJ52TVNTJV6yNtuUD64W10VKsPMQ=;
        b=b6nqNgmEEWwjvrqXDAg3LifGwvBsvBzX05eZFyNw7thFc2Z9twwVQKHDGwrdU9/e96
         BHPXm2XiAVjv26il0IgyylJviS0GoQzn7v04XIuEqdCjJJ4GzkZn7Ndr2nvu33BGeVR4
         PNAeao/GK7JEaCWu2WR87WUsIGThssnJuH/10VTT/bO/neoH4H8xPI/38JX1FPt0N9Rt
         I63eQNW81bk1ynX+aVVYzGxvgtt4CCl/dMC20I7u8n4Zvupu1IQJHgF3NU156WqtkQLX
         Agfa3fa/mU5VipYa77a/St5DoN07YKtTB+PH2RIhOkS678zP4IZTG0pDFhaPC5BJRrQI
         WBPw==
X-Gm-Message-State: AOJu0Ywu9+YjkPYA0avILLp0A4PUi4Y6KPyCEhWY7FF94aqglqvGIJzn
	8qY989SLURqnqVHHFO2IwAY/FZ3VhTdoPN/U4fzSNQ2bH42draQ+N1Eem1GMKw==
X-Gm-Gg: ASbGnctMt2a8Mt60ZDKYne9WhhrG0mEzFTAlfw7Nvi9YHH/6MvgAQ51uKu47BE9PRZb
	QAGgMvwfdZdIe3TadjCtqWbky7n7J0h5FTfzr7EHFmgoHcYwj5L1ruoWXb7TLIGojEnO6u0fCvB
	jVFoa3lutF+7YBjF0Pkmg2aoucv3EqVwPcequ0kec2nkhsAEJf2FYm4fN5psm3ThHvi9A/58eTt
	/evyAWJNTH0GmqFdYXsg7zPanqfXMD411sRC3/FonGS6sajMsOIZ/FXpnvaQFC6iW30EIIHWUUz
	KlylvFg0TSM7lmE3+KRYWRltpW5DzO64JJ/bvpOIrN83o9Ay3ayihv2aToAFk7/maOPcahXQ4hZ
	CCKe76kvI5xK2Per8J4e9rHV9o4+A5uF6AQ4tkW8fUvoyJC5Nm/fiDRqtsEOkwSaj3H74vdRWOH
	LYEtPIt8bZ1lc+cp9vXfgErQSNE0RpmndXjrEh
X-Google-Smtp-Source: AGHT+IE/Pqo9g/79NqujWCYNaRPE/Av0/tYasRVp5wy78GqNqqUsEqcCoDl2WXGQnivTURLoXjBQNA==
X-Received: by 2002:a05:600c:3ba0:b0:475:da13:2568 with SMTP id 5b1f17b1804b1-4776bcb87f8mr16393565e9.25.1762502437251;
        Fri, 07 Nov 2025 00:00:37 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm161484025e9.6.2025.11.07.00.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:00:36 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 1/2] bitbake-setup: rename bb-layers -> bb-layers-in-sources, bb-layers-relative -> bb-layers-in-thisdir
Date: Fri,  7 Nov 2025 09:00:25 +0100
Message-Id: <20251107080026.2599821-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 08:00:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18298

From: Alexander Kanavin <alex@linutronix.de>

As pointed out by Peter K, bb-layers and bb-layers-relative is a confusing way
to name these lists:
https://lists.openembedded.org/g/bitbake-devel/message/18296

I do believe this is the best option of several, it's yet another rename,
but also a super important one, and the only chance to get the best
nomenclature is now.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup                             | 14 +++++------
 .../configurations/oe-nodistro.conf.json      |  2 +-
 .../configurations/poky-master.conf.json      |  2 +-
 lib/bb/tests/setup.py                         | 24 +++++++++----------
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 29fdf1189..50b7f1488 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -129,7 +129,7 @@ def checkout_layers(layers, layerdir, d):
     return layers_fixed_revisions
 
 def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
-    def _setup_build_conf(layers, relative_layers, build_conf_dir):
+    def _setup_build_conf(layers, thisdir_layers, build_conf_dir):
         os.makedirs(build_conf_dir)
         layers_s = []
 
@@ -137,11 +137,11 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
             l = os.path.join(layerdir, l)
             layers_s.append("  {} \\".format(l))
 
-        for l in relative_layers:
+        for l in thisdir_layers:
             if thisdir:
                 l = os.path.join(thisdir, l)
             else:
-                raise Exception("Configuration is using bb-layers-relative to specify " \
+                raise Exception("Configuration is using bb-layers-in-this-dir to specify " \
                 "a layer path relative to itself. This can be done only " \
                 "when the configuration is specified by its path on local " \
                 "disk, not when it's in a registry or is fetched over http.")
@@ -209,9 +209,9 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
     print("Setting up bitbake configuration in\n    {}\n".format(bitbake_builddir))
 
     template = bitbake_config.get("oe-template")
-    layers = bitbake_config.get("bb-layers")
+    layers = bitbake_config.get("bb-layers-in-sources")
     if not template and not layers:
-        print("Bitbake configuration does not contain a reference to an OpenEmbedded build template via 'oe-template' or a list of layers via 'bb-layers'; please use oe-setup-build, oe-init-build-env or another mechanism manually to complete the setup.")
+        print("Bitbake configuration does not contain a reference to an OpenEmbedded build template via 'oe-template' or a list of layers via 'bb-layers-in-sources'; please use oe-setup-build, oe-init-build-env or another mechanism manually to complete the setup.")
         return
     oesetupbuild = os.path.join(layerdir, 'setup-build')
     if template and not os.path.exists(oesetupbuild):
@@ -223,8 +223,8 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
         os.rename(bitbake_confdir, backup_bitbake_confdir)
 
     if layers:
-        relative_layers = bitbake_config.get("bb-layers-relative") or []
-        _setup_build_conf(layers, relative_layers, bitbake_confdir)
+        thisdir_layers = bitbake_config.get("bb-layers-in-this-dir") or []
+        _setup_build_conf(layers, thisdir_layers, bitbake_confdir)
 
     if template:
         bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbuild, template, bitbake_builddir))
diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro.conf.json
index 7619738b1..cd3c5f612 100644
--- a/default-registry/configurations/oe-nodistro.conf.json
+++ b/default-registry/configurations/oe-nodistro.conf.json
@@ -43,7 +43,7 @@
         {
             "name": "nodistro",
             "description": "OpenEmbedded 'nodistro'",
-            "bb-layers": ["openembedded-core/meta"],
+            "bb-layers-in-sources": ["openembedded-core/meta"],
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 60531ba02..5a580197b 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -53,7 +53,7 @@
     "bitbake-setup": {
         "configurations": [
         {
-            "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
+            "bb-layers-in-sources": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index ba2a90009..b8a5a03ad 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -122,7 +122,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             {
                 "name": "gizmo-env-passthrough",
                 "description": "Gizmo configuration with environment-passthrough",
-                "bb-layers": ["layerC","layerD/meta-layer"],
+                "bb-layers-in-sources": ["layerC","layerD/meta-layer"],
                 "oe-fragments": ["test-fragment-1"],
                 "bb-env-passthrough-additions": [
                     "BUILD_ID",
@@ -138,20 +138,20 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             {
                 "name": "gadget-notemplate",
                 "description": "Gadget notemplate configuration",
-                "bb-layers": ["layerA","layerB/meta-layer"],
+                "bb-layers-in-sources": ["layerA","layerB/meta-layer"],
                 "oe-fragments": ["test-fragment-1"]
             },
             {
                 "name": "gizmo-notemplate",
                 "description": "Gizmo notemplate configuration",
-                "bb-layers": ["layerC","layerD/meta-layer"],
+                "bb-layers-in-sources": ["layerC","layerD/meta-layer"],
                 "oe-fragments": ["test-fragment-2"]
             },
             {
-                "name": "gizmo-notemplate-with-relative-layers",
-                "description": "Gizmo notemplate configuration using relative layers",
-                "bb-layers": ["layerC","layerD/meta-layer"],
-                "bb-layers-relative": ["layerE/meta-layer"],
+                "name": "gizmo-notemplate-with-thisdir-layers",
+                "description": "Gizmo notemplate configuration using thisdir layers",
+                "bb-layers-in-sources": ["layerC","layerD/meta-layer"],
+                "bb-layers-in-this-dir": ["layerE/meta-layer"],
                 "oe-fragments": ["test-fragment-2"]
             }
         ]
@@ -204,14 +204,14 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 self.assertIn(bitbake_config["description"], f.read())
             with open(os.path.join(bb_conf_path, 'bblayers.conf')) as f:
                 bblayers = f.read()
-                for l in bitbake_config["bb-layers"]:
+                for l in bitbake_config["bb-layers-in-sources"]:
                     self.assertIn(os.path.join(setuppath, "layers", l), bblayers)
-                for l in bitbake_config.get("bb-layers-relative") or []:
-                    relative_layer = os.path.join(
+                for l in bitbake_config.get("bb-layers-in-this-dir") or []:
+                    thisdir_layer = os.path.join(
                             os.path.dirname(config_upstream["path"]),
                             l,
                         )
-                    self.assertIn(relative_layer, bblayers)
+                    self.assertIn(thisdir_layer, bblayers)
 
         if 'oe-fragment' in bitbake_config.keys():
             for f in bitbake_config["oe-fragments"]:
@@ -298,7 +298,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                                                                   'gizmo-env-passthrough',
                                                                   'gizmo-no-fragment',
                                                                   'gadget-notemplate','gizmo-notemplate',
-                                                                  'gizmo-notemplate-with-relative-layers')}
+                                                                  'gizmo-notemplate-with-thisdir-layers')}
                                }
         for cf, v in test_configurations.items():
             for c in v['buildconfigs']:
-- 
2.39.5


