Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8270ECEBF97
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 12:52:33 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8389.1763383945023764340
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Nov 2025 04:52:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=udlqIvw1;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 58A66C12650;
	Mon, 17 Nov 2025 12:52:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6D9F6606B9;
	Mon, 17 Nov 2025 12:52:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 886BB10371D12;
	Mon, 17 Nov 2025 13:52:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763383943; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=44hmeRWlPyIAZKk5dKQZ3yxyHnpkT6h51XHpjluh1n8=;
	b=udlqIvw1CUaRdX0+VtJV1au5/jQ/LIOXm3+kuF+dUXVb380IQyxygzpM4NhQKx81+HSOF+
	Qz7hFuoQqxwxnAJ5V6cm9T7VMTlsp4faMs5/k49myHCVPCQeJaOhMIp3E1AAjfKprSnpUK
	bUU7WRLJDvX3NQZJQMCj5FTGRfXzKekh/BjX6XhWk69g/XS0SZpxeH3w2E2EDSSuC3BkAM
	lwYtWzCqmYdGCB3tIq5fPBsS18h8Kh91cFOACDdPjccau9VQM108LNCzBb1wlGPFdFWKXY
	oDZQbWdTLeW6OEjA0fEgZIodClngGgFG+nIfKPmVDjl+rtHz/bA3N5XryGdaLA==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Mon, 17 Nov 2025 13:52:17 +0100
Subject: [PATCH v3 1/2] bitbake-setup: update: add a --update-bb-conf
 option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-bitbake-setup-conf-updates-v3-1-46cdf826e79c@bootlin.com>
References: <20251117-bitbake-setup-conf-updates-v3-0-46cdf826e79c@bootlin.com>
In-Reply-To: <20251117-bitbake-setup-conf-updates-v3-0-46cdf826e79c@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11257;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=6EQ9uOGf7052h7+vjGctRh/41AZ3qsAKlpf9ItQbSVw=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpGxqEeb1Rx9ybqprGK1zqmp9+mYxS1DMnzKhiK
 hA7sT05+5+JAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaRsahAAKCRDRgEFAKaOo
 NhP+D/9ghxjeE3GPRcHxnUrDsc2FELyc7rCH5pDltstuwohXO2KopAN41tABl0cVtncX0SnicqE
 IQr8vu/8SQ2nZ8ohAMtLBOlGGzWnMh60mFn2c6I3CLM8e3JGFKRxPQQWkPofQL9tk7xVWojGLjO
 tPx+E4Y1RgjMQ3ooBHPsaFQbrTBiPMpWLlsAMokBi1VfdMYE6Utqd7o/mj/9WlewgQ/I85pN/KA
 OhDl5AkGeDiHl/8GWzkl4rL5u6H5NOuF5064jAwL5MsYQZVi7Gy2dfdmf6xccYmZvJR18uhZ00i
 H0GiQgKXsxXtCGmOIOThVhem3itX4qiQQ0/vsZWh78oAXSxSrIocsz0d6SeXZ22oAw+PooS7qyx
 c19ToWpmvp1dSk/HfxS0JJQeK0Tz209FocNXeaTUOIIJB6d3rNVInPByMADmF+SsiYNaRk0ioPF
 61Pop+vo6wzzKw6Czi2PMfZlScYgyIN3RsSHQycgbwSd4nzgGCIfRbiijwaIb0sgsDaXxUsknS0
 c4+wvIoJ5LC0vNBIlvG5LKxjmLtcJey92iYUmp5DENDRpuP+Q+FkUQL5FCS18KZv+XqQ41U7txC
 MJauz91SM/IMWyIpj6fUVvUig7CXfGicjrp8AI+Ypx23FFc9XRrgjS7jKk3ykG3e/kO/mNMeyFA
 t3oZyvsG0pPR5bQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 12:52:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18428

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
 bin/bitbake-setup                                  | 58 ++++++++++++++++------
 .../bitbake-user-manual-environment-setup.rst      |  8 +++
 lib/bb/tests/setup.py                              |  6 +--
 3 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index d0a932a6b2..97ca67e155 100755
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
 
+        if update_bb_conf == 'no':
+            print('Ignoring upstream bitbake configuration changes')
+            print(f'Leaving the upstream configuration in {upstream_bitbake_confdir}')
+            os.rename(bitbake_confdir, upstream_bitbake_confdir)
+            os.rename(backup_bitbake_confdir, bitbake_confdir)
+            return
+
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
@@ -565,18 +585,25 @@ def build_status(top_dir, settings, args, d, update=False):
     write_upstream_config(confdir, new_upstream_config)
     config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
 
+    update_bb_conf = 'prompt'
+    try:
+        update_bb_conf = args.update_bb_conf
+    except AttributeError:
+        # this arg is only passed from build_update()
+        pass
+
     if config_diff:
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


