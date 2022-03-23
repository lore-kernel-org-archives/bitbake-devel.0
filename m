Return-Path: <simon.eu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFC7C433EF
	for <webhook@archiver.kernel.org>; Wed, 23 Mar 2022 12:24:39 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web08.8304.1648038278569523630
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Mar 2022 05:24:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=qqcQvryt;
 spf=pass (domain: gmail.com, ip: 209.85.210.179,
 mailfrom: simon.eu@gmail.com)
Received: by mail-pf1-f179.google.com with SMTP id s11so1351139pfu.13
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Mar 2022 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kFukV90qqZVT75iqd0VrhAvSOjTPEUdDnBuaaXZRac=;
        b=qqcQvryt8RE0HYJgXq09bQJbG0lXKKxAd2ldX7KbWG35b/CqUxtVMLcvMt1R9LT3SO
         8XB/BHY1c9NM8DivfDd2qJFaRC27rYzRj0YAEJED+AIjmrc8lJBifDqgogDswSNlJt6+
         u5dG/eSsvsqJ56yoFQRGWBavUxEeFHCfbvZz/IWwdooTswvdKPKylKXqP4c0x3kLkHQc
         qAHuot52uYZDe7m7RBilcBx9VOCEOhMc0Gdp3MDBdigbgozl7BjQTwf1GbwBtrop9cmC
         na7wAt+FKwSD0M2CQGC6veGJtcXQ0zo3cxcDeNJMbpO6hr1dYEpS6fxozTY8kjR2Eput
         P9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kFukV90qqZVT75iqd0VrhAvSOjTPEUdDnBuaaXZRac=;
        b=XbTlPqXcANV5+nJmHU1X53OEJZX9TATVYd8byT82LADibgtNEXNqejdq92B9uBPmgJ
         pmCp5d6piJ884sIu3cI/Iux1RNyYaStukrH9SM/vs7Z4bMlP7EOmtZHRO3IxvVgNoOQO
         /rRifCH90onqhFWE/DieARipJpfHkNuxMqU54w715Q2nw6Qsj31vdL+rIFgzkePFoENs
         KLvc5d1PzCLADnGyekSuNGeuQoFy2UmNJ0uRz0EMFWNDo4kHhcFERAKseQBz7pvZTdwP
         MQzWgb9Y4NBZCMNm/vdJMKrL9QKDCcEyqKXuRrUdtS0fMeUP2o4KZh12MWU+Y0oac3nc
         KdFw==
X-Gm-Message-State: AOAM531nLgiAB6iskgettb7mw8hRAZ74WkRjvFeZxDGzKaqSCC4zIf9W
	pRQJ9Teg7ZSbdiMrgyXUFKQml/EuvnwxUsB3eUw=
X-Google-Smtp-Source: 
 ABdhPJwIanNXKjOYJKOJANRWIiH9ViStiWQ4bdzqr1E56ejhW2cmi695OToSeT3zOoKHwdOIRg4G445oY7Pb94xRy64=
X-Received: by 2002:a05:6a02:182:b0:374:5a57:cbf9 with SMTP id
 bj2-20020a056a02018200b003745a57cbf9mr25271780pgb.616.1648038278000; Wed, 23
 Mar 2022 05:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211215092509.60979-1-simon.eu@gmail.com>
 <42d3ff93-33a1-e751-b0ff-974c8ecb4858@bootlin.com>
 <CAO8d5BY0R2d4Ufvk9cWwx=t95sOcQXs-5NGquP-3AAH8xG-RAg@mail.gmail.com>
 <9e458156-8a40-ce06-986a-8ce39b546712@bootlin.com>
 <CAO8d5BYN7g0oEoPG=CrTt99pQ1-fYkx5bq-RiB_j9E3OBu4K2w@mail.gmail.com>
 <ca5a3aed-e04c-b2b5-65eb-6bb424d0c379@bootlin.com>
 <6035008ce96fb9055547cf0cc2ffa51d2262c9ea.camel@linuxfoundation.org>
In-Reply-To: 
 <6035008ce96fb9055547cf0cc2ffa51d2262c9ea.camel@linuxfoundation.org>
From: Simon Eugster <simon.eu@gmail.com>
Date: Wed, 23 Mar 2022 13:24:26 +0100
Message-ID: 
 <CAO8d5BYO1z76mtrYiXt5P-gg0VZFRgL_b0DcBteuP6WxHpkhnQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [docs] [PATCH] bitbake: doc: bitbake-user-manual:
 Add more explanations to OVERRIDES
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000022f2d805dae1d053"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Mar 2022 12:24:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13498

--00000000000022f2d805dae1d053
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I submitted a patch for only the OVERRIDE part now. (The in-reply-to did
not seem to have an effect =E2=80=93 sorry for that!)

I can submit that part as separate patch and I'm happy to re-phrase or
change it in other ways.

+.. note::
+
+   Before Honister (3.4), override style used ``_`` instead of ``:``, so
you will
+   still find a lot of documentation using =E2=80=9C_append=E2=80=9D, =E2=
=80=9C_prepend=E2=80=9D, and
+   =E2=80=9C_remove=E2=80=9D.

Simon

On Tue, Mar 1, 2022 at 2:33 PM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> On Tue, 2022-03-01 at 09:33 +0100, Michael Opdenacker via
> lists.openembedded.org
> wrote:
> > Hi Simon,
> >
> > On 2/28/22 10:31, Simon A. Eugster wrote:
> > >
> > > On Wed, Jan 5, 2022 at 5:02 PM Michael Opdenacker
> > > <michael.opdenacker@bootlin.com> wrote:
> > >
> > >     Hi Simon,
> > >
> > >     Thanks for your answers...
> > >
> > >     On 1/5/22 11:11 AM, Simon Eugster wrote:
> > >     > Hi Michael,
> > >     >
> > >     >     >
> > >     >     > +.. note::
> > >     >     > +
> > >     >     > +   Before Honister (3.4), override style used ``_``
> > >     instead of
> > >     >     ``:``, so you will
> > >     >     > +   still find a lot of documentation using =E2=80=9C_app=
end=E2=80=9D,
> > >     >     =E2=80=9C_prepend=E2=80=9D, and
> > >     >     > +   =E2=80=9C_remove=E2=80=9D.
> > >     >     > +
> > >     >
> > >     >
> > >     >     I don't have anything about this text, but I wonder whether
> > >     we should
> > >     >     mention the old syntax in the current docs.
> > >     >     Thoughts anyone?
> > >     >
> > >     >
> > >     > I added this because I (as a new user) found it very confusing
> > >     to find
> > >     > all the _ style syntax in guides online and no mention of it in
> the
> > >     > docs. I would have expected such a note.
> > >
> > >
> > >     This makes sense, but so far we just mentioned the old syntax in
> the
> > >     migration guides. That's why I was asking for other opinions...
> > >
> > >
> > > Looks like there are no other opinions on that topic.
> > > In that case, do you want me to continue with the MR and apply your
> > > suggestions, or discard the MR?
> >
> >
> > Well, I'd rather drop the note about the overrides syntax change, but
> > I'm still interested in the rest of the patch.
>
> Since you asked for opinions, I think some mention of this in the overrid=
es
> section of the bitbake manual would be a good idea since it was such a
> fundamental change?
>
> Cheers,
>
> Richard
>
>
>
>
>
>

--00000000000022f2d805dae1d053
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I submitted a patch for only the OVERRIDE part now. (=
The in-reply-to did not seem to have an effect =E2=80=93 sorry for that!)</=
div><div><br></div><div>I can submit that part as separate patch and I&#39;=
m happy to re-phrase or change it in other ways.<br></div><div><br></div><d=
iv>+.. note::<br>+<br>+ =C2=A0 Before Honister (3.4), override style used `=
`_`` instead of ``:``, so you will<br>+ =C2=A0 still find a lot of document=
ation using =E2=80=9C_append=E2=80=9D, =E2=80=9C_prepend=E2=80=9D, and<br>+=
 =C2=A0 =E2=80=9C_remove=E2=80=9D.<br></div><div><br></div><div>Simon<br></=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Tue, Mar 1, 2022 at 2:33 PM Richard Purdie &lt;<a href=3D"mailto:ric=
hard.purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, =
2022-03-01 at 09:33 +0100, Michael Opdenacker via <a href=3D"http://lists.o=
penembedded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.or=
g</a><br>
wrote:<br>
&gt; Hi Simon,<br>
&gt; <br>
&gt; On 2/28/22 10:31, Simon A. Eugster wrote:<br>
&gt; &gt; <br>
&gt; &gt; On Wed, Jan 5, 2022 at 5:02 PM Michael Opdenacker<br>
&gt; &gt; &lt;<a href=3D"mailto:michael.opdenacker@bootlin.com" target=3D"_=
blank">michael.opdenacker@bootlin.com</a>&gt; wrote:<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Hi Simon,<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Thanks for your answers...<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0On 1/5/22 11:11 AM, Simon Eugster wrote:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi Michael,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +.. note::<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0Bef=
ore Honister (3.4), override style used ``_``<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0instead of<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0``:``, so you will<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0sti=
ll find a lot of documentation using =E2=80=9C_append=E2=80=9D,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0=E2=80=9C_prepend=E2=
=80=9D, and<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +=C2=A0 =C2=A0=E2=
=80=9C_remove=E2=80=9D.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0&gt; +<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t have anyth=
ing about this text, but I wonder whether<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0we should<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0mention the old syntax=
 in the current docs.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0 =C2=A0Thoughts anyone?<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; I added this because I (as a new user) fo=
und it very confusing<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0to find<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; all the _ style syntax in guides online a=
nd no mention of it in the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; docs. I would have expected such a note.<=
br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0This makes sense, but so far we just mentioned=
 the old syntax in the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0migration guides. That&#39;s why I was asking =
for other opinions...<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Looks like there are no other opinions on that topic.<br>
&gt; &gt; In that case, do you want me to continue with the MR and apply yo=
ur<br>
&gt; &gt; suggestions, or discard the MR?<br>
&gt; <br>
&gt; <br>
&gt; Well, I&#39;d rather drop the note about the overrides syntax change, =
but<br>
&gt; I&#39;m still interested in the rest of the patch.<br>
<br>
Since you asked for opinions, I think some mention of this in the overrides=
<br>
section of the bitbake manual would be a good idea since it was such a<br>
fundamental change?<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--00000000000022f2d805dae1d053--

