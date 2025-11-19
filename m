Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01EECF34A9
	for <webhook@archiver.kernel.org>; Wed, 19 Nov 2025 12:48:46 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6073.1763556520175196145
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Nov 2025 04:48:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HmHnnDEh;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3720e58eso6118406f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 04:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763556518; x=1764161318; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTvNz0gGmBNOD5YZkVjkViZdra37V5neDdFmAT15jVk=;
        b=HmHnnDEhWsfgogBcwnPI1thVRfYTymXoL1aZc8aU2V7WzkDFObUzJJIbz1B1MAMkqj
         ln56XGfZSqhoQx70bDvtQTuCiOmaja/rQftmD6M/LMBRc0ccEF6qehxlMnJgs+A0Ai4P
         Qe7P5FRPRWcQBmJhZ9dDFCpzj118VUwfK57URbChuhirImsrNxNJ9Z7jXkMHfKHSqPb4
         ir9eSaoXnhTfImjgSlMSriu0mrwwSIBmH//H23AulAiRZacO7cIEmLRcpfxCLByMok+I
         aH3n5ZMhf7qpd3MLXVX1CLapUT1MWOCVCVtH2W3rp4cV9hmpCPQEdxnL7iinNfPRmuOQ
         AgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763556518; x=1764161318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTvNz0gGmBNOD5YZkVjkViZdra37V5neDdFmAT15jVk=;
        b=vQ7icWLy0pVkCiZ21ciyYsh6g9ayHLkXF4xXxBlpXGjbPYgHhpFlzKdeoSLs/uPcyn
         JaEtINEkAXkWcBYa4qTYczdjF6t71pGV3JQ/c0xKw7Y6DNjcs3y1IVO7Ymy/V55sqRoN
         fVytKiTXmlXN/4OEtSS5BRqLnSr+eIaxjyXj/3l1uwMwi+EWOsOL8KwlnXAeeVihu3W6
         bY6VqChUVw3fcIJSwijTFyMK8mYBGX1CzXuBCbuY1M6mUmm7M1HqmGmasWQ8xpATF/ai
         /w6c3VICgpcaNLnFtnQekm3OczJzSrRkqz08lC5JQO+MFq3e1FHDkSdnAM2Nlte87w37
         fSqA==
X-Gm-Message-State: AOJu0YxpipTxj+jW97cx+F7MpWPHesn0hPTfW0FnKKh0nUaUmqaMoAZ1
	srfu2G5fkOxEMxuqkdYawJ5cBvIm4ahpUmvJJU82yiKY7TMz8+nCq/Ht2pwFQw==
X-Gm-Gg: ASbGncvIOj42951uYCkvrM2B9QoXCddVxvi3IfVeyTR/KPVoAGHRpcjwKGVYCsBM9JT
	OBANu5MSB8NbmiQrxRZHVG2F1KYvPu+hDWMQwt/rdpJhw8W0LffD4dMFBqBu6MOnNL1gOYr5XmO
	OEoAT0kCAwMxutYdJci3kdCW65YlRane1P53UioVwm1/w9IiUH2nXLbMWZ+hK+lZd2Du0sX4Jfc
	eZDzBBTlIPAmdyVVWigt2sIRc37aPmEKgI1b4rpryXbhV++9wzg69Tts75WIREWQ7mzz30yX86D
	kPeKQxyOxwtaZ5s9InWnCydH8wgqAHaei+sWZpB4sabcyAWM8PBMfyAk7oG9btaxd/5OybP2Or1
	9NioZtUbWde18bo7dXX9uS2zw9HEO7UU8uXKxDyu8ZKmoB5hf/G3+SohoYmrWzsJ6DZeu82v7N/
	W1iKo8fUkUvuTQ834A0/AArrheKxvD/5uRUwoRvk44H6xGUOJwxuJngIDL1A==
X-Google-Smtp-Source: AGHT+IFFmbGDnri9jf8h6ao1axEI5SpC3UsPYFZw8w7bAiy61OxQUyIbk3Hy2e+GFABZQFFl1FdGmg==
X-Received: by 2002:a05:6000:3110:b0:42b:394a:9e3 with SMTP id ffacd0b85a97d-42b593821d8mr17838607f8f.38.1763556518346;
        Wed, 19 Nov 2025 04:48:38 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e846afsm36953267f8f.13.2025.11.19.04.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:48:37 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: "Joshua Watt via lists.openembedded.org" <JPEWhacker=gmail.com@lists.openembedded.org>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/3] bitbake-setup: Allow setup-dir-name to be specified in JSON (and use that in the default registry)
Date: Wed, 19 Nov 2025 13:48:31 +0100
Message-Id: <20251119124832.3906214-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119124832.3906214-1-alex.kanavin@gmail.com>
References: <20251119124832.3906214-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Nov 2025 12:48:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18456

From: "Joshua Watt via lists.openembedded.org" <JPEWhacker=gmail.com@lists.openembedded.org>

Enables the JSON file to specify the preferred name of the setup
directory with a 'setup-dir-name' key. This key can have variable
expansions in the same format as python string.Template strings (which
matches the shell variable expansion rules).

Variables that can be expanded are any fragment configuration prompted
by the user (e.g. the keys in "oe-fragments-one-of"), or "$name" to use
the name of the configuration (e.g. the .conf.json file).

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

default-registry: Change default setup dir

Uses the template mechanism to provide shorter setup-dir names by
default. Specifically, the machine names are no longer part of the setup
path since they are intended to be changed without needing a new setup
directory.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>

Further tweaks by Alex:
- $name support is not actually implemented (as far as I see)
- add fallbacks to the full name if the short name already exists in the filesystem
or there's a setting that forces full names
- add documentation for the setup dir entry in configs and the setting to ignore it
- adjust the schema
- adjust the selftest to include the feature and test for it

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup                             | 16 ++++++++
 .../configurations/oe-nodistro.conf.json      |  1 +
 .../configurations/poky-master.conf.json      |  1 +
 .../bitbake-user-manual-environment-setup.rst | 39 +++++++++++++++++++
 lib/bb/tests/setup.py                         | 15 ++++---
 setup-schema/bitbake-setup.schema.json        |  4 ++
 6 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index cbcd637b2..b331eac53 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -19,6 +19,7 @@ import copy
 import textwrap
 import signal
 import functools
+import string
 
 default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
 
@@ -492,6 +493,20 @@ def init_config(top_dir, settings, args):
         setup_dir_name = args.setup_dir_name
     else:
         setup_dir_name = "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_"))
+        if 'setup-dir-name' in upstream_config['bitbake-config']:
+            mapping = {
+                    k: v.replace(" ", "-").replace("/", "_")
+                    for k, v in upstream_config['bitbake-config']['oe-fragment-choices'].items()
+            }
+            config_setup_dir_name = string.Template(upstream_config['bitbake-config']['setup-dir-name']).substitute(mapping)
+            config_setup_dir = os.path.join(top_dir, config_setup_dir_name)
+            if os.path.exists(config_setup_dir):
+                print("Setup directory {} (as suggested by configuration) already exists, using the full name instead.\n".format(config_setup_dir))
+            elif settings['default']['use-full-setup-dir-name'] != 'no':
+                print("Using the full setup directory name instead of {} suggested by configuration, as set in the settings.\n".format(config_setup_dir))
+            else:
+                setup_dir_name = config_setup_dir_name
+
         if not args.non_interactive:
             n = input(f"Enter setup directory name: [{setup_dir_name}] ")
             if n:
@@ -935,6 +950,7 @@ def main():
                          'top-dir-prefix':os.getcwd(),
                          'top-dir-name':'bitbake-builds',
                          'registry':default_registry,
+                         'use-full-setup-dir-name':'no',
                          }
 
         global_settings = load_settings(global_settings_path(args))
diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro.conf.json
index 9cd11a218..70ae6d364 100644
--- a/default-registry/configurations/oe-nodistro.conf.json
+++ b/default-registry/configurations/oe-nodistro.conf.json
@@ -40,6 +40,7 @@
         {
             "name": "nodistro",
             "description": "OpenEmbedded 'nodistro'",
+            "setup-dir-name": "oe-nodistro",
             "bb-layers": ["openembedded-core/meta"],
             "oe-fragments-one-of": {
                 "machine": {
diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 9b63ea5f0..81e0e47f0 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -50,6 +50,7 @@
         "configurations": [
         {
             "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
+            "setup-dir-name": "poky-master-$distro",
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index dd8d08877..8a90e33e8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -504,6 +504,7 @@ A valid settings file would for example be:
    top-dir-name = bitbake-builds
    registry = /path/to/bitbake/default-registry
    dl-dir = /path/to/bitbake-setup-downloads
+   use-full-setup-dir-name = yes
 
 Settings and their values can be listed and modified with the ``bitbake-setup
 settings`` command. See the :ref:`ref-bbsetup-command-settings` section for
@@ -597,6 +598,17 @@ BitBake builds, so that there is a single directory containing a copy of
 everything needed to set up and run a BitBake build offline in a reproducible
 manner.
 
+.. _ref-bbsetup-setting-use-full-setup-dir-name:
+
+``use-full-setup-dir-name``
+---------------------------
+
+The :ref:`ref-bbsetup-setting-use-full-setup-dir-name` setting, if set to ``yes``
+will override the suggestions for the :term:`Setup` directory name made by
+``setup-dir-name`` entries in :term:`Generic Configuration` files. This
+will make the directory names longer, but fully specific: they will contain
+all selections made during initialization.
+
 .. _ref-bbsetup-section-config-reference:
 
 Generic Configuration Files Reference
@@ -802,6 +814,33 @@ They contain the following sections:
       See https://docs.yoctoproject.org/dev/ref-manual/fragments.html for
       more information of OpenEmbedded configuration fragments.
 
+   -  ``setup-dir-name`` (*optional*): a suggestion for the :term:`Setup`
+      directory name. Bitbake-setup will use it, unless it already exists, or
+      the :ref:`ref-bbsetup-setting-use-full-setup-dir-name` setting is set
+      to ``yes`` (in those cases, it will fall back to the built-in full name,
+      containing the full set of choices made during initialization).
+
+      This key can have variable expansions in the same format as python
+      string.Template strings (which matches the shell variable expansion rules):
+      https://docs.python.org/3/library/string.html#template-strings-strings .
+
+      Variables that can be expanded are any fragment configuration prompted
+      by the user (e.g. the keys in "oe-fragments-one-of")::
+
+            {
+                ...
+                "oe-fragments-one-of": {
+                    "machine": {
+                        "description": "Target machines",
+                        "options" : ["machine/gadget", "machine/gizmo"]
+                    }
+                },
+                "setup-dir-name": "somebuild-$machine"
+                ...
+            }
+
+      would expand to ``somebuild-machine_gadget``.
+
 Generic Configuration Examples
 ------------------------------
 
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 27b9f288a..8b6d8bce6 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -118,7 +118,8 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 "name": "gizmo",
                 "description": "Gizmo configuration",
                 "oe-template": "test-configuration-gizmo",
-                "oe-fragments": ["test-fragment-2"]
+                "oe-fragments": ["test-fragment-2"],
+                "setup-dir-name": "this-is-a-custom-gizmo-build"
             },
             {
                 "name": "gizmo-env-passthrough",
@@ -227,6 +228,10 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             self.assertTrue('BUILD_SERVER' in init_build_env)
             # a more throrough test could be to initialize a bitbake build-env, export FOO to the shell environment, set the env-passthrough on it and finally check against 'bitbake-getvar FOO'
 
+    def get_setup_path(self, cf, c):
+        if c == 'gizmo':
+            return os.path.join(self.tempdir, 'bitbake-builds', 'this-is-a-custom-gizmo-build')
+        return os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
 
     def test_setup(self):
         # unset BBPATH to ensure tests run in isolation from the existing bitbake environment
@@ -307,7 +312,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         for cf, v in test_configurations.items():
             for c in v['buildconfigs']:
                 out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
-                setuppath = os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
+                setuppath = self.get_setup_path(cf, c)
                 self.check_setupdir_files(setuppath, test_file_content)
                 os.environ['BBPATH'] = os.path.join(setuppath, 'build')
                 out = self.runbbsetup("status")
@@ -329,7 +334,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                   'gizmo-env-passthrough',
                   'gizmo-no-fragment',
                   'gadget-notemplate', 'gizmo-notemplate'):
-            setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
+            setuppath = self.get_setup_path('test-config-1', c)
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             out = self.runbbsetup("status")
             self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, setuppath), out[0])
@@ -352,7 +357,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                   'gizmo-env-passthrough',
                   'gizmo-no-fragment',
                   'gadget-notemplate', 'gizmo-notemplate'):
-            setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
+            setuppath = self.get_setup_path('test-config-1', c)
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             out = self.runbbsetup("status")
             self.assertIn("Configuration in {} has changed:".format(setuppath), out[0])
@@ -385,7 +390,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                   'gizmo-env-passthrough',
                   'gizmo-no-fragment',
                   'gadget-notemplate', 'gizmo-notemplate'):
-            setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
+            setuppath = self.get_setup_path('test-config-1', c)
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             # write something in local.conf and bblayers.conf
             for f in ["local.conf", "bblayers.conf"]:
diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 7030f1d6d..027ba2568 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -96,6 +96,10 @@
                                 "items": {
                                     "type": "string"
                                 }
+                            },
+                            "setup-dir-name": {
+                                "type": "string",
+                                "description": "A suggestion for the setup directory name, $-prefixed keys from oe-fragments-one-of will be substituted with user selections."
                             }
                         },
                         "additionalProperties": false
-- 
2.39.5


