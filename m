Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CF9FEA822
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 07:14:12 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16760.1774422847649471384
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2026 00:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=eo63SPfH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1329275-2026032507140574482c20350002073e-jpfbsx@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2026032507140574482c20350002073e
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 25 Mar 2026 08:14:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jNtCpr5FFCFklpndqR4ITvVKi67qimn+drWpM3s3Nag=;
 b=eo63SPfHIVR8r9H/9Bm6lJlpW7LuX4lY7ox/4aLd0QHaIoI4XCOMh0O/EywtjyHmgKvG5F
 704kRjNIBIRegRlzyi646D8w73mLQSgoPFjpNyGLW68M/nWBxBM5B/uJFh/JBxegM864TRod
 FgP3kBmW6WlXBuht8XW9cThGaSvXKY7fcDEPrpoko6VIfwYUViCM7qaZTeInBLao0Lrsil6a
 sjWOsH8VF7iiCKnYIRp2ffC05fDJsC9pKlgv/4SZthbKMP86zZ8/mnUPS5W6D5J0wxZQdZwZ
 q0cHDS/TGKUsKM6BnJdtaUWo5GZrV7hLIGmf7YKcmQLOdagVkA0NB6fA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 09/10] bitbake-setup: add --rebase-conflicts-strategy to the update command
Date: Wed, 25 Mar 2026 07:51:51 +0100
Message-ID: <20260325071342.47272-10-adrian.freihofer@siemens.com>
In-Reply-To: <20260325071342.47272-1-adrian.freihofer@siemens.com>
References: <20260325071342.47272-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 07:14:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19223

From: Adrian Freihofer <adrian.freihofer@siemens.com>

When unpack_update() raises a LocalModificationsError due to local
modifications in a layer repository, the caller now has a choice of
how to handle it, controlled by the new --rebase-conflicts-strategy
option on the 'update' subcommand:

- abort (default): re-raise the error so the update stops with a clear
  message that names the affected source and its path. The fetcher has
  already aborted the rebase and restored the checkout to its previous
  state.
- backup: rename the directory to a timestamped <name>-backup path to
  preserve local work, then re-clone from upstream via fetcher.unpack().

The strategy is threaded from the CLI argument through build_status()
and update_build() down to checkout_layers().

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index bebf2e705..a5f33b794 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -166,7 +166,7 @@ def _get_remotes(r_remote):
 
     return remotes
 
-def checkout_layers(layers, confdir, layerdir, d):
+def checkout_layers(layers, confdir, layerdir, d, rebase_conflicts_strategy='abort'):
     def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
@@ -182,7 +182,33 @@ def checkout_layers(layers, confdir, layerdir, d):
             else:
                 src_uri = f"{fetchuri};protocol={prot};rev={rev};nobranch=1;destsuffix={repodir}"
             fetcher = bb.fetch.Fetch([src_uri], d)
-            do_fetch(fetcher, layerdir)
+            repodir_path = os.path.join(layerdir, repodir)
+            try:
+                do_fetch(fetcher, layerdir)
+            except bb.fetch2.LocalModificationsError as e:
+                if rebase_conflicts_strategy != 'backup':
+                    e.msg += ("\nUse 'bitbake-setup update --rebase-conflicts-strategy=backup'"
+                              " to automatically back up the directory and re-clone from upstream,"
+                              " or use 'bitbake-setup init -L %s /path/to/local/checkout'"
+                              " to work with a local checkout instead." % r_name)
+                    raise
+                backup_path = add_unique_timestamp_to_path(repodir_path + '-backup')
+                logger.warning(
+                    "Source '{}' at {} has local modifications that prevent an in-place update.\n"
+                    "Renaming it to {} to preserve your work, then re-cloning from upstream."
+                    .format(r_name, repodir_path, backup_path))
+                os.rename(repodir_path, backup_path)
+                fetcher.unpack(layerdir)
+            except bb.fetch2.UnpackError as e:
+                if rebase_conflicts_strategy != 'backup':
+                    raise
+                backup_path = add_unique_timestamp_to_path(repodir_path + '-backup')
+                logger.warning(
+                    "Source '{}' at {} could not be updated in place (rebase conflict).\n"
+                    "Renaming it to {} to preserve your work, then re-cloning from upstream."
+                    .format(r_name, repodir_path, backup_path))
+                os.rename(repodir_path, backup_path)
+                fetcher.unpack(layerdir)
             urldata = fetcher.ud[src_uri]
             revision = urldata.revision
             layers_fixed_revisions[r_name]['git-remote']['rev'] = revision
@@ -441,9 +467,9 @@ def merge_overrides_into_sources(sources, overrides):
             layers[k] = v
     return layers
 
-def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False):
+def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False, rebase_conflicts_strategy='abort'):
     layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
-    sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d)
+    sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d, rebase_conflicts_strategy=rebase_conflicts_strategy)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
     setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf, init_vscode)
@@ -926,7 +952,7 @@ def build_status(top_dir, settings, args, d, update=False):
         logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
         if update:
             update_build(new_upstream_config, confdir, setupdir, layerdir, d,
-                         update_bb_conf=args.update_bb_conf)
+                         update_bb_conf=args.update_bb_conf, rebase_conflicts_strategy=args.rebase_conflicts_strategy)
         else:
             bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
         return
@@ -935,7 +961,7 @@ def build_status(top_dir, settings, args, d, update=False):
     if are_layers_changed(layer_config, layerdir, d):
         if update:
             update_build(current_upstream_config, confdir, setupdir, layerdir,
-                         d, update_bb_conf=args.update_bb_conf)
+                         d, update_bb_conf=args.update_bb_conf, rebase_conflicts_strategy=args.rebase_conflicts_strategy)
         return
 
     logger.plain("\nConfiguration in {} has not changed.".format(setupdir))
@@ -1256,6 +1282,10 @@ def main():
     parser_update = subparsers.add_parser('update', help='Update a setup to be in sync with configuration')
     add_setup_dir_arg(parser_update)
     parser_update.add_argument('--update-bb-conf', choices=['prompt', 'yes', 'no'], default='prompt', help='Update bitbake configuration files (bblayers.conf, local.conf) (default: prompt)')
+    parser_update.add_argument('--rebase-conflicts-strategy', choices=['abort', 'backup'], default='abort',
+                        help="What to do when a layer repository has local modifications that prevent "
+                             "an in-place update: 'abort' (default) aborts with an error message; "
+                             "'backup' renames the directory to a timestamped backup and re-clones from upstream.")
     parser_update.set_defaults(func=build_update)
 
     parser_install_buildtools = subparsers.add_parser('install-buildtools', help='Install buildtools which can help fulfil missing or incorrect dependencies on the host machine')
-- 
2.53.0


