Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D50C282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 23:59:17 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web11.2801.1741305550114169904
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Mar 2025 15:59:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fndiy3S2;
 spf=pass (domain: gmail.com, ip: 209.85.208.169, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30b936ffc51so10311261fa.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Mar 2025 15:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741305548; x=1741910348; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sv4EnPDt2pmOTxbD/qmC9iiQ4Wjw1YuYhrLJ0hl8Gag=;
        b=fndiy3S2XdEOAhKw0i3ZgmsNEP+AYf2FKpFRUY0yhphK8/GnORxHJKlQPBAe7yKaZa
         FcPf0d2juEuoey1HFw1oSc+2S7sk7v1WekYbUzFSTGBvZdAMU0lJ/KO+ivo7O7puFfKA
         /whwS4Uay/KndqfkgK0P3E+ox3C9OpaI6IY2SnHGat6MzQISywHFBKLiEjg07yw1X544
         6dZ6+pQR630k2qCfZ6A09BzwSXtlzkP66Dzr5au+lJojNJzEL6gZO//4THKa+eVephVx
         gG4iINvbiNscpugijcQIUjDRhQWqTOLyoCBwKm0es9O0mDaavWIpAG5gJvvm4AFDmu7U
         wyFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741305548; x=1741910348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sv4EnPDt2pmOTxbD/qmC9iiQ4Wjw1YuYhrLJ0hl8Gag=;
        b=xJbQQ4Y74I69T/x/r8nKc1XAXDdgVds2mpg8K/Ue1fR6t3sOozTYvz7LorXtwf67hO
         aueFOLkRCYE9xc/oY0ZwvirssFZEOzhLXtP49b39FWKPGwbKsh7aSFaQRPlNzE3C50+I
         pICGPrifPiqmjPvEPBvRPAZ9zthhNhWNhyX9xivHIzq4uVZ8iYUPvVLm8O2JAdUix5LY
         300wLUsrqcoQkjXS9kXvzW/zzArb86kBmA9goVYE4kMi83IMSvoRrxrWngrYmWBsQLZP
         qnESixHlxFb1AXvWsU89uwsR1gbWlLVoyCBae7HZoqC20nnHkeZKm5hXkKgkpdpOf8ck
         0fhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY/M9L7ilyym5WsYWTbANUtztclYfsSHfUfvQCD2K/IRbXvdF8bhlE7syFBKDEjmWQ9Sawr6XzUUfRqIT9@lists.openembedded.org
X-Gm-Message-State: AOJu0YxET01X76U5GP9iE+8lzZw3jfudQGqM5m3OVgaARy/xe93DbdKj
	pu0WTMjCwOqMUJLfAEFcE0k7ko5g8gAKjvkQ4Niosyk8uWQUKiBOB0WBcxfW3ueo0eyy9q/7zMr
	XEI++gqXimosGCBlXbpxf8lUr3AQ=
X-Gm-Gg: ASbGncsn4DDIqj12Xomipn2zIp5U3lUf7kkgKHIdWwBQbhaZEMwBO8dOtA0JAXo44ba
	3B3EZwiOiH+VXN43N/2gGd0d3+6rpPf+mY8y7DE2EVpEEXmJWSkJLELOasFS1sQlY2X1YPqONnR
	GByKDHSaTnyxFM55IGWSlmoLRL4g==
X-Google-Smtp-Source: AGHT+IEpSeCjuwrV9WLO5M8KmDUdpu6iHOhyf3Kqi0BmKSO3Pywkd0E8IFZj04wex8FdtJDTxex6PBcXnHKp/kGqyKg=
X-Received: by 2002:a05:651c:b0a:b0:30b:c22d:83b3 with SMTP id
 38308e7fff4ca-30bf4537aecmr3239701fa.15.1741305547709; Thu, 06 Mar 2025
 15:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20250306150628.278459-1-pmi183@gmail.com> <4090036f9516a7af7e3bbf6abeb76490c1c2abc6.camel@linuxfoundation.org>
In-Reply-To: <4090036f9516a7af7e3bbf6abeb76490c1c2abc6.camel@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 6 Mar 2025 16:58:54 -0700
X-Gm-Features: AQ5f1Jrs5-OoEeHQjCAujm7NEQyt_ToK7xMD0vbqEg2NZCRpiQxN0zdrF91yBwI
Message-ID: <CAJdd5GbTRPu8SuNYaNUaGzJR4J97iG2pXppaPM_+QciijGMcrQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] codeparser: Skipping typing when
 inspecting Python modules
To: richard.purdie@linuxfoundation.org
Cc: pmi183@gmail.com, bitbake-devel@lists.openembedded.org, 
	Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Mar 2025 23:59:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17397

On Thu, Mar 6, 2025 at 3:05=E2=80=AFPM Richard Purdie via
lists.openembedded.org
<richard.purdie=3Dlinuxfoundation.org@lists.openembedded.org> wrote:
>
> On Thu, 2025-03-06 at 15:06 +0000, Pedro Ferreira via lists.openembedded.=
org wrote:
> > From: Pedro Ferreira <Pedro.Silva.Ferreira@criticaltechworks.com>
> >
> > If a custom python module is added thru BBIMPORTS and it
> > uses typing(Any,Tuple,Union...), codeparser will fail because
> > inspect.py raises TypeError exception if the object is a
> > built-in module, class, or function.
> >
> > Signed-off-by: Pedro Silva Ferreira <Pedro.Silva.Ferreira@criticaltechw=
orks.com>
> > ---
> >  lib/bb/codeparser.py | 22 ++++++++++++++--------
> >  1 file changed, 14 insertions(+), 8 deletions(-)
> >
> > diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
> > index d249af326..7f6adaf36 100644
> > --- a/lib/bb/codeparser.py
> > +++ b/lib/bb/codeparser.py
> > @@ -72,15 +72,21 @@ def add_module_functions(fn, functions, namespace):
> >              parser.parse_python(None, filename=3Dfn, lineno=3D1, fixed=
hash=3Dfixedhash+f)
> >              #bb.warn("Cached %s" % f)
> >          except KeyError:
> > -            targetfn =3D inspect.getsourcefile(functions[f])
> > -            if fn !=3D targetfn:
> > -                # Skip references to other modules outside this file
> > -                #bb.warn("Skipping %s" % name)
> > +            try:
> > +                targetfn =3D inspect.getsourcefile(functions[f])
> > +                if fn !=3D targetfn:
> > +                    # Skip references to other modules outside this fi=
le
> > +                    #bb.warn("Skipping %s" % name)
> > +                    continue
> > +                lines, lineno =3D inspect.getsourcelines(functions[f])
> > +                src =3D "".join(lines)
> > +                parser.parse_python(src, filename=3Dfn, lineno=3Dlinen=
o, fixedhash=3Dfixedhash+f)
> > +                #bb.warn("Not cached %s" % f)
> > +            except TypeError:
> > +                # Since Python inspect wont support special types
> > +                # Skip references of typing special forms, aliases and=
 tuples
> > +                bb.warn("Skipping refs to %s : %s" % (f, type(function=
s[f]).__name__))
> >                  continue
> > -            lines, lineno =3D inspect.getsourcelines(functions[f])
> > -            src =3D "".join(lines)
> > -            parser.parse_python(src, filename=3Dfn, lineno=3Dlineno, f=
ixedhash=3Dfixedhash+f)
> > -            #bb.warn("Not cached %s" % f)
> >          execs =3D parser.execs.copy()
> >          # Expand internal module exec references
> >          for e in parser.execs:
> >
>
>
> This may be a good reason not to use typing in python module code we're
> importing. Catching and ignoring all TypeErrors like this sounds like
> it will cause us other problems in the future by hiding real errors :(

This could be OK. The API definition of getsourcefile() clearly states
it rasies TypeError on a builtin, and None if the file is not found,
so we can tell the difference. That said, it would be better to scope
it as tightly as possible to prevent hiding other errors in the code

try:
    targetfn =3D inspect.getsourcefile(functions[f])
except TypeError:
    # Builtin
    continue

>
> Cheers,
>
> Richard
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17396): https://lists.openembedded.org/g/bitbake-deve=
l/message/17396
> Mute This Topic: https://lists.openembedded.org/mt/111549472/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

