Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37BBC197A0
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 13:14:49 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
 by mx.groups.io with SMTP id smtpd.web10.49826.1700486088029219911
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 05:14:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=LbChhiwY;
 spf=pass (domain: gmail.com, ip: 209.85.208.181, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c875207626so23770881fa.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 05:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700486086; x=1701090886; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8dmQUhq9Llo9fijCL7XE6mpIrzGspCQUVUJX8yMkTe0=;
        b=LbChhiwYtBjw/ME8XMz9eJcpgO81yHJ+0ckFgcEax+tiCkh+4quCyNoVne5Gt4O6Fq
         2asmmH5P71yDMNdPqZ45g/OQNPN0h0qiEsx3xCtiFIMfEx1A60nySWmTrNgzx7EuYNHt
         J0Ap+FCe/+VMdtJuLLXMIaUVP4tecbA0rMXJMJ89JveHoujoh8YucbjqQGd7llndKlT1
         EQZwSqXPdSL3kPMLaAgHVuTYyS0v1qldDWcFxdBTHa4dNMg4Sv0f1EvsR/nf5CSB6eVD
         cbG9qvpgo8554ZqBRjoz7THOC7mT1EGX6In8xtJ5jIu8IIaRb7cf+pTqVbFWl+mtEq88
         OlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700486086; x=1701090886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8dmQUhq9Llo9fijCL7XE6mpIrzGspCQUVUJX8yMkTe0=;
        b=DKmbsdrrU9n3Nbmv4ajZggPjXqD+k9nzgU5J3dkIQxggos3YVA31K/Qb3BvNg7eDwo
         ca/eY764Glm2H3qroV2mH3WxF8Y509ikVJWMMi5KGL7WT4YXFnZgHkPGazTOKapWgHUa
         Q9GaGcul3PC9Pkms0HjHZpSl/GiHqGWL9fqh6R++0ZyoXyXmIizB3+95mHdGkzyQqAaA
         uLqUIzv2mTl+C/wWlfhFHR5tslvSGUzJKbbMf7d9Gu26+4ABlivTrNShTmzqdYVvi7PY
         B5eHWSMjT5bEfPhN2GRwgigxNf8JEoe+qAcFmIKTx1zTD8BnKbOqg7ienOeMFqKQr0C/
         YGZw==
X-Gm-Message-State: AOJu0Yw46TO5BtrM6R8YAKSo7IxoajJg5+2JEx0myxlbFKqT/d29pf53
	gABxofx1cLthLNUtpNx9EnEitKZYk44Fpbeq9rE=
X-Google-Smtp-Source: AGHT+IHRJb5p5D11V1FUTjBkM8cLSqYktceTfG5CoJI6F3nSkZwQuWojlXU2yiuVn3NHRMjS/SzwAbp3UbjMEDr8WGY=
X-Received: by 2002:a2e:9c53:0:b0:2c5:55a:b6b5 with SMTP id
 t19-20020a2e9c53000000b002c5055ab6b5mr5335543ljj.28.1700486085824; Mon, 20
 Nov 2023 05:14:45 -0800 (PST)
MIME-Version: 1.0
References: <4851356.GXAFRqVoOG@n95hx1g2> <CANNYZj-cc2wDXUODqveROB6Hdpr0CnHoNLt49Nywfcpgs_19xA@mail.gmail.com>
 <2250070.iZASKD2KPV@n95hx1g2> <70e7245a5f6b37f9045027f90c665c244a28a234.camel@ew.tq-group.com>
In-Reply-To: <70e7245a5f6b37f9045027f90c665c244a28a234.camel@ew.tq-group.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Mon, 20 Nov 2023 14:14:32 +0100
Message-ID: <CA+chaQeFGqnDbKav6JbXOO4ouqEVDvUNofuhM5A_+t7dv9n81A@mail.gmail.com>
Subject: Re: [bitbake-devel] npm/npmsw fetchers: Support for "offline" builds?
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Cc: Christian Eggers <ceggers@arri.de>, Alexander Kanavin <alex.kanavin@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000175516060a9545de"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 13:14:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15537

--000000000000175516060a9545de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 2:01=E2=80=AFPM Markus Niebel <Markus.Niebel@ew.tq-=
group.com>
wrote:

> Am Montag, dem 20.11.2023 um 13:19 +0100 schrieb Christian Eggers:
> >
> > Hi Alex,
> >
> > On Monday, 20 November 2023, 12:05:28 CET, Alexander Kanavin wrote:
> >
> > > On Mon, 20 Nov 2023 at 11:59, Christian Eggers <ceggers@arri.de>
> > wrote:
> > >
> > > > When having NPM based application in my SDK (e.g. quicktype [1],
> > recipe is
> > > > attached), the "fetch" tasks perform a full build of nodejs
> > before starting
> > > > the actual download of the quicktype sources. But building nodejs
> > (and its
> > > > dependencies) during the "fetch" stage, compromises my wish to
> > perform the
> > > > actual build in an offline environment.
> > > >
> > >
> > > I'm not sure I understand what is being compromised here. If you
> > want an
> > > offline build, throw away the sstate cache that was created in the
> > fetching
> > > step, and nodejs will be again rebuilt together with everything
> > else.
> >
> > my intend is to run as few build scripts as possible as long as the
> > build
> > machine has access to the internet. For security reasons I would like
> > to divide
> > the build into two stages, one stage for downloading (with internet
> > access enabled)
> > and one stage for compiling (without internet access).
> >
> > While I highly trust the OpenEmbedded/Yocto projects, I fear that
> > single upstream
> > projects may become targets for supply chain attacks in the future.
> > Running
> > the package Makefiles/scripts etc. on a machine (e.g. docker) without
> > network
> > access reduces the possibility for manipulated packages to retrieve
> > internal
> > secrets and upload them to the internet.
> >
> > Are there any other use cases why people want to perform an "offline"
> > build?
> >
>
> At least offline builds are useful for release builds to make sure no
> recipe tries to bypass the normal fetch logic. We saw this several
> times in the past with silicon vendor stuff - recipes tried to fetch
> things during configuration or as part of compilation.
>
> Another thing I can imagine are builds against an internal PREMIRROR
> for several reasons.
>

Yes, but bitbake and oe do that automatically (even in "online" build) now
with following changes:

     bitbake can now restrict network access in various tasks based on
"network" flag as implemented in:

https://git.openembedded.org/bitbake/commit/?id=3D0746b6a2a32fec4c18bf1a52b=
1454ca4c04bf543

https://git.openembedded.org/bitbake/commit/?id=3D9d6341df611a1725090444f6f=
8eb0244aed08213
    and oe now enables network mostly only in do_fetch and few special
tasks as implemented in:

https://git.openembedded.org/openembedded-core/commit/?id=3D7ce1e88a3ad85bb=
b925bb9f7167dc0a5fd1c27f4

so unless your evil vendor doesn't enable network flag on (m)any tasks,
they shouldn't be able to bypass the normal fetch logic.

--000000000000175516060a9545de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 20, 2023 at 2:01=E2=80=AF=
PM Markus Niebel &lt;<a href=3D"mailto:Markus.Niebel@ew.tq-group.com">Marku=
s.Niebel@ew.tq-group.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Am Montag, dem 20.11.2023 um 13:19 +0100 schrieb Ch=
ristian Eggers:<br>
&gt;=C2=A0 <br>
&gt; Hi Alex,<br>
&gt; <br>
&gt; On Monday, 20 November 2023, 12:05:28 CET, Alexander Kanavin wrote:<br=
>
&gt; <br>
&gt; &gt; On Mon, 20 Nov 2023 at 11:59, Christian Eggers &lt;<a href=3D"mai=
lto:ceggers@arri.de" target=3D"_blank">ceggers@arri.de</a>&gt;<br>
&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt; &gt; When having NPM based application in my SDK (e.g. quicktype =
[1],<br>
&gt; recipe is<br>
&gt; &gt; &gt; attached), the &quot;fetch&quot; tasks perform a full build =
of nodejs<br>
&gt; before starting<br>
&gt; &gt; &gt; the actual download of the quicktype sources. But building n=
odejs<br>
&gt; (and its<br>
&gt; &gt; &gt; dependencies) during the &quot;fetch&quot; stage, compromise=
s my wish to<br>
&gt; perform the<br>
&gt; &gt; &gt; actual build in an offline environment.<br>
&gt; &gt; &gt;<br>
&gt; &gt; <br>
&gt; &gt; I&#39;m not sure I understand what is being compromised here. If =
you<br>
&gt; want an<br>
&gt; &gt; offline build, throw away the sstate cache that was created in th=
e<br>
&gt; fetching<br>
&gt; &gt; step, and nodejs will be again rebuilt together with everything<b=
r>
&gt; else.<br>
&gt; <br>
&gt; my intend is to run as few build scripts as possible as long as the<br=
>
&gt; build<br>
&gt; machine has access to the internet. For security reasons I would like<=
br>
&gt; to divide<br>
&gt; the build into two stages, one stage for downloading (with internet<br=
>
&gt; access enabled)<br>
&gt; and one stage for compiling (without internet access).<br>
&gt; <br>
&gt; While I highly trust the OpenEmbedded/Yocto projects, I fear that<br>
&gt; single upstream<br>
&gt; projects may become targets for supply chain attacks in the future.<br=
>
&gt; Running<br>
&gt; the package Makefiles/scripts etc. on a machine (e.g. docker) without<=
br>
&gt; network<br>
&gt; access reduces the possibility for manipulated packages to retrieve<br=
>
&gt; internal<br>
&gt; secrets and upload them to the internet.<br>
&gt; <br>
&gt; Are there any other use cases why people want to perform an &quot;offl=
ine&quot;<br>
&gt; build?<br>
&gt; <br>
<br>
At least offline builds are useful for release builds to make sure no<br>
recipe tries to bypass the normal fetch logic. We saw this several<br>
times in the past with silicon vendor stuff - recipes tried to fetch<br>
things during configuration or as part of compilation.<br>
<br>
Another thing I can imagine are builds against an internal PREMIRROR<br>
for several reasons.<br></blockquote><div><br></div><div>Yes, but bitbake a=
nd oe do that automatically (even in &quot;online&quot; build) now with fol=
lowing changes:</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0bitbake can no=
w restrict network access in various tasks based on &quot;network&quot; fla=
g as implemented in:</div>=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.opene=
mbedded.org/bitbake/commit/?id=3D0746b6a2a32fec4c18bf1a52b1454ca4c04bf543">=
https://git.openembedded.org/bitbake/commit/?id=3D0746b6a2a32fec4c18bf1a52b=
1454ca4c04bf543</a><br>=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://git.openembe=
dded.org/bitbake/commit/?id=3D9d6341df611a1725090444f6f8eb0244aed08213">htt=
ps://git.openembedded.org/bitbake/commit/?id=3D9d6341df611a1725090444f6f8eb=
0244aed08213</a><br>=C2=A0 =C2=A0 and oe now enables network mostly only in=
 do_fetch and few special tasks as implemented in:<br>=C2=A0 =C2=A0 =C2=A0 =
<a href=3D"https://git.openembedded.org/openembedded-core/commit/?id=3D7ce1=
e88a3ad85bbb925bb9f7167dc0a5fd1c27f4">https://git.openembedded.org/openembe=
dded-core/commit/?id=3D7ce1e88a3ad85bbb925bb9f7167dc0a5fd1c27f4</a></div><d=
iv class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">so unless you=
r evil vendor doesn&#39;t enable network flag on (m)any tasks, they shouldn=
&#39;t be able to bypass the normal fetch logic.</div></div>

--000000000000175516060a9545de--

