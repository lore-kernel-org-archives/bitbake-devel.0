Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94DFC433F5
	for <webhook@archiver.kernel.org>; Fri, 26 Nov 2021 19:54:53 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
 [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web10.28402.1637956493316477857
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Nov 2021 11:54:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=HlfF5J7a;
 spf=pass (domain: gmail.com, ip: 209.85.166.44, mailfrom: ticotimo@gmail.com)
Received: by mail-io1-f44.google.com with SMTP id x10so12741129ioj.9
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Nov 2021 11:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dJnL5N4blV+mw7CWD0szVU1mKQBdlWA2m4ivdbPeN5s=;
        b=HlfF5J7a39Kt9XunI48Gp+sfoceIMG6ZN/OHEKi9VwbQ6I/61lBk58rz3txn+DY99J
         Jh0Vz5x5x1CNFuOf0Pe7NoinZSVUKALhjEPPH7UTOrH5XYulK/T1zSWS8P7Qb4+K5sSc
         gJ5fT9TGlTOlJr0Qb6tZlS3KhP124WgXirxL27Ui/1oTbKHiDYVzgsosMPYKUzReyMTv
         MqnzhJw8DGWF4Pxtpft/m+6HcwSYVeGdlPK3mvSZCzgHApwNnJLqK0IlW/sYQOgmbAeL
         H+l/U6RkARrf9vqo4YWpc73G9EfvI0mCSM4l599wb78btd1+8FCG8aizPAcQ7LWOisU8
         JL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dJnL5N4blV+mw7CWD0szVU1mKQBdlWA2m4ivdbPeN5s=;
        b=K55wRKym3ZaJFkl7GX5hnyf1EsHl+qWYRofCyPTlYHSNKEmGpaoV3EcTfixj2XLDxm
         UMQhfjBc8T5+PO3Tfu+F9jxDm27bR1Pz7VbNfXtxjlvbDI3HIAu9RbvIB6R+GKmWOUg2
         N0bBPQ4wvwex6P2wBdS5M5iTUIpk908B+VP6L0WQKbG5M+lqlzH5aILlxxik/X8o6jGd
         EworEHtDdQVJQ97lGwmxgFD5Rk8d8x1InqIzUrGW5gj3Xx4iPH48mDte3kq5lC8lyYI5
         HbPgLUhAFEOBmU4Wdxymv3KipcTCxYtriDObe2XkctntUsHEJI6AAkvOTA3QsYMPkCAM
         zpOg==
X-Gm-Message-State: AOAM530YzeHufyQjCAKiLO1aGI1Ey8IhRTrVQQCbwjgxlpH4ZmfByHWK
	US/8Sbo4dyjWA6HpWRy3axqYEqSRxoekYge2RkM=
X-Google-Smtp-Source: 
 ABdhPJxITP75/Yng3RQ2dU9cKMpjIIScZFRGxyI80gCKr5JhWtF3mK1FBId2wDq2ldNkB/6IQDOnWGsEPXZ7wKv1fd0=
X-Received: by 2002:a05:6602:2e81:: with SMTP id
 m1mr36053826iow.55.1637956492566;
 Fri, 26 Nov 2021 11:54:52 -0800 (PST)
MIME-Version: 1.0
References: <20211126051800.2364615-1-timothy.t.orling@intel.com>
 <4cb1cfdfd24814d29dea9308b9bceee6f6054f99.camel@linuxfoundation.org>
 <CANx9H-DqwpfBovbZUcHAR-GWeDuoGKXnUcNLwavpkREJRMXCvg@mail.gmail.com>
 <13b87370c53e1cf2b0f5711beebd1797df9d1f70.camel@linuxfoundation.org>
In-Reply-To: 
 <13b87370c53e1cf2b0f5711beebd1797df9d1f70.camel@linuxfoundation.org>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 26 Nov 2021 11:54:41 -0800
Message-ID: 
 <CANx9H-AjFBsmy9_qimMOruAOj-FMEaNkWX7ZLBVLx1VVYzgPgg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/version.py: add from
 distutils.version
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Tim Orling <timothy.t.orling@intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="000000000000e5a60105d1b676ad"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Nov 2021 19:54:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13117

--000000000000e5a60105d1b676ad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 26, 2021 at 8:36 AM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Fri, 2021-11-26 at 08:14 -0800, Tim Orling wrote:
> >
> >
> > On Fri, Nov 26, 2021 at 12:21 AM Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > > On Thu, 2021-11-25 at 21:18 -0800, Tim Orling wrote:
> > > > In places like sanity.bbclass we currently use
> > > > distutils.version.LooseVersion, but distutils is deprecated in Pyth=
on
> > > > 3.10 and will be removed in Python 3.12 (~October 2023).
> > > >
> > > > The recommended replacement for for distutils.version.LooseVersion =
is
> > > > packaging.version.Version, but this implies 'packaging' be installe=
d
> on
> > > > the host. It is also not the same functionality as LooseVersion.
> > > >
> > > > [YOCTO #14610]
> > > >
> > > > Signed-off-by: Tim Orling <timothy.t.orling@intel.com>
> > > > ---
> > > >   lib/bb/version.py | 347
> ++++++++++++++++++++++++++++++++++++++++++++++
> > > >   1 file changed, 347 insertions(+)
> > > >   create mode 100644 lib/bb/version.py
> > >
> > > I'm wondering if we could switch the usage of LooseVersion for
> > > bb.utils.vercmp_string(a, b)?
> > >
> > >
> >
> > I don't know. I was trying to follow any guidance from upstream CPython
> and
> > PEP 632 and this was the simplest way out. In my thread to the
> oe-architecture
> > list Khem thought this was ok, so I just went with it to get the
> distutils
> > deprecation series out into the wild and get eyeballs on it. Much more
> will
> > have to wait until after the YP Summit in terms of my bandwidth.
> >
>
> Ok, I've sent out a patch which replaces the LooseVersion usage with our
> bb.utils function since as far as I can tell it should work fine. It isn'=
t
> quite
> as pretty as the python one but I'm not keen to add new licenses to
> bitbake or
> have multiple version handling functions.
>

Thank you and agreed. I didn=E2=80=99t like adding the new license.

>
> I suspect we could also make that function more pythonic.


I=E2=80=99ll take look later.

>
>
> Cheers,
>
> Richard
>
>

--000000000000e5a60105d1b676ad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Nov 26, 2021 at 8:36 AM Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linuxfoundati=
on.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;paddi=
ng-left:1ex;border-left-color:rgb(204,204,204)">On Fri, 2021-11-26 at 08:14=
 -0800, Tim Orling wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Fri, Nov 26, 2021 at 12:21 AM Richard Purdie<br>
&gt; &lt;<a href=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_b=
lank">richard.purdie@linuxfoundation.org</a>&gt; wrote:<br>
&gt; &gt; On Thu, 2021-11-25 at 21:18 -0800, Tim Orling wrote:<br>
&gt; &gt; &gt; In places like sanity.bbclass we currently use<br>
&gt; &gt; &gt; distutils.version.LooseVersion, but distutils is deprecated =
in Python<br>
&gt; &gt; &gt; 3.10 and will be removed in Python 3.12 (~October 2023).<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The recommended replacement for for distutils.version.LooseV=
ersion is<br>
&gt; &gt; &gt; packaging.version.Version, but this implies &#39;packaging&#=
39; be installed on<br>
&gt; &gt; &gt; the host. It is also not the same functionality as LooseVers=
ion.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; [YOCTO #14610]<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Signed-off-by: Tim Orling &lt;<a href=3D"mailto:timothy.t.or=
ling@intel.com" target=3D"_blank">timothy.t.orling@intel.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt; =C2=A0 lib/bb/version.py | 347 +++++++++++++++++++++++++++++=
+++++++++++++++++<br>
&gt; &gt; &gt; =C2=A0 1 file changed, 347 insertions(+)<br>
&gt; &gt; &gt; =C2=A0 create mode 100644 lib/bb/version.py<br>
&gt; &gt; <br>
&gt; &gt; I&#39;m wondering if we could switch the usage of LooseVersion fo=
r<br>
&gt; &gt; bb.utils.vercmp_string(a, b)?<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; <br>
&gt; I don&#39;t know. I was trying to follow any guidance from upstream CP=
ython and<br>
&gt; PEP 632 and this was the simplest way out. In my thread to the oe-arch=
itecture<br>
&gt; list Khem thought this was ok, so I just went with it to get the distu=
tils<br>
&gt; deprecation series out into the wild and get eyeballs on it. Much more=
 will<br>
&gt; have to wait until after the YP Summit in terms of my bandwidth.<br>
&gt; <br>
<br>
Ok, I&#39;ve sent out a patch which replaces the LooseVersion usage with ou=
r<br>
bb.utils function since as far as I can tell it should work fine. It isn&#3=
9;t quite<br>
as pretty as the python one but I&#39;m not keen to add new licenses to bit=
bake or<br>
have multiple version handling functions.<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Thank you and ag=
reed. I didn=E2=80=99t like adding the new license.</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">=
<br>
I suspect we could also make that function more pythonic.</blockquote><div =
dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:=
1ex;border-left-color:rgb(204,204,204)" dir=3D"auto"></blockquote><div dir=
=3D"auto">I=E2=80=99ll take look later.</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;padding-left:1ex;border-left-color:rgb(204,204,204)" dir=3D"auto">=
<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
</blockquote></div></div>

--000000000000e5a60105d1b676ad--

