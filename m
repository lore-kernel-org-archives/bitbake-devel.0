Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A80CEBF9A
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 08:21:21 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4954.1763367676687775387
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 00:21:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=f55kMxsz;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 98055C1264F;
	Mon, 17 Nov 2025 08:20:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8BE0F606B9;
	Mon, 17 Nov 2025 08:21:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1E3810371CF0;
	Mon, 17 Nov 2025 09:21:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763367674; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rwdaKdjOa90+qsbBrHxt4jS4GKG1d9CoxQV+gpy7MK4=;
	b=f55kMxszeLMuKNYApZa7mh5bUZKGV328m40i5MR0ZwNs/X19NK9sCxuElcE1EmBZex67ta
	nJz+6RSRWUvGP6SrULwacSVDqYqvFpk5vrDhXszdq8DB0R3zsbWp81/G9W3OmLv7G4KCeU
	RfSztjgf7IKOC3ZaafT4vKYPX4MklFZudIDMUO4dlKuQPxvLZISRuPou8C7Td/omgKAUGs
	KOW0oPjbYOM9j9E2wAGABdd1yoVHK/oxlqJUm4NTOGNul3+U46j5GECxsss37J7+zftWLp
	Ae9LLamvqYzkHTq/QOk6spYMSOGP51ugogK5lpyDzOPCE8spbjluTWoWGGqJ3A==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 17 Nov 2025 09:21:08 +0100
Subject: [PATCH v2 1/2] bitbake-setup: update: add a --update-bb-conf
 option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-bitbake-setup-conf-updates-v2-1-209637e01fbe@bootlin.com>
References: <20251117-bitbake-setup-conf-updates-v2-0-209637e01fbe@bootlin.com>
In-Reply-To: <20251117-bitbake-setup-conf-updates-v2-0-209637e01fbe@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13801;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=5ajRV4DP7dzeJyiingr06Z1F6w2azYFRVra3C6U5mEw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpGtr3lSEkXuieB8GqexYBY8D0DM2WxNmzAmS0q
 LpKod8R5PqJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRra9wAKCRDRgEFAKaOo
 NiD7EADHF/OsppYWFXB79asTOqiE9AfrUTm1fFNinsCaF4WHJ190sSm7VtMSljSAkSj3FAG8yRl
 H0esRaEqhtPtQG3tDcuXJsS+DGV/HGKWBK1uiFFidrY7i6Cx8mFpj3mi57nogc0cRnwL9pWvPoZ
 LnT5vAs2x1dl0AvIq2N4bjHlBZDLxZLD9Z9wsCuqOfl3AJ8MyCJ9I7K8rMmwm97FIMIT1fehQuU
 iTM4aaUj9PHB0NiLtOJLUX8lt4KrgmLJvkI3uKhnEGx8MDqNSCEo4Xd17nr94pBj2NhL0E+9vC0
 BX5lPfKLh8t4uT0wJ8aPcNfFEviOFKhYC/d6jXWFqgUdo+ZvPTsbmugo8Uxl8C1FMOs12R9q/v1
 vxGDbvXV2FBDy26NP5mIigGK/OLOHej2hP1ytD14Qb75TM/ZxLdbYQZkBNy+zHKHj2/HXLrIEvQ
 PITL9i9M0CuY9Zh89UyJUgOfDEMgsYnmzIjA3U/DyBtIpCxixhcf0Na/VQMV28vrznbqFBGTe9G
 GrCZKfT0jIb8j28KLP5nyXCzmKEw47l7jnkM1mgPbbS9zNylKmVJ9MsOWpJuN/c+4inGmpgiML4
 5K8umDLrGFttrSHa2ci5S+2CtjIXmrH+ekA6SK7G4FnIKMwTiLvWPBq45Xx/OWVwDwnNhAaUxWz
 dMHCdjTUpFRD/dA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 08:21:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18421

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
 bin/bitbake-setup                                  | 98 ++++++++++++++--------
 .../bitbake-user-manual-environment-setup.rst      |  8 ++
 lib/bb/tests/setup.py                              |  6 +-
 3 files changed, 74 insertions(+), 38 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index d0a932a6b2..d9cd632d1a 100755
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
@@ -256,33 +260,56 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
     if fragments:
         bb.process.run("{} -c '. {} && bitbake-config-build enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
 
+    conf_diff = None
     if os.path.exists(backup_bitbake_confdir):
-        bitbake_config_diff = get_diff(backup_bitbake_confdir, bitbake_confdir)
-        if bitbake_config_diff:
-            print("Existing bitbake configuration directory renamed to {}".format(backup_bitbake_confdir))
-            print("The bitbake configuration has changed:")
-            print(bitbake_config_diff)
-        else:
-            shutil.rmtree(backup_bitbake_confdir)
-
-    print("This bitbake configuration provides:\n    {}\n".format(bitbake_config["description"]))
-
-    readme = """{}\n\nAdditional information is in {} and {}\n
-Source the environment using '. {}' to run builds from the command line.
-The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf
-""".format(
-        bitbake_config["description"],
-        os.path.join(bitbake_builddir,'conf/conf-summary.txt'),
-        os.path.join(bitbake_builddir,'conf/conf-notes.txt'),
-        init_script,
-        bitbake_builddir
-        )
-    readme_file = os.path.join(bitbake_builddir, "README")
-    with open(readme_file, 'w') as f:
-        f.write(readme)
-    print("Usage instructions and additional information are in\n     {}\n".format(readme_file))
-    print("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
-    print("To run builds, source the environment using\n    . {}".format(init_script))
+        try:
+            conf_diff = bb.process.run(f'git diff --no-index "{backup_bitbake_confdir}" "{bitbake_confdir}"')[0]
+        except bb.process.ExecutionError as e:
+            if e.exitcode == 1:
+                conf_diff = e.stdout
+            else:
+                raise e
+
+    _extra_msg_info = " (--update-bb-conf=yes)"
+    if update_bb_conf == "no":
+        print('Ignoring upstream bitbake configuration changes (--update-bb-conf=no)')
+        print(f'Leaving the upstream configuration in {upstream_bitbake_confdir}')
+        os.rename(bitbake_confdir, upstream_bitbake_confdir)
+        os.rename(backup_bitbake_confdir, bitbake_confdir)
+    elif conf_diff:
+        print('Upstream bitbake configuration changes were found:')
+        print(conf_diff)
+        if update_bb_conf == "prompt":
+            y_or_n = input('Apply these changes to the current configuration? (y/N): ')
+            if y_or_n == 'y':
+                update_bb_conf = 'yes'
+                _extra_msg_info = ""
+                print(f'Leaving the previous configuration in {backup_bitbake_confdir}')
+            else:
+                print(f'Leaving the upstream configuration in {upstream_bitbake_confdir}')
+                os.rename(bitbake_confdir, upstream_bitbake_confdir)
+                os.rename(backup_bitbake_confdir, bitbake_confdir)
+
+    if update_bb_conf == "yes":
+        print(f"Applying upstream bitbake configuration changes{_extra_msg_info}")
+        print("This new bitbake configuration provides:\n    {}\n".format(bitbake_config["description"]))
+
+        readme = """{}\n\nAdditional information is in {} and {}\n
+    Source the environment using '. {}' to run builds from the command line.
+    The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf
+    """.format(
+            bitbake_config["description"],
+            os.path.join(bitbake_builddir,'conf/conf-summary.txt'),
+            os.path.join(bitbake_builddir,'conf/conf-notes.txt'),
+            init_script,
+            bitbake_builddir
+            )
+        readme_file = os.path.join(bitbake_builddir, "README")
+        with open(readme_file, 'w') as f:
+            f.write(readme)
+        print("Usage instructions and additional information are in\n     {}\n".format(readme_file))
+        print("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
+        print("To run builds, source the environment using\n    . {}".format(init_script))
 
 def get_registry_config(registry_path, id):
     for root, dirs, files in os.walk(registry_path):
@@ -291,7 +318,7 @@ def get_registry_config(registry_path, id):
                 return os.path.join(root, f)
     raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
 
-def update_build(config, confdir, setupdir, layerdir, d):
+def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"):
     layer_config = copy.deepcopy(config["data"]["sources"])
     layer_overrides = config["source-overrides"]["sources"]
     for k,v in layer_overrides.items():
@@ -300,7 +327,7 @@ def update_build(config, confdir, setupdir, layerdir, d):
     sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
-    setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir)
+    setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
     write_sources_fixed_revisions(confdir, sources_fixed_revisions)
 
 def int_input(allowed_values):
@@ -506,7 +533,7 @@ def init_config(top_dir, settings, args):
     bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
 
     write_upstream_config(confdir, upstream_config)
-    update_build(upstream_config, confdir, setupdir, layerdir, d)
+    update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes")
     commit_config(confdir)
 
     bb.event.remove("bb.build.TaskProgress", None)
@@ -548,7 +575,7 @@ def are_layers_changed(layers, layerdir, d):
 
     return changed
 
-def build_status(top_dir, settings, args, d, update=False):
+def build_status(top_dir, settings, args, d, update=False, update_bb_conf="prompt"):
     setupdir = args.setup_dir
 
     confdir = os.path.join(setupdir, "config")
@@ -569,20 +596,20 @@ def build_status(top_dir, settings, args, d, update=False):
         print('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
         if update:
             commit_config(confdir)
-            update_build(new_upstream_config, confdir, setupdir, layerdir, d)
+            update_build(new_upstream_config, confdir, setupdir, layerdir, d, update_bb_conf=update_bb_conf)
         else:
             bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
         return
 
     if are_layers_changed(current_upstream_config["data"]["sources"], layerdir, d):
         if update:
-            update_build(current_upstream_config, confdir, setupdir, layerdir, d)
+            update_build(current_upstream_config, confdir, setupdir, layerdir, d, update_bb_conf=update_bb_conf)
         return
 
     print("\nConfiguration in {} has not changed.".format(setupdir))
 
 def build_update(top_dir, settings, args, d):
-    build_status(top_dir, settings, args, d, update=True)
+    build_status(top_dir, settings, args, d, update=True, update_bb_conf=args.update_bb_conf)
 
 def do_fetch(fetcher, dir):
     # git fetcher simply dumps git output to stdout; in bitbake context that is redirected to temp/log.do_fetch
@@ -836,6 +863,7 @@ def main():
 
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


