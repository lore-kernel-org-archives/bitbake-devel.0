Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F65D64095
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 08:48:54 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10419.1765961329266099011
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Dec 2025 00:48:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=oc4nTU/2;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B7D534E41C53
	for <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 08:48:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 89C2B6072F
	for <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 08:48:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 083311195031D;
	Wed, 17 Dec 2025 09:48:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1765961323; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qVOAgjcnuPFE+idsQ6YQFyXt/f3DByPC80YOpyoT9F0=;
	b=oc4nTU/2ZzdWTduOari3/A091pv5BaCxFkotRzLgif4DQTmAl8D+A5tKpx3jUazcCLbzNR
	ftZvf1hzxhz57JDvsbs4PQOnMJW8l/rtVsOgD6O0rDWPPw5u9nwn4CVW6omL+/7a85NArw
	UC9XaA6hQHwFIPY55nj4UUPpdifvU9LhEqGz+wOdtnS6oY00Rrx1tzXdhDCIWNnO/BNvy7
	XHjcjCEuMr3dH0QT2WHtW/GUB8Mav4qqIdWGB08VNDXsvRpd2gFZvVdq1DaRMJ+irfCV17
	zlnWX3Op1KxyuA/QYWGoTtM5/c+j7uWOlLm6u7yqiEjgO/H56MpUGxJcDsTvpQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Wed, 17 Dec 2025 09:48:27 +0100
Subject: [PATCH 2/2] bitbake-setup: convert print calls to logger
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-bbsetup-logger-v1-2-6bc7d02c11c6@bootlin.com>
References: <20251217-bbsetup-logger-v1-0-6bc7d02c11c6@bootlin.com>
In-Reply-To: <20251217-bbsetup-logger-v1-0-6bc7d02c11c6@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=29551;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=aBTf8m9VZ3jgZttwQYNZ3YIm+dDDJ9iuzMKhTTMsywY=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBpQm5hV6cjIBe7nCKHY+7uKxbkm6HlDO2gJrIoZ
 CB2aC8eLcGJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaUJuYQAKCRDRgEFAKaOo
 Nku6D/9a8CuipY/AnX+ETyPQMGBB69C4SyMeocITujXPEfye2f/yd6ks84UuTRzzaB1xNLBZnlk
 kbLr3sK9XcJi6EmdT1ZJDdQEawOlRuLPHqXmdcqtfzTC7aNZ0ecaNv/m+sAIQnHHlXRdgnhCZZ6
 fG1rMFU/BzqcezBWpNisiKvP3K5drjMmF/W4vJ76EYGcI3DqkBgvK5iHjBJJPX2711/LYJosZMR
 iyVts7wc7V77+TETUqhgzfKymB+RM1Q4qqOFYSIaRgxDwwXPEIfRH0d3QN9OCJN+UGvdC/224fm
 PBt1/QrCwbG7naRYOp1aSD/gCV9CERwZnQW4fOx0rqbCrIsMYWs3luY+HwgIo34z7y5RlG+2kLI
 ryBA6gBdBvbpZNPXtll8PeXqgv7JPaEvXZZbgdQAzmG8ulel+wmgskmCgASsBkb2EDJrlr9Bhlh
 Il/+txVc/FI6BgYSM3sKwjeEA25CLwmtrSF1CmdH2NKGmQvGroKQqrgNuaRHNZagQ7jX7bEDJMs
 vqdGiirfM2+sKwwwyfGGVL0+VCX3NtktZfOxf6IpB3iK82C+yJ1ikhk9hSOsy4XYt6A7AUm/2yz
 kBxWCmsyG1sD4rd4eMsm2QQRcseeaz0/msdw7P8s6NpSOaDgIl+wB9uN/1dcYgORMiwDByzhsPw
 GCefqb9ecnfxyFg==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Dec 2025 08:48:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18605

We already have a logger defined but don't use it for logging. Convert
existing print calls to use the logger, categorizing them by importance
with the levels we have.

Most of the calls are replaced with logger.plain, which renders the same
way as print. Other messages are preceded by their level (NOTE:,
WARNING:, etc.).

This does not change the verbosity of bitbake-setup, all current
messages are still printed.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 bin/bitbake-setup | 154 +++++++++++++++++++++++++++---------------------------
 1 file changed, 78 insertions(+), 76 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 1d93ed05c1..70ece7de74 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -93,7 +93,7 @@ def checkout_layers(layers, layerdir, d):
     layers_fixed_revisions = copy.deepcopy(layers)
     repodirs = []
     oesetupbuild = None
-    print("Fetching layer/tool repositories into {}".format(layerdir))
+    logger.plain("Fetching layer/tool repositories into {}".format(layerdir))
     for r_name in layers:
         r_data = layers[r_name]
         repodir = r_data.get("path", r_name)
@@ -107,7 +107,7 @@ def checkout_layers(layers, layerdir, d):
         for remote in remotes:
             prot,host,path,user,pswd,params = bb.fetch.decodeurl(remotes[remote]["uri"])
             fetchuri = bb.fetch.encodeurl(('git',host,path,user,pswd,params))
-            print("    {}".format(r_name))
+            logger.plain("    {}".format(r_name))
             if branch:
                 src_uri = f"{fetchuri};protocol={prot};rev={rev};branch={branch};destsuffix={repodir}"
             else:
@@ -122,7 +122,7 @@ def checkout_layers(layers, layerdir, d):
             oesetupbuild = os.path.join(layerdir, repodir, 'scripts/oe-setup-build')
             oeinitbuildenvdir = os.path.join(layerdir, repodir)
 
-    print("        ")
+    logger.plain("        ")
     _write_layer_list(layerdir, repodirs)
 
     if oesetupbuild:
@@ -213,12 +213,12 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
             f.write(content)
 
     bitbake_builddir = os.path.join(setupdir, "build")
-    print("Setting up bitbake configuration in\n    {}\n".format(bitbake_builddir))
+    logger.plain("Setting up bitbake configuration in\n    {}\n".format(bitbake_builddir))
 
     template = bitbake_config.get("oe-template")
     layers = bitbake_config.get("bb-layers")
     if not template and not layers:
-        print("Bitbake configuration does not contain a reference to an OpenEmbedded build template via 'oe-template' or a list of layers via 'bb-layers'; please use oe-setup-build, oe-init-build-env or another mechanism manually to complete the setup.")
+        logger.error("Bitbake configuration does not contain a reference to an OpenEmbedded build template via 'oe-template' or a list of layers via 'bb-layers'; please use oe-setup-build, oe-init-build-env or another mechanism manually to complete the setup.")
         return
     oesetupbuild = os.path.join(layerdir, 'setup-build')
     if template and not os.path.exists(oesetupbuild):
@@ -231,7 +231,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
 
     if os.path.exists(bitbake_confdir):
         os.rename(bitbake_confdir, backup_bitbake_confdir)
-        print("Existing bitbake configuration directory renamed to {}".format(backup_bitbake_confdir))
+        logger.info("Existing bitbake configuration directory renamed to {}".format(backup_bitbake_confdir))
 
     if layers:
         filerelative_layers = bitbake_config.get("bb-layers-file-relative") or []
@@ -242,7 +242,7 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
     else:
         oeinitbuildenvdir = os.path.join(layerdir, 'oe-init-build-env-dir')
         if not os.path.exists(os.path.join(oeinitbuildenvdir, "oe-init-build-env")):
-            print("Could not find oe-init-build-env in any of the layers; please use another mechanism to initialize the bitbake environment")
+            logger.error("Could not find oe-init-build-env in any of the layers; please use another mechanism to initialize the bitbake environment")
             return
         _make_init_build_env(bitbake_builddir, os.path.realpath(oeinitbuildenvdir))
 
@@ -264,13 +264,13 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
     if os.path.exists(backup_bitbake_confdir):
         conf_diff = get_diff(backup_bitbake_confdir, bitbake_confdir)
         if not conf_diff:
-            print('New bitbake configuration from upstream is the same as the current one, no need to update it.')
+            logger.plain('New bitbake configuration from upstream is the same as the current one, no need to update it.')
             shutil.rmtree(bitbake_confdir)
             os.rename(backup_bitbake_confdir, bitbake_confdir)
             return
 
-        print('Upstream bitbake configuration changes were found:')
-        print(conf_diff)
+        logger.plain('Upstream bitbake configuration changes were found:')
+        logger.plain(conf_diff)
 
         if update_bb_conf == 'prompt':
             y_or_n = input('Apply these changes to the current configuration? (y/N): ')
@@ -278,14 +278,14 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
                 update_bb_conf = 'no'
 
         if update_bb_conf == 'no':
-            print('Ignoring upstream bitbake configuration changes')
-            print(f'Leaving the upstream configuration in {upstream_bitbake_confdir}')
+            logger.plain('Ignoring upstream bitbake configuration changes')
+            logger.plain(f'Leaving the upstream configuration in {upstream_bitbake_confdir}')
             os.rename(bitbake_confdir, upstream_bitbake_confdir)
             os.rename(backup_bitbake_confdir, bitbake_confdir)
             return
 
-        print('Applying upstream bitbake configuration changes')
-        print(f'Leaving the previous configuration in {backup_bitbake_confdir}')
+        logger.plain('Applying upstream bitbake configuration changes')
+        logger.plain(f'Leaving the previous configuration in {backup_bitbake_confdir}')
 
     fragment_note = "Run 'bitbake-config-build enable-fragment <fragment-name>' to enable additional fragments or replace built-in ones (e.g. machine/<name> or distro/<name> to change MACHINE or DISTRO)."
 
@@ -305,11 +305,11 @@ The bitbake configuration files (local.conf, bblayers.conf and more) can be foun
     with open(readme_file, 'w') as f:
         f.write(readme)
 
-    print("This bitbake configuration provides:\n    {}\n".format(bitbake_config["description"]))
-    print("Usage instructions and additional information are in\n     {}\n".format(readme_file))
-    print("To run builds, source the environment using\n    . {}\n".format(init_script))
-    print("{}\n".format(fragment_note))
-    print("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
+    logger.plain("This bitbake configuration provides:\n    {}\n".format(bitbake_config["description"]))
+    logger.plain("Usage instructions and additional information are in\n     {}\n".format(readme_file))
+    logger.plain("To run builds, source the environment using\n    . {}\n".format(init_script))
+    logger.plain("{}\n".format(fragment_note))
+    logger.plain("The bitbake configuration files (local.conf, bblayers.conf and more) can be found in\n    {}/conf\n".format(bitbake_builddir))
 
 def get_registry_config(registry_path, id):
     for root, dirs, files in os.walk(registry_path):
@@ -379,15 +379,15 @@ def choose_bitbake_config(configs, parameters, non_interactive):
     enumerated_configs = list(enumerate(flattened_configs, 1))
     if len(enumerated_configs) == 1:
         only_config = flattened_configs[0]
-        print("\nSelecting the only available bitbake configuration {}".format(only_config["name"]))
+        logger.plain("\nSelecting the only available bitbake configuration {}".format(only_config["name"]))
         return only_config
 
     if non_interactive:
         raise Exception("Unable to choose from bitbake configurations in non-interactive mode: {}".format(configs_dict))
 
-    print("\nAvailable bitbake configurations:")
+    logger.plain("\nAvailable bitbake configurations:")
     for n, config_data in enumerated_configs:
-        print("{}. {}\t{}".format(n, config_data["name"], config_data["description"]))
+        logger.plain("{}. {}\t{}".format(n, config_data["name"], config_data["description"]))
     config_n = int_input([i[0] for i in enumerated_configs],
                          "\nPlease select one of the above bitbake configurations by its number: ") - 1
     return flattened_configs[config_n]
@@ -397,21 +397,21 @@ def choose_config(configs, non_interactive):
     config_list = list(enumerate(not_expired_configs, 1))
     if len(config_list) == 1:
         only_config = config_list[0][1]
-        print("\nSelecting the only available configuration {}\n".format(only_config))
+        logger.plain("\nSelecting the only available configuration {}\n".format(only_config))
         return only_config
 
     if non_interactive:
         raise Exception("Unable to choose from configurations in non-interactive mode: {}".format(not_expired_configs))
 
-    print("\nAvailable configurations:")
+    logger.plain("\nAvailable configurations:")
     for n, config_name in config_list:
         config_data = configs[config_name]
         expiry_date = config_data.get("expires", None)
         config_desc = config_data["description"]
         if expiry_date:
-           print("{}. {}\t{} (supported until {})".format(n, config_name, config_desc, expiry_date))
+           logger.plain("{}. {}\t{} (supported until {})".format(n, config_name, config_desc, expiry_date))
         else:
-           print("{}. {}\t{}".format(n, config_name, config_desc))
+           logger.plain("{}. {}\t{}".format(n, config_name, config_desc))
     config_n = int_input([i[0] for i in config_list],
                          "\nPlease select one of the above configurations by its number: ") - 1
     return config_list[config_n][1]
@@ -420,7 +420,7 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
     choices = {}
     for k,v in possibilities.items():
         if skip_selection and k in skip_selection:
-            print("Skipping a selection of {}, as requested on command line. The resulting bitbake configuration may require further manual adjustments.".format(k))
+            logger.info("Skipping a selection of {}, as requested on command line. The resulting bitbake configuration may require further manual adjustments.".format(k))
             continue
         choice = [o for o in v["options"] if o in parameters]
         if len(choice) > 1:
@@ -432,10 +432,10 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
         if non_interactive:
             raise Exception("Unable to choose from options in non-interactive mode: {}".format(v["options"]))
 
-        print("\n" + v["description"] + ":")
+        logger.plain("\n" + v["description"] + ":")
         options_enumerated = list(enumerate(v["options"], 1))
         for n,o in options_enumerated:
-            print("{}. {}".format(n, o))
+            logger.plain("{}. {}".format(n, o))
         option_n = int_input([i[0] for i in options_enumerated],
                              "\nPlease select one of the above options by its number: ") - 1
         choices[k] = options_enumerated[option_n][1]
@@ -446,19 +446,19 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
         config_id = args.config[0]
         config_parameters = args.config[1:]
         if os.path.exists(config_id):
-            print("Reading configuration from local file\n    {}".format(config_id))
+            logger.info("Reading configuration from local file\n    {}".format(config_id))
             upstream_config = {'type':'local',
                                'path':os.path.abspath(config_id),
                                'name':get_config_name(config_id),
                                'data':json.load(open(config_id))
                                }
         elif config_id.startswith("http://") or config_id.startswith("https://"):
-            print("Reading configuration from network URI\n    {}".format(config_id))
+            logger.info("Reading configuration from network URI\n    {}".format(config_id))
             import urllib.request
             with urllib.request.urlopen(config_id) as f:
               upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.load(f)}
         else:
-            print("Looking up config {} in configuration registry".format(config_id))
+            logger.info("Looking up config {} in configuration registry".format(config_id))
             registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
             registry_configs = list_registry(registry_path, with_expired=True)
             if config_id not in registry_configs:
@@ -466,7 +466,7 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
             upstream_config = {'type':'registry','registry':settings["default"]["registry"],'name':config_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
         expiry_date = upstream_config['data'].get("expires", None)
         if has_expired(expiry_date):
-            print("This configuration is no longer supported after {}. Please consider changing to a supported configuration.".format(expiry_date))
+            logger.warning("This configuration is no longer supported after {}. Please consider changing to a supported configuration.".format(expiry_date))
     else:
         registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
         registry_configs = list_registry(registry_path, with_expired=True)
@@ -489,11 +489,13 @@ def init_config(top_dir, settings, args):
     def handle_task_progress(event, d):
         rate = event.rate if event.rate else ''
         progress = event.progress if event.progress > 0 else 0
-        print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
+        logger.handlers[0].terminator = '\r'
+        logger.plain("{}% {}                ".format(progress, rate))
+        logger.handlers[0].terminator = '\n'
 
     source_overrides = json.load(open(args.source_overrides)) if args.source_overrides else {'sources':{}}
     upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
-    print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
+    logger.info("Run 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
     if args.setup_dir_name:
         setup_dir_name = args.setup_dir_name
@@ -507,9 +509,9 @@ def init_config(top_dir, settings, args):
             config_setup_dir_name = string.Template(upstream_config['bitbake-config']['setup-dir-name']).substitute(mapping)
             config_setup_dir = os.path.join(top_dir, config_setup_dir_name)
             if os.path.exists(config_setup_dir):
-                print("Setup directory {} (as suggested by configuration) already exists, using the full name instead.\n".format(config_setup_dir))
+                logger.info("Setup directory {} (as suggested by configuration) already exists, using the full name instead.\n".format(config_setup_dir))
             elif settings['default']['use-full-setup-dir-name'] != 'no':
-                print("Using the full setup directory name instead of {} suggested by configuration, as set in the settings.\n".format(config_setup_dir))
+                logger.info("Using the full setup directory name instead of {} suggested by configuration, as set in the settings.\n".format(config_setup_dir))
             else:
                 setup_dir_name = config_setup_dir_name
 
@@ -520,15 +522,15 @@ def init_config(top_dir, settings, args):
 
     setupdir = os.path.join(os.path.abspath(top_dir), setup_dir_name)
     if os.path.exists(os.path.join(setupdir, "layers")):
-        print(f"Setup already initialized in:\n    {setupdir}\nUse 'bitbake-setup status' to check if it needs to be updated, or 'bitbake-setup update' to perform the update.\nIf you would like to start over and re-initialize in this directory, remove it, and run 'bitbake-setup init' again.")
+        logger.info(f"Setup already initialized in:\n    {setupdir}\nUse 'bitbake-setup status' to check if it needs to be updated, or 'bitbake-setup update' to perform the update.\nIf you would like to start over and re-initialize in this directory, remove it, and run 'bitbake-setup init' again.")
         return
 
-    print("Initializing a setup directory in\n    {}".format(setupdir))
+    logger.plain("Initializing a setup directory in\n    {}".format(setupdir))
     if not args.non_interactive:
         y_or_n = input('Continue? (y/N): ')
         if y_or_n != 'y':
             exit()
-        print()
+        logger.plain("")
 
     os.makedirs(setupdir, exist_ok=True)
 
@@ -585,7 +587,7 @@ def are_layers_changed(layers, layerdir, d):
             local_revision = rev_parse_result[0].strip()
             if upstream_revision != local_revision:
                 changed = True
-                print('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remotes[remote]["uri"], os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
+                logger.info('Layer repository {} checked out into {} updated revision {} from {} to {}'.format(remotes[remote]["uri"], os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
 
     return changed
 
@@ -607,7 +609,7 @@ def build_status(top_dir, settings, args, d, update=False):
     config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
 
     if config_diff:
-        print('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
+        logger.plain('\nConfiguration in {} has changed:\n{}'.format(setupdir, config_diff))
         if update:
             commit_config(confdir)
             update_build(new_upstream_config, confdir, setupdir, layerdir, d,
@@ -622,7 +624,7 @@ def build_status(top_dir, settings, args, d, update=False):
                          d, update_bb_conf=args.update_bb_conf)
         return
 
-    print("\nConfiguration in {} has not changed.".format(setupdir))
+    logger.plain("\nConfiguration in {} has not changed.".format(setupdir))
 
 def build_update(top_dir, settings, args, d):
     build_status(top_dir, settings, args, d, update=True)
@@ -648,7 +650,7 @@ def update_registry(registry, cachedir, d):
         full_registrydir = os.path.join(registry, registrydir)
     else:
         full_registrydir = os.path.join(cachedir, registrydir)
-        print("Fetching configuration registry\n    {}\ninto\n    {}".format(registry, full_registrydir))
+        logger.info("Fetching configuration registry\n    {}\ninto\n    {}".format(registry, full_registrydir))
         fetcher = bb.fetch.Fetch(["{};destsuffix={}".format(registry, registrydir)], d)
         do_fetch(fetcher, cachedir)
     return full_registrydir
@@ -683,56 +685,56 @@ def list_configs(settings, args):
     json_data = list_registry(registry_path, args.with_expired)
     shutil.rmtree(top_dir)
 
-    print("Available configurations:")
+    logger.plain("Available configurations:")
     for config_name, config_data in json_data.items():
         expiry_date = config_data.get("expires", None)
         config_desc = config_data["description"]
         if expiry_date:
            if args.with_expired or not has_expired(expiry_date):
-               print("{}\t{} (supported until {})".format(config_name, config_desc, expiry_date))
+               logger.plain("{}\t{} (supported until {})".format(config_name, config_desc, expiry_date))
         else:
-           print("{}\t{}".format(config_name, config_desc))
-    print("\nRun 'init' with one of the above configuration identifiers to set up a build.")
+           logger.plain("{}\t{}".format(config_name, config_desc))
+    logger.plain("\nRun 'init' with one of the above configuration identifiers to set up a build.")
 
     if args.write_json:
         with open(args.write_json, 'w') as f:
             json.dump(json_data, f, sort_keys=True, indent=4)
-        print("Available configurations written into {}".format(args.write_json))
+        logger.plain("Available configurations written into {}".format(args.write_json))
 
 def install_buildtools(top_dir, settings, args, d):
     buildtools_install_dir = os.path.join(args.setup_dir, 'buildtools')
     if os.path.exists(buildtools_install_dir):
         if not args.force:
-            print("Buildtools are already installed in {}.".format(buildtools_install_dir))
+            logger.plain("Buildtools are already installed in {}.".format(buildtools_install_dir))
             env_scripts = glob.glob(os.path.join(buildtools_install_dir, 'environment-setup-*'))
             if env_scripts:
-                print("If you wish to use them, you need to source the environment setup script e.g.")
+                logger.plain("If you wish to use them, you need to source the environment setup script e.g.")
                 for s in env_scripts:
-                    print("$ . {}".format(s))
-            print("You can also re-run bitbake-setup install-buildtools with --force option to force a reinstallation.")
+                    logger.plain("$ . {}".format(s))
+            logger.plain("You can also re-run bitbake-setup install-buildtools with --force option to force a reinstallation.")
             return
         shutil.rmtree(buildtools_install_dir)
 
     install_buildtools = os.path.join(args.setup_dir, 'layers/oe-scripts/install-buildtools')
     buildtools_download_dir = os.path.join(args.setup_dir, 'buildtools-downloads/{}'.format(time.strftime("%Y%m%d%H%M%S")))
-    print("Buildtools archive is downloaded into {} and its content installed into {}".format(buildtools_download_dir, buildtools_install_dir))
+    logger.plain("Buildtools archive is downloaded into {} and its content installed into {}".format(buildtools_download_dir, buildtools_install_dir))
     subprocess.check_call("{} -d {} --downloads-directory {}".format(install_buildtools, buildtools_install_dir, buildtools_download_dir), shell=True)
 
 def create_siteconf(top_dir, non_interactive, settings):
     siteconfpath = os.path.join(top_dir, 'site.conf')
     if os.path.exists(siteconfpath):
-        print('A site.conf file already exists. Please remove it if you would like to replace it with a default one')
+        logger.info('A site.conf file already exists. Please remove it if you would like to replace it with a default one')
     else:
-        print(f'{top_dir} looks like a new top directory. If you would like to use a different directory, answer "n" below and either:')
-        print('\t1) Change the default bitbake-setup settings:')
-        print('\t\tbitbake-setup settings set default top-dir-prefix <PATH>')
-        print('\t\tbitbake-setup settings set default top-dir-name <NAME>')
-        print('\t2) Pass one or more options on the command line to change the top level directory in that invocation only:')
-        print('\t\tbitbake-setup --setting default top-dir-prefix <PATH> ...')
-        print('\t\tbitbake-setup --setting default top-dir-name <NAME> ...')
-        print()
-
-        print('A common site.conf file will be created, please check it is correct before running builds\n    {}\n'.format(siteconfpath))
+        logger.plain(f'{top_dir} looks like a new top directory. If you would like to use a different directory, answer "n" below and either:')
+        logger.plain('\t1) Change the default bitbake-setup settings:')
+        logger.plain('\t\tbitbake-setup settings set default top-dir-prefix <PATH>')
+        logger.plain('\t\tbitbake-setup settings set default top-dir-name <NAME>')
+        logger.plain('\t2) Pass one or more options on the command line to change the top level directory in that invocation only:')
+        logger.plain('\t\tbitbake-setup --setting default top-dir-prefix <PATH> ...')
+        logger.plain('\t\tbitbake-setup --setting default top-dir-name <NAME> ...')
+        logger.plain('')
+
+        logger.plain('A common site.conf file will be created, please check it is correct before running builds\n    {}\n'.format(siteconfpath))
         if not non_interactive:
             y_or_n = input('Proceed? (y/N): ')
             if y_or_n != 'y':
@@ -770,7 +772,7 @@ def global_settings_path(args):
 def load_settings(settings_path):
     settings = configparser.ConfigParser()
     if os.path.exists(settings_path):
-        print('Loading settings from\n    {}\n'.format(settings_path))
+        logger.info('Loading settings from {}'.format(settings_path))
         settings.read_file(open(settings_path))
     return settings
 
@@ -778,7 +780,7 @@ def change_setting(top_dir, args):
     if vars(args)['global']:
         settings_path = global_settings_path(args)
     elif args.setting in GLOBAL_ONLY_SETTINGS:
-        print(f"{args.setting} can only be set in the global config; '--global' is implied")
+        logger.info(f"{args.setting} can only be set in the global config; '--global' is implied")
         settings_path = global_settings_path(args)
     else:
         settings_path = topdir_settings_path(top_dir)
@@ -788,21 +790,21 @@ def change_setting(top_dir, args):
         if args.section not in settings.keys():
             settings[args.section] = {}
         settings[args.section][args.setting] = args.value
-        print(f"From section '{args.section}' the setting '{args.setting}' was changed to '{args.value}'")
+        logger.plain(f"From section '{args.section}' the setting '{args.setting}' was changed to '{args.value}'")
     if args.subcommand == 'unset':
         if args.section in settings.keys() and args.setting in settings[args.section].keys():
             del settings[args.section][args.setting]
-            print(f"From section '{args.section}' the setting '{args.setting}' has been removed")
+            logger.plain(f"From section '{args.section}' the setting '{args.setting}' has been removed")
 
     os.makedirs(os.path.dirname(settings_path), exist_ok=True)
     with open(settings_path, 'w') as settingsfile:
         settings.write(settingsfile)
-    print(f"Settings written to {settings_path}")
+    logger.info(f"Settings written to {settings_path}")
 
 def list_settings(all_settings):
     for section, section_settings in all_settings.items():
         for key, value in section_settings.items():
-            print("{} {} {}".format(section, key, value))
+            logger.plain("{} {} {}".format(section, key, value))
 
 def settings_func(top_dir, all_settings, args):
     if args.subcommand == 'list':
@@ -852,12 +854,12 @@ def merge_settings(builtin_settings, global_settings, topdir_settings, cmdline_s
     return all_settings
 
 def sigint_handler(sig, frame, func, top_dir):
-    print(f'\nShutting down...')
+    logger.plain(f'\nShutting down...')
     if isinstance(top_dir, str) and os.path.exists(top_dir):
         if func in [init_config, build_update]:
-            print(f'{top_dir} may contain an incomplete setup!')
+            logger.warning(f'{top_dir} may contain an incomplete setup!')
         elif func == install_buildtools:
-            print(f'{top_dir} may contain an incomplete buildtools installation!')
+            logger.warning(f'{top_dir} may contain an incomplete buildtools installation!')
     exit()
 
 def main():
@@ -949,7 +951,7 @@ def main():
     if 'func' in args:
         if hasattr(args, 'setup_dir'):
             if not os.path.exists(os.path.join(args.setup_dir,'build', 'init-build-env')):
-                print("Not a valid setup directory: build/init-build-env does not exist in {}".format(args.setup_dir))
+                logger.error("Not a valid setup directory: build/init-build-env does not exist in {}".format(args.setup_dir))
                 return
 
         if not hasattr(args, 'non_interactive'):
@@ -985,7 +987,7 @@ def main():
             list_configs(all_settings, args)
             return
 
-        print('Bitbake-setup is using {} as top directory.\n'.format(top_dir, global_settings_path(args)))
+        logger.info('Bitbake-setup is using {} as top directory.'.format(top_dir, global_settings_path(args)))
 
         if args.func == init_config:
             init_config(top_dir, all_settings, args)

-- 
2.51.0


