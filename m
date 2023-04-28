Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBC7C77B61
	for <webhook@archiver.kernel.org>; Fri, 28 Apr 2023 13:48:19 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
 by mx.groups.io with SMTP id smtpd.web10.20247.1682689689986017512
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Apr 2023 06:48:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=cLOUljds;
 spf=pass (domain: gmail.com, ip: 209.85.222.49, mailfrom: raj.khem@gmail.com)
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7782debbc4bso6379839241.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Apr 2023 06:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682689689; x=1685281689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU8wgx7hZNYx6u8kUwKhHK/8av6jy2g4aCHgeL9i+Ug=;
        b=cLOUljdsQsa13u2PZYp2Wpt5ACKCP67/zAXc0tvl6hz9zc/bDYPbyq1Qre5LLdsbwW
         ViIQ3ut8+caMmJL4uUbena4RI8qjhQWRMhXum11XI+GvQxAITpVVmh/cm15joEq8O7mR
         PX/435kIUNoa3IacBxvttoOUloPJfbZmWU5Z6Qfp/gBH/2pUOQ0od/Z9B3kSnmyQH+xb
         PNcTKPbNiwewquPp14SIcEJW8RG2JKR7YRT9TmFbhRGIOiOPwI8toulhBqsqeF3B3GcT
         vOqMxwlTv5oVgqC02HN23LM6/J5ZPX8/WaBgMKG3mpi7dN1WAy3ypOS+JCG8Qw78148i
         V/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682689689; x=1685281689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qU8wgx7hZNYx6u8kUwKhHK/8av6jy2g4aCHgeL9i+Ug=;
        b=B5uN8zYX82svwSHEDeJQYjPSmvm7I29VAweEa7mqbGXqkZs8LNjYRdxmeeJMFEJxl4
         uQS7HBNBuQWa+1E750Mn14/gjZGJRKU12BWr/R9Zc6JTn4NnR9N+glpu3pO0B1GTTcYW
         xBDe0jbR7by5ZsISWpMInWbXmkHtL1+rjyueVJWLQURcFshdGFFkwDB0S7XuyhavV2yw
         DzuyRj0ZDQQNzRR+QCVk/t9HQswGq1oZa+qIPSYevnvtj7RobpoSvNcDLpbXynsqzW69
         4+3bEeFJ/3ndzWGda4eQdt54CcHsgnoB1LoUnVrvAA2qI9KI/bgfYjGp9RYVdO72TG4T
         d4jA==
X-Gm-Message-State: AC+VfDzujtyOvS/ygF3BkGmleaCT37IE71nhLX/XM48FX26qltgf2Ma1
	aimJj4SMYeG88AfXEh63KnW72soqHYFM52vBtJUmnJ0i
X-Google-Smtp-Source: ACHHUZ6p2+deeKhlLnANMjeKQynDrAG9rYFp5ChgJAqezeQS/xdkagiOqrgj9LxLY/m0uURdmKRW4EohubecMR4DJC4=
X-Received: by 2002:a67:e913:0:b0:42e:3705:17e3 with SMTP id
 c19-20020a67e913000000b0042e370517e3mr2730655vso.35.1682689688792; Fri, 28
 Apr 2023 06:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230420062113.134546-1-alberto@pianon.eu> <CAMKF1sre46PCJrhPcuHzYu8_uLHabY4S_+up5vwvyWnjmSeooA@mail.gmail.com>
 <8dfce9c36a557f67be4dc6d37417ac63@pianon.eu> <afcd01000f265238360efcdaecd16a4e@pianon.eu>
 <CAMKF1srdkydixmdbW4dm8egyNYHOxJ5kGoDtTt-WPB_zyWefig@mail.gmail.com>
 <1759B8A6082B56AB.32698@lists.openembedded.org> <eb69f0d13d5ff7dc8acc987a5344c3fe@pianon.eu>
 <CAMKF1srvD2ZUcfhYbtMUX=t-p0NjE9nA4mdS1bASwWo3v6yrfQ@mail.gmail.com> <f831364c9b14ac92d527b04fe82713dc@pianon.eu>
In-Reply-To: <f831364c9b14ac92d527b04fe82713dc@pianon.eu>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 28 Apr 2023 06:47:42 -0700
Message-ID: <CAMKF1sqwNtQj0c7MhQWzrn+Kkiv5zptf52kktUUqENUUS1sKmg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] upstream source tracing: data collection
 (patch 2/3)
To: Alberto Pianon <alberto@pianon.eu>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org, 
	jpewhacker@gmail.com, carlo@piana.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Apr 2023 13:48:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14757

On Fri, Apr 28, 2023 at 12:47=E2=80=AFAM Alberto Pianon <alberto@pianon.eu>=
 wrote:
>
>
> On 2023-04-27 21:40, Khem Raj wrote:
> > On Thu, Apr 27, 2023 at 7:10=E2=80=AFAM Alberto Pianon <alberto@pianon.=
eu>
> > wrote:
> >>
> >> Hi Khem,
> >>
> >> Il 2023-04-27 09:02 Alberto Pianon ha scritto:
> >>
> >>      Il 2023-04-27 08:56 Khem Raj ha scritto:
> >>
> >>          On Wed, Apr 26, 2023 at 10:19=E2=80=AFPM Alberto Pianon
> >> <alberto@pianon.eu> wrote:
> >>
> >>
> >>              Il 2023-04-27 07:14 Alberto Pianon ha scritto:
> >>
> >>                  Could you please check if this is really the case in
> >> your case?
> >>                  You'd need to go to
> >> meta/recipes-sato/matchbox-panel-2/files
> >>                  (check where the layer is located in your filesystem)
> >> and do
> >>
> >>
> >>              Of course it is located at
> >>              /mnt/b/yoe/master/sources/poky/meta/recipes-sato/m
> >>
> >> atchbox-panel-2/files/0001-applets-systray-Allow-icons-to-be-smaller.p=
atch
> >>
> >>              :)
> >>
> >>              Please check also the other two files for which you get
> >> the
> >> warnings
> >>
> >>
> >>          My distro uses git submodules at top level and poky is a
> >> submodule see
> >>          https://github.com/yoedistro/yoe-distro
> >>
> >>          git rev-parse --is-inside-work-tree
> >>          true
> >>
> >>          % git status
> >>          HEAD detached at 5a944d32a1
> >>          nothing to commit, working tree clean
> >>
> >>
> >>
> >>      so something's wrong... I'll build your distro and try to find
> >> the
> >> problem
> >>      thanks
> >>
> >>
> >> first of all kudos for Yoe, it's one of the simpler-to-build distros I
> >> ever tried, it seems you did a very good job there :)
> >>
> >> BTW, I couldn't reproduce the problem, since I don't get any warning
> >> message, and the upstream sources are correctly identified, eg. in
> >> build/tmp/work/cortexa72-yoe-linux/matchbox-keyboard/0.1.1-r0/temp/mat=
chbox-keyboard-0.1.1.unpack.trace.json.zst
> >> I find:
> >>
> >>
> >> "git+https://github.com/yoedistro/poky@5a944d32a1e2baff34eb03b07ec0944=
21a7a8773#meta/recipes-sato/m
> >> atchbox-keyboard/files/0001-desktop-file-Hide-the-keyboard-from-app-li=
st.patch":
> >> {
> >>      "download_location":
> >> "git+https://github.com/yoedistro/poky@5a944d32a1e2baff34eb03b07ec0944=
21a7a8773#meta/recipes-sato/matchbox-keyboard/files/0001-desktop-file-Hide-=
the-keyboard-from-app-list.patch",
> >>      "src_uri":
> >> "file://0001-desktop-file-Hide-the-keyboard-from-app-list.patch",
> >>      "layer": "meta",
> >>      "files": {
> >>        "": {
> >>          "sha1": "856c3f6bf74a1b11e90b0ade0b4aeecbb3babfff",
> >>          "paths_in_workdir": [
> >>            "0001-desktop-file-Hide-the-keyboard-from-app-list.patch"
> >>          ]
> >>        }
> >>      }
> >>    },
> >>
> >> ... which is the expected result (while on the same file you get a
> >> warning that the download_location has not been identified).
> >>
> >> Could you please double-check the output of git commands in
> >> /mnt/b/yoe/master/sources/poky/meta/recipes-sato/matchbox-keyboard/fil=
es/
> >> and in other dirs?
> >
> > [kraj@apollo
> > /mnt/b/yoe/master/sources/poky/meta/recipes-sato/matchbox-keyboard/file=
s]
> > % git rev-parse --is-inside-work-tree
> >
> > true
> >
> > Secondly, I am building on archlinux which is uptodate as of
> > yesterday, Default yoe builds in a debian bullseye container
> > so I wonder if thats what is mattering here. in order to not use
> > container with yoe add
> >
> > cp local.sh.example local.sh
> >
> > and add below line to local.sh
> >
> > export DOCKER_REPO=3Dnone
> >
> > Then source envsetup again and build.
> >
>
> I tried that, but I got the same (good) results, I get none of the
> warnings you are getting. I'm on Ubuntu 22.04 though... which archlinux
> version are you on?

arch is a rolling distro i am uptodate as of today

