Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2180CCA470
	for <webhook@archiver.kernel.org>; Wed,  8 Oct 2025 10:40:44 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web11.12542.1759920035752566420
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Oct 2025 03:40:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BGsWvmRK;
 spf=pass (domain: gmail.com, ip: 209.85.160.54, mailfrom: adam.blank.g@gmail.com)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-36c9859b036so558831fac.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 08 Oct 2025 03:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759920035; x=1760524835; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ImqJ2PIAffLU4GG6s05Fuvoz0YXR8PASNj6habwlGTQ=;
        b=BGsWvmRKHX/GgXhZ+hZdVx1Vvg2K+J4HmQKEDXpVzpnyXFnpJplwvzMrHW1Jm3EGLU
         WV+fabhS/FXAoxRFZ4QUZxmZ4VjpzvaiZZ6+75DkHFkiCwzThRMEve3uol064Nv8zMWA
         mQuWuf7qNdkwZpL8yUdzmkfg6SifYSnue/WlgY9W7saf5VMobpgEjQp2smDv/JoPUODL
         5zGb3QgmsX8NpPiVvZyjg8sv2uIAJ6tv8AzDv6mp+0D4r207w5W7f6DykvTow/6xO0ot
         ifHUn9bA8RquKURyhmP0ovCJbhXHJX5NEzfcs7yT47onfiUA60EY3QytfPyGuWQyJAjC
         FPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920035; x=1760524835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImqJ2PIAffLU4GG6s05Fuvoz0YXR8PASNj6habwlGTQ=;
        b=mMoJkTmL+1lopap9NAsh5AO8sLkzk/Ytl8WKG4RiUvt8P0sYqSd/RC2PHNQmw9A71S
         ShMkFOnwmnz0GPOK26Z+PoRSDNSaP+WYKTBtxsjuyv0WVgl54pgqSwiKJEPxeDikofKq
         oDl3Rq3byHbgCNha2HeGmC8H9CO/wKlypNWWtQzjkB7hDjjbsjqDfQj7/elQunF5y0zb
         QnAlkGgy8OGmmms6LG+W+Tknv3fCEpQUn5b/iNcEgI+FUaPmxWM58gK72uiho92OUQpm
         VIQX1tZWn7HtJfEN5uCmvmT8UA2MM8oruU3jZqPDn7PpsDG3t14OlPMPtgwWiavYl7bG
         4oXg==
X-Gm-Message-State: AOJu0YxhhnBzhzU9tGQUM9PBj++Mg61ABLTLJT8W7ir55c+egKihMiO3
	eFk2qZhksvTECTyjWbExRsDMCNDPrnGen9FFKL2hLzMBrQAV2DDdKnQT1i4wCyRB8TPwV98KKzN
	Nk0ryUfzWu1m4GlzOdFhdmngnt445mwNs3Q==
X-Gm-Gg: ASbGncsg4ottxcPHRGeGt1oBbIVyTYMtMMNNhcBeqZ1Qb7nap+l1wJWY3SficLGnVea
	lHsxEKgEWZGdbbtjMStsIMr0r4LskCf91/AfkhKBLE7ShSA4vN38XVrlyFi7RpOKaSRnIm2xjJY
	VWG9DwbZUheLeWTRaa+VSS235BHZH6JTO6IGF5V0OYmn0PQvXFAZ0QQuLsV8wgUUlsWSSPou+0Y
	LNQy44ViMnCYgrlq3G63H93agpOC7rXGgmnS0Fx6Y3r
X-Google-Smtp-Source: AGHT+IEqsOdqazvQAUpkv0YYuJYUlLgEyX0ALObXDsjV+Z0npfX3BK59hW+yJjnyhLzdbFa+RxrAwcoJHKFnu8hJMAc=
X-Received: by 2002:a05:6870:d29e:b0:345:ee86:3565 with SMTP id
 586e51a60fabf-3c11483e0e5mr1383832fac.4.1759920034912; Wed, 08 Oct 2025
 03:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251006181951.39364-1-adam.blank.g@gmail.com> <DDCTRS0A6C72.13SF4HEOH56TD@bootlin.com>
In-Reply-To: <DDCTRS0A6C72.13SF4HEOH56TD@bootlin.com>
From: Adam Blank <adam.blank.g@gmail.com>
Date: Wed, 8 Oct 2025 12:40:23 +0200
X-Gm-Features: AS18NWAkrQ9WWTHW6j7ZyP7oYKRCltrLCW5TKFLA2iXVsFL4Om5s_3P5DWQZuec
Message-ID: <CAFAffzzR=DYqbtaGVun07AeCw8yMcj+aNDLCPv0WTx+U1v27SA@mail.gmail.com>
Subject: Re: [PATCH v3] doc/bitbake-user-manual-ref-variables: improve INHERIT
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000839fb00640a3500b"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 08 Oct 2025 10:40:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18144

--000000000000839fb00640a3500b
Content-Type: text/plain; charset="UTF-8"

Right, thanks for the tips :) I've sent a V4 of this patch.
On a side note, would it make sense to chase other references to
OpenEmbedded in BitBake's documentation?

Thanks,
Adam

On Wed, 8 Oct 2025 at 11:15, Antonin Godard <antonin.godard@bootlin.com>
wrote:

> On Mon Oct 6, 2025 at 8:19 PM CEST, Adam Blank wrote:
> > Current wording makes it difficult to understand what
> > exactly is done with INHERIT-ed anonymous functions and
> > when.
> >
> > Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
> > Reviewed-by: Antonin Godard <antonin.godard@bootlin.com>
> > ---
> > Changes in v2:
> > - Added reference to Parsing The Base Configuration Metadata
> > - Emphasised how disjoint the cases are
> > Changes in v3:
> > - Regenerate the patch previously corrupted by Emacs
> >
> > ---
> >  .../bitbake-user-manual-ref-variables.rst         | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git
> a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > index 810f88689..06d48dd47 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > @@ -1200,9 +1200,18 @@ overview of their function and contents.
> >
> >     :term:`INHERIT`
> >        Causes the named class or classes to be inherited globally.
> Anonymous
> > -      functions in the class or classes are not executed for the base
> > -      configuration and in each individual recipe. The OpenEmbedded
> build
> > -      system ignores changes to :term:`INHERIT` in individual recipes.
> > +      functions in the class or classes are executed in two disjoint
> situations:
> > +
> > +      - When only the
> > +     :ref:`base configuration
> <bitbake-user-manual/bitbake-user-manual-execution:parsing the base
> configuration metadata>`
> > +     is parsed as a result of the following BitBake invocation::
> > +
> > +       $ bitbake -e
>
> I guess this is _one_ of the situations where this can happen. Maybe,
> rephrase
> to:
>
> """
> ... is parsed. For example, as a result of the following BitBake
> invocation::
> """
>
> > +
> > +      - When recipes are parsed - then for each parsed recipe.
> > +
> > +      The OpenEmbedded build system ignores changes to :term:`INHERIT`
> > +      in individual recipes.
>
> This is the Bitbake documentation and Bitbake is not only used by the
> OpenEmbedded build system, so we can't have OpenEmbedded references here.
> So you
> could rephrase to:
>
> """
> BitBake ignores changes to ...
> """
>
> Otherwise some documentation syntax nitpicks, not important but for next
> time
> you will know :) :
>
> * We put two spaces after the "-", like so:
>
>   """
>   -  one
>   -  two
>   """
>
> * We indent code blocks with three spaces usually, like so:
>
>   """
>   Here is a code block::
>
>      code
>   """
>
> See
> https://git.yoctoproject.org/yocto-docs/tree/documentation/standards.md.
> We
> try to follow those.
>
> Thanks!
> Antonin
>
> --
> Antonin Godard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

--000000000000839fb00640a3500b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Rig=
ht, thanks for the tips :) I&#39;ve sent a V4 of this patch.</div><div clas=
s=3D"gmail_default" style=3D"font-size:small">On a side note, would it make=
 sense to chase other references to OpenEmbedded in BitBake&#39;s documenta=
tion?</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div=
><div class=3D"gmail_default" style=3D"font-size:small">Thanks,</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">Adam</div></div><br><div c=
lass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_=
attr">On Wed, 8 Oct 2025 at 11:15, Antonin Godard &lt;<a href=3D"mailto:ant=
onin.godard@bootlin.com">antonin.godard@bootlin.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">On Mon Oct 6, 2025 at 8:=
19 PM CEST, Adam Blank wrote:<br>
&gt; Current wording makes it difficult to understand what<br>
&gt; exactly is done with INHERIT-ed anonymous functions and<br>
&gt; when.<br>
&gt;<br>
&gt; Signed-off-by: Adam Blank &lt;<a href=3D"mailto:adam.blank.g@gmail.com=
" target=3D"_blank">adam.blank.g@gmail.com</a>&gt;<br>
&gt; Reviewed-by: Antonin Godard &lt;<a href=3D"mailto:antonin.godard@bootl=
in.com" target=3D"_blank">antonin.godard@bootlin.com</a>&gt;<br>
&gt; ---<br>
&gt; Changes in v2:<br>
&gt; - Added reference to Parsing The Base Configuration Metadata<br>
&gt; - Emphasised how disjoint the cases are<br>
&gt; Changes in v3:<br>
&gt; - Regenerate the patch previously corrupted by Emacs<br>
&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../bitbake-user-manual-ref-variables.rst=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 15 ++++++++++++---<br>
&gt;=C2=A0 1 file changed, 12 insertions(+), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=
.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
&gt; index 810f88689..06d48dd47 100644<br>
&gt; --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt; +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt; @@ -1200,9 +1200,18 @@ overview of their function and contents.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0:term:`INHERIT`<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Causes the named class or classes to be inh=
erited globally. Anonymous<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 functions in the class or classes are not execut=
ed for the base<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 configuration and in each individual recipe. The=
 OpenEmbedded build<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 system ignores changes to :term:`INHERIT` in ind=
ividual recipes.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 functions in the class or classes are executed i=
n two disjoint situations:<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 - When only the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0:ref:`base configuration &lt;bitbake-user-manual/=
bitbake-user-manual-execution:parsing the base configuration metadata&gt;`<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0is parsed as a result of the following BitBake in=
vocation::<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0$ bitbake -e<br>
<br>
I guess this is _one_ of the situations where this can happen. Maybe, rephr=
ase<br>
to:<br>
<br>
&quot;&quot;&quot;<br>
... is parsed. For example, as a result of the following BitBake invocation=
::<br>
&quot;&quot;&quot;<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 - When recipes are parsed - then for each parsed=
 recipe.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 The OpenEmbedded build system ignores changes to=
 :term:`INHERIT`<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 in individual recipes.<br>
<br>
This is the Bitbake documentation and Bitbake is not only used by the<br>
OpenEmbedded build system, so we can&#39;t have OpenEmbedded references her=
e. So you<br>
could rephrase to:<br>
<br>
&quot;&quot;&quot;<br>
BitBake ignores changes to ...<br>
&quot;&quot;&quot;<br>
<br>
Otherwise some documentation syntax nitpicks, not important but for next ti=
me<br>
you will know :) :<br>
<br>
* We put two spaces after the &quot;-&quot;, like so:<br>
<br>
=C2=A0 &quot;&quot;&quot;<br>
=C2=A0 -=C2=A0 one<br>
=C2=A0 -=C2=A0 two<br>
=C2=A0 &quot;&quot;&quot;<br>
<br>
* We indent code blocks with three spaces usually, like so:<br>
<br>
=C2=A0 &quot;&quot;&quot;<br>
=C2=A0 Here is a code block::<br>
<br>
=C2=A0 =C2=A0 =C2=A0code<br>
=C2=A0 &quot;&quot;&quot;<br>
<br>
See <a href=3D"https://git.yoctoproject.org/yocto-docs/tree/documentation/s=
tandards.md" rel=3D"noreferrer" target=3D"_blank">https://git.yoctoproject.=
org/yocto-docs/tree/documentation/standards.md</a>. We<br>
try to follow those.<br>
<br>
Thanks!<br>
Antonin<br>
<br>
-- <br>
Antonin Godard, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
<br>
</blockquote></div>

--000000000000839fb00640a3500b--

