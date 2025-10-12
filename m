Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9355CCD184
	for <webhook@archiver.kernel.org>; Sun, 12 Oct 2025 17:48:02 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web10.23233.1760291273818645235
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Oct 2025 10:47:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aLy1gOlT;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46e33b260b9so29214095e9.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760291272; x=1760896072; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FISmkO9FeciZ98yoOZxBq+8BdicIW74f+QMvrpaW6F0=;
        b=aLy1gOlTwG+JswbyEkdbsg5SLUT+KmxH/FDhTUDPjZ7ugRYrU+bYSY3FzLOB4hBH2u
         wE17JtS4z1gE55Wbn+t+QM5sS/LPT8xUCQ53e85pX1HE5yuqlOnJsvVryoQuD1Ae2QC6
         XXUoMprJ29NT/oAaalzIhfDpz+fkYFugBjk8NgKz4FWo9bRvjW8oHrZuAS312CRxqsnO
         fWm4A7xyF2YD3t2J3i2VZByIFx3XU7j5G/8j9Y7VJHALggRExMj4pZnQijIxMb+681Sm
         iIwQUnpnVcqQUPit43COqxMLhhoRjD3fp7aD8dKv4GpSZK5xFEfZ9CLpjUpoeAEtlinK
         0WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760291272; x=1760896072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FISmkO9FeciZ98yoOZxBq+8BdicIW74f+QMvrpaW6F0=;
        b=Idpge+AOd7z1Wcjr9GXNbjNPFYkNugkfwZr2hKklmTW6UI9wXyLwUbm7klI2Izewyp
         Qv9Xfpgp9SRrZHlnpeHOFzJO/cQSB3vlNnA9G0UFXho0TxPsg7upOJ87haS0j+/UCqpF
         T9KtlKHZyBfwAQ0I6RsPq3wWzmfgw4RkYsbDJ5wXfDMnnHt2taIIOIDVvGkOHPqY0u7y
         UaYJCdRa5y9B2lRCxK8CxdEedSG1cy1jRUeW8m48A1hmKYMFz9gjbW6xxtC3nAxDDKo6
         nceUZ6EEneY8zDhODxeq+b3+z85FvKdieC2yoqXOHAe68Zbu7pIaW2t+2dBB2JQbt2eG
         s81w==
X-Gm-Message-State: AOJu0Yyj+/Cnz8ZgvISNdZb/V/0Uemf75obgAs2SoYlsoDuBkgvioi/g
	Z9rDS8sTzuDnaoPCwVrUHnAKk39Va/MTN61j3oBYSh792oj+Q9JKgz5LQzEJhUHP
X-Gm-Gg: ASbGncvdWHhkqXtmqe+C6hS+n7MmIOMOykUht5jw/7ScLfM9FjsYXCSoj23HVXKXQI5
	fOFBGm2ZDG6PpF8D4Z5KzIIembghm9XGsfhyBvDBwy0bsfqFDYih82rG5Y+wW/mp7Hj+eMikfOC
	ZMRK8BjSdJZuqP2zULAVtUZ+apA7jyMx3lo9JUynTgVyMTtoDj/SicVvNVTIhhoHZYf5CF1mY9v
	58gVQCEojxr3T3qHcmlsSoxxNXQPxIp+N2Kcjgc2RoQHxQp456cwcESgbLJkcLgqfcOIrXSlS93
	33UC2rM1MH+0vQycsRSXr0E9/XavkseO722RU0QVFlwqH0p/90VA+JXyMZHFMaTNPpVzNBwFxT6
	SFuNPQr0b4u3QKyzQgIGbMmXYM6Z5+BvVT1I62TjMD8P9aIDvdsLaE2qtJa5AFF1STUuKdwiENW
	EwexqH6mFts2WOFJN/g9esJLdv9736gmfr+HKlyIv11uVbYeVSXaWn+IA7wf93u3Eq9VLi6eAku
	GB4Y+GE6EjZue9MAhtDIxoS+A==
X-Google-Smtp-Source: AGHT+IFPHSLTmxks3Va5zK4OT79Nl1SKJzcnsssft0Mj7khrXu5hJDa2AUnuJSRDXOLuvDEPP1GkOw==
X-Received: by 2002:a05:6000:607:b0:424:211a:4141 with SMTP id ffacd0b85a97d-4266e7c61a2mr13049078f8f.27.1760291271868;
        Sun, 12 Oct 2025 10:47:51 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce582abcsm14170160f8f.17.2025.10.12.10.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 10:47:51 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Johannes Schneider <johannes.schneider@leica-geosystems.com>
Subject: [PATCH 5/5] bitbake-setup: commandline: use subsubparser for settings {list,set,unset}
Date: Sun, 12 Oct 2025 19:47:27 +0200
Message-Id: <20251012174727.4191604-5-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251012174727.4191604-1-alex.kanavin@gmail.com>
References: <20251012174727.4191604-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 12 Oct 2025 17:48:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18179

From: Johannes Schneider <johannes.schneider@leica-geosystems.com>

Previously the sub-command 'settings' would take any number of
arguments and then silently do nothing if the number wasn't three.

The help text was also not clear about this, marking the positionals
separately as optional:

usage: bitbake-setup settings [-h] [--global] [--unset UNSET UNSET] [-l] [section] [key] [value]

The '--unset SECTION SETTING' also did not  integrate too well, as it
had its own positional arguments for section+setting.

For a bit more consistency and a explorable help, a sub-subparser is
added, that provides the commands:
  bitbake-setup settings list
  bitbake-setup settings set foo bar baz
  bitbake-setup settings unset foo bar
with a '--global' that is added from a stand-alone parent parser, so
that it shows up in all sub-command help texts.

The new help text now reads:
usage: bitbake-setup settings [-h] [--global] {list,set,unset} ...

and the respective sub commands:
usage: bitbake-setup settings list [-h] [--global]
usage: bitbake-setup settings set [-h] [--global] <section> <setting> <value>
usage: bitbake-setup settings unset [-h] [--global] <section> <setting>

Signed-off-by: Johannes Schneider <johannes.schneider@leica-geosystems.com>
---
 bin/bitbake-setup     | 50 +++++++++++++++++++++++++++----------------
 lib/bb/tests/setup.py | 20 ++++++++---------
 2 files changed, 41 insertions(+), 29 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 94e38b472..38bb8099f 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -670,22 +670,20 @@ def change_setting(top_dir, args):
         settings_path = default_settings_path(top_dir)
     settings = load_settings(settings_path)
 
-    if args.section and args.key and args.value:
+    if args.subcommand == 'set':
         if args.section not in settings.keys():
             settings[args.section] = {}
-        settings[args.section][args.key] = args.value
-        print("Setting '{}' in section '{}' is changed to '{}'".format(args.key, args.section, args.value))
-    if args.unset:
-        section = args.unset[0]
-        setting = args.unset[1]
-        if section in settings.keys() and setting in settings[section].keys():
-            del settings[section][setting]
-            print("Setting '{} in section '{}' is removed".format(setting, section))
+        settings[args.section][args.setting] = args.value
+        print(f"From section '{args.section}' the setting '{args.setting}' was changed to '{args.value}'")
+    if args.subcommand == 'unset':
+        if args.section in settings.keys() and args.setting in settings[args.section].keys():
+            del settings[args.section][args.setting]
+            print(f"From section '{args.section}' the setting '{args.setting}' has been removed")
 
     os.makedirs(os.path.dirname(settings_path), exist_ok=True)
     with open(settings_path, 'w') as settingsfile:
         settings.write(settingsfile)
-    print("New settings written to {}".format(settings_path))
+    print(f"Settings written to {settings_path}")
 
 def list_settings(all_settings):
     for section, section_settings in all_settings.items():
@@ -693,9 +691,9 @@ def list_settings(all_settings):
             print("{} {} {}".format(section, key, value))
 
 def settings_func(top_dir, all_settings, args):
-    if args.list:
+    if args.subcommand == 'list':
         list_settings(all_settings)
-    else:
+    elif args.subcommand == 'set' or args.subcommand == 'unset':
         change_setting(top_dir, args)
 
 def get_build_dir_via_bbpath():
@@ -784,15 +782,29 @@ def main():
     parser_install_buildtools.add_argument('--force', action='store_true', help='Force a reinstall of buildtools over the previous installation.')
     parser_install_buildtools.set_defaults(func=install_buildtools)
 
-    parser_settings = subparsers.add_parser('settings', help='List current settings, or set or unset a setting in a settings file (e.g. the default prefix and name of the top directory, the location of build configuration registry, downloads directory and other settings specific to a top directory)')
-    parser_settings.add_argument('section', nargs='?', help="Section in a settings file, typically 'default'")
-    parser_settings.add_argument('key', nargs='?', help="Name of the setting")
-    parser_settings.add_argument('value', nargs='?', help="Value of the setting")
-    parser_settings.add_argument('--global', action='store_true', help="Modify the setting in a global settings file, rather than one specific to a top directory")
-    parser_settings.add_argument('--unset', nargs=2, help="Unset a setting, e.g. 'bitbake-setup settings --unset default registry' would revert to the registry setting in a global settings file")
-    parser_settings.add_argument('-l' ,'--list', action='store_true', help="List all settings with their values")
+    parser_settings_arg_global = argparse.ArgumentParser(add_help=False)
+    parser_settings_arg_global.add_argument('--global', action='store_true', help="Modify the setting in a global settings file, rather than one specific to a top directory")
+
+    parser_settings = subparsers.add_parser('settings', parents=[parser_settings_arg_global],
+                                            help='List current settings, or set or unset a setting in a settings file (e.g. the default prefix and name of the top directory, the location of build configuration registry, downloads directory and other settings specific to a top directory)')
     parser_settings.set_defaults(func=settings_func)
 
+    subparser_settings = parser_settings.add_subparsers(dest="subcommand", required=True, help="The action to perform on the settings file")
+
+    parser_settings_list = subparser_settings.add_parser('list',
+                                                         help="List all settings with their values")
+
+    parser_settings_set = subparser_settings.add_parser('set', parents=[parser_settings_arg_global],
+                                                        help="In a Section, set a setting to a certain value")
+    parser_settings_set.add_argument("section", metavar="<section>", help="Section in a settings file, typically 'default'")
+    parser_settings_set.add_argument("setting", metavar="<setting>", help="Name of a setting")
+    parser_settings_set.add_argument("value", metavar="<value>", help="The setting value")
+
+    parser_settings_unset = subparser_settings.add_parser('unset', parents=[parser_settings_arg_global],
+                                                          help="Unset a setting, e.g. 'bitbake-setup settings unset default registry' would revert to the registry setting in a global settings file")
+    parser_settings_unset.add_argument("section", metavar="<section>", help="Section in a settings file, typically 'default'")
+    parser_settings_unset.add_argument("setting", metavar="<setting>", help="The setting to remove")
+
     args = parser.parse_args()
 
     logging.basicConfig(stream=sys.stdout)
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index b238926b2..e320cdf56 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -232,25 +232,25 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.runbbsetup("--help")
 
         # set up global location for top-dir-prefix
-        out = self.runbbsetup("settings --global default top-dir-prefix {}".format(self.tempdir))
+        out = self.runbbsetup("settings set --global default top-dir-prefix {}".format(self.tempdir))
         settings_path = "{}/global-config".format(self.tempdir)
         self.assertIn(settings_path, out[0])
-        self.assertIn("Setting 'top-dir-prefix' in section 'default' is changed to", out[0])
-        self.assertIn("New settings written to".format(settings_path), out[0])
-        out = self.runbbsetup("settings --global default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')))
-        self.assertIn("Setting 'dl-dir' in section 'default' is changed to", out[0])
-        self.assertIn("New settings written to".format(settings_path), out[0])
+        self.assertIn("From section 'default' the setting 'top-dir-prefix' was changed to", out[0])
+        self.assertIn("Settings written to".format(settings_path), out[0])
+        out = self.runbbsetup("settings set --global default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')))
+        self.assertIn("From section 'default' the setting 'dl-dir' was changed to", out[0])
+        self.assertIn("Settings written to".format(settings_path), out[0])
 
         # check that writing settings works and then adjust them to point to
         # test registry repo
-        out = self.runbbsetup("settings default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
+        out = self.runbbsetup("settings set default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
         settings_path = "{}/bitbake-builds/settings.conf".format(self.tempdir)
         self.assertIn(settings_path, out[0])
-        self.assertIn("Setting 'registry' in section 'default' is changed to", out[0])
-        self.assertIn("New settings written to".format(settings_path), out[0])
+        self.assertIn("From section 'default' the setting 'registry' was changed to", out[0])
+        self.assertIn("Settings written to".format(settings_path), out[0])
 
         # check that listing settings works
-        out = self.runbbsetup("settings --list")
+        out = self.runbbsetup("settings list")
         self.assertIn("default top-dir-prefix {}".format(self.tempdir), out[0])
         self.assertIn("default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')), out[0])
         self.assertIn("default registry {}".format('git://{};protocol=file;branch=master;rev=master'.format(self.registrypath)), out[0])
-- 
2.39.5


