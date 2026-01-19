Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D041CA5FFF
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 07:34:39 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30750.1768808076940642879
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Jan 2026 23:34:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=O5skqjcA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1329275-2026011907343392ac80360500020784-xk9jv2@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2026011907343392ac80360500020784
        for <bitbake-devel@lists.openembedded.org>;
        Mon, 19 Jan 2026 08:34:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=EELs6CXsn2CJU3WVKU3wgma3k8N3dynLMIoTtJdl3ek=;
 b=O5skqjcA+J2A+OhoFI175iodcVSCBsAufx/7YFKK4SIAnHWGjC/+yCCSrvgmAfSq59JnRv
 JiIJYOQyWdVCUFxoBRhU2zNi/uIzfVv58/Pz27szQgabvnrzaXZvfNC2lRGqIESuNKYLnSb+
 Csl6k7xCGhVnkekJu+mlxSqc2mm92qpGQMLKeLKZ3FItP1d/ebs4D//Gfk40AzXbnliREyeu
 V7iUBk+07IZ2g0mbqa/seDO8yPlEnXm4UMqpPIaq2Ug0PJu/GE5jdOt+jCuzhdw1oL21gIU5
 Jr+YXMkRLvWaxkzTeTfFjWm59zUYYPBzdnkaR5Sg1WvCGB+5ZDMDC57g==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 1/2] bitbake-setup: generate config files for VSCode
Date: Mon, 19 Jan 2026 08:34:02 +0100
Message-ID: <20260119073419.952608-2-adrian.freihofer@siemens.com>
In-Reply-To: <20260119073419.952608-1-adrian.freihofer@siemens.com>
References: <20260119073419.952608-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 19 Jan 2026 07:34:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18806

From: Adrian Freihofer <adrian.freihofer@siemens.com>

This change introduces a function to generate a VSCode workspace file
(`bitbake.code-workspace`). This workspace file is preferred over a
project-specific `.vscode/settings.json` for several reasons:

- It allows for a multi-root workspace, which is ideal for a bitbake
  project structure setup with bitbake-setup. This enables including all
  layer repositories and the build configuration directory as top-level
  folders in the explorer.
- The workspace file can be located at the top level of the setup,
  outside of any version-controlled source directory. This avoids
  cluttering the git repositories with editor-specific configuration.
- It provides a centralized place for all VSCode settings related to the
  project, including those for the bitbake extension, Python language
  server, and file associations, ensuring a consistent development
  environment for all users of the project.

The Python analysis paths (`python.analysis.extraPaths`) are configured
with absolute paths. This is a workaround for a limitation in the Pylance
extension, which does not correctly resolve `${workspaceFolder:...}`
variables in a multi-root workspace context for import resolution. Using
absolute paths ensures that Pylance can find all necessary modules from
the various layers.

There is room for improvement. Starting a terminal (bitbake or any other)
is cumbersome, as VSCode wants to start it for one of the layers rather
than the build directory. not sure how this can be improved.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 198 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 183 insertions(+), 15 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index abe7614c8..df4addec8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -204,7 +204,7 @@ bitbake-setup init -L {} /path/to/repo/checkout""".format(
 
     return layers_fixed_revisions
 
-def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf):
+def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf, init_vscode=False):
     def _setup_build_conf(layers, filerelative_layers, build_conf_dir):
         os.makedirs(build_conf_dir)
         layers_s = []
@@ -335,7 +335,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
             logger.plain('New bitbake configuration from upstream is the same as the current one, no need to update it.')
             shutil.rmtree(bitbake_confdir)
             os.rename(backup_bitbake_confdir, bitbake_confdir)
-            return
+            return bitbake_builddir, init_script
 
         logger.plain('Upstream bitbake configuration changes were found:')
         logger.plain(conf_diff)
@@ -350,24 +350,31 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
             logger.plain(f'Leaving the upstream configuration in {upstream_bitbake_confdir}')
             os.rename(bitbake_confdir, upstream_bitbake_confdir)
             os.rename(backup_bitbake_confdir, bitbake_confdir)
-            return
+            return bitbake_builddir, init_script
 
         logger.plain('Applying upstream bitbake configuration changes')
         logger.plain(f'Leaving the previous configuration in {backup_bitbake_confdir}')
 
     fragment_note = "Run 'bitbake-config-build enable-fragment <fragment-name>' to enable additional fragments or replace built-in ones (e.g. machine/<name> or distro/<name> to change MACHINE or DISTRO)."
 
+    setupdir = os.path.dirname(layerdir)
+    workspace_file = os.path.join(setupdir, "bitbake.code-workspace")
+
+    readme_extra = ""
+    if init_vscode:
+        readme_extra = "\n\nTo edit the code in VSCode, open the workspace: code {}\n".format(workspace_file)
+
     readme = """{}\n\nAdditional information is in {} and {}\n
 Source the environment using '. {}' to run builds from the command line.\n
 {}\n
-The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf
-""".format(
+The bitbake configuration files (local.conf, bblayers.conf and more) can be found in {}/conf{}""".format(
         bitbake_config["description"],
         os.path.join(bitbake_builddir,'conf/conf-summary.txt'),
         os.path.join(bitbake_builddir,'conf/conf-notes.txt'),
         init_script,
         fragment_note,
-        bitbake_builddir
+        bitbake_builddir,
+        readme_extra
         )
     readme_file = os.path.join(bitbake_builddir, "README")
     with open(readme_file, 'w') as f:
@@ -378,6 +385,10 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
     logger.plain("To run builds, source the environment using\n    . {}\n".format(init_script))
     logger.plain("{}\n".format(fragment_note))
     logger.plain("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
+    if init_vscode:
+        logger.plain("To edit the code in VSCode, open the workspace:\n    code {}\n".format(workspace_file))
+
+    return bitbake_builddir, init_script
 
 def get_registry_config(registry_path, id):
     for root, dirs, files in os.walk(registry_path):
@@ -393,14 +404,15 @@ def merge_overrides_into_sources(sources, overrides):
             layers[k] = v
     return layers
 
-def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"):
+def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False):
     layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
     sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
-    setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
+    bitbake_builddir, init_script = setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf, init_vscode)
     write_sources_fixed_revisions(confdir, layerdir, sources_fixed_revisions)
     commit_config(confdir)
+    return bitbake_builddir, init_script
 
 def int_input(allowed_values, prompt=''):
     n = None
@@ -570,6 +582,150 @@ def obtain_overrides(args):
 
     return overrides
 
+def configure_vscode(setupdir, layerdir, builddir, init_script):
+    """
+    Configure the VSCode environment by creating or updating a workspace file.
+
+    Create or update a bitbake.code-workspace file with folders for the layers and build/conf.
+    Adds missing folders and settings, removes obsolete ones.
+    """
+    logger.debug("configure_vscode: setupdir={}, layerdir={}, builddir={}, init_script={}".format(
+        setupdir, layerdir, builddir, init_script))
+
+    # Get git repository directories
+    git_repos = []
+    if os.path.exists(layerdir):
+        for entry in os.listdir(layerdir):
+            entry_path = os.path.join(layerdir, entry)
+            if os.path.isdir(entry_path) and not os.path.islink(entry_path):
+                # Check if it's a git repository
+                if os.path.exists(os.path.join(entry_path, '.git')):
+                    git_repos.append(entry)
+    logger.debug("configure_vscode: found {} git repos: {}".format(len(git_repos), git_repos))
+
+    conf_path = os.path.relpath(os.path.join(builddir, "conf"), setupdir)
+    repo_paths = [os.path.relpath(os.path.join(layerdir, repo), setupdir) for repo in git_repos]
+    logger.debug("configure_vscode: conf_path={}, repo_paths={}".format(conf_path, repo_paths))
+
+    # Load existing workspace
+    workspace_file = os.path.join(setupdir, "bitbake.code-workspace")
+    workspace = {
+        "extensions": {
+            "recommendations": [
+                "yocto-project.yocto-bitbake"
+            ]
+        }
+    }
+    if os.path.exists(workspace_file):
+        logger.debug("configure_vscode: loading existing workspace file: {}".format(workspace_file))
+        try:
+            with open(workspace_file, 'r') as f:
+                workspace = json.load(f)
+            logger.debug("configure_vscode: loaded workspace with {} folders, {} settings".format(
+                len(workspace.get("folders", [])), len(workspace.get("settings", {}))))
+        except (json.JSONDecodeError, OSError) as e:
+            logger.error(
+                "Unable to read existing workspace file {}: {}. Skipping update.".format(
+                    workspace_file, str(e)
+                )
+            )
+            return
+    else:
+        logger.debug("configure_vscode: creating new workspace file: {}".format(workspace_file))
+
+    # Update folders
+    existing_folders = workspace.get("folders", [])
+    new_folders = [{"name": "conf", "path": conf_path}]
+    for rp in repo_paths:
+        repo_name = os.path.basename(rp)
+        new_folders.append({"name": repo_name, "path": rp})
+    # Keep any user-added folders that are not managed
+    managed_paths = {f["path"] for f in new_folders}
+    for f in existing_folders:
+        if f["path"] not in managed_paths:
+            new_folders.append(f)
+            logger.debug("configure_vscode: keeping user-added folder: {}".format(f["path"]))
+    workspace["folders"] = new_folders
+    logger.debug("configure_vscode: updated workspace with {} folders".format(len(new_folders)))
+
+    # Build Python extra paths for each layer
+    extra_paths = []
+    subdirs_to_check = ['lib', 'scripts']
+    for repo in git_repos:
+        repo_path_abs = os.path.join(layerdir, repo)
+        for root, dirs, files in os.walk(repo_path_abs):
+            for subdir in subdirs_to_check:
+                if subdir in dirs:
+                    sub_path = os.path.join(root, subdir)
+                    if os.path.isdir(sub_path):
+                        extra_paths.append(sub_path)
+
+    # Update settings
+    existing_settings = workspace.get("settings", {})
+    new_settings = {
+        "bitbake.disableConfigModification": True,
+        "bitbake.pathToBitbakeFolder": os.path.join(layerdir, "bitbake"),
+        "bitbake.pathToBuildFolder": builddir,
+        "bitbake.pathToEnvScript": init_script,
+        "bitbake.workingDirectory": builddir,
+        "files.associations": {
+            "*.conf": "bitbake",
+            "*.inc": "bitbake"
+        },
+        "files.exclude": {
+            "**/.git/**": True
+        },
+        "search.exclude": {
+            "**/.git/**": True,
+            "**/logs/**": True
+        },
+        "files.watcherExclude": {
+            "**/.git/**": True,
+            "**/logs/**": True
+        },
+        "python.analysis.exclude": [
+            "**/.git/**",
+            "**/logs/**"
+        ],
+        "python.autoComplete.extraPaths": extra_paths,
+        "python.analysis.extraPaths": extra_paths
+    }
+
+    # Merge settings: add missing, update bitbake paths
+    for key, value in new_settings.items():
+        if key not in existing_settings:
+            existing_settings[key] = value
+        elif key.startswith("bitbake."):
+            existing_settings[key] = value
+        elif key in [
+            "files.associations",
+            "files.exclude",
+            "search.exclude",
+            "files.watcherExclude",
+            "python.analysis.exclude",
+            "python.autoComplete.extraPaths",
+            "python.analysis.extraPaths",
+        ]:
+            # For dicts and lists, merge
+            if isinstance(value, dict):
+                if not isinstance(existing_settings[key], dict):
+                    existing_settings[key] = {}
+                for k, v in value.items():
+                    if k not in existing_settings[key]:
+                        existing_settings[key][k] = v
+            elif isinstance(value, list):
+                if not isinstance(existing_settings[key], list):
+                    existing_settings[key] = []
+                for item in value:
+                    if item not in existing_settings[key]:
+                        existing_settings[key].append(item)
+
+    workspace["settings"] = existing_settings
+    logger.debug("configure_vscode: merged settings, total {} keys".format(len(existing_settings)))
+
+    with open(workspace_file, 'w') as f:
+        json.dump(workspace, f, indent=4)
+    logger.debug("configure_vscode: wrote workspace file: {}".format(workspace_file))
 
 def init_config(top_dir, settings, args):
     create_siteconf(top_dir, args.non_interactive, settings)
@@ -611,7 +767,8 @@ def init_config(top_dir, settings, args):
                 setup_dir_name = n
 
     setupdir = os.path.join(os.path.abspath(top_dir), setup_dir_name)
-    if os.path.exists(os.path.join(setupdir, "layers")):
+    layerdir = os.path.join(setupdir, "layers")
+    if os.path.exists(layerdir):
         logger.info(f"Setup already initialized in:\n    {setupdir}\nUse 'bitbake-setup status' to check if it needs to be updated, or 'bitbake-setup update' to perform the update.\nIf you would like to start over and re-initialize in this directory, remove it, and run 'bitbake-setup init' again.")
         return
 
@@ -625,7 +782,6 @@ def init_config(top_dir, settings, args):
     os.makedirs(setupdir, exist_ok=True)
 
     confdir = os.path.join(setupdir, "config")
-    layerdir = os.path.join(setupdir, "layers")
 
     os.makedirs(confdir)
     os.makedirs(layerdir)
@@ -639,7 +795,11 @@ def init_config(top_dir, settings, args):
     bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
 
     write_upstream_config(confdir, upstream_config)
-    update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes")
+    bitbake_builddir, init_script = update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes", init_vscode=(args.init_vscode == 'yes'))
+
+    # Source the build environment to verify setup and prepare for VSCode if needed
+    if args.init_vscode == 'yes':
+        configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
 
     bb.event.remove("bb.build.TaskProgress", None)
 
@@ -706,8 +866,10 @@ def build_status(top_dir, settings, args, d, update=False):
     if config_diff:
         logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
         if update:
-            update_build(new_upstream_config, confdir, setupdir, layerdir, d,
-                         update_bb_conf=args.update_bb_conf)
+            bitbake_builddir, init_script = update_build(new_upstream_config, confdir, setupdir, layerdir, d,
+                         update_bb_conf=args.update_bb_conf, init_vscode=(args.init_vscode == 'yes'))
+            if args.init_vscode == 'yes':
+                configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
         else:
             bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
         return
@@ -715,8 +877,10 @@ def build_status(top_dir, settings, args, d, update=False):
     layer_config = merge_overrides_into_sources(current_upstream_config["data"]["sources"], current_upstream_config["source-overrides"]["sources"])
     if are_layers_changed(layer_config, layerdir, d):
         if update:
-            update_build(current_upstream_config, confdir, setupdir, layerdir,
-                         d, update_bb_conf=args.update_bb_conf)
+            bitbake_builddir, init_script = update_build(current_upstream_config, confdir, setupdir, layerdir,
+                         d, update_bb_conf=args.update_bb_conf, init_vscode=(args.init_vscode == 'yes'))
+            if args.init_vscode == 'yes':
+                configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
         return
 
     logger.plain("\nConfiguration in {} has not changed.".format(setupdir))
@@ -993,6 +1157,8 @@ def main():
     parser_init.add_argument('--skip-selection', action='append', help='Do not select and set an option/fragment from available choices; the resulting bitbake configuration may be incomplete.')
     parser_init.add_argument('-L', '--use-local-source', default=[], action='append', nargs=2, metavar=('SOURCE_NAME', 'PATH'),
                         help='Symlink local source into a build, instead of getting it as prescribed by a configuration (useful for local development).')
+    parser_init.add_argument('--init-vscode', choices=['yes', 'no'], default='yes' if shutil.which('code') else 'no',
+                        help='Generate VSCode workspace configuration (default: %(default)s)')
     parser_init.set_defaults(func=init_config)
 
     parser_status = subparsers.add_parser('status', help='Check if the setup needs to be synchronized with configuration')
@@ -1002,6 +1168,8 @@ def main():
     parser_update = subparsers.add_parser('update', help='Update a setup to be in sync with configuration')
     add_setup_dir_arg(parser_update)
     parser_update.add_argument('--update-bb-conf', choices=['prompt', 'yes', 'no'], default='prompt', help='Update bitbake configuration files (bblayers.conf, local.conf) (default: prompt)')
+    parser_update.add_argument('--init-vscode', choices=['yes', 'no'], default='yes' if shutil.which('code') else 'no',
+                        help='Generate VSCode workspace configuration (default: %(default)s)')
     parser_update.set_defaults(func=build_update)
 
     parser_install_buildtools = subparsers.add_parser('install-buildtools', help='Install buildtools which can help fulfil missing or incorrect dependencies on the host machine')
-- 
2.52.0


