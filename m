Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF29FEA81C
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 07:14:11 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16765.1774422847650728674
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 25 Mar 2026 00:14:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=RoOh1FoR;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1329275-20260325071405107f536f5b00020761-n8_y0t@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260325071405107f536f5b00020761
        for <bitbake-devel@lists.openembedded.org>;
        Wed, 25 Mar 2026 08:14:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=owFlcwP31Gm5TeqHR7w0fX9n7gq24jHO/hgERsrv6+Y=;
 b=RoOh1FoRamIjAMOqZizQccMPqOylmMNIyPdv8I2NAIX/4qh56oODYn3LECyMYjKvIXpkfv
 XFAjK0Lr3BlykJ3rSlpDzeBVsoUQZ4cTv5B1rbqpVF2IKhRRAODXfdRblJeLuiIXtKZc4Tje
 HYpf06bnF9XDcZc0FKWadIQFZt7sh63MOF3Te4G9HMGf4G5y7h29HaZ/8hz9J07rbxjsA7CE
 js9R46dq/+o3uzZqqcOrWelVA2CmMIySTwbr9zIxuEMTxxFft+QjKsSgbodZJE7XfoM82qhB
 N+PM600hr4B5wiRgsJcaw1cFfdZTLEqA26Hew/ASoBmtjkaIA5+8qFNw==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH v2 07/10] bitbake-setup: generate config files for VSCode
Date: Wed, 25 Mar 2026 07:51:49 +0100
Message-ID: <20260325071342.47272-8-adrian.freihofer@siemens.com>
In-Reply-To: <20260325071342.47272-1-adrian.freihofer@siemens.com>
References: <20260325071342.47272-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 25 Mar 2026 07:14:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19220

From: Adrian Freihofer <adrian.freihofer@siemens.com>

This change introduces a function to generate a VSCode workspace file
(bitbake.code-workspace). The --init-vscode flag added to bitbake-setup
init defaults to True when the code binary is found on PATH, and can be
passed explicitly to exercise the feature on machines without code (e.g.
when running tests on an autobuilder). Once the workspace file exists,
it is updated automatically on every subsequent run.

This workspace file is preferred over a project-specific
.vscode/settings.json for several reasons:

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

The Python analysis paths (python.analysis.extraPaths) are configured
with absolute paths. This is a workaround for a limitation in the Pylance
extension, which does not correctly resolve ${workspaceFolder:...}
variables in a multi-root workspace context for import resolution. Using
absolute paths ensures that Pylance can find all necessary modules from
the various layers.

There is room for improvement. Starting a terminal (bitbake or any other)
is cumbersome, as VSCode wants to start it for one of the layers rather
than the build directory.

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 bin/bitbake-setup | 175 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 168 insertions(+), 7 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index e8d520687..bebf2e705 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -239,7 +239,7 @@ bitbake-setup init -L {} /path/to/repo/checkout""".format(
 
     return layers_fixed_revisions
 
-def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf):
+def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf, init_vscode=False):
     def _setup_build_conf(layers, filerelative_layers, build_conf_dir):
         os.makedirs(build_conf_dir)
         layers_s = []
@@ -358,6 +358,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
 
 
     init_script = os.path.join(bitbake_builddir, "init-build-env")
+    workspace_file = os.path.join(setupdir, "bitbake.code-workspace")
     shell = "bash"
     fragments = bitbake_config.get("oe-fragments", []) + sorted(bitbake_config.get("oe-fragment-choices",{}).values())
     if fragments:
@@ -369,6 +370,8 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
             logger.plain('New bitbake configuration from upstream is the same as the current one, no need to update it.')
             shutil.rmtree(bitbake_confdir)
             os.rename(backup_bitbake_confdir, bitbake_confdir)
+            if init_vscode or os.path.exists(workspace_file):
+                configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
             return
 
         logger.plain('Upstream bitbake configuration changes were found:')
@@ -384,6 +387,8 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
             logger.plain(f'Leaving the upstream configuration in {upstream_bitbake_confdir}')
             os.rename(bitbake_confdir, upstream_bitbake_confdir)
             os.rename(backup_bitbake_confdir, bitbake_confdir)
+            if init_vscode or os.path.exists(workspace_file):
+                configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
             return
 
         logger.plain('Applying upstream bitbake configuration changes')
@@ -391,17 +396,21 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
 
     fragment_note = "Run 'bitbake-config-build enable-fragment <fragment-name>' to enable additional fragments or replace built-in ones (e.g. machine/<name> or distro/<name> to change MACHINE or DISTRO)."
 
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
@@ -412,6 +421,11 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
     logger.plain("To run builds, source the environment using\n    . {}\n".format(init_script))
     logger.plain("{}\n".format(fragment_note))
     logger.plain("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
+    if init_vscode:
+        logger.plain("To edit the code in VSCode, open the workspace:\n    code {}\n".format(workspace_file))
+
+    if init_vscode or os.path.exists(workspace_file):
+        configure_vscode(setupdir, layerdir, bitbake_builddir, init_script)
 
 def get_registry_config(registry_path, id):
     for root, dirs, files in os.walk(registry_path):
@@ -427,12 +441,12 @@ def merge_overrides_into_sources(sources, overrides):
             layers[k] = v
     return layers
 
-def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt"):
+def update_build(config, confdir, setupdir, layerdir, d, update_bb_conf="prompt", init_vscode=False):
     layer_config = merge_overrides_into_sources(config["data"]["sources"], config["source-overrides"]["sources"])
     sources_fixed_revisions = checkout_layers(layer_config, confdir, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
-    setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf)
+    setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_conf, init_vscode)
     write_sources_fixed_revisions(confdir, layerdir, sources_fixed_revisions)
     commit_config(confdir)
 
@@ -621,6 +635,151 @@ def obtain_overrides(args):
 
     return overrides
 
+def configure_vscode(setupdir, layerdir, builddir, init_script):
+    """
+    Configure the VSCode environment by creating or updating a workspace file.
+
+    Create or update a bitbake.code-workspace file with folders for the layers and build/conf.
+    Managed folders are regenerated; user-added folders are kept. Settings are merged, with
+    managed keys (bitbake.*, python extra paths) always overwritten.
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
+    # Build Python extra paths for each layer - only check top level of each repo
+    extra_paths = []
+    subdirs_to_check = ['lib', 'scripts']
+    for repo in git_repos:
+        repo_path_abs = os.path.join(layerdir, repo)
+        for subdir in subdirs_to_check:
+            sub_path = os.path.join(repo_path_abs, subdir)
+            if os.path.isdir(sub_path):
+                extra_paths.append(sub_path)
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
+    # Merge settings: add missing, always update bitbake paths and python extra paths
+    for key, value in new_settings.items():
+        if key not in existing_settings:
+            existing_settings[key] = value
+        elif key.startswith("bitbake.") or key in [
+            "python.autoComplete.extraPaths",
+            "python.analysis.extraPaths",
+        ]:
+            # Always replace - these are managed/machine-generated settings
+            existing_settings[key] = value
+        elif key in [
+            "files.associations",
+            "files.exclude",
+            "search.exclude",
+            "files.watcherExclude",
+            "python.analysis.exclude",
+        ]:
+            # For dicts and lists, merge new values in without removing user additions
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
@@ -690,7 +849,7 @@ def init_config(top_dir, settings, args):
     bb.event.register("bb.build.TaskProgress", handle_task_progress, data=d)
 
     write_upstream_config(confdir, upstream_config)
-    update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes")
+    update_build(upstream_config, confdir, setupdir, layerdir, d, update_bb_conf="yes", init_vscode=args.init_vscode)
 
     bb.event.remove("bb.build.TaskProgress", None)
 
@@ -1086,6 +1245,8 @@ def main():
     parser_init.add_argument('--skip-selection', action='append', help='Do not select and set an option/fragment from available choices; the resulting bitbake configuration may be incomplete.')
     parser_init.add_argument('-L', '--use-local-source', default=[], action='append', nargs=2, metavar=('SOURCE_NAME', 'PATH'),
                         help='Symlink local source into a build, instead of getting it as prescribed by a configuration (useful for local development).')
+    parser_init.add_argument('--init-vscode', action=argparse.BooleanOptionalAction, default=bool(shutil.which('code')),
+                        help='Generate VSCode workspace configuration (default: %(default)s)')
     parser_init.set_defaults(func=init_config)
 
     parser_status = subparsers.add_parser('status', help='Check if the setup needs to be synchronized with configuration')
-- 
2.53.0


