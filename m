Return-Path: <tgamblin@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063EACCD185
	for <webhook@archiver.kernel.org>; Fri, 10 Oct 2025 16:55:52 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
 by mx.groups.io with SMTP id smtpd.web10.531.1760115344116834408
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 10 Oct 2025 09:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=SKK0MsfR;
 spf=pass (domain: baylibre.com, ip: 209.85.222.177, mailfrom: tgamblin@baylibre.com)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-86420079b01so254017185a.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 09:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760115342; x=1760720142; darn=lists.openembedded.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkTUJcduoMf0gFLvyVMnEAfZXTvsZ5G39XJbNoPbrz0=;
        b=SKK0MsfRKs5ySRgEH7NySZpwGDH0BMxaFesuX5wg24KuE3GlaUA/lscjOVi2JZJdZE
         fJkNuVHvqAsIgAjPzGAmeIua/t2XjdheA8/hvi5jOQYIw9huAqQj5/ZesV03rqylQEcN
         LocnxlADs3fimH6fMsoVMc8P8RKfLtakGcdHcasitOjO4YcZ4lGZqChlrEunUQ8v06QU
         h5QQj31x3fbEB93QNDBcm9L3jJO+LgooyXcnLmaFjL0X/Sa3nJG1H8kIHDZN3UTsDbEX
         MmNhP0hmfIUbWoVtlZZ2npfGsYt6Cl5y1gwb1WZ+jLWWrKCmvOuTZUFtbKPDnzIz5qWy
         yalw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760115342; x=1760720142;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkTUJcduoMf0gFLvyVMnEAfZXTvsZ5G39XJbNoPbrz0=;
        b=ksaD9ktW8l/n4mKgXTc3lULpchcl1ys3CtCmlAWG8IdTBMucfd4VQzdJ+VkiBNBOjv
         8Wx/Ut6MqNSIX6Owub25/Flafc/NbVh4PFziHlSs88VfR/lA45OaIQLYXB+BJeYcwFbX
         V+7+4LqwrRC6G0e3HSovh4ciI3rtvmHmfYx2bL9Y0eDFm+jQuuS6M3w72z9ar+y4bWjF
         KT1v6xOnOAu9TA8ErhawNK6ruKWZ9TEaMBXbsaVgYEIxe3nYuklkHnBIPNCXVKYQBKzX
         QuRf5Lbm/EacYq5of4JoTweKiFVCJsFGwciCcLnbgLHEAVt61gY55DY2vSD54Cs7Qeu6
         a/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCX28net0Hp3RO4LNjUVVYCtVotbvl62VFN174cSJDznSHzMT3D+gSDBgvDhCKE1pm2aIHIr0E5C2lfwWgHd@lists.openembedded.org
X-Gm-Message-State: AOJu0YznMlcsZDEv5b6S0+/oyoGgjvGWtgcyAksLSegBhGtJ4tsOKvZV
	lsKYpQ2fUCaWxzf5c08TXwfLnzaoeIIP5hJRxq6/k6l9xUvuNlht7YTp4nWh2YdskvEf9EKaEqp
	S08puI/c=
X-Gm-Gg: ASbGncstwblMuXiLYjBZmdEdoTcWPeb4MWsU9mj1JpTSYvAFHhj76iYToNbUBxbxRao
	818D+rpVOFNQ2cppbyOkoRgb4ynV6BPsKIJqGTzkabdcTY29kPVoCN0ve4TeA8jUWqSl1d9tPEG
	DBuSJ9G/Pwvmh2xbiS9dBS+IE+1fVVUbPqGuZkTXxG6KodCbUmFFQNR4QYVphEmV75SKpX3tg29
	Dz/HgEuUOjTMogR2Py/P5O+Y8dsCW5pS0qYg8l1uAKUsfSTSLOH3ddTII9YmVRBsSwbX0SvAOXA
	vhTTHO312Ff65OxCPCypU8tR6BYbSfI9m9RMKdXwBjQH9cEAmSKgXox6J7joHAlldG0NpSoy+/n
	FToI70WtQVMwTZgFcXpxJYI2rtJe4qGKrzYdcr898Bl/yq5JfnbIlBERLgbzl6xXx1gyoqjk8fI
	NmEiLT9taaab6nVnaV4l19DK+8XQORrw==
X-Google-Smtp-Source: AGHT+IH4bU2gIpA+I6n04ggg9xAcybh98UbyQtTfPtLO9e+TBhZKqiRgVDskOabhLSsIlDAerN3t/w==
X-Received: by 2002:a05:620a:269f:b0:886:173f:1b4c with SMTP id af79cd13be357-886173f1f98mr492586085a.80.1760115342031;
        Fri, 10 Oct 2025 09:55:42 -0700 (PDT)
Received: from ?IPV6:2001:1970:3847:e000:84f2:c6ad:afd9:6725? ([2001:1970:3847:e000:84f2:c6ad:afd9:6725])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a2274482sm436810785a.46.2025.10.10.09.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 09:55:41 -0700 (PDT)
Message-ID: <45e4b824-e486-488c-b54a-25599d64759f@baylibre.com>
Date: Fri, 10 Oct 2025 12:55:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: further rework the
 settings handling
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
References: <20251009163108.2571082-1-alex.kanavin@gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20251009163108.2571082-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 10 Oct 2025 16:55:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18168

I think I've found a couple of minor issues in the bitbake-setup binary. 
See inline.

On 2025-10-09 12:31, Alexander Kanavin via lists.openembedded.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
>
> After some further feedback, additional changes are made:
>
> 1. 'setting' command is renamed to 'settings' to better reflect
> that it is an interface to various ways of managing settings.
>
> 2. This command now has a -l/--list option to list all settings
> with their values (same as 'git config -l').
>
> 3. A new level of settings (built-in defaults) is added,
> and used as a last resort after command line options, top dir
> settings file and global settings file.
>
> 4. This means bitbake-setup does not have to write and use a
> global settings file, and it no longer does so when initializing
> a build, avoiding default 'pollution' of ~/.config/bitbake-setup/
> which can be problematic or unwelcome.
>
> A global settings file is still created if a setting is explicitly
> requested to be placed into it.
>
> 5. 'install-global-settins' is removed as the use case for it
> (tweak default settings before using them to initialize a build)
> can be achieved by setting the settings individually.
>
> 5. Similarly, a top dir settings file is no longer created by default
> and only appears if a setting needs to be written into it.
>
> 6. Default dl-dir is again created inside a top directory and not
> in ~/.cache/ to make default builds fully contained in the top
> directory (which was also asked about).
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>   bin/bitbake-setup     | 161 ++++++++++++++++--------------------------
>   lib/bb/tests/setup.py |  13 ++--
>   2 files changed, 69 insertions(+), 105 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index e9e73a927..71b5b8de9 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -436,6 +436,7 @@ def init_config(top_dir, settings, args, d):
>           progress = event.progress if event.progress > 0 else 0
>           print("{}% {}                ".format(progress, rate), file=stdout, end='\r')
>   
> +    create_siteconf(top_dir, args.non_interactive)
>       source_overrides = json.load(open(args.source_overrides)) if args.source_overrides else {'sources':{}}
>       upstream_config = obtain_config(top_dir, settings, args, source_overrides, d)
>       print("\nRun 'bitbake-setup init --non-interactive {}' to select this configuration non-interactively.\n".format(" ".join(upstream_config['non-interactive-cmdline-options'])))
> @@ -636,30 +637,15 @@ def install_buildtools(top_dir, settings, args, d):
>   def default_settings_path(top_dir):
>       return os.path.join(top_dir, 'settings.conf')
>   
> -def create_settings(top_dir, non_interactive=True):
> -    settings_path = default_settings_path(top_dir)
> -    settings = configparser.ConfigParser()
> -    settings['default'] = {
> -                          }
> -    os.makedirs(os.path.dirname(settings_path), exist_ok=True)
> -
> +def create_siteconf(top_dir, non_interactive=True):
>       siteconfpath = os.path.join(top_dir, 'site.conf')
> -    print('A new empty settings file will be created in (you can add settings to it to override defaults from the global settings file)\n    {}\n'.format(settings_path))
>       print('A common site.conf file will be created, please edit or replace before running builds\n    {}\n'.format(siteconfpath))
>       if not non_interactive:
> -        y_or_n = input('Bitbake-setup will be configured with the above settings in {}, (y/N): '.format(top_dir))
> +        y_or_n = input('Proceed? (y/N): ')
>           if y_or_n != 'y':
> -            print("\nYou can run 'bitbake-setup install-settings' to edit them before setting up builds")
>               exit()
> -        print()
> -
> -    if os.path.exists(settings_path):
> -        backup_conf = settings_path + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
> -        os.rename(settings_path, backup_conf)
> -        print("Previous settings are in {}".format(backup_conf))
> -    with open(settings_path, 'w') as settingsfile:
> -        settings.write(settingsfile)
>   
> +    os.makedirs(os.path.dirname(top_dir), exist_ok=True)
>       if os.path.exists(siteconfpath):
>           backup_siteconf = siteconfpath + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
>           os.rename(siteconfpath, backup_siteconf)
> @@ -667,58 +653,26 @@ def create_settings(top_dir, non_interactive=True):
>       with open(siteconfpath, 'w') as siteconffile:
>           siteconffile.write('# This file is intended for build host-specific bitbake settings\n')
>   
> -def load_settings(top_dir, non_interactive):
> -    settings_path = default_settings_path(top_dir)
> -    if not os.path.exists(settings_path):
> -        create_settings(top_dir, non_interactive=non_interactive)
> -
> -    settings = configparser.ConfigParser()
> -    print('Loading settings from\n    {}\n'.format(settings_path))
> -    settings.read_file(open(settings_path))
> -    return settings
> -
>   def global_settings_path(args):
>       return os.path.abspath(args.global_settings) if args.global_settings else os.path.join(os.path.expanduser('~'), '.config', 'bitbake-setup', 'settings.conf')
>   
> -def create_global_settings(settings_path, non_interactive=True):
> +def load_settings(settings_path):
>       settings = configparser.ConfigParser()
> -    settings['default'] = {
> -                         'top-dir-prefix':os.path.expanduser('~'),
> -                         'top-dir-name':'bitbake-builds',
> -                         'registry':default_registry,
> -                         'dl-dir':os.path.join(os.path.expanduser('~'), '.cache', 'bitbake-setup', 'downloads'),
> -                         }
> -    os.makedirs(os.path.dirname(settings_path), exist_ok=True)
> -    print('Configuring global settings in\n    {}\n'.format(settings_path))
> -    print('Top directory prefix (where all top level directories are created) set to\n    {}\n'.format(settings['default']['top-dir-prefix']))
> -    print('Top directory name (this is added to the top directory prefix to form a top directory where builds are set up) set to\n    {}\n'.format(settings['default']['top-dir-name']))
> -    print('Configuration registry set to\n    {}\n'.format(settings['default']['registry']))
> -    print('Bitbake-setup download cache (DL_DIR) set to\n    {}\n'.format(settings['default']['dl-dir']))
> -    if not non_interactive:
> -        y_or_n = input('Write out the global settings as specified above (y/N)? ')
> -        if y_or_n != 'y':
> -            print("\nYou can run 'bitbake-setup install-global-settings' to edit them before setting up builds")
> -            exit()
> -        print()
> -
>       if os.path.exists(settings_path):
> -        backup_conf = settings_path + "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
> -        os.rename(settings_path, backup_conf)
> -        print("Previous global settings are in {}".format(backup_conf))
> -    with open(settings_path, 'w') as settingsfile:
> -        settings.write(settingsfile)
> -
> -def load_global_settings(settings_path, non_interactive):
> -    if not os.path.exists(settings_path):
> -        create_global_settings(settings_path, non_interactive=non_interactive)
> -
> -    settings = configparser.ConfigParser()
> -    print('Loading global settings from\n    {}\n'.format(settings_path))
> -    settings.read_file(open(settings_path))
> +        print('Loading settings from\n    {}\n'.format(settings_path))
> +        settings.read_file(open(settings_path))
>       return settings
>   
> -def change_setting(settings_path, settings, args):
> +def change_setting(top_dir, args):
> +    if vars(args)['global']:
> +        settings_path = global_settings_path(args)
> +    else:
> +        settings_path = default_settings_path(top_dir)
> +    settings = load_settings(settings_path)
> +
>       if args.section and args.key and args.value:
> +        if args.section not in settings.keys():
> +            settings[args.section] = {}
>           settings[args.section][args.key] = args.value
>           print("Setting '{}' in section '{}' is changed to '{}'".format(args.key, args.section, args.value))
>       if args.unset:
> @@ -728,19 +682,21 @@ def change_setting(settings_path, settings, args):
>               del settings[section][setting]
>               print("Setting '{} in section '{}' is removed".format(setting, section))
>   
> +    os.makedirs(os.path.dirname(settings_path), exist_ok=True)
>       with open(settings_path, 'w') as settingsfile:
>           settings.write(settingsfile)
>       print("New settings written to {}".format(settings_path))
>   
> -def setting_global(args):
> -    settings = load_global_settings(global_settings_path(args), args.non_interactive)
> -    settings_path = global_settings_path(args)
> -    change_setting(settings_path, settings, args)
> +def list_settings(all_settings):
> +    for section, section_settings in all_settings.items():
> +        for key, value in section_settings.items():
> +            print("{} {} {}".format(section, key, value))
>   
> -def setting(top_dir, args):
> -    settings = load_settings(top_dir, args.non_interactive)
> -    settings_path = default_settings_path(top_dir)
> -    change_setting(settings_path, settings, args)
> +def settings_func(top_dir, all_settings, args):
> +    if args.list:
> +        list_settings(all_settings)
> +    else:
> +        change_setting(top_dir, args)
>   
>   def get_build_dir_via_bbpath():
>       bbpath = os.environ.get('BBPATH')
> @@ -766,11 +722,13 @@ def get_top_dir(args, settings):
>       top_dir_name = settings['default']['top-dir-name']
>       return os.path.join(top_dir_prefix, top_dir_name)
>   
> -def merge_settings(global_settings, local_settings, cmdline_settings):
> -    all_settings = global_settings
> -    for section, section_settings in local_settings.items():
> -        for setting, value in section_settings.items():
> -            all_settings[section][setting] = value
> +def merge_settings(builtin_settings, global_settings, local_settings, cmdline_settings):
> +    all_settings = builtin_settings
> +
> +    for s in (global_settings, local_settings):
> +        for section, section_settings in s.items():
> +            for setting, value in section_settings.items():
> +                all_settings[section][setting] = value
>   
>       for (section, setting, value) in cmdline_settings:
>           all_settings[section][setting] = value
> @@ -824,16 +782,14 @@ def main():
>       parser_install_buildtools.add_argument('--force', action='store_true', help='Force a reinstall of buildtools over the previous installation.')
>       parser_install_buildtools.set_defaults(func=install_buildtools)
>   
> -    parser_install_global_settings = subparsers.add_parser('install-global-settings', help='Write a global settings file with default values')
> -    parser_install_global_settings.set_defaults(func=create_global_settings)
> -
> -    parser_setting = subparsers.add_parser('setting', help='Set or unset a setting in a setting file (e.g. the default prefix and name of the top directory, the location of build configuration registry, downloads directory and other settings specific to a top directory)')
> -    parser_setting.add_argument('section', nargs='?', help="Section in a settings file, typically 'default'")
> -    parser_setting.add_argument('key', nargs='?', help="Name of the setting")
> -    parser_setting.add_argument('value', nargs='?', help="Value of the setting")
> -    parser_setting.add_argument('--global', action='store_true', help="Modify the setting in a global settings file, rather than one specific to a top directory")
> -    parser_setting.add_argument('--unset', nargs=2, help="Unset a setting, e.g. 'bitbake-setup setting --unset default registry' would revert to the registry setting in a global settings file")
> -    parser_setting.set_defaults(func=setting)
> +    parser_settings = subparsers.add_parser('settings', help='List current settings, or set or unset a setting in a settings file (e.g. the default prefix and name of the top directory, the location of build configuration registry, downloads directory and other settings specific to a top directory)')
> +    parser_settings.add_argument('section', nargs='?', help="Section in a settings file, typically 'default'")
> +    parser_settings.add_argument('key', nargs='?', help="Name of the setting")
> +    parser_settings.add_argument('value', nargs='?', help="Value of the setting")
> +    parser_settings.add_argument('--global', action='store_true', help="Modify the setting in a global settings file, rather than one specific to a top directory")
> +    parser_settings.add_argument('--unset', nargs=2, help="Unset a setting, e.g. 'bitbake-setup setting --unset default registry' would revert to the registry setting
/s/bitbake-setup setting/bitbake-setup settings/
> in a global settings file")
> +    parser_settings.add_argument('-l' ,'--list', action='store_true', help="List all settings with their values")
> +    parser_settings.set_defaults(func=settings_func)
>   
>       args = parser.parse_args()
>   
> @@ -850,10 +806,6 @@ def main():
>                            level=logger.getEffectiveLevel())
>   
>       if 'func' in args:
> -        if args.func == create_global_settings:
> -            create_global_settings(global_settings_path(args))
> -            return
> -
>           if hasattr(args, 'build_dir'):
>               if not os.path.exists(os.path.join(args.build_dir,'build', 'init-build-env')):
>                   print("Not a valid build directory: build/init-build-env does not exist in {}".format(args.build_dir))
> @@ -862,23 +814,30 @@ def main():
>           if not hasattr(args, 'non_interactive'):
>               args.non_interactive = True
>   
> -        if args.func == setting and vars(args)['global']:
> -            setting_global(args)
> -            return
> +        builtin_settings = {}
> +        builtin_settings['default'] = {
> +                         'top-dir-prefix':os.path.expanduser('~'),
> +                         'top-dir-name':'bitbake-builds',
> +                         'registry':default_registry,
> +                         }
> +
> +        global_settings = load_settings(global_settings_path(args))
> +        top_dir = get_top_dir(args, merge_settings(builtin_settings, global_settings, {}, args.setting))
> +
> +        # This cannot be set with the rest of the builtin settings as top_dir needs to be determined first
> +        builtin_settings['default']['dl-dir'] = os.path.join(top_dir, '.bitbake-setup-downloads')
>   
> -        global_settings = load_global_settings(global_settings_path(args), args.non_interactive)
> -        top_dir = get_top_dir(args, merge_settings(global_settings, {}, args.setting))
> +        topdir_settings = load_settings(default_settings_path(top_dir))
> +        all_settings = merge_settings(builtin_settings, global_settings, topdir_settings, args.setting)
>   
> -        if args.func == setting:
> -            setting(top_dir, args)
> +        if args.func == settings_func:
> +            settings_func(top_dir, all_settings, args)
>               return
>   
> -        print('Bitbake-setup is using {} as top directory (can be changed by setting top dir prefix and name in {}).\n'.format(top_dir, global_settings_path(args)))
> +        print('Bitbake-setup is using {} as top directory ("bitbake-setup setting --help" shows how to change it).\n'.format(top_dir, global_settings_path(args)))
Same here.
>   
> -        settings = load_settings(top_dir, args.non_interactive)
> -        settings = merge_settings(global_settings, settings, args.setting)
> -        d = init_bb_cache(top_dir, settings, args)
> -        args.func(top_dir, settings, args, d)
> +        d = init_bb_cache(top_dir, all_settings, args)
> +        args.func(top_dir, all_settings, args, d)
>           save_bb_cache()
>       else:
>           from argparse import Namespace
> diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
> index 22edda40e..b238926b2 100644
> --- a/lib/bb/tests/setup.py
> +++ b/lib/bb/tests/setup.py
> @@ -232,24 +232,29 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>           self.runbbsetup("--help")
>   
>           # set up global location for top-dir-prefix
> -        out = self.runbbsetup("install-global-settings")
> +        out = self.runbbsetup("settings --global default top-dir-prefix {}".format(self.tempdir))
>           settings_path = "{}/global-config".format(self.tempdir)
>           self.assertIn(settings_path, out[0])
> -        out = self.runbbsetup("setting --global default top-dir-prefix {}".format(self.tempdir))
>           self.assertIn("Setting 'top-dir-prefix' in section 'default' is changed to", out[0])
>           self.assertIn("New settings written to".format(settings_path), out[0])
> -        out = self.runbbsetup("setting --global default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')))
> +        out = self.runbbsetup("settings --global default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')))
>           self.assertIn("Setting 'dl-dir' in section 'default' is changed to", out[0])
>           self.assertIn("New settings written to".format(settings_path), out[0])
>   
>           # check that writing settings works and then adjust them to point to
>           # test registry repo
> -        out = self.runbbsetup("setting default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
> +        out = self.runbbsetup("settings default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
>           settings_path = "{}/bitbake-builds/settings.conf".format(self.tempdir)
>           self.assertIn(settings_path, out[0])
>           self.assertIn("Setting 'registry' in section 'default' is changed to", out[0])
>           self.assertIn("New settings written to".format(settings_path), out[0])
>   
> +        # check that listing settings works
> +        out = self.runbbsetup("settings --list")
> +        self.assertIn("default top-dir-prefix {}".format(self.tempdir), out[0])
> +        self.assertIn("default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')), out[0])
> +        self.assertIn("default registry {}".format('git://{};protocol=file;branch=master;rev=master'.format(self.registrypath)), out[0])
> +
>           # check that 'list' produces correct output with no configs, one config and two configs
>           out = self.runbbsetup("list")
>           self.assertNotIn("test-config-1", out[0])
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18153): https://lists.openembedded.org/g/bitbake-devel/message/18153
> Mute This Topic: https://lists.openembedded.org/mt/115674529/7611679
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [tgamblin@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

