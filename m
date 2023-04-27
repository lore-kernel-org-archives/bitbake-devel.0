Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE13C77B73
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 19:41:03 +0000 (UTC)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
 by mx.groups.io with SMTP id smtpd.web10.1520.1682624461503335743
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Apr 2023 12:41:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@gmail.com header.s=20221208 header.b=W6dt4REY;
 spf=pass (domain: gmail.com, ip: 209.85.222.44, mailfrom: raj.khem@gmail.com)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-772b550b8f0so5808103241.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Apr 2023 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682624460; x=1685216460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iH3hNTrQCQtlEQs353AFhYVUOQKqIwEnQizdnIexzis=;
        b=W6dt4REYpvnMbRFr5KFaFpl3v4rSwxDsjLREM1ymbvjPu4331XEGaMUiwLitVB78DR
         rYp0Tt2UixpQWG7kZItgsJlXHX/S7Qb6Ci2OcUfZ8SWygWs2lSZKQ49TJ9NuolfWSzeQ
         wVSBO7B3ETtR28EaVqMdY+ygr7gPpZ3yTEuSALA2JjBjSEXOEE/hDmC5e7J6A2eFveUr
         XFUCbGet7m1iz4qbGBnuwz6lPeKY0BsE4vuwgs0qoVGxl6sM90svc4EoKqIIRHw2DF2p
         RIwjn7qDH9EjMC2ZYgrEzGS6bSxfJeA+o42kT/bE9rvbwLXRzLvQqSBD4ghtAU1P/NGH
         b3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682624460; x=1685216460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iH3hNTrQCQtlEQs353AFhYVUOQKqIwEnQizdnIexzis=;
        b=bPkwJWkC5Ze1NRVQ30U18682MCAHin90QmyphpWZUe12zW+OTw++4Eo2NJHrfO8VnG
         Cu4gK+ueW+3W4ipT1Is2mb0RJSVqc862gHXrQK5wfzsQpSAGfWFwm8BVXlmx8HMsV0lC
         acyOBSu2B/IcDoS+1Hyo6BEJ17FcjN+5liRWCj2AukW4Z7jDhrjSkwTAkzgGxza4+eA9
         lBA0sCZj335v2LPCqV+ux5qChAPG9GGRaMk2zwkVAUkSdzEYhl9FhzqOx0/umfhMmFoz
         CnITOaUaRF9QuPtmmRMRDsigLQDp+4ovyaTJEOO8J2xLitKIJf3OJ0yBYV34V1CnEnwo
         OaBQ==
X-Gm-Message-State: AC+VfDz5+xgnxrEvhpAjhUhU0RlwC6SkuOX3OI3jEURgzc45E5NkNRFz
	b1h0reDKPB3K+kaDZv4aT4G45GrDeuX1lKt8J9g=
X-Google-Smtp-Source: ACHHUZ45/PjiRAvylF/66TZ0apFtvc5Xg4GEA4eO6bKcmJJ7F3VqhUi8OIr45YFc9xTjEys8H815k0zQJyOT9hpVZ3o=
X-Received: by 2002:a67:e442:0:b0:42f:fc44:be5d with SMTP id
 n2-20020a67e442000000b0042ffc44be5dmr1669161vsm.27.1682624460285; Thu, 27 Apr
 2023 12:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230420062113.134546-1-alberto@pianon.eu> <CAMKF1sre46PCJrhPcuHzYu8_uLHabY4S_+up5vwvyWnjmSeooA@mail.gmail.com>
 <8dfce9c36a557f67be4dc6d37417ac63@pianon.eu> <afcd01000f265238360efcdaecd16a4e@pianon.eu>
 <CAMKF1srdkydixmdbW4dm8egyNYHOxJ5kGoDtTt-WPB_zyWefig@mail.gmail.com>
 <1759B8A6082B56AB.32698@lists.openembedded.org> <eb69f0d13d5ff7dc8acc987a5344c3fe@pianon.eu>
In-Reply-To: <eb69f0d13d5ff7dc8acc987a5344c3fe@pianon.eu>
From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 27 Apr 2023 12:40:34 -0700
Message-ID: <CAMKF1srvD2ZUcfhYbtMUX=t-p0NjE9nA4mdS1bASwWo3v6yrfQ@mail.gmail.com>
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
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Apr 2023 19:41:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14755

On Thu, Apr 27, 2023 at 7:10=E2=80=AFAM Alberto Pianon <alberto@pianon.eu> =
wrote:
>
> Hi Khem,
>
> Il 2023-04-27 09:02 Alberto Pianon ha scritto:
>
>      Il 2023-04-27 08:56 Khem Raj ha scritto:
>
>          On Wed, Apr 26, 2023 at 10:19=E2=80=AFPM Alberto Pianon
> <alberto@pianon.eu> wrote:
>
>
>              Il 2023-04-27 07:14 Alberto Pianon ha scritto:
>
>                  Could you please check if this is really the case in
> your case?
>                  You'd need to go to
> meta/recipes-sato/matchbox-panel-2/files
>                  (check where the layer is located in your filesystem)
> and do
>
>
>              Of course it is located at
>              /mnt/b/yoe/master/sources/poky/meta/recipes-sato/m
>
> atchbox-panel-2/files/0001-applets-systray-Allow-icons-to-be-smaller.patc=
h
>
>              :)
>
>              Please check also the other two files for which you get the
> warnings
>
>
>          My distro uses git submodules at top level and poky is a
> submodule see
>          https://github.com/yoedistro/yoe-distro
>
>          git rev-parse --is-inside-work-tree
>          true
>
>          % git status
>          HEAD detached at 5a944d32a1
>          nothing to commit, working tree clean
>
>
>
>      so something's wrong... I'll build your distro and try to find the
> problem
>      thanks
>
>
> first of all kudos for Yoe, it's one of the simpler-to-build distros I
> ever tried, it seems you did a very good job there :)
>
> BTW, I couldn't reproduce the problem, since I don't get any warning
> message, and the upstream sources are correctly identified, eg. in
> build/tmp/work/cortexa72-yoe-linux/matchbox-keyboard/0.1.1-r0/temp/matchb=
ox-keyboard-0.1.1.unpack.trace.json.zst
> I find:
>
>
> "git+https://github.com/yoedistro/poky@5a944d32a1e2baff34eb03b07ec094421a=
7a8773#meta/recipes-sato/m
> atchbox-keyboard/files/0001-desktop-file-Hide-the-keyboard-from-app-list.=
patch":
> {
>      "download_location":
> "git+https://github.com/yoedistro/poky@5a944d32a1e2baff34eb03b07ec094421a=
7a8773#meta/recipes-sato/matchbox-keyboard/files/0001-desktop-file-Hide-the=
-keyboard-from-app-list.patch",
>      "src_uri":
> "file://0001-desktop-file-Hide-the-keyboard-from-app-list.patch",
>      "layer": "meta",
>      "files": {
>        "": {
>          "sha1": "856c3f6bf74a1b11e90b0ade0b4aeecbb3babfff",
>          "paths_in_workdir": [
>            "0001-desktop-file-Hide-the-keyboard-from-app-list.patch"
>          ]
>        }
>      }
>    },
>
> ... which is the expected result (while on the same file you get a
> warning that the download_location has not been identified).
>
> Could you please double-check the output of git commands in
> /mnt/b/yoe/master/sources/poky/meta/recipes-sato/matchbox-keyboard/files/
> and in other dirs?

[kraj@apollo /mnt/b/yoe/master/sources/poky/meta/recipes-sato/matchbox-keyb=
oard/files]
% git rev-parse --is-inside-work-tree

true

Secondly, I am building on archlinux which is uptodate as of
yesterday, Default yoe builds in a debian bullseye container
so I wonder if thats what is mattering here. in order to not use
container with yoe add

cp local.sh.example local.sh

and add below line to local.sh

export DOCKER_REPO=3Dnone

Then source envsetup again and build.

>
> Thanks
>
> Alberto

