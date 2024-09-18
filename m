Return-Path: <jstephan@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C81CCD187
	for <webhook@archiver.kernel.org>; Wed, 18 Sep 2024 07:40:06 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.10193.1726645197662104624
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Sep 2024 00:39:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=tBi9vVH5;
 spf=pass (domain: baylibre.com, ip: 209.85.218.42, mailfrom: jstephan@baylibre.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a789c4fc5so86989866b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 00:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726645196; x=1727249996; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/YlK1O+JFmqoaxH4lYsW/mhlnmtqgjjNsQ7XrD3oG4=;
        b=tBi9vVH5wX6tw1ivynRTiZ4zzZRfnhcPTV1s1ptB+ED9YwJQCyqX5ETh3ax8ynlRQ+
         3DS+NHkFZiCqNBfB0JVo1MlZxqvQtK12Hsj6w+W3UDfbc4Gelae0eafcqxzXxqCkOx6j
         u6Zxd9KTpe22JuTs3CIRXXPaVohSllKGRHRV5+RGchg/Zb+YI/DGAV+H63y9DNg0y+V0
         FIj7BpD+diisfbj4SsNhqjnL26kFHY4eqJdPxRVjB8W1H+1a7t+m+HOwneT/1IJV2ma2
         H3XEsj0QX2rC/XYZrSHSpzg5UsuJvbMxFp9S9MY4+4UgUzAEZq3ddovNrkV0xm1vy/6N
         umDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726645196; x=1727249996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/YlK1O+JFmqoaxH4lYsW/mhlnmtqgjjNsQ7XrD3oG4=;
        b=SKs3CFnWB745dar9piiBLklTcYX/WSLtAJ5NKN6bwXb4qU0XD7Cby1xQGCNsfob8eY
         1CCFRwe0KM3duo964/v8x3/2QK/n1IZ3jF8ty23RqEGjdjjAhk/l3QHng/PylCbThpwb
         nuR8UE1W6JavqGnglV84aADnRPR4fsIRCw3Ah1mpFT46rhABgOTQ85Rps8flGckhPEV1
         iusxeeyk0j9J71AjjmT06PS1XPrkBWwp4LgfwjHCxf5i8HaiG2YgGBzjgMmwrNCoP2GL
         qTiZ4Y0oX3+iwrp2L9KoR5bgxqdowrZcsjADJC8X++fk3B27KIY+rLO4mP2EXhrY6Ok1
         hnKw==
X-Gm-Message-State: AOJu0YwMioQwfVdMQ0tI1EgQFwejZDhbstslXZXYWzLEqIzg1SfycsdW
	nTzkIvzyTd3CELL+xFsRRxjR6hSEg2Ai0/VQigUY2m9JJhG0eHQbaNY2ap2cpWRp2GdMYvS7mkS
	O2ECiwOG13eOdwS47LQ14b6k8lIHUO6SDzALk5A==
X-Google-Smtp-Source: AGHT+IHmUXS2qmuIb8mUmHIAaBowI72d7V9Z04sO3aNzUaYeZUOeayoFMfBOq8syzDY7bzz3uDgfRuylNpVDW8tx/+Q=
X-Received: by 2002:a17:906:fd8b:b0:a75:7a8:d70c with SMTP id
 a640c23a62f3a-a902a3d186bmr2366927166b.4.1726645195873; Wed, 18 Sep 2024
 00:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240917151157.780068-1-jstephan@baylibre.com>
 <b911e5bef3e661b976d6a5822e9fa2941d2e90d7.camel@linuxfoundation.org>
 <CAEHHSvZigPQTmPwHP-vom2ybOXoXQm3NhCsUyFLW0n9H2t3VxA@mail.gmail.com> <6a74952e25ddc9b0aaf90571851b4802c574369f.camel@linuxfoundation.org>
In-Reply-To: <6a74952e25ddc9b0aaf90571851b4802c574369f.camel@linuxfoundation.org>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Sep 2024 09:39:44 +0200
Message-ID: <CAEHHSvZpX1HZAX_wT9X9ysnAG2meu0UeO1-tA5Jrebc6449_6g@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: add documentation for
 "bitbake -S lockedsigs"
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 18 Sep 2024 07:40:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16570

Le mer. 18 sept. 2024 =C3=A0 09:30, Richard Purdie
<richard.purdie@linuxfoundation.org> a =C3=A9crit :
>
> On Wed, 2024-09-18 at 09:05 +0200, Julien Stephan wrote:
> > Le mar. 17 sept. 2024 =C3=A0 22:55, Richard Purdie
> > <richard.purdie@linuxfoundation.org> a =C3=A9crit :
> > >
> > > On Tue, 2024-09-17 at 17:11 +0200, Julien Stephan via
> > > lists.openembedded.org wrote:
> > > > The following commit added "lockedsigs" as new signature handler
> > > > for the
> > > > -S option of bitbake:
> > > >     2cf13f25139 - lib/oe/sstatesig.py: dump locked.sigs.inc only
> > > > when explicitly asked via -S lockedsigs
> > > >
> > > > But it was not documented anywhere, so add some basic
> > > > documentation for
> > > > it in both the .rst documentation files and the help message of
> > > > bitbake
> > > >
> > > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > > ---
> > > >  .../bitbake-user-manual-execution.rst               |  6 ++++++
> > > >  .../bitbake-user-manual-intro.rst                   | 13
> > > > +++++++++----
> > > >  bitbake/lib/bb/main.py                              | 12
> > > > +++++++-----
> > > >  3 files changed, 22 insertions(+), 9 deletions(-)
> > >
> > > Unfortunately I don't think this is quite so simple. The lockedsigs
> > > support is implemented in OE-Core and BitBake doesn't contain that
> > > code. This makes it very hard to accurately document since it is
> > > metadata dependent.
> > >
> > > I do agree we need to improve this somehow, I just don't know how.
> >
> > Hi Richard,
> >
> > Maybe we should remove this from bitbake and implement it using
> > bblock? :)
> > Let me know if I can help on this!
>
> That is a direction I've been wondering about and I think it would make
> sense. It is one of the reasons I wanted to see the lock/unlock
> commands become separate tools!
>

ok then let me try to come up with something :)

By the way, my next step was to send a patch adding documentation for
SIGGEN_LOCKEDSIGS*
variables, but I realize that the same problem applies to these
variables,  right?
I don't see any reference for these variables inside bitbake code..
Should I add them in yocto-docs ?



> Cheers,
>
> Richard
>
>

