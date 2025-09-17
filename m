Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D037CAC59A
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 16:26:04 +0000 (UTC)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
 by mx.groups.io with SMTP id smtpd.web11.28186.1758126360158675988
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 09:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=MDoPufcE;
 spf=softfail (domain: sakoman.com, ip: 209.85.219.169, mailfrom: steve@sakoman.com)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ea5ca8dbd37so3730276.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 09:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1758126359; x=1758731159; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q54rYUJl6Q37ixXaalL7vsDvSE9GYY52rcGZ/5DV7PY=;
        b=MDoPufcEl9sfDUepyOtRlI6ACHWtW8gVmR4x+BR/34ZPlIV5JYYzTbX2kVsR9zgHob
         Gk3vz6PHuoHNM/t7qA73Dro3RlzWYK65hM+jrU4PL7VouKaqP7OjAib8vzeUsJZy40A6
         D0KtuhSqhA8Xy8tbPOlu0KZ9lUbriOBDqFw28v+2Y6/fhfSQcJ+UmwlwFYl4J8qXEiXN
         O1MYe4jt/pOrM7tEaysstH1DQIWV6Fo6p604kFfVu/jWiKzW4MZxWpIVxMhXRA0OsBl4
         ldESQWPzwOjh412356ajmyIpj0OnC3r45nwYjJEuLaQ9a8cMmehnqkBRmfKxtPfcbIvR
         f1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758126359; x=1758731159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q54rYUJl6Q37ixXaalL7vsDvSE9GYY52rcGZ/5DV7PY=;
        b=Tuwi7x6h8Gg4fREEIryyuoMimn3bEdMPfNtSfhFKkHJLCVf4REfFKuAU18rk4xAqOb
         izV+Vx3ZtKGbp3AvS92Dl3boOWgaJHoKmyMVrVnmO1eps9yFX9vVmVSU1Zt15TUbz55f
         KuKyGAO0/YY55YdLWxDcbYZq7XgdQ+TCa7oTOMUhh8/YNmMoLy5bgiYHBhVfdT6gpuSK
         MWdjhfb8fwyEwhUIRqYji3M31kM2tuzD71toZkp4+BPybXdyroRhPHo7zYCns+b7hvUN
         llEvIB9y9qZiN7quZMeifQGVXNCToMEog+zoCC/O27PXU2kgJm8Vp796LCBc1Hk3HiY1
         Hyrw==
X-Forwarded-Encrypted: i=1; AJvYcCXh2TiVcdWMS0bsE2I5PYsgQ5ObF+ChkBNCj2SdnH0/dQreITKJBb/XW08zdIvQ9SFcDhTL4mu0wX9RTL9D@lists.openembedded.org
X-Gm-Message-State: AOJu0YxpHFfk0QH2SyOGO9ZsGdKbZr6JsESvr7hDzFZxcs3IjIgjaozx
	cb/MlKSWdV77faBkMfmxChOQzqLgUulzOheTU2Sw7zGewbDbp4TNaOqX7RET3FHyl2x4Pf1sKma
	so9MlZeDJxqm0t/cqGW9X8daHZjYkuxH9BQa/bwylow==
X-Gm-Gg: ASbGncuKnOSnqVw9lVGsn3L5Z4EjhHkr6ZqEuYFRMKyLvwJOgNNl8/k3CraIpGO5O/d
	lxS4IuGeYjyfi0iSnrEGt1PxvndFS5+xtRIvBdnDv1e0BGm3Qa04T4GvSJZafhj7d/kuKw34m1Y
	zM6lVH/P+N00ZqPYmlViiE5AeDKKBHccATBmpfk/dXOncJnps3aHxyVxXkBzZ5fXsFU+6a69C9Y
	MfWwWm7C4JnSrvMyeB7J8aRCSxC/X+FUovYJfNc9gDFI4wzqQ==
X-Google-Smtp-Source: AGHT+IEpiyTfr9FF3JtMrgDIlvUmHIwg7jYdlB7GcIF17LfVDz9h0DUzlgm1zY54YCLQKAmN/73oLvaT6HIsLt4Se2c=
X-Received: by 2002:a05:6902:4482:b0:ea5:ba20:3e60 with SMTP id
 3f1490d57ef6-ea5c044ce4amr2099302276.31.1758126358997; Wed, 17 Sep 2025
 09:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1757519577.git.steve@sakoman.com> <a7d07075ed20f11a9bc068b495d739cab71b07c6.1757519577.git.steve@sakoman.com>
 <CA+chaQcqqi=Zy1xEgEt1FdnBsH9hVDsskK15T=yUOg0MJ0CbqQ@mail.gmail.com>
 <CAOSpxdbx6NRbf3DJdvDbVQswa839AeMbaD=Uv_5U9BJ-Qg-WRw@mail.gmail.com> <CA+chaQfWY40HZhEiDr9dF5UDCFmQcqjRkxNgCDXFRpTYAPMLRg@mail.gmail.com>
In-Reply-To: <CA+chaQfWY40HZhEiDr9dF5UDCFmQcqjRkxNgCDXFRpTYAPMLRg@mail.gmail.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Wed, 17 Sep 2025 09:25:48 -0700
X-Gm-Features: AS18NWBfpt5iCv5WPURzTrEy4vRzJEl2VJoC91wTrL2J3SbubI2IDRAfcWsB1J0
Message-ID: <CAOSpxdaCKONLXZ-8aYWWb-jha7-P04-MGj1vSLKuZHbod=dFEA@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][walnascar][2.12][PATCH 2/2] bitbake:
 Bump version to 2.12.1
To: Martin Jansa <martin.jansa@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 16:26:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18056

On Wed, Sep 17, 2025 at 7:05=E2=80=AFAM Martin Jansa <martin.jansa@gmail.co=
m> wrote:
>
> I've sent the v2 of all 4 related changes to use 2.12.4 and 2.8.13.
>
> I've also noticed that the sanity check for bitbake version is
> executed too late after the utils.py is already failing with:
> ERROR: Unable to parse oe-core/meta/lib/oe/utils.py
> Traceback (most recent call last):
>   File "oe-core/meta/lib/oe/utils.py", line 11, in <module>
>     from bb import multiprocessing
> ImportError: cannot import name 'multiprocessing' from 'bb'
> (bitbake/lib/bb/__init__.py)
>
> To avoid this issue I recommend to leave "lib/oe/utils: use
> multiprocessing from bb" commit in oe-core scarthgap and walnascar for
> some future batch and now merge just the bitbake version bump in
> bitbake and the requirement for newer bitbake in oe-core, that way
> people will hopefully update both before it gets really mandatory.

I'll be doing the final walnascar build at the end of next week, so we
either need to have this sorted by early next week, or just decide to
leave things as they are with walnascar since it is going end of life.

I'll pull the patches from scarthgap till we sort the proper version
numbering and we can then stage them as you suggest.

Steve

> On Wed, Sep 17, 2025 at 3:57=E2=80=AFPM Steve Sakoman <steve@sakoman.com>=
 wrote:
> >
> > On Wed, Sep 17, 2025 at 12:27=E2=80=AFAM Martin Jansa <martin.jansa@gma=
il.com> wrote:
> > >
> > > Hello Steve,
> > >
> > > I've noticed today that 1.12.3 tag was pushed for current 1.12 branch=
:
> > >
> > > commit 710f98844ae30416bdf6a01b655df398b49574ec (tag: yocto-5.2.3,
> > > tag: 2025-04.3-walnascar, tag: 2.12.3, origin/2.12, oe/2.12,
> > > github/2.12, github.oe/2.12, 2.12)
> > > Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > Date:   Tue Jul 29 16:42:25 2025 -0400
> > >
> > >     utils: Optimise signal/sigmask performance
> > >
> > > Should I redo this as 2.12.4 and adjust the related change for oe-cor=
e
> > > to bump the minimal version to 2.12.4 as well?
> > >
> > > Similarly for scarthgap and 2.8 bitbake, which has 2.8.12 tag already=
,
> > > so instead of 2.8.1 I would bump it to 2.8.13.
> >
> > Adding Richard since he is the bitbake maintainer.
> >
> > I'm not sure what has been done historically.  We haven't been bumping
> > the version with each minor release, but it seems to make sense to me
> > to do the bump to 2.12.4 rather than 2.12.1
> >
> > Steve
> >
> > > commit 982645110a19ebb94d519926a4e14c8a2a205cfd (tag: yocto-5.0.12,
> > > tag: 2024-04.12-scarthgap, tag: 2.8.12, origin/2.8, oe/2.8,
> > > github/2.8, github.oe/2.8, 2.8)
> > > Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> > > Date:   Tue Jul 29 14:43:09 2025 -0400
> > >
> > >     utils: Optimise signal/sigmask performance
> > >
> > > Regards,
> > >
> > > On Wed, Sep 10, 2025 at 5:55=E2=80=AFPM Steve Sakoman via
> > > lists.openembedded.org <steve=3Dsakoman.com@lists.openembedded.org>
> > > wrote:
> > > >
> > > > From: Martin Jansa <martin.jansa@gmail.com>
> > > >
> > > > To indicate compatibility with python 3.14
> > > >
> > > > [YOCTO #15858]
> > > >
> > > > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > > > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > > > ---
> > > >  bin/bitbake        | 2 +-
> > > >  lib/bb/__init__.py | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/bin/bitbake b/bin/bitbake
> > > > index 09cbb54e8..05b6ba742 100755
> > > > --- a/bin/bitbake
> > > > +++ b/bin/bitbake
> > > > @@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigPa=
rameters, BBMainException
> > > >
> > > >  bb.utils.check_system_locale()
> > > >
> > > > -__version__ =3D "2.12.0"
> > > > +__version__ =3D "2.12.1"
> > > >
> > > >  if __name__ =3D=3D "__main__":
> > > >      if __version__ !=3D bb.__version__:
> > > > diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
> > > > index 605355e1a..eba7b8fdd 100644
> > > > --- a/lib/bb/__init__.py
> > > > +++ b/lib/bb/__init__.py
> > > > @@ -9,7 +9,7 @@
> > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > >  #
> > > >
> > > > -__version__ =3D "2.12.0"
> > > > +__version__ =3D "2.12.1"
> > > >
> > > >  import sys
> > > >  if sys.version_info < (3, 9, 0):
> > > > --
> > > > 2.43.0
> > > >
> > > >
> > > > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > > > Links: You receive all messages sent to this group.
> > > > View/Reply Online (#17999): https://lists.openembedded.org/g/bitbak=
e-devel/message/17999
> > > > Mute This Topic: https://lists.openembedded.org/mt/115172226/361715=
6
> > > > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > > > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [=
martin.jansa@gmail.com]
> > > > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > > >

