Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B822CCFA03
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 11:47:27 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13264.1762429639499289576
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Nov 2025 03:47:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OXwxunXb;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b70bee93dc4so111726366b.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 03:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762429638; x=1763034438; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=34lSSakZVQu/zTrPmG+Jq/jG4JsAjupb1sZSFLAxd3s=;
        b=OXwxunXbCSu8UF/WI0mvK9G5fMdQqvAfZ21C+l4ppqiXj0P0KtF3IcFJi5McyF7nh7
         y3Q2VyZ2b/smNnugsk3gRF/xIB1/iA44mxJjrS6V4A+a04fQmz9/YY5x7PkZw1G0VsJ6
         LA0H+ngwRTYl93LUa8ky6VzVDgNQ9DW+DJWTo+uqL54XI5HAkNas385doklp1pOo7Evn
         N2hGS6iuM8UqePVn94ow/19bRaEtF/ku/9jMO4m7gyO353lWW4q3rcqmIuW9cqoDU6me
         uKTAt2scNw8dU1Qu9epnQz6ZoCRZwKz2PvmN6G4gUebVpkSZesPnirXnTOZh1N5m0PFm
         DIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429638; x=1763034438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34lSSakZVQu/zTrPmG+Jq/jG4JsAjupb1sZSFLAxd3s=;
        b=bL2c4+EQwefXtWr2YJH54AVoynxXmtdMutm/+pvXtSdIXYcpZwDSjAFFAjZ56Dap9M
         w4rjUH9CT9Jjia6MF1rEEjHI66p+Lwrh+5IwZcssuJjT9OnZDEK9/z3HlTXzpCTQUvg7
         CPBcfLmXUj5nAtabLe1o1o9tvQCvZVG1etTwmrsL1cvgB3xPjBMk9ToaaQS+TA9MUSzL
         YrGkyz1/ETi1fB6jcblqOYcGoRfFHvGNBSvwb1nkB099WsFfZvI5V+6lI5hr4bEvtxkM
         fxJ+1pQZso+kJxDFxDNfjkOcRBdJ1LZR2uXeyirwwXcdySOL9SU1ZoXh6phpJ6QyFwsy
         uBug==
X-Gm-Message-State: AOJu0Yx5KsUwfvGpRqjDdD/A6yxF54umUvencR3HRB+q/YsyVvCSC6qY
	u5zHiOSK9iJufI7MdIxeXIKLfOyM3Wk3cT32yq3bK05HT5fqIgJTChp2k0wGxQ==
X-Gm-Gg: ASbGncuYVW5FmBWCfslHiVHkRl0FwwZG4KEO17OZFkhTbtRKZytkqbUbMmjoLd5K7p0
	PWIJ7n3MYDnm/P/g6fDq42N15bs7vE145pA1kAYxjKBOZQbMYZf+WeG6sJ4xcOdbtQt5MKoYQxQ
	/TDLzaZTSU287ws5QYnU112BBfyKmSUUeSKRDBLmM3Pq4y80Is2zXNMW4BMnOdM6kdL42caRwag
	FOu5MtESKYsK3BplxHUj6MCNf8AlC9xJCNOV0f5GUDJVAAgq7B2TnOw0j0zyyCgRxfwzxDaCJuL
	Facpy+o8Kg08rhvnOY7SqWe5+up5hxRNCYFx+rTTC7ek6B0NYTBM9xh/mxsfpRvWQN1nVt6ufHl
	pz0i8hk8g6ktV2jKmVN6oqhbRZEHae6jxF13+/uoIcyKZpkA7KfpPBzX/vkofB8OvaVJiVK4+n4
	PQIUVRk04h5WWOkgANgJ3YVjJ2RKQWehObLYM6
X-Google-Smtp-Source: AGHT+IF6CGEstAF7KgwpusPQHOShLLE1vFPC2F4kedaT4fWwLCIXaK4rfkL2EV4oHwDhY0oPuHU2Eg==
X-Received: by 2002:a17:907:2da8:b0:b6d:7400:3d90 with SMTP id a640c23a62f3a-b7265698527mr630154366b.64.1762429637477;
        Thu, 06 Nov 2025 03:47:17 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f862cbesm1592635a12.31.2025.11.06.03.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:47:17 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: replace {THISDIR} token with an explicit keyword
Date: Thu,  6 Nov 2025 12:47:14 +0100
Message-Id: <20251106114714.918370-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Nov 2025 11:47:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18285

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
   "bb-layers-relative-to-this-file": [
        "meta-my-project"

Going forward I think we should strive to avoid any further special value tokens.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup     | 28 ++++++++++++++++------------
 lib/bb/tests/setup.py | 20 ++++++++++----------
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 47de4654e..7e227d82d 100755
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
+                raise Exception("Configuration is using {THISDIR} to specify " \
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
+        relative_layers = bitbake_config.get("bb-layers-relative-to-this-file") or []
+        _setup_build_conf(layers, relative_layers, bitbake_confdir)
 
     if template:
         bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbuild, template, bitbake_builddir))
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 767a6298d..83b1794a3 100644
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
+                "bb-layers-relative-to-this-file": ["layerE/meta-layer"],
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
+                for l in bitbake_config.get("bb-layers-relative-to-this-file") or []:
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


