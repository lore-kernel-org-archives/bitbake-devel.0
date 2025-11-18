Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B6ECEBF93
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 08:20:28 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7954.1763454014596627011
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Nov 2025 00:20:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=nUtrUBs0;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0C2C54E4175C
	for <bitbake-devel@lists.openembedded.org>; Tue, 18 Nov 2025 08:20:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D678D606FE;
	Tue, 18 Nov 2025 08:20:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F01510371D04;
	Tue, 18 Nov 2025 09:20:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763454012; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=k7AgIDryM2vpDhuu/cRNNylx08i9NjKz7r3jxeqjz/M=;
	b=nUtrUBs04POPPhOyUsnYLcrhi+Q1T1xMENwPFL0pFM0g0nTV60eTG1/k1Gw846GqwMXW4V
	S725rOVVCcPan8DLNjbwpmXr+t4o9GzLt2+plUWya7nZPcpyQuQ18f4SOeyPma2s0JSOGe
	MdrzuR4ZnqUbMlF5VsVOped0ws8MmbhRjARupk5bz+EAWG6J29d/RR4JYZ9pnMJ+lQLAvJ
	MDvAdhIc/kztXiqS2DJ2lzIUDgl6oDGWe6m+WUrYV3AnghBbqh9FOh902PryfqYqPv5nYG
	fuyTFL4n5yy9fwkeDLiuR5JfKCONFW5A957zgrIc2aGdVqmDeoW4Ee8ikq+UzA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 18 Nov 2025 09:19:56 +0100
Subject: [PATCH v4 1/2] bitbake-setup: update: add a --update-bb-conf
 option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-bitbake-setup-conf-updates-v4-1-7336b663bca6@bootlin.com>
References: <20251118-bitbake-setup-conf-updates-v4-0-7336b663bca6@bootlin.com>
In-Reply-To: <20251118-bitbake-setup-conf-updates-v4-0-7336b663bca6@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10974;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=v33njoml6UR3nxBaUxwXYwbxcF/CNNcEemqVQLdopew=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpHCw6H6h19GBdWLzWdHQZYkNDzl82bEeYuBRD4
 FDLT7vfQIGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRwsOgAKCRDRgEFAKaOo
 Nu9lEADApFqG6diN1Oo7eJ7fg0XLEac9S2TkeB7X6unpRFYCeD+iN1ZlB4gq3agpyFh3SU9bnoG
 BjAtBQRQhjYDQrVV8+VtQUTw2j2WQpMLB0FSO7OGu3U93XRR9JDK1FKbkdtP6GQXafm0Bs38tjJ
 LLr8H2Iz0RCvFZOV3i3V8Ucv/7HtK1qofeV0JNEiQNhFeDBp41lIkbE4UQizeUuV7O71GDuIW/t
 TmU6ReGUw7Y57m69isXdbqecZKxJYtDlQLQ5XdBxpE0sNKKtyIAKboQKJhvqHNu+AAhKu072EM9
 4kWFr8smX/+mwNl8drjiEJO+OLeVK2geRf/ex1Xf5JWhO7q9915VhFe7arwZ8R8mFB10k+Z0sry
 imgdt8aNnw6Uzuo8+7P0l7EN7nCm6NGZXsdz9YeoTBuRJncq/rV2SdzbhkMhWgQ23Dz2yeH6EHX
 JrfTXXYkgtrE/KjjAiFSiJIa/89phFH3TkPr7gHesvCjjj+GjI7qWhyBnn+N6DAVQB5WCChY7DJ
 vNkxcqgF7zDEjwv9pc/89f1ybUGChzpgQ+SjjOvDZXvlxeY6F/8OcIrcDEC5cuFUGCFMnmIv5fh
 IStCUwEnw2r3+ZCVgpZa/wvNuh1u6RQaVPpvvQ44V8TqQghu226lgn2dm3p7FoVVfzqfHCZqYH6
 sTZPLXn1YxCsq/A==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Nov 2025 08:20:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18444

Add a --update-bb-conf option that can be used to choose whether to
update the BitBake configuration files (local.conf, bblayers.conf, etc.)
in the conf/ directory.

The argument can take up to three values:

-  ``prompt`` (default): ask the user whether to update.
-  ``yes``: update the configuration files.
-  ``no``: don't update the configuration files.

A diff is printed when changes in configuration are detected.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup                                  | 53 ++++++++++++++++------
 .../bitbake-user-manual-environment-setup.rst      |  8 ++++
 lib/bb/tests/setup.py                              |  6 +--
 3 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index d0a932a6b2..ca2422b1ce 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -134,7 +134,7 @@ def checkout_layers(layers, layerdir, d):
 
     return layers_fixed_revisions
 
-def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
+def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf):
     def _setup_build_conf(layers, filerelative_layers, build_conf_dir):
         os.makedirs(build_conf_dir)
         layers_s = []
@@ -224,9 +224,13 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
         raise Exception("Cannot complete setting up a bitbake build directory from OpenEmbedded template '{}' as oe-setup-build was not found in any layers; please use oe-init-build-env manually.".format(template))
 
     bitbake_confdir = os.path.join(bitbake_builddir, 'conf')
-    backup_bitbake_confdir = bitbake_confdir + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
+    timestamp = time.strftime("%Y%m%d%H%M%S")
+    backup_bitbake_confdir = os.path.join(bitbake_builddir, 'conf-backup.{}'.format(timestamp))
+    upstream_bitbake_confdir = os.path.join(bitbake_builddir, 'conf-upstream.{}'.format(timestamp))
+
     if os.path.exists(bitbake_confdir):
         os.rename(bitbake_confdir, backup_bitbake_confdir)
+        print("Existing bitbake configuration directory renamed to {}".format(backup_bitbake_confdir))
 
     if layers:
         filerelative_layers = bitbake_config.get("bb-layers-file-relative") or []
@@ -257,16 +261,32 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
         bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
 
     if os.path.exists(backup_bitbake_confdir):
-        bitbake_config_diff = get_diff(backup_bitbake_confdir, bitbake_confdir)
-        if bitbake_config_diff:
-            print("Existing bitbake configuration directory renamed to {}".format(backup_bitbake_confdir))
-            print("The bitbake configuration has changed:")
-            print(bitbake_config_diff)
-        else:
-            shutil.rmtree(backup_bitbake_confdir)
+        conf_diff = get_diff(backup_bitbake_confdir, bitbake_confdir)
+        if not conf_diff:
+            print('New bitbake configuration from upstream is the same as the current one, no need to update it.')
+            shutil.rmtree(bitbake_confdir)
+            os.rename(backup_bitbake_confdir, bitbake_confdir)
+            return
 
-    print("This bitbake configuration provides:\n    {}\n".format(bitbake_config["description"]))
+        print('Upstream bitbake configuration changes were found:')
+        print(conf_diff)
+
+        if update_bb_conf == 'prompt':
+            y_or_n = input('Apply these changes to the current configuration? (y/N): ')
+            if y_or_n != 'y':
+                update_bb_conf = 'no'
+
+        if update_bb_conf == 'no':
+            print('Ignoring upstream bitbake configuration changes')
+            print(f'Leaving the upstream configuration in {upstream_bitbake_confdir}')
+            os.rename(bitbake_confdir, upstream_bitbake_confdir)
+            os.rename(backup_bitbake_confdir, bitbake_confdir)
+            return
 
+        print('Applying upstream bitbake configuration changes')
+        print(f'Leaving the previous configuration in {backup_bitbake_confdir}')
+
+    print("This bitbake configuration provides:\n    {}\n".format(bitbake_config["description"]))
     readme = """{}\n\nAdditional information is in {} and {}\n
 Source the environment using '. {}' to run builds from the command line.
 The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf
@@ -291,7 +311,7 @@ def get_registry_config(registry_path, id):
                 return os.path.join(root, f)
     raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
 
-def update_build(config, confdir, setupdir, layerdir, d):
+def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"):
     layer_config = copy.deepcopy(config["data"]["sources"])
     layer_overrides = config["source-overrides"]["sources"]
     for k,v in layer_overrides.items():
@@ -300,7 +320,7 @@ def update_build(config, confdir, setupdir, layerdir, d):
     sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
-    setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir)
+    setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
     write_sources_fixed_revisions(confdir, sources_fixed_revisions)
 
 def int_input(allowed_values):
@@ -506,7 +526,7 @@ def init_config(top_dir, settings, args):
     bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
 
     write_upstream_config(confdir, upstream_config)
-    update_build(upstream_config, confdir, setupdir, layerdir, d)
+    update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes")
     commit_config(confdir)
 
     bb.event.remove("bb.build.TaskProgress", None)
@@ -569,14 +589,16 @@ def build_status(top_dir, settings, args, d, update=False):
         print('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
         if update:
             commit_config(confdir)
-            update_build(new_upstream_config, confdir, setupdir, layerdir, d)
+            update_build(new_upstream_config, confdir, setupdir, layerdir, d,
+                         update_bb_conf=args.update_bb_conf)
         else:
             bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
         return
 
     if are_layers_changed(current_upstream_config["data"]["sources"], layerdir, d):
         if update:
-            update_build(current_upstream_config, confdir, setupdir, layerdir, d)
+            update_build(current_upstream_config, confdir, setupdir, layerdir,
+                         d, update_bb_conf=args.update_bb_conf)
         return
 
     print("\nConfiguration in {} has not changed.".format(setupdir))
@@ -836,6 +858,7 @@ def main():
 
     parser_update = subparsers.add_parser('update', help='Update a setup to be in sync with configuration')
     add_setup_dir_arg(parser_update)
+    parser_update.add_argument('--update-bb-conf', choices=['prompt', 'yes', 'no'], default='prompt', help='Update bitbake configuration files (bblayers.conf, local.conf) (default: prompt)')
     parser_update.set_defaults(func=build_update)
 
     parser_install_buildtools = subparsers.add_parser('install-buildtools', help='Install buildtools which can help fulfil missing or incorrect dependencies on the host machine')
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 3193952972..dd8d08877f 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -401,6 +401,14 @@ status of the :term:`Setup` before updating it.
 
 In addition, the command can take the following arguments:
 
+-  ``--update-bb-conf``: whether to update the :term:`BitBake Build`
+   configuration (``local.conf``, ``bblayers.conf``, etc.). This argument can
+   take up to three values:
+
+   -  ``prompt`` (default): ask the user whether to update.
+   -  ``yes``: update the configuration files.
+   -  ``no``: don't update the configuration files.
+
 -  ``--setup-dir``: path to the :term:`Setup` to update. Not required if the
    command is invoked from an initialized BitBake environment that contains
    :term:`BBPATH`.
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 73ba3b2bc8..18b560b93d 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -311,7 +311,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 os.environ['BBPATH'] = os.path.join(setuppath, 'build')
                 out = self.runbbsetup("status")
                 self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
-                out = self.runbbsetup("update")
+                out = self.runbbsetup("update --update-bb-conf='yes'")
                 self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
 
         # install buildtools
@@ -332,7 +332,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             out = self.runbbsetup("status")
             self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, setuppath), out[0])
-            out = self.runbbsetup("update")
+            out = self.runbbsetup("update --update-bb-conf='yes'")
             if c in ('gadget', 'gizmo'):
                 self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
@@ -356,7 +356,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             out = self.runbbsetup("status")
             self.assertIn("Configuration in {} has changed:".format(setuppath), out[0])
             self.assertIn('-                    "rev": "master"\n+                    "rev": "another-branch"', out[0])
-            out = self.runbbsetup("update")
+            out = self.runbbsetup("update --update-bb-conf='yes'")
             if c in ('gadget', 'gizmo'):
                 self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])

-- 
2.51.0


