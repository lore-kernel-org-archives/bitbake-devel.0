Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15701FC72DF
	for <webhook@archiver.kernel.org>; Sun, 22 Mar 2026 19:35:08 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1874.1774208105448540912
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Mar 2026 12:35:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=eQEqh9/w;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1329275-2026032219350270238e7fc7000207a8-tbpq5u@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026032219350270238e7fc7000207a8
        for <bitbake-devel@lists.openembedded.org>;
        Sun, 22 Mar 2026 20:35:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lB9DJ6WFJsZh2LO8Op8nlrCV/A+o1OEulu+Vx4zPlmU=;
 b=eQEqh9/wziB9jH/9VfasvYpPsymhpyyWbrpRKC5vKUCn4V3o6GMBTl53pVmN/OaN06iFOf
 VF7C9NLLKjaKNWP5ep20KEETLwAdBS4rByl0fo/YDGKC5LE+YUL+JOQRpGqeB4yLP1EUUClg
 MGXeegEESQd1LHfeUJNB7ASjBYkgqyxwAB3lbYRL0V8JPRgrF5L79ku3AwPNud8ISuNfBshD
 MveC//Wl4PK+AgZkefnTEpII7nKFLMY+xWVw5pdOL1Fr6Rj0W0YnDXhpTca5Fko5WN/LIwWS
 vrxNwLrXs5KUEIKIO21jx+KOQzQq38Xj+SEEiA17NguRTrtNdRt8CdAA==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 8/9] bitbake-setup: add --rebase-strategy to the update command
Date: Sun, 22 Mar 2026 20:34:19 +0100
Message-ID: <20260322193440.870120-9-adrian.freihofer@siemens.com>
In-Reply-To: <20260322193440.870120-1-adrian.freihofer@siemens.com>
References: <20260322193440.870120-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 22 Mar 2026 19:35:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19206

From: Adrian Freihofer <adrian.freihofer@siemens.com>

When unpack_update() raises an UnpackError due to local modifications in
a layer repository, the caller now has a choice of how to handle it,
controlled by the new --rebase-strategy option on the 'update' subcommand:

- stop (default): abort with a clear error message that names the
  affected source and directory, and suggests --rebase-strategy=backup
  as a remedy.
- backup: rename the directory to a timestamped <name>-backup path to
  preserve local work, then re-clone from upstream via fetcher.unpack().

The strategy is threaded from the CLI argument through build_status()
and update_build() down to checkout_layers(). The choices= list in
argparse makes it straightforward to add further strategies (e.g.
interactive or AI) in the future.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 695043378..dc433fa22 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -166,7 +166,7 @@ def _get_remotes(r_remote):
 
     return remotes
 
-def checkout_layers(layers, confdir, layerdir, d):
+def checkout_layers(layers, confdir, layerdir, d, rebase_strategy='stop'):
     def _checkout_git_remote(r_remote, repodir, layers_fixed_revisions):
         rev = r_remote['rev']
         branch = r_remote.get('branch', None)
@@ -186,10 +186,20 @@ def checkout_layers(layers, confdir, layerdir, d):
             try:
                 do_fetch(fetcher, layerdir)
             except bb.fetch2.UnpackError as e:
-                raise Exception(
-                    "Cannot update source '{}' in {} because it has local modifications.\n"
-                    "Please commit, stash or discard your changes and re-run the update.\n"
-                    "Details: {}".format(r_name, repodir_path, e)) from None
+                if rebase_strategy == 'backup':
+                    backup_path = add_unique_timestamp_to_path(repodir_path + '-backup')
+                    logger.warning(
+                        "Source '{}' at {} has local modifications that prevent an in-place update.\n"
+                        "Renaming it to {} to preserve your work, then re-cloning from upstream."
+                        .format(r_name, repodir_path, backup_path))
+                    os.rename(repodir_path, backup_path)
+                    fetcher.unpack(layerdir)
+                else:
+                    raise Exception(
+                        "Cannot update source '{}' in {} because it has local modifications.\n"
+                        "Please commit, stash or discard your changes and re-run the update,\n"
+                        "or use --rebase-strategy=backup to back up the directory and re-clone automatically.\n"
+                        "Details: {}".format(r_name, repodir_path, e)) from None
             urldata = fetcher.ud[src_uri]
             revision = urldata.revision
             layers_fixed_revisions[r_name]['git-remote']['rev'] = revision
@@ -444,9 +454,9 @@ def merge_overrides_into_sources(sources, overrides):
             layers[k] = v
     return layers
 
-def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False):
+def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False, rebase_strategy='stop'):
     layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
-    sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d)
+    sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d, rebase_strategy=rebase_strategy)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
     bitbake_builddir, init_script = setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf, init_vscode)
@@ -933,7 +943,7 @@ def build_status(top_dir, settings, args, d, update=False):
         logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
         if update:
             bitbake_builddir, init_script = update_build(new_upstream_config, confdir, setupdir, layerdir, d,
-                         update_bb_conf=args.update_bb_conf, init_vscode=args.init_vscode)
+                         update_bb_conf=args.update_bb_conf, init_vscode=args.init_vscode, rebase_strategy=args.rebase_strategy)
             if args.init_vscode:
                 configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
         else:
@@ -944,7 +954,7 @@ def build_status(top_dir, settings, args, d, update=False):
     if are_layers_changed(layer_config, layerdir, d):
         if update:
             bitbake_builddir, init_script = update_build(current_upstream_config, confdir, setupdir, layerdir,
-                         d, update_bb_conf=args.update_bb_conf, init_vscode=args.init_vscode)
+                         d, update_bb_conf=args.update_bb_conf, init_vscode=args.init_vscode, rebase_strategy=args.rebase_strategy)
             if args.init_vscode:
                 configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
         return
@@ -1272,6 +1282,10 @@ def main():
     parser_update.add_argument('--update-bb-conf', choices=['prompt', 'yes', 'no'], default='prompt', help='Update bitbake configuration files (bblayers.conf, local.conf) (default: prompt)')
     parser_update.add_argument('--init-vscode', action=argparse.BooleanOptionalAction, default=bool(shutil.which('code')),
                         help='Generate VSCode workspace configuration (default: %(default)s)')
+    parser_update.add_argument('--rebase-strategy', choices=['stop', 'backup'], default='stop',
+                        help="What to do when a layer repository has local modifications that prevent "
+                             "an in-place update: 'stop' (default) aborts with an error message; "
+                             "'backup' renames the directory to a timestamped backup and re-clones from upstream.")
     parser_update.set_defaults(func=build_update)
 
     parser_install_buildtools = subparsers.add_parser('install-buildtools', help='Install buildtools which can help fulfil missing or incorrect dependencies on the host machine')
-- 
2.53.0


