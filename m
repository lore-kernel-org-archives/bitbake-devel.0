Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D085DCAC5BB
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 16:57:19 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.744.1759942634632407948
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Oct 2025 09:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=dl6U4e0q;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so151656f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Oct 2025 09:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759942633; x=1760547433; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/Vhtg76ygXqDf/DoCmJBgG2CcU3cr/K7NUEm77PXA8=;
        b=dl6U4e0qaMUTldl++8JtT9y5tcFbypyCYW4iHck5kv6Adr5LvglFfj94o9FrnIJ2V3
         zzS+irvnmFCTWwqhq6vWybVebKplmyxpZGUHfvMxfpBRLliP83su4bU3wATEZijeXDwI
         av6Nu5QD2F+swVreV7lYGCge8nbQhOaHHSn0lzt9My5tyOXKTCdIEReq9L+KlfGCeYL4
         dZapod8NVEV5eQgP6xUvT4Z4m933+iuJt4CXa7hzEwn8Qn7ycOCCdYqtG56fi1tZNNgD
         JEW5GUF+sx/wUPVG6IOW83GR/v7Vgc4Et8BPU5y3UzaNeKCWmNUMi9/0nDKWQiuXYCds
         mNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942633; x=1760547433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/Vhtg76ygXqDf/DoCmJBgG2CcU3cr/K7NUEm77PXA8=;
        b=J8NLi40Nx+rhKGP1npfIwUONzMZ9v404W1yizSamlk/uX3Wk0iljtSb4ctse1jURBZ
         OFgSdKIBCLnfWR6StZFwCOANWsi7Ddt/uj7yhhH61+R//7cKEZ02KttTpDnoeWnEO2nc
         kUY7KRZhWV0QBM+GpcWG6ip8PoL5iU3Ga2Wx1I2sfsAWMorEk90i7GD2iOJ9MbgGzVj/
         vJJLTr11HyFxILGKlN5tx02evVDpNqgFVFxik58/aoVABD24sjefPIYiGB4db84CyLuE
         qpMU+os4mj+OCTkekbKI0jLZS7WDTq4IrYmQaDhDJeUv5B9b+79uE3lmHVDHbVP3DM/i
         gYpQ==
X-Gm-Message-State: AOJu0Yx2ZiW2hSgZrqhH7K0gFSTWxmqU1ENqWSyqTnL4sEjrUUPZ3aNy
	pRukhIKPXtTaAb1e5XqjVC0Xa9OaJoyrjAFwwUIAuab4qbVgvKR/SFxeJzSbUQ==
X-Gm-Gg: ASbGnctRIwVkHCoK6lSRoi0C1bAVMamejrlvQjEmCk6OC6IKkYxdt4fCSv/Rb7+pvMh
	Tvryh66LUQTzbCS/0gF33GQ4oCAjCoMEmLzL3EGuPB0wlWLGF6oD3BmiN/KP+MbOnNvza6p10N/
	7Ko8kfHgvT/6agovAai4LXIfwSPvdla5NmFEsOUSAKayPnsyUQk2X8l1lxtF6CunMvmtlPtXT/j
	pQ8Xg9adh/NX3mDxMPWqN3TEojCtpyKUe9cPAduwKneUeUpbInUkzTd6NUwjGYkX9E6qz8elU6w
	q/sk5YtQAJvZ7vXCrcYN2wPjGr8zLcs277Oe7ZXF0t3N21I1YmrY+qICXlKPRPa7IB9r4DaULjk
	Z475rx3YtHh4mot0XGyGTf42VwaMftALGcyMQO2dgbZ2cRbG6iIG5bYvbDK+8OimzaGhYV3na7B
	DCQmnn3ppebBIi7nAQJKImqPWMh87XJLMnksrnFiSPMtWseZQNbHSAYa2bv2YJk+MDEi1mAsCSA
	lTnRe7ntg==
X-Google-Smtp-Source: AGHT+IELP1j2OjlgF6fqHaU2IGfAorwC97Sax5VOV3IZiC4XXPcBQLBdCapvteDaW0zNUKl88l/UVQ==
X-Received: by 2002:a05:6000:2dc9:b0:425:8c06:b78a with SMTP id ffacd0b85a97d-4266e8e6820mr2556654f8f.59.1759942632932;
        Wed, 08 Oct 2025 09:57:12 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b77sm30740453f8f.6.2025.10.08.09.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:57:12 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 3/4] bitbake-setup: tests: add environment-passthrough
Date: Wed,  8 Oct 2025 18:56:58 +0200
Message-Id: <20251008165659.1884881-3-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251008165659.1884881-1-alex.kanavin@gmail.com>
References: <20251008165659.1884881-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Oct 2025 16:57:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18147

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

Add a test configuration to cover the 'bb-env-passthrough-additions'
conf.json key, and add it to the test routine.

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 lib/bb/tests/setup.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index c1e753b14..495d1da20 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -119,6 +119,17 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 "oe-template": "test-configuration-gizmo",
                 "oe-fragments": ["test-fragment-2"]
             },
+            {
+                "name": "gizmo-env-passthrough",
+                "description": "Gizmo build configuration with environment-passthrough",
+                "bb-layers": ["layerC","layerD/meta-layer"],
+                "oe-fragments": ["test-fragment-1"],
+                "bb-env-passthrough-additions": [
+                    "BUILD_ID",
+                    "BUILD_DATE",
+                    "BUILD_SERVER"
+                ]
+            },
             {
                 "name": "gizmo-no-fragment",
                 "description": "Gizmo no-fragment template-only build configuration",
@@ -198,6 +209,15 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             for f in bitbake_config["oe-fragments"]:
                 self.assertTrue(os.path.exists(os.path.join(bb_conf_path, f)))
 
+        if 'bb-environment-passthrough' in bitbake_config.keys():
+            with open(os.path.join(bb_build_path, 'init-build-env'), 'r') as f:
+                init_build_env = f.read()
+            self.assertTrue('BB_ENV_PASSTHROUGH_ADDITIONS' in init_build_env)
+            self.assertTrue('BUILD_ID' in init_build_env)
+            self.assertTrue('BUILD_DATE' in init_build_env)
+            self.assertTrue('BUILD_SERVER' in init_build_env)
+            # a more throrough test could be to initialize a bitbake build-env, export FOO to the shell environment, set the env-passthrough on it and finally check against 'bitbake-getvar FOO'
+
 
     def test_setup(self):
         # unset BBPATH to ensure tests run in isolation from the existing bitbake environment
@@ -255,10 +275,12 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         # test-config-1 is tested as a registry config, test-config-2 as a local file
         test_configurations = {'test-config-1': {'cmdline': 'test-config-1',
                                                  'buildconfigs':('gadget','gizmo',
+                                                                 'gizmo-env-passthrough',
                                                                  'gizmo-no-fragment',
                                                                  'gadget-notemplate','gizmo-notemplate')},
                                'test-config-2': {'cmdline': os.path.join(self.registrypath,'config-2/test-config-2.conf.json'),
                                                  'buildconfigs': ('gadget','gizmo',
+                                                                  'gizmo-env-passthrough',
                                                                   'gizmo-no-fragment',
                                                                   'gadget-notemplate','gizmo-notemplate',
                                                                   'gizmo-notemplate-with-thisdir')}
@@ -312,6 +334,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.add_file_to_testrepo('test-file', test_file_content)
         json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
         for c in ('gadget', 'gizmo',
+                  'gizmo-env-passthrough',
                   'gizmo-no-fragment',
                   'gadget-notemplate', 'gizmo-notemplate'):
             buildpath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
-- 
2.39.5


