Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43690CA0EE6
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 21:54:16 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web11.5945.1755640453038836858
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Aug 2025 14:54:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Sr/X3XWe;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: ticotimo@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-333f8d3be05so40413081fa.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 14:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755640451; x=1756245251; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vEyoKYDWLbO4r+7sdJsGn1udn01fm9V7K9rGlIuVeTM=;
        b=Sr/X3XWes73d5t6f1vXzOBryNFSHpTEgqJbUrGpkjIs+VENdAo0gaXgDsntRMrdjoi
         gMnCFfzqpHVWVucbnqhRBYDfo7sNT+nymYsxGaLGQEMuZ+OjuoB4nJG1RLUfKhFNGoc8
         cHD+dh4g+MxBQzL5PhKnXootqL1m+IeXx5bzJywJwbGa6nC3j/uhIrQw1Q8NfejK/vOd
         A22MnHjt5E4rX0AVOY+silSMZj2vnIZw4r1LwrW3qFBIRbjkLNE9hQWzox+qXfvnmfxm
         eLhYmhwleULN/zZQIOp6hRqGgI7nnO0xTKP1S00/uXi+/MDVocKqdVPNUAZHFmh6mkFC
         qr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640451; x=1756245251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEyoKYDWLbO4r+7sdJsGn1udn01fm9V7K9rGlIuVeTM=;
        b=jQ0Ro8oN3eAA5dAHP9tvJMt3Lj6FeQgfqSN1RBpkGnecsZqYaLZLGIpzCr9I2Rng0Y
         XaquTVPBpx9Lf1qzS3LdKUxNluhgtLmNAfTbL5E/2ur0CYax0Z//uUbUOTTfHgzeC1zX
         TeDE1U5eDwjJbD/ZPhxrrKauKRznJQ6KWvghd6Y79wmqgKP/eRnlTCUSFVeAv+30k4Jk
         60bsVom02qlz+ZIww4PwUNS604k82e89a4Cqihe918hs81tIM1EpFJ9Q4NmVsCc28FKJ
         v9WA9C1NfaRINUNE68aFuNUB4LhTjr+g3CFQm8s1/v0a1roaQxTRVHvQC2bmT4IltO0l
         SXHg==
X-Gm-Message-State: AOJu0YwUxRon3bK1R2ALOvdeS9LJCqzy64i1DuDytMekiPmFoAnPW4OP
	nYkUKD85oyiZJGruxazQwBb8+WUU60POR8XbzhsijvXLfHhk8wak3G3Z/YIniFZkaYPfQ6vUikJ
	+ehRun8xUosKR1Dq08IRKwFjfhaZwX48=
X-Gm-Gg: ASbGnctr2fL7s10PFfBP+k03MBz/cLGpKJ3ckXkAU//TJ4L1nKtTxLpERqq+yFlXniY
	uR0eziwjEjXgOkIU94ub2VHe0Z0XHN6aMiWWhxvIuzc/6MgjtXALInb+7NVhfknMvlmh1OsGekj
	/GYv3m8o9nbvEzYYl3FuUq3OH4LbTYBdSiFgFuXLZqywk4nwLD0AF56l+3rsESHuoLEPAOIM4o9
	Dt7v2A=
X-Google-Smtp-Source: AGHT+IG6P2sNTM6COWWZo3Ylmvnp+ZG10ii9UsnFDkMQmYWrtwL2qUh9mh5KvvqUpm6Z7eZTO4NVB8zIRERtm0tzzTM=
X-Received: by 2002:a05:651c:1107:20b0:32a:888e:b30f with SMTP id
 38308e7fff4ca-3353bc27057mr1178551fa.6.1755640450576; Tue, 19 Aug 2025
 14:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250813151523.1855287-1-alex.kanavin@gmail.com>
In-Reply-To: <20250813151523.1855287-1-alex.kanavin@gmail.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Tue, 19 Aug 2025 14:53:58 -0700
X-Gm-Features: Ac12FXzDA0Z1uavzdRnAvyLBvAJiKcWKby94xOdcST0QJpayvTpe9gTxDsrztzg
Message-ID: <CANx9H-CviD0ojn2YKbLOv+u7jsuwqgNmNSDgM2HzC+2eukfoOA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/3] bitbake-setup: add the initial implementation
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="00000000000068f577063cbee524"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 21:54:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17891

--00000000000068f577063cbee524
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I agree with Richard. This is really shaping up nicely. And I want to
really thank you for all the effort and iterations to get to where we are
today.

I took the liberty of documenting how I currently use/see bitbake-setup:
https://lists.yoctoproject.org/g/docs/message/7457

One of the things I came across is that build/conf/context-notes.txt is
empty. This means when the user runs init-build-env they don't get the
usual descriptive prompt. This can obviously be improved in another
iteration.

I resisted documenting both "yocto-master-nested-configs" and
"yocto-master-options". I started with "yocto-master-nested-configs", which
is "cleaner" or "simpler" to some extent and instead went with
"yocto-master-options" which feels like it makes decisions the user expects
(choosing a MACHINE and a DISTRO). I'm still on the fence about that.

I've tried to resist adding new features and so on to allow you to do the
initial development with your initial target audience. Maintainers are not
the initial target audience, for instance. In my first attempt at
documentation, I tried (like you intended) to address the "new to Yocto"
audience and not experts.

I hope that my initial attempt at documentation isn't too far off from
being useful. Clearly another section explaining more about the way
config-upstream.json works and other aspects such as bitbake-setup.conf is
needed, but I wanted to address just the "how do I use this?" basics. My
goal was to actually get folks to try it.

Cheers,
Tim

On Wed, Aug 13, 2025 at 8:15=E2=80=AFAM Alexander Kanavin via lists.openemb=
edded.org
<alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:

> From: Alexander Kanavin <alex@linutronix.de>
>
> Preamble
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> The latest iteration of this patchset is available at
> https://github.com/kanavin/bitbake
> I recommend taking the patches from there to ensure that
> you are not trying out outdated code.
>
> For the rationale and design guidelines please see this message:
> https://lists.openembedded.org/g/openembedded-architecture/message/1913
>
> Left out for now but will be done later:
>
> - handling site-specific settings. There was a discussion about it:
>
> =3D=3D=3D=3D=3D
> > Finally, a question, how do you recommend to handle my local
> SSTATE_DIR/DL_DIR?
> > Setup with bbsetup, copy a site.conf with these config inside the build=
,
> then
> > the proper build? ... or is there a better way?
>
> This is an unresolved question. I'm open to proposals. Or code.
>
> I guess it will be something like 'bitbake-setup change-setting
> default site-conf /path/to/site.conf', and then bitbake-setup will add
> that to every build that is initialized. Site.conf need not list site
> settings directly, it too can add a fragment maintained in a layer.
> That way CI settings can be specified and maintained in a layer, but
> they don't need to be added to a json config, as that would impose
> them on everyone using that config to reproduce builds locally.
> =3D=3D=3D=3D=3D
>
> - official configuration repository
>
> - documentation
>
> Amble *scratch* HOWTO
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1. If you don't know where to start, run 'bitbake-setup init'.
>
> Bitbake-setup will ask a few questions about available configuration
> choices and set up a build:
>
> =3D=3D=3D
> alex@alex-lx-laptop:~$ development/bitbake/bin/bitbake-setup init
> Created a new settings file in
> /home/alex/bitbake-builds/bitbake-setup.conf.
>
> Loading settings from /home/alex/bitbake-builds/bitbake-setup.conf
>
> Fetching configuration registry git://
> github.com/kanavin/bitbake-setup-configurations.git;protocol=3Dhttps;bran=
ch=3Dmain;rev=3Dmain
> into /home/alex/bitbake-builds/.bitbake-setup-cache/configurations
>
> Available configurations:
> 0. yocto-master-nested-configs  (future) Official Yocto configurations:
> poky, poky-altcfg, poky-tiny, for qemux86-64 and arm64 (defined with nest=
ed
> configurations)
> 1. yocto-master-options (future) Official Yocto configurations: poky,
> poky-altcfg, poky-tiny, for qemux86-64, riscv64 and arm64 (defined with
> options)
>
> Please select one of the above configurations by its number:
> 1
> Selecting the only available bitbake configuration poky
> Available target machines:
> 0. machine/qemux86-64
> 1. machine/qemuarm64
> 2. machine/qemuriscv64
> Please select one of the above options by its number:
> 0
> Available distributions:
> 0. distro/poky
> 1. distro/poky-altcfg
> 2. distro/poky-tiny
> Please select one of the above options by its number:
> 0
> Run 'bitbake-setup yocto-master-options poky distro/poky
> machine/qemux86-64' to select this configuration non-interactively.
> Initializing a build in
> /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_q=
emux86-64
> Fetching layer/tool repository bitbake into
> /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_q=
emux86-64/layers/bitbake
> Fetching layer/tool repository openembedded-core into
> /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_q=
emux86-64/layers/openembedded-core
> Fetching layer/tool repository meta-yocto into
> /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_q=
emux86-64/layers/meta-yocto
> Fetching layer/tool repository yocto-docs into
> /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_q=
emux86-64/layers/yocto-docs
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> Setting up bitbake configuration in
> /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_q=
emux86-64/build
> This bitbake configuration provides: Poky reference distro build
> Usage instructions and additional information are in
> /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_q=
emux86-64/build/README
> =3D=3D=3D
>
> Note: 'init' sub-command can also take a path or a URL with a
> configuration file directly.
> You can see how those files look like here:
> https://github.com/kanavin/bitbake-setup-configurations
>
> 2. You can then source the bitbake environment and run bitbake to perform
> builds as usual:
>
> alex@alex-lx-laptop:~$ .
> /home/alex/bitbake-builds/yocto-master-options-poky-distro_poky-machine_q=
emux86-64/build/init-build-env
>
> Also, subsequent status/update commands will not require a separate
> --build-dir argument telling
> bitbake-setup where the build is.
>
> 3. To check if the build configuration needs to be updated, run:
> =3D=3D=3D
> alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup status
> Loading settings from /home/alex/bitbake-builds/bitbake-setup.conf.
>
> Fetching configuration registry git://
> github.com/kanavin/bitbake-setup-configurations.git;protocol=3Dhttps;bran=
ch=3Dmain;rev=3Dmain
> into /home/alex/bitbake-builds/.bitbake-setup-cache/configurations
> Configuration in /home/alex/bitbake-builds/poky-alex/ has not changed.
> =3D=3D=3D
>
> If the configuration has changed, you will see the difference:
> =3D=3D=3D
> ...
> Configuration in /home/alex/builds/poky-alex has changed:
> --- /home/alex/builds/poky-alex/config/poky-alex.conf.json      2024-12-1=
6
> 11:43:24.077446096 +0100
> +++ /home/alex/builds/poky-alex/config-tmp-asoubw5u/poky-alex.conf.json
> 2024-12-16 11:47:43.237104405 +0100
> @@ -7,7 +7,7 @@
>                          "uri": "git://git.yoctoproject.org/poky-contrib"
>                      }
>                  },
> -                "rev": "akanavin/sstate-for-all"
> +                "rev": "akanavin/bitbake-setup-testing"
>              },
>              "path": "poky"
>          }
> =3D=3D=3D
>
> If the configuration has not changed, but layer revisions referred to it
> have (for example
> if the configuration specifies a tip of a branch), you will see that too:
> =3D=3D=3D
> ...
> Layer repository git://git.yoctoproject.org/poky-contrib checked out into
> /home/alex/builds/poky-alex/layers/poky updated revision
> akanavin/sstate-for-all from 6b842ba55f996b27c900e3de78ceac8cb3b1c492 to
> aeb73e29379fe6007a8adc8d94c1ac18a93e68de
> =3D=3D=3D
>
> 4. If the configuration has changed, you can bring it in sync with:
> =3D=3D=3D
> alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup update
> Default parameter values are in /home/alex/.bitbake-setup/config - adjust
> as needed.
>
> Fetching configuration repository git://
> github.com/kanavin/bitbake-setup-configurations.git;protocol=3Dhttps;bran=
ch=3Dmain;rev=3Dmain
> into /home/alex/.bitbake-setup/configurations
> Layer repository git://git.yoctoproject.org/poky-contrib checked out into
> /home/alex/builds/poky-alex/layers/poky updated revision
> akanavin/bitbake-setup-testing from
> d174acad934f8ad1fe303abc5705733e15542859 to
> a3d2ee10045f8c1151d680ad97994c5d6cf51ece
> Fetching layer/tool repository poky into
> /home/alex/builds/poky-alex/layers/poky
>
> Setting up bitbake configuration gadget in
> /home/alex/bitbake-builds/poky-alex/build-gadget
> Existing bitbake congfiguration directory renamed to
> /home/alex/builds/poky-alex/build-gadget/conf-backup.20241216115007
> The bitbake configuration has changed:
> diff -uNr
> /home/alex/builds/poky-alex/build-gadget/conf-backup.20241216115007/local=
.conf
> /home/alex/builds/poky-alex/build-gadget/conf/local.conf
> ---
> /home/alex/builds/poky-alex/build-gadget/conf-backup.20241216115007/local=
.conf
>     2024-12-16 11:47:51.865043102 +0100
> +++ /home/alex/builds/poky-alex/build-gadget/conf/local.conf    2024-12-1=
6
> 11:50:07.811942847 +0100
> @@ -287,5 +287,3 @@
>  # track the version of this file when it was generated. This can safely
> be ignored if
>  # this doesn't mean anything to you.
>  CONF_VERSION =3D "2"
> -
> -TCLIBC =3D "musl"
>
> Bitbake configuration summary: This configuration is intended for buildin=
g
> gadget.
> Usage instructions and additional information in
> /home/alex/bitbake-builds/poky-alex/build-gadget/README
> =3D=3D=3D
>
> Note that it will also rename/preserve the existing build/conf directory,
> and print changes
> in bitbake configuration (diff of content of build/conf/) if that has
> changed. I can't
> at the moment think of anything more clever that is also not much more
> brittle or complex
> to implement, but open to suggestions.
>
> Terminology
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - 'top directory' means the place under which bitbake-setup reads and
> writes everything. bitbake-setup makes a promise to not touch anything
> outside of
> that, unless otherwise directed to by entries in settings (currently
> there is one such setting for fetcher downloads for layers and config
> registries). Top directory can be selected by an environment variable, a
> command line option,
> or otherwise assumed to be ~/bitbake-builds/. If BBPATH is in environment
> (e.g. we are in a bitbake environment), then the top directory is
> deduced from that and doesn't need to be specified by hand.
>
> - 'settings' means bitbake-setup operational parameters that are
> global to all builds under a top directory. E.g. the location of
> configuration registry, or where the bitbake fetcher should place the
> downloads (DL_DIR setting). Settings are stored in a .conf file in ini
> format just under the top directory.
>
> - 'build' means a tree structure set up by 'bitbake-setup init',
> consisting of, at least, a layers checkout, and a bitbake
> build. It maps 1:1 to the json data it was constructed from, which is
> called 'build configuration'. Build configurations are constructed from
> generic configurations that may involve making one or more choices
> about available options in them. Generic configurations are files, URLs
> or are obtained from git repositories called 'config
> registries', in which case they can be listed with 'bitbake-setup
> list'. There can be multiple 'builds' under a top directory. Here are
> two example generic configurations that showcase this:
>
> https://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-m=
aster-options.conf.json
>
> https://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-m=
aster-nested-configs.conf.json
>
> - 'bitbake-setup status' will tell if a build is in sync with
> the generic configuration it was made from. 'bitbake-setup update' will
> bring a build
> in sync with a configuration if needed.
>
> - 'bitbake build' means a particular sub-tree inside a build that
> bitbake itself operates on, e.g. what is set in BBPATH/BUILDDIR
> by oe-init-build-env. conf/* in that tree is 'bitbake configuration'.
> Bitbake configurations are constructed from templates and fragments,
> with existing mechanisms provided by oe-core. The configuration file
> format is specified such that other mechanisms to set up a
> bitbake build can be added; there was a mention of ability to specify
> local.conf content and a set of layers directly in a configuration. I
> think that scales poorly compared to templates and fragments, but I
> made sure alternative ways to configure a bitbake build are possible
> to add in the future :)
>
> - 'source override' is a json file that can be used to modify revisions
> and origins of layers that need to be checkout into a build (e.g.
> when master branches need to be changed to master-next for purposes
> of testing). Such a file is specified with a command-line option to 'init=
'
> and an example can be seen here:
>
> https://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-m=
aster-next.override.json
>
> This commit includes a fix by Ryan Eatmon <reatmon@ti.com>:
> https://github.com/kanavin/bitbake/pull/1
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>  bin/bitbake-setup | 673 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 673 insertions(+)
>  create mode 100755 bin/bitbake-setup
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> new file mode 100755
> index 000000000..11569e67d
> --- /dev/null
> +++ b/bin/bitbake-setup
> @@ -0,0 +1,673 @@
> +#!/usr/bin/env python3
> +
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +import logging
> +import os
> +import sys
> +import argparse
> +import warnings
> +import json
> +import shutil
> +import time
> +import stat
> +import tempfile
> +import configparser
> +import datetime
> +
> +default_registry =3D 'git://
> github.com/kanavin/bitbake-setup-configurations.git;protocol=3Dhttps;bran=
ch=3Dmain;rev=3Dmain
> '
> +
> +bindir =3D os.path.abspath(os.path.dirname(__file__))
> +sys.path[0:0] =3D [os.path.join(os.path.dirname(bindir), 'lib')]
> +
> +import bb.msg
> +import bb.process
> +
> +logger =3D bb.msg.logger_create('bitbake-setup', sys.stdout)
> +
> +def cache_dir(top_dir):
> +    return os.path.join(top_dir, '.bitbake-setup-cache')
> +
> +def init_bb_cache(settings, args):
> +    dldir =3D settings["default"]["dl-dir"]
> +    bb_cachedir =3D os.path.join(cache_dir(args.top_dir), 'bitbake-cache=
')
> +
> +    d =3D bb.data.init()
> +    d.setVar("DL_DIR", dldir)
> +    d.setVar("BB_CACHEDIR", bb_cachedir)
> +    d.setVar("__BBSRCREV_SEEN", "1")
> +    if args.no_network:
> +        d.setVar("BB_SRCREV_POLICY", "cache")
> +    bb.fetch.fetcher_init(d)
> +    return d
> +
> +def save_bb_cache():
> +    bb.fetch2.fetcher_parse_save()
> +    bb.fetch2.fetcher_parse_done()
> +
> +def get_config_name(config):
> +    return os.path.basename(config).split('.')[0]
> +
> +def write_config(config, config_dir):
> +    with open(os.path.join(config_dir, "config-upstream.json"),'w') as s=
:
> +        json.dump(config, s, sort_keys=3DTrue, indent=3D4)
> +
> +def commit_config(config_dir):
> +    bb.process.run("git -C {} add .".format(config_dir))
> +    bb.process.run("git -C {} commit -a -m 'Configuration at
> {}'".format(config_dir, time.asctime()))
> +
> +def _write_layer_list(dest, repodirs):
> +    layers =3D []
> +    for r in repodirs:
> +        for root, dirs, files in os.walk(os.path.join(dest,r)):
> +            if os.path.basename(root) =3D=3D 'conf' and 'layer.conf' in =
files:
> +                layers.append(os.path.relpath(os.path.dirname(root),
> dest))
> +    layers_f =3D os.path.join(dest, ".oe-layers.json")
> +    with open(layers_f, 'w') as f:
> +        json.dump({"version":"1.0","layers":layers}, f, sort_keys=3DTrue=
,
> indent=3D4)
> +
> +def checkout_layers(layers, layerdir, d):
> +    repodirs =3D []
> +    oesetupbuild =3D None
> +    for r_name in layers:
> +        r_data =3D layers[r_name]
> +        repodir =3D r_data["path"]
> +        repodirs.append(repodir)
> +
> +        r_remote =3D r_data['git-remote']
> +        rev =3D r_remote['rev']
> +        remotes =3D r_remote['remotes']
> +
> +        for remote in remotes:
> +            type,host,path,user,pswd,params =3D
> bb.fetch.decodeurl(remotes[remote]["uri"])
> +            fetchuri =3D
> bb.fetch.encodeurl(('git',host,path,user,pswd,params))
> +            print("Fetching layer/tool repository {} into
> {}".format(r_name, os.path.join(layerdir,repodir)))
> +            fetcher =3D
> bb.fetch.Fetch(["{};protocol=3D{};rev=3D{};nobranch=3D1;destsuffix=3D{}".=
format(fetchuri,type,rev,repodir)],
> d)
> +            do_fetch(fetcher, layerdir)
> +
> +        if os.path.exists(os.path.join(layerdir, repodir,
> 'scripts/oe-setup-build')):
> +            oesetupbuild =3D os.path.join(layerdir, repodir,
> 'scripts/oe-setup-build')
> +            oeinitbuildenv =3D os.path.join(layerdir, repodir,
> 'oe-init-build-env')
> +
> +    _write_layer_list(layerdir, repodirs)
> +
> +    if oesetupbuild:
> +        links =3D {'setup-build': oesetupbuild, 'oe-scripts':
> os.path.dirname(oesetupbuild), 'init-build-env': oeinitbuildenv}
> +        for l,t in links.items():
> +            symlink =3D os.path.join(layerdir, l)
> +            if os.path.lexists(symlink):
> +                os.remove(symlink)
> +            os.symlink(os.path.relpath(t,layerdir),symlink)
> +
> +def setup_bitbake_build(bitbake_config, layerdir, builddir):
> +    def _setup_build_conf(layers, build_conf_dir):
> +        os.makedirs(build_conf_dir)
> +        layers_s =3D "\n".join(["  {} \\".format(os.path.join(layerdir,l=
))
> for l in layers])
> +        bblayers_conf =3D """BBLAYERS ?=3D " \
> +{}
> +  "
> +""".format(layers_s)
> +        with open(os.path.join(build_conf_dir, "bblayers.conf"), 'w') as
> f:
> +            f.write(bblayers_conf)
> +
> +        local_conf =3D """#
> +# This file is intended for local configuration tweaks.
> +#
> +# If you would like to publish and share changes made to this file,
> +# it is recommended to put them into a distro config, or to create
> +# layer fragments from changes made here.
> +#
> +"""
> +        with open(os.path.join(build_conf_dir, "local.conf"), 'w') as f:
> +            f.write(local_conf)
> +
> +        with open(os.path.join(build_conf_dir, "templateconf.cfg"), 'w')
> as f:
> +            f.write("")
> +
> +        with open(os.path.join(build_conf_dir, "conf-summary.txt"), 'w')
> as f:
> +            f.write(bitbake_config["description"] + "\n")
> +
> +        with open(os.path.join(build_conf_dir, "conf-notes.txt"), 'w') a=
s
> f:
> +            f.write("")
> +
> +    def _make_init_build_env(builddir, initbuildenv):
> +        cmd =3D ". {} {}".format(initbuildenv, builddir)
> +        initbuild_in_builddir =3D os.path.join(builddir, 'init-build-env=
')
> +        with open(initbuild_in_builddir, 'w') as f:
> +            f.write(cmd)
> +
> +    bitbake_builddir =3D os.path.join(builddir, "build")
> +    print("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D")
> +    print("Setting up bitbake configuration in
> {}".format(bitbake_builddir))
> +
> +    template =3D bitbake_config.get("oe-template")
> +    layers =3D bitbake_config.get("bb-layers")
> +    if not template and not layers:
> +        print("Bitbake configuration does not contain a reference to an
> OpenEmbedded build template via 'oe-template' or a list of layers via
> 'bb-layers'; please use oe-setup-build, oe-init-build-env or another
> mechanism manually to complete the setup.")
> +        return
> +    oesetupbuild =3D os.path.join(layerdir, 'setup-build')
> +    if template and not os.path.exists(oesetupbuild):
> +        raise Exception("Cannot complete setting up a bitbake build
> directory from OpenEmbedded template '{}' as oe-setup-build was not found
> in any layers; please use oe-init-build-env manually.".format(template))
> +
> +    bitbake_confdir =3D os.path.join(bitbake_builddir, 'conf')
> +    backup_bitbake_confdir =3D bitbake_confdir +
> "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
> +    if os.path.exists(bitbake_confdir):
> +        os.rename(bitbake_confdir, backup_bitbake_confdir)
> +
> +    if layers:
> +        _setup_build_conf(layers, bitbake_confdir)
> +
> +    if template:
> +        bb.process.run("{} setup -c {} -b {}
> --no-shell".format(oesetupbuild, template, bitbake_builddir))
> +    else:
> +        initbuildenv =3D os.path.join(layerdir, 'init-build-env')
> +        if not os.path.exists(initbuildenv):
> +            print("Could not find oe-init-build-env in any of the layers=
;
> please use another mechanism to initialize the bitbake environment")
> +            return
> +        _make_init_build_env(bitbake_builddir,
> os.path.realpath(initbuildenv))
> +
> +    init_script =3D os.path.join(bitbake_builddir, "init-build-env")
> +    shell =3D os.path.basename(os.environ.get("SHELL","bash"))
> +    fragments =3D bitbake_config.get("oe-fragments", []) +
> sorted(bitbake_config.get("oe-fragment-choices",{}).values())
> +    if fragments:
> +        bb.process.run("{} -c '. {} && bitbake-config-build
> enable-fragment {}'".format(shell, init_script, " ".join(fragments)))
> +
> +    if os.path.exists(backup_bitbake_confdir):
> +        bitbake_config_diff =3D get_diff(backup_bitbake_confdir,
> bitbake_confdir)
> +        if bitbake_config_diff:
> +            print("Existing bitbake configuration directory renamed to
> {}".format(backup_bitbake_confdir))
> +            print("The bitbake configuration has changed:")
> +            print(bitbake_config_diff)
> +        else:
> +            shutil.rmtree(backup_bitbake_confdir)
> +
> +    print("This bitbake configuration provides:
> {}".format(bitbake_config["description"]))
> +
> +    readme =3D """{}\n\nAdditional information is in {} and {}\n
> +Source the environment using '. {}' to run builds from the command line.
> +The bitbake configuration files (local.conf, bblayers.conf and more) can
> be found in {}/conf
> +""".format(
> +        bitbake_config["description"],
> +        os.path.join(bitbake_builddir,'conf/conf-summary.txt'),
> +        os.path.join(bitbake_builddir,'conf/conf-notes.txt'),
> +        init_script,
> +        bitbake_builddir
> +        )
> +    readme_file =3D os.path.join(bitbake_builddir, "README")
> +    with open(readme_file, 'w') as f:
> +        f.write(readme)
> +    print("Usage instructions and additional information are in
> {}".format(readme_file))
> +
> +def get_registry_config(registry_path, id):
> +    for root, dirs, files in os.walk(registry_path):
> +        for f in files:
> +            if f.endswith('.conf.json') and id =3D=3D get_config_name(f)=
:
> +                return os.path.join(root, f)
> +    raise Exception("Unable to find {} in available configurations; use
> 'list' sub-command to see what is available".format(id))
> +
> +def update_build(config, confdir, builddir, layerdir, d):
> +    layer_config =3D config["data"]["sources"]
> +    layer_overrides =3D config["source-overrides"]["sources"]
> +    for k,v in layer_overrides.items():
> +        if k in layer_config:
> +            layer_config[k]["git-remote"] =3D v["git-remote"]
> +    checkout_layers(layer_config, layerdir, d)
> +    bitbake_config =3D config["bitbake-config"]
> +    setup_bitbake_build(bitbake_config, layerdir, builddir)
> +
> +def flatten_bitbake_configs(configs):
> +    def merge_configs(c1,c2):
> +        c_merged =3D {}
> +        for k,v in c2.items():
> +            if k not in c1.keys():
> +                c_merged[k] =3D v
> +        for k,v in c1.items():
> +            if k not in c2.keys():
> +                c_merged[k] =3D v
> +            else:
> +               c_merged[k] =3D c1[k] + c2[k]
> +        del c_merged['configurations']
> +        return c_merged
> +
> +    flattened_configs =3D []
> +    for c in configs:
> +        if 'configurations' not in c:
> +            flattened_configs.append(c)
> +        else:
> +            for sub_c in flatten_bitbake_configs(c['configurations']):
> +                flattened_configs.append(merge_configs(c, sub_c))
> +    return flattened_configs
> +
> +def choose_bitbake_config(configs, parameters, non_interactive):
> +    flattened_configs =3D flatten_bitbake_configs(configs)
> +    configs_dict =3D {i["name"]:i for i in flattened_configs}
> +
> +    if parameters:
> +        config_id =3D parameters[0]
> +        if config_id not in configs_dict:
> +            raise Exception("Bitbake configuration {} not found; replace
> with one of {}".format(config_id, configs_dict))
> +        return configs_dict[config_id]
> +
> +    enumerated_configs =3D list(enumerate(flattened_configs))
> +    if len(enumerated_configs) =3D=3D 1:
> +        only_config =3D flattened_configs[0]
> +        print("Selecting the only available bitbake configuration
> {}".format(only_config["name"]))
> +        return only_config
> +
> +    if non_interactive:
> +        raise Exception("Unable to choose from bitbake configurations in
> non-interactive mode: {}".format(configs_dict))
> +
> +    print("Available bitbake configurations:")
> +    for n, config_data in enumerated_configs:
> +        print("{}. {}\t{}".format(n, config_data["name"],
> config_data["description"]))
> +    print("\nPlease select one of the above bitbake configurations by it=
s
> number:")
> +    config_n =3D int(input())
> +    return flattened_configs[config_n]
> +
> +def choose_config(configs, non_interactive):
> +    not_expired_configs =3D [k for k in configs.keys() if not
> has_expired(configs[k].get("expires", None))]
> +    config_list =3D list(enumerate(not_expired_configs))
> +    if len(config_list) =3D=3D 1:
> +        only_config =3D config_list[0][1]
> +        print("Selecting the only available configuration
> {}".format(only_config))
> +        return only_config
> +
> +    if non_interactive:
> +        raise Exception("Unable to choose from configurations in
> non-interactive mode: {}".format(not_expired_configs))
> +
> +    print("\nAvailable configurations:")
> +    for n, config_name in config_list:
> +        config_data =3D configs[config_name]
> +        expiry_date =3D config_data.get("expires", None)
> +        config_desc =3D config_data["description"]
> +        if expiry_date:
> +           print("{}. {}\t{} (supported until {})".format(n, config_name=
,
> config_desc, expiry_date))
> +        else:
> +           print("{}. {}\t{}".format(n, config_name, config_desc))
> +    print("\nPlease select one of the above configurations by its
> number:")
> +    config_n =3D int(input())
> +    return config_list[config_n][1]
> +
> +def choose_fragments(possibilities, parameters, non_interactive):
> +    choices =3D {}
> +    for k,v in possibilities.items():
> +        choice =3D [o for o in v["options"] if o in parameters]
> +        if len(choice) > 1:
> +            raise Exception("Options specified on command line do not
> allow a single selection from possibilities {}, please remove one or more
> from {}".format(v["options"], parameters))
> +        if len(choice) =3D=3D 1:
> +            choices[k] =3D choice[0]
> +            continue
> +
> +        if non_interactive:
> +            raise Exception("Unable to choose from options in
> non-interactive mode: {}".format(v["options"]))
> +
> +        print(v["description"]+ ":")
> +        options_enumerated =3D list(enumerate(v["options"]))
> +        for n,o in options_enumerated:
> +            print("{}. {}".format(n, o))
> +        print("Please select one of the above options by its number:")
> +        option_n =3D int(input())
> +        choices[k] =3D options_enumerated[option_n][1]
> +    return choices
> +
> +def obtain_config(settings, args, source_overrides, d):
> +    if args.config:
> +        config_id =3D args.config[0]
> +        config_parameters =3D args.config[1:]
> +        if os.path.exists(config_id):
> +            print("Reading configuration from local file
> {}".format(config_id))
> +            upstream_config =3D
> {'type':'local','path':os.path.abspath(args.config),'name':get_config_nam=
e(config_id),'data':json.load(open(config_path))}
> +        elif config_id.startswith("http://") or
> config_id.startswith("https://"):
> +            print("Reading configuration from network URI
> {}".format(config_id))
> +            import urllib.request
> +            with urllib.request.urlopen(config_id) as f:
> +              upstream_config =3D
> {'type':'network','uri':config_id,'name':get_config_name(config_id),'data=
':json.load(f)}
> +        else:
> +            print("Looking up config {} in configuration
> registry".format(config_id))
> +            registry_path =3D
> update_registry(settings["default"]["registry"], cache_dir(args.top_dir),=
 d)
> +            registry_configs =3D list_registry(registry_path,
> with_expired=3DTrue)
> +            if config_id not in registry_configs:
> +                raise Exception("Config {} not found in configuration
> registry, re-run 'init' without parameters to choose from available
> configurations.".format(config_id))
> +            upstream_config =3D
> {'type':'registry','registry':settings["default"]["registry"],'name':conf=
ig_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
> +        expiry_date =3D upstream_config['data'].get("expires", None)
> +        if has_expired(expiry_date):
> +            print("This configuration is no longer supported after {}.
> Please consider changing to a supported configuration.".format(expiry_dat=
e))
> +    else:
> +        registry_path =3D update_registry(settings["default"]["registry"=
],
> cache_dir(args.top_dir), d)
> +        registry_configs =3D list_registry(registry_path, with_expired=
=3DTrue)
> +        config_id =3D choose_config(registry_configs, args.non_interacti=
ve)
> +        config_parameters =3D []
> +        upstream_config =3D
> {'type':'registry','registry':settings["default"]["registry"],'name':conf=
ig_id,'data':json.load(open(get_registry_config(registry_path,config_id)))}
> +
> +    upstream_config['bitbake-config'] =3D
> choose_bitbake_config(upstream_config['data']['bitbake-setup']['configura=
tions'],
> config_parameters, args.non_interactive)
> +    upstream_config['bitbake-config']['oe-fragment-choices'] =3D
> choose_fragments(upstream_config['bitbake-config'].get('oe-fragments-one-=
of',{}),
> config_parameters[1:], args.non_interactive)
> +    upstream_config['non-interactive-cmdline-options'] =3D "
> ".join([upstream_config['name'], upstream_config['bitbake-config']['name'=
]]
> + sorted(upstream_config['bitbake-config']['oe-fragment-choices'].values(=
)))
> +    upstream_config['source-overrides'] =3D source_overrides
> +    return upstream_config
> +
> +def init_config(settings, args, d):
> +    stdout =3D sys.stdout
> +    def handle_task_progress(event, d):
> +        rate =3D event.rate if event.rate else ''
> +        progress =3D event.progress if event.progress > 0 else 0
> +        print("{}% {}                ".format(progress, rate),
> file=3Dstdout, end=3D'\r')
> +
> +    source_overrides =3D json.load(open(args.source_overrides)) if
> args.source_overrides else {'sources':{}}
> +    upstream_config =3D obtain_config(settings, args, source_overrides, =
d)
> +    print("Run 'bitbake-setup {}' to select this configuration
> non-interactively.".format(upstream_config['non-interactive-cmdline-optio=
ns']))
> +
> +    builddir =3D os.path.join(os.path.abspath(args.top_dir),
> upstream_config['non-interactive-cmdline-options'].replace("
> ","-").replace("/","_"))
> +    if os.path.exists(builddir):
> +        print("Build already initialized in {}\nUse 'bitbake-setup
> status' to check if it needs to be updated or 'bitbake-setup update' to
> perform the update.".format(builddir))
> +        return
> +
> +    print("Initializing a build in {}".format(builddir))
> +
> +    os.makedirs(builddir)
> +
> +    confdir =3D os.path.join(builddir, "config")
> +    layerdir =3D os.path.join(builddir, "layers")
> +
> +    os.makedirs(confdir)
> +    os.makedirs(layerdir)
> +
> +    bb.process.run("git -C {} init -b main".format(confdir))
> +    bb.process.run("git -C {} commit --allow-empty -m 'Initial
> commit'".format(confdir))
> +
> +    bb.event.register("bb.build.TaskProgress", handle_task_progress,
> data=3Dd)
> +
> +    write_config(upstream_config, confdir)
> +    commit_config(confdir)
> +    update_build(upstream_config, confdir, builddir, layerdir, d)
> +
> +    bb.event.remove("bb.build.TaskProgress", None)
> +
> +def get_diff(file1, file2):
> +    try:
> +        bb.process.run('diff -uNr {} {}'.format(file1, file2))
> +    except bb.process.ExecutionError as e:
> +        if e.exitcode =3D=3D 1:
> +            return e.stdout
> +        else:
> +            raise e
> +    return None
> +
> +def are_layers_changed(layers, layerdir, d):
> +    changed =3D False
> +    for r_name in layers:
> +        r_data =3D layers[r_name]
> +        repodir =3D r_data["path"]
> +
> +        r_remote =3D r_data['git-remote']
> +        rev =3D r_remote['rev']
> +        remotes =3D r_remote['remotes']
> +
> +        for remote in remotes:
> +            type,host,path,user,pswd,params =3D
> bb.fetch.decodeurl(remotes[remote]["uri"])
> +            fetchuri =3D
> bb.fetch.encodeurl(('git',host,path,user,pswd,params))
> +            fetcher =3D
> bb.fetch.FetchData("{};protocol=3D{};rev=3D{};nobranch=3D1;destsuffix=3D{=
}".format(fetchuri,type,rev,repodir),
> d)
> +            upstream_revision =3D fetcher.method.latest_revision(fetcher=
,
> d, 'default')
> +            rev_parse_result =3D bb.process.run('git -C {} rev-parse
> HEAD'.format(os.path.join(layerdir, repodir)))
> +            local_revision =3D rev_parse_result[0].strip()
> +            if upstream_revision !=3D local_revision:
> +                changed =3D True
> +                print('Layer repository {} checked out into {} updated
> revision {} from {} to {}'.format(remotes[remote]["uri"],
> os.path.join(layerdir, repodir), rev, local_revision, upstream_revision))
> +
> +    return changed
> +
> +def build_status(settings, args, d, update=3DFalse):
> +    builddir =3D args.build_dir
> +
> +    confdir =3D os.path.join(builddir, "config")
> +    layerdir =3D os.path.join(builddir, "layers")
> +
> +    current_upstream_config =3D json.load(open(os.path.join(confdir,
> "config-upstream.json")))
> +
> +    args.config =3D
> current_upstream_config['non-interactive-cmdline-options'].split()
> +    args.non_interactive =3D True
> +    source_overrides =3D current_upstream_config["source-overrides"]
> +    new_upstream_config =3D obtain_config(settings, args, source_overrid=
es,
> d)
> +
> +    write_config(new_upstream_config, confdir)
> +    config_diff =3D bb.process.run('git -C {} diff'.format(confdir))[0]
> +
> +    if config_diff:
> +        print('Configuration in {} has changed:\n{}'.format(builddir,
> config_diff))
> +        if update:
> +            commit_config(confdir)
> +            update_build(new_upstream_config, confdir, builddir,
> layerdir, d)
> +        else:
> +            bb.process.run('git -C {} restore
> config-upstream.json'.format(confdir))
> +        return
> +
> +    if are_layers_changed(current_upstream_config["data"]["sources"],
> layerdir, d):
> +        if update:
> +            update_build(current_upstream_config, confdir, builddir,
> layerdir, d)
> +        return
> +
> +    print("Configuration in {} has not changed.".format(builddir))
> +
> +def build_update(settings, args, d):
> +    build_status(settings, args, d, update=3DTrue)
> +
> +def do_fetch(fetcher, dir):
> +    # git fetcher simply dumps git output to stdout; in bitbake context
> that is redirected to temp/log.do_fetch
> +    # and we need to set up smth similar here
> +    fetchlogdir =3D os.path.join(dir, 'logs')
> +    os.makedirs(fetchlogdir, exist_ok=3DTrue)
> +    fetchlog =3D os.path.join(fetchlogdir,
> 'fetch_log.{}'.format(datetime.datetime.now().strftime("%Y%m%d%H%M%S")))
> +    with open(fetchlog, 'a') as f:
> +        oldstdout =3D sys.stdout
> +        sys.stdout =3D f
> +        fetcher.download()
> +        fetcher.unpack(dir)
> +        sys.stdout =3D oldstdout
> +
> +def update_registry(registry, cachedir, d):
> +    registrydir =3D 'configurations'
> +    full_registrydir =3D os.path.join(cachedir, registrydir)
> +    print("Fetching configuration registry {} into {}".format(registry,
> full_registrydir))
> +    fetcher =3D bb.fetch.Fetch(["{};destsuffix=3D{}".format(registry,
> registrydir)], d)
> +    do_fetch(fetcher, cachedir)
> +    return full_registrydir
> +
> +def has_expired(expiry_date):
> +    if expiry_date:
> +        return datetime.datetime.now() >
> datetime.datetime.fromisoformat(expiry_date)
> +    return False
> +
> +def list_registry(registry_path, with_expired):
> +    json_data =3D {}
> +
> +    for root, dirs, files in os.walk(registry_path):
> +        for f in files:
> +            if f.endswith('.conf.json'):
> +                config_name =3D get_config_name(f)
> +                config_data =3D json.load(open(os.path.join(root, f)))
> +                config_desc =3D config_data["description"]
> +                expiry_date =3D config_data.get("expires", None)
> +                if expiry_date:
> +                    if with_expired or not has_expired(expiry_date):
> +                        json_data[config_name] =3D {"description":
> config_desc, "expires": expiry_date}
> +                else:
> +                    json_data[config_name] =3D {"description": config_de=
sc}
> +    return json_data
> +
> +def list_configs(settings, args, d):
> +    registry_path =3D update_registry(settings["default"]["registry"],
> cache_dir(args.top_dir), d)
> +    json_data =3D list_registry(registry_path, args.with_expired)
> +    print("\nAvailable configurations:")
> +    for config_name, config_data in json_data.items():
> +        expiry_date =3D config_data.get("expires", None)
> +        config_desc =3D config_data["description"]
> +        if expiry_date:
> +           if args.with_expired or not has_expired(expiry_date):
> +               print("{}\t{} (supported until {})".format(config_name,
> config_desc, expiry_date))
> +        else:
> +           print("{}\t{}".format(config_name, config_desc))
> +    print("\nRun 'init' with one of the above configuration identifiers
> to set up a build.")
> +
> +    if args.write_json:
> +        with open(args.write_json, 'w') as f:
> +            json.dump(json_data, f, sort_keys=3DTrue, indent=3D4)
> +        print("Available configurations written into
> {}".format(args.write_json))
> +
> +def default_settings_path(top_dir):
> +    return os.path.join(top_dir, 'bitbake-setup.conf')
> +
> +def write_settings(top_dir, force_replace):
> +    settings_path =3D default_settings_path(top_dir)
> +    if not os.path.exists(settings_path) or force_replace:
> +        if os.path.exists(settings_path):
> +            backup_conf =3D settings_path +
> "-backup.{}".format(time.strftime("%Y%m%d%H%M%S"))
> +            os.rename(settings_path, backup_conf)
> +            print("Previous settings are in {}".format(backup_conf))
> +
> +        settings =3D configparser.ConfigParser()
> +        settings['default'] =3D {
> +                             'registry':default_registry,
> +                             'dl-dir':os.path.join(top_dir,
> '.bitbake-setup-downloads'),
> +                            }
> +        os.makedirs(os.path.dirname(settings_path), exist_ok=3DTrue)
> +        with open(settings_path, 'w') as settingsfile:
> +            settings.write(settingsfile)
> +        print('Created a new settings file in
> {}.\n'.format(settings_path))
> +
> +def load_settings(top_dir):
> +    # This creates a new settings file if it does not yet exist
> +    write_settings(top_dir, force_replace=3DFalse)
> +
> +    settings_path =3D default_settings_path(top_dir)
> +    settings =3D configparser.ConfigParser()
> +    print('Loading settings from {}\n'.format(settings_path))
> +    settings.read([settings_path])
> +    return settings
> +
> +def change_settings(top_dir, new_settings):
> +    # This creates a new settings file if it does not yet exist
> +    write_settings(top_dir, force_replace=3DFalse)
> +
> +    settings =3D load_settings(top_dir)
> +    for section, section_settings in new_settings.items():
> +        for setting, value in section_settings.items():
> +            settings[section][setting] =3D value
> +            print("Setting '{}' in section '{}' is changed to
> '{}'".format(setting, section, value))
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
> +    return os.environ.get('BITBAKE_SETUP_TOP_DIR') or
> os.path.join(os.path.expanduser('~'), 'bitbake-builds')
> +
> +def main():
> +    def add_top_dir_arg(parser):
> +        parser.add_argument('--top-dir', default=3Dget_default_top_dir()=
,
> help=3D'Top level directory where builds are set up and downloaded
> configurations and layers are cached for reproducibility and offline
> builds, default is %(default)s, can be overriden via BITBAKE_SETUP_TOP_DI=
R
> environment variable')
> +
> +    def add_build_dir_arg(parser):
> +        build_dir =3D get_build_dir_via_bbpath()
> +        if build_dir:
> +            parser.add_argument('--build-dir', default=3Dbuild_dir,
> help=3D"Path to the build, default is %(default)s via BBPATH")
> +        else:
> +            parser.add_argument('--build-dir', required=3DTrue, help=3D"=
Path
> to the build")
> +
> +    parser =3D argparse.ArgumentParser(
> +        description=3D"BitBake setup utility. Run with 'init' argument t=
o
> get started.",
> +        epilog=3D"Use %(prog)s <subcommand> --help to get help on a
> specific command"
> +        )
> +    parser.add_argument('-d', '--debug', help=3D'Enable debug output',
> action=3D'store_true')
> +    parser.add_argument('-q', '--quiet', help=3D'Print only errors',
> action=3D'store_true')
> +    parser.add_argument('--color', choices=3D['auto', 'always', 'never']=
,
> default=3D'auto', help=3D'Colorize output (where %(metavar)s is %(choices=
)s)',
> metavar=3D'COLOR')
> +    parser.add_argument('--no-network', action=3D'store_true', help=3D'D=
o not
> check whether configuration repositories and layer repositories have been
> updated; use only the local cache.')
> +
> +    subparsers =3D parser.add_subparsers()
> +
> +    parser_list =3D subparsers.add_parser('list', help=3D'List available
> configurations')
> +    add_top_dir_arg(parser_list)
> +    parser_list.add_argument('--with-expired', action=3D'store_true',
> help=3D'List also configurations that are no longer supported due to reac=
hing
> their end-of-life dates.')
> +    parser_list.add_argument('--write-json', action=3D'store', help=3D'W=
rite
> available configurations into a json file so they can be programmatically
> processed.')
> +    parser_list.set_defaults(func=3Dlist_configs)
> +
> +    parser_init =3D subparsers.add_parser('init', help=3D'Select a
> configuration and initialize a build from it')
> +    add_top_dir_arg(parser_init)
> +    parser_init.add_argument('config', nargs=3D'*', help=3D"path/URL/id =
to a
> configuration file (use 'list' command to get available ids), followed by
> configuration options. Bitbake-setup will ask to choose from available
> choices if command line doesn't completely specify them.")
> +    parser_init.add_argument('--non-interactive', action=3D'store_true',
> help=3D'Do not ask to interactively choose from available options; if
> bitbake-setup cannot make a decision it will stop with a failure.')
> +    parser_init.add_argument('--source-overrides', action=3D'store',
> help=3D'Override sources information (repositories/revisions) with values
> from a local json file.')
> +    parser_init.set_defaults(func=3Dinit_config)
> +
> +    parser_status =3D subparsers.add_parser('status', help=3D'Check if t=
he
> build needs to be synchronized with configuration')
> +    add_build_dir_arg(parser_status)
> +    parser_status.set_defaults(func=3Dbuild_status)
> +
> +    parser_update =3D subparsers.add_parser('update', help=3D'Update a b=
uild
> to be in sync with configuration')
> +    add_build_dir_arg(parser_update)
> +    parser_update.set_defaults(func=3Dbuild_update)
> +
> +    parser_reset_settings =3D subparsers.add_parser('reset-settings',
> help=3D'Write a settings file with default values into the top level
> directory (contains the location of build configuration registry, downloa=
ds
> directory and other global settings)')
> +    add_top_dir_arg(parser_reset_settings)
> +    parser_reset_settings.set_defaults(func=3Dwrite_settings)
> +
> +    parser_change_setting =3D subparsers.add_parser('change-setting',
> help=3D'Change a setting in the settings file')
> +    add_top_dir_arg(parser_change_setting)
> +    parser_change_setting.add_argument('section', help=3D"Section in a
> settings file, typically 'default'")
> +    parser_change_setting.add_argument('key', help=3D"Name of the settin=
g")
> +    parser_change_setting.add_argument('value', help=3D"Value of the
> setting")
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
> +        if not os.path.exists(os.path.join(args.build_dir,'build',
> 'init-build-env')):
> +            print("Not a valid build directory: build/init-build-env doe=
s
> not exist in {}".format(args.build_dir))
> +            return
> +        # commands without --top-dir argument (status, update) still nee=
d
> to know where
> +        # the top dir is, but it should be auto-deduced as parent of
> args.build_dir
> +        if not hasattr(args, 'top_dir'):
> +            args.top_dir =3D
> os.path.dirname(os.path.normpath(args.build_dir))
> +
> +    if 'func' in args:
> +        if args.func =3D=3D write_settings:
> +            write_settings(args.top_dir, force_replace=3DTrue)
> +        elif args.func =3D=3D change_settings:
> +            change_settings(args.top_dir,
> {args.section:{args.key:args.value}})
> +        else:
> +            settings =3D load_settings(args.top_dir)
> +            d =3D init_bb_cache(settings, args)
> +            args.func(settings, args, d)
> +            save_bb_cache()
> +    else:
> +        from argparse import Namespace
> +        parser.print_help()
> +
> +main()
> --
> 2.39.5
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17872):
> https://lists.openembedded.org/g/bitbake-devel/message/17872
> Mute This Topic: https://lists.openembedded.org/mt/114685174/924729
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ticotimo@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--00000000000068f577063cbee524
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I agree with Richard. This is really shaping up nicely. An=
d I want to really thank you for all the effort and iterations to get to wh=
ere we are today.<div><br></div><div>I took the liberty of documenting how =
I currently use/see bitbake-setup:<br><a href=3D"https://lists.yoctoproject=
.org/g/docs/message/7457">https://lists.yoctoproject.org/g/docs/message/745=
7</a></div><div><br></div><div>One of the things I came across is that buil=
d/conf/context-notes.txt is empty. This means when the user runs init-build=
-env they don&#39;t get the usual descriptive prompt. This can obviously be=
 improved in another iteration.</div><div><br></div><div>I resisted documen=
ting both &quot;yocto-master-nested-configs&quot; and &quot;yocto-master-op=
tions&quot;. I started with &quot;yocto-master-nested-configs&quot;, which =
is &quot;cleaner&quot; or &quot;simpler&quot; to some extent and instead we=
nt with &quot;yocto-master-options&quot; which feels like it makes decision=
s the user expects (choosing a MACHINE and a DISTRO). I&#39;m still on the =
fence about that.</div><div><br></div><div>I&#39;ve tried to resist adding =
new features and so on to allow you to do the initial development with your=
 initial target audience. Maintainers are not the initial target audience, =
for instance. In my first attempt at documentation, I tried (like you inten=
ded) to address the &quot;new to Yocto&quot; audience and not experts.</div=
><div><br></div><div>I hope that my initial attempt at documentation isn&#3=
9;t too far off from being useful. Clearly another section explaining more =
about the way config-upstream.json works and other aspects such as bitbake-=
setup.conf is needed, but I wanted to address just the &quot;how do I use t=
his?&quot; basics. My goal was to actually get folks to try it.</div><div><=
br></div><div>Cheers,</div><div>Tim</div></div><br><div class=3D"gmail_quot=
e gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug =
13, 2025 at 8:15=E2=80=AFAM Alexander Kanavin via <a href=3D"http://lists.o=
penembedded.org">lists.openembedded.org</a> &lt;alex.kanavin=3D<a href=3D"m=
ailto:gmail.com@lists.openembedded.org">gmail.com@lists.openembedded.org</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" target=3D"_b=
lank">alex@linutronix.de</a>&gt;<br>
<br>
Preamble<br>
=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
The latest iteration of this patchset is available at<br>
<a href=3D"https://github.com/kanavin/bitbake" rel=3D"noreferrer" target=3D=
"_blank">https://github.com/kanavin/bitbake</a><br>
I recommend taking the patches from there to ensure that<br>
you are not trying out outdated code.<br>
<br>
For the rationale and design guidelines please see this message:<br>
<a href=3D"https://lists.openembedded.org/g/openembedded-architecture/messa=
ge/1913" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.or=
g/g/openembedded-architecture/message/1913</a><br>
<br>
Left out for now but will be done later:<br>
<br>
- handling site-specific settings. There was a discussion about it:<br>
<br>
=3D=3D=3D=3D=3D<br>
&gt; Finally, a question, how do you recommend to handle my local SSTATE_DI=
R/DL_DIR?<br>
&gt; Setup with bbsetup, copy a site.conf with these config inside the buil=
d, then<br>
&gt; the proper build? ... or is there a better way?<br>
<br>
This is an unresolved question. I&#39;m open to proposals. Or code.<br>
<br>
I guess it will be something like &#39;bitbake-setup change-setting<br>
default site-conf /path/to/site.conf&#39;, and then bitbake-setup will add<=
br>
that to every build that is initialized. Site.conf need not list site<br>
settings directly, it too can add a fragment maintained in a layer.<br>
That way CI settings can be specified and maintained in a layer, but<br>
they don&#39;t need to be added to a json config, as that would impose<br>
them on everyone using that config to reproduce builds locally.<br>
=3D=3D=3D=3D=3D<br>
<br>
- official configuration repository<br>
<br>
- documentation<br>
<br>
Amble *scratch* HOWTO<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
1. If you don&#39;t know where to start, run &#39;bitbake-setup init&#39;.<=
br>
<br>
Bitbake-setup will ask a few questions about available configuration choice=
s and set up a build:<br>
<br>
=3D=3D=3D<br>
alex@alex-lx-laptop:~$ development/bitbake/bin/bitbake-setup init<br>
Created a new settings file in /home/alex/bitbake-builds/bitbake-setup.conf=
.<br>
<br>
Loading settings from /home/alex/bitbake-builds/bitbake-setup.conf<br>
<br>
Fetching configuration registry git://<a href=3D"http://github.com/kanavin/=
bitbake-setup-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain"=
 rel=3D"noreferrer" target=3D"_blank">github.com/kanavin/bitbake-setup-conf=
igurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain</a> into /home/ale=
x/bitbake-builds/.bitbake-setup-cache/configurations<br>
<br>
Available configurations:<br>
0. yocto-master-nested-configs=C2=A0 (future) Official Yocto configurations=
: poky, poky-altcfg, poky-tiny, for qemux86-64 and arm64 (defined with nest=
ed configurations)<br>
1. yocto-master-options (future) Official Yocto configurations: poky, poky-=
altcfg, poky-tiny, for qemux86-64, riscv64 and arm64 (defined with options)=
<br>
<br>
Please select one of the above configurations by its number:<br>
1<br>
Selecting the only available bitbake configuration poky<br>
Available target machines:<br>
0. machine/qemux86-64<br>
1. machine/qemuarm64<br>
2. machine/qemuriscv64<br>
Please select one of the above options by its number:<br>
0<br>
Available distributions:<br>
0. distro/poky<br>
1. distro/poky-altcfg<br>
2. distro/poky-tiny<br>
Please select one of the above options by its number:<br>
0<br>
Run &#39;bitbake-setup yocto-master-options poky distro/poky machine/qemux8=
6-64&#39; to select this configuration non-interactively.<br>
Initializing a build in /home/alex/bitbake-builds/yocto-master-options-poky=
-distro_poky-machine_qemux86-64<br>
Fetching layer/tool repository bitbake into /home/alex/bitbake-builds/yocto=
-master-options-poky-distro_poky-machine_qemux86-64/layers/bitbake<br>
Fetching layer/tool repository openembedded-core into /home/alex/bitbake-bu=
ilds/yocto-master-options-poky-distro_poky-machine_qemux86-64/layers/openem=
bedded-core<br>
Fetching layer/tool repository meta-yocto into /home/alex/bitbake-builds/yo=
cto-master-options-poky-distro_poky-machine_qemux86-64/layers/meta-yocto<br=
>
Fetching layer/tool repository yocto-docs into /home/alex/bitbake-builds/yo=
cto-master-options-poky-distro_poky-machine_qemux86-64/layers/yocto-docs<br=
>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
Setting up bitbake configuration in /home/alex/bitbake-builds/yocto-master-=
options-poky-distro_poky-machine_qemux86-64/build<br>
This bitbake configuration provides: Poky reference distro build<br>
Usage instructions and additional information are in /home/alex/bitbake-bui=
lds/yocto-master-options-poky-distro_poky-machine_qemux86-64/build/README<b=
r>
=3D=3D=3D<br>
<br>
Note: &#39;init&#39; sub-command can also take a path or a URL with a confi=
guration file directly.<br>
You can see how those files look like here:<br>
<a href=3D"https://github.com/kanavin/bitbake-setup-configurations" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/kanavin/bitbake-setup-conf=
igurations</a><br>
<br>
2. You can then source the bitbake environment and run bitbake to perform b=
uilds as usual:<br>
<br>
alex@alex-lx-laptop:~$ . /home/alex/bitbake-builds/yocto-master-options-pok=
y-distro_poky-machine_qemux86-64/build/init-build-env<br>
<br>
Also, subsequent status/update commands will not require a separate --build=
-dir argument telling<br>
bitbake-setup where the build is.<br>
<br>
3. To check if the build configuration needs to be updated, run:<br>
=3D=3D=3D<br>
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup status<br>
Loading settings from /home/alex/bitbake-builds/bitbake-setup.conf.<br>
<br>
Fetching configuration registry git://<a href=3D"http://github.com/kanavin/=
bitbake-setup-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain"=
 rel=3D"noreferrer" target=3D"_blank">github.com/kanavin/bitbake-setup-conf=
igurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain</a> into /home/ale=
x/bitbake-builds/.bitbake-setup-cache/configurations<br>
Configuration in /home/alex/bitbake-builds/poky-alex/ has not changed.<br>
=3D=3D=3D<br>
<br>
If the configuration has changed, you will see the difference:<br>
=3D=3D=3D<br>
...<br>
Configuration in /home/alex/builds/poky-alex has changed:<br>
--- /home/alex/builds/poky-alex/config/poky-alex.conf.json=C2=A0 =C2=A0 =C2=
=A0 2024-12-16 11:43:24.077446096 +0100<br>
+++ /home/alex/builds/poky-alex/config-tmp-asoubw5u/poky-alex.conf.json 202=
4-12-16 11:47:43.237104405 +0100<br>
@@ -7,7 +7,7 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;uri&quot;: &quot;git://<a href=3D"http://git.yoctopr=
oject.org/poky-contrib" rel=3D"noreferrer" target=3D"_blank">git.yoctoproje=
ct.org/poky-contrib</a>&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rev&quot;: &=
quot;akanavin/sstate-for-all&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;rev&quot;: &=
quot;akanavin/bitbake-setup-testing&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;path&quot;: &quot;pok=
y&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=3D=3D=3D<br>
<br>
If the configuration has not changed, but layer revisions referred to it ha=
ve (for example<br>
if the configuration specifies a tip of a branch), you will see that too:<b=
r>
=3D=3D=3D<br>
...<br>
Layer repository git://<a href=3D"http://git.yoctoproject.org/poky-contrib"=
 rel=3D"noreferrer" target=3D"_blank">git.yoctoproject.org/poky-contrib</a>=
 checked out into /home/alex/builds/poky-alex/layers/poky updated revision =
akanavin/sstate-for-all from 6b842ba55f996b27c900e3de78ceac8cb3b1c492 to ae=
b73e29379fe6007a8adc8d94c1ac18a93e68de<br>
=3D=3D=3D<br>
<br>
4. If the configuration has changed, you can bring it in sync with:<br>
=3D=3D=3D<br>
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup update<br>
Default parameter values are in /home/alex/.bitbake-setup/config - adjust a=
s needed.<br>
<br>
Fetching configuration repository git://<a href=3D"http://github.com/kanavi=
n/bitbake-setup-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmai=
n" rel=3D"noreferrer" target=3D"_blank">github.com/kanavin/bitbake-setup-co=
nfigurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain</a> into /home/a=
lex/.bitbake-setup/configurations<br>
Layer repository git://<a href=3D"http://git.yoctoproject.org/poky-contrib"=
 rel=3D"noreferrer" target=3D"_blank">git.yoctoproject.org/poky-contrib</a>=
 checked out into /home/alex/builds/poky-alex/layers/poky updated revision =
akanavin/bitbake-setup-testing from d174acad934f8ad1fe303abc5705733e1554285=
9 to a3d2ee10045f8c1151d680ad97994c5d6cf51ece<br>
Fetching layer/tool repository poky into /home/alex/builds/poky-alex/layers=
/poky<br>
<br>
Setting up bitbake configuration gadget in /home/alex/bitbake-builds/poky-a=
lex/build-gadget<br>
Existing bitbake congfiguration directory renamed to /home/alex/builds/poky=
-alex/build-gadget/conf-backup.20241216115007<br>
The bitbake configuration has changed:<br>
diff -uNr /home/alex/builds/poky-alex/build-gadget/conf-backup.202412161150=
07/local.conf /home/alex/builds/poky-alex/build-gadget/conf/local.conf<br>
--- /home/alex/builds/poky-alex/build-gadget/conf-backup.20241216115007/loc=
al.conf=C2=A0 =C2=A0 =C2=A0 2024-12-16 11:47:51.865043102 +0100<br>
+++ /home/alex/builds/poky-alex/build-gadget/conf/local.conf=C2=A0 =C2=A0 2=
024-12-16 11:50:07.811942847 +0100<br>
@@ -287,5 +287,3 @@<br>
=C2=A0# track the version of this file when it was generated. This can safe=
ly be ignored if<br>
=C2=A0# this doesn&#39;t mean anything to you.<br>
=C2=A0CONF_VERSION =3D &quot;2&quot;<br>
-<br>
-TCLIBC =3D &quot;musl&quot;<br>
<br>
Bitbake configuration summary: This configuration is intended for building =
gadget.<br>
Usage instructions and additional information in /home/alex/bitbake-builds/=
poky-alex/build-gadget/README<br>
=3D=3D=3D<br>
<br>
Note that it will also rename/preserve the existing build/conf directory, a=
nd print changes<br>
in bitbake configuration (diff of content of build/conf/) if that has chang=
ed. I can&#39;t<br>
at the moment think of anything more clever that is also not much more brit=
tle or complex<br>
to implement, but open to suggestions.<br>
<br>
Terminology<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
- &#39;top directory&#39; means the place under which bitbake-setup reads a=
nd<br>
writes everything. bitbake-setup makes a promise to not touch anything outs=
ide of<br>
that, unless otherwise directed to by entries in settings (currently<br>
there is one such setting for fetcher downloads for layers and config<br>
registries). Top directory can be selected by an environment variable, a co=
mmand line option,<br>
or otherwise assumed to be ~/bitbake-builds/. If BBPATH is in environment<b=
r>
(e.g. we are in a bitbake environment), then the top directory is<br>
deduced from that and doesn&#39;t need to be specified by hand.<br>
<br>
- &#39;settings&#39; means bitbake-setup operational parameters that are<br=
>
global to all builds under a top directory. E.g. the location of<br>
configuration registry, or where the bitbake fetcher should place the<br>
downloads (DL_DIR setting). Settings are stored in a .conf file in ini<br>
format just under the top directory.<br>
<br>
- &#39;build&#39; means a tree structure set up by &#39;bitbake-setup init&=
#39;,<br>
consisting of, at least, a layers checkout, and a bitbake<br>
build. It maps 1:1 to the json data it was constructed from, which is<br>
called &#39;build configuration&#39;. Build configurations are constructed =
from<br>
generic configurations that may involve making one or more choices<br>
about available options in them. Generic configurations are files, URLs<br>
or are obtained from git repositories called &#39;config<br>
registries&#39;, in which case they can be listed with &#39;bitbake-setup<b=
r>
list&#39;. There can be multiple &#39;builds&#39; under a top directory. He=
re are<br>
two example generic configurations that showcase this:<br>
<a href=3D"https://github.com/kanavin/bitbake-setup-configurations/blob/mai=
n/yocto-master-options.conf.json" rel=3D"noreferrer" target=3D"_blank">http=
s://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-master-=
options.conf.json</a><br>
<a href=3D"https://github.com/kanavin/bitbake-setup-configurations/blob/mai=
n/yocto-master-nested-configs.conf.json" rel=3D"noreferrer" target=3D"_blan=
k">https://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-=
master-nested-configs.conf.json</a><br>
<br>
- &#39;bitbake-setup status&#39; will tell if a build is in sync with<br>
the generic configuration it was made from. &#39;bitbake-setup update&#39; =
will bring a build<br>
in sync with a configuration if needed.<br>
<br>
- &#39;bitbake build&#39; means a particular sub-tree inside a build that<b=
r>
bitbake itself operates on, e.g. what is set in BBPATH/BUILDDIR<br>
by oe-init-build-env. conf/* in that tree is &#39;bitbake configuration&#39=
;.<br>
Bitbake configurations are constructed from templates and fragments,<br>
with existing mechanisms provided by oe-core. The configuration file<br>
format is specified such that other mechanisms to set up a<br>
bitbake build can be added; there was a mention of ability to specify<br>
local.conf content and a set of layers directly in a configuration. I<br>
think that scales poorly compared to templates and fragments, but I<br>
made sure alternative ways to configure a bitbake build are possible<br>
to add in the future :)<br>
<br>
- &#39;source override&#39; is a json file that can be used to modify revis=
ions<br>
and origins of layers that need to be checkout into a build (e.g.<br>
when master branches need to be changed to master-next for purposes<br>
of testing). Such a file is specified with a command-line option to &#39;in=
it&#39;<br>
and an example can be seen here:<br>
<a href=3D"https://github.com/kanavin/bitbake-setup-configurations/blob/mai=
n/yocto-master-next.override.json" rel=3D"noreferrer" target=3D"_blank">htt=
ps://github.com/kanavin/bitbake-setup-configurations/blob/main/yocto-master=
-next.override.json</a><br>
<br>
This commit includes a fix by Ryan Eatmon &lt;<a href=3D"mailto:reatmon@ti.=
com" target=3D"_blank">reatmon@ti.com</a>&gt;:<br>
<a href=3D"https://github.com/kanavin/bitbake/pull/1" rel=3D"noreferrer" ta=
rget=3D"_blank">https://github.com/kanavin/bitbake/pull/1</a><br>
<br>
Signed-off-by: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" =
target=3D"_blank">alex@linutronix.de</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-setup | 673 +++++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 673 insertions(+)<br>
=C2=A0create mode 100755 bin/bitbake-setup<br>
<br>
diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
new file mode 100755<br>
index 000000000..11569e67d<br>
--- /dev/null<br>
+++ b/bin/bitbake-setup<br>
@@ -0,0 +1,673 @@<br>
+#!/usr/bin/env python3<br>
+<br>
+#<br>
+# SPDX-License-Identifier: GPL-2.0-only<br>
+#<br>
+<br>
+import logging<br>
+import os<br>
+import sys<br>
+import argparse<br>
+import warnings<br>
+import json<br>
+import shutil<br>
+import time<br>
+import stat<br>
+import tempfile<br>
+import configparser<br>
+import datetime<br>
+<br>
+default_registry =3D &#39;git://<a href=3D"http://github.com/kanavin/bitba=
ke-setup-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain" rel=
=3D"noreferrer" target=3D"_blank">github.com/kanavin/bitbake-setup-configur=
ations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain</a>&#39;<br>
+<br>
+bindir =3D os.path.abspath(os.path.dirname(__file__))<br>
+sys.path[0:0] =3D [os.path.join(os.path.dirname(bindir), &#39;lib&#39;)]<b=
r>
+<br>
+import bb.msg<br>
+import bb.process<br>
+<br>
+logger =3D bb.msg.logger_create(&#39;bitbake-setup&#39;, sys.stdout)<br>
+<br>
+def cache_dir(top_dir):<br>
+=C2=A0 =C2=A0 return os.path.join(top_dir, &#39;.bitbake-setup-cache&#39;)=
<br>
+<br>
+def init_bb_cache(settings, args):<br>
+=C2=A0 =C2=A0 dldir =3D settings[&quot;default&quot;][&quot;dl-dir&quot;]<=
br>
+=C2=A0 =C2=A0 bb_cachedir =3D os.path.join(cache_dir(args.top_dir), &#39;b=
itbake-cache&#39;)<br>
+<br>
+=C2=A0 =C2=A0 d =3D bb.data.init()<br>
+=C2=A0 =C2=A0 d.setVar(&quot;DL_DIR&quot;, dldir)<br>
+=C2=A0 =C2=A0 d.setVar(&quot;BB_CACHEDIR&quot;, bb_cachedir)<br>
+=C2=A0 =C2=A0 d.setVar(&quot;__BBSRCREV_SEEN&quot;, &quot;1&quot;)<br>
+=C2=A0 =C2=A0 if args.no_network:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 d.setVar(&quot;BB_SRCREV_POLICY&quot;, &quot;c=
ache&quot;)<br>
+=C2=A0 =C2=A0 bb.fetch.fetcher_init(d)<br>
+=C2=A0 =C2=A0 return d<br>
+<br>
+def save_bb_cache():<br>
+=C2=A0 =C2=A0 bb.fetch2.fetcher_parse_save()<br>
+=C2=A0 =C2=A0 bb.fetch2.fetcher_parse_done()<br>
+<br>
+def get_config_name(config):<br>
+=C2=A0 =C2=A0 return os.path.basename(config).split(&#39;.&#39;)[0]<br>
+<br>
+def write_config(config, config_dir):<br>
+=C2=A0 =C2=A0 with open(os.path.join(config_dir, &quot;config-upstream.jso=
n&quot;),&#39;w&#39;) as s:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 json.dump(config, s, sort_keys=3DTrue, indent=
=3D4)<br>
+<br>
+def commit_config(config_dir):<br>
+=C2=A0 =C2=A0 bb.process.run(&quot;git -C {} add .&quot;.format(config_dir=
))<br>
+=C2=A0 =C2=A0 bb.process.run(&quot;git -C {} commit -a -m &#39;Configurati=
on at {}&#39;&quot;.format(config_dir, time.asctime()))<br>
+<br>
+def _write_layer_list(dest, repodirs):<br>
+=C2=A0 =C2=A0 layers =3D []<br>
+=C2=A0 =C2=A0 for r in repodirs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for root, dirs, files in os.walk(os.path.join(=
dest,r)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.basename(root) =3D=3D=
 &#39;conf&#39; and &#39;layer.conf&#39; in files:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layers.append(os.p=
ath.relpath(os.path.dirname(root), dest))<br>
+=C2=A0 =C2=A0 layers_f =3D os.path.join(dest, &quot;.oe-layers.json&quot;)=
<br>
+=C2=A0 =C2=A0 with open(layers_f, &#39;w&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 json.dump({&quot;version&quot;:&quot;1.0&quot;=
,&quot;layers&quot;:layers}, f, sort_keys=3DTrue, indent=3D4)<br>
+<br>
+def checkout_layers(layers, layerdir, d):<br>
+=C2=A0 =C2=A0 repodirs =3D []<br>
+=C2=A0 =C2=A0 oesetupbuild =3D None<br>
+=C2=A0 =C2=A0 for r_name in layers:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r_data =3D layers[r_name]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 repodir =3D r_data[&quot;path&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 repodirs.append(repodir)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r_remote =3D r_data[&#39;git-remote&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rev =3D r_remote[&#39;rev&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 remotes =3D r_remote[&#39;remotes&#39;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for remote in remotes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type,host,path,user,pswd,params =
=3D bb.fetch.decodeurl(remotes[remote][&quot;uri&quot;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetchuri =3D bb.fetch.encodeurl(=
(&#39;git&#39;,host,path,user,pswd,params))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Fetching layer/tool =
repository {} into {}&quot;.format(r_name, os.path.join(layerdir,repodir)))=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch.Fetch([&quo=
t;{};protocol=3D{};rev=3D{};nobranch=3D1;destsuffix=3D{}&quot;.format(fetch=
uri,type,rev,repodir)], d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do_fetch(fetcher, layerdir)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(os.path.join(layerdir, repod=
ir, &#39;scripts/oe-setup-build&#39;)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 oesetupbuild =3D os.path.join(la=
yerdir, repodir, &#39;scripts/oe-setup-build&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 oeinitbuildenv =3D os.path.join(=
layerdir, repodir, &#39;oe-init-build-env&#39;)<br>
+<br>
+=C2=A0 =C2=A0 _write_layer_list(layerdir, repodirs)<br>
+<br>
+=C2=A0 =C2=A0 if oesetupbuild:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 links =3D {&#39;setup-build&#39;: oesetupbuild=
, &#39;oe-scripts&#39;: os.path.dirname(oesetupbuild), &#39;init-build-env&=
#39;: oeinitbuildenv}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for l,t in links.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 symlink =3D os.path.join(layerdi=
r, l)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.lexists(symlink):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.remove(symlink)=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.symlink(os.path.relpath(t,lay=
erdir),symlink)<br>
+<br>
+def setup_bitbake_build(bitbake_config, layerdir, builddir):<br>
+=C2=A0 =C2=A0 def _setup_build_conf(layers, build_conf_dir):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.makedirs(build_conf_dir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 layers_s =3D &quot;\n&quot;.join([&quot;=C2=A0=
 {} \\&quot;.format(os.path.join(layerdir,l)) for l in layers])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bblayers_conf =3D &quot;&quot;&quot;BBLAYERS ?=
=3D &quot; \<br>
+{}<br>
+=C2=A0 &quot;<br>
+&quot;&quot;&quot;.format(layers_s)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(os.path.join(build_conf_dir, &quot;b=
blayers.conf&quot;), &#39;w&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(bblayers_conf)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 local_conf =3D &quot;&quot;&quot;#<br>
+# This file is intended for local configuration tweaks.<br>
+#<br>
+# If you would like to publish and share changes made to this file,<br>
+# it is recommended to put them into a distro config, or to create<br>
+# layer fragments from changes made here.<br>
+#<br>
+&quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(os.path.join(build_conf_dir, &quot;l=
ocal.conf&quot;), &#39;w&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(local_conf)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(os.path.join(build_conf_dir, &quot;t=
emplateconf.cfg&quot;), &#39;w&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(os.path.join(build_conf_dir, &quot;c=
onf-summary.txt&quot;), &#39;w&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(bitbake_config[&quot;des=
cription&quot;] + &quot;\n&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(os.path.join(build_conf_dir, &quot;c=
onf-notes.txt&quot;), &#39;w&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(&quot;&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def _make_init_build_env(builddir, initbuildenv):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D &quot;. {} {}&quot;.format(initbuilden=
v, builddir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initbuild_in_builddir =3D os.path.join(builddi=
r, &#39;init-build-env&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(initbuild_in_builddir, &#39;w&#39;) =
as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(cmd)<br>
+<br>
+=C2=A0 =C2=A0 bitbake_builddir =3D os.path.join(builddir, &quot;build&quot=
;)<br>
+=C2=A0 =C2=A0 print(&quot;=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D&quot;)<br>
+=C2=A0 =C2=A0 print(&quot;Setting up bitbake configuration in {}&quot;.for=
mat(bitbake_builddir))<br>
+<br>
+=C2=A0 =C2=A0 template =3D bitbake_config.get(&quot;oe-template&quot;)<br>
+=C2=A0 =C2=A0 layers =3D bitbake_config.get(&quot;bb-layers&quot;)<br>
+=C2=A0 =C2=A0 if not template and not layers:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Bitbake configuration does not con=
tain a reference to an OpenEmbedded build template via &#39;oe-template&#39=
; or a list of layers via &#39;bb-layers&#39;; please use oe-setup-build, o=
e-init-build-env or another mechanism manually to complete the setup.&quot;=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 oesetupbuild =3D os.path.join(layerdir, &#39;setup-build&#39=
;)<br>
+=C2=A0 =C2=A0 if template and not os.path.exists(oesetupbuild):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(&quot;Cannot complete setting =
up a bitbake build directory from OpenEmbedded template &#39;{}&#39; as oe-=
setup-build was not found in any layers; please use oe-init-build-env manua=
lly.&quot;.format(template))<br>
+<br>
+=C2=A0 =C2=A0 bitbake_confdir =3D os.path.join(bitbake_builddir, &#39;conf=
&#39;)<br>
+=C2=A0 =C2=A0 backup_bitbake_confdir =3D bitbake_confdir + &quot;-backup.{=
}&quot;.format(time.strftime(&quot;%Y%m%d%H%M%S&quot;))<br>
+=C2=A0 =C2=A0 if os.path.exists(bitbake_confdir):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.rename(bitbake_confdir, backup_bitbake_conf=
dir)<br>
+<br>
+=C2=A0 =C2=A0 if layers:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _setup_build_conf(layers, bitbake_confdir)<br>
+<br>
+=C2=A0 =C2=A0 if template:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.process.run(&quot;{} setup -c {} -b {} --no=
-shell&quot;.format(oesetupbuild, template, bitbake_builddir))<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 initbuildenv =3D os.path.join(layerdir, &#39;i=
nit-build-env&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(initbuildenv):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Could not find oe-in=
it-build-env in any of the layers; please use another mechanism to initiali=
ze the bitbake environment&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 _make_init_build_env(bitbake_builddir, os.path=
.realpath(initbuildenv))<br>
+<br>
+=C2=A0 =C2=A0 init_script =3D os.path.join(bitbake_builddir, &quot;init-bu=
ild-env&quot;)<br>
+=C2=A0 =C2=A0 shell =3D os.path.basename(os.environ.get(&quot;SHELL&quot;,=
&quot;bash&quot;))<br>
+=C2=A0 =C2=A0 fragments =3D bitbake_config.get(&quot;oe-fragments&quot;, [=
]) + sorted(bitbake_config.get(&quot;oe-fragment-choices&quot;,{}).values()=
)<br>
+=C2=A0 =C2=A0 if fragments:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.process.run(&quot;{} -c &#39;. {} &amp;&amp=
; bitbake-config-build enable-fragment {}&#39;&quot;.format(shell, init_scr=
ipt, &quot; &quot;.join(fragments)))<br>
+<br>
+=C2=A0 =C2=A0 if os.path.exists(backup_bitbake_confdir):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bitbake_config_diff =3D get_diff(backup_bitbak=
e_confdir, bitbake_confdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if bitbake_config_diff:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Existing bitbake con=
figuration directory renamed to {}&quot;.format(backup_bitbake_confdir))<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;The bitbake configur=
ation has changed:&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(bitbake_config_diff)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shutil.rmtree(backup_bitbake_con=
fdir)<br>
+<br>
+=C2=A0 =C2=A0 print(&quot;This bitbake configuration provides: {}&quot;.fo=
rmat(bitbake_config[&quot;description&quot;]))<br>
+<br>
+=C2=A0 =C2=A0 readme =3D &quot;&quot;&quot;{}\n\nAdditional information is=
 in {} and {}\n<br>
+Source the environment using &#39;. {}&#39; to run builds from the command=
 line.<br>
+The bitbake configuration files (local.conf, bblayers.conf and more) can b=
e found in {}/conf<br>
+&quot;&quot;&quot;.format(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bitbake_config[&quot;description&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.path.join(bitbake_builddir,&#39;conf/conf-s=
ummary.txt&#39;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.path.join(bitbake_builddir,&#39;conf/conf-n=
otes.txt&#39;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 init_script,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bitbake_builddir<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 readme_file =3D os.path.join(bitbake_builddir, &quot;README&=
quot;)<br>
+=C2=A0 =C2=A0 with open(readme_file, &#39;w&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(readme)<br>
+=C2=A0 =C2=A0 print(&quot;Usage instructions and additional information ar=
e in {}&quot;.format(readme_file))<br>
+<br>
+def get_registry_config(registry_path, id):<br>
+=C2=A0 =C2=A0 for root, dirs, files in os.walk(registry_path):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in files:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f.endswith(&#39;.conf.json&#3=
9;) and id =3D=3D get_config_name(f):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return os.path.joi=
n(root, f)<br>
+=C2=A0 =C2=A0 raise Exception(&quot;Unable to find {} in available configu=
rations; use &#39;list&#39; sub-command to see what is available&quot;.form=
at(id))<br>
+<br>
+def update_build(config, confdir, builddir, layerdir, d):<br>
+=C2=A0 =C2=A0 layer_config =3D config[&quot;data&quot;][&quot;sources&quot=
;]<br>
+=C2=A0 =C2=A0 layer_overrides =3D config[&quot;source-overrides&quot;][&qu=
ot;sources&quot;]<br>
+=C2=A0 =C2=A0 for k,v in layer_overrides.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if k in layer_config:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 layer_config[k][&quot;git-remote=
&quot;] =3D v[&quot;git-remote&quot;]<br>
+=C2=A0 =C2=A0 checkout_layers(layer_config, layerdir, d)<br>
+=C2=A0 =C2=A0 bitbake_config =3D config[&quot;bitbake-config&quot;]<br>
+=C2=A0 =C2=A0 setup_bitbake_build(bitbake_config, layerdir, builddir)<br>
+<br>
+def flatten_bitbake_configs(configs):<br>
+=C2=A0 =C2=A0 def merge_configs(c1,c2):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 c_merged =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for k,v in c2.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if k not in c1.keys():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c_merged[k] =3D v<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for k,v in c1.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if k not in c2.keys():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 c_merged[k] =3D v<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_merged[k] =3D c1[=
k] + c2[k]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 del c_merged[&#39;configurations&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return c_merged<br>
+<br>
+=C2=A0 =C2=A0 flattened_configs =3D []<br>
+=C2=A0 =C2=A0 for c in configs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if &#39;configurations&#39; not in c:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flattened_configs.append(c)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for sub_c in flatten_bitbake_con=
figs(c[&#39;configurations&#39;]):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flattened_configs.=
append(merge_configs(c, sub_c))<br>
+=C2=A0 =C2=A0 return flattened_configs<br>
+<br>
+def choose_bitbake_config(configs, parameters, non_interactive):<br>
+=C2=A0 =C2=A0 flattened_configs =3D flatten_bitbake_configs(configs)<br>
+=C2=A0 =C2=A0 configs_dict =3D {i[&quot;name&quot;]:i for i in flattened_c=
onfigs}<br>
+<br>
+=C2=A0 =C2=A0 if parameters:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config_id =3D parameters[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if config_id not in configs_dict:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(&quot;Bitbake co=
nfiguration {} not found; replace with one of {}&quot;.format(config_id, co=
nfigs_dict))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return configs_dict[config_id]<br>
+<br>
+=C2=A0 =C2=A0 enumerated_configs =3D list(enumerate(flattened_configs))<br=
>
+=C2=A0 =C2=A0 if len(enumerated_configs) =3D=3D 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 only_config =3D flattened_configs[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Selecting the only available bitba=
ke configuration {}&quot;.format(only_config[&quot;name&quot;]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return only_config<br>
+<br>
+=C2=A0 =C2=A0 if non_interactive:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(&quot;Unable to choose from bi=
tbake configurations in non-interactive mode: {}&quot;.format(configs_dict)=
)<br>
+<br>
+=C2=A0 =C2=A0 print(&quot;Available bitbake configurations:&quot;)<br>
+=C2=A0 =C2=A0 for n, config_data in enumerated_configs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;{}. {}\t{}&quot;.format(n, config_=
data[&quot;name&quot;], config_data[&quot;description&quot;]))<br>
+=C2=A0 =C2=A0 print(&quot;\nPlease select one of the above bitbake configu=
rations by its number:&quot;)<br>
+=C2=A0 =C2=A0 config_n =3D int(input())<br>
+=C2=A0 =C2=A0 return flattened_configs[config_n]<br>
+<br>
+def choose_config(configs, non_interactive):<br>
+=C2=A0 =C2=A0 not_expired_configs =3D [k for k in configs.keys() if not ha=
s_expired(configs[k].get(&quot;expires&quot;, None))]<br>
+=C2=A0 =C2=A0 config_list =3D list(enumerate(not_expired_configs))<br>
+=C2=A0 =C2=A0 if len(config_list) =3D=3D 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 only_config =3D config_list[0][1]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Selecting the only available confi=
guration {}&quot;.format(only_config))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return only_config<br>
+<br>
+=C2=A0 =C2=A0 if non_interactive:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(&quot;Unable to choose from co=
nfigurations in non-interactive mode: {}&quot;.format(not_expired_configs))=
<br>
+<br>
+=C2=A0 =C2=A0 print(&quot;\nAvailable configurations:&quot;)<br>
+=C2=A0 =C2=A0 for n, config_name in config_list:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config_data =3D configs[config_name]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expiry_date =3D config_data.get(&quot;expires&=
quot;, None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config_desc =3D config_data[&quot;description&=
quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if expiry_date:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;{}. {}\t{} (supported=
 until {})&quot;.format(n, config_name, config_desc, expiry_date))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;{}. {}\t{}&quot;.form=
at(n, config_name, config_desc))<br>
+=C2=A0 =C2=A0 print(&quot;\nPlease select one of the above configurations =
by its number:&quot;)<br>
+=C2=A0 =C2=A0 config_n =3D int(input())<br>
+=C2=A0 =C2=A0 return config_list[config_n][1]<br>
+<br>
+def choose_fragments(possibilities, parameters, non_interactive):<br>
+=C2=A0 =C2=A0 choices =3D {}<br>
+=C2=A0 =C2=A0 for k,v in possibilities.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 choice =3D [o for o in v[&quot;options&quot;] =
if o in parameters]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(choice) &gt; 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(&quot;Options sp=
ecified on command line do not allow a single selection from possibilities =
{}, please remove one or more from {}&quot;.format(v[&quot;options&quot;], =
parameters))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if len(choice) =3D=3D 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 choices[k] =3D choice[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if non_interactive:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(&quot;Unable to =
choose from options in non-interactive mode: {}&quot;.format(v[&quot;option=
s&quot;]))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(v[&quot;description&quot;]+ &quot;:&quot=
;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 options_enumerated =3D list(enumerate(v[&quot;=
options&quot;]))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for n,o in options_enumerated:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;{}. {}&quot;.format(=
n, o))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Please select one of the above opt=
ions by its number:&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 option_n =3D int(input())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 choices[k] =3D options_enumerated[option_n][1]=
<br>
+=C2=A0 =C2=A0 return choices<br>
+<br>
+def obtain_config(settings, args, source_overrides, d):<br>
+=C2=A0 =C2=A0 if args.config:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config_id =3D args.config[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config_parameters =3D args.config[1:]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(config_id):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Reading configuratio=
n from local file {}&quot;.format(config_id))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upstream_config =3D {&#39;type&#=
39;:&#39;local&#39;,&#39;path&#39;:os.path.abspath(args.config),&#39;name&#=
39;:get_config_name(config_id),&#39;data&#39;:json.load(open(config_path))}=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif config_id.startswith(&quot;http://&quot;)=
 or config_id.startswith(&quot;https://&quot;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Reading configuratio=
n from network URI {}&quot;.format(config_id))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 import urllib.request<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with urllib.request.urlopen(conf=
ig_id) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upstream_config =3D {&#39=
;type&#39;:&#39;network&#39;,&#39;uri&#39;:config_id,&#39;name&#39;:get_con=
fig_name(config_id),&#39;data&#39;:json.load(f)}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Looking up config {}=
 in configuration registry&quot;.format(config_id))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 registry_path =3D update_registr=
y(settings[&quot;default&quot;][&quot;registry&quot;], cache_dir(args.top_d=
ir), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 registry_configs =3D list_regist=
ry(registry_path, with_expired=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if config_id not in registry_con=
figs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise Exception(&q=
uot;Config {} not found in configuration registry, re-run &#39;init&#39; wi=
thout parameters to choose from available configurations.&quot;.format(conf=
ig_id))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upstream_config =3D {&#39;type&#=
39;:&#39;registry&#39;,&#39;registry&#39;:settings[&quot;default&quot;][&qu=
ot;registry&quot;],&#39;name&#39;:config_id,&#39;data&#39;:json.load(open(g=
et_registry_config(registry_path,config_id)))}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expiry_date =3D upstream_config[&#39;data&#39;=
].get(&quot;expires&quot;, None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if has_expired(expiry_date):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;This configuration i=
s no longer supported after {}. Please consider changing to a supported con=
figuration.&quot;.format(expiry_date))<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 registry_path =3D update_registry(settings[&qu=
ot;default&quot;][&quot;registry&quot;], cache_dir(args.top_dir), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 registry_configs =3D list_registry(registry_pa=
th, with_expired=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config_id =3D choose_config(registry_configs, =
args.non_interactive)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config_parameters =3D []<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 upstream_config =3D {&#39;type&#39;:&#39;regis=
try&#39;,&#39;registry&#39;:settings[&quot;default&quot;][&quot;registry&qu=
ot;],&#39;name&#39;:config_id,&#39;data&#39;:json.load(open(get_registry_co=
nfig(registry_path,config_id)))}<br>
+<br>
+=C2=A0 =C2=A0 upstream_config[&#39;bitbake-config&#39;] =3D choose_bitbake=
_config(upstream_config[&#39;data&#39;][&#39;bitbake-setup&#39;][&#39;confi=
gurations&#39;], config_parameters, args.non_interactive)<br>
+=C2=A0 =C2=A0 upstream_config[&#39;bitbake-config&#39;][&#39;oe-fragment-c=
hoices&#39;] =3D choose_fragments(upstream_config[&#39;bitbake-config&#39;]=
.get(&#39;oe-fragments-one-of&#39;,{}), config_parameters[1:], args.non_int=
eractive)<br>
+=C2=A0 =C2=A0 upstream_config[&#39;non-interactive-cmdline-options&#39;] =
=3D &quot; &quot;.join([upstream_config[&#39;name&#39;], upstream_config[&#=
39;bitbake-config&#39;][&#39;name&#39;]] + sorted(upstream_config[&#39;bitb=
ake-config&#39;][&#39;oe-fragment-choices&#39;].values()))<br>
+=C2=A0 =C2=A0 upstream_config[&#39;source-overrides&#39;] =3D source_overr=
ides<br>
+=C2=A0 =C2=A0 return upstream_config<br>
+<br>
+def init_config(settings, args, d):<br>
+=C2=A0 =C2=A0 stdout =3D sys.stdout<br>
+=C2=A0 =C2=A0 def handle_task_progress(event, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rate =3D event.rate if event.rate else &#39;&#=
39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 progress =3D event.progress if event.progress =
&gt; 0 else 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;{}% {}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;.format(progress, rate), file=3Dstdout, e=
nd=3D&#39;\r&#39;)<br>
+<br>
+=C2=A0 =C2=A0 source_overrides =3D json.load(open(args.source_overrides)) =
if args.source_overrides else {&#39;sources&#39;:{}}<br>
+=C2=A0 =C2=A0 upstream_config =3D obtain_config(settings, args, source_ove=
rrides, d)<br>
+=C2=A0 =C2=A0 print(&quot;Run &#39;bitbake-setup {}&#39; to select this co=
nfiguration non-interactively.&quot;.format(upstream_config[&#39;non-intera=
ctive-cmdline-options&#39;]))<br>
+<br>
+=C2=A0 =C2=A0 builddir =3D os.path.join(os.path.abspath(args.top_dir), ups=
tream_config[&#39;non-interactive-cmdline-options&#39;].replace(&quot; &quo=
t;,&quot;-&quot;).replace(&quot;/&quot;,&quot;_&quot;))<br>
+=C2=A0 =C2=A0 if os.path.exists(builddir):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Build already initialized in {}\nU=
se &#39;bitbake-setup status&#39; to check if it needs to be updated or &#3=
9;bitbake-setup update&#39; to perform the update.&quot;.format(builddir))<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 print(&quot;Initializing a build in {}&quot;.format(builddir=
))<br>
+<br>
+=C2=A0 =C2=A0 os.makedirs(builddir)<br>
+<br>
+=C2=A0 =C2=A0 confdir =3D os.path.join(builddir, &quot;config&quot;)<br>
+=C2=A0 =C2=A0 layerdir =3D os.path.join(builddir, &quot;layers&quot;)<br>
+<br>
+=C2=A0 =C2=A0 os.makedirs(confdir)<br>
+=C2=A0 =C2=A0 os.makedirs(layerdir)<br>
+<br>
+=C2=A0 =C2=A0 bb.process.run(&quot;git -C {} init -b main&quot;.format(con=
fdir))<br>
+=C2=A0 =C2=A0 bb.process.run(&quot;git -C {} commit --allow-empty -m &#39;=
Initial commit&#39;&quot;.format(confdir))<br>
+<br>
+=C2=A0 =C2=A0 bb.event.register(&quot;bb.build.TaskProgress&quot;, handle_=
task_progress, data=3Dd)<br>
+<br>
+=C2=A0 =C2=A0 write_config(upstream_config, confdir)<br>
+=C2=A0 =C2=A0 commit_config(confdir)<br>
+=C2=A0 =C2=A0 update_build(upstream_config, confdir, builddir, layerdir, d=
)<br>
+<br>
+=C2=A0 =C2=A0 bb.event.remove(&quot;bb.build.TaskProgress&quot;, None)<br>
+<br>
+def get_diff(file1, file2):<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.process.run(&#39;diff -uNr {} {}&#39;.forma=
t(file1, file2))<br>
+=C2=A0 =C2=A0 except bb.process.ExecutionError as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if e.exitcode =3D=3D 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return e.stdout<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise e<br>
+=C2=A0 =C2=A0 return None<br>
+<br>
+def are_layers_changed(layers, layerdir, d):<br>
+=C2=A0 =C2=A0 changed =3D False<br>
+=C2=A0 =C2=A0 for r_name in layers:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r_data =3D layers[r_name]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 repodir =3D r_data[&quot;path&quot;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r_remote =3D r_data[&#39;git-remote&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rev =3D r_remote[&#39;rev&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 remotes =3D r_remote[&#39;remotes&#39;]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for remote in remotes:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type,host,path,user,pswd,params =
=3D bb.fetch.decodeurl(remotes[remote][&quot;uri&quot;])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetchuri =3D bb.fetch.encodeurl(=
(&#39;git&#39;,host,path,user,pswd,params))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher =3D bb.fetch.FetchData(&=
quot;{};protocol=3D{};rev=3D{};nobranch=3D1;destsuffix=3D{}&quot;.format(fe=
tchuri,type,rev,repodir), d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upstream_revision =3D fetcher.me=
thod.latest_revision(fetcher, d, &#39;default&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rev_parse_result =3D bb.process.=
run(&#39;git -C {} rev-parse HEAD&#39;.format(os.path.join(layerdir, repodi=
r)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 local_revision =3D rev_parse_res=
ult[0].strip()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if upstream_revision !=3D local_=
revision:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 changed =3D True<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&#39;Layer r=
epository {} checked out into {} updated revision {} from {} to {}&#39;.for=
mat(remotes[remote][&quot;uri&quot;], os.path.join(layerdir, repodir), rev,=
 local_revision, upstream_revision))<br>
+<br>
+=C2=A0 =C2=A0 return changed<br>
+<br>
+def build_status(settings, args, d, update=3DFalse):<br>
+=C2=A0 =C2=A0 builddir =3D args.build_dir<br>
+<br>
+=C2=A0 =C2=A0 confdir =3D os.path.join(builddir, &quot;config&quot;)<br>
+=C2=A0 =C2=A0 layerdir =3D os.path.join(builddir, &quot;layers&quot;)<br>
+<br>
+=C2=A0 =C2=A0 current_upstream_config =3D json.load(open(os.path.join(conf=
dir, &quot;config-upstream.json&quot;)))<br>
+<br>
+=C2=A0 =C2=A0 args.config =3D current_upstream_config[&#39;non-interactive=
-cmdline-options&#39;].split()<br>
+=C2=A0 =C2=A0 args.non_interactive =3D True<br>
+=C2=A0 =C2=A0 source_overrides =3D current_upstream_config[&quot;source-ov=
errides&quot;]<br>
+=C2=A0 =C2=A0 new_upstream_config =3D obtain_config(settings, args, source=
_overrides, d)<br>
+<br>
+=C2=A0 =C2=A0 write_config(new_upstream_config, confdir)<br>
+=C2=A0 =C2=A0 config_diff =3D bb.process.run(&#39;git -C {} diff&#39;.form=
at(confdir))[0]<br>
+<br>
+=C2=A0 =C2=A0 if config_diff:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&#39;Configuration in {} has changed:\n{=
}&#39;.format(builddir, config_diff))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if update:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 commit_config(confdir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_build(new_upstream_config=
, confdir, builddir, layerdir, d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bb.process.run(&#39;git -C {} re=
store config-upstream.json&#39;.format(confdir))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 if are_layers_changed(current_upstream_config[&quot;data&quo=
t;][&quot;sources&quot;], layerdir, d):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if update:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_build(current_upstream_co=
nfig, confdir, builddir, layerdir, d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+<br>
+=C2=A0 =C2=A0 print(&quot;Configuration in {} has not changed.&quot;.forma=
t(builddir))<br>
+<br>
+def build_update(settings, args, d):<br>
+=C2=A0 =C2=A0 build_status(settings, args, d, update=3DTrue)<br>
+<br>
+def do_fetch(fetcher, dir):<br>
+=C2=A0 =C2=A0 # git fetcher simply dumps git output to stdout; in bitbake =
context that is redirected to temp/log.do_fetch<br>
+=C2=A0 =C2=A0 # and we need to set up smth similar here<br>
+=C2=A0 =C2=A0 fetchlogdir =3D os.path.join(dir, &#39;logs&#39;)<br>
+=C2=A0 =C2=A0 os.makedirs(fetchlogdir, exist_ok=3DTrue)<br>
+=C2=A0 =C2=A0 fetchlog =3D os.path.join(fetchlogdir, &#39;fetch_log.{}&#39=
;.format(datetime.datetime.now().strftime(&quot;%Y%m%d%H%M%S&quot;)))<br>
+=C2=A0 =C2=A0 with open(fetchlog, &#39;a&#39;) as f:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 oldstdout =3D sys.stdout<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.stdout =3D f<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.download()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 fetcher.unpack(dir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.stdout =3D oldstdout<br>
+<br>
+def update_registry(registry, cachedir, d):<br>
+=C2=A0 =C2=A0 registrydir =3D &#39;configurations&#39;<br>
+=C2=A0 =C2=A0 full_registrydir =3D os.path.join(cachedir, registrydir)<br>
+=C2=A0 =C2=A0 print(&quot;Fetching configuration registry {} into {}&quot;=
.format(registry, full_registrydir))<br>
+=C2=A0 =C2=A0 fetcher =3D bb.fetch.Fetch([&quot;{};destsuffix=3D{}&quot;.f=
ormat(registry, registrydir)], d)<br>
+=C2=A0 =C2=A0 do_fetch(fetcher, cachedir)<br>
+=C2=A0 =C2=A0 return full_registrydir<br>
+<br>
+def has_expired(expiry_date):<br>
+=C2=A0 =C2=A0 if expiry_date:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return datetime.datetime.now() &gt; datetime.d=
atetime.fromisoformat(expiry_date)<br>
+=C2=A0 =C2=A0 return False<br>
+<br>
+def list_registry(registry_path, with_expired):<br>
+=C2=A0 =C2=A0 json_data =3D {}<br>
+<br>
+=C2=A0 =C2=A0 for root, dirs, files in os.walk(registry_path):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for f in files:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f.endswith(&#39;.conf.json&#3=
9;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_name =3D ge=
t_config_name(f)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_data =3D js=
on.load(open(os.path.join(root, f)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 config_desc =3D co=
nfig_data[&quot;description&quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expiry_date =3D co=
nfig_data.get(&quot;expires&quot;, None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if expiry_date:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if w=
ith_expired or not has_expired(expiry_date):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 json_data[config_name] =3D {&quot;description&quot;: config_desc=
, &quot;expires&quot;: expiry_date}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 json=
_data[config_name] =3D {&quot;description&quot;: config_desc}<br>
+=C2=A0 =C2=A0 return json_data<br>
+<br>
+def list_configs(settings, args, d):<br>
+=C2=A0 =C2=A0 registry_path =3D update_registry(settings[&quot;default&quo=
t;][&quot;registry&quot;], cache_dir(args.top_dir), d)<br>
+=C2=A0 =C2=A0 json_data =3D list_registry(registry_path, args.with_expired=
)<br>
+=C2=A0 =C2=A0 print(&quot;\nAvailable configurations:&quot;)<br>
+=C2=A0 =C2=A0 for config_name, config_data in json_data.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 expiry_date =3D config_data.get(&quot;expires&=
quot;, None)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 config_desc =3D config_data[&quot;description&=
quot;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if expiry_date:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if args.with_expired or not has_e=
xpired(expiry_date):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;{}\t{} =
(supported until {})&quot;.format(config_name, config_desc, expiry_date))<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print(&quot;{}\t{}&quot;.format(c=
onfig_name, config_desc))<br>
+=C2=A0 =C2=A0 print(&quot;\nRun &#39;init&#39; with one of the above confi=
guration identifiers to set up a build.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 if args.write_json:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(args.write_json, &#39;w&#39;) as f:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 json.dump(json_data, f, sort_key=
s=3DTrue, indent=3D4)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Available configurations written i=
nto {}&quot;.format(args.write_json))<br>
+<br>
+def default_settings_path(top_dir):<br>
+=C2=A0 =C2=A0 return os.path.join(top_dir, &#39;bitbake-setup.conf&#39;)<b=
r>
+<br>
+def write_settings(top_dir, force_replace):<br>
+=C2=A0 =C2=A0 settings_path =3D default_settings_path(top_dir)<br>
+=C2=A0 =C2=A0 if not os.path.exists(settings_path) or force_replace:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(settings_path):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backup_conf =3D settings_path + =
&quot;-backup.{}&quot;.format(time.strftime(&quot;%Y%m%d%H%M%S&quot;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.rename(settings_path, backup_=
conf)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Previous settings ar=
e in {}&quot;.format(backup_conf))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 settings =3D configparser.ConfigParser()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 settings[&#39;default&#39;] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;registry&#39;:default_registry,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;dl-dir&#39;:os.path.join(top_dir, &#39;=
.bitbake-setup-downloads&#39;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.makedirs(os.path.dirname(settings_path), ex=
ist_ok=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with open(settings_path, &#39;w&#39;) as setti=
ngsfile:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 settings.write(settingsfile)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&#39;Created a new settings file in {}.\=
n&#39;.format(settings_path))<br>
+<br>
+def load_settings(top_dir):<br>
+=C2=A0 =C2=A0 # This creates a new settings file if it does not yet exist<=
br>
+=C2=A0 =C2=A0 write_settings(top_dir, force_replace=3DFalse)<br>
+<br>
+=C2=A0 =C2=A0 settings_path =3D default_settings_path(top_dir)<br>
+=C2=A0 =C2=A0 settings =3D configparser.ConfigParser()<br>
+=C2=A0 =C2=A0 print(&#39;Loading settings from {}\n&#39;.format(settings_p=
ath))<br>
+=C2=A0 =C2=A0 settings.read([settings_path])<br>
+=C2=A0 =C2=A0 return settings<br>
+<br>
+def change_settings(top_dir, new_settings):<br>
+=C2=A0 =C2=A0 # This creates a new settings file if it does not yet exist<=
br>
+=C2=A0 =C2=A0 write_settings(top_dir, force_replace=3DFalse)<br>
+<br>
+=C2=A0 =C2=A0 settings =3D load_settings(top_dir)<br>
+=C2=A0 =C2=A0 for section, section_settings in new_settings.items():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for setting, value in section_settings.items()=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 settings[section][setting] =3D v=
alue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Setting &#39;{}&#39;=
 in section &#39;{}&#39; is changed to &#39;{}&#39;&quot;.format(setting, s=
ection, value))<br>
+<br>
+=C2=A0 =C2=A0 settings_path =3D default_settings_path(top_dir)<br>
+=C2=A0 =C2=A0 with open(settings_path, &#39;w&#39;) as settingsfile:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 settings.write(settingsfile)<br>
+=C2=A0 =C2=A0 print(&quot;New settings written to {}&quot;.format(settings=
_path))<br>
+=C2=A0 =C2=A0 return settings<br>
+<br>
+def get_build_dir_via_bbpath():<br>
+=C2=A0 =C2=A0 bbpath =3D os.environ.get(&#39;BBPATH&#39;)<br>
+=C2=A0 =C2=A0 if bbpath:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bitbake_dir =3D os.path.normpath(bbpath.split(=
&#39;:&#39;)[0])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(os.path.join(bitbake_dir,&#3=
9;init-build-env&#39;)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 build_dir =3D os.path.dirname(bi=
tbake_dir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return build_dir<br>
+=C2=A0 =C2=A0 return None<br>
+<br>
+def get_default_top_dir():<br>
+=C2=A0 =C2=A0 build_dir_via_bbpath =3D get_build_dir_via_bbpath()<br>
+=C2=A0 =C2=A0 if build_dir_via_bbpath:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 top_dir =3D os.path.dirname(build_dir_via_bbpa=
th)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.path.exists(default_settings_path(top_di=
r)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return top_dir<br>
+=C2=A0 =C2=A0 return os.environ.get(&#39;BITBAKE_SETUP_TOP_DIR&#39;) or os=
.path.join(os.path.expanduser(&#39;~&#39;), &#39;bitbake-builds&#39;)<br>
+<br>
+def main():<br>
+=C2=A0 =C2=A0 def add_top_dir_arg(parser):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_argument(&#39;--top-dir&#39;, defau=
lt=3Dget_default_top_dir(), help=3D&#39;Top level directory where builds ar=
e set up and downloaded configurations and layers are cached for reproducib=
ility and offline builds, default is %(default)s, can be overriden via BITB=
AKE_SETUP_TOP_DIR environment variable&#39;)<br>
+<br>
+=C2=A0 =C2=A0 def add_build_dir_arg(parser):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 build_dir =3D get_build_dir_via_bbpath()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if build_dir:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_argument(&#39;--build=
-dir&#39;, default=3Dbuild_dir, help=3D&quot;Path to the build, default is =
%(default)s via BBPATH&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.add_argument(&#39;--build=
-dir&#39;, required=3DTrue, help=3D&quot;Path to the build&quot;)<br>
+<br>
+=C2=A0 =C2=A0 parser =3D argparse.ArgumentParser(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 description=3D&quot;BitBake setup utility. Run=
 with &#39;init&#39; argument to get started.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 epilog=3D&quot;Use %(prog)s &lt;subcommand&gt;=
 --help to get help on a specific command&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 parser.add_argument(&#39;-d&#39;, &#39;--debug&#39;, help=3D=
&#39;Enable debug output&#39;, action=3D&#39;store_true&#39;)<br>
+=C2=A0 =C2=A0 parser.add_argument(&#39;-q&#39;, &#39;--quiet&#39;, help=3D=
&#39;Print only errors&#39;, action=3D&#39;store_true&#39;)<br>
+=C2=A0 =C2=A0 parser.add_argument(&#39;--color&#39;, choices=3D[&#39;auto&=
#39;, &#39;always&#39;, &#39;never&#39;], default=3D&#39;auto&#39;, help=3D=
&#39;Colorize output (where %(metavar)s is %(choices)s)&#39;, metavar=3D&#3=
9;COLOR&#39;)<br>
+=C2=A0 =C2=A0 parser.add_argument(&#39;--no-network&#39;, action=3D&#39;st=
ore_true&#39;, help=3D&#39;Do not check whether configuration repositories =
and layer repositories have been updated; use only the local cache.&#39;)<b=
r>
+<br>
+=C2=A0 =C2=A0 subparsers =3D parser.add_subparsers()<br>
+<br>
+=C2=A0 =C2=A0 parser_list =3D subparsers.add_parser(&#39;list&#39;, help=
=3D&#39;List available configurations&#39;)<br>
+=C2=A0 =C2=A0 add_top_dir_arg(parser_list)<br>
+=C2=A0 =C2=A0 parser_list.add_argument(&#39;--with-expired&#39;, action=3D=
&#39;store_true&#39;, help=3D&#39;List also configurations that are no long=
er supported due to reaching their end-of-life dates.&#39;)<br>
+=C2=A0 =C2=A0 parser_list.add_argument(&#39;--write-json&#39;, action=3D&#=
39;store&#39;, help=3D&#39;Write available configurations into a json file =
so they can be programmatically processed.&#39;)<br>
+=C2=A0 =C2=A0 parser_list.set_defaults(func=3Dlist_configs)<br>
+<br>
+=C2=A0 =C2=A0 parser_init =3D subparsers.add_parser(&#39;init&#39;, help=
=3D&#39;Select a configuration and initialize a build from it&#39;)<br>
+=C2=A0 =C2=A0 add_top_dir_arg(parser_init)<br>
+=C2=A0 =C2=A0 parser_init.add_argument(&#39;config&#39;, nargs=3D&#39;*&#3=
9;, help=3D&quot;path/URL/id to a configuration file (use &#39;list&#39; co=
mmand to get available ids), followed by configuration options. Bitbake-set=
up will ask to choose from available choices if command line doesn&#39;t co=
mpletely specify them.&quot;)<br>
+=C2=A0 =C2=A0 parser_init.add_argument(&#39;--non-interactive&#39;, action=
=3D&#39;store_true&#39;, help=3D&#39;Do not ask to interactively choose fro=
m available options; if bitbake-setup cannot make a decision it will stop w=
ith a failure.&#39;)<br>
+=C2=A0 =C2=A0 parser_init.add_argument(&#39;--source-overrides&#39;, actio=
n=3D&#39;store&#39;, help=3D&#39;Override sources information (repositories=
/revisions) with values from a local json file.&#39;)<br>
+=C2=A0 =C2=A0 parser_init.set_defaults(func=3Dinit_config)<br>
+<br>
+=C2=A0 =C2=A0 parser_status =3D subparsers.add_parser(&#39;status&#39;, he=
lp=3D&#39;Check if the build needs to be synchronized with configuration&#3=
9;)<br>
+=C2=A0 =C2=A0 add_build_dir_arg(parser_status)<br>
+=C2=A0 =C2=A0 parser_status.set_defaults(func=3Dbuild_status)<br>
+<br>
+=C2=A0 =C2=A0 parser_update =3D subparsers.add_parser(&#39;update&#39;, he=
lp=3D&#39;Update a build to be in sync with configuration&#39;)<br>
+=C2=A0 =C2=A0 add_build_dir_arg(parser_update)<br>
+=C2=A0 =C2=A0 parser_update.set_defaults(func=3Dbuild_update)<br>
+<br>
+=C2=A0 =C2=A0 parser_reset_settings =3D subparsers.add_parser(&#39;reset-s=
ettings&#39;, help=3D&#39;Write a settings file with default values into th=
e top level directory (contains the location of build configuration registr=
y, downloads directory and other global settings)&#39;)<br>
+=C2=A0 =C2=A0 add_top_dir_arg(parser_reset_settings)<br>
+=C2=A0 =C2=A0 parser_reset_settings.set_defaults(func=3Dwrite_settings)<br=
>
+<br>
+=C2=A0 =C2=A0 parser_change_setting =3D subparsers.add_parser(&#39;change-=
setting&#39;, help=3D&#39;Change a setting in the settings file&#39;)<br>
+=C2=A0 =C2=A0 add_top_dir_arg(parser_change_setting)<br>
+=C2=A0 =C2=A0 parser_change_setting.add_argument(&#39;section&#39;, help=
=3D&quot;Section in a settings file, typically &#39;default&#39;&quot;)<br>
+=C2=A0 =C2=A0 parser_change_setting.add_argument(&#39;key&#39;, help=3D&qu=
ot;Name of the setting&quot;)<br>
+=C2=A0 =C2=A0 parser_change_setting.add_argument(&#39;value&#39;, help=3D&=
quot;Value of the setting&quot;)<br>
+=C2=A0 =C2=A0 parser_change_setting.set_defaults(func=3Dchange_settings)<b=
r>
+<br>
+=C2=A0 =C2=A0 args =3D parser.parse_args()<br>
+<br>
+=C2=A0 =C2=A0 logging.basicConfig(stream=3Dsys.stdout)<br>
+=C2=A0 =C2=A0 if args.debug:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.setLevel(logging.DEBUG)<br>
+=C2=A0 =C2=A0 elif args.quiet:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.setLevel(logging.ERROR)<br>
+<br>
+=C2=A0 =C2=A0 # Need to re-run logger_create with color argument<br>
+=C2=A0 =C2=A0 # (will be the same logger since it has the same name)<br>
+=C2=A0 =C2=A0 bb.msg.logger_create(&#39;bitbake-setup&#39;, output=3Dsys.s=
tdout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0color=3Dargs.color,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0level=3Dlogger.getEffectiveLevel())<br>
+<br>
+<br>
+=C2=A0 =C2=A0 if hasattr(args, &#39;build_dir&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not os.path.exists(os.path.join(args.build_=
dir,&#39;build&#39;, &#39;init-build-env&#39;)):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Not a valid build di=
rectory: build/init-build-env does not exist in {}&quot;.format(args.build_=
dir))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # commands without --top-dir argument (status,=
 update) still need to know where<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # the top dir is, but it should be auto-deduce=
d as parent of args.build_dir<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not hasattr(args, &#39;top_dir&#39;):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args.top_dir =3D os.path.dirname=
(os.path.normpath(args.build_dir))<br>
+<br>
+=C2=A0 =C2=A0 if &#39;func&#39; in args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if args.func =3D=3D write_settings:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write_settings(args.top_dir, for=
ce_replace=3DTrue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif args.func =3D=3D change_settings:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 change_settings(args.top_dir, {a=
rgs.section:{args.key:args.value}})<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 settings =3D load_settings(args.=
top_dir)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 d =3D init_bb_cache(settings, ar=
gs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args.func(settings, args, d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 save_bb_cache()<br>
+=C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 from argparse import Namespace<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 parser.print_help()<br>
+<br>
+main()<br>
-- <br>
2.39.5<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#17872): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/17872" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/17872</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/114685174/924=
729" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/mt=
/114685174/924729</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:ticotimo@gmail.com" target=3D"_bla=
nk">ticotimo@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div>

--00000000000068f577063cbee524--

