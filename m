Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA80FC97F3
	for <webhook@archiver.kernel.org>; Sun, 29 Mar 2026 18:34:31 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34710.1774809263055482082
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 29 Mar 2026 11:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=IHFo4ABG;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1329275-20260329183420ad2ddcdc2000020729-edxgwn@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260329183420ad2ddcdc2000020729
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 29 Mar 2026 20:34:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=oSI7b6jTNl6qYNAHRL/07Gn5qIcP6gP/yQHbmtlIROw=;
 b=IHFo4ABGSGlkICRyntD0A7kLZxGk3gThck0EegpyPNz3UW7PmcisdBYpyKTPDF0aiNjI7k
 IGzVjUoPCmXu6fU3NjrBOsbniWml0mKbLOA3pwbLuHEnDubRk2Xb6OUfWmtaJLNtqTeyN1v1
 bruiOJYDo7rUKFEiTUzT+S1WJX5X1fS8d1327Y6hnRfyrxdIcUtk4Fu8RF4PD5Bh1tTwNf22
 RaQptz9K1s4lX/WsJ/M8F4J4BanPFZsEk2sOJsMVtdv2qwEEAMpmwAK+ur73rxAFQfu984Gp
 ZZ74kEzNw2IOjthGf30jxf8uAyBst+7WvYNZ/YDF8qaW/T/TCmi/EIow==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v3 11/14] bitbake-setup: add --rebase-conflicts-strategy to the update command
Date: Sun, 29 Mar 2026 20:32:58 +0200
Message-ID: <20260329183332.1996183-12-adrian.freihofer@siemens.com>
In-Reply-To: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
References: <20260329183332.1996183-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 29 Mar 2026 18:34:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19265

From: Adrian Freihofer <adrian.freihofer@siemens.com>

When unpack_update() raises LocalModificationsError (uncommitted changes)
or RebaseError (local commits that could not be rebased), the caller now
has a choice of how to handle it, controlled by the new
--rebase-conflicts-strategy option on the 'update' subcommand:

- abort (default): re-raise the error so the update stops with a clear
  message that names the affected source and its path. The fetcher has
  already aborted the rebase and restored the checkout to its previous
  state.
- backup: rename the directory to a timestamped <name>-backup path to
  preserve local work, then re-clone from upstream via fetcher.unpack().

Both exception types share a single except clause; the exception message
already describes the specific failure (uncommitted changes vs. failed
rebase with git output), so it is forwarded directly to the warning log.

The strategy is threaded from the CLI argument through build_status()
and update_build() down to checkout_layers().

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index ce32c3f13..596722e48 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -167,7 +167,7 @@ def _get_remotes(r_remote):
 
     return remotes
 
-def checkout_layers(layers, confdir, layerdir, d):
+def checkout_layers(layers, confdir, layerdir, d, rebase_conflicts_strategy='abort'):
     def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
@@ -183,7 +183,23 @@ def checkout_layers(layers, confdir, layerdir, d):
             else:
                 src_uri = f"{fetchuri};protocol={prot};rev={rev};nobranch=1;destsuffix={repodir}"
             fetcher = bb.fetch.Fetch([src_uri], d)
-            do_fetch(fetcher, layerdir)
+            repodir_path = os.path.join(layerdir, repodir)
+            try:
+                do_fetch(fetcher, layerdir)
+            except (bb.fetch2.LocalModificationsError, bb.fetch2.RebaseError) as e:
+                if rebase_conflicts_strategy != 'backup':
+                    e.msg += ("\nUse 'bitbake-setup update --rebase-conflicts-strategy=backup'"
+                              " to automatically back up the directory and re-clone from upstream,"
+                              " or use 'bitbake-setup init -L %s /path/to/local/checkout'"
+                              " to work with a local checkout instead." % r_name)
+                    raise
+                backup_path = add_unique_timestamp_to_path(repodir_path + '-backup')
+                logger.warning(
+                    "%s\n"
+                    "Renaming %s to %s to preserve your work, then re-cloning from upstream.",
+                    e, repodir_path, backup_path)
+                os.rename(repodir_path, backup_path)
+                fetcher.unpack(layerdir)
             urldata = fetcher.ud[src_uri]
             revision = urldata.revision
             layers_fixed_revisions[r_name]['git-remote']['rev'] = revision
@@ -442,9 +458,9 @@ def merge_overrides_into_sources(sources, overrides):
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
@@ -927,7 +943,7 @@ def build_status(top_dir, settings, args, d, update=False):
         logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
         if update:
             update_build(new_upstream_config, confdir, setupdir, layerdir, d,
-                         update_bb_conf=args.update_bb_conf)
+                         update_bb_conf=args.update_bb_conf, rebase_conflicts_strategy=args.rebase_conflicts_strategy)
         else:
             bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
         return
@@ -936,7 +952,7 @@ def build_status(top_dir, settings, args, d, update=False):
     if are_layers_changed(layer_config, layerdir, d):
         if update:
             update_build(current_upstream_config, confdir, setupdir, layerdir,
-                         d, update_bb_conf=args.update_bb_conf)
+                         d, update_bb_conf=args.update_bb_conf, rebase_conflicts_strategy=args.rebase_conflicts_strategy)
         return
 
     logger.plain("\nConfiguration in {} has not changed.".format(setupdir))
@@ -1257,6 +1273,10 @@ def main():
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


