Return-Path: <ernstp@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8E5C76188
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 10:20:47 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web10.126348.1680690045634855563
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 03:20:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=SqSBsLyl;
 spf=pass (domain: gmail.com, ip: 209.85.167.182, mailfrom: ernstp@gmail.com)
Received: by mail-oi1-f182.google.com with SMTP id f14so12708207oiw.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 03:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680690045; x=1683282045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iEcbyakDoU0Y60kzEDjDzoGeIwhoYhf0mc4WUpjv/w8=;
        b=SqSBsLylBCJZGLS/vhWg7PoHc+LxnfEy6a3eWPuu82NBrGqmuhAG5r2HV4pLjlMykX
         Z/MJLRE9sM0CDSvPbNCBGmGhzotMoN7ddstRMGm5UxMpli1/PCsGE5TJbl2dQVtvUZmx
         bAeq35pUlYIOIkDmXtsEsfL7AeohjFYKrE1rui8E8gD++p/W9hOVWyJYQ8Q4ubHarO94
         27hxncFmZ+v1yg3tUZMigr5+iFobqFQ71056YTfhBD3j7YricC1hNHvlhV/UXb7xCD9b
         h/NOYwAwxC0VFSn/jmwHx3hg+hjoRL/NwbIaYVKXAmq7NZkaU+nLRZOYhZfseEycwk4u
         z0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680690045; x=1683282045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEcbyakDoU0Y60kzEDjDzoGeIwhoYhf0mc4WUpjv/w8=;
        b=rJ6hV1L0o12pbxu+TclXiZeePu7e4nu4N5T2rfKR8mfWIrWNP3gP+nLaKYxRzH0Yjx
         hcVEd0Qw+1NS2PdcAfqxiaKwAOAFlE8jy0e50CQRnfLGFQE14miRh7s5j6LCGAX5CAeQ
         m1ZyedjIskf1XxD5LUGVGPCcBj0kKTgGspmkCRqtwzMOqdyoWnH78h+MKsflgQG+B/os
         5kg59uuN+cJcOITDb5LGeFdMXr/Y41m+2RTWa6MbFOAVjqFHcPvKj2DNbAy/ISxMrk7e
         ttUkdxuxSg+vksj/vBJaYjxBIuoNByiIuYeG54ictafotxoxA45wt3vE5ntQUPp6Z+XP
         mOwg==
X-Gm-Message-State: AAQBX9eByd+bIvffrIASc4KE2ePJqAHXVaESYEGll0kkfSVEfpkkH82V
	k2MxEUDFdJpA2yx/ObIUmSCZnW5nRaaBJFgrzfM=
X-Google-Smtp-Source: AKy350aAxaY3iHFAyNJi8OH/gLrPjk0FwL6o+oUeDTH/ZUqFROTA1jsTWUsWjgXhuvJ+rDkLoNPtxx/guxd3Lk/LCn4=
X-Received: by 2002:a05:6808:298a:b0:378:74af:45ef with SMTP id
 ex10-20020a056808298a00b0037874af45efmr1691096oib.11.1680690044829; Wed, 05
 Apr 2023 03:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <43210b1ce3260a74b29f28db3125aad206612ac9.camel@infinera.com>
 <CAD=4a=VVXxX-OW2sSzsNaji8uqRsp15yxkYpgDZUgdwFqsK-qQ@mail.gmail.com> <3b5cd3a10aafb8392dcf26d38ab5437a4d3ae1d9.camel@infinera.com>
In-Reply-To: <3b5cd3a10aafb8392dcf26d38ab5437a4d3ae1d9.camel@infinera.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Wed, 5 Apr 2023 12:20:31 +0200
Message-ID: <CAD=4a=W0mdnk4774_m9cFW8Z6HJ30D-y3OHvq8fVfr9NqmjStQ@mail.gmail.com>
Subject: Re: [bitbake-devel] building python-inflect ?
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="00000000000019867b05f89425c1"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Apr 2023 10:20:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14646

--00000000000019867b05f89425c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah you didn't mention dunfell.

Luckily I have a solution for you!

https://github.com/ernstp/meta-setuptools-backport

Regards
/Ernst

Den ons 5 apr. 2023 11:09Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
skrev:

> On Wed, 2023-04-05 at 01:45 +0200, Ernst Sj=C3=B6strand wrote:
> > I think you want to add
> > inherit python_setuptools_build_meta
>
> Thank for your help, I looked for python_setuptools_build_meta in dunfell
> but seem only to be in kirkstone :(
> Is there some other way in dunfell ?
>
> The exact problem we have is that it builds/installs fine in both native
> and nativesdk but is only
> useable in native, in natetivsdk one get a No such module when trying to
> import the module.
>
>  Jocke
> >
> > Regards
> > //Ernst
> >
> > Den tis 4 apr. 2023 kl 22:21 skrev Joakim Tjernlund
> > <Joakim.Tjernlund@infinera.com>:
> > >
> > > Trying to make a .bb for python-inflect,
> https://github.com/jaraco/inflect but this pkg
> > > does not have a setup.py, only a setup.cfg
> > >
> > > I do not speak python and cannot work out what to do, I got(can
> someone help me fill in the missing part?):
> > >
> > > SUMMARY =3D "A port of Ruby on Rails' inflection to Python."
> > > HOMEPAGE =3D "https://pypi.org/project/inflect"
> > > LICENSE =3D "MIT"
> > > SECTION =3D "devel/python"
> > > #LIC_FILES_CHKSUM =3D
> "file://LICENSE;md5=3D2fb6fa1a6f1792d78de19ad1bb653c31"
> > > LIC_FILES_CHKSUM =3D
> "file://LICENSE;md5=3D7a7126e068206290f3fe9f8d6c713ea6"
> > >
> > > SRC_URI[md5sum] =3D "e7aad8f161ee9c85c7d125af69ae661f"
> > > SRC_URI[sha256sum] =3D
> "f1a6bcb0105046f89619fde1a7d044c612c614c2d85ef182582d9dc9b86d309a"
> > >
> > > inherit pypi ptest
> > >
> > > SRC_URI +=3D" \
> > >         file://run-ptest \
> > > "
> > > #DEPENDS =3D "python3-pydantic"
> > > RDEPENDS:${PN} =3D "python3-pydantic"
> > >
> > > RDEPENDS:${PN}_ptest +=3D" \
> > >         ${PYTHON_PN}_pytest \
> > > "
> > >
> > > do_install_ptest() {
> > >         cp -f ${S}/test_inflection.py ${D}${PTEST_PATH}/
> > > }
> > >
> > >
> > > RDEPENDS:${PN} +=3D "${PYTHON_PN}-pytest"
> > >
> > > BBCLASSEXTEND =3D "native nativesdk"
> > >
> > >
> > > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > > Links: You receive all messages sent to this group.
> > > View/Reply Online (#14634):
> https://lists.openembedded.org/g/bitbake-devel/message/14634
> > > Mute This Topic: https://lists.openembedded.org/mt/98068636/4947266
> > > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> ernstp@gmail.com]
> > > -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> > >
>
>

--00000000000019867b05f89425c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Ah you didn&#39;t mention dunfell.</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Luckily I have a solution for you!</div><=
div dir=3D"auto"><br></div><div dir=3D"auto"><a href=3D"https://github.com/=
ernstp/meta-setuptools-backport">https://github.com/ernstp/meta-setuptools-=
backport</a></div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards</di=
v><div dir=3D"auto">/Ernst<br><br><div class=3D"gmail_quote" dir=3D"auto"><=
div dir=3D"ltr" class=3D"gmail_attr">Den ons 5 apr. 2023 11:09Joakim Tjernl=
und &lt;<a href=3D"mailto:Joakim.Tjernlund@infinera.com">Joakim.Tjernlund@i=
nfinera.com</a>&gt; skrev:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Wed, =
2023-04-05 at 01:45 +0200, Ernst Sj=C3=B6strand wrote:<br>
&gt; I think you want to add<br>
&gt; inherit python_setuptools_build_meta<br>
<br>
Thank for your help, I looked for python_setuptools_build_meta in dunfell b=
ut seem only to be in kirkstone :(<br>
Is there some other way in dunfell ?<br>
<br>
The exact problem we have is that it builds/installs fine in both native an=
d nativesdk but is only<br>
useable in native, in natetivsdk one get a No such module when trying to im=
port the module.<br>
<br>
=C2=A0Jocke<br>
&gt;<br>
&gt; Regards<br>
&gt; //Ernst<br>
&gt;<br>
&gt; Den tis 4 apr. 2023 kl 22:21 skrev Joakim Tjernlund<br>
&gt; &lt;<a href=3D"mailto:Joakim.Tjernlund@infinera.com" target=3D"_blank"=
 rel=3D"noreferrer">Joakim.Tjernlund@infinera.com</a>&gt;:<br>
&gt; &gt;<br>
&gt; &gt; Trying to make a .bb for python-inflect, <a href=3D"https://githu=
b.com/jaraco/inflect" rel=3D"noreferrer noreferrer" target=3D"_blank">https=
://github.com/jaraco/inflect</a> but this pkg<br>
&gt; &gt; does not have a setup.py, only a setup.cfg<br>
&gt; &gt;<br>
&gt; &gt; I do not speak python and cannot work out what to do, I got(can s=
omeone help me fill in the missing part?):<br>
&gt; &gt;<br>
&gt; &gt; SUMMARY =3D &quot;A port of Ruby on Rails&#39; inflection to Pyth=
on.&quot;<br>
&gt; &gt; HOMEPAGE =3D &quot;<a href=3D"https://pypi.org/project/inflect" r=
el=3D"noreferrer noreferrer" target=3D"_blank">https://pypi.org/project/inf=
lect</a>&quot;<br>
&gt; &gt; LICENSE =3D &quot;MIT&quot;<br>
&gt; &gt; SECTION =3D &quot;devel/python&quot;<br>
&gt; &gt; #LIC_FILES_CHKSUM =3D &quot;file://LICENSE;md5=3D2fb6fa1a6f1792d7=
8de19ad1bb653c31&quot;<br>
&gt; &gt; LIC_FILES_CHKSUM =3D &quot;file://LICENSE;md5=3D7a7126e068206290f=
3fe9f8d6c713ea6&quot;<br>
&gt; &gt;<br>
&gt; &gt; SRC_URI[md5sum] =3D &quot;e7aad8f161ee9c85c7d125af69ae661f&quot;<=
br>
&gt; &gt; SRC_URI[sha256sum] =3D &quot;f1a6bcb0105046f89619fde1a7d044c612c6=
14c2d85ef182582d9dc9b86d309a&quot;<br>
&gt; &gt;<br>
&gt; &gt; inherit pypi ptest<br>
&gt; &gt;<br>
&gt; &gt; SRC_URI +=3D&quot; \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://run-ptest \<br>
&gt; &gt; &quot;<br>
&gt; &gt; #DEPENDS =3D &quot;python3-pydantic&quot;<br>
&gt; &gt; RDEPENDS:${PN} =3D &quot;python3-pydantic&quot;<br>
&gt; &gt;<br>
&gt; &gt; RDEPENDS:${PN}_ptest +=3D&quot; \<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0${PYTHON_PN}_pytest \<br>
&gt; &gt; &quot;<br>
&gt; &gt;<br>
&gt; &gt; do_install_ptest() {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cp -f ${S}/test_inflection.py ${=
D}${PTEST_PATH}/<br>
&gt; &gt; }<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; RDEPENDS:${PN} +=3D &quot;${PYTHON_PN}-pytest&quot;<br>
&gt; &gt;<br>
&gt; &gt; BBCLASSEXTEND =3D &quot;native nativesdk&quot;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; &gt; Links: You receive all messages sent to this group.<br>
&gt; &gt; View/Reply Online (#14634): <a href=3D"https://lists.openembedded=
.org/g/bitbake-devel/message/14634" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://lists.openembedded.org/g/bitbake-devel/message/14634</a><b=
r>
&gt; &gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/980=
68636/4947266" rel=3D"noreferrer noreferrer" target=3D"_blank">https://list=
s.openembedded.org/mt/98068636/4947266</a><br>
&gt; &gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openem=
bedded.org" target=3D"_blank" rel=3D"noreferrer">bitbake-devel+owner@lists.=
openembedded.org</a><br>
&gt; &gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-=
devel/unsub" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.=
openembedded.org/g/bitbake-devel/unsub</a> [<a href=3D"mailto:ernstp@gmail.=
com" target=3D"_blank" rel=3D"noreferrer">ernstp@gmail.com</a>]<br>
&gt; &gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; &gt;<br>
<br>
</blockquote></div></div></div>

--00000000000019867b05f89425c1--

