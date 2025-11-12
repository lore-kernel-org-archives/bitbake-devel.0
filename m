Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E59CCFA1A
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 05:57:03 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6999.1762927022632254618
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Nov 2025 21:57:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=XMdWgTht;
 spf=pass (domain: gmail.com, ip: 209.85.219.41, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-882390f7952so5268306d6.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 11 Nov 2025 21:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762927021; x=1763531821; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh6CipSaHPJaTjiYBfqJnQ2vqk9XEE3vjkB+2D+LHOU=;
        b=XMdWgThts/VsmVdpSnLkW2/Y7NeBsaqxOuxuvaqmNmgBglgWtEL6vhjZ3FvvS6xUw5
         sPRwY+dwUyyurTt9dQKPQOImrg+LpXoDoCQNPJmZTPRvQK0crlDlXIse9kocD89w3LiU
         qSWUvFiJ8p9XZLaxcIyIc8Ke7QE4EYE6auopVHZ96x62vXARy4+rs53jMgFyI9DF4t4l
         +dQ2dUxb9Y+e/1GQcjMOxnXAjivXyF2KYKehQj4ltpW/S0/fhks0o8KTscxAZmhQG/+A
         zofnC2UpFUoVqQLbqtEYrJIEf/QOpogGNX05801kuHy+Hgya1ebK2gQ3e1qwbGFgoMcO
         NZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762927021; x=1763531821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uh6CipSaHPJaTjiYBfqJnQ2vqk9XEE3vjkB+2D+LHOU=;
        b=W/ukgBJtJMZmKHrnksgvGcHZxihKN+alaX01jA/A0PVyc699KYF6MaxdGYeZWu5ihI
         6zPgoLgsBFQkiX+yObR02Eiz96z/P1SvsfLhrRFBqrwricSZkAQ/2eJe8k/ann1WQtDY
         DfOX2n+JT8ZalJm3ma3WWqbThuubwVMTvlXHLthQxV7TQoZRTmI7lgBnwJfPl9gqEil6
         nKH4Xx8Ytm9V5IIIA6oStHrGErW+KaOquwZCRWmdZXzagQJSjrzZM1pDKzCFPAzIIWps
         Ewp1WxasxSuoQYJ4QLPKH2XRAz94M2TO1jRanY+ntrgj+muu5s2Wn5LbqYfhRImHzh9j
         mlkw==
X-Gm-Message-State: AOJu0YwelFSva55cURBkgKaGkGMIJ6xVIlO4/Iv4VHyYglAewD5iay6W
	Cmv9jeSeF9wQzLzShKU9xQPLiYcQDjsP+yKRT2ISsIdxF2TTauE5sTofC0Oa84vSfNxbCyt0Uc5
	VvE5wuehCuE2280z26ujOvFrhsA3+hrU=
X-Gm-Gg: ASbGnctscDt/kOm3DwBgsoNWvjhpb4ImDckNv8qnv2H220/h6pvjiPzGrGgqbQUBSaN
	LAsDsWWpZoX2/hAhqw2pXQ7yeV4R/ZNBOY3iiFwncIy9JoNZK0nI8NOXKU2tQ5ufJI7ooL5O2tJ
	QWxZfDaJ36P0ozS6EJZiKbP7PcRgiAx8HhinMKdxAUyjjWnaZ6e9bxKiPp7F8ogT2dBXmrZZqCJ
	W7j7SEvYcoyAEi81nGVJc3N1EudelsA96O9MyCxMx1gFmVt3HV2j+mAldKwJD90r0IYWA==
X-Google-Smtp-Source: AGHT+IGViguQY1PkNY41cDxffeq+khQ71Le0Nt5iYlFey7CKZY+J3NHlt44ucZYw0KXMW0mrAjVbiim9zUEwKmbKG1U=
X-Received: by 2002:a05:6214:20c6:b0:882:5e6e:b94e with SMTP id
 6a1803df08f44-88271a35dcbmr27237446d6.45.1762927021516; Tue, 11 Nov 2025
 21:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20251111223325.2034322-1-adrian.freihofer@siemens.com> <20251111223325.2034322-3-adrian.freihofer@siemens.com>
In-Reply-To: <20251111223325.2034322-3-adrian.freihofer@siemens.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 12 Nov 2025 06:56:51 +0100
X-Gm-Features: AWmQ_bkr39mCnoDtvKb7HCIjYNfgpln99G8GwluJXXpQcaOf89Sr_90GUyKot8A
Message-ID: <CANNYZj-msfr_qFD_3UNTB2BCm_Vqr25cuOfPn9=0yNo0jzYjEg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/3] bitbake-setup: default top-dir to
 empty string
To: adrian.freihofer@siemens.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Nov 2025 05:57:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18342

This I have to firmly say no to.

bitbake-setup doesn't just create setup directories under the top dir,
it also creates local settings, site.conf, downloads and bitbake cache
in it. This would put all of it in the current directory. Then users
realize they messed up, and need it elsewhere, and it's tricky to
clean up because some of it is hidden (.-prefixed). It's much much
better to create a single directory - top-dir-name, and put all of it
there.

There's also something rather confusing about setting top-dir-name to
'' so that it would not be created at all. If you really not want it,
it should be a separate boolean setting.

Alex

On Tue, 11 Nov 2025 at 23:34, Adrian Freihofer via
lists.openembedded.org
<adrian.freihofer=siemens.com@lists.openembedded.org> wrote:
>
> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
> Change the default for top-dir to be an empty string instead of
> "bitbake-builds". This makes the build directory be created directly
> under the specified top-dir-prefix (which defaults to the current working
> directory).
>
> This allows to do:
>     mkdir -p ~/temp/bb-test
>     cd ~/temp/bb-test
>     bitbake-setup init
>       ...
>       setup-dir = poky-altcfg
>
> ending up with the build directory at:
>   ~/temp/bb-test/poky-altcfg/build
>
> bitbake-selftest: improve tests for top-dir-name setting
>
> Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> ---
>  bin/bitbake-setup     |  2 +-
>  lib/bb/tests/setup.py | 19 +++++++++++++------
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index bda62f5f4..5a0ad599a 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -871,7 +871,7 @@ def main():
>          builtin_settings = {}
>          builtin_settings['default'] = {
>                           'top-dir-prefix':os.getcwd(),
> -                         'top-dir-name':'bitbake-builds',
> +                         'top-dir-name':'',
>                           'registry':default_registry,
>                           }
>
> diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
> index d761ee734..85bb33db4 100644
> --- a/lib/bb/tests/setup.py
> +++ b/lib/bb/tests/setup.py
> @@ -233,22 +233,28 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>          if 'BBPATH' in os.environ:
>              del os.environ['BBPATH']
>
> +        TOP_DIR_NAME = 'bitbake-builds'
> +
>          # check that no arguments works
>          self.runbbsetup("")
>
>          # check that --help works
>          self.runbbsetup("--help")
>
> -        # check that the default top-dir-prefix is cwd before any settings are configured
> +        # check that the default top-dir-prefix is cwd and top-dir-name is empty before any settings are configured
>          out = self.runbbsetup("settings list")
>          self.assertIn("default top-dir-prefix {}".format(os.getcwd()), out[0])
> +        self.assertIn("default top-dir-name", out[0])
>
> -        # set up global location for top-dir-prefix
> +        # set up global location for top-dir-prefix and top-dir-name
>          out = self.runbbsetup("settings set --global default top-dir-prefix {}".format(self.tempdir))
>          settings_path = "{}/global-config".format(self.tempdir)
>          self.assertIn(settings_path, out[0])
>          self.assertIn("From section 'default' the setting 'top-dir-prefix' was changed to", out[0])
>          self.assertIn("Settings written to".format(settings_path), out[0])
> +        out = self.runbbsetup('settings set --global default top-dir-name "{}"'.format(TOP_DIR_NAME))
> +        self.assertIn("From section 'default' the setting 'top-dir-name' was changed to '{}'".format(TOP_DIR_NAME), out[0])
> +        self.assertIn("Settings written to".format(settings_path), out[0])
>          out = self.runbbsetup("settings set --global default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')))
>          self.assertIn("From section 'default' the setting 'dl-dir' was changed to", out[0])
>          self.assertIn("Settings written to".format(settings_path), out[0])
> @@ -256,7 +262,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>          # check that writing settings works and then adjust them to point to
>          # test registry repo
>          out = self.runbbsetup("settings set default registry 'git://{};protocol=file;branch=master;rev=master'".format(self.registrypath))
> -        settings_path = "{}/bitbake-builds/settings.conf".format(self.tempdir)
> +        settings_path = os.path.join(self.tempdir, TOP_DIR_NAME, "settings.conf")
>          self.assertIn(settings_path, out[0])
>          self.assertIn("From section 'default' the setting 'registry' was changed to", out[0])
>          self.assertIn("Settings written to".format(settings_path), out[0])
> @@ -264,6 +270,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>          # check that listing settings works
>          out = self.runbbsetup("settings list")
>          self.assertIn("default top-dir-prefix {}".format(self.tempdir), out[0])
> +        self.assertIn("default top-dir-name {}".format(TOP_DIR_NAME), out[0])
>          self.assertIn("default dl-dir {}".format(os.path.join(self.tempdir, 'downloads')), out[0])
>          self.assertIn("default registry {}".format('git://{};protocol=file;branch=master;rev=master'.format(self.registrypath)), out[0])
>
> @@ -307,7 +314,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>          for cf, v in test_configurations.items():
>              for c in v['buildconfigs']:
>                  out = self.runbbsetup("init --non-interactive {} {}".format(v['cmdline'], c))
> -                setuppath = os.path.join(self.tempdir, 'bitbake-builds', '{}-{}'.format(cf, c))
> +                setuppath = os.path.join(self.tempdir, TOP_DIR_NAME, '{}-{}'.format(cf, c))
>                  self.check_setupdir_files(setuppath, test_file_content)
>                  os.environ['BBPATH'] = os.path.join(setuppath, 'build')
>                  out = self.runbbsetup("status")
> @@ -329,7 +336,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>                    'gizmo-env-passthrough',
>                    'gizmo-no-fragment',
>                    'gadget-notemplate', 'gizmo-notemplate'):
> -            setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
> +            setuppath = os.path.join(self.tempdir, TOP_DIR_NAME, 'test-config-1-{}'.format(c))
>              os.environ['BBPATH'] = os.path.join(setuppath, 'build')
>              out = self.runbbsetup("status")
>              self.assertIn("Layer repository file://{} checked out into {}/layers/test-repo updated revision master from".format(self.testrepopath, setuppath), out[0])
> @@ -352,7 +359,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>                    'gizmo-env-passthrough',
>                    'gizmo-no-fragment',
>                    'gadget-notemplate', 'gizmo-notemplate'):
> -            setuppath = os.path.join(self.tempdir, 'bitbake-builds', 'test-config-1-{}'.format(c))
> +            setuppath = os.path.join(self.tempdir, TOP_DIR_NAME, 'test-config-1-{}'.format(c))
>              os.environ['BBPATH'] = os.path.join(setuppath, 'build')
>              out = self.runbbsetup("status")
>              self.assertIn("Configuration in {} has changed:".format(setuppath), out[0])
> --
> 2.51.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18339): https://lists.openembedded.org/g/bitbake-devel/message/18339
> Mute This Topic: https://lists.openembedded.org/mt/116247252/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

