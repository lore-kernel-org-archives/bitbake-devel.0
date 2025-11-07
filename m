Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D3FCCFA05
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 10:16:49 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8188.1762510603414367453
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Nov 2025 02:16:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WjBC9YsT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477563bcaacso4044075e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 02:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762510601; x=1763115401; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fH93wnxPYnTxE1xsDhhek+6kGNq6mGQCFUoECUOU6vk=;
        b=WjBC9YsTUPPOiL9P5RBKPbc6glHMn7vBSvktzahz+7rM7H1A0OOP7bzckkUtsPT1e7
         FN2ftM5WuPDFoET8J9uyNQ2Vaa6Ukh7s4vFW6FMcw0PVeUj7SprxyEeJb+cmDNS61wZ+
         LnuU+Sg5iGcDflr/4sn5jTiU6au5uGvm1Byz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510601; x=1763115401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fH93wnxPYnTxE1xsDhhek+6kGNq6mGQCFUoECUOU6vk=;
        b=hgZo+9tdpNKTHv91XiNAsGtOeRrLgLcxpWLLrLRKXbduFS9pKSR7h3cPAfJl+munXX
         eX6QO+qLMOBWf45PrjPskS29WAdYlZDlkb21sXs2x/f9ECAmPQqJniku9/GE+SldpEAF
         xJ4Tv7MQ5hbOaN5LIlDLRN1AcO+nIxF7yGMZ9FlHLs5Qk7wHA8H0/HW8ejXE4ouG4MwL
         n3TXGkIKxTwfL4jiTxGX0tE+IP/ht5gYVOH1+1mmxMGcA8Vf33Ng5CarsFbLhi6SSlh/
         oOfHoVBf4XsvRYnx+NvMjuKDrUFhv8/m2UNMoiLsYwrWaMZsOKBp/JZM3sntLcoKGK0l
         gXxQ==
X-Gm-Message-State: AOJu0Ywv5ruEJaj5wiPJbnI/dwNGngDhQi2/WfBkowUQVCtrB/7mGLwT
	kePznS/B6ttuymvMjleqZkdF6dgH0p6BWiC46FjlV4lBLkjT7F2XXrKbDUaXEQCECac8+w1jkRh
	WQTpo
X-Gm-Gg: ASbGnct5C8u5a+xF0jKlvdJwlf0/Y2HFKe60uqbCG1Ffyxv14xMtz9vH+Tw0ztfkYiB
	XyXCpC3FSTIn+49aE4a3u2lsoOgTWa531//MIH/XJ85661bVq34LqlXJZm1ei2s06HBbL9KySWW
	19ta81JyGXrK9TOrEBiL6rqY5nufTe+emXBmyFH9pK3DLHa4b/iQS2vYWozN/oqL3ypL5dTUQ/N
	3qvlkbDCGCvisK20HYXEEdTa/mA2GCZjeJLYNwYUaseTiwId499b8bg5EuSC3e4ILLhVcQ9Y6VJ
	1RicspgCCo09uTAilEdt6A4jvz5SGa/6R9cLKBsNsNTBOE9cRYdkvIU9W/3nvZS6OIsX1jWDY38
	tBMIZ+bA6CF1ro7cUWLXE5Z5a5MQowA7rA52jibZK9Qk2H/2sDG1aUdLiSqy0FFBJhkMek1Ipg1
	O22Zm1VPRuD833ia6a1HRTD3EnCmoS
X-Google-Smtp-Source: AGHT+IErYfocV4Fp+q8+8Qk0Ry6ftqw9ZIqT57jeRvTYsQZcC2mGTG1s7CgMIYFcyZGdB8dT/++g2Q==
X-Received: by 2002:a7b:cb99:0:b0:477:5c45:8100 with SMTP id 5b1f17b1804b1-4776bcb9fcemr11290925e9.24.1762510601234;
        Fri, 07 Nov 2025 02:16:41 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:aeb7:f903:75cb:8c09])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477640fb801sm36612305e9.11.2025.11.07.02.16.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 02:16:40 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-setup: Rename bb-layers-relative to bb-layers-file-relative
Date: Fri,  7 Nov 2025 10:16:39 +0000
Message-ID: <20251107101639.1610711-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Nov 2025 10:16:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18303

The difference between bb-layers and bb-layers-relative is unclear as both
are relative paths. Rename one to "file-relative" which makes it clear it
is relative to the current file, without becomming a long name.

https://lists.openembedded.org/g/bitbake-devel/message/18296

Based on a patch from Alexander Kanavin <alex@linutronix.de> but
with different naming.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-setup     | 10 +++++-----
 lib/bb/tests/setup.py | 14 +++++++-------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 29fdf118923..caec990c291 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -129,7 +129,7 @@ def checkout_layers(layers, layerdir, d):
     return layers_fixed_revisions
 
 def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
-    def _setup_build_conf(layers, relative_layers, build_conf_dir):
+    def _setup_build_conf(layers, filerelative_layers, build_conf_dir):
         os.makedirs(build_conf_dir)
         layers_s = []
 
@@ -137,11 +137,11 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
             l = os.path.join(layerdir, l)
             layers_s.append("  {} \\".format(l))
 
-        for l in relative_layers:
+        for l in filerelative_layers:
             if thisdir:
                 l = os.path.join(thisdir, l)
             else:
-                raise Exception("Configuration is using bb-layers-relative to specify " \
+                raise Exception("Configuration is using bb-layers-file-relative to specify " \
                 "a layer path relative to itself. This can be done only " \
                 "when the configuration is specified by its path on local " \
                 "disk, not when it's in a registry or is fetched over http.")
@@ -223,8 +223,8 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
         os.rename(bitbake_confdir, backup_bitbake_confdir)
 
     if layers:
-        relative_layers = bitbake_config.get("bb-layers-relative") or []
-        _setup_build_conf(layers, relative_layers, bitbake_confdir)
+        filerelative_layers = bitbake_config.get("bb-layers-file-relative") or []
+        _setup_build_conf(layers, filerelative_layers, bitbake_confdir)
 
     if template:
         bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbuild, template, bitbake_builddir))
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index ba2a90009de..6e9bf036548 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -148,10 +148,10 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 "oe-fragments": ["test-fragment-2"]
             },
             {
-                "name": "gizmo-notemplate-with-relative-layers",
-                "description": "Gizmo notemplate configuration using relative layers",
+                "name": "gizmo-notemplate-with-filerelative-layers",
+                "description": "Gizmo notemplate configuration using filerelative layers",
                 "bb-layers": ["layerC","layerD/meta-layer"],
-                "bb-layers-relative": ["layerE/meta-layer"],
+                "bb-layers-file-relative": ["layerE/meta-layer"],
                 "oe-fragments": ["test-fragment-2"]
             }
         ]
@@ -206,12 +206,12 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 bblayers = f.read()
                 for l in bitbake_config["bb-layers"]:
                     self.assertIn(os.path.join(setuppath, "layers", l), bblayers)
-                for l in bitbake_config.get("bb-layers-relative") or []:
-                    relative_layer = os.path.join(
+                for l in bitbake_config.get("bb-layers-file-relative") or []:
+                    filerelative_layer = os.path.join(
                             os.path.dirname(config_upstream["path"]),
                             l,
                         )
-                    self.assertIn(relative_layer, bblayers)
+                    self.assertIn(filerelative_layer, bblayers)
 
         if 'oe-fragment' in bitbake_config.keys():
             for f in bitbake_config["oe-fragments"]:
@@ -298,7 +298,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                                                                   'gizmo-env-passthrough',
                                                                   'gizmo-no-fragment',
                                                                   'gadget-notemplate','gizmo-notemplate',
-                                                                  'gizmo-notemplate-with-relative-layers')}
+                                                                  'gizmo-notemplate-with-filerelative-layers')}
                                }
         for cf, v in test_configurations.items():
             for c in v['buildconfigs']:

