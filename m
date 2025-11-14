Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD4FCE8D5D
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 16:44:45 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2833.1763138682349894026
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 08:44:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=DRsI4Dau;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B0FD04E416B5
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 16:44:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 87EF76060E;
	Fri, 14 Nov 2025 16:44:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B493010371CC3;
	Fri, 14 Nov 2025 17:44:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763138680; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UDgYgYFY+MxOFJBzi79MoEoZGLgcvuVPulQ2vv3lAmE=;
	b=DRsI4DauXKEf7zpbYM9vC3rDsAgusYhLLUAzJAJCD+ogdZLZrlFkLHpSRuMsUeQA4khiQ7
	xEFTx5dSWZwXhnWBi3+O2qxKJSJM7OAsz98yKdVjPlaxbJcbj62/gDPcaMJHt8TxbN4737
	vg6rK9ZnO/m1K1BrO/mY+SwSfBQG0UF2OHupB57M0VjGqzCIcGUFSqNDu0cUy2pSpCG3bz
	D4biIUNa7vBPyiKG0y8dzeBqqPbKLVZp6aGHChECn9m97J66F3McrrkcxvrlGAzGZyOrL9
	ZzieGcSbWholjG71Tzsy8Lk7LkaoX5IpQzqt9OxSTBGd1TRvpn8CzzGvB6jkqQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 14 Nov 2025 17:44:20 +0100
Subject: [PATCH 1/2] bitbake-setup: update: add a --update-bb-conf option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-bitbake-setup-conf-updates-v1-1-990583d8251b@bootlin.com>
References: <20251114-bitbake-setup-conf-updates-v1-0-990583d8251b@bootlin.com>
In-Reply-To: <20251114-bitbake-setup-conf-updates-v1-0-990583d8251b@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8348;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=jHeZJZWyNMKkWzcVqHu+5LlyCo/EUfZV1YA/Y419Ils=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpF1x1IWwgUKbFvxejNvoWpVwW+6odnNFkwK5iK
 7B99wouVOOJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRdcdQAKCRDRgEFAKaOo
 NrDXD/0Z481Jlm/IsI2mZdsIysqDmh2tdrKlmvzCn4cHh4iDu/Ca+0Lg4xU+164twD+1gZJFWnO
 xozoQ1waVUOELGz9Jk4MKjrpNHRuP0nQVznuXb7ojoWM6WLeJTp7da00ArBCVNWlUxPcMgB7+1G
 aA2QPIrxofTOcafxTP1rwxmlhXiQYhBX+zjkLolerRmF4lO/+v4ew65HjIVXVY8wIi4vaNheNz0
 naSPobbjmNEpYQIam54ucZR728812ie16fgu87STREuht+QtQFxnZClUeUWz5ruIYrJjqPYI0wk
 O0AeCMcrNRptwtvTY/mbR3BJ7mJzoAUEIMDDSVN14sgi6sF1qFeyu4nB7+1uMU62H2+bfjbeNnA
 zUxik9tBhfQyvWkqx84LJ6be7PxjxXU39wfy1oh+GsGZk1z9FF2tE8D5xYtDUjPbebupaKPV5d6
 qvPF5WJO/kyXPJbgau2hcq+6a1gNxd6YMpXy5FoGqOzoYoCp+VKNaFqB5MbnahWLPoYI5exYqfb
 LY74qkri9NQ8PAloi+8x4o0r0WQ9/4ieUWBhQopXbTzEzF/RDuTug9ylhe/NCDKmhYoYTJ3Wmdv
 Kw+JnFHMU28ICTWSwUU9Y/Pg4yf6kyZwC6xqOj3D+yn+A7dk4xJeu/vDbMDNMXDAvUkY4fEN/jS
 ex28vTZIDeuP+4w==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 16:44:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18406

Add a --update-bb-conf option that can be used to choose whether to
update the BitBake configuration files (local.conf, bblayers.conf, etc.)
in the conf/ directory.

The argument can take up to three values:

-  ``prompt`` (default): ask the user whether to update.
-  ``yes``: update the configuration files.
-  ``no``: don't update the configuration files.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup                                  | 28 ++++++++++++++++------
 .../bitbake-user-manual-environment-setup.rst      |  8 +++++++
 lib/bb/tests/setup.py                              |  6 ++---
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 5a9dde5c92..3e711f5cd7 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -291,7 +291,7 @@ def get_registry_config(registry_path, id):
                 return os.path.join(root, f)
     raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
 
-def update_build(config, confdir, setupdir, layerdir, d):
+def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"):
     layer_config = copy.deepcopy(config["data"]["sources"])
     layer_overrides = config["source-overrides"]["sources"]
     for k,v in layer_overrides.items():
@@ -300,7 +300,18 @@ def update_build(config, confdir, setupdir, layerdir, d):
     sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
-    setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir)
+
+    if update_bb_conf == "prompt":
+        print(f'bitbake-setup can update the BitBake configuration in {setupdir}/conf')
+        print('This means updating the local.conf, bblayers.conf, and other files in this directory.')
+        print('A backup will be created for the existing files.')
+        y_or_n = input('Proceed to update? (y/N): ')
+        if y_or_n == 'y':
+            update_bb_conf = 'yes'
+
+    if update_bb_conf == "yes":
+        setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir)
+
     write_sources_fixed_revisions(confdir, sources_fixed_revisions)
 
 def int_input(allowed_values):
@@ -514,7 +525,7 @@ def init_config(top_dir, settings, args):
     bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
 
     write_upstream_config(confdir, upstream_config)
-    update_build(upstream_config, confdir, setupdir, layerdir, d)
+    update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes")
     commit_config(confdir)
 
     bb.event.remove("bb.build.TaskProgress", None)
@@ -556,7 +567,7 @@ def are_layers_changed(layers, layerdir, d):
 
     return changed
 
-def build_status(top_dir, settings, args, d, update=False):
+def build_status(top_dir, settings, args, d, update=False, update_bb_conf="prompt"):
     setupdir = args.setup_dir
 
     confdir = os.path.join(setupdir, "config")
@@ -576,21 +587,23 @@ def build_status(top_dir, settings, args, d, update=False):
     if config_diff:
         print('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
         if update:
+            update_build(new_upstream_config, confdir, setupdir, layerdir, d,
+                         update_bb_conf=update_bb_conf)
             commit_config(confdir)
-            update_build(new_upstream_config, confdir, setupdir, layerdir, d)
         else:
             bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
         return
 
     if are_layers_changed(current_upstream_config["data"]["sources"], layerdir, d):
         if update:
-            update_build(current_upstream_config, confdir, setupdir, layerdir, d)
+            update_build(current_upstream_config, confdir, setupdir, layerdir, d,
+                         update_bb_conf=update_bb_conf)
         return
 
     print("\nConfiguration in {} has not changed.".format(setupdir))
 
 def build_update(top_dir, settings, args, d):
-    build_status(top_dir, settings, args, d, update=True)
+    build_status(top_dir, settings, args, d, update=True, update_bb_conf=args.update_bb_conf)
 
 def do_fetch(fetcher, dir):
     # git fetcher simply dumps git output to stdout; in bitbake context that is redirected to temp/log.do_fetch
@@ -844,6 +857,7 @@ def main():
 
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
index 46834f361e..58049c8c7a 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -310,7 +310,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 os.environ['BBPATH'] = os.path.join(setuppath, 'build')
                 out = self.runbbsetup("status")
                 self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
-                out = self.runbbsetup("update")
+                out = self.runbbsetup("update --update-bb-conf='yes'")
                 self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
 
         # install buildtools
@@ -331,7 +331,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             out = self.runbbsetup("status")
             self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, setuppath), out[0])
-            out = self.runbbsetup("update")
+            out = self.runbbsetup("update --update-bb-conf='yes'")
             if c in ('gadget', 'gizmo'):
                 self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
@@ -355,7 +355,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
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


