Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D379FCCD187
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 16:57:19 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.web10.791.1759942633914194187
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Oct 2025 09:57:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YVpleJ91;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so120989f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Oct 2025 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759942632; x=1760547432; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmJW1kqlnN1S2CnsBugrVRuV2iWPSXdpG228dMj/vCs=;
        b=YVpleJ91VzZX11sckKPbdoFUadGiGEih1b1bMW2bXz4fqxWkG8xpYruNryrnKrTsKi
         C71G9+C8wWM2+voGZ2HcTOrcmlmSVL/1/eQV54n6S/6xc702Ys1r+aZpHeRj+PFED6/n
         uLo5LN+tSszcFeCWZSZhthejteN71xDxX5CgzbJhaTEsxgFK0x5Xptqj90d15Lg/ouS4
         VzW+vtBXFRspAnEy0psNx+NQkSU9uySZkFLPN/1N3vA6JrLqUsBMP2xPmhgxOl7qZ22u
         +rA1B2byno3sKeFslvOa2iDvVuGMX9UX2qXORlsbfKg3eHHL4Hwn/1tqd5bMqvyZ5C1u
         z5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942632; x=1760547432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QmJW1kqlnN1S2CnsBugrVRuV2iWPSXdpG228dMj/vCs=;
        b=XSaq0Ar/vYcNU5ymUdsV0wedu8CLljHc26nmrEakE4m8eaPs1qRQJ6iAZcjofgZYA9
         KcLTQ/94jlHE1ErQI7xVZRnbDtJc1pZE7ok0Cl/faVxp3EW/vs1Hz4hhoYOXwbKOnWwp
         WT2mH6wqTscn+pogHIYyoWQWXPSrLqvo8+v7QTL5POB5gt8g/j1geUOv7c+1/Xkrp41v
         4UqtaSRi7Ab1tOCI24p1N/5YhxXgdKJHyX7swvRKA1+Pd7kKIITTG2WmYfelRWSblqx4
         +/onaWMdOZfXHbdYsQkZUEJIBjSbHWXXkbh4XbNk6mBkg8//8UxL11h4ssL5+hMIQN7N
         740g==
X-Gm-Message-State: AOJu0YwFs48xusOR3m1fs1I4XNw1MjIMEbQzwQXf2GQASJKiQO+xmc66
	PTyZ20Rl7hHCre1r5kgO8SuwQe+3uN5uzaLOTAL4tRzF1D+d1FF47A8XbuOeoQ==
X-Gm-Gg: ASbGnct4ouCkOVb/WLU67ZVGJdK6Pe7SkLXRBn3oam1z6Ni+F9bSizZHXkUnYbciuKi
	83krUQZvApPo6MIpEIIN1FWaXgdmp8WB2dlMvokg9De/JB13NHopDPBfN5I81W3veFCc09DpKEE
	4OrZOkXlTYl6ynzGvuL0YhZIequa7LPk0YsRCFI8hX/podjG4rc0mzktcZ5E0myYE0CadMu2EH1
	dC8wKbH+VivhpFsC3GpfTVRfPlNff9W+3yeDnPc9ef1p2xcqylImspAdrIeLv9KEbQbzjt/unav
	V3P1BCvzIsp7i7SUTBimJ1ayWpwIOjMFaxlpQSYhk4F4/qRYFFv++LpnSzKh0SfB3nOkxh3x3By
	lYqRMxyuVhuic+X6HtH1w/X88+VUR1gHhcMk7a9mN4osMAoPDzjpfDqWaWyVRTegBb6CoTwhIsL
	VRXgY9HmfvHvsEQWDfRCtoinfJi9KiaC2iB/nSNUaQb+zfG+Xwwh8scFjMtqQLp0VsfHtwW5zG2
	LLDMO/1Sg==
X-Google-Smtp-Source: AGHT+IEGjHtkuXGQcnihcopD2WQpT8y29mZ3zo5GphgzOVw6q80P+ckc4Ski0BWcUki8Wsp/m1Kd/w==
X-Received: by 2002:a05:6000:2501:b0:40d:86c9:5c9e with SMTP id ffacd0b85a97d-4266e7dfddfmr2685216f8f.40.1759942632149;
        Wed, 08 Oct 2025 09:57:12 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b77sm30740453f8f.6.2025.10.08.09.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:57:11 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 2/4] bitbake-setup: tests: add a template-only test configuration
Date: Wed,  8 Oct 2025 18:56:57 +0200
Message-Id: <20251008165659.1884881-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251008165659.1884881-1-alex.kanavin@gmail.com>
References: <20251008165659.1884881-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Oct 2025 16:57:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18146

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

bitbake-setup conf.json can be purely template driven, to setup older
yocto LTS (e.g. scarthgap) based layer-collections - where fragment
support was not yet present in oe-core+bitbake.

Add a configuration for that scenario and add it to the test routine.

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 lib/bb/tests/setup.py | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 747a9b733..c1e753b14 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -119,6 +119,11 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 "oe-template": "test-configuration-gizmo",
                 "oe-fragments": ["test-fragment-2"]
             },
+            {
+                "name": "gizmo-no-fragment",
+                "description": "Gizmo no-fragment template-only build configuration",
+                "oe-template": "test-configuration-gizmo"
+            },
             {
                 "name": "gadget-notemplate",
                 "description": "Gadget notemplate build configuration",
@@ -189,8 +194,9 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                     else:
                         self.assertIn(os.path.join(buildpath, "layers", l), bblayers)
 
-        for f in bitbake_config["oe-fragments"]:
-            self.assertTrue(os.path.exists(os.path.join(bb_conf_path, f)))
+        if 'oe-fragment' in bitbake_config.keys():
+            for f in bitbake_config["oe-fragments"]:
+                self.assertTrue(os.path.exists(os.path.join(bb_conf_path, f)))
 
 
     def test_setup(self):
@@ -247,8 +253,16 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.add_file_to_testrepo('test-file', test_file_content)
 
         # test-config-1 is tested as a registry config, test-config-2 as a local file
-        test_configurations = {'test-config-1': {'cmdline': 'test-config-1', 'buildconfigs':('gadget','gizmo','gadget-notemplate','gizmo-notemplate')},
-                               'test-config-2': {'cmdline': os.path.join(self.registrypath,'config-2/test-config-2.conf.json'), 'buildconfigs': ('gadget','gizmo','gadget-notemplate','gizmo-notemplate', 'gizmo-notemplate-with-thisdir') } }
+        test_configurations = {'test-config-1': {'cmdline': 'test-config-1',
+                                                 'buildconfigs':('gadget','gizmo',
+                                                                 'gizmo-no-fragment',
+                                                                 'gadget-notemplate','gizmo-notemplate')},
+                               'test-config-2': {'cmdline': os.path.join(self.registrypath,'config-2/test-config-2.conf.json'),
+                                                 'buildconfigs': ('gadget','gizmo',
+                                                                  'gizmo-no-fragment',
+                                                                  'gadget-notemplate','gizmo-notemplate',
+                                                                  'gizmo-notemplate-with-thisdir')}
+                               }
         for cf, v in test_configurations.items():
             for c in v['buildconfigs']:
                 out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
@@ -272,13 +286,16 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         prev_test_file_content = test_file_content
         test_file_content = 'modified\n'
         self.add_file_to_testrepo('test-file', test_file_content)
-        for c in ('gadget','gizmo','gadget-notemplate','gizmo-notemplate'):
+        for c in ('gadget', 'gizmo',
+                  'gizmo-env-passthrough',
+                  'gizmo-no-fragment',
+                  'gadget-notemplate', 'gizmo-notemplate'):
             buildpath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
             os.environ['BBPATH'] = os.path.join(buildpath, 'build')
             out = self.runbbsetup("status")
             self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, buildpath), out[0])
             out = self.runbbsetup("update")
-            if c in ('gadget','gizmo'):
+            if c in ('gadget', 'gizmo'):
                 self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(buildpath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
             with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
@@ -294,14 +311,16 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.git('checkout -b {}'.format(branch), cwd=self.testrepopath)
         self.add_file_to_testrepo('test-file', test_file_content)
         json_1 = self.add_json_config_to_registry('test-config-1.conf.json', branch, branch)
-        for c in ('gadget','gizmo','gadget-notemplate','gizmo-notemplate'):
+        for c in ('gadget', 'gizmo',
+                  'gizmo-no-fragment',
+                  'gadget-notemplate', 'gizmo-notemplate'):
             buildpath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
             os.environ['BBPATH'] = os.path.join(buildpath, 'build')
             out = self.runbbsetup("status")
             self.assertIn("Configuration in {} has changed:".format(buildpath), out[0])
             self.assertIn('-                    "rev": "master"\n+                    "rev": "another-branch"', out[0])
             out = self.runbbsetup("update")
-            if c in ('gadget','gizmo'):
+            if c in ('gadget', 'gizmo'):
                 self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(buildpath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
             with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
-- 
2.39.5


