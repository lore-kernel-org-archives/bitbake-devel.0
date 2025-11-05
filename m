Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EFCCCFA1C
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 19:06:48 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17662.1762369606429176477
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 11:06:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=R6XWlaSi;
 spf=pass (domain: gmail.com, ip: 209.85.221.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429b72691b4so144824f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 11:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762369605; x=1762974405; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aI7pnUesjsLGs0O80OhdRsiCGJvxWifBYB24Q8cr8DY=;
        b=R6XWlaSiX8pjk77Xxxj7Egiu3QPK0lOgUkvA6owiMyKXrvs4nPIBkByQdMzOhDLtdn
         qdH8PExxa5IMOiMtafrx294lziEUfiHv3A3HS5+LFQa1chmY4CbO/vGnbuMKMB11qdhm
         YNIMIPdz1CiAAsPee3dmrjToP5d/OKW+cYhTIGyohOLlIaDdD47p903fYQJqZMR9WThi
         zxbIXm2qzNRSYdT1UBz+v6UYEXMAuuILTsOvbYJLDA9BxQzgbt5vgd6EErEDu7y8Fo0C
         JEElBxu/H+AwFhRRpq00kVClaNmawazWMTpeOnY/tuKF3i8GZDQIT/QhlINP8+ewM2hU
         BI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762369605; x=1762974405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aI7pnUesjsLGs0O80OhdRsiCGJvxWifBYB24Q8cr8DY=;
        b=jNSeHbwtD2pbOVZDU02cKvXxuRAiwzbIy8xLVMKWMHrEv0DxopndD+S3hD5K/dEs8e
         HFsfeSfZ8OF1GLP55flfd97lKXtsuwbRYzx9Txju1ynyfu3oIeobJo8NjgTpV5cSLhQF
         QiKm+KgG9jhe8ditMpyJ9xGnDy2vgF8l8DcbmFGQpTwXW3BhZPX7sdsGDCrLxzc6gTKl
         EwD7YgX5zRUOdPPHrCPEH9TmgJfvosVKt9RPaxbJ8sz+baq9CCILP2w5CC53nHcMJAQ4
         3zMD69ztfqhDXrKCxaCVW4XaEQWxB3AcztxlFW86MgYGBqr1CTJwwdHy9NJr2SWuxKrj
         aesg==
X-Gm-Message-State: AOJu0Yx35MjnkRD+wqVghalSF2FMjuvzHBwbWl10OxX/7QpgLdQRarKw
	U7o50b+AH896VWipl5Pr5ln90ciM4vFzcVHFsAokkEQIDMm+jq+CEtgK6q196w==
X-Gm-Gg: ASbGncsvX176/MHblrCj/EHovii5O39Jx4rUiDjzGSoyB934X0mnjmZSSHkJgucmxAN
	WRydOlTA3ko8su4H98+ssZp2WBKYaS6dOcyZJBLBkmwZwNDfT12EGO1fzZsTFwoyfDX5VsH1crw
	asyY439XSahEgdbvu+Jx50D+vtmTFo+Vq0mJpN6Ng8IUsWzftG/MDkxRFcIJAHva9X/4BBton3v
	r23b6SJiDAAhpwpjbwk9UdpnrZ844tM7iVRbY0FHX3mVfWInBtNWpJ54llrq6cSvHFqMyqHfFCv
	0mQn3W8WcpFrDEO2Nj0Fi2eRS/8wo3rYbZQqIDcXsjQVHZoks/bYXENZlQiKpdQcbKvkgSA5zJI
	DsWLlxOVfEU93nUZqi2L68CDdY6TPG0Vz3wz+llUUd0z1oPce0xOC221Ck8PoXDqwGhkEHmTe9A
	4yMzZCq5p1k9/HDzt7o/PNOCei5YiZQbl9T2ayKORYG+oUXVw=
X-Google-Smtp-Source: AGHT+IH8Mn38QiwO6Oq/KPDKP5Wnj12OGGZGQLpNSjwtLOnhc8p8RmR+y1efOsZ+2MTzmArEbMN6EA==
X-Received: by 2002:a05:6000:1a8a:b0:429:d48d:aca8 with SMTP id ffacd0b85a97d-429e32c9560mr3507660f8f.9.1762369604513;
        Wed, 05 Nov 2025 11:06:44 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb477203sm313840f8f.29.2025.11.05.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:06:44 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 5/6] bitbake-setup: tests: move duplicate code into 'check_setupdir_files'
Date: Wed,  5 Nov 2025 20:06:35 +0100
Message-Id: <20251105190636.679388-5-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105190636.679388-1-alex.kanavin@gmail.com>
References: <20251105190636.679388-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 19:06:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18274

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

All places that called into 'check_setupdir_files' did the same
preparation step to load the upstream-config.json and then pass it
into the function.

Since the 'setuppath' is already passed into the function, and the
name and relative location of the upstream-config.json is fixed,
constructing the file path and loading the json could be done in the
function.

De-duplicate code by loading the json inside the function instead.

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 lib/bb/tests/setup.py | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index a17b8ac46..e18d6fc6a 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -177,10 +177,12 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.git('add {}'.format(name), cwd=self.testrepopath)
         self.git('commit -m "Adding {}"'.format(name), cwd=self.testrepopath)
 
-    def check_setupdir_files(self, setuppath, test_file_content, json_config):
+    def check_setupdir_files(self, setuppath, test_file_content):
+        with open(os.path.join(setuppath, 'config', "config-upstream.json")) as f:
+            config_upstream = json.load(f)
         with open(os.path.join(setuppath, 'layers', 'test-repo', 'test-file')) as f:
             self.assertEqual(f.read(), test_file_content)
-        bitbake_config = json_config["bitbake-config"]
+        bitbake_config = config_upstream["bitbake-config"]
         bb_build_path = os.path.join(setuppath, 'build')
         bb_conf_path = os.path.join(bb_build_path, 'conf')
         self.assertTrue(os.path.exists(os.path.join(bb_build_path, 'init-build-env')))
@@ -198,7 +200,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 for l in bitbake_config["bb-layers"]:
                     if l.startswith('{THISDIR}/'):
                         thisdir_layer = os.path.join(
-                            os.path.dirname(json_config["path"]),
+                            os.path.dirname(config_upstream["path"]),
                             l.removeprefix("{THISDIR}/"),
                         )
                         self.assertIn(thisdir_layer, bblayers)
@@ -296,9 +298,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             for c in v['buildconfigs']:
                 out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
                 setuppath = os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
-                with open(os.path.join(setuppath, 'config', "config-upstream.json")) as f:
-                    config_upstream = json.load(f)
-                self.check_setupdir_files(setuppath, test_file_content, config_upstream)
+                self.check_setupdir_files(setuppath, test_file_content)
                 os.environ['BBPATH'] = os.path.join(setuppath, 'build')
                 out = self.runbbsetup("status")
                 self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
@@ -327,9 +327,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             if c in ('gadget', 'gizmo'):
                 self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
-            with open(os.path.join(setuppath, 'config', "config-upstream.json")) as f:
-                config_upstream = json.load(f)
-            self.check_setupdir_files(setuppath, test_file_content, config_upstream)
+            self.check_setupdir_files(setuppath, test_file_content)
 
         # make a new branch in the test layer repo, change a file on that branch,
         # make a new commit, update the top level json config to refer to that branch,
@@ -353,6 +351,4 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             if c in ('gadget', 'gizmo'):
                 self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
-            with open(os.path.join(setuppath, 'config', "config-upstream.json")) as f:
-                config_upstream = json.load(f)
-            self.check_setupdir_files(setuppath, test_file_content, config_upstream)
+            self.check_setupdir_files(setuppath, test_file_content)
-- 
2.39.5


