Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC98CAC5B0
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 10:09:45 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.5229.1759399776343645930
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 03:09:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jJfNXMOW;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso537983f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 03:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399775; x=1760004575; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69vIkpICLyJT/PNf/Frl2PjjuaYh1jjwVBprDsDn+fU=;
        b=jJfNXMOWBnXUwtbLFgYvLjtw5SfmimBSvJKJzPr6kWvouIJwNgPCD4D1nrbG8Kx2Uw
         UQVx6jDgYKwZexvQD/Ulb8C11p83IcA9qIrlUjx4mTb4cB5mqRXdbRIAupFCYpsRT7nP
         QZWwIHaKNKy3190yxJuEn/k9fbUNZ24sZ7anZZ0M+SazlA+0Oj6WRizDbr5ggZ5YSDy8
         idv/UJB5TOnAzhT1dJNG+utfC8v9FXAvZdilAcBb3kilJ2d2iX7w4Sx8+xXBR0zgyTDa
         32yrhRP1dsdiKKG6T10BA1J9xgB82Idp5JWSRvbx67gg5DLjYoihlNxPDJEK3IvSzj41
         ubRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399775; x=1760004575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69vIkpICLyJT/PNf/Frl2PjjuaYh1jjwVBprDsDn+fU=;
        b=OUeFQXDBqjGwDb4MZ9Nle4OqzsFZn2Xi5mS2MO9cl5L2k8/C4s3eqvgLpwVgQM2Arb
         SRvGOUlR2PF0jrZNlH3mRMSj5Ski4QPrKeuzI9aX6/HR611HtX6pmANGYw3mx6XJY6ZZ
         dSapP0Tk1hHIBf/pheyqByQjwCQDe/Aj0MxwiRBItWxWWtBnxYOl3o2yn5/h4qTM3Exs
         4q2k1ERpI5CrHbmiNpY9WQkuzV2XhLZWm54CJDHMEmZSBhwu7yCTdKRZT/pKIIxErTVg
         ruqtRvLuGS7tOq6IGGYf+7zXUAss8bW4VAtLgva7b4Q0MqpJNY51ae2JAdoWFEAB6Crc
         nNKg==
X-Gm-Message-State: AOJu0YwHW6ehwSexHKGOZr0CBO8lPN9KN9IvHNkomKzyIzks5hZqiCqv
	NfJW3CNnQaxrzG5HfjY2wN3EL9JnWc2jcZo1eXWAckPAEukvemecpQSvq/2DEg==
X-Gm-Gg: ASbGncvrVy8/r7fapPg9e3Vs3CE9Ljw5ASmKC5XroP/ASCn3zsHIx0RVYrrFzkeVkck
	Ib/D4pe3ftwEfjETzakRZ8Ggl0blyWYGrbKADpVDloL778bd7ePi13S6uWVzNTKPv8fYSDCv6Sh
	FvP9eaxy1wvBvyjUdXM3lcacBedWTUZ3PAZau1nIESW9t8dfPuNXjBpDQUbjSFtiXdYdarGo0yX
	7iD4J1hxSOCiSR7gbJwqQLja7Yv3y3ZQQN1ozZyWXBOS8ludnug2HOR1YOvLm2uODFtFVPvDpFR
	qNLK2ANs0axeLff7KI+384qORsIWWsR2tK5app2z01QyRL7BkRlIMKDAoEvHGbcVUXCUojdE/yz
	nc/eCEMs6xYuAZycWgf/jqs42PllvSzg0bjkik5VyVoH+GMZoGzJWaq6pMRLjKTuyHwLL5xNZN4
	rd45rKrQ9p/G7yaj40UssxHcFzQfFDhIbBQiHEto9xpJlATXAU+1Cnd5HZ2VSMBuLFFIEpDO5ww
	rlySbChV42GVTpSQlUC
X-Google-Smtp-Source: AGHT+IH449xS+FSlripcaiB1+ZONvjDSOmYM/w41aq1AAsMbPfNhJfxZqo1PgDH5h1zuokRvdgNT7g==
X-Received: by 2002:a5d:64c6:0:b0:3ee:158c:8bc3 with SMTP id ffacd0b85a97d-42557814828mr5741262f8f.36.1759399774642;
        Thu, 02 Oct 2025 03:09:34 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6bbesm2953894f8f.12.2025.10.02.03.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:09:34 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH 5/7] bitbake-setup: allow using {THISDIR}/my-layer
Date: Thu,  2 Oct 2025 12:09:27 +0200
Message-Id: <20251002100929.1054540-5-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251002100929.1054540-1-alex.kanavin@gmail.com>
References: <20251002100929.1054540-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 10:09:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18119

From: Yoann Congal <yoann.congal@smile.fr>

This implement the ability to use "{THISDIR}/my-layer" in the
"bb-layers" list. "{THISDIR}" is remplaced by the directory containing
the configuration file.

In small projects, we try to keep the setup a simple as possible: a
single git repo containing both the build confguration (e.g.
a bitbake-setup configuration file) and the meta layer with project
recipes/machine/distro.

This change allows this kind of setup:
├── meta-my-project/ # the project layer
└── my-project.conf.json   # the bb-setup configuration file

by writing, in my-project.conf.json:
  "bitbake-setup": {
    "configurations": [{
      "bb-layers": [
        "{THISDIR}/meta-my-project"

Note: in this case meta-my-project is not present as a "source", so, not
handled by bb-setup update/status. It is expected of the user to handle
this on their own (is our case, a simple git workflow).

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 bin/bitbake-setup     | 20 +++++++++++++++++---
 lib/bb/tests/setup.py | 17 +++++++++++++++--
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 36a1bbd91..de83d780b 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -114,10 +114,23 @@ def checkout_layers(layers, layerdir, d):
                 os.remove(symlink)
             os.symlink(os.path.relpath(t,layerdir),symlink)
 
-def setup_bitbake_build(bitbake_config, layerdir, builddir):
+def setup_bitbake_build(bitbake_config, layerdir, builddir, thisdir):
     def _setup_build_conf(layers, build_conf_dir):
         os.makedirs(build_conf_dir)
-        layers_s = "\n".join(["  {} \\".format(os.path.join(layerdir,l)) for l in layers])
+        layers_s = []
+        for l in layers:
+            if l.startswith("{THISDIR}/"):
+                if thisdir:
+                    l = l.format(THISDIR=thisdir)
+                else:
+                    raise Exception("Configuration is using {THISDIR} to specify " \
+                    "a layer path relative to itself. This can be done only " \
+                    "when the configuration is specified by its path on local " \
+                    "disk, not when it's in a registry or is fetched over http.")
+            if not os.path.isabs(l):
+                l = os.path.join(layerdir, l)
+            layers_s.append("  {} \\".format(l))
+        layers_s = "\n".join(layers_s)
         bblayers_conf = """BBLAYERS ?= " \\
 {}
   "
@@ -237,7 +250,8 @@ def update_build(config, confdir, builddir, layerdir, d):
             layer_config[k]["git-remote"] = v["git-remote"]
     checkout_layers(layer_config, layerdir, d)
     bitbake_config = config["bitbake-config"]
-    setup_bitbake_build(bitbake_config, layerdir, builddir)
+    thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
+    setup_bitbake_build(bitbake_config, layerdir, builddir, thisdir)
 
 def int_input(allowed_values):
     n = None
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 2076613d9..747a9b733 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -130,6 +130,12 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 "description": "Gizmo notemplate build configuration",
                 "bb-layers": ["layerC","layerD/meta-layer"],
                 "oe-fragments": ["test-fragment-2"]
+            },
+            {
+                "name": "gizmo-notemplate-with-thisdir",
+                "description": "Gizmo notemplate build configuration using THISDIR",
+                "bb-layers": ["layerC","layerD/meta-layer","{THISDIR}/layerE/meta-layer"],
+                "oe-fragments": ["test-fragment-2"]
             }
         ]
     },
@@ -174,7 +180,14 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             with open(os.path.join(bb_conf_path, 'bblayers.conf')) as f:
                 bblayers = f.read()
                 for l in bitbake_config["bb-layers"]:
-                    self.assertIn(os.path.join(buildpath, 'layers', l), bblayers)
+                    if l.startswith('{THISDIR}/'):
+                        thisdir_layer = os.path.join(
+                            os.path.dirname(json_config["path"]),
+                            l.removeprefix("{THISDIR}/"),
+                        )
+                        self.assertIn(thisdir_layer, bblayers)
+                    else:
+                        self.assertIn(os.path.join(buildpath, "layers", l), bblayers)
 
         for f in bitbake_config["oe-fragments"]:
             self.assertTrue(os.path.exists(os.path.join(bb_conf_path, f)))
@@ -235,7 +248,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 
         # test-config-1 is tested as a registry config, test-config-2 as a local file
         test_configurations = {'test-config-1': {'cmdline': 'test-config-1', 'buildconfigs':('gadget','gizmo','gadget-notemplate','gizmo-notemplate')},
-                               'test-config-2': {'cmdline': os.path.join(self.registrypath,'config-2/test-config-2.conf.json'), 'buildconfigs': ('gadget','gizmo','gadget-notemplate','gizmo-notemplate') } }
+                               'test-config-2': {'cmdline': os.path.join(self.registrypath,'config-2/test-config-2.conf.json'), 'buildconfigs': ('gadget','gizmo','gadget-notemplate','gizmo-notemplate', 'gizmo-notemplate-with-thisdir') } }
         for cf, v in test_configurations.items():
             for c in v['buildconfigs']:
                 out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
-- 
2.39.5


