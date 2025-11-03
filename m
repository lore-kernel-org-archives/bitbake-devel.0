Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1941CCF9F8
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 13:58:11 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21002.1762178286242323358
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 03 Nov 2025 05:58:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=K5gL1rrT;
 spf=pass (domain: gmail.com, ip: 209.85.128.45, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471191ac79dso49994915e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 05:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762178284; x=1762783084; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDh6ka+EPfFOXGFtWVFH6LriJ5GX4oYqKC4dMITuyFg=;
        b=K5gL1rrT4m5wIvIbXsVeR6Wz/wP7qQjkXtToO+Xei5S+6dSO3SYJFq+/D56yjsVDuC
         mcdJp9cuNzMq3ovQhD0sRZq0K+HCkqsYlXSbP+GwNQSJruwF8chLnhYL4Be6PEYNeAyG
         KD/UWGgvpNH1OmMlHPaOZeQ38mqTOk9i4BeoNZ7XleBwbJkp000dLuisi+K3gGyVsSHQ
         xPuReW5za+XeDgP953b7VmQ5SXnJfiXd5IlzZOPAo3daSHwb7oZ/cUulp3rbFDGczksg
         VBrrCzdb8AnOV7Ly64+rH5mGg7oTINUT1n90s4ooOprBtg3pgYlTMWK91RPdHrYmdSzz
         7cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762178284; x=1762783084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDh6ka+EPfFOXGFtWVFH6LriJ5GX4oYqKC4dMITuyFg=;
        b=cnfujfwHgBk+UriADahT6ZyjNgZykyIdr9WPvV0RBxigvo3Q65gWbTK4qoLW/CipXD
         vCcPURBeqN8mbFjeGcYXyF6JazPuACjkWDn3Jtmz8AbYVq8Fr6/JY/X/MfuPowsDFVBA
         WaeaAaJ04T24jSLTnysmJk4QqI1CxMqVldW8dW3NlSM75mDhUqX4PP3FZuBOAGoY2ATk
         0XbgnkgzVOSgU/9hoglVKO0F1T5jqvGlnPLe8lMhK/FUpFSgT234YqfVEUZ6b/HKhXhR
         PPNPysCyuTR53X46CR1SNgz1hUkcinVsd0oRZP0LAX6gu4f8RZP3iHWJ8WQJcDc/kbcj
         NZxQ==
X-Gm-Message-State: AOJu0YwmhGg+MxPYKDJCWyzfkcaXyuYujE0SeHqqKZreKizXJDn+q+hV
	hWtfRRzUYcRUnmXguXwn6wySQNTyFs9nAnnQfzfzIc5AiJX1p15W/HSCTXIcbw==
X-Gm-Gg: ASbGnctYZ5PhNJfImOB+UvCU/r7NnHTKftCEAb8jAwQDhpFy8kWbT9jBZHvVCM38Nnt
	J/9w269NSczXnrFoCo/C2dmYLIz7cMCjqluxYkXRnuoOBkLoWpimQcQRh/ROQdkqNLZpdKkZrA5
	zd+Zlgk5YW3FzzK5hWucuSxao4STtp5G0FVLDo+S63E6MGT32UjeHvSHS51dyHWDc7EbsLp0MIH
	+QrD95od76C2iIkIVa5jwzAD/NOo/vGWgdYM4+jlGhxpC1gIivj7U4VQqdOnmCqcJZF928ANURN
	QvnVHTJEj4KQhBxwQkDSsudLFLVwzNjss8BrW37KUbmFuyZOoby4D66Di08sCt2D1hbhYYkTQV5
	lW6ywrS/jMAFbfUOaJLD8UqUBdXmbXOdjrE/r4QvYcnM4Q9O8IXJaAOKk0QlSo+2CwySDyM5q2R
	b/b1XlO5jXsboXleC+mXEP7cuwaM9l0w7n0osrtaIvuL4FrVfcyIvnjGCLSA==
X-Google-Smtp-Source: AGHT+IG6V/h8VfCrLessKuocDPWNRXAHCdjcKnWQ7WFtwegeWReHyZlVTaNKc8jezfsHm9bgXpubNw==
X-Received: by 2002:a05:600c:190e:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-47730802ca0mr117065495e9.6.1762178284168;
        Mon, 03 Nov 2025 05:58:04 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c48daa0sm161543865e9.3.2025.11.03.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:58:03 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: rename 'build' -> 'setup'
Date: Mon,  3 Nov 2025 14:57:59 +0100
Message-Id: <20251103135759.1129769-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 03 Nov 2025 13:58:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18237

From: Alexander Kanavin <alex@linutronix.de>

After a terminology review by Antonin we brainstormed
something less confusing than 'build' and 'build directory'
for the place where bitbake-setup clones layers and
creates a *bitbake* build directory in. People are bound
to get these two confused and mix them up, and 'setup' is
much more distinct and aligns nicely with 'bitbake-setup'.
It's also not claimed by anything else in OE/Yocto.

So before:

top-dir -> build-dir (can be several) -> bitbake build dir, layer dir, config dir

Now:

top-dir -> setup-dir (can be several) -> bitbake build dir, layer dir, config dir

This also updates the respective command line options, I understand it's
a breaking change, but as before the tweaks are simple and we need to get the
terminology right for the users, and now is the time to do it.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup     | 94 +++++++++++++++++++++----------------------
 lib/bb/tests/setup.py | 60 +++++++++++++--------------
 2 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index a0426005f..c05195062 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -114,7 +114,7 @@ def checkout_layers(layers, layerdir, d):
                 os.remove(symlink)
             os.symlink(os.path.relpath(t,layerdir),symlink)
 
-def setup_bitbake_build(bitbake_config, layerdir, builddir, thisdir):
+def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir):
     def _setup_build_conf(layers, build_conf_dir):
         os.makedirs(build_conf_dir)
         layers_s = []
@@ -188,7 +188,7 @@ def setup_bitbake_build(bitbake_config, layerdir, builddir, thisdir):
             f.write('\n')
             f.write(content)
 
-    bitbake_builddir = os.path.join(builddir, "build")
+    bitbake_builddir = os.path.join(setupdir, "build")
     print("Setting up bitbake configuration in\n    {}\n".format(bitbake_builddir))
 
     template = bitbake_config.get("oe-template")
@@ -220,7 +220,7 @@ def setup_bitbake_build(bitbake_config, layerdir, builddir, thisdir):
     _prepend_passthrough_to_init_build_env(bitbake_builddir)
 
     siteconf_symlink = os.path.join(bitbake_confdir, "site.conf")
-    siteconf = os.path.normpath(os.path.join(builddir, '..', "site.conf"))
+    siteconf = os.path.normpath(os.path.join(setupdir, '..', "site.conf"))
     if os.path.lexists(siteconf_symlink):
         os.remove(symlink)
     os.symlink(os.path.relpath(siteconf, bitbake_confdir) ,siteconf_symlink)
@@ -267,7 +267,7 @@ def get_registry_config(registry_path, id):
                 return os.path.join(root, f)
     raise Exception("Unable to find {} in available configurations; use 'list' sub-command to see what is available".format(id))
 
-def update_build(config, confdir, builddir, layerdir, d):
+def update_build(config, confdir, setupdir, layerdir, d):
     layer_config = config["data"]["sources"]
     layer_overrides = config["source-overrides"]["sources"]
     for k,v in layer_overrides.items():
@@ -276,7 +276,7 @@ def update_build(config, confdir, builddir, layerdir, d):
     checkout_layers(layer_config, layerdir, d)
     bitbake_config = config["bitbake-config"]
     thisdir = os.path.dirname(config["path"]) if config["type"] == 'local' else None
-    setup_bitbake_build(bitbake_config, layerdir, builddir, thisdir)
+    setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir)
 
 def int_input(allowed_values):
     n = None
@@ -441,22 +441,22 @@ def init_config(top_dir, settings, args, d):
     upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
     print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
-    builddir = os.path.join(os.path.abspath(top_dir), args.build_dir_name or "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
-    if os.path.exists(os.path.join(builddir, "layers")):
-        print(f"Build already initialized in:\n    {builddir}\nUse 'bitbake-setup status' to check if it needs to be updated, or 'bitbake-setup update' to perform the update.\nIf you would like to start over and re-initialize a build in this directory, remove it, and run 'bitbake-setup init' again.")
+    setupdir = os.path.join(os.path.abspath(top_dir), args.setup_dir_name or "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
+    if os.path.exists(os.path.join(setupdir, "layers")):
+        print(f"Setup already initialized in:\n    {setupdir}\nUse 'bitbake-setup status' to check if it needs to be updated, or 'bitbake-setup update' to perform the update.\nIf you would like to start over and re-initialize in this directory, remove it, and run 'bitbake-setup init' again.")
         return
 
-    print("Initializing a build in\n    {}".format(builddir))
+    print("Initializing a setup in\n    {}".format(setupdir))
     if not args.non_interactive:
         y_or_n = input('Continue? (y/N): ')
         if y_or_n != 'y':
             exit()
         print()
 
-    os.makedirs(builddir, exist_ok=True)
+    os.makedirs(setupdir, exist_ok=True)
 
-    confdir = os.path.join(builddir, "config")
-    layerdir = os.path.join(builddir, "layers")
+    confdir = os.path.join(setupdir, "config")
+    layerdir = os.path.join(setupdir, "layers")
 
     os.makedirs(confdir)
     os.makedirs(layerdir)
@@ -471,7 +471,7 @@ def init_config(top_dir, settings, args, d):
 
     write_config(upstream_config, confdir)
     commit_config(confdir)
-    update_build(upstream_config, confdir, builddir, layerdir, d)
+    update_build(upstream_config, confdir, setupdir, layerdir, d)
 
     bb.event.remove("bb.build.TaskProgress", None)
 
@@ -513,10 +513,10 @@ def are_layers_changed(layers, layerdir, d):
     return changed
 
 def build_status(top_dir, settings, args, d, update=False):
-    builddir = args.build_dir
+    setupdir = args.setup_dir
 
-    confdir = os.path.join(builddir, "config")
-    layerdir = os.path.join(builddir, "layers")
+    confdir = os.path.join(setupdir, "config")
+    layerdir = os.path.join(setupdir, "layers")
 
     current_upstream_config = json.load(open(os.path.join(confdir, "config-upstream.json")))
 
@@ -530,20 +530,20 @@ def build_status(top_dir, settings, args, d, update=False):
     config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
 
     if config_diff:
-        print('\nConfiguration in {} has changed:\n{}'.format(builddir, config_diff))
+        print('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
         if update:
             commit_config(confdir)
-            update_build(new_upstream_config, confdir, builddir, layerdir, d)
+            update_build(new_upstream_config, confdir, setupdir, layerdir, d)
         else:
             bb.process.run('git -C {} restore config-upstream.json'.format(confdir))
         return
 
     if are_layers_changed(current_upstream_config["data"]["sources"], layerdir, d):
         if update:
-            update_build(current_upstream_config, confdir, builddir, layerdir, d)
+            update_build(current_upstream_config, confdir, setupdir, layerdir, d)
         return
 
-    print("\nConfiguration in {} has not changed.".format(builddir))
+    print("\nConfiguration in {} has not changed.".format(setupdir))
 
 def build_update(top_dir, settings, args, d):
     build_status(top_dir, settings, args, d, update=True)
@@ -616,7 +616,7 @@ def list_configs(top_dir, settings, args, d):
         print("Available configurations written into {}".format(args.write_json))
 
 def install_buildtools(top_dir, settings, args, d):
-    buildtools_install_dir = os.path.join(args.build_dir, 'buildtools')
+    buildtools_install_dir = os.path.join(args.setup_dir, 'buildtools')
     if os.path.exists(buildtools_install_dir):
         if not args.force:
             print("Buildtools are already installed in {}.".format(buildtools_install_dir))
@@ -629,8 +629,8 @@ def install_buildtools(top_dir, settings, args, d):
             return
         shutil.rmtree(buildtools_install_dir)
 
-    install_buildtools = os.path.join(args.build_dir, 'layers/oe-scripts/install-buildtools')
-    buildtools_download_dir = os.path.join(args.build_dir, 'buildtools-downloads/{}'.format(time.strftime("%Y%m%d%H%M%S")))
+    install_buildtools = os.path.join(args.setup_dir, 'layers/oe-scripts/install-buildtools')
+    buildtools_download_dir = os.path.join(args.setup_dir, 'buildtools-downloads/{}'.format(time.strftime("%Y%m%d%H%M%S")))
     print("Buildtools archive is downloaded into {} and its content installed into {}".format(buildtools_download_dir, buildtools_install_dir))
     subprocess.check_call("{} -d {} --downloads-directory {}".format(install_buildtools, buildtools_install_dir, buildtools_download_dir), shell=True)
 
@@ -696,24 +696,24 @@ def settings_func(top_dir, all_settings, args):
     elif args.subcommand == 'set' or args.subcommand == 'unset':
         change_setting(top_dir, args)
 
-def get_build_dir_via_bbpath():
+def get_setup_dir_via_bbpath():
     bbpath = os.environ.get('BBPATH')
     if bbpath:
         bitbake_dir = os.path.normpath(bbpath.split(':')[0])
         if os.path.exists(os.path.join(bitbake_dir,'init-build-env')):
-            build_dir = os.path.dirname(bitbake_dir)
-            return build_dir
+            setup_dir = os.path.dirname(bitbake_dir)
+            return setup_dir
     return None
 
 def get_top_dir(args, settings):
-    build_dir_via_bbpath = get_build_dir_via_bbpath()
-    if build_dir_via_bbpath:
-        top_dir = os.path.dirname(build_dir_via_bbpath)
+    setup_dir_via_bbpath = get_setup_dir_via_bbpath()
+    if setup_dir_via_bbpath:
+        top_dir = os.path.dirname(setup_dir_via_bbpath)
         if os.path.exists(default_settings_path(top_dir)):
             return top_dir
 
-    if hasattr(args, 'build_dir'):
-        top_dir = os.path.dirname(os.path.normpath(args.build_dir))
+    if hasattr(args, 'setup_dir'):
+        top_dir = os.path.dirname(os.path.normpath(args.setup_dir))
         return top_dir
 
     top_dir_prefix = settings['default']['top-dir-prefix']
@@ -734,12 +734,12 @@ def merge_settings(builtin_settings, global_settings, local_settings, cmdline_se
     return all_settings
 
 def main():
-    def add_build_dir_arg(parser):
-        build_dir = get_build_dir_via_bbpath()
-        if build_dir:
-            parser.add_argument('--build-dir', default=build_dir, help="Path to the build, default is %(default)s via BBPATH")
+    def add_setup_dir_arg(parser):
+        setup_dir = get_setup_dir_via_bbpath()
+        if setup_dir:
+            parser.add_argument('--setup-dir', default=setup_dir, help="Path to the setup, default is %(default)s via BBPATH")
         else:
-            parser.add_argument('--build-dir', required=True, help="Path to the build")
+            parser.add_argument('--setup-dir', required=True, help="Path to the setup")
 
     parser = argparse.ArgumentParser(
         description="BitBake setup utility. Run with 'init' argument to get started.",
@@ -761,24 +761,24 @@ def main():
     parser_list.add_argument('--write-json', action='store', help='Write available configurations into a json file so they can be programmatically processed.')
     parser_list.set_defaults(func=list_configs)
 
-    parser_init = subparsers.add_parser('init', help='Select a configuration and initialize a build from it')
+    parser_init = subparsers.add_parser('init', help='Select a configuration and initialize a setup from it')
     parser_init.add_argument('config', nargs='*', help="path/URL/id to a configuration file (use 'list' command to get available ids), followed by configuration options. Bitbake-setup will ask to choose from available choices if command line doesn't completely specify them.")
     parser_init.add_argument('--non-interactive', action='store_true', help='Do not ask to interactively choose from available options; if bitbake-setup cannot make a decision it will stop with a failure.')
     parser_init.add_argument('--source-overrides', action='store', help='Override sources information (repositories/revisions) with values from a local json file.')
-    parser_init.add_argument('--build-dir-name', action='store', help='A custom build directory name under the top directory.')
+    parser_init.add_argument('--setup-dir-name', action='store', help='A custom setup directory name under the top directory.')
     parser_init.add_argument('--skip-selection', action='append', help='Do not select and set an option/fragment from available choices; the resulting bitbake configuration may be incomplete.')
     parser_init.set_defaults(func=init_config)
 
-    parser_status = subparsers.add_parser('status', help='Check if the build needs to be synchronized with configuration')
-    add_build_dir_arg(parser_status)
+    parser_status = subparsers.add_parser('status', help='Check if the setup needs to be synchronized with configuration')
+    add_setup_dir_arg(parser_status)
     parser_status.set_defaults(func=build_status)
 
-    parser_update = subparsers.add_parser('update', help='Update a build to be in sync with configuration')
-    add_build_dir_arg(parser_update)
+    parser_update = subparsers.add_parser('update', help='Update a setup to be in sync with configuration')
+    add_setup_dir_arg(parser_update)
     parser_update.set_defaults(func=build_update)
 
     parser_install_buildtools = subparsers.add_parser('install-buildtools', help='Install buildtools which can help fulfil missing or incorrect dependencies on the host machine')
-    add_build_dir_arg(parser_install_buildtools)
+    add_setup_dir_arg(parser_install_buildtools)
     parser_install_buildtools.add_argument('--force', action='store_true', help='Force a reinstall of buildtools over the previous installation.')
     parser_install_buildtools.set_defaults(func=install_buildtools)
 
@@ -786,7 +786,7 @@ def main():
     parser_settings_arg_global.add_argument('--global', action='store_true', help="Modify the setting in a global settings file, rather than one specific to a top directory")
 
     parser_settings = subparsers.add_parser('settings',
-                                            help='List current settings, or set or unset a setting in a settings file (e.g. the default prefix and name of the top directory, the location of build configuration registry, downloads directory and other settings specific to a top directory)')
+                                            help='List current settings, or set or unset a setting in a settings file (e.g. the default prefix and name of the top directory, the location of configuration registry, downloads directory and other settings specific to a top directory)')
     parser_settings.set_defaults(func=settings_func)
 
     subparser_settings = parser_settings.add_subparsers(dest="subcommand", required=True, help="The action to perform on the settings file")
@@ -820,9 +820,9 @@ def main():
                          level=logger.getEffectiveLevel())
 
     if 'func' in args:
-        if hasattr(args, 'build_dir'):
-            if not os.path.exists(os.path.join(args.build_dir,'build', 'init-build-env')):
-                print("Not a valid build directory: build/init-build-env does not exist in {}".format(args.build_dir))
+        if hasattr(args, 'setup_dir'):
+            if not os.path.exists(os.path.join(args.setup_dir,'build', 'init-build-env')):
+                print("Not a valid setup directory: build/init-build-env does not exist in {}".format(args.setup_dir))
                 return
 
         if not hasattr(args, 'non_interactive'):
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index e320cdf56..a17b8ac46 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -109,19 +109,19 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         "configurations": [
             {
                 "name": "gadget",
-                "description": "Gadget build configuration",
+                "description": "Gadget configuration",
                 "oe-template": "test-configuration-gadget",
                 "oe-fragments": ["test-fragment-1"]
             },
             {
                 "name": "gizmo",
-                "description": "Gizmo build configuration",
+                "description": "Gizmo configuration",
                 "oe-template": "test-configuration-gizmo",
                 "oe-fragments": ["test-fragment-2"]
             },
             {
                 "name": "gizmo-env-passthrough",
-                "description": "Gizmo build configuration with environment-passthrough",
+                "description": "Gizmo configuration with environment-passthrough",
                 "bb-layers": ["layerC","layerD/meta-layer"],
                 "oe-fragments": ["test-fragment-1"],
                 "bb-env-passthrough-additions": [
@@ -132,24 +132,24 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             },
             {
                 "name": "gizmo-no-fragment",
-                "description": "Gizmo no-fragment template-only build configuration",
+                "description": "Gizmo no-fragment template-only configuration",
                 "oe-template": "test-configuration-gizmo"
             },
             {
                 "name": "gadget-notemplate",
-                "description": "Gadget notemplate build configuration",
+                "description": "Gadget notemplate configuration",
                 "bb-layers": ["layerA","layerB/meta-layer"],
                 "oe-fragments": ["test-fragment-1"]
             },
             {
                 "name": "gizmo-notemplate",
-                "description": "Gizmo notemplate build configuration",
+                "description": "Gizmo notemplate configuration",
                 "bb-layers": ["layerC","layerD/meta-layer"],
                 "oe-fragments": ["test-fragment-2"]
             },
             {
                 "name": "gizmo-notemplate-with-thisdir",
-                "description": "Gizmo notemplate build configuration using THISDIR",
+                "description": "Gizmo notemplate configuration using THISDIR",
                 "bb-layers": ["layerC","layerD/meta-layer","{THISDIR}/layerE/meta-layer"],
                 "oe-fragments": ["test-fragment-2"]
             }
@@ -177,11 +177,11 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         self.git('add {}'.format(name), cwd=self.testrepopath)
         self.git('commit -m "Adding {}"'.format(name), cwd=self.testrepopath)
 
-    def check_builddir_files(self, buildpath, test_file_content, json_config):
-        with open(os.path.join(buildpath, 'layers', 'test-repo', 'test-file')) as f:
+    def check_setupdir_files(self, setuppath, test_file_content, json_config):
+        with open(os.path.join(setuppath, 'layers', 'test-repo', 'test-file')) as f:
             self.assertEqual(f.read(), test_file_content)
         bitbake_config = json_config["bitbake-config"]
-        bb_build_path = os.path.join(buildpath, 'build')
+        bb_build_path = os.path.join(setuppath, 'build')
         bb_conf_path = os.path.join(bb_build_path, 'conf')
         self.assertTrue(os.path.exists(os.path.join(bb_build_path, 'init-build-env')))
 
@@ -203,7 +203,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                         )
                         self.assertIn(thisdir_layer, bblayers)
                     else:
-                        self.assertIn(os.path.join(buildpath, "layers", l), bblayers)
+                        self.assertIn(os.path.join(setuppath, "layers", l), bblayers)
 
         if 'oe-fragment' in bitbake_config.keys():
             for f in bitbake_config["oe-fragments"]:
@@ -295,20 +295,20 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         for cf, v in test_configurations.items():
             for c in v['buildconfigs']:
                 out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
-                buildpath = os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
-                with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
+                setuppath = os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
+                with open(os.path.join(setuppath, 'config', "config-upstream.json")) as f:
                     config_upstream = json.load(f)
-                self.check_builddir_files(buildpath, test_file_content, config_upstream)
-                os.environ['BBPATH'] = os.path.join(buildpath, 'build')
+                self.check_setupdir_files(setuppath, test_file_content, config_upstream)
+                os.environ['BBPATH'] = os.path.join(setuppath, 'build')
                 out = self.runbbsetup("status")
-                self.assertIn("Configuration in {} has not changed".format(buildpath), out[0])
+                self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
                 out = self.runbbsetup("update")
-                self.assertIn("Configuration in {} has not changed".format(buildpath), out[0])
+                self.assertIn("Configuration in {} has not changed".format(setuppath), out[0])
 
         # install buildtools
         out = self.runbbsetup("install-buildtools")
         self.assertIn("Buildtools installed into", out[0])
-        self.assertTrue(os.path.exists(os.path.join(buildpath, 'buildtools')))
+        self.assertTrue(os.path.exists(os.path.join(setuppath, 'buildtools')))
 
         # change a file in the test layer repo, make a new commit and
         # test that status/update correctly report the change and update the config
@@ -319,17 +319,17 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                   'gizmo-env-passthrough',
                   'gizmo-no-fragment',
                   'gadget-notemplate', 'gizmo-notemplate'):
-            buildpath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
-            os.environ['BBPATH'] = os.path.join(buildpath, 'build')
+            setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
+            os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             out = self.runbbsetup("status")
-            self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, buildpath), out[0])
+            self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, setuppath), out[0])
             out = self.runbbsetup("update")
             if c in ('gadget', 'gizmo'):
-                self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(buildpath), out[0])
+                self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
-            with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
+            with open(os.path.join(setuppath, 'config', "config-upstream.json")) as f:
                 config_upstream = json.load(f)
-            self.check_builddir_files(buildpath, test_file_content, config_upstream)
+            self.check_setupdir_files(setuppath, test_file_content, config_upstream)
 
         # make a new branch in the test layer repo, change a file on that branch,
         # make a new commit, update the top level json config to refer to that branch,
@@ -344,15 +344,15 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                   'gizmo-env-passthrough',
                   'gizmo-no-fragment',
                   'gadget-notemplate', 'gizmo-notemplate'):
-            buildpath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
-            os.environ['BBPATH'] = os.path.join(buildpath, 'build')
+            setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
+            os.environ['BBPATH'] = os.path.join(setuppath, 'build')
             out = self.runbbsetup("status")
-            self.assertIn("Configuration in {} has changed:".format(buildpath), out[0])
+            self.assertIn("Configuration in {} has changed:".format(setuppath), out[0])
             self.assertIn('-                    "rev": "master"\n+                    "rev": "another-branch"', out[0])
             out = self.runbbsetup("update")
             if c in ('gadget', 'gizmo'):
-                self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(buildpath), out[0])
+                self.assertIn("Existing bitbake configuration directory renamed to {}/build/conf-backup.".format(setuppath), out[0])
                 self.assertIn('-{}+{}'.format(prev_test_file_content, test_file_content), out[0])
-            with open(os.path.join(buildpath, 'config', "config-upstream.json")) as f:
+            with open(os.path.join(setuppath, 'config', "config-upstream.json")) as f:
                 config_upstream = json.load(f)
-            self.check_builddir_files(buildpath, test_file_content, config_upstream)
+            self.check_setupdir_files(setuppath, test_file_content, config_upstream)
-- 
2.39.5


