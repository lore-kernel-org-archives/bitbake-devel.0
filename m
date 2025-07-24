Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745A7C83F26
	for <webhook@archiver.kernel.org>; Thu, 24 Jul 2025 09:00:02 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.8092.1753347593756177458
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Jul 2025 01:59:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=p/GlBaoE;
 spf=pass (domain: smile.fr, ip: 209.85.221.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a503d9ef59so457308f8f.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Jul 2025 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1753347592; x=1753952392; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4314eYNyaF7jeWdA6j88pwSIZukzL8FQ4ijbxd3i14E=;
        b=p/GlBaoE+0R0Sy3rNu4hERRrNL4pv775Iu4rmQfM3K1T16mmAOTSWV0jbi30DnpAbI
         udjYjA+IdtiWR/6/RgDbjBh7pJ8OEmqCGf6A8bPZ4EahMdsJuxa8XuQxdMFAN7Jym5qb
         fdk6WZwnWgx6WumqJdpPRWSdydKgkSrn1Qs+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753347592; x=1753952392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4314eYNyaF7jeWdA6j88pwSIZukzL8FQ4ijbxd3i14E=;
        b=dVuu1TWeaZbbxARPg4x7HvJPIq7Xh55suLhfeP61zzEGOWwOg1rZL9AcuCTnigKS9e
         ei0oAzW+FUWaGG6SvcIMVK2SvHcW2os7ImK+7pIinYRTPtarW+4LNcmVU/qKF2EMUsp7
         y6QQ/TA/D3qqpQqrGPlgVUmNQuI7398g+bFs3QLYMMtBZV9iNVhQmbX/3CfgxYntascO
         bWz1c7G8Gc59BDP6xI6UhlkbKWwouYwpCt7zt7q0PuGY5+B487nvUrDhcd3vsf4LQoV4
         zQphrJ3PQnT3da+fDpfSMyZJDYF9r9aW0RFeKb0lJTlMfsy/6wOMUn2uL+Eeis0Lvlit
         YQSQ==
X-Gm-Message-State: AOJu0Yx1LNA2WMDo3t6q6G857pq2mtQgHNsL2NgO+YA9mQR3XNgMKER/
	ggPiET5Yrh8LTVmQXMyi29j1/9B2C/yK+TqiqzG6pmg1Bg9q4vuxEglEvX7KLkFmad66DTFeVwe
	DBAQQxTpjupUO+kNsztxXZ0sKbtzY49aNLmzU0QsmNQ==
X-Gm-Gg: ASbGncuHYef1f8OnyCLkccFrXpGItmDW9ZgsEALRGU73nFMJJLjue29ZcG2kMkP13H/
	pMnY3gDZ5BFbjrP2WDFX8JP6tQJpNExTngl/8W+dUvQNEsHevNpxvL6oDRVVZD77u42D/9dqXf/
	XeX1LpZhiZdR9I2FIvhGHxnh27eywatt7lP/Zg/q/tUXDel0s9xlZD8FVQssCD84LW6uEBquf19
	sRmKEkU4w==
X-Google-Smtp-Source: AGHT+IF9Yd37WXlPw6bOqGuygDq74Eiah7SajU2UNnu24xNqj/e3JTc8M4uBkp2UOVJovXQ3p+Y+tQj1b7XNhk62Umo=
X-Received: by 2002:a05:6000:3105:b0:3b6:1a2b:d11b with SMTP id
 ffacd0b85a97d-3b768f270d4mr5954302f8f.48.1753347591462; Thu, 24 Jul 2025
 01:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250630101828.3109911-1-alex.kanavin@gmail.com>
In-Reply-To: <20250630101828.3109911-1-alex.kanavin@gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 24 Jul 2025 10:59:25 +0200
X-Gm-Features: Ac12FXy35t6UzCWRsuAeJiqR0Imdhpt0NRePvohammu9ifBv79fFMR5SdY9kja4
Message-ID: <CAMSfU+7CQaNKDbJyu8NY6VKC=K-M2vVmgO1UxB2HvRSe5zWuhg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake-setup: add the initial implementation
To: alex.kanavin@gmail.com
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: multipart/alternative; boundary="0000000000005b7e3b063aa90c8f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Jul 2025 09:00:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17807

--0000000000005b7e3b063aa90c8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 30 juin 2025 =C3=A0 12:18, Alexander Kanavin via lists.openembedded=
.org
<alex.kanavin=3Dgmail.com@lists.openembedded.org> a =C3=A9crit :

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
> - base bitbake configs (a way to declare the common parts between several
> bitbake build configurations just once, like a parent 'class')
> (this is inspired by a similar mechannism in yocto-autobuilder)
>
> - official configuration repository (this probably depends on oe-core bei=
ng
> populated with a rich, useful set of fragments, and providing sstate for
> official configurations)
>
> - documentation
>
> Amble *scratch* HOWTO
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1. If you don't know where to start, list available configurations, and
> pick one:
>
> =3D=3D=3D
> alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup list
> Created a new settings file in
> /home/alex/bitbake-builds/bitbake-setup.conf.
>
> Loading settings from /home/alex/bitbake-builds/bitbake-setup.conf.
>
> Fetching configuration registry git://
> github.com/kanavin/bitbake-setup-configurations.git;protocol=3Dhttps;bran=
ch=3Dmain;rev=3Dmain
> into /home/alex/bitbake-builds/.bitbake-setup-cache/configurations
>
> Available configurations:
> poky-alex       Poky reference distribution, with alex fixes
> poky-kirkstone  Poky reference distribution, kirkstone long term support
> release (supported until April 2026)
> poky-ng Poky-ng configuration: like poky but built from individual
> repositories
>
> Run 'init' with one of the above configuration identifiers to set up a
> build.
> =3D=3D=3D
>
> 2. Then build is initialized this way:
> =3D=3D=3D
> alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup init poky-alex
> Loading settings from /home/alex/bitbake-builds/bitbake-setup.conf.
>
> Initializing a poky-alex build in /home/alex/bitbake-builds/poky-alex
> Fetching configuration registry git://
> github.com/kanavin/bitbake-setup-configurations.git;protocol=3Dhttps;bran=
ch=3Dmain;rev=3Dmain
> into /home/alex/bitbake-builds/.bitbake-setup-cache/configurations
> Fetching layer/tool repository poky into
> /home/alex/bitbake-builds/poky-alex/layers/poky
> Fetching layer/tool repository meta-alex into
> /home/alex/bitbake-builds/poky-alex/layers/meta-alex
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> Setting up bitbake configuration gadget in
> /home/alex/bitbake-builds/poky-alex/build-gadget
> Bitbake configuration summary: This configuration is intended for buildin=
g
> gadget.
> Usage instructions and additional information in
> /home/alex/bitbake-builds/poky-alex/build-gadget/README
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> Setting up bitbake configuration gizmo in
> /home/alex/bitbake-builds/poky-alex/build-gizmo
> Bitbake configuration summary: This configuration is intended for buildin=
g
> gizmo.
> Usage instructions and additional information in
> /home/alex/bitbake-builds/poky-alex/build-gizmo/README
> =3D=3D=3D
>
> Note: 'init' sub-command can also take a path or a URL with a
> configuration file directly.
> You can see how those files look like here:
> https://github.com/kanavin/bitbake-setup-configurations
>
> 3. The above message refers to a one-liner shell script that would build
> the targets
> specified in the chosen configuration:
> =3D=3D=3D
> alex@Zen2:/srv/work/alex/bitbake$ cat
> /home/alex/builds/poky-alex/build-gadget/build-targets
> . /home/alex/builds/poky-alex/build-gadget/init-build-env && bitbake
> core-image-minimal
> =3D=3D=3D
>
> 4. You can also source the bitbake environment, and then subsequent
> status/update commands
> will not require a --build-dir option telling bitbake-setup where the
> initialized build is.
>
> 5. To check if the build configuration needs to be updated, run:
> =3D=3D=3D
> alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup status --build-dir
> ~/bitbake-builds/poky-alex/
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
> 6. If the configuration has changed, you can bring it in sync with:
> =3D=3D=3D
> alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup update -build-dir
> ~/bitbake-builds/poky-alex/
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
> registries). Top directory can be selected by a command line option,
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
> - ' build' means a tree structure set up by 'bitbake-setup init',
> consisting of, at least, a layers checkout, and a set of bitbake
> builds. It maps 1:1 to the json data it was constructed from, which is
> called 'configuration'. Configuration files are either standalone
> files, or are obtained from git repositories called 'config
> registries', in which case they can be listed with 'bitbake-setup
> list'. There can be multiple 'builds' under a top directory. Here's an
> example configuration that showcases this:
>
> https://github.com/kanavin/bitbake-setup-configurations/blob/main/poky-al=
ex.conf.json
>
> - 'bitbake-setup status' will tell if a configuration is in sync with
> the build it was made from. 'bitbake-setup update' will bring a build
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
> This commit includes a fix by Ryan Eatmon <reatmon@ti.com>:
> https://github.com/kanavin/bitbake/pull/1
>
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
>

Hello Alexander,

Here is my attempt at reviewing bitbake-setup. I'll explain how I've tried
to use it, what I found along the way.
I have not (yet) reviewed the code, only the user perspective.

First, I find that this is definitely the right track.
I like how it is based on bitbake tools and not directly writing in .conf
files, that will definitely help maintenance long-term.

Then, here is what I've did: I've try to migrate 2 projects from Cooker (
https://github.com/cpb-/yocto-cooker) to bitbake-setup:
* our contribution project (basically yocto-master but pointed at our
gitlab mirrors)
* a simple existing project of one of our customer (Scarthgap poky.git +
BSP layers + some lib layers, 1 distro, 2 images)

The contribution project migrated quite easily but I was stuck on the
scarthgap project.
The bitbake inside does not have bitbake-config-build which is needed to
configure a build from fragments.
Maybe I could have used the oe-template mechanism instead of the fragments
from config?
I finally (virtually) upgraded the project to master and then, no trouble
to migrate the configuration.

I agree with the need to make some elements common between configurations:
* most config of a project will share the same layer set,
* the "dev" config should inherit the "prod" config, ...
(You mentioned this in your intro)

I think I found 2 bugs:
* Calling "bitbake-setup init non-existing-file.json" will default to
cloning the default registry (where I expected to fail with a error message=
)
* When sh is dash, the init process fail because dash does not support the
source argument:
see https://git.yoctoproject.org/poky/tree/oe-init-build-env#n11
and where the bug is (I guess):
https://github.com/kanavin/bitbake/blob/akanavin/bitbake-setup/bin/bitbake-=
setup#L136

Coming from Cooker, I miss some features (I'll totally accept to be told to
adapt ^^):
* setting bitbake conf variable directly from the config json (but I agree
the fragments are neater)
* Using already checked-out layers : For simple projects, we have the JSON
configuration and the project layers inside the same git repo. IIUC,
bb-setup always does a clone for layers.
Maybe this can be fixed by not handling layers as a "source" and having a
way to add layer to bb configuration by their relative path to the JSON
config (similar to how OEROOT template work?)
* I don't like mixing projects, so that mean I'll use different top-dir for
each. Having to repeat --top-dir everytime is a bit cumbersome, maybe
add an envvar that can change the topdir defaut?

Something not directly related to bb-setup I saw while testing: the
variable history for fragments could maybe be nicer (I'll create a BZ bug
for this.)
 $ bitbake-getvar MACHINE
# $MACHINE [2 operations]
#   set ast.py:367 [check_and_set_builtin_fragment]       <=3D=3D which
fragment? from where?
#     "qemux86-64"
...
# pre-expansion value:
#   "qemux86-64"
MACHINE=3D"qemux86-64"

Finally, a question, how do you recommend to handle my local
SSTATE_DIR/DL_DIR? Setup with bbsetup, copy a site.conf with these config
inside the build, then the proper build? ... or is there a better way?

Sorry for the messy mail, I hope it will be somewhat useful.

Regards,
--=20
Yoann Congal
Smile ECS

--0000000000005b7e3b063aa90c8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0lun. 30 juin 2025 =
=C3=A0=C2=A012:18, Alexander Kanavin via <a href=3D"http://lists.openembedd=
ed.org" target=3D"_blank">lists.openembedded.org</a> &lt;alex.kanavin=3D<a =
href=3D"mailto:gmail.com@lists.openembedded.org" target=3D"_blank">gmail.co=
m@lists.openembedded.org</a>&gt; a =C3=A9crit=C2=A0:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">From: Alexander Kanavin &lt;<a href=3D=
"mailto:alex@linutronix.de" target=3D"_blank">alex@linutronix.de</a>&gt;<br=
>
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
- base bitbake configs (a way to declare the common parts between several b=
itbake build configurations just once, like a parent &#39;class&#39;)<br>
(this is inspired by a similar mechannism in yocto-autobuilder)<br>
<br>
- official configuration repository (this probably depends on oe-core being=
<br>
populated with a rich, useful set of fragments, and providing sstate for<br=
>
official configurations)<br>
<br>
- documentation<br>
<br>
Amble *scratch* HOWTO<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
1. If you don&#39;t know where to start, list available configurations, and=
 pick one:<br>
<br>
=3D=3D=3D<br>
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup list<br>
Created a new settings file in /home/alex/bitbake-builds/bitbake-setup.conf=
.<br>
<br>
Loading settings from /home/alex/bitbake-builds/bitbake-setup.conf.<br>
<br>
Fetching configuration registry git://<a href=3D"http://github.com/kanavin/=
bitbake-setup-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain"=
 rel=3D"noreferrer" target=3D"_blank">github.com/kanavin/bitbake-setup-conf=
igurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain</a> into /home/ale=
x/bitbake-builds/.bitbake-setup-cache/configurations<br>
<br>
Available configurations:<br>
poky-alex=C2=A0 =C2=A0 =C2=A0 =C2=A0Poky reference distribution, with alex =
fixes<br>
poky-kirkstone=C2=A0 Poky reference distribution, kirkstone long term suppo=
rt release (supported until April 2026)<br>
poky-ng Poky-ng configuration: like poky but built from individual reposito=
ries<br>
<br>
Run &#39;init&#39; with one of the above configuration identifiers to set u=
p a build.<br>
=3D=3D=3D<br>
<br>
2. Then build is initialized this way:<br>
=3D=3D=3D<br>
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup init poky-alex<br>
Loading settings from /home/alex/bitbake-builds/bitbake-setup.conf.<br>
<br>
Initializing a poky-alex build in /home/alex/bitbake-builds/poky-alex<br>
Fetching configuration registry git://<a href=3D"http://github.com/kanavin/=
bitbake-setup-configurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain"=
 rel=3D"noreferrer" target=3D"_blank">github.com/kanavin/bitbake-setup-conf=
igurations.git;protocol=3Dhttps;branch=3Dmain;rev=3Dmain</a> into /home/ale=
x/bitbake-builds/.bitbake-setup-cache/configurations<br>
Fetching layer/tool repository poky into /home/alex/bitbake-builds/poky-ale=
x/layers/poky<br>
Fetching layer/tool repository meta-alex into /home/alex/bitbake-builds/pok=
y-alex/layers/meta-alex<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
Setting up bitbake configuration gadget in /home/alex/bitbake-builds/poky-a=
lex/build-gadget<br>
Bitbake configuration summary: This configuration is intended for building =
gadget.<br>
Usage instructions and additional information in /home/alex/bitbake-builds/=
poky-alex/build-gadget/README<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D<br>
Setting up bitbake configuration gizmo in /home/alex/bitbake-builds/poky-al=
ex/build-gizmo<br>
Bitbake configuration summary: This configuration is intended for building =
gizmo.<br>
Usage instructions and additional information in /home/alex/bitbake-builds/=
poky-alex/build-gizmo/README<br>
=3D=3D=3D<br>
<br>
Note: &#39;init&#39; sub-command can also take a path or a URL with a confi=
guration file directly.<br>
You can see how those files look like here:<br>
<a href=3D"https://github.com/kanavin/bitbake-setup-configurations" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/kanavin/bitbake-setup-conf=
igurations</a><br>
<br>
3. The above message refers to a one-liner shell script that would build th=
e targets<br>
specified in the chosen configuration:<br>
=3D=3D=3D<br>
alex@Zen2:/srv/work/alex/bitbake$ cat /home/alex/builds/poky-alex/build-gad=
get/build-targets<br>
. /home/alex/builds/poky-alex/build-gadget/init-build-env &amp;&amp; bitbak=
e core-image-minimal<br>
=3D=3D=3D<br>
<br>
4. You can also source the bitbake environment, and then subsequent status/=
update commands<br>
will not require a --build-dir option telling bitbake-setup where the initi=
alized build is.<br>
<br>
5. To check if the build configuration needs to be updated, run:<br>
=3D=3D=3D<br>
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup status --build-dir ~/bi=
tbake-builds/poky-alex/<br>
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
6. If the configuration has changed, you can bring it in sync with:<br>
=3D=3D=3D<br>
alex@Zen2:/srv/work/alex/bitbake$ bin/bitbake-setup update -build-dir ~/bit=
bake-builds/poky-alex/<br>
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
registries). Top directory can be selected by a command line option,<br>
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
- &#39; build&#39; means a tree structure set up by &#39;bitbake-setup init=
&#39;,<br>
consisting of, at least, a layers checkout, and a set of bitbake<br>
builds. It maps 1:1 to the json data it was constructed from, which is<br>
called &#39;configuration&#39;. Configuration files are either standalone<b=
r>
files, or are obtained from git repositories called &#39;config<br>
registries&#39;, in which case they can be listed with &#39;bitbake-setup<b=
r>
list&#39;. There can be multiple &#39;builds&#39; under a top directory. He=
re&#39;s an<br>
example configuration that showcases this:<br>
<a href=3D"https://github.com/kanavin/bitbake-setup-configurations/blob/mai=
n/poky-alex.conf.json" rel=3D"noreferrer" target=3D"_blank">https://github.=
com/kanavin/bitbake-setup-configurations/blob/main/poky-alex.conf.json</a><=
br>
<br>
- &#39;bitbake-setup status&#39; will tell if a configuration is in sync wi=
th<br>
the build it was made from. &#39;bitbake-setup update&#39; will bring a bui=
ld<br>
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
This commit includes a fix by Ryan Eatmon &lt;<a href=3D"mailto:reatmon@ti.=
com" target=3D"_blank">reatmon@ti.com</a>&gt;:<br>
<a href=3D"https://github.com/kanavin/bitbake/pull/1" rel=3D"noreferrer" ta=
rget=3D"_blank">https://github.com/kanavin/bitbake/pull/1</a><br>
<br>
Signed-off-by: Alexander Kanavin &lt;<a href=3D"mailto:alex@linutronix.de" =
target=3D"_blank">alex@linutronix.de</a>&gt;<br></blockquote><div>=C2=A0</d=
iv><div>Hello Alexander,</div><div><br></div><div>Here is my attempt=C2=A0a=
t reviewing bitbake-setup. I&#39;ll explain how I&#39;ve tried to use it, w=
hat I found along the way.</div><div>I have not (yet) reviewed the code, on=
ly the user perspective.</div><div><br></div><div>First, I find that this i=
s definitely the right track.</div><div>I like how it is based on bitbake t=
ools and not directly writing in .conf files, that will definitely help mai=
ntenance long-term.</div><div><br></div><div>Then, here is what I&#39;ve di=
d: I&#39;ve try to migrate 2 projects from Cooker (<a href=3D"https://githu=
b.com/cpb-/yocto-cooker" target=3D"_blank">https://github.com/cpb-/yocto-co=
oker</a>) to bitbake-setup:</div><div>* our contribution project (basically=
=C2=A0yocto-master but pointed at our gitlab mirrors)</div><div>* a simple =
existing project of one of our customer (Scarthgap poky.git=C2=A0+ BSP laye=
rs=C2=A0+ some lib layers, 1 distro, 2 images)</div><div><br></div><div>The=
 contribution project migrated quite easily but I was stuck on the scarthga=
p project.</div><div>The bitbake inside does not have=C2=A0bitbake-config-b=
uild which is needed to configure a build from fragments.</div><div>Maybe I=
 could have used the oe-template mechanism instead of the fragments from co=
nfig?</div><div>I finally (virtually) upgraded the project to master and th=
en, no trouble to migrate the configuration.</div><div><br></div><div>I agr=
ee with the need to make some elements common between configurations:</div>=
<div>* most config of a project will share the same layer set,</div><div>* =
the &quot;dev&quot; config should inherit the &quot;prod&quot; config, ...<=
/div><div>(You mentioned=C2=A0this in your intro)</div><div><br></div><div>=
I think I found 2 bugs:</div><div>* Calling &quot;bitbake-setup init non-ex=
isting-file.json&quot; will default to cloning the default registry (where =
I expected to fail with a error message)</div><div>* When sh is dash, the i=
nit process fail because dash does not support the source argument:</div><d=
iv>see <a href=3D"https://git.yoctoproject.org/poky/tree/oe-init-build-env#=
n11" target=3D"_blank">https://git.yoctoproject.org/poky/tree/oe-init-build=
-env#n11</a></div><div>and where the bug is (I guess):=C2=A0<a href=3D"http=
s://github.com/kanavin/bitbake/blob/akanavin/bitbake-setup/bin/bitbake-setu=
p#L136" target=3D"_blank">https://github.com/kanavin/bitbake/blob/akanavin/=
bitbake-setup/bin/bitbake-setup#L136</a></div><div><br></div><div>Coming fr=
om=C2=A0Cooker, I miss some features (I&#39;ll totally accept to be told to=
 adapt ^^):</div><div>* setting bitbake conf variable directly from the con=
fig json (but I agree the fragments are neater)</div><div>* Using already c=
hecked-out layers : For simple projects, we have the JSON configuration and=
 the project layers inside the same git repo. IIUC, bb-setup always does a =
clone for layers.</div><div>Maybe this can=C2=A0be fixed by not handling la=
yers as a &quot;source&quot; and having a way to add layer to bb configurat=
ion by their relative path to the JSON config (similar to how OEROOT=C2=A0t=
emplate work?)</div><div>* I don&#39;t like mixing projects, so that mean I=
&#39;ll use different top-dir for each. Having to repeat --top-dir everytim=
e is a bit cumbersome, maybe add=C2=A0an envvar that can change the topdir =
defaut?=C2=A0</div><div><br></div><div>Something not directly related to bb=
-setup I saw while testing: the variable history for fragments could maybe =
be nicer (I&#39;ll create a BZ bug for this.)</div><div>=C2=A0$ bitbake-get=
var MACHINE<br># $MACHINE [2 operations]<br># =C2=A0 set ast.py:367 [check_=
and_set_builtin_fragment]=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;=3D=3D which fragme=
nt? from where?<br># =C2=A0 =C2=A0 &quot;qemux86-64&quot;<br>...<br># pre-e=
xpansion value:<br># =C2=A0 &quot;qemux86-64&quot;<br>MACHINE=3D&quot;qemux=
86-64&quot;</div><div><br></div><div>Finally, a question, how do you recomm=
end to handle my local SSTATE_DIR/DL_DIR? Setup with bbsetup, copy a site.c=
onf with these config inside the build, then the proper build? ... or is th=
ere a better way?</div><div><br></div><div>Sorry for the messy mail, I hope=
 it will be somewhat useful.</div><div><br></div><div>Regards,</div></div><=
span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=
=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"Raleway, regular">Yoann=
 Congal</font><div><font face=3D"Raleway, regular">Smile ECS</font></div></=
div></div></div>
</div>
</div>
</div>
</div>
</div>

--0000000000005b7e3b063aa90c8f--

