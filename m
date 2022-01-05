Return-Path: <simon.eu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7638DC433F5
	for <webhook@archiver.kernel.org>; Wed,  5 Jan 2022 10:42:04 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web08.5280.1641379323734521812
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Jan 2022 02:42:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=MBrlbLzU;
 spf=pass (domain: gmail.com, ip: 209.85.210.173,
 mailfrom: simon.eu@gmail.com)
Received: by mail-pf1-f173.google.com with SMTP id c2so34848140pfc.1
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Jan 2022 02:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=/W6ZvktxrlWq3OWpwJSNcHiX2LryICv5xm4qCal6GVM=;
        b=MBrlbLzU9cAnKKnHPLhgsn8BdZrBEear4iZDJEoCa3FjEEAUbUrGfDfqetHQjvGM6s
         ecmhBa3xtRckN5d6ClUYU0X36dYiamNxITn6cF/vzZ7KU9rG4QqTgtzpeDMyOZLnDXJR
         GvKhkAdHwjTYcQt7r4exKmNMEY6pB+nREmhXzYMMTfQDBUGD9jykZPtilN3s5dYlgmUt
         Pti9taBSbC3vBLmtyzrA8UScdc4Kv2s36lPq8deO/dymF2fWpREEArz+xCGJ4gtzFKxO
         2eGeTInVN1s1OVngv99y9a/pZj9gVW1NO2206WHSmgK5QTWnLMwjUB0Aq/iIzOcOXss+
         iU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=/W6ZvktxrlWq3OWpwJSNcHiX2LryICv5xm4qCal6GVM=;
        b=3h+GWTzh4DGr4yJnKgUITHl066loBK+jvZzEBntwY9Kd3d4z/o0SJCq8h/Ujm9zAt3
         pj3mwec2wnJdo6itB3Wf9uRpyiUaMkQpm4tX9wjcTAJwabRcg5mr/JGNLIXJGcQRJJuf
         ff1R3c1N7WOZ4NKVXqc5pu8Eru4zzURIOWOLvPjwq5IGrdr5qMVRfsGBtsaliyc1weMR
         QvR115USt9wpFIH8zzujGY0xh/jWtxRgQOF3r1z87GA5Zeme4gfju6RncdtUmfcOgrLR
         ZHHlDpl0w2ZOPRYB1MFwtSCKG+Id1HOblMqjRtgJdjmj0VTvWR/gY2ghRvGgpnYyLimm
         rXcA==
X-Gm-Message-State: AOAM530sCpSfMTFCfIWUYwRoKRlMqW3zC8oBQpqMUIAl0IkVbUvhIKjL
	SsykIESQ6gz/JrLDA5KFm3TI1qhFCTzHg8WCDPyp5GTS
X-Google-Smtp-Source: 
 ABdhPJz72OadFFb2+m0Bd8atZguIYpPaytZSpOY7M3fvs4ZCai1+59AC5vBUljBaPBnmEE+PXQ5sF0Z5WBlW9kpZWcA=
X-Received: by 2002:a63:7148:: with SMTP id b8mr25118073pgn.616.1641379322812;
 Wed, 05 Jan 2022 02:42:02 -0800 (PST)
MIME-Version: 1.0
References: <20211215092509.60979-1-simon.eu@gmail.com>
 <42d3ff93-33a1-e751-b0ff-974c8ecb4858@bootlin.com>
 <CAO8d5BY0R2d4Ufvk9cWwx=t95sOcQXs-5NGquP-3AAH8xG-RAg@mail.gmail.com>
In-Reply-To: 
 <CAO8d5BY0R2d4Ufvk9cWwx=t95sOcQXs-5NGquP-3AAH8xG-RAg@mail.gmail.com>
From: Simon Eugster <simon.eu@gmail.com>
Date: Wed, 5 Jan 2022 11:41:51 +0100
Message-ID: 
 <CAO8d5Ba-wDnhUNbuNfyoNr1F8vuVw5+Rjd-nrLh_+xe6imco7A@mail.gmail.com>
Subject: Fwd: [docs] [PATCH] bitbake: doc: bitbake-user-manual: Add more
 explanations to OVERRIDES
To: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000007a5e7605d4d3671a"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Jan 2022 10:42:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13221

--0000000000007a5e7605d4d3671a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Forwarding manually because I was not subscribed anymore and the email got
dropped.)

Hi Michael,

Am Mi., 15. Dez. 2021 um 11:46 Uhr schrieb Michael Opdenacker <
michael.opdenacker@bootlin.com>:

> Hi Simon,
>
> Many thanks for the new version of your patch!
> See my questions below...
>
> On 12/15/21 10:25 AM, Simon A. Eugster wrote:
> > Signed-off-by: Simon A. Eugster <simon.eu@gmail.com>
> > ---
> >  .../bitbake-user-manual-metadata.rst          | 28 ++++++++++++-------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > index d802a8d3..fc4f5d13 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > @@ -300,6 +300,12 @@ It is also possible to append and prepend to shell
> functions and
> >  BitBake-style Python functions. See the
> ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:shell functions`"
> and ":ref:`bitbake-user-manual/bitbake-user-manual-metadata:bitbake-style
> python functions`"
> >  sections for examples.
> >
> > +.. note::
> > +
> > +   Before Honister (3.4), override style used ``_`` instead of ``:``,
> so you will
> > +   still find a lot of documentation using =E2=80=9C_append=E2=80=9D, =
=E2=80=9C_prepend=E2=80=9D, and
> > +   =E2=80=9C_remove=E2=80=9D.
> > +
>
>
> I don't have anything about this text, but I wonder whether we should
> mention the old syntax in the current docs.
> Thoughts anyone?
>

I added this because I (as a new user) found it very confusing to find all
the _ style syntax in guides online and no mention of it in the docs. I
would have expected such a note.


> >  .. _removing-override-style-syntax:
> >
> >  Removal (Override Style Syntax)
> > @@ -517,20 +523,22 @@ variable.
> >  -  *Selecting a Variable:* The :term:`OVERRIDES` variable is a
> >     colon-character-separated list that contains items for which you wa=
nt
> >     to satisfy conditions. Thus, if you have a variable that is
> > -   conditional on "arm", and "arm" is in :term:`OVERRIDES`, then the
> > +   conditional on "arm", and "arm" is listed in :term:`OVERRIDES`, the=
n
> the
> >     "arm"-specific version of the variable is used rather than the
> >     non-conditional version. Here is an example::
> >
> > -      OVERRIDES =3D "architecture:os:machine"
> > +      # Typically, OVERRIDES contains something like
> architecture:os:machine
> > +      OVERRIDES =3D "linux:arm"
>
>
> Here you quote an example with two items, but this doesn't align with
> the typical contents with three items you mention in the comment that
> you added.
> By the way, according to the below text, didn't you mean?
>
> OVERRIDES =3D "foo:linux:arm"
>
> It looks like a good idea to have this comment; this way you can give a
> concrete example. In my opinion, "foo" is vague, what about instead?
>
> OVERRIDES =3D "arm:linux:beaglebone"
>

Yes, will change that!


> >        TEST =3D "default"
> > -      TEST_os =3D "osspecific"
> > -      TEST_nooverride =3D "othercondvalue"
> > +      TEST:arm =3D "armspecific"
> > +      TEST:nooverride =3D "othercondvalue"
> >
> > -   In this example, the :term:`OVERRIDES`
> > -   variable lists three overrides: "architecture", "os", and "machine"=
.
> > -   The variable ``TEST`` by itself has a default value of "default". Y=
ou
> > -   select the os-specific version of the ``TEST`` variable by appendin=
g
> > -   the "os" override to the variable (i.e. ``TEST_os``).
> > +   In this example, the :term:`OVERRIDES` variable lists three
> > +   overrides: "foo", "linux", and "arm". The variable ``TEST`` by itse=
lf
> > +   has a default value of "default", and the value of the =E2=80=9Carm=
=E2=80=9D specific
> > +   version =E2=80=9Carmspecific=E2=80=9D is used because :term:`OVERRI=
DES` contains
> > +   =E2=80=9Carm=E2=80=9D. The =E2=80=9Cnooverride=E2=80=9D specific ve=
rsion is not used because
> > +   :term:`OVERRIDES` does not contain =E2=80=9Cnooverride=E2=80=9D.
> >
> >     To better understand this, consider a practical example that assume=
s
> >     an OpenEmbedded metadata-based Linux kernel recipe file. The
> > @@ -552,7 +560,7 @@ variable.
> >
> >        DEPENDS =3D "glibc ncurses"
> >        OVERRIDES =3D "machine:local"
> > -      DEPENDS:append:machine =3D "libmad"
> > +      DEPENDS:append:machine =3D " libmad"
> >
> >     In this example, :term:`DEPENDS` becomes "glibc ncurses libmad".
>

Thanks,
Simon

--0000000000007a5e7605d4d3671a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">(Forwarding manually because I was not subscribed anymore =
and the email got dropped.)<br><div><div class=3D"gmail_quote"><br><div dir=
=3D"ltr"><div>Hi Michael,<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Am Mi., 15. Dez. 2021 um 11:46=C2=A0Uhr schri=
eb Michael Opdenacker &lt;<a href=3D"mailto:michael.opdenacker@bootlin.com"=
 target=3D"_blank">michael.opdenacker@bootlin.com</a>&gt;:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hi Simon,<br>
<br>
Many thanks for the new version of your patch!<br>
See my questions below...<br>
<br>
On 12/15/21 10:25 AM, Simon A. Eugster wrote:<br>
&gt; Signed-off-by: Simon A. Eugster &lt;<a href=3D"mailto:simon.eu@gmail.c=
om" target=3D"_blank">simon.eu@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../bitbake-user-manual-metadata.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 28 ++++++++++++-------<br>
&gt;=C2=A0 1 file changed, 18 insertions(+), 10 deletions(-)<br>
&gt;<br>
&gt; diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst<br>
&gt; index d802a8d3..fc4f5d13 100644<br>
&gt; --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst<br>
&gt; +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst<br>
&gt; @@ -300,6 +300,12 @@ It is also possible to append and prepend to shel=
l functions and<br>
&gt;=C2=A0 BitBake-style Python functions. See the &quot;:ref:`bitbake-user=
-manual/bitbake-user-manual-metadata:shell functions`&quot; and &quot;:ref:=
`bitbake-user-manual/bitbake-user-manual-metadata:bitbake-style python func=
tions`&quot;<br>
&gt;=C2=A0 sections for examples.<br>
&gt;=C2=A0 <br>
&gt; +.. note::<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0Before Honister (3.4), override style used ``_`` instead=
 of ``:``, so you will<br>
&gt; +=C2=A0 =C2=A0still find a lot of documentation using =E2=80=9C_append=
=E2=80=9D, =E2=80=9C_prepend=E2=80=9D, and<br>
&gt; +=C2=A0 =C2=A0=E2=80=9C_remove=E2=80=9D.<br>
&gt; +<br>
<br>
<br>
I don&#39;t have anything about this text, but I wonder whether we should<b=
r>
mention the old syntax in the current docs.<br>
Thoughts anyone?<br></blockquote><div><br></div><div>I added this because I=
 (as a new user) found it very confusing to find all the _ style syntax in =
guides online and no mention of it in the docs. I would have expected such =
a note.<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
&gt;=C2=A0 .. _removing-override-style-syntax:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Removal (Override Style Syntax)<br>
&gt; @@ -517,20 +523,22 @@ variable.<br>
&gt;=C2=A0 -=C2=A0 *Selecting a Variable:* The :term:`OVERRIDES` variable i=
s a<br>
&gt;=C2=A0 =C2=A0 =C2=A0colon-character-separated list that contains items =
for which you want<br>
&gt;=C2=A0 =C2=A0 =C2=A0to satisfy conditions. Thus, if you have a variable=
 that is<br>
&gt; -=C2=A0 =C2=A0conditional on &quot;arm&quot;, and &quot;arm&quot; is i=
n :term:`OVERRIDES`, then the<br>
&gt; +=C2=A0 =C2=A0conditional on &quot;arm&quot;, and &quot;arm&quot; is l=
isted in :term:`OVERRIDES`, then the<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;arm&quot;-specific version of the variable is=
 used rather than the<br>
&gt;=C2=A0 =C2=A0 =C2=A0non-conditional version. Here is an example::<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 =C2=A0 OVERRIDES =3D &quot;architecture:os:machine&quot=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 # Typically, OVERRIDES contains something like a=
rchitecture:os:machine<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 OVERRIDES =3D &quot;linux:arm&quot;<br>
<br>
<br>
Here you quote an example with two items, but this doesn&#39;t align with<b=
r>
the typical contents with three items you mention in the comment that<br>
you added.<br>
By the way, according to the below text, didn&#39;t you mean?<br>
<br>
OVERRIDES =3D &quot;foo:linux:arm&quot;<br>
<br>
It looks like a good idea to have this comment; this way you can give a<br>
concrete example. In my opinion, &quot;foo&quot; is vague, what about inste=
ad?<br>
<br>
OVERRIDES =3D &quot;arm:linux:beaglebone&quot;<br></blockquote><div><br></d=
iv><div>Yes, will change that!<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST =3D &quot;default&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 TEST_os =3D &quot;osspecific&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 TEST_nooverride =3D &quot;othercondvalue&quot;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 TEST:arm =3D &quot;armspecific&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 TEST:nooverride =3D &quot;othercondvalue&quot;<b=
r>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0In this example, the :term:`OVERRIDES`<br>
&gt; -=C2=A0 =C2=A0variable lists three overrides: &quot;architecture&quot;=
, &quot;os&quot;, and &quot;machine&quot;.<br>
&gt; -=C2=A0 =C2=A0The variable ``TEST`` by itself has a default value of &=
quot;default&quot;. You<br>
&gt; -=C2=A0 =C2=A0select the os-specific version of the ``TEST`` variable =
by appending<br>
&gt; -=C2=A0 =C2=A0the &quot;os&quot; override to the variable (i.e. ``TEST=
_os``).<br>
&gt; +=C2=A0 =C2=A0In this example, the :term:`OVERRIDES` variable lists th=
ree<br>
&gt; +=C2=A0 =C2=A0overrides: &quot;foo&quot;, &quot;linux&quot;, and &quot=
;arm&quot;. The variable ``TEST`` by itself<br>
&gt; +=C2=A0 =C2=A0has a default value of &quot;default&quot;, and the valu=
e of the =E2=80=9Carm=E2=80=9D specific<br>
&gt; +=C2=A0 =C2=A0version =E2=80=9Carmspecific=E2=80=9D is used because :t=
erm:`OVERRIDES` contains<br>
&gt; +=C2=A0 =C2=A0=E2=80=9Carm=E2=80=9D. The =E2=80=9Cnooverride=E2=80=9D =
specific version is not used because<br>
&gt; +=C2=A0 =C2=A0:term:`OVERRIDES` does not contain =E2=80=9Cnooverride=
=E2=80=9D.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0To better understand this, consider a practical exa=
mple that assumes<br>
&gt;=C2=A0 =C2=A0 =C2=A0an OpenEmbedded metadata-based Linux kernel recipe =
file. The<br>
&gt; @@ -552,7 +560,7 @@ variable.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 DEPENDS =3D &quot;glibc ncurses&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 OVERRIDES =3D &quot;machine:local&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 DEPENDS:append:machine =3D &quot;libmad&quot;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 DEPENDS:append:machine =3D &quot; libmad&quot;<b=
r>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0In this example, :term:`DEPENDS` becomes &quot;glib=
c ncurses libmad&quot;.<br></blockquote><div><br></div><div>Thanks,</div><d=
iv>Simon<br></div></div></div>
</div></div></div>

--0000000000007a5e7605d4d3671a--

