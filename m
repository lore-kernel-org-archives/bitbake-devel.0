Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E87CA0FFE
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 14:16:18 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.web10.78589.1756822577177306434
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Sep 2025 07:16:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=e7os4V16;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 97F621A09D3;
	Tue,  2 Sep 2025 14:16:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6FCB960695;
	Tue,  2 Sep 2025 14:16:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 455BA1C228A1E;
	Tue,  2 Sep 2025 16:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756822574; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1JdZiO/fjMijeVEn5i/kYN0m3+7zdCx5VOumRDpd1pU=;
	b=e7os4V16skNZaUJ7EgqfbSFYYccZynOJzfykxgfjI78osZPu/Blyd/HjqFTQCOF3eeBs9A
	I9txj7jaOaP1tpjeSPOojhocCxBA6xZNXm/zG6+LI12msjtWozbnM3o8gLvWJ3QC9hEImH
	d8o4SF6pilJVOXUq8J1/1MCJYsllsWzCEqReETJ1QcY/gJGpi8gEp7W6OFesGaE4YLg+CX
	pNA0/iJYERW0YMf1dwudzh9Aqp8NYB3T4nHT8LvwCzOPCPA3sjjCOL40tn4yxdXt42idxH
	3tDLyHFNHK9Svu+uhAuUJlVLfmCPleYtyAC4WjtPqry7OB8iJIuTZbf5aIJGeQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Sep 2025 16:16:09 +0200
Message-Id: <DCIDMIQZKLXV.2ZM8YXZTV1MM8@bootlin.com>
Cc: "Alexander Kanavin" <alex@linutronix.de>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: <alex.kanavin@gmail.com>, <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 1/6] bitbake-setup: add the initial
 implementation
References: <20250901135836.2927686-1-alex.kanavin@gmail.com>
In-Reply-To: <20250901135836.2927686-1-alex.kanavin@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 14:16:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17944

Hi,

On Mon Sep 1, 2025 at 3:58 PM CEST, Alexander Kanavin via lists.openembedde=
d.org wrote:
[...]
> +def write_settings(top_dir, force_replace, non_interactive=3DTrue):
> +    settings_path =3D default_settings_path(top_dir)
> +    if not os.path.exists(settings_path) or force_replace:
> +
> +        settings =3D configparser.ConfigParser()
> +        settings['default'] =3D {
> +                             'registry':default_registry,
> +                             'dl-dir':os.path.join(top_dir, '.bitbake-se=
tup-downloads'),
> +                            }
> +        os.makedirs(os.path.dirname(settings_path), exist_ok=3DTrue)
> +
> +        siteconfpath =3D os.path.join(top_dir, 'site.conf')
> +        print('Configuration registry set to\n    {}\n'.format(settings[=
'default']['registry']))
> +        print('Bitbake-setup download cache (DL_DIR) set to\n    {}\n'.f=
ormat(settings['default']['dl-dir']))
> +        print('A new settings file will be created in\n    {}\n'.format(=
settings_path))
> +        print('A common site.conf file will be created, please edit or r=
eplace before running builds\n    {}\n'.format(siteconfpath))
> +        if not non_interactive:
> +            y_or_n =3D input('Bitbake-setup will be configured in {}, y/=
n: '.format(top_dir))
> +            if y_or_n !=3D 'y':
> +                print("\nYou can run 'bitbake-setup write-settings' to e=
dit them before setting up builds")

write-settings does not exist, I think you meant install-settings?

> +                exit()
> +            print()
> +
> +        if os.path.exists(settings_path):
> +            backup_conf =3D settings_path + "-backup.{}".format(time.str=
ftime("%Y%m%d%H%M%S"))
> +            os.rename(settings_path, backup_conf)
> +            print("Previous settings are in {}".format(backup_conf))
> +        with open(settings_path, 'w') as settingsfile:
> +            settings.write(settingsfile)
> +
> +        if os.path.exists(siteconfpath):
> +            backup_siteconf =3D siteconfpath + "-backup.{}".format(time.=
strftime("%Y%m%d%H%M%S"))
> +            os.rename(siteconfpath, backup_siteconf)
> +            print("Previous settings are in {}".format(backup_siteconf))
> +        with open(siteconfpath, 'w') as siteconffile:
> +            siteconffile.write('# This file is intended for build host-s=
pecific bitbake settings\n')
> +
> +def load_settings(top_dir, non_interactive):
> +    # This creates a new settings file if it does not yet exist
> +    write_settings(top_dir, force_replace=3DFalse, non_interactive=3Dnon=
_interactive)
> +
> +    settings_path =3D default_settings_path(top_dir)
> +    settings =3D configparser.ConfigParser()
> +    print('Loading settings from\n    {}\n'.format(settings_path))
> +    settings.read([settings_path])
> +    return settings
> +
> +def change_settings(top_dir, new_settings):
> +    # This creates a new settings file if it does not yet exist
> +    write_settings(top_dir, force_replace=3DFalse)
> +
> +    settings =3D load_settings(top_dir, non_interactive=3DTrue)
> +    for section, section_settings in new_settings.items():
> +        for setting, value in section_settings.items():
> +            settings[section][setting] =3D value
> +            print("Setting '{}' in section '{}' is changed to '{}'".form=
at(setting, section, value))
> +
> +    settings_path =3D default_settings_path(top_dir)
> +    with open(settings_path, 'w') as settingsfile:
> +        settings.write(settingsfile)
> +    print("New settings written to {}".format(settings_path))
> +    return settings
> +
> +def get_build_dir_via_bbpath():
> +    bbpath =3D os.environ.get('BBPATH')
> +    if bbpath:
> +        bitbake_dir =3D os.path.normpath(bbpath.split(':')[0])
> +        if os.path.exists(os.path.join(bitbake_dir,'init-build-env')):
> +            build_dir =3D os.path.dirname(bitbake_dir)
> +            return build_dir
> +    return None
> +
> +def get_default_top_dir():
> +    build_dir_via_bbpath =3D get_build_dir_via_bbpath()
> +    if build_dir_via_bbpath:
> +        top_dir =3D os.path.dirname(build_dir_via_bbpath)
> +        if os.path.exists(default_settings_path(top_dir)):
> +            return top_dir
> +    return os.environ.get('BITBAKE_SETUP_TOP_DIR') or os.path.join(os.pa=
th.expanduser('~'), 'bitbake-builds')
> +
> +def main():
> +    def add_top_dir_arg(parser):
> +        parser.add_argument('--top-dir', default=3Dget_default_top_dir()=
, help=3D'Top level directory where builds are set up and downloaded config=
urations and layers are cached for reproducibility and offline builds, defa=
ult is %(default)s, can be overriden via BITBAKE_SETUP_TOP_DIR environment =
variable')
> +
> +    def add_build_dir_arg(parser):
> +        build_dir =3D get_build_dir_via_bbpath()
> +        if build_dir:
> +            parser.add_argument('--build-dir', default=3Dbuild_dir, help=
=3D"Path to the build, default is %(default)s via BBPATH")
> +        else:
> +            parser.add_argument('--build-dir', required=3DTrue, help=3D"=
Path to the build")

Could we add the shorter form `-b`? I feel like this is going to get typed =
a
lot. Same for --top-dir/-t, although the BITBAKE_SETUP_TOP_DIR variable mak=
es it
less necessary.

> +
> +    parser =3D argparse.ArgumentParser(
> +        description=3D"BitBake setup utility. Run with 'init' argument t=
o get started.",
> +        epilog=3D"Use %(prog)s <subcommand> --help to get help on a spec=
ific command"
> +        )
> +    parser.add_argument('-d', '--debug', help=3D'Enable debug output', a=
ction=3D'store_true')
> +    parser.add_argument('-q', '--quiet', help=3D'Print only errors', act=
ion=3D'store_true')
> +    parser.add_argument('--color', choices=3D['auto', 'always', 'never']=
, default=3D'auto', help=3D'Colorize output (where %(metavar)s is %(choices=
)s)', metavar=3D'COLOR')
> +    parser.add_argument('--no-network', action=3D'store_true', help=3D'D=
o not check whether configuration repositories and layer repositories have =
been updated; use only the local cache.')
> +
> +    subparsers =3D parser.add_subparsers()
> +
> +    parser_list =3D subparsers.add_parser('list', help=3D'List available=
 configurations')
> +    add_top_dir_arg(parser_list)
> +    parser_list.add_argument('--with-expired', action=3D'store_true', he=
lp=3D'List also configurations that are no longer supported due to reaching=
 their end-of-life dates.')
> +    parser_list.add_argument('--write-json', action=3D'store', help=3D'W=
rite available configurations into a json file so they can be programmatica=
lly processed.')
> +    parser_list.set_defaults(func=3Dlist_configs)
> +
> +    parser_init =3D subparsers.add_parser('init', help=3D'Select a confi=
guration and initialize a build from it')
> +    add_top_dir_arg(parser_init)
> +    parser_init.add_argument('config', nargs=3D'*', help=3D"path/URL/id =
to a configuration file (use 'list' command to get available ids), followed=
 by configuration options. Bitbake-setup will ask to choose from available =
choices if command line doesn't completely specify them.")
> +    parser_init.add_argument('--non-interactive', action=3D'store_true',=
 help=3D'Do not ask to interactively choose from available options; if bitb=
ake-setup cannot make a decision it will stop with a failure.')
> +    parser_init.add_argument('--source-overrides', action=3D'store', hel=
p=3D'Override sources information (repositories/revisions) with values from=
 a local json file.')
> +    parser_init.set_defaults(func=3Dinit_config)
> +
> +    parser_status =3D subparsers.add_parser('status', help=3D'Check if t=
he build needs to be synchronized with configuration')
> +    add_build_dir_arg(parser_status)

Do we really need --build-dir for the status command?

"bitbake-setup status" alone returns:

  usage: bitbake-setup status [-h] --build-dir BUILD_DIR
  bitbake-setup status: error: the following arguments are required: --buil=
d-dir

Maybe BUILD_DIR should be the only positional argument instead of an option=
al
one:

  bitbake-setup status <build_dir>

> +    parser_status.set_defaults(func=3Dbuild_status)
> +
> +    parser_update =3D subparsers.add_parser('update', help=3D'Update a b=
uild to be in sync with configuration')
> +    add_build_dir_arg(parser_update)
> +    parser_update.set_defaults(func=3Dbuild_update)
> +
> +    parser_install_settings =3D subparsers.add_parser('install-settings'=
, help=3D'Write a settings file with default values into the top level dire=
ctory (contains the location of build configuration registry, downloads dir=
ectory and other global settings)')
> +    add_top_dir_arg(parser_install_settings)
> +    parser_install_settings.set_defaults(func=3Dwrite_settings)
> +
> +    parser_change_setting =3D subparsers.add_parser('change-setting', he=
lp=3D'Change a setting in the settings file')
> +    add_top_dir_arg(parser_change_setting)
> +    parser_change_setting.add_argument('section', help=3D"Section in a s=
ettings file, typically 'default'")
> +    parser_change_setting.add_argument('key', help=3D"Name of the settin=
g")
> +    parser_change_setting.add_argument('value', help=3D"Value of the set=
ting")
> +    parser_change_setting.set_defaults(func=3Dchange_settings)
> +
> +    args =3D parser.parse_args()
> +
> +    logging.basicConfig(stream=3Dsys.stdout)
> +    if args.debug:
> +        logger.setLevel(logging.DEBUG)
> +    elif args.quiet:
> +        logger.setLevel(logging.ERROR)
> +
> +    # Need to re-run logger_create with color argument
> +    # (will be the same logger since it has the same name)
> +    bb.msg.logger_create('bitbake-setup', output=3Dsys.stdout,
> +                         color=3Dargs.color,
> +                         level=3Dlogger.getEffectiveLevel())
> +
> +
> +    if hasattr(args, 'build_dir'):
> +        if not os.path.exists(os.path.join(args.build_dir,'build', 'init=
-build-env')):
> +            print("Not a valid build directory: build/init-build-env doe=
s not exist in {}".format(args.build_dir))
> +            return
> +        # commands without --top-dir argument (status, update) still nee=
d to know where
> +        # the top dir is, but it should be auto-deduced as parent of arg=
s.build_dir
> +        if not hasattr(args, 'top_dir'):
> +            args.top_dir =3D os.path.dirname(os.path.normpath(args.build=
_dir))
> +
> +    if 'func' in args:
> +        print('Bitbake-setup is using {} as top directory (can be change=
d with --top-dir argument or BITBAKE_SETUP_TOP_DIR variable).\n'.format(arg=
s.top_dir))
> +        if args.func =3D=3D write_settings:
> +            write_settings(args.top_dir, force_replace=3DTrue)
> +        elif args.func =3D=3D change_settings:
> +            change_settings(args.top_dir, {args.section:{args.key:args.v=
alue}})
> +        else:
> +            if not hasattr(args, 'non_interactive'):
> +                args.non_interactive =3D True
> +            settings =3D load_settings(args.top_dir, args.non_interactiv=
e)
> +            d =3D init_bb_cache(settings, args)
> +            args.func(settings, args, d)
> +            save_bb_cache()
> +    else:
> +        from argparse import Namespace
> +        parser.print_help()
> +
> +main()

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


