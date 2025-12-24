Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60671E77361
	for <webhook@archiver.kernel.org>; Wed, 24 Dec 2025 15:13:12 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.121737.1766589184693513474
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Dec 2025 07:13:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm2 header.b=DlDo9Sb7;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1329275-20251224151302a4ed7233bd0002072d-whwkov@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251224151302a4ed7233bd0002072d
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 24 Dec 2025 16:13:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=rF76PJA1JSAEv8GMo6KLJX2On3Ut5QtEvzOGp5QWlsU=;
 b=DlDo9Sb7eoG1y3g2ezlRQloBc+thmVKL+B+fSHnD+Iu0WdlUhRC6tg18SVET5mPTPrAies
 V/aM9ZjtqLO286w9viP9coVsyZRaqYkaeOxsRMIdJhumfzX+PQkqwGJ23CsKBtvVBAEuK+k7
 q+jee5WrOgMmJQZcDvvzfAQtUYf320FnaNeAr8LgzymseaWlbsHkCPKY5fa4YNuOOnF8sSHE
 q5v4VitclFB3egkGFqFp5P1ker9U0oMzNYOp8zaFZkxb7kCfHXfp6fxvrrWMMWuEKhcQaebM
 D4GaCK/Hsi1I/hlwi5+mcBqiObjRVrGxhUX8nG4CvIpNwhQm/ddoP6Zg==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 1/1] bitbake-setup: Initialize build environment after setup/update
Date: Wed, 24 Dec 2025 16:12:15 +0100
Message-ID: <20251224151248.3313463-2-adrian.freihofer@siemens.com>
In-Reply-To: <20251224151248.3313463-1-adrian.freihofer@siemens.com>
References: <20251224151248.3313463-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Dec 2025 15:13:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18649

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add verify_and_prepare_environment() function to source the init-build-env
script after configuration setup or updates. This ensures the build
environment is properly initialized and IDE configuration files (such as
.vscode/settings.json) are created before the user starts the IDE.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 73f734e73..4c9a86b34 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
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


