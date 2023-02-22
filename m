Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE419C636D6
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 15:04:27 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.11068.1677078264808303583
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Feb 2023 07:04:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TZ9LVDk7;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso199733wmp.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 07:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1mBF0qdSuh4UoX7ST3tx39RRu1BfUkXbF8wS97JRzg=;
        b=TZ9LVDk71onoVfVMPcSR7gPgmaSWsGPpOC2L8I3os43tTeMEeTWyz3zQ/5hJ213nEh
         w0nLcd6S29HI2HKc/jOrPxBtHE5yJmA3qsZNV88bTgNCNFJgzZXsIY8vmFM4cuZm3VIK
         eLWNgQaEWXw3jpuTjsVnDuISf7KmSzpXKmz5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1mBF0qdSuh4UoX7ST3tx39RRu1BfUkXbF8wS97JRzg=;
        b=Rb9wITiwf02tYTAm500joq0M6jCUe8adswE8qA921hyhDvVsPqpHFEFr6B29KU2mK3
         25xUbV1KufO7gSHLIYcBo2GAnlk0bCRrMPqE/ozwstbtyp3R0PQd6Ael6FtgO1C1x6tK
         RXVxjc9Tj/RUAr7v8ICbZ6LPaia8vnvsV0pqo9R5TyVaOKCC94phyd5VTh+KQ/s3I6nV
         MmQkHxfuNViYJMOFuDDZLUKRGgu3D1WHVqTvx+uz5Mcxx1u4/6dwSJt/1sVar4y+LJlk
         9fxZVh1g1jyKn/FKZe8bZ5IpQ2vMw1kWTOZehDvIHzVUx6aNc3Ghrci1vTv7P4nsYkzK
         Eetg==
X-Gm-Message-State: AO0yUKV3YvKnGwl4GjMf/0CkjofKdq/v5nWbStrowcGD9vCI6gXzFS7F
	cuWmPCcdgipSKnIFbIXgvMhsjYWgCba8Nobv
X-Google-Smtp-Source: AK7set8cf2pKqsfhajA81yd7NpKR4ZI3NCEoi9JQd1k0dTIW2C3J7Wbr0l1Ecg75GgG40AuNRL8Yig==
X-Received: by 2002:a05:600c:a287:b0:3dc:1f90:35b with SMTP id hu7-20020a05600ca28700b003dc1f90035bmr5843044wmb.34.1677078263206;
        Wed, 22 Feb 2023 07:04:23 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:d5d1:6a95:9b62:17ab? ([2001:8b0:aba:5f3c:d5d1:6a95:9b62:17ab])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d4cc5000000b002c59f18674asm7157229wrt.22.2023.02.22.07.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 07:04:22 -0800 (PST)
Message-ID: <fdff0bf7029c1d618b90a36d18d1d6b9c5de4c83.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/2] event/cooker/runqueue: Add ability
 to interrupt longer running code
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Watt <jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 22 Feb 2023 15:04:22 +0000
In-Reply-To: <5672f789-0dcc-779b-3158-10235ad661c6@gmail.com>
References: <20230222145153.581307-1-richard.purdie@linuxfoundation.org>
	 <5672f789-0dcc-779b-3158-10235ad661c6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 15:04:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14480

On Wed, 2023-02-22 at 08:59 -0600, Joshua Watt wrote:
> On 2/22/23 08:51, Richard Purdie wrote:
> > Bitbake is now able to understand when a UI wants it to stop the curren=
t
> > processing. There are some long running functions which currently have =
no
> > mechanism to interrupt them however.
> >=20
> > This patch adds a call, bb.event.check_for_interrupts(d) which can be
> > placed in long running code and allows an internal state flag within
> > bitbake to be checked. If set, that flag will trigger an exit.
> >=20
> > This means that Ctrl+C can be made to work in a variety of places where
> > it currently would not.
> >=20
> > Long running event handlers in OE-Core can also then benefit from this
> > new approach with the addition of the function call as well.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >   lib/bb/cooker.py   |  4 ++++
> >   lib/bb/event.py    | 11 +++++++++++
> >   lib/bb/runqueue.py | 15 +++++++++++++++
> >   3 files changed, 30 insertions(+)
> >=20
> > diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> > index b673fe10ee..c631ec7e6d 100644
> > --- a/lib/bb/cooker.py
> > +++ b/lib/bb/cooker.py
> > @@ -345,6 +345,7 @@ class BBCooker:
> >           elif signum =3D=3D signal.SIGHUP:
> >               bb.warn("Cooker received SIGHUP, shutting down...")
> >           self.state =3D state.forceshutdown
> > +        bb.event._should_exit.set()
> >  =20
> >       def setFeatures(self, features):
> >           # we only accept a new feature set if we're in state initial,=
 so we can reset without problems
> > @@ -1520,6 +1521,7 @@ class BBCooker:
> >               msg =3D None
> >               interrupted =3D 0
> >               if halt or self.state =3D=3D state.forceshutdown:
> > +                bb.event._should_exit.set()
> >                   rq.finish_runqueue(True)
> >                   msg =3D "Forced shutdown"
> >                   interrupted =3D 2
> > @@ -1760,6 +1762,7 @@ class BBCooker:
> >               self.state =3D state.forceshutdown
> >           else:
> >               self.state =3D state.shutdown
> > +        bb.event._should_exit.set()
> >  =20
> >           if self.parser:
> >               self.parser.shutdown(clean=3DFalse)
> > @@ -1770,6 +1773,7 @@ class BBCooker:
> >               self.parser.shutdown(clean=3DFalse)
> >               self.parser.final_cleanup()
> >           self.state =3D state.initial
> > +        bb.event._should_exit.clear()
>=20
> I typically avoid Event because it's easy to forget some the assumptions=
=20
> it makes, but I think it's OK in this context because it's never=20
> possible for set() and clear() to be called out of sequence (or in=20
> parallel on other threads).

Right, I was thinking/hoping in this case it should likely be ok...

>=20
> >  =20
> >       def reset(self):
> >           if hasattr(bb.parse, "siggen"):
> > diff --git a/lib/bb/event.py b/lib/bb/event.py
> > index 8b05f93e2f..37cc630c63 100644
> > --- a/lib/bb/event.py
> > +++ b/lib/bb/event.py
> > @@ -69,6 +69,7 @@ _eventfilter =3D None
> >   _uiready =3D False
> >   _thread_lock =3D threading.Lock()
> >   _heartbeat_enabled =3D False
> > +_should_exit =3D threading.Event()
> >  =20
> >   def enable_threadlock():
> >       # Always needed now
> > @@ -86,6 +87,16 @@ def disable_heartbeat():
> >       global _heartbeat_enabled
> >       _heartbeat_enabled =3D False
> >  =20
> > +#
> > +# In long running code, this function should be called periodically
> > +# to check if we should exit due to an interuption (.e.g Ctrl+C from t=
he UI)
> > +#
> > +def check_for_interrupts(d):
>=20
> why the addition of 'd' here?

It should always be available in any of the contexts where it would be
used and I did wonder about putting the signal mechanism via the
datastore instead of via the global variable.

Having it here therefore doesn't appear to hurt and may be useful in
future to improve the code as it is the best global context we have
right now.

Cheers,

Richard



