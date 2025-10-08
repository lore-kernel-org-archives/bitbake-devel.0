Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF46CCD183
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 16:57:19 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.747.1759942635954495336
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Oct 2025 09:57:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Y1H4cNsN;
 spf=pass (domain: gmail.com, ip: 209.85.221.54, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so121089f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Oct 2025 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759942634; x=1760547434; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn1SxDNwrChFeNJbHBsIYc4kQcbOEY+C/agGZjl02FM=;
        b=Y1H4cNsNURCaiUcPddd0mWgISVZXYNZjyT+SeN6Pm48KmQ1ssARXVo25GOBF8M8oMK
         rQ8nq4binA6Js5GWWyof97JOwv9dtCAILHDJcE19voQGjXOBGPoidnudXyVwpZd765mF
         Rkm+ZCch45oAg5sgEA4R0PdPohZ4oip+UG2nK0LasL6W7qZ9ORVvvGIRALMHKt7Q78PZ
         ZogHDUK1qceXm3vfkPch/nEQsnG9bRILFo4eCHWsBHEZ6DE66MssjKAqNGnCv31pp3pF
         AGbuW6m99kQY+ifvKF8E1shyu6Sbl5kpxuym5H46zRpLLlMGgsiFig/Y0UWal6wkDlzj
         DqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942634; x=1760547434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn1SxDNwrChFeNJbHBsIYc4kQcbOEY+C/agGZjl02FM=;
        b=nK/c8q01hVhesFsHJYqjvP8QI76muBW+EKD4KdrWR8XG4KFEGhpUf3yFm/3HumHLEV
         hV7ADEEUMfhzs5XugT+3Cdv1k+/4SohAwmWdbhZ5N9W8BHMK7OkR5QINh6BFbrEN55Fi
         CahL+hXVe8UwTrGS3gchqSgmmwU4Uy9leaW7RV+t0uIw9wsu7zRZhaT3R6MhRvHiToFW
         9qEE4X3exT7oiMkcwtss7h+hiq8hLa6pXSKhg9CJuYJYWd8bPw3kbm/uhfg+eutIQ2Nv
         MlI1tCoGWk4xJ5QL4Ob59LscTQWgwoW0rnW1qjySdQy/dPKx3wgjU9XbCmh2dZJHZH4D
         OANw==
X-Gm-Message-State: AOJu0YyNa6ivT2cJxOF2L+izKXQE9KrkXwiK+fcfex+Hf1iCQnTYGZmT
	sOSWQj5GCKQlNeqGyCsqPArLXMIkiYNcliuzLNZs6kqTTPZv4rqNwHqVUFreGg==
X-Gm-Gg: ASbGnctuOWX32PuZ2ynL6ipQgzSCdT+RHmUbsp1mDpDbS0L4NUVHY+DExemjU8/6NKa
	JWKO+Lbo8XEYfrL7a8+t/bJMrkcqW7jhm5dXtuEUiNPr2wTVyA7SbWL6wHYfo5BeNmLVThYok7d
	jSNkAY+TKg/+4sJJq1FyCrh2FqNn13GgZrCBLpzsGrX8OKuPD6SPkXIHnohblBRTI7vghuEIOD7
	rraVjrJ0QbR8q47wBkWVvslEjXTph8xrwqls6vSMGIJvK7kkNudTv5U82zRU3/DIZRMUW9bjvwb
	d/YmrH1LJPDPYirfmFY7BJr7BqM58V498RialojuEyH03nDAdW1ttXZPe7arnEmA1B00EU1XYDq
	a0fYG9NkoMQbTuKGPOcquO/0adzzyJuV+u05eQRvWQIJd2FUGJ+1gPRyxFJFVH58gOAo1njHk6s
	N+/S2x70/Dii+CWYHasEHOAzK9uKQiESAdN4qI3oxOLsdPIoygyGKdigZ/iF60GVE7NxY558qs/
	Lb0evNODw==
X-Google-Smtp-Source: AGHT+IGEXbRmdyezD1N0DtVWH8H5J6D8IDMwwxSVzj11ijLzK4ds4cZyRhWZMn/1wbP5lmMarTA3+w==
X-Received: by 2002:a5d:5887:0:b0:425:7591:7072 with SMTP id ffacd0b85a97d-4265ef60236mr2359873f8f.0.1759942633794;
        Wed, 08 Oct 2025 09:57:13 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b77sm30740453f8f.6.2025.10.08.09.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:57:13 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 4/4] bitbake-setup: rework the settings handling
Date: Wed,  8 Oct 2025 18:56:59 +0200
Message-Id: <20251008165659.1884881-4-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251008165659.1884881-1-alex.kanavin@gmail.com>
References: <20251008165659.1884881-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Oct 2025 16:57:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18148

From: Alexander Kanavin <alex@linutronix.de>

This is the outcome of various discussions, suggestions and pull
requests on github.

What has specifically changed?

1. The sources for the settings are no longer separated, but are stacked and given priorities,
from highest to lowest:

    a. '--setting section key value' on the command line

    b. a settings file in the top directory

    c. a global settings file in ~/.config/bitbake-setup/ (or in a file pointed to by --global-settings)

Any setting can be in any of these three locations (other than top dir name and prefix which do not
make sense in the settings file in the top directory).

2. A global settings file must contain all of the needed settings, while a settings file
in the top directory can be empty (and this is how they are written out if they do not exist).

Specifically, both dl-dir and registry settings have been relocated to the global file,
and dl-dir defaults to ~/.cache/bitbake-setup/downloads, rather than somewhere in top dir.

3. The file name for both global and top dir settings is now 'settings.conf'.

4. --top-dir-prefix and --top-dir-name options have been removed and superseded by
a generic, universal --setting option.

5. 'install-settings' command has been removed, as it is no longer does anything useful,
and is superseded by the 'setting' command (see below).

'install-global-settings' has been retained, to be able to have a set of global defaults
that can be changed without initializing a build.

6. 'change-setting', 'change-global-setting' and 'install-settings' have all been replaced
by a single 'setting' command that mimics 'git config' in its parameters:

    a. Changing a setting: bitbake-setup setting [--global] default dl-dir /path/to/downloads

    b. Removing a setting: bitbake-setup setting [--global] --unset default dl-dir

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup     | 287 +++++++++++++++++++++---------------------
 lib/bb/tests/setup.py |  12 +-
 2 files changed, 147 insertions(+), 152 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 7878cd939..e9e73a927 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -32,9 +32,9 @@ logger = bb.msg.logger_create('bitbake-setup', sys.stdout)
 def cache_dir(top_dir):
     return os.path.join(top_dir, '.bitbake-setup-cache')
 
-def init_bb_cache(settings, args):
+def init_bb_cache(top_dir, settings, args):
     dldir = settings["default"]["dl-dir"]
-    bb_cachedir = os.path.join(cache_dir(args.top_dir), 'bitbake-cache')
+    bb_cachedir = os.path.join(cache_dir(top_dir), 'bitbake-cache')
 
     d = bb.data.init()
     d.setVar("DL_DIR", dldir)
@@ -389,7 +389,7 @@ def choose_fragments(possibilities, parameters, non_interactive, skip_selection)
         choices[k] = options_enumerated[option_n][1]
     return choices
 
-def obtain_config(settings, args, source_overrides, d):
+def obtain_config(top_dir, settings, args, source_overrides, d):
     if args.config:
         config_id = args.config[0]
         config_parameters = args.config[1:]
@@ -407,7 +407,7 @@ def obtain_config(settings, args, source_overrides, d):
               upstream_config = {'type':'network','uri':config_id,'name':get_config_name(config_id),'data':json.load(f)}
         else:
             print("Looking up config {} in configuration registry".format(config_id))
-            registry_path = update_registry(settings["default"]["registry"], cache_dir(args.top_dir), d)
+            registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
             registry_configs = list_registry(registry_path, with_expired=True)
             if config_id not in registry_configs:
                 raise Exception("Config {} not found in configuration registry, re-run 'init' without parameters to choose from available configurations.".format(config_id))
@@ -416,7 +416,7 @@ def obtain_config(settings, args, source_overrides, d):
         if has_expired(expiry_date):
             print("This configuration is no longer supported after {}. Please consider changing to a supported configuration.".format(expiry_date))
     else:
-        registry_path = update_registry(settings["default"]["registry"], cache_dir(args.top_dir), d)
+        registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
         registry_configs = list_registry(registry_path, with_expired=True)
         config_id = choose_config(registry_configs, args.non_interactive)
         config_parameters = []
@@ -429,7 +429,7 @@ def obtain_config(settings, args, source_overrides, d):
     upstream_config['skip-selection'] = args.skip_selection
     return upstream_config
 
-def init_config(settings, args, d):
+def init_config(top_dir, settings, args, d):
     stdout = sys.stdout
     def handle_task_progress(event, d):
         rate = event.rate if event.rate else ''
@@ -437,10 +437,10 @@ def init_config(settings, args, d):
         print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
 
     source_overrides = json.load(open(args.source_overrides)) if args.source_overrides else {'sources':{}}
-    upstream_config = obtain_config(settings, args, source_overrides, d)
+    upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
     print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
 
-    builddir = os.path.join(os.path.abspath(args.top_dir), args.build_dir_name or "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
+    builddir = os.path.join(os.path.abspath(top_dir), args.build_dir_name or "{}-{}".format(upstream_config['name']," ".join(upstream_config['non-interactive-cmdline-options'][1:]).replace(" ","-").replace("/","_")))
     if os.path.exists(os.path.join(builddir, "layers")):
         print("Build already initialized in {}\nUse 'bitbake-setup status' to check if it needs to be updated or 'bitbake-setup update' to perform the update.".format(builddir))
         return
@@ -511,7 +511,7 @@ def are_layers_changed(layers, layerdir, d):
 
     return changed
 
-def build_status(settings, args, d, update=False):
+def build_status(top_dir, settings, args, d, update=False):
     builddir = args.build_dir
 
     confdir = os.path.join(builddir, "config")
@@ -523,7 +523,7 @@ def build_status(settings, args, d, update=False):
     args.non_interactive = True
     args.skip_selection = current_upstream_config['skip-selection']
     source_overrides = current_upstream_config["source-overrides"]
-    new_upstream_config = obtain_config(settings, args, source_overrides, d)
+    new_upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
 
     write_config(new_upstream_config, confdir)
     config_diff = bb.process.run('git -C {} diff'.format(confdir))[0]
@@ -544,8 +544,8 @@ def build_status(settings, args, d, update=False):
 
     print("\nConfiguration in {} has not changed.".format(builddir))
 
-def build_update(settings, args, d):
-    build_status(settings, args, d, update=True)
+def build_update(top_dir, settings, args, d):
+    build_status(top_dir, settings, args, d, update=True)
 
 def do_fetch(fetcher, dir):
     # git fetcher simply dumps git output to stdout; in bitbake context that is redirected to temp/log.do_fetch
@@ -595,8 +595,8 @@ def list_registry(registry_path, with_expired):
                     json_data[config_name] = {"description": config_desc}
     return json_data
 
-def list_configs(settings, args, d):
-    registry_path = update_registry(settings["default"]["registry"], cache_dir(args.top_dir), d)
+def list_configs(top_dir, settings, args, d):
+    registry_path = update_registry(settings["default"]["registry"], cache_dir(top_dir), d)
     json_data = list_registry(registry_path, args.with_expired)
     print("\nAvailable configurations:")
     for config_name, config_data in json_data.items():
@@ -614,7 +614,7 @@ def list_configs(settings, args, d):
             json.dump(json_data, f, sort_keys=True, indent=4)
         print("Available configurations written into {}".format(args.write_json))
 
-def install_buildtools(settings, args, d):
+def install_buildtools(top_dir, settings, args, d):
     buildtools_install_dir = os.path.join(args.build_dir, 'buildtools')
     if os.path.exists(buildtools_install_dir):
         if not args.force:
@@ -634,117 +634,113 @@ def install_buildtools(settings, args, d):
     subprocess.check_call("{} -d {} --downloads-directory {}".format(install_buildtools, buildtools_install_dir, buildtools_download_dir), shell=True)
 
 def default_settings_path(top_dir):
-    return os.path.join(top_dir, 'bitbake-setup.conf')
+    return os.path.join(top_dir, 'settings.conf')
 
-def write_settings(top_dir, force_replace, non_interactive=True):
+def create_settings(top_dir, non_interactive=True):
     settings_path = default_settings_path(top_dir)
-    if not os.path.exists(settings_path) or force_replace:
-
-        settings = configparser.ConfigParser()
-        settings['default'] = {
-                             'registry':default_registry,
-                             'dl-dir':os.path.join(top_dir, '.bitbake-setup-downloads'),
-                            }
-        os.makedirs(os.path.dirname(settings_path), exist_ok=True)
-
-        siteconfpath = os.path.join(top_dir, 'site.conf')
-        print('Configuration registry set to\n    {}\n'.format(settings['default']['registry']))
-        print('Bitbake-setup download cache (DL_DIR) set to\n    {}\n'.format(settings['default']['dl-dir']))
-        print('A new settings file will be created in\n    {}\n'.format(settings_path))
-        print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
-        if not non_interactive:
-            y_or_n = input('Bitbake-setup will be configured with the above settings in {}, (y/N): '.format(top_dir))
-            if y_or_n != 'y':
-                print("\nYou can run 'bitbake-setup install-settings' to edit them before setting up builds")
-                exit()
-            print()
-
-        if os.path.exists(settings_path):
-            backup_conf = settings_path + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
-            os.rename(settings_path, backup_conf)
-            print("Previous settings are in {}".format(backup_conf))
-        with open(settings_path, 'w') as settingsfile:
-            settings.write(settingsfile)
-
-        if os.path.exists(siteconfpath):
-            backup_siteconf = siteconfpath + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
-            os.rename(siteconfpath, backup_siteconf)
-            print("Previous settings are in {}".format(backup_siteconf))
-        with open(siteconfpath, 'w') as siteconffile:
-            siteconffile.write('# This file is intended for build host-specific bitbake settings\n')
+    settings = configparser.ConfigParser()
+    settings['default'] = {
+                          }
+    os.makedirs(os.path.dirname(settings_path), exist_ok=True)
+
+    siteconfpath = os.path.join(top_dir, 'site.conf')
+    print('A new empty settings file will be created in (you can add settings to it to override defaults from the global settings file)\n    {}\n'.format(settings_path))
+    print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
+    if not non_interactive:
+        y_or_n = input('Bitbake-setup will be configured with the above settings in {}, (y/N): '.format(top_dir))
+        if y_or_n != 'y':
+            print("\nYou can run 'bitbake-setup install-settings' to edit them before setting up builds")
+            exit()
+        print()
 
-def load_settings(top_dir, non_interactive):
-    # This creates a new settings file if it does not yet exist
-    write_settings(top_dir, force_replace=False, non_interactive=non_interactive)
+    if os.path.exists(settings_path):
+        backup_conf = settings_path + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
+        os.rename(settings_path, backup_conf)
+        print("Previous settings are in {}".format(backup_conf))
+    with open(settings_path, 'w') as settingsfile:
+        settings.write(settingsfile)
+
+    if os.path.exists(siteconfpath):
+        backup_siteconf = siteconfpath + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
+        os.rename(siteconfpath, backup_siteconf)
+        print("Previous settings are in {}".format(backup_siteconf))
+    with open(siteconfpath, 'w') as siteconffile:
+        siteconffile.write('# This file is intended for build host-specific bitbake settings\n')
 
+def load_settings(top_dir, non_interactive):
     settings_path = default_settings_path(top_dir)
+    if not os.path.exists(settings_path):
+        create_settings(top_dir, non_interactive=non_interactive)
+
     settings = configparser.ConfigParser()
     print('Loading settings from\n    {}\n'.format(settings_path))
     settings.read_file(open(settings_path))
     return settings
 
 def global_settings_path(args):
-    return os.path.abspath(args.global_settings) if args.global_settings else os.path.join(os.path.expanduser('~'), '.config', 'bitbake-setup', 'config')
-
-def write_global_settings(settings_path, force_replace, non_interactive=True):
-    if not os.path.exists(settings_path) or force_replace:
-
-        settings = configparser.ConfigParser()
-        settings['default'] = {
-                             'top-dir-prefix':os.path.expanduser('~'),
-                             'top-dir-name':'bitbake-builds'
-                            }
-        os.makedirs(os.path.dirname(settings_path), exist_ok=True)
-        print('Configuring global settings in\n    {}\n'.format(settings_path))
-        print('Top directory prefix (where all top level directories are created) set to\n    {}\n'.format(settings['default']['top-dir-prefix']))
-        print('Top directory name (this is added to the top directory prefix to form a top directory where builds are set up) set to\n    {}\n'.format(settings['default']['top-dir-name']))
-        if not non_interactive:
-            y_or_n = input('Write out the global settings as specified above (y/N)? ')
-            if y_or_n != 'y':
-                print("\nYou can run 'bitbake-setup install-global-settings' to edit them before setting up builds")
-                exit()
-            print()
-
-        if os.path.exists(settings_path):
-            backup_conf = settings_path + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
-            os.rename(settings_path, backup_conf)
-            print("Previous global settings are in {}".format(backup_conf))
-        with open(settings_path, 'w') as settingsfile:
-            settings.write(settingsfile)
+    return os.path.abspath(args.global_settings) if args.global_settings else os.path.join(os.path.expanduser('~'), '.config', 'bitbake-setup', 'settings.conf')
+
+def create_global_settings(settings_path, non_interactive=True):
+    settings = configparser.ConfigParser()
+    settings['default'] = {
+                         'top-dir-prefix':os.path.expanduser('~'),
+                         'top-dir-name':'bitbake-builds',
+                         'registry':default_registry,
+                         'dl-dir':os.path.join(os.path.expanduser('~'), '.cache', 'bitbake-setup', 'downloads'),
+                         }
+    os.makedirs(os.path.dirname(settings_path), exist_ok=True)
+    print('Configuring global settings in\n    {}\n'.format(settings_path))
+    print('Top directory prefix (where all top level directories are created) set to\n    {}\n'.format(settings['default']['top-dir-prefix']))
+    print('Top directory name (this is added to the top directory prefix to form a top directory where builds are set up) set to\n    {}\n'.format(settings['default']['top-dir-name']))
+    print('Configuration registry set to\n    {}\n'.format(settings['default']['registry']))
+    print('Bitbake-setup download cache (DL_DIR) set to\n    {}\n'.format(settings['default']['dl-dir']))
+    if not non_interactive:
+        y_or_n = input('Write out the global settings as specified above (y/N)? ')
+        if y_or_n != 'y':
+            print("\nYou can run 'bitbake-setup install-global-settings' to edit them before setting up builds")
+            exit()
+        print()
+
+    if os.path.exists(settings_path):
+        backup_conf = settings_path + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
+        os.rename(settings_path, backup_conf)
+        print("Previous global settings are in {}".format(backup_conf))
+    with open(settings_path, 'w') as settingsfile:
+        settings.write(settingsfile)
 
 def load_global_settings(settings_path, non_interactive):
-    # This creates a new settings file if it does not yet exist
-    write_global_settings(settings_path, force_replace=False, non_interactive=non_interactive)
+    if not os.path.exists(settings_path):
+        create_global_settings(settings_path, non_interactive=non_interactive)
 
     settings = configparser.ConfigParser()
     print('Loading global settings from\n    {}\n'.format(settings_path))
     settings.read_file(open(settings_path))
     return settings
 
-def change_settings(top_dir, new_settings):
-    settings = load_settings(top_dir, non_interactive=True)
-    for section, section_settings in new_settings.items():
-        for setting, value in section_settings.items():
-            settings[section][setting] = value
-            print("Setting '{}' in section '{}' is changed to '{}'".format(setting, section, value))
+def change_setting(settings_path, settings, args):
+    if args.section and args.key and args.value:
+        settings[args.section][args.key] = args.value
+        print("Setting '{}' in section '{}' is changed to '{}'".format(args.key, args.section, args.value))
+    if args.unset:
+        section = args.unset[0]
+        setting = args.unset[1]
+        if section in settings.keys() and setting in settings[section].keys():
+            del settings[section][setting]
+            print("Setting '{} in section '{}' is removed".format(setting, section))
 
-    settings_path = default_settings_path(top_dir)
     with open(settings_path, 'w') as settingsfile:
         settings.write(settingsfile)
     print("New settings written to {}".format(settings_path))
-    return settings
 
-def change_global_settings(settings_path, new_settings):
-    settings = load_global_settings(settings_path, non_interactive=True)
-    for section, section_settings in new_settings.items():
-        for setting, value in section_settings.items():
-            settings[section][setting] = value
-            print("Setting '{}' in section '{}' is changed to '{}'".format(setting, section, value))
+def setting_global(args):
+    settings = load_global_settings(global_settings_path(args), args.non_interactive)
+    settings_path = global_settings_path(args)
+    change_setting(settings_path, settings, args)
 
-    with open(settings_path, 'w') as settingsfile:
-        settings.write(settingsfile)
-    print("New global settings written to {}".format(settings_path))
-    return settings
+def setting(top_dir, args):
+    settings = load_settings(top_dir, args.non_interactive)
+    settings_path = default_settings_path(top_dir)
+    change_setting(settings_path, settings, args)
 
 def get_build_dir_via_bbpath():
     bbpath = os.environ.get('BBPATH')
@@ -755,7 +751,7 @@ def get_build_dir_via_bbpath():
             return build_dir
     return None
 
-def get_top_dir(args, global_settings):
+def get_top_dir(args, settings):
     build_dir_via_bbpath = get_build_dir_via_bbpath()
     if build_dir_via_bbpath:
         top_dir = os.path.dirname(build_dir_via_bbpath)
@@ -763,20 +759,25 @@ def get_top_dir(args, global_settings):
             return top_dir
 
     if hasattr(args, 'build_dir'):
-        # commands without --top-dir-prefix/name arguments (status, update) still need to know where
-        # the top dir is, but it should be auto-deduced as parent of args.build_dir
         top_dir = os.path.dirname(os.path.normpath(args.build_dir))
         return top_dir
 
-    top_dir_prefix = args.top_dir_prefix if args.top_dir_prefix else global_settings['default']['top-dir-prefix']
-    top_dir_name = args.top_dir_name if args.top_dir_name else global_settings['default']['top-dir-name']
+    top_dir_prefix = settings['default']['top-dir-prefix']
+    top_dir_name = settings['default']['top-dir-name']
     return os.path.join(top_dir_prefix, top_dir_name)
 
-def main():
-    def add_top_dir_arg(parser):
-        parser.add_argument('--top-dir-prefix', help='Top level directory prefix. This is where all top level directories are created.')
-        parser.add_argument('--top-dir-name', help='Top level directory name. Together with the top directory prefix this forms a top directory where builds are set up and downloaded configurations and layers are cached for reproducibility and offline builds.')
+def merge_settings(global_settings, local_settings, cmdline_settings):
+    all_settings = global_settings
+    for section, section_settings in local_settings.items():
+        for setting, value in section_settings.items():
+            all_settings[section][setting] = value
+
+    for (section, setting, value) in cmdline_settings:
+        all_settings[section][setting] = value
+
+    return all_settings
 
+def main():
     def add_build_dir_arg(parser):
         build_dir = get_build_dir_via_bbpath()
         if build_dir:
@@ -792,18 +793,17 @@ def main():
     parser.add_argument('-q', '--quiet', help='Print only errors', action='store_true')
     parser.add_argument('--color', choices=['auto', 'always', 'never'], default='auto', help='Colorize output (where %(metavar)s is %(choices)s)', metavar='COLOR')
     parser.add_argument('--no-network', action='store_true', help='Do not check whether configuration repositories and layer repositories have been updated; use only the local cache.')
-    parser.add_argument('--global-settings', action='store', help='Path to the global settings file where defaults for top directory prefix and name can be specified')
+    parser.add_argument('--global-settings', action='store', help='Path to the global settings file.')
+    parser.add_argument('--setting', default=[], action='append', nargs=3, help='Modify a setting (for this bitbake-setup invocation only), for example "--setting default top-dir-prefix /path/to/top/dir".')
 
     subparsers = parser.add_subparsers()
 
     parser_list = subparsers.add_parser('list', help='List available configurations')
-    add_top_dir_arg(parser_list)
     parser_list.add_argument('--with-expired', action='store_true', help='List also configurations that are no longer supported due to reaching their end-of-life dates.')
     parser_list.add_argument('--write-json', action='store', help='Write available configurations into a json file so they can be programmatically processed.')
     parser_list.set_defaults(func=list_configs)
 
     parser_init = subparsers.add_parser('init', help='Select a configuration and initialize a build from it')
-    add_top_dir_arg(parser_init)
     parser_init.add_argument('config', nargs='*', help="path/URL/id to a configuration file (use 'list' command to get available ids), followed by configuration options. Bitbake-setup will ask to choose from available choices if command line doesn't completely specify them.")
     parser_init.add_argument('--non-interactive', action='store_true', help='Do not ask to interactively choose from available options; if bitbake-setup cannot make a decision it will stop with a failure.')
     parser_init.add_argument('--source-overrides', action='store', help='Override sources information (repositories/revisions) with values from a local json file.')
@@ -824,25 +824,16 @@ def main():
     parser_install_buildtools.add_argument('--force', action='store_true', help='Force a reinstall of buildtools over the previous installation.')
     parser_install_buildtools.set_defaults(func=install_buildtools)
 
-    parser_install_settings = subparsers.add_parser('install-settings', help='Write a settings file with default values into the top level directory (contains the location of build configuration registry, downloads directory and other settings specific to a top directory)')
-    add_top_dir_arg(parser_install_settings)
-    parser_install_settings.set_defaults(func=write_settings)
-
-    parser_install_global_settings = subparsers.add_parser('install-global-settings', help='Write a global settings file with default values (contains the default prefix and name of the top directory)')
-    parser_install_global_settings.set_defaults(func=write_global_settings)
-
-    parser_change_setting = subparsers.add_parser('change-setting', help='Change a setting in the settings file')
-    add_top_dir_arg(parser_change_setting)
-    parser_change_setting.add_argument('section', help="Section in a settings file, typically 'default'")
-    parser_change_setting.add_argument('key', help="Name of the setting")
-    parser_change_setting.add_argument('value', help="Value of the setting")
-    parser_change_setting.set_defaults(func=change_settings)
+    parser_install_global_settings = subparsers.add_parser('install-global-settings', help='Write a global settings file with default values')
+    parser_install_global_settings.set_defaults(func=create_global_settings)
 
-    parser_change_global_setting = subparsers.add_parser('change-global-setting', help='Change a setting in the global settings file')
-    parser_change_global_setting.add_argument('section', help="Section in a global settings file, typically 'default'")
-    parser_change_global_setting.add_argument('key', help="Name of the setting")
-    parser_change_global_setting.add_argument('value', help="Value of the setting")
-    parser_change_global_setting.set_defaults(func=change_global_settings)
+    parser_setting = subparsers.add_parser('setting', help='Set or unset a setting in a setting file (e.g. the default prefix and name of the top directory, the location of build configuration registry, downloads directory and other settings specific to a top directory)')
+    parser_setting.add_argument('section', nargs='?', help="Section in a settings file, typically 'default'")
+    parser_setting.add_argument('key', nargs='?', help="Name of the setting")
+    parser_setting.add_argument('value', nargs='?', help="Value of the setting")
+    parser_setting.add_argument('--global', action='store_true', help="Modify the setting in a global settings file, rather than one specific to a top directory")
+    parser_setting.add_argument('--unset', nargs=2, help="Unset a setting, e.g. 'bitbake-setup setting --unset default registry' would revert to the registry setting in a global settings file")
+    parser_setting.set_defaults(func=setting)
 
     args = parser.parse_args()
 
@@ -859,11 +850,8 @@ def main():
                          level=logger.getEffectiveLevel())
 
     if 'func' in args:
-        if args.func == write_global_settings:
-            write_global_settings(global_settings_path(args), force_replace=True)
-            return
-        elif args.func == change_global_settings:
-            change_global_settings(global_settings_path(args), {args.section:{args.key:args.value}})
+        if args.func == create_global_settings:
+            create_global_settings(global_settings_path(args))
             return
 
         if hasattr(args, 'build_dir'):
@@ -874,19 +862,24 @@ def main():
         if not hasattr(args, 'non_interactive'):
             args.non_interactive = True
 
+        if args.func == setting and vars(args)['global']:
+            setting_global(args)
+            return
+
         global_settings = load_global_settings(global_settings_path(args), args.non_interactive)
-        args.top_dir = get_top_dir(args, global_settings)
+        top_dir = get_top_dir(args, merge_settings(global_settings, {}, args.setting))
 
-        print('Bitbake-setup is using {} as top directory (can be changed with --top-dir-prefix/name arguments or by setting them in {}).\n'.format(args.top_dir, global_settings_path(args)))
-        if args.func == write_settings:
-            write_settings(args.top_dir, force_replace=True)
-        elif args.func == change_settings:
-            change_settings(args.top_dir, {args.section:{args.key:args.value}})
-        else:
-            settings = load_settings(args.top_dir, args.non_interactive)
-            d = init_bb_cache(settings, args)
-            args.func(settings, args, d)
-            save_bb_cache()
+        if args.func == setting:
+            setting(top_dir, args)
+            return
+
+        print('Bitbake-setup is using {} as top directory (can be changed by setting top dir prefix and name in {}).\n'.format(top_dir, global_settings_path(args)))
+
+        settings = load_settings(top_dir, args.non_interactive)
+        settings = merge_settings(global_settings, settings, args.setting)
+        d = init_bb_cache(top_dir, settings, args)
+        args.func(top_dir, settings, args, d)
+        save_bb_cache()
     else:
         from argparse import Namespace
         parser.print_help()
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 495d1da20..22edda40e 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -235,16 +235,18 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
         out = self.runbbsetup("install-global-settings")
         settings_path = "{}/global-config".format(self.tempdir)
         self.assertIn(settings_path, out[0])
-        out = self.runbbsetup("change-global-setting default top-dir-prefix {}".format(self.tempdir))
+        out = self.runbbsetup("setting --global default top-dir-prefix {}".format(self.tempdir))
         self.assertIn("Setting 'top-dir-prefix' in section 'default' is changed to", out[0])
-        self.assertIn("New global settings written to".format(settings_path), out[0])
+        self.assertIn("New settings written to".format(settings_path), out[0])
+        out = self.runbbsetup("setting --global default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')))
+        self.assertIn("Setting 'dl-dir' in section 'default' is changed to", out[0])
+        self.assertIn("New settings written to".format(settings_path), out[0])
 
         # check that writing settings works and then adjust them to point to
         # test registry repo
-        out = self.runbbsetup("install-settings")
-        settings_path = "{}/bitbake-builds/bitbake-setup.conf".format(self.tempdir)
+        out = self.runbbsetup("setting default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
+        settings_path = "{}/bitbake-builds/settings.conf".format(self.tempdir)
         self.assertIn(settings_path, out[0])
-        out = self.runbbsetup("change-setting default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
         self.assertIn("Setting 'registry' in section 'default' is changed to", out[0])
         self.assertIn("New settings written to".format(settings_path), out[0])
 
-- 
2.39.5


