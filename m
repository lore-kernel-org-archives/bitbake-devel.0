Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD715CCFA05
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 17:08:20 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2832.1762448892178493966
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 09:08:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jZmelhWx;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b70fb7b54cdso226687566b.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 09:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448890; x=1763053690; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fEZ0uIuqRBKRpeGaIp6rFTm0QvCmALndPDWXYeIvn+M=;
        b=jZmelhWxXiZIO/JhZPUpVo++abP+R/9Nn530zZDxgOtvOElhiIitz8ye4BXHUpj/VA
         fHAChmgO6k+TIWmQ2j7nXHNzXoUkR8gl826saqqaS42FeGrA2yl3qobSaHTSMBdwHP24
         yB40je77v8sTZ/eZe3wohJ1YLiIJIwE0tLURGZn5+GMUMBjEBiA2Q87J6yCxi4+002QF
         BiqJjAv4By+ROZTMxJUgBmREWhRVqeE0gY89PCNW3FK83W2fF+A7rVPN6akvvjN10T7U
         FeHlpsCqoPpsCgSIWWYyNHKVT6IdgS/BZczZ6S1+ui5TFgZgR2Udcn7vm9O4ny0V2+uG
         ak+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448890; x=1763053690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEZ0uIuqRBKRpeGaIp6rFTm0QvCmALndPDWXYeIvn+M=;
        b=XN4q1kVhjdG9o0W8wgDGAipX8rllrh0hCR8ouTUPjMtaO2tAMQ+buLT4mIX5iFamKq
         MG6fkB3P+aqZaZrXavxjOgaqNecJ3w63lF2k4+EDe8b6zPc80A5V+m+6HTviVQcCg/rN
         3UH5dTfcfU43Av1XrOOibOQw3jT5pho9I5Xg2wkORBRI00xBOwERmudFmIFvvltSdEM+
         0rtw9JjoKyudreb7ZxEf1CBlaQRjwsaVGgjlXprVcSNoKdkCxwlj+7r+dEaAddZ48y8c
         LGcekvFJZMgKf+A71L9UFn3UMBfFL78hxq8pPBn6I5CpAPTZ+BoeHkc9HroCCK0bIwOv
         1VYg==
X-Gm-Message-State: AOJu0YwXCEW77231c22OAlBsnFTvdib+V4Yte8MelzyYup7jVywu9whn
	SOHMFhyglV2T3anyJvMpoMInEgUuLMGv/aEixs5731QbFjtOKvaijBXHvgAhPQ==
X-Gm-Gg: ASbGncuk2PkvpaeKKPCLiy0QVOtON9QOUawnU8rnfp4/jl6Tk1V5JLbdcy0lGsO904Q
	PSDfqGs/YWkXtIbVdTBs/mjCOOg5QIBNdGXgaIj15BujA3aTolmcWku6G2umkQeyUdjsykCMGtS
	0DVyPrEhg57UvY58Ku3B/1czAdAFrD6pSvTT8NLFzBpH0csclhbWZhefjG4+cMSEx04kZDgQKal
	me9irEGamtF14aXGWWiMvU0Sv7LDkHVF/vKq6aoqZFi5IPRaGz2tAcVb9cNAYlsNdxyLQiSatZH
	EP3++irFmn60//66+fW8PxyrynGXBpQgVr16pUxUpbmybSbZtM0BWFqwU6KJfqLSSML3QSFdAgc
	tepvbOKSR2Mo8SuPoUVRv2EAqEZcJOMu66M/EU883N5ZdoeWR+UVD5U1tfhbCz4AXQ5n4W3gG3j
	emb8yBtIzpkdVFVAWW0N3v/D1xM+Gx/+7O38qnKWUZXV/UhnA=
X-Google-Smtp-Source: AGHT+IHWAl5i2+dlGOUYwBG8O4asWy+Mxwli0SmgVJ4V5zqM92jbbir3XM7fitPNGieFUTTDgHQ+Uw==
X-Received: by 2002:a17:907:2dab:b0:b72:614a:ab42 with SMTP id a640c23a62f3a-b7264e1d0c1mr827606666b.0.1762448890009;
        Thu, 06 Nov 2025 09:08:10 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf407a01sm6809566b.22.2025.11.06.09.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:08:09 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2] bitbake-setup: replace {THISDIR} token with a keyword: bb-layers-relative
Date: Thu,  6 Nov 2025 18:08:04 +0100
Message-Id: <20251106170804.2439400-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 17:08:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18293

From: Alexander Kanavin <alex@linutronix.de>

{THISDIR} is a special value token that can be used in the list of enabled
layers to specify the layer location relative to the confguration file:
https://git.openembedded.org/bitbake/commit/?id=b3153be29de8b8570b0c184369bd41f4c646cf92

This replaces the token with an explicit separate keyword for such layers:
so that special processing to determine the final value can be avoided, and
the feature can be formalized in the json schema:

instead of
   "bb-layers": [
        "{THISDIR}/meta-my-project"
    ]

this allows
   "bb-layers-relative": [
        "meta-my-project"

Going forward I think we should strive to avoid any further special value tokens.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup     | 28 ++++++++++++++++------------
 lib/bb/tests/setup.py | 20 ++++++++++----------
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 47de4654e..29fdf1189 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -129,21 +129,24 @@ def checkout_layers(layers, layerdir, d):
     return layers_fixed_revisions
 
 def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
-    def _setup_build_conf(layers, build_conf_dir):
+    def _setup_build_conf(layers, relative_layers, build_conf_dir):
         os.makedirs(build_conf_dir)
         layers_s = []
+
         for l in layers:
-            if l.startswith("{THISDIR}/"):
-                if thisdir:
-                    l = l.format(THISDIR=thisdir)
-                else:
-                    raise Exception("Configuration is using {THISDIR} to specify " \
-                    "a layer path relative to itself. This can be done only " \
-                    "when the configuration is specified by its path on local " \
-                    "disk, not when it's in a registry or is fetched over http.")
-            if not os.path.isabs(l):
-                l = os.path.join(layerdir, l)
+            l = os.path.join(layerdir, l)
+            layers_s.append("  {} \\".format(l))
+
+        for l in relative_layers:
+            if thisdir:
+                l = os.path.join(thisdir, l)
+            else:
+                raise Exception("Configuration is using bb-layers-relative to specify " \
+                "a layer path relative to itself. This can be done only " \
+                "when the configuration is specified by its path on local " \
+                "disk, not when it's in a registry or is fetched over http.")
             layers_s.append("  {} \\".format(l))
+
         layers_s = "\n".join(layers_s)
         bblayers_conf = """BBLAYERS ?= " \\
 {}
@@ -220,7 +223,8 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
         os.rename(bitbake_confdir, backup_bitbake_confdir)
 
     if layers:
-        _setup_build_conf(layers, bitbake_confdir)
+        relative_layers = bitbake_config.get("bb-layers-relative") or []
+        _setup_build_conf(layers, relative_layers, bitbake_confdir)
 
     if template:
         bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbuild, template, bitbake_builddir))
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 767a6298d..ba2a90009 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -148,9 +148,10 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 "oe-fragments": ["test-fragment-2"]
             },
             {
-                "name": "gizmo-notemplate-with-thisdir",
-                "description": "Gizmo notemplate configuration using THISDIR",
-                "bb-layers": ["layerC","layerD/meta-layer","{THISDIR}/layerE/meta-layer"],
+                "name": "gizmo-notemplate-with-relative-layers",
+                "description": "Gizmo notemplate configuration using relative layers",
+                "bb-layers": ["layerC","layerD/meta-layer"],
+                "bb-layers-relative": ["layerE/meta-layer"],
                 "oe-fragments": ["test-fragment-2"]
             }
         ]
@@ -204,14 +205,13 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             with open(os.path.join(bb_conf_path, 'bblayers.conf')) as f:
                 bblayers = f.read()
                 for l in bitbake_config["bb-layers"]:
-                    if l.startswith('{THISDIR}/'):
-                        thisdir_layer = os.path.join(
+                    self.assertIn(os.path.join(setuppath, "layers", l), bblayers)
+                for l in bitbake_config.get("bb-layers-relative") or []:
+                    relative_layer = os.path.join(
                             os.path.dirname(config_upstream["path"]),
-                            l.removeprefix("{THISDIR}/"),
+                            l,
                         )
-                        self.assertIn(thisdir_layer, bblayers)
-                    else:
-                        self.assertIn(os.path.join(setuppath, "layers", l), bblayers)
+                    self.assertIn(relative_layer, bblayers)
 
         if 'oe-fragment' in bitbake_config.keys():
             for f in bitbake_config["oe-fragments"]:
@@ -298,7 +298,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                                                                   'gizmo-env-passthrough',
                                                                   'gizmo-no-fragment',
                                                                   'gadget-notemplate','gizmo-notemplate',
-                                                                  'gizmo-notemplate-with-thisdir')}
+                                                                  'gizmo-notemplate-with-relative-layers')}
                                }
         for cf, v in test_configurations.items():
             for c in v['buildconfigs']:
-- 
2.39.5


