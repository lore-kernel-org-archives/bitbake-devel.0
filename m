Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B7ACAC599
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 13:57:33 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web11.23711.1758117448344222089
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Sep 2025 06:57:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=PRym6N7u;
 spf=softfail (domain: sakoman.com, ip: 209.85.219.170, mailfrom: steve@sakoman.com)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea4036dbdb4so1223566276.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 06:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1758117447; x=1758722247; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ig12MFv3WE94TWSQ2tuIwKzftMIxQpHHV0uyHcGC+M=;
        b=PRym6N7uzSCz0CxXf+5YleX6+tUm7ZQMwzI08BayK4v9yeLIL7ZDU9joS77WHYdgIh
         4F6zglyD1J94crce1Mpcnt3wUcRC3AhP66BTuLGDS+PXggtG0irZepqUl3qpEAm74SYi
         BeSM1evCXF888OEcc9u+MtCRT6sezFTxlfV1fTg0F6YJuV8YckEEwWt2+XLSHmfJaKXl
         /smuhE7/Nw7W4Sx92uCXd7IxIjLEUvuiBQPBgUY1hqJqbT8QcKWsPWL4UyStnHrtWvcl
         De4Dez6IJCjvPOoy3UPghq/txPDm5rfRE50ZydROtlgtfWkZOrJpdl6nuXGCUWfph+Wm
         Te2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117447; x=1758722247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ig12MFv3WE94TWSQ2tuIwKzftMIxQpHHV0uyHcGC+M=;
        b=hYW5YPjosaTtgowXUmpf7U2pwmQW2BvyklszevK4n9cjQuInIfWERzKppmboQoRDM6
         10VQ1TP36EmKCBzCVHkmPH7IrPdbPYmEJUZqGQrIzKieBdolkfc8MdrkbdW/X4amwu6/
         pdYG0QI+mY3HNbBSF0fvS9dUQ/Q6VbKAMxyBPfLlNdjjlVx6jJzW80B2kZL7Rnb3QOD5
         9Xq8ZSmyjQ5VZulYu0hFHrRAZqB2Ui4ZLEdyPk5qw59xQEojz/rovktvJaoHxgQvfOcC
         dqiO7M2JpyzN49EWWtyfb4IIoFtIHZLT7b9DJTBx8SQGs2HDz3SjwxD2y3u7Gbyiw8ur
         lADg==
X-Gm-Message-State: AOJu0YxWL4jRDdJ5VVF42auiqDRtvzPcQ46cgvQ/7OjV81d5E6n2gR2b
	S0d7O3wGiT7P1MuD/0IAZPkOePMVUAZa2plFfc4VRhKxxAaDv0MgFixGs321o7eqN/2rji+gt9F
	1DvZzr+9X9GpCzNhDTRHfJ8H2Cy75mxPQVymQyMf4/w==
X-Gm-Gg: ASbGncukX9UNJl4dX6gjtI2FZ5zgpTVTYm1gBsyklr8kT+5dawpSNaJmV5UR776CfE8
	onu0G4KsJ8Yd6ziH4pk7K9fhLrX80vaKxTab6CO0w/nAvRk5ItxL9HpE/zU7K+xDvYlrInNa20m
	GyZ1Bx4O9ljmpszKJUlvarlat0zxU0oS36Fjk+ww7WLj7A8/8UXBmFBTn2Bob1E3r7lPqcEw2Mj
	umxbTvA+qaFkwwwRiHlBklQ6IeZ7cXEPTWul98=
X-Google-Smtp-Source: AGHT+IFJ6wpQp25Thsy3Joh+HVLJizktYSlE4PAXZwVEEbXoSLmmaVEZ9SPnHX5mNnz642NyxaaWfe1MCNtwyPqgCMU=
X-Received: by 2002:a05:6902:c0b:b0:ea5:c442:16f5 with SMTP id
 3f1490d57ef6-ea5c44217c3mr1408675276.19.1758117447110; Wed, 17 Sep 2025
 06:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1757519577.git.steve@sakoman.com> <a7d07075ed20f11a9bc068b495d739cab71b07c6.1757519577.git.steve@sakoman.com>
 <CA+chaQcqqi=Zy1xEgEt1FdnBsH9hVDsskK15T=yUOg0MJ0CbqQ@mail.gmail.com>
In-Reply-To: <CA+chaQcqqi=Zy1xEgEt1FdnBsH9hVDsskK15T=yUOg0MJ0CbqQ@mail.gmail.com>
From: Steve Sakoman <steve@sakoman.com>
Date: Wed, 17 Sep 2025 06:57:16 -0700
X-Gm-Features: AS18NWBYtKRo9X_MPFuApYEXFdgA-SKkAxDiBcyn0hLe9LjrqjOIuDUK59rEipw
Message-ID: <CAOSpxdbx6NRbf3DJdvDbVQswa839AeMbaD=Uv_5U9BJ-Qg-WRw@mail.gmail.com>
Subject: Re: [bitbake-devel] [bitbake][walnascar][2.12][PATCH 2/2] bitbake:
 Bump version to 2.12.1
To: Martin Jansa <martin.jansa@gmail.com>, 
	Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Sep 2025 13:57:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18054

On Wed, Sep 17, 2025 at 12:27=E2=80=AFAM Martin Jansa <martin.jansa@gmail.c=
om> wrote:
>
> Hello Steve,
>
> I've noticed today that 1.12.3 tag was pushed for current 1.12 branch:
>
> commit 710f98844ae30416bdf6a01b655df398b49574ec (tag: yocto-5.2.3,
> tag: 2025-04.3-walnascar, tag: 2.12.3, origin/2.12, oe/2.12,
> github/2.12, github.oe/2.12, 2.12)
> Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> Date:   Tue Jul 29 16:42:25 2025 -0400
>
>     utils: Optimise signal/sigmask performance
>
> Should I redo this as 2.12.4 and adjust the related change for oe-core
> to bump the minimal version to 2.12.4 as well?
>
> Similarly for scarthgap and 2.8 bitbake, which has 2.8.12 tag already,
> so instead of 2.8.1 I would bump it to 2.8.13.

Adding Richard since he is the bitbake maintainer.

I'm not sure what has been done historically.  We haven't been bumping
the version with each minor release, but it seems to make sense to me
to do the bump to 2.12.4 rather than 2.12.1

Steve

> commit 982645110a19ebb94d519926a4e14c8a2a205cfd (tag: yocto-5.0.12,
> tag: 2024-04.12-scarthgap, tag: 2.8.12, origin/2.8, oe/2.8,
> github/2.8, github.oe/2.8, 2.8)
> Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> Date:   Tue Jul 29 14:43:09 2025 -0400
>
>     utils: Optimise signal/sigmask performance
>
> Regards,
>
> On Wed, Sep 10, 2025 at 5:55=E2=80=AFPM Steve Sakoman via
> lists.openembedded.org <steve=3Dsakoman.com@lists.openembedded.org>
> wrote:
> >
> > From: Martin Jansa <martin.jansa@gmail.com>
> >
> > To indicate compatibility with python 3.14
> >
> > [YOCTO #15858]
> >
> > Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
> > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > ---
> >  bin/bitbake        | 2 +-
> >  lib/bb/__init__.py | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/bin/bitbake b/bin/bitbake
> > index 09cbb54e8..05b6ba742 100755
> > --- a/bin/bitbake
> > +++ b/bin/bitbake
> > @@ -27,7 +27,7 @@ from bb.main import bitbake_main, BitBakeConfigParame=
ters, BBMainException
> >
> >  bb.utils.check_system_locale()
> >
> > -__version__ =3D "2.12.0"
> > +__version__ =3D "2.12.1"
> >
> >  if __name__ =3D=3D "__main__":
> >      if __version__ !=3D bb.__version__:
> > diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
> > index 605355e1a..eba7b8fdd 100644
> > --- a/lib/bb/__init__.py
> > +++ b/lib/bb/__init__.py
> > @@ -9,7 +9,7 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  #
> >
> > -__version__ =3D "2.12.0"
> > +__version__ =3D "2.12.1"
> >
> >  import sys
> >  if sys.version_info < (3, 9, 0):
> > --
> > 2.43.0
> >
> >
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#17999): https://lists.openembedded.org/g/bitbake-de=
vel/message/17999
> > Mute This Topic: https://lists.openembedded.org/mt/115172226/3617156
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [mart=
in.jansa@gmail.com]
> > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> >

