Return-Path: <simon.eu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296ACC433EF
	for <webhook@archiver.kernel.org>; Thu, 31 Mar 2022 14:08:29 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.7413.1648735708422072216
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 07:08:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=GpOAewAR;
 spf=pass (domain: gmail.com, ip: 209.85.210.169,
 mailfrom: simon.eu@gmail.com)
Received: by mail-pf1-f169.google.com with SMTP id bo5so2650784pfb.4
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Mar 2022 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gx6iYBZaFAsH30PZlmOR7I5sDZ6/H3NrdsmRflXk6B8=;
        b=GpOAewAR8DJdQ7HosU5CGe6SCP+o4Dzhc59o2/Ql6wkKC0pO+WxHfPwy+537FhdbLb
         EoXZi6sqxFcm7skCIB1dzh8h0PwAwBwvN0gUKqyNiIzd7BcZj6v8847g5gTqbtzDy+cz
         ciD29dte/aNCXygwwmGcOz2h7kR8ZXajqloRhpSFBIRc+FgMTwo/Lk/XCs1Lr1u4hU5j
         pSIh38slQIrvQ3w0LXZOj568CrHAKhWAip0kEPTiaUytY9dVtbPzZq9LxFaGsWEvsYiV
         OGg0i3YTgvpJi3DUQVotknHYLUAGdW4hbcCt4b37YaBBUAubYfYJemlWWn/giCYgjK7O
         8tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gx6iYBZaFAsH30PZlmOR7I5sDZ6/H3NrdsmRflXk6B8=;
        b=pSbK2UVWpdespGyKCToDUA8oQmiSsFPoXk/Wor+cnMiV3T+SWGXzMGXMo3Z/Ybjuc2
         0kRWyCRXPxC9CM/e1XeYGI+yEOKgr0Sbm5eMJPA9m6RLh0pb1EzlY3G86wD2KlRR5J0g
         lFvlwcQbfeNr0i/jmnJAi5e0D2rbmgnt/9+0mBaAy/Q+jz3Zy/65UChr4drWAbXIERkl
         DnE8h1TOFLe2bYw09E1S33HE71oTa2Uv1kFnL6IKOInzptAc+ekLEOk0JaYoYqMfucBv
         HPUrmC8aADL6VOjKUpDJsUeQU0Ga1VRDWA0DMChrzlUg6pQjIRQk4fFeW4k4yumTz3k4
         jzng==
X-Gm-Message-State: AOAM530lY8tyoEpg9rO4xqolSsO24lteAL5TDtZosAp0Jd6RpPYTqTrY
	eJONLxdqrBo3G3Bzw+mQDTf5kXhBXJ6bHn/OGuQAgbOV
X-Google-Smtp-Source: 
 ABdhPJxoiRngtfiYu+0Tlnhln+NEoEd6fOqFyCoQU0LK0McnTz3LGFtOr1LJmFxFoIvq+thWIfm56DADu4NEQkOzXRw=
X-Received: by 2002:a63:cf52:0:b0:36c:8e67:45c9 with SMTP id
 b18-20020a63cf52000000b0036c8e6745c9mr11114466pgj.542.1648735707795; Thu, 31
 Mar 2022 07:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <bb55d51b-1563-07b3-b21c-ba982e811615@bootlin.com>
 <20220329143748.297881-1-simon.eu@gmail.com>
 <bb5d84ce-8424-3d40-2ace-5a68bbe260b6@bootlin.com>
In-Reply-To: <bb5d84ce-8424-3d40-2ace-5a68bbe260b6@bootlin.com>
From: Simon Eugster <simon.eu@gmail.com>
Date: Thu, 31 Mar 2022 16:08:16 +0200
Message-ID: 
 <CAO8d5BbqYEpcZJvcCvLMJ5xWf683VOK_fNgWaVPSkOeEVNVorw@mail.gmail.com>
Subject: Re: [docs] [PATCH] bitbake: doc: bitbake-user-manual: Add more
 explanations to OVERRIDES
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
Content-Type: multipart/alternative; boundary="00000000000031164705db843216"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Mar 2022 14:08:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13558

--00000000000031164705db843216
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, Mar 29, 2022 at 7:11 PM Michael Opdenacker <
michael.opdenacker@bootlin.com> wrote:

> Hi Simon,
>
> Thanks for the patch update. See my comments below.
>
> On 3/29/22 16:37, Simon A. Eugster wrote:
> > Signed-off-by: Simon A. Eugster <simon.eu@gmail.com>
> > ---
> >  .../bitbake-user-manual-metadata.rst          | 26 ++++++++++++-------
> >  1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> > index ea42d77c..7d7d99c2 100644
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
> >  .. _removing-override-style-syntax:
> >
> >  Removal (Override Style Syntax)
>
>
> As discussed previously, we already have such as statement elsewhere in
> the same file (currently:
>
> https://git.openembedded.org/bitbake/tree/doc/bitbake-user-manual/bitbake=
-user-manual-metadata.rst#n590
> ).
>

Sorry, not sure how that slipped into the patch again, I had previously
removed it. Should be fixed now! :)

(Would be a bit easier with MRs on something like GitLab O:-))

Thanks and sorry for the countless retries,
Simon

--00000000000031164705db843216
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Michael,<br></div><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 29, 2022 at 7:11 PM Michae=
l Opdenacker &lt;<a href=3D"mailto:michael.opdenacker@bootlin.com">michael.=
opdenacker@bootlin.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Hi Simon,<br>
<br>
Thanks for the patch update. See my comments below.<br>
<br>
On 3/29/22 16:37, Simon A. Eugster wrote:<br>
&gt; Signed-off-by: Simon A. Eugster &lt;<a href=3D"mailto:simon.eu@gmail.c=
om" target=3D"_blank">simon.eu@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../bitbake-user-manual-metadata.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 | 26 ++++++++++++-------<br>
&gt;=C2=A0 1 file changed, 17 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst<br>
&gt; index ea42d77c..7d7d99c2 100644<br>
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
&gt;=C2=A0 .. _removing-override-style-syntax:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Removal (Override Style Syntax)<br>
<br>
<br>
As discussed previously, we already have such as statement elsewhere in<br>
the same file (currently:<br>
<a href=3D"https://git.openembedded.org/bitbake/tree/doc/bitbake-user-manua=
l/bitbake-user-manual-metadata.rst#n590" rel=3D"noreferrer" target=3D"_blan=
k">https://git.openembedded.org/bitbake/tree/doc/bitbake-user-manual/bitbak=
e-user-manual-metadata.rst#n590</a>).<br></blockquote><div><br></div><div>S=
orry, not sure how that slipped into the patch again, I had previously remo=
ved it. Should be fixed now! :)</div><div><br></div><div>(Would be a bit ea=
sier with MRs on something like GitLab O:-))</div><div><br></div><div>Thank=
s and sorry for the countless retries,</div><div>Simon <br></div></div></di=
v>

--00000000000031164705db843216--

