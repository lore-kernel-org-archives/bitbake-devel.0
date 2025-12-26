Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D10E8FDB1
	for <webhook@archiver.kernel.org>; Fri, 26 Dec 2025 17:21:38 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.155871.1766769689876243374
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Dec 2025 09:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=m4BwN+zP;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1329275-202512261721268c3ba2b3a600020785-zrgex5@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202512261721268c3ba2b3a600020785
        for <bitbake-devel@lists.openembedded.org>;
        Fri, 26 Dec 2025 18:21:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Uxl0P1YJPI9W+HgHVdO4rKyFal7PpB6FKknhvIwrMro=;
 b=m4BwN+zPYZK6EdJyaRWKqYmsiEymKorZ/kOThousYCKwNE/4fYkcWSArlSG2qm02fZxLMS
 sIGAoPWG2NvnyJ+awJ2ofG7NillbOHbfFZUiHMB/QdZnl6PVqCn+29GGhb+mBUcLwqPxRVeZ
 vB81/oVdnUMu3VOp3sEdOQPT2rbmokVyflUZwt8tZ5L9KA7H2BWTMooTieu8TTfcZQFRX4bN
 1iTIFapqZ8Crxv4Qhf2mED9Xn21vdhyyNgyMdOIu7yo2gs4yzrwcLAM9nG7irQGOM5Ic+PLB
 s9El+hEYDUVcCDfhWTnE3l8rv+Eb+edWzANQy7jtz65QyAtOJTPfjlAA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 1/1] bitbake-setup: Initialize build environment after setup/update
Date: Fri, 26 Dec 2025 18:19:05 +0100
Message-ID: <20251226172034.1091465-2-adrian.freihofer@siemens.com>
In-Reply-To: <20251226172034.1091465-1-adrian.freihofer@siemens.com>
References: <20251226172034.1091465-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Dec 2025 17:21:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18652

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add verify_and_prepare_environment() function to source the init-build-env
script after configuration setup or updates. This ensures the build
environment is properly initialized and IDE configuration files (such as
.vscode/settings.json) are created before the user starts the IDE.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 73f734e73..0faa5da4e 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -280,7 +280,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
             logger.plain('New bitbake configuration from upstream is the same as the current one, no need to update it.')
             shutil.rmtree(bitbake_confdir)
             os.rename(backup_bitbake_confdir, bitbake_confdir)
-            return
+            return init_script
 
         logger.plain('Upstream bitbake configuration changes were found:')
         logger.plain(conf_diff)
@@ -295,7 +295,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
             logger.plain(f'Leaving the upstream configuration in {upstream_bitbake_confdir}')
             os.rename(bitbake_confdir, upstream_bitbake_confdir)
             os.rename(backup_bitbake_confdir, bitbake_confdir)
-            return
+            return init_script
 
         logger.plain('Applying upstream bitbake configuration changes')
         logger.plain(f'Leaving the previous configuration in {backup_bitbake_confdir}')
@@ -324,6 +324,8 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
     logger.plain("{}\n".format(fragment_note))
     logger.plain("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
 
+    return init_script
+
 def get_registry_config(registry_path, id):
     for root, dirs, files in os.walk(registry_path):
         for f in files:
@@ -340,8 +342,9 @@ def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"
     sources_fixed_revisions = checkout_layers(layer_config, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
-    setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
+    init_script = setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
     write_sources_fixed_revisions(confdir, sources_fixed_revisions)
+    return init_script
 
 def int_input(allowed_values, prompt=''):
     n = None
@@ -511,6 +514,14 @@ def obtain_overrides(args):
 
     return overrides
 
+def verify_and_prepare_environment(init_script):
+    """
+    Source the build environment init-build-env script.
+
+    This verifies the setup is working.
+    Additionally it may initialize the environment with e.g. a .vscode/settings.json if needed.
+    """
+    bb.process.run(['sh', '-c', '. {}'.format(init_script)])
 
 def init_config(top_dir, settings, args):
     create_siteconf(top_dir, args.non_interactive, settings)
@@ -580,9 +591,12 @@ def init_config(top_dir, settings, args):
     bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
 
     write_upstream_config(confdir, upstream_config)
-    update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes")
+    init_script = update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes")
     commit_config(confdir)
 
+    # Source the build environment to verify setup and prepare for VSCode if needed
+    verify_and_prepare_environment(init_script)
+
     bb.event.remove("bb.build.TaskProgress", None)
 
 def get_diff(file1, file2):
@@ -649,16 +663,18 @@ def build_status(top_dir, settings, args, d, update=False):
         logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
         if update:
             commit_config(confdir)
-            update_build(new_upstream_config, confdir, setupdir, layerdir, d,
+            init_script = update_build(new_upstream_config, confdir, setupdir, layerdir, d,
                          update_bb_conf=args.update_bb_conf)
+            verify_and_prepare_environment(init_script)
         else:
             bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
         return
 
     if are_layers_changed(current_upstream_config["data"]["sources"], layerdir, d):
         if update:
-            update_build(current_upstream_config, confdir, setupdir, layerdir,
+            init_script = update_build(current_upstream_config, confdir, setupdir, layerdir,
                          d, update_bb_conf=args.update_bb_conf)
+            verify_and_prepare_environment(init_script)
         return
 
     logger.plain("\nConfiguration in {} has not changed.".format(setupdir))
-- 
2.52.0


