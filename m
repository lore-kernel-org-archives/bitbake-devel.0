Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39759CAC59A
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 14:05:43 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web10.23916.1758117940968770776
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 07:05:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QtMAlcPo;
 spf=pass (domain: gmail.com, ip: 209.85.167.47, mailfrom: martin.jansa@gmail.com)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5607a240c75so6821099e87.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758117939; x=1758722739; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PgkQkjzUsJIX3CdD65Z5XuHc/09kjXOLOo7UIfhaS4=;
        b=QtMAlcPoFTtbK98II79nyJvvRaTduh53CFwuMGhZNMVOAkQP+5VYwH0P6gsVCAz6Ox
         JCP+QqgvNphNxid4ADgH3cBOGQfqLbxgq54AyqC6vHSSmqr8E94X/lHtDZJJj612eOfG
         JogICdca1tNEDF/BstXJSWZxpOdJ7el6Eeq9usuYsj3AvgdOSkicCYwUwzDYEt+iHo4G
         qxGXevR5BJlQ4ASeyi8173jue5Nqo7Mxm/aUCrRVHE+XgJXxnTwqlAlqfzD7K52HsQau
         Ql2bhpWSKqvamOm5i9FxSJWHhNq9VlTaV0gc4IKTJ0hZ52cenBm2w2cX4aN5APthDkQk
         xxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117939; x=1758722739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PgkQkjzUsJIX3CdD65Z5XuHc/09kjXOLOo7UIfhaS4=;
        b=D8WGFMXv8mDKRjG8qsXxE3PDmf7/Lzxuzu7J5pIFDVTQ7oiGZoWcDbipR942/5EaEX
         ccFO1X7Krgjx3k5wW/HKKMoCnRwX3wrQauDe4/tG43QZSV84H1LqX8v7nKMJ+3+4yzCQ
         7MIqyQixEfEV2oOR9bsmgTWaljJGj0zDyklDw3MGxMZrDShl+f3BuK5Giv4H2yxbYwSf
         nULNQIJ/6d+mBkC0fx9r911u4wN+7CJ4ZUNb4K48LsBVnJ2IpKEzih6lUAQFWyY0hi+V
         HJAQHmnvbAIKP1rcvFwlyjKlzKU7Uy+apVhy4zQ3WkwMzPxFnQ8hH898UjUPhDgYan5O
         SIiA==
X-Forwarded-Encrypted: i=1; AJvYcCXjyIrUKS6wz5Nr4t12zd7I2uygdmYw5xaqES6eOzXmJbSq8LzHG54e1P8cDOhib0qNf2L3SHuCZb9WjHI6@lists.openembedded.org
X-Gm-Message-State: AOJu0YxacezQfA8n2JT0iATISF70/umYBKgmfvC6GCUHHFK0MXxTg0mk
	W/IHjHcIMccMoUHxwO0lo0+Jvr83UrKHWeunfoHnU5D90/GIDQX9URSe4e2bjfYYL4OXW7cHgK3
	I30I+FRMS9AK6PAJx6XuMPdpSRrA83aU=
X-Gm-Gg: ASbGnctpGQYAMO/twSa/iDAzoEZf2ZCUmX0Fv7RaQ30GoeqGHXNi2t2RGksAYJ52dwo
	fQisQB1h8jvwXI8xURs8PQhwEoNdr7aq6csr0FQoNnLo5fbX1nFLJSTE3qFzuxa/SO4jyJdTN0s
	JoTtXr8gT6jGQ04gGzKcByVltEr9Cox5oGLct/jUV6WEqAAcV1tlhH3VFAjMTqsXbnefFTssTPu
	WufEqZAWQ==
X-Google-Smtp-Source: AGHT+IF9eHn/zXPJ86IBrXJjybrenv6+BWvlAjrZ+CzOK10L62lpE/yqaiGAE2/xcg3kNXtU/P5pJzpP4H57JiWnT9g=
X-Received: by 2002:a05:6512:3a94:b0:560:885b:2c79 with SMTP id
 2adb3069b0e04-57798e1c21cmr670560e87.27.1758117938678; Wed, 17 Sep 2025
 07:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1757519577.git.steve@sakoman.com> <a7d07075ed20f11a9bc068b495d739cab71b07c6.1757519577.git.steve@sakoman.com>
 <CA+chaQcqqi=Zy1xEgEt1FdnBsH9hVDsskK15T=yUOg0MJ0CbqQ@mail.gmail.com> <CAOSpxdbx6NRbf3DJdvDbVQswa839AeMbaD=Uv_5U9BJ-Qg-WRw@mail.gmail.com>
In-Reply-To: <CAOSpxdbx6NRbf3DJdvDbVQswa839AeMbaD=Uv_5U9BJ-Qg-WRw@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Wed, 17 Sep 2025 16:05:24 +0200
X-Gm-Features: AS18NWA4s9NQD9_JgXegAVCxsZKaANqvkcown-OVqVTX7qyr2Ic3eM6kr7Z26y0
Message-ID: <CA+chaQfWY40HZhEiDr9dF5UDCFmQcqjRkxNgCDXFRpTYAPMLRg@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][walnascar][2.12][PATCH 2/2] bitbake:
 Bump version to 2.12.1
To: Steve Sakoman <steve@sakoman.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 14:05:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18055

I've sent the v2 of all 4 related changes to use 2.12.4 and 2.8.13.

I've also noticed that the sanity check for bitbake version is
executed too late after the utils.py is already failing with:
ERROR: Unable to parse oe-core/meta/lib/oe/utils.py
Traceback (most recent call last):
  File "oe-core/meta/lib/oe/utils.py", line 11, in <module>
    from bb import multiprocessing
ImportError: cannot import name 'multiprocessing' from 'bb'
(bitbake/lib/bb/__init__.py)

To avoid this issue I recommend to leave "lib/oe/utils: use
multiprocessing from bb" commit in oe-core scarthgap and walnascar for
some future batch and now merge just the bitbake version bump in
bitbake and the requirement for newer bitbake in oe-core, that way
people will hopefully update both before it gets really mandatory.

Cheers,

On Wed, Sep 17, 2025 at 3:57=E2=80=AFPM Steve Sakoman <steve@sakoman.com> w=
rote:
>
> On Wed, Sep 17, 2025 at 12:27=E2=80=AFAM Martin Jansa <martin.jansa@gmail=
.com> wrote:
> >
> > Hello Steve,
> >
> > I've noticed today that 1.12.3 tag was pushed for current 1.12 branch:
> >
> > commit 710f98844ae30416bdf6a01b655df398b49574ec (tag: yocto-5.2.3,
> > tag: 2025-04.3-walnascar, tag: 2.12.3, origin/2.12, oe/2.12,
> > github/2.12, github.oe/2.12, 2.12)
> > Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> > Date:   Tue Jul 29 16:42:25 2025 -0400
> >
> >     utils: Optimise signal/sigmask performance
> >
> > Should I redo this as 2.12.4 and adjust the related change for oe-core
> > to bump the minimal version to 2.12.4 as well?
> >
> > Similarly for scarthgap and 2.8 bitbake, which has 2.8.12 tag already,
> > so instead of 2.8.1 I would bump it to 2.8.13.
>
> Adding Richard since he is the bitbake maintainer.
>
> I'm not sure what has been done historically.  We haven't been bumping
> the version with each minor release, but it seems to make sense to me
> to do the bump to 2.12.4 rather than 2.12.1
>
> Steve
>
> > commit 982645110a19ebb94d519926a4e14c8a2a205cfd (tag: yocto-5.0.12,
> > tag: 2024-04.12-scarthgap, tag: 2.8.12, origin/2.8, oe/2.8,
> > github/2.8, github.oe/2.8, 2.8)
> > Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> > Date:   Tue Jul 29 14:43:09 2025 -0400
> >
> >     utils: Optimise signal/sigmask performance
> >
> > Regards,
> >
> > On Wed, Sep 10, 2025 at 5:55=E2=80=AFPM Steve Sakoman via
> > lists.openembedded.org <steve=3Dsakoman.com@lists.openembedded.org>
> > wrote:
> > >
> > > From: Martin Jansa <martin.jansa@gmail.com>
> > >
> > > To indicate compatibility with python 3.14
> > >
> > > [YOCTO #15858]
> > >
> > > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > > ---
> > >  bin/bitbake        | 2 +-
> > >  lib/bb/__init__.py | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/bin/bitbake b/bin/bitbake
> > > index 09cbb54e8..05b6ba742 100755
> > > --- a/bin/bitbake
> > > +++ b/bin/bitbake
> > > @@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigPara=
meters, BBMainException
> > >
> > >  bb.utils.check_system_locale()
> > >
> > > -__version__ =3D "2.12.0"
> > > +__version__ =3D "2.12.1"
> > >
> > >  if __name__ =3D=3D "__main__":
> > >      if __version__ !=3D bb.__version__:
> > > diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
> > > index 605355e1a..eba7b8fdd 100644
> > > --- a/lib/bb/__init__.py
> > > +++ b/lib/bb/__init__.py
> > > @@ -9,7 +9,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0-only
> > >  #
> > >
> > > -__version__ =3D "2.12.0"
> > > +__version__ =3D "2.12.1"
> > >
> > >  import sys
> > >  if sys.version_info < (3, 9, 0):
> > > --
> > > 2.43.0
> > >
> > >
> > > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > > Links: You receive all messages sent to this group.
> > > View/Reply Online (#17999): https://lists.openembedded.org/g/bitbake-=
devel/message/17999
> > > Mute This Topic: https://lists.openembedded.org/mt/115172226/3617156
> > > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [ma=
rtin.jansa@gmail.com]
> > > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > >

