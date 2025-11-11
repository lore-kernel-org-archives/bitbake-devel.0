Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A0BCCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 22:34:16 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2189.1762900451995843069
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 14:34:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=e0MWdweq;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1329275-202511112234097da364ea5000020762-b2_ntq@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202511112234097da364ea5000020762
        for <bitbake-devel@lists.openembedded.org>;
        Tue, 11 Nov 2025 23:34:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ES+bEz1PbcC5lUICjYP1YT2x/09vZQa8l6BnM8S8obU=;
 b=e0MWdweq36CuSYxkLcdp16t991IV045rYYUSCWzbIv/4dhx1qi4wD5mSI3Qz6Xh2QdjJd5
 sZtivowkOzpaPwkrlhbC5iCOuV5swuRwfkqt7Y3JzRXdR3866dlV+OALqseNjebd1UzbOg5k
 k5Xgaig1xaj/0QSFlv09tFkMDYDg8tkbLVykQTwkOnLf9Si3ggW7Hz3s6pTFrhgIeXODsl3B
 kaTFxz15jxjt0f1bfpTCet9pJQwv7zzRMNYjj7GW5Eg+bM9fe7plXFFiSRX9b+U7zMbkBs2w
 k1Q/EGhPCQX1zEfid24toS3+b7TTNZqsLIirIHdGnDL04ImR0kSD2V4Q==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 3/3] bitbake-setup: default top-dir to empty string
Date: Tue, 11 Nov 2025 23:33:25 +0100
Message-ID: <20251111223325.2034322-3-adrian.freihofer@siemens.com>
In-Reply-To: <20251111223325.2034322-1-adrian.freihofer@siemens.com>
References: <20251111223325.2034322-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 22:34:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18339

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Change the default for top-dir to be an empty string instead of
"bitbake-builds". This makes the build directory be created directly
under the specified top-dir-prefix (which defaults to the current working
directory).

This allows to do:
    mkdir -p ~/temp/bb-test
    cd ~/temp/bb-test
    bitbake-setup init
      ...
      setup-dir = poky-altcfg

ending up with the build directory at:
  ~/temp/bb-test/poky-altcfg/build

bitbake-selftest: improve tests for top-dir-name setting

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup     |  2 +-
 lib/bb/tests/setup.py | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index bda62f5f4..5a0ad599a 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -871,7 +871,7 @@ def main():
         builtin_settings = {}
         builtin_settings['default'] = {
                          'top-dir-prefix':os.getcwd(),
-                         'top-dir-name':'bitbake-builds',
+                         'top-dir-name':'',
                          'registry':default_registry,
                          }
 
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index d761ee734..85bb33db4 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -233,22 +233,28 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         if 'BBPATH' in os.environ:
             del os.environ['BBPATH']
 
+        TOP_DIR_NAME = 'bitbake-builds'
+
         # check that no arguments works
         self.runbbsetup("")
 
         # check that --help works
         self.runbbsetup("--help")
 
-        # check that the default top-dir-prefix is cwd before any settings are configured
+        # check that the default top-dir-prefix is cwd and top-dir-name is empty before any settings are configured
         out = self.runbbsetup("settings list")
         self.assertIn("default top-dir-prefix {}".format(os.getcwd()), out[0])
+        self.assertIn("default top-dir-name", out[0])
 
-        # set up global location for top-dir-prefix
+        # set up global location for top-dir-prefix and top-dir-name
         out = self.runbbsetup("settings set --global default top-dir-prefix {}".format(self.tempdir))
         settings_path = "{}/global-config".format(self.tempdir)
         self.assertIn(settings_path, out[0])
         self.assertIn("From section 'default' the setting 'top-dir-prefix' was changed to", out[0])
         self.assertIn("Settings written to".format(settings_path), out[0])
+        out = self.runbbsetup('settings set --global default top-dir-name "{}"'.format(TOP_DIR_NAME))
+        self.assertIn("From section 'default' the setting 'top-dir-name' was changed to '{}'".format(TOP_DIR_NAME), out[0])
+        self.assertIn("Settings written to".format(settings_path), out[0])
         out = self.runbbsetup("settings set --global default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')))
         self.assertIn("From section 'default' the setting 'dl-dir' was changed to", out[0])
         self.assertIn("Settings written to".format(settings_path), out[0])
@@ -256,7 +262,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         # check that writing settings works and then adjust them to point to
         # test registry repo
         out = self.runbbsetup("settings set default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
-        settings_path = "{}/bitbake-builds/settings.conf".format(self.tempdir)
+        settings_path = os.path.join(self.tempdir, TOP_DIR_NAME, "settings.conf")
         self.assertIn(settings_path, out[0])
         self.assertIn("From section 'default' the setting 'registry' was changed to", out[0])
         self.assertIn("Settings written to".format(settings_path), out[0])
@@ -264,6 +270,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         # check that listing settings works
         out = self.runbbsetup("settings list")
         self.assertIn("default top-dir-prefix {}".format(self.tempdir), out[0])
+        self.assertIn("default top-dir-name {}".format(TOP_DIR_NAME), out[0])
         self.assertIn("default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')), out[0])
         self.assertIn("default registry {}".format('git://{};protocol=file;branch=master;rev=master'.format(self.registrypath)), out[0])
 
@@ -307,7 +314,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         for cf, v in test_configurations.items():
             for c in v['buildconfigs']:
                 out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
-                setuppath = os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
+                setuppath = os.path.join(self.tempdir, TOP_DIR_NAME, '{}-{}'.format(cf, c))
                 self.check_setupdir_files(setuppath, test_file_content)
                 os.environ['BBPATH'] = os.path.join(setuppath, 'build')
                 out = self.runbbsetup("status")
@@ -329,7 +336,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                   'gizmo-env-passthrough',
                   'gizmo-no-fragment',
                   'gadget-notemplate', 'gizmo-notemplate'):
-            setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
+            setuppath = os.path.join(self.tempdir, TOP_DIR_NAME, 'test-config-1-{}'.format(c))
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             out = self.runbbsetup("status")
             self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, setuppath), out[0])
@@ -352,7 +359,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                   'gizmo-env-passthrough',
                   'gizmo-no-fragment',
                   'gadget-notemplate', 'gizmo-notemplate'):
-            setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
+            setuppath = os.path.join(self.tempdir, TOP_DIR_NAME, 'test-config-1-{}'.format(c))
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             out = self.runbbsetup("status")
             self.assertIn("Configuration in {} has changed:".format(setuppath), out[0])
-- 
2.51.1


