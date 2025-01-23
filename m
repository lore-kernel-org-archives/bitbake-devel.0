Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4464BC02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 10:12:00 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.web10.7467.1737627119509317403
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jan 2025 02:11:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IwkUG7Z6;
 spf=pass (domain: gmail.com, ip: 209.85.222.178, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b6f95d2eafso75070085a.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737627118; x=1738231918; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZMWMBWhnhcNngQ7X2+IA/1vAAIxanJbzskZOVD6y2Y=;
        b=IwkUG7Z6EZGwjKagJQQRX2UfG1zLaFhEhejwQ+hC8YoUEYL+wKuYTPbX0bdTzwzvbg
         ND+SkyY8jsRAaEq3V9oD8ImNPpCIbsqy4LvHX6SSb+KpFCognlrFL5hNOOLm/+7C1rCT
         Rev8m4Ivr5nmObNjD7PBrvyU8ReyYLbV4Cr+asbIhx9ALiD4iRrtCCz/26gqHma5Bl3g
         yg4lmtFi/DnNl4UKFFQYxp13c2VqF2CEvO3LIxXlkA+WhWzBa4dEBVHfOnxKoYMUqqq3
         uS2nkzb/A7puBylVRNMg0l6ibdcMkNj/5nmjnXTwC0yGbhDI2WxzftwCceptGc6LuUI1
         2fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737627118; x=1738231918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZMWMBWhnhcNngQ7X2+IA/1vAAIxanJbzskZOVD6y2Y=;
        b=lV0h3nTHAvheFDo4iUnN/03jvnIVS2bB52ZW7WcSNBdslBHYm7pCMdozJc+Fw7cM7Q
         yexAeY9FYhM6WtZwmesKBeYpaJXAHJvLVyPeOipzdld3x3WnpfNyBRwCcxDsSCu10XwT
         3ZKXfefks6qolckmi6Qzt1dvbbsCxHm3rI1oi8Zm/kXfQt47Dwbc/UcKwqxx3s9GQbYN
         Trh6sOeQltt/XN9Dm6EGmTcuQzycKDKfg7bo5MKI7tyUwdeoW9lNJEx017BhWAhwbpFi
         rqJxUlb5D/FtQjr1dAsNYQhkufxKgoinEVsJeC3fNhvozLghDaYaoHj0vvKoB2IcLspt
         TaIg==
X-Gm-Message-State: AOJu0YxkbSOGo4y71EZ984bk8OPbgyXJZdqN8d4dVBQV0uxqkejB3Jws
	EcFu2rm29ZR410D1vXcIqNJOmwGPZYxXBwYBVu8oiDvGgB4LoyBJzOGJJtKMBZooUmXMKCQXMyG
	gTFMh8IXLToq8LyCPtIaeHf9tmfA=
X-Gm-Gg: ASbGncsAcJExhJPfuyqSgMZa021eXyHd8NemlCo7ojtPG/h84j8A4rIwHWoZQN/CxXl
	qSJC5zVWAUyihU4x/8vL7xqBc2uS2u/lkW1iJm5/XGO2IAQe9AcUSMdrKGYk+V5XSNBw2q073YU
	EDI0BgL99T0wen7C43YxfJ
X-Google-Smtp-Source: AGHT+IH8jq5e+ku82QcVQmSgFIP4brUerOxic7Bjjt58Sz1esmNFfzAVhKwSBMrsDudvmpQKok5GGnHMkRcH7Emd6No=
X-Received: by 2002:a05:622a:252:b0:466:b122:5138 with SMTP id
 d75a77b69052e-46e12a583famr320551691cf.17.1737627118059; Thu, 23 Jan 2025
 02:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20250117141127.255295-1-alex.kanavin@gmail.com> <CA+chaQdX-s6M8oqmURoe1ZcC3cr_5FPW5GHxzcESfOUoLK60VQ@mail.gmail.com>
In-Reply-To: <CA+chaQdX-s6M8oqmURoe1ZcC3cr_5FPW5GHxzcESfOUoLK60VQ@mail.gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 23 Jan 2025 11:11:46 +0100
X-Gm-Features: AWEUYZllEl-cHPX5q4yf2PUIztty4GnTL8S9SD9czrX26f5oGwsIhmLkrfkdPCU
Message-ID: <CANNYZj-5nvwvUxr_m8DdQ8buduaShKA1XjRSB_xREZADeko8Kg@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH 1/2] bitbake-setup: add the proof of
 concept implementation
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 10:12:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17068

Normally I'd say it's published here:

https://github.com/kanavin/bitbake/

but I pushed some WIP commits there that need to be discarded to match
what was posted to the list.

Alex

On Thu, 23 Jan 2025 at 11:08, Martin Jansa <martin.jansa@gmail.com> wrote:
>
> Is there a branch with these changes? I haven't found it in
> bitbake-contrib nor poky-contrib.
>
> Applying the patch from patchwork with git am fails as it tries to
> apply the diffs from commit message as well:
>
> Applying: bitbake-setup: add the proof of concept implementation
> error: home/alex/builds/poky-alex/config-tmp-asoubw5u/poky-alex.conf.json=
:
> does not exist in index
> error: home/alex/builds/poky-alex/build-gadget/conf/local.conf: does
> not exist in index
> Patch failed at 0001 bitbake-setup: add the proof of concept implementati=
on
>
> I've already applied it manually, but it might be useful for other people=
.
>
> On Fri, Jan 17, 2025 at 3:11=E2=80=AFPM Alexander Kanavin via
> lists.openembedded.org <alex.kanavin=3Dgmail.com@lists.openembedded.org>
> wrote:
> >
> > From: Alexander Kanavin <alex@linutronix.de>
> >
> > For the rationale and design guidelines please see this message:
> > https://lists.openembedded.org/g/openembedded-architecture/message/1913
> >
> > Left out for now but will be done later:
> >
> > - base bitbake configs (a way to declare the common parts between sever=
al bitbake build configurations just once, like a parent 'class')
> > (this is inspired by a similar mechannism in yocto-autobuilder)
> >
> > - tighten the terminology: 'build' and 'configuration' are each used to=
 refer to
> > several distinct things, and should be replaced by specific, unambigous=
 terms
> >
> > - documentation
> >
> > - official configuration repository (this probably depends on oe-core b=
eing
> > populated with a rich, useful set of fragments)
> >
> > 1. If you don't know where to start, list available configurations, and=
 pick one:
> >
> > =3D=3D=3D
> > alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup list
> > Default parameter values are in /home/alex/.bitbake-setup/config - adju=
st as needed.
> >
> > Fetching configuration repository git://github.com/kanavin/bitbake-setu=
p-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain into /home/a=
lex/.bitbake-setup/configurations
> >
> > Available configurations:
> > poky-alex       Poky reference distribution, with alex fixes
> > poky-kirkstone  Poky reference distribution, kirkstone long term suppor=
t release (supported until April 2026)
> > poky-ng Poky-ng configuration: like poky but built from individual repo=
sitories
> > =3D=3D=3D
> >
> > 2. Then build is initialized this way:
> > =3D=3D=3D
> > alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup init poky-ng
> > Default parameter values are in /home/alex/.bitbake-setup/config - adju=
st as needed.
> >
> > Initializing a poky-ng build in /home/alex/builds/poky-ng
> > Fetching configuration repository git://github.com/kanavin/bitbake-setu=
p-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain into /home/a=
lex/.bitbake-setup/configurations
> > Fetching layer/tool repository bitbake into /home/alex/builds/poky-ng/l=
ayers/bitbake
> > Fetching layer/tool repository openembedded-core into /home/alex/builds=
/poky-ng/layers/openembedded-core
> > Fetching layer/tool repository meta-yocto into /home/alex/builds/poky-n=
g/layers/meta-yocto
> > Fetching layer/tool repository yocto-docs into /home/alex/builds/poky-n=
g/layers/yocto-docs
> >
> > Setting up configuration in /home/alex/builds/poky-ng/build-default
> > Configuration summary:
> > This is the default build configuration for the openembedded-core layer=
.
> >
> > Additional information is in /home/alex/builds/poky-ng/build-default/co=
nf/conf-notes.txt
> >
> > Run /home/alex/builds/poky-ng/build-default/build-targets to execute th=
e default build targets for this configuration.
> > Source the environment using '. /home/alex/builds/poky-ng/build-default=
/init-build-env' to run builds from the command line.
> > The bitbake build configuration (local.conf, bblayers.conf and more) ca=
n be found in /home/alex/builds/poky-ng/build-default/conf
> > =3D=3D=3D
> >
> > Note: 'init' sub-command can also take a path or a URL with a configura=
tion file directly.
> > You can see how those files look like here:
> > https://github.com/kanavin/bitbake-setup-configurations
> >
> > 3. The above message refers to a one-liner shell script that would buil=
d the targets
> > specified in the chosen configuration:
> > =3D=3D=3D
> > alex@Zen2:/srv/work/alex/bitbake$ cat /home/alex/builds/poky-alex/build=
-gadget/build-targets
> > . /home/alex/builds/poky-alex/build-gadget/init-build-env && bitbake co=
re-image-minimal
> > =3D=3D=3D
> >
> > 4. You should also source the environment, and then subsequent status/u=
pdate commands
> > will not require a parameter telling bitbake-setup where the initialize=
d build is.
> >
> > 5. To check if the build configuration needs to be updated, run:
> > =3D=3D=3D
> > Default parameter values are in /home/alex/.bitbake-setup/config - adju=
st as needed.
> >
> > Fetching configuration repository git://github.com/kanavin/bitbake-setu=
p-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain into /home/a=
lex/.bitbake-setup/configurations
> > Configuration in /home/alex/builds/poky-ng/ has not changed.
> > =3D=3D=3D
> >
> > If the configuration has changed, you will see the difference:
> > =3D=3D=3D
> > alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup status
> > ...
> > Top level configuration in /home/alex/builds/poky-alex has changed:
> > --- /home/alex/builds/poky-alex/config/poky-alex.conf.json      2024-12=
-16 11:43:24.077446096 +0100
> > +++ /home/alex/builds/poky-alex/config-tmp-asoubw5u/poky-alex.conf.json=
 2024-12-16 11:47:43.237104405 +0100
> > @@ -7,7 +7,7 @@
> >                          "uri": "git://git.yoctoproject.org/poky-contri=
b"
> >                      }
> >                  },
> > -                "rev": "akanavin/sstate-for-all"
> > +                "rev": "akanavin/bitbake-setup-testing"
> >              },
> >              "path": "poky"
> >          }
> > =3D=3D=3D
> >
> > If the configuration has not changed, but layer revisions referred to i=
t have (for example
> > if the configuration specifies a tip of a branch), you will see that to=
o:
> > =3D=3D=3D
> > alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup status
> > ...
> > Layer repository git://git.yoctoproject.org/poky-contrib checked out in=
to /home/alex/builds/poky-alex/layers/poky updated revision akanavin/sstate=
-for-all from 6b842ba55f996b27c900e3de78ceac8cb3b1c492 to aeb73e29379fe6007=
a8adc8d94c1ac18a93e68de
> > =3D=3D=3D
> >
> > 6. If the configuration has changed, you can bring it in sync with:
> > =3D=3D=3D
> > alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup update ~/builds/pok=
y-alex/
> > Default parameter values are in /home/alex/.bitbake-setup/config - adju=
st as needed.
> >
> > Fetching configuration repository git://github.com/kanavin/bitbake-setu=
p-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain into /home/a=
lex/.bitbake-setup/configurations
> > Layer repository git://git.yoctoproject.org/poky-contrib checked out in=
to /home/alex/builds/poky-alex/layers/poky updated revision akanavin/bitbak=
e-setup-testing from d174acad934f8ad1fe303abc5705733e15542859 to a3d2ee1004=
5f8c1151d680ad97994c5d6cf51ece
> > Fetching layer/tool repository poky into /home/alex/builds/poky-alex/la=
yers/poky
> >
> > Setting up configuration in /home/alex/builds/poky-alex/build-gadget
> > Existing bitbake congfiguration directory renamed to /home/alex/builds/=
poky-alex/build-gadget/conf-backup.20241216115007
> > The bitbake configuration has changed:
> > diff -uNr /home/alex/builds/poky-alex/build-gadget/conf-backup.20241216=
115007/local.conf /home/alex/builds/poky-alex/build-gadget/conf/local.conf
> > --- /home/alex/builds/poky-alex/build-gadget/conf-backup.20241216115007=
/local.conf      2024-12-16 11:47:51.865043102 +0100
> > +++ /home/alex/builds/poky-alex/build-gadget/conf/local.conf    2024-12=
-16 11:50:07.811942847 +0100
> > @@ -287,5 +287,3 @@
> >  # track the version of this file when it was generated. This can safel=
y be ignored if
> >  # this doesn't mean anything to you.
> >  CONF_VERSION =3D "2"
> > -
> > -TCLIBC =3D "musl"
> >
> > Configuration summary:
> > This is the default build configuration for the Poky reference distribu=
tion.
> >
> > Additional information is in /home/alex/builds/poky-alex/build-gadget/c=
onf/conf-notes.txt
> >
> > Run /home/alex/builds/poky-alex/build-gadget/build-targets to execute t=
he default build targets for this configuration.
> > Source the environment using '. /home/alex/builds/poky-alex/build-gadge=
t/init-build-env' to run builds from the command line.
> > The bitbake build configuration (local.conf, bblayers.conf and more) ca=
n be found in /home/alex/builds/poky-alex/build-gadget/conf
> > =3D=3D=3D
> >
> > Note that it will also rename/preserve the existing build/conf director=
y, and print changes
> > in bitbake configuration (diff of content of build/conf/) if that has c=
hanged. I can't
> > at the moment think of anything more clever that is also not much more =
brittle or complex
> > to implement, but open to suggestions.
> >
> > 7. To make it easier to review the code, please also review the data it=
's operating on:
> > =3D=3D=3D
> > alex@Zen2:/srv/work/alex/bitbake$ ls ~/.bitbake-setup/
> > cache  configurations  downloads
> > alex@Zen2:/srv/work/alex/bitbake$ ls ~/builds/poky-alex/
> > build  config  config-upstream.json  layers
> > =3D=3D=3D
> >
> > This commit includes a fix by Ryan Eatmon <reatmon@ti.com>:
> > https://github.com/kanavin/bitbake/pull/1
> >
> > Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> > ---
> >  bin/bitbake-setup | 403 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 403 insertions(+)
> >  create mode 100755 bin/bitbake-setup
> >
> > diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> > new file mode 100755
> > index 000000000..9a78963a6
> > --- /dev/null
> > +++ b/bin/bitbake-setup
> > @@ -0,0 +1,403 @@
> > +#!/usr/bin/env python3
> > +
> > +#
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +
> > +import logging
> > +import os
> > +import sys
> > +import argparse
> > +import warnings
> > +import json
> > +import shutil
> > +import time
> > +import stat
> > +import tempfile
> > +import configparser
> > +import datetime
> > +
> > +bindir =3D os.path.abspath(os.path.dirname(__file__))
> > +topdir =3D os.path.dirname(bindir)
> > +sys.path[0:0] =3D [os.path.join(topdir, 'lib')]
> > +
> > +import bb.msg
> > +import bb.process
> > +
> > +logger =3D bb.msg.logger_create('bitbake-setup', sys.stdout)
> > +
> > +def init_bb_cache(args):
> > +    dldir =3D os.path.join(args.cache_dir, 'downloads')
> > +    bb_cachedir =3D os.path.join(args.cache_dir, 'cache')
> > +
> > +    d =3D bb.data.init()
> > +    d.setVar("DL_DIR", dldir)
> > +    d.setVar("BB_CACHEDIR", bb_cachedir)
> > +    d.setVar("__BBSRCREV_SEEN", "1")
> > +    if args.no_network:
> > +        d.setVar("BB_SRCREV_POLICY", "cache")
> > +    bb.fetch.fetcher_init(d)
> > +    return d
> > +
> > +def get_config_name(config):
> > +    return os.path.basename(config).split('.')[0]
> > +
> > +def copy_and_commit_config(config_path, dest_config_dir):
> > +    shutil.copy(config_path, dest_config_dir)
> > +
> > +    bb.process.run("git -C {} add .".format(dest_config_dir))
> > +    bb.process.run("git -C {} commit -a -m 'Configuration at {}'".form=
at(dest_config_dir, time.asctime()))
> > +
> > +def _write_layer_list(dest, repodirs):
> > +    layers =3D []
> > +    for r in repodirs:
> > +        for root, dirs, files in os.walk(os.path.join(dest,r)):
> > +            if os.path.basename(root) =3D=3D 'conf' and 'layer.conf' i=
n files:
> > +                layers.append(os.path.relpath(os.path.dirname(root), d=
est))
> > +    layers_f =3D os.path.join(dest, ".oe-layers.json")
> > +    with open(layers_f, 'w') as f:
> > +        json.dump({"version":"1.0","layers":layers}, f, sort_keys=3DTr=
ue, indent=3D4)
> > +
> > +def checkout_layers(layers, layerdir, d):
> > +    repodirs =3D []
> > +    oesetupbuild =3D None
> > +    for r_name in layers:
> > +        r_data =3D layers[r_name]
> > +        repodir =3D r_data["path"]
> > +        repodirs.append(repodir)
> > +
> > +        r_remote =3D r_data['git-remote']
> > +        rev =3D r_remote['rev']
> > +        remotes =3D r_remote['remotes']
> > +
> > +        for remote in remotes:
> > +            type,host,path,user,pswd,params =3D bb.fetch.decodeurl(rem=
otes[remote]["uri"])
> > +            fetchuri =3D bb.fetch.encodeurl(('git',host,path,user,pswd=
,params))
> > +            print("Fetching layer/tool repository {} into {}".format(r=
_name, os.path.join(layerdir,repodir)))
> > +            fetcher =3D bb.fetch.Fetch(["{};protocol=3D{};rev=3D{};nob=
ranch=3D1;destsuffix=3D{}".format(fetchuri,type,rev,repodir)], d)
> > +            do_fetch(fetcher, layerdir)
> > +
> > +        if os.path.exists(os.path.join(layerdir, repodir, 'scripts/oe-=
setup-build')):
> > +            oesetupbuild =3D os.path.join(layerdir, repodir, 'scripts/=
oe-setup-build')
> > +
> > +    _write_layer_list(layerdir, repodirs)
> > +
> > +    if oesetupbuild:
> > +        oesetupbuild_symlink =3D os.path.join(layerdir, 'setup-build')
> > +        if os.path.exists(oesetupbuild_symlink):
> > +            os.remove(oesetupbuild_symlink)
> > +        os.symlink(os.path.relpath(oesetupbuild,layerdir),oesetupbuild=
_symlink)
> > +
> > +def setup_build(name, config, layerdir, topbuilddir):
> > +    builddir =3D os.path.join(topbuilddir, "build-{}".format(name))
> > +    print("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D")
> > +    print("Setting up configuration {} in {}".format(name, builddir))
> > +
> > +    template =3D config.get("oe-template")
> > +    if not template:
> > +        print("Configuration does not contain a reference to an OpenEm=
bedded build template via 'oe-template'; please use oe-setup-build, oe-init=
-build-env or another mechanism manually to complete the setup.")
> > +        return
> > +    oesetupbuild =3D os.path.join(layerdir, 'setup-build')
> > +    if not os.path.exists(oesetupbuild):
> > +        raise Exception("Cannot complete setting up a build directory =
from OpenEmbedded template '{}' as oe-setup-build was not found in any laye=
rs; please use oe-init-build-env manually.".format(template))
> > +
> > +    confdir =3D os.path.join(builddir, 'conf')
> > +    backup_confdir =3D confdir + "-backup.{}".format(time.strftime("%Y=
%m%d%H%M%S"))
> > +    if os.path.exists(confdir):
> > +        os.rename(confdir, backup_confdir)
> > +    bb.process.run("{} setup -c {} -b {} --no-shell".format(oesetupbui=
ld, template, builddir))
> > +
> > +    build_script =3D os.path.join(builddir, "build-targets")
> > +    init_script =3D os.path.join(builddir, "init-build-env")
> > +    targets =3D " && ".join(config["targets"])
> > +    shell =3D os.path.basename(os.environ.get("SHELL","bash"))
> > +    with open(build_script,'w') as f:
> > +        f.write("#!/usr/bin/env {}\n. {} && {}\n".format(shell, init_s=
cript, targets))
> > +    st =3D os.stat(build_script)
> > +    os.chmod(build_script, st.st_mode | stat.S_IEXEC)
> > +
> > +    fragments =3D config.get("oe-fragments")
> > +    if fragments:
> > +        for f in fragments:
> > +            bb.process.run("{} -c '. {} && bitbake-config-build enable=
-fragment {}'".format(shell, init_script, f))
> > +
> > +    if os.path.exists(backup_confdir):
> > +        config_diff =3D get_diff(backup_confdir, confdir)
> > +        if config_diff:
> > +            print("Existing bitbake configuration directory renamed to=
 {}".format(backup_confdir))
> > +            print("The bitbake configuration has changed:")
> > +            print(config_diff)
> > +        else:
> > +            shutil.rmtree(backup_confdir)
> > +
> > +    with open(os.path.join(builddir,'conf/conf-summary.txt')) as f:
> > +        print("Configuration summary:\n{}\nAdditional information is i=
n {}\n".format(f.read(), os.path.join(builddir,'conf/conf-notes.txt')))
> > +    print("Run {} to execute the default build targets for this config=
uration.".format(build_script))
> > +    print("Source the environment using '. {}' to run builds from the =
command line.".format(init_script))
> > +    print("The bitbake build configuration (local.conf, bblayers.conf =
and more) can be found in {}/conf".format(builddir))
> > +
> > +def get_registry_config(registry_path, id, dest_dir):
> > +    for root, dirs, files in os.walk(registry_path):
> > +        for f in files:
> > +            if f.endswith('.conf.json') and id =3D=3D get_config_name(=
f):
> > +                shutil.copy(os.path.join(root, f), dest_dir)
> > +                return f
> > +    raise Exception("Unable to find {} in available configurations; us=
e 'list' sub-command to see what is available".format(id))
> > +
> > +def obtain_config(upstream_config, dest_dir, args, d):
> > +    if upstream_config["type"] =3D=3D 'local':
> > +        shutil.copy(upstream_config['path'], dest_dir)
> > +        basename =3D os.path.basename(upstream_config['path'])
> > +    elif upstream_config["type"] =3D=3D 'network':
> > +        bb.process.run("wget {}".format(upstream_config["uri"]), cwd=
=3Ddest_dir)
> > +        basename =3D os.path.basename(upstream_config['uri'])
> > +    elif upstream_config["type"] =3D=3D 'registry':
> > +        registry_path =3D update_registry(upstream_config["registry"],=
 args.cache_dir, d)
> > +        basename =3D get_registry_config(registry_path, upstream_confi=
g["id"], dest_dir)
> > +    else:
> > +        raise Exception("Unknown configuration type: {}".format(upstre=
am_config["type"]))
> > +    return os.path.join(dest_dir, basename)
> > +
> > +def update_build_config(config_path, confdir, topbuilddir, layerdir, d=
, update_layers_only=3DFalse):
> > +    build_configs =3D json.load(open(config_path))["configuration"]["b=
itbake-setup"]
> > +    layer_config =3D json.load(open(config_path))["sources"]
> > +    if not update_layers_only:
> > +        copy_and_commit_config(config_path, confdir)
> > +    checkout_layers(layer_config, layerdir, d)
> > +    for build_name, build_config in build_configs.items():
> > +        setup_build(build_name, build_config, layerdir, topbuilddir)
> > +
> > +def init_config(args, d):
> > +    stdout =3D sys.stdout
> > +    def handle_task_progress(event, d):
> > +        rate =3D event.rate if event.rate else ''
> > +        progress =3D event.progress if event.progress > 0 else 0
> > +        print("{}% {}                ".format(progress, rate), file=3D=
stdout, end=3D'\r')
> > +
> > +    config_name =3D get_config_name(args.config)
> > +    topbuilddir =3D os.path.join(os.path.abspath(args.build_dir_prefix=
), config_name)
> > +    if os.path.exists(topbuilddir):
> > +        print("Build already initialized in {}\nUse 'bitbake-setup sta=
tus' to check if it needs to be updated or 'bitbake-setup update' to perfor=
m the update.".format(topbuilddir))
> > +        return
> > +
> > +    print("Initializing a {} build in {}".format(config_name, topbuild=
dir))
> > +
> > +    if os.path.exists(args.config):
> > +        upstream_config =3D {'type':'local','path':os.path.abspath(arg=
s.config)}
> > +    elif args.config.startswith("http://") or args.config.startswith("=
https://"):
> > +        upstream_config =3D {'type':'network','uri':args.config}
> > +    else:
> > +        upstream_config =3D {'type':'registry','registry':args.registr=
y,'id':args.config}
> > +
> > +    os.makedirs(topbuilddir)
> > +
> > +    with open(os.path.join(topbuilddir, "config-upstream.json"),'w') a=
s s:
> > +        json.dump(upstream_config, s, sort_keys=3DTrue, indent=3D4)
> > +
> > +    confdir =3D os.path.join(topbuilddir, "config")
> > +    layerdir =3D os.path.join(topbuilddir, "layers")
> > +
> > +    os.makedirs(confdir)
> > +    os.makedirs(layerdir)
> > +
> > +    bb.process.run("git -C {} init -b main".format(confdir))
> > +    bb.process.run("git -C {} commit --allow-empty -m 'Initial commit'=
".format(confdir))
> > +
> > +    bb.event.register("bb.build.TaskProgress", handle_task_progress, d=
ata=3Dd)
> > +
> > +    with tempfile.TemporaryDirectory(dir=3Dtopbuilddir, prefix=3D'conf=
ig-tmp-') as tmpdirname:
> > +        config_path =3D obtain_config(upstream_config, tmpdirname, arg=
s, d)
> > +        update_build_config(config_path, confdir, topbuilddir, layerdi=
r, d)
> > +
> > +    bb.event.remove("bb.build.TaskProgress", None)
> > +
> > +def get_diff(file1, file2):
> > +    try:
> > +        bb.process.run('diff -uNr {} {}'.format(file1, file2))
> > +    except bb.process.ExecutionError as e:
> > +        if e.exitcode =3D=3D 1:
> > +            return e.stdout
> > +        else:
> > +            raise e
> > +    return None
> > +
> > +def are_layers_changed(layers, layerdir, d):
> > +    changed =3D False
> > +    for r_name in layers:
> > +        r_data =3D layers[r_name]
> > +        repodir =3D r_data["path"]
> > +
> > +        r_remote =3D r_data['git-remote']
> > +        rev =3D r_remote['rev']
> > +        remotes =3D r_remote['remotes']
> > +
> > +        for remote in remotes:
> > +            type,host,path,user,pswd,params =3D bb.fetch.decodeurl(rem=
otes[remote]["uri"])
> > +            fetchuri =3D bb.fetch.encodeurl(('git',host,path,user,pswd=
,params))
> > +            fetcher =3D bb.fetch.FetchData("{};protocol=3D{};rev=3D{};=
nobranch=3D1;destsuffix=3D{}".format(fetchuri,type,rev,repodir), d)
> > +            upstream_revision =3D fetcher.method.latest_revision(fetch=
er, d, 'default')
> > +            rev_parse_result =3D bb.process.run('git -C {} rev-parse H=
EAD'.format(os.path.join(layerdir, repodir)))
> > +            local_revision =3D rev_parse_result[0].strip()
> > +            if upstream_revision !=3D local_revision:
> > +                changed =3D True
> > +                print('Layer repository {} checked out into {} updated=
 revision {} from {} to {}'.format(remotes[remote]["uri"], os.path.join(lay=
erdir, repodir), rev, local_revision, upstream_revision))
> > +
> > +    return changed
> > +
> > +def build_status(args, d, update=3DFalse):
> > +    topbuilddir =3D args.build_dir
> > +
> > +    confdir =3D os.path.join(topbuilddir, "config")
> > +    layerdir =3D os.path.join(topbuilddir, "layers")
> > +
> > +    upstream_config =3D json.load(open(os.path.join(topbuilddir, "conf=
ig-upstream.json")))
> > +
> > +    with tempfile.TemporaryDirectory(dir=3Dtopbuilddir, prefix=3D'conf=
ig-tmp-') as tmpdirname:
> > +        current_config_path =3D obtain_config(upstream_config, tmpdirn=
ame, args, d)
> > +
> > +        build_config_path =3D os.path.join(confdir, os.path.basename(c=
urrent_config_path))
> > +        config_diff =3D get_diff(build_config_path, current_config_pat=
h)
> > +        if config_diff:
> > +            print('Top level configuration in {} has changed:\n{}'.for=
mat(topbuilddir, config_diff))
> > +            if update:
> > +                update_build_config(current_config_path, confdir, topb=
uilddir, layerdir, d)
> > +            return
> > +
> > +    if are_layers_changed(json.load(open(build_config_path))["sources"=
], layerdir, d):
> > +        if update:
> > +            update_build_config(build_config_path, confdir, topbuilddi=
r, layerdir, d, update_layers_only=3DTrue)
> > +        return
> > +
> > +    print("Configuration in {} has not changed.".format(topbuilddir))
> > +
> > +def build_update(args, d):
> > +    build_status(args, d, update=3DTrue)
> > +
> > +def do_fetch(fetcher, dir):
> > +    # git fetcher simply dumps git output to stdout; in bitbake contex=
t that is redirected to temp/log.do_fetch
> > +    # and we need to set up smth similar here
> > +    fetchlogdir =3D os.path.join(dir, 'logs')
> > +    os.makedirs(fetchlogdir, exist_ok=3DTrue)
> > +    fetchlog =3D os.path.join(fetchlogdir, 'fetch_log.{}'.format(datet=
ime.datetime.now().strftime("%Y%m%d%H%M%S")))
> > +    with open(fetchlog, 'a') as f:
> > +        oldstdout =3D sys.stdout
> > +        sys.stdout =3D f
> > +        fetcher.download()
> > +        fetcher.unpack(dir)
> > +        sys.stdout =3D oldstdout
> > +
> > +def update_registry(registry, cachedir, d):
> > +    registrydir =3D 'configurations'
> > +    full_registrydir =3D os.path.join(cachedir, registrydir)
> > +    print("Fetching configuration repository {} into {}".format(regist=
ry, full_registrydir))
> > +    fetcher =3D bb.fetch.Fetch(["{};destsuffix=3D{}".format(registry, =
registrydir)], d)
> > +    do_fetch(fetcher, cachedir)
> > +    return full_registrydir
> > +
> > +def list_registry(registry_path):
> > +    print("\nAvailable configurations:")
> > +    for root, dirs, files in os.walk(registry_path):
> > +        for f in files:
> > +            if f.endswith('.conf.json'):
> > +                config_name =3D get_config_name(f)
> > +                config_desc =3D json.load(open(os.path.join(root, f)))=
["description"]
> > +                print("{}\t{}".format(config_name, config_desc))
> > +
> > +def list_configs(args, d):
> > +    registry_path =3D update_registry(args.registry, args.cache_dir, d=
)
> > +    list_registry(registry_path)
> > +
> > +def default_tool_config_path():
> > +    return os.environ.get('BITBAKE_SETUP_CONFIG') or os.path.join(os.p=
ath.expanduser('~'), '.bitbake-setup', 'config')
> > +
> > +def write_tool_config(force_overwrite):
> > +    config_path =3D default_tool_config_path()
> > +    if not os.path.exists(config_path) or force_overwrite:
> > +        config =3D configparser.ConfigParser()
> > +        config['default'] =3D {'registry':'git://github.com/kanavin/bi=
tbake-setup-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain',
> > +                             'cache-dir':os.path.join(os.path.expandus=
er('~'), '.bitbake-setup'),
> > +                             'build-dir-prefix':os.path.join(os.path.e=
xpanduser('~'), 'builds')}
> > +        os.makedirs(os.path.dirname(config_path), exist_ok=3DTrue)
> > +        with open(config_path, 'w') as configfile:
> > +            config.write(configfile)
> > +
> > +def load_tool_config():
> > +    # This creates a new config file if it does not yet exist
> > +    write_tool_config(force_overwrite=3DFalse)
> > +
> > +    config_path =3D default_tool_config_path()
> > +    config =3D configparser.ConfigParser()
> > +    print('Default parameter values are in {} - adjust as needed.\n'.f=
ormat(config_path))
> > +    config.read([config_path])
> > +    return config
> > +
> > +def get_build_dir():
> > +    bbpath =3D os.environ.get('BBPATH')
> > +    if bbpath:
> > +        build_dir =3D os.path.dirname(bbpath.split(':')[0])
> > +        if os.path.exists(os.path.join(build_dir,'config-upstream.json=
')):
> > +            return build_dir
> > +    return None
> > +
> > +def main():
> > +    config =3D load_tool_config()
> > +
> > +    parser =3D argparse.ArgumentParser(
> > +        description=3D"BitBake setup utility",
> > +        epilog=3D"Use %(prog)s <subcommand> --help to get help on a sp=
ecific command"
> > +        )
> > +    parser.add_argument('-d', '--debug', help=3D'Enable debug output',=
 action=3D'store_true')
> > +    parser.add_argument('-q', '--quiet', help=3D'Print only errors', a=
ction=3D'store_true')
> > +    parser.add_argument('--color', choices=3D['auto', 'always', 'never=
'], default=3D'auto', help=3D'Colorize output (where %(metavar)s is %(choic=
es)s)', metavar=3D'COLOR')
> > +    parser.add_argument('--registry', default=3Dconfig['default']['reg=
istry'], help=3D'Git repository with configuration files (in bitbake SRC_UR=
I format), default is %(default)s')
> > +    parser.add_argument('--cache-dir', default=3Dconfig['default']['ca=
che-dir'], help=3D'Directory where downloaded configurations and layers are=
 cached for reproducibility and offline builds, default is %(default)s')
> > +    parser.add_argument('--no-network', action=3D'store_true', help=3D=
'Do not check whether configuration repositories and layer repositories hav=
e been updated; use only the local cache.')
> > +
> > +    subparsers =3D parser.add_subparsers()
> > +
> > +    parser_init =3D subparsers.add_parser('init', help=3D'Initialize a=
 build from a configuration')
> > +    parser_init.add_argument('config', help=3D"path/URL/id to a config=
uration file, use 'list' command to get available ids")
> > +    parser_init.add_argument('--build-dir-prefix', help=3D"Directory p=
refix under which the build directory should be created and initialized, de=
fault is %(default)s", default=3Dconfig['default']['build-dir-prefix'])
> > +    parser_init.set_defaults(func=3Dinit_config)
> > +
> > +    build_dir =3D get_build_dir()
> > +
> > +    parser_status =3D subparsers.add_parser('status', help=3D'Check if=
 the build needs to be synchronized with configuration')
> > +    if build_dir:
> > +        parser_status.add_argument('--build-dir', default=3Dbuild_dir,=
 help=3D"Path to the build, default is %(default)s via BBPATH")
> > +    else:
> > +        parser_status.add_argument('--build-dir', required=3DTrue, hel=
p=3D"Path to the build")
> > +    parser_status.set_defaults(func=3Dbuild_status)
> > +
> > +    parser_update =3D subparsers.add_parser('update', help=3D'Update a=
 build to be in sync with configuration')
> > +    if build_dir:
> > +        parser_update.add_argument('--build-dir', default=3Dbuild_dir,=
 help=3D"Path to the build, default is %(default)s via BBPATH")
> > +    else:
> > +        parser_update.add_argument('--build-dir', required=3DTrue, hel=
p=3D"Path to the build")
> > +    parser_update.set_defaults(func=3Dbuild_update)
> > +
> > +    parser_list =3D subparsers.add_parser('list', help=3D'List availab=
le configurations')
> > +    parser_list.set_defaults(func=3Dlist_configs)
> > +
> > +    args =3D parser.parse_args()
> > +
> > +    logging.basicConfig(stream=3Dsys.stdout)
> > +    if args.debug:
> > +        logger.setLevel(logging.DEBUG)
> > +    elif args.quiet:
> > +        logger.setLevel(logging.ERROR)
> > +
> > +    # Need to re-run logger_create with color argument
> > +    # (will be the same logger since it has the same name)
> > +    bb.msg.logger_create('bitbake-setup', output=3Dsys.stdout,
> > +                         color=3Dargs.color,
> > +                         level=3Dlogger.getEffectiveLevel())
> > +
> > +    d =3D init_bb_cache(args)
> > +    if 'func' in args:
> > +        args.func(args, d)
> > +    else:
> > +        from argparse import Namespace
> > +        parser.print_help()
> > +
> > +main()
> > --
> > 2.39.5
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#17033): https://lists.openembedded.org/g/bitbake-de=
vel/message/17033
> > Mute This Topic: https://lists.openembedded.org/mt/110666120/3617156
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [mart=
in.jansa@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >

