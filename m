Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DABCCA471
	for <webhook@archiver.kernel.org>; Fri,  3 Oct 2025 12:07:10 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
 by mx.groups.io with SMTP id smtpd.web11.5827.1759493226293810334
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Oct 2025 05:07:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PIycNnPr;
 spf=pass (domain: gmail.com, ip: 209.85.160.54, mailfrom: adam.blank.g@gmail.com)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3b15f0027d9so414844fac.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Oct 2025 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759493225; x=1760098025; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X5A7KP6GJZtnw06F9ntPZpCGX4jpk9YOXLETMJHcv2E=;
        b=PIycNnPrZ4olZid8ByUCFDw4nEP3sFzQ43mWYpH/fqUrHh1esGzOfQxDI1gOF9ZopT
         xMwtntCqz1aJe7CNmU+G/X4J0KmgkmzPpvImmp8YeXAfKFjxvooqLec6KR047RZmN3MR
         DZKs0jEhynHvCfB6YEVYzPblxUT+Lgs9FKqRssmcu75e4Iup28rX/XH2K4wJJCLxcDkm
         uBZMg6JN7qb34GoMOtznyXBLfannAZjnSuQwCjofxyyWEG/4/DU5rsnGgLEvWBGPe1Xx
         81ihrAUNC9zqidvvIXo7lcC3YZ4XOxDd33RJo0hegqk0oyxqi9BPsM7N58IUn5tc+Rr4
         yEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759493225; x=1760098025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5A7KP6GJZtnw06F9ntPZpCGX4jpk9YOXLETMJHcv2E=;
        b=G/kMflmTOVo5XxKdALcldNPYXOhRQQtxHsmJgqZpCytUYD5ZZKGx5XHzJ1q8kycojA
         LQL6PCU4StbRNU2gJokA+vnXTaj3uEW/UqbszujcDBS5P7dOyeRpNY6T5Kic4uMZEMKC
         +m6VBDxE+dyEFaWsz3jea/7ylKLsAIQ27b35sooZJ78bjG8UwG0Oq1sfJEJTMS8jbk8i
         DItVIfXSiPbuz2q/Zx8pDnZKFdBGGtgYhiWLPXz6zzUTOjdqmmU4u3aekbxBVef7k8rA
         dpNWe4xsG0xXbcCHUL37CwCnOfFOllHdG75x/IJReNIqYArXB2czAPrTKsjLsu4flggW
         djNQ==
X-Gm-Message-State: AOJu0YzuUe4PV/H2UO1m5uyBXpOonLZVJBhJS26RnzS0mmGw8qn+x94P
	nr0ozW05Etkp6m8aS+LjaAOCbHyau6JNiyRXehh9QnEAJN0qJlk3R0mcFs+ao74U6/P2yDNg/sT
	0rzYVK+dbu9h5XBmDGokK1/U1KjZ8Hdl3Bg==
X-Gm-Gg: ASbGncvWP5REOA2eppv7PHFvm3bKha4Kdox39u7TKb70SDFqDJB0zANNoHjVmoCT75+
	loUsxF2crJ5pPWLOJ0gs5/cjyzIs8FtcVoCf6Fckz4Cf/H/iIrqveqel2iDge6IT0f7Yf1O3XiB
	zuarXCoGNos+wdUFKPLYa9mxgr0z/kqnpkFhM8xJfC4GbqIOfltM26om0jNaYndJ10GqlYu1Rcw
	u3ZwG5lYui0VqdgIx3YzvaDGZjGvE+h
X-Google-Smtp-Source: AGHT+IEhmJbuEs4XnZJd2TT/gLAh+IXoxxuzQwELY/GXJsht5FuQtuEuEZXxHrP7bNaLxjt9tmPcCRuAzhpnMHbgZCA=
X-Received: by 2002:a05:6870:6386:b0:34b:f75a:7d74 with SMTP id
 586e51a60fabf-3b0f9e67673mr1716415fac.42.1759493225374; Fri, 03 Oct 2025
 05:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20251001093743.26710-1-adam.blank.g@gmail.com> <DD8O1G6S52MQ.2RRPD9QVIHT6O@bootlin.com>
In-Reply-To: <DD8O1G6S52MQ.2RRPD9QVIHT6O@bootlin.com>
From: Adam Blank <adam.blank.g@gmail.com>
Date: Fri, 3 Oct 2025 14:06:54 +0200
X-Gm-Features: AS18NWBv3BI2RzzFKSe0rqlS9NibYFcHt3Dn3JUUDM1PxGbr6m6O_iNIQeH2u60
Message-ID: <CAFAffzwZqKTTX6GebYfAWU5dA_gFqmpGAwz8HPRR1S6VGs13xQ@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] doc/bitbake-user-manual-ref-variables:
 improve INHERIT
To: Antonin Godard <antonin.godard@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000aeec0c06403ff0f5"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Oct 2025 12:07:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18131

--000000000000aeec0c06403ff0f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Anonymous Python functions are called either when a recipe is finalised, or
when
Bitbake is called to show just the base configuration, i.e. 'bitbake -e'.
In a normal build those two cases don't coincide, so your proposal is fully
correct,
but perhaps it would be good to hint on why their execution can be observed
in
the 'show environment' case?

Thanks,
Adam

On Fri, 3 Oct 2025 at 13:55, Antonin Godard <antonin.godard@bootlin.com>
wrote:

> On Wed Oct 1, 2025 at 11:37 AM CEST, Adam Blank via lists.openembedded.or=
g
> wrote:
> > Current wording makes it difficult to understand what
> > exactly is done with INHERIT-ed anonymous functions and
> > when.
> >
> > Signed-off-by: Adam Blank <adam.blank.g@gmail.com>
> > ---
> >  doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git
> a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > index 810f88689..9d0cbd71d 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> > @@ -1200,8 +1200,8 @@ overview of their function and contents.
> >
> >     :term:`INHERIT`
> >        Causes the named class or classes to be inherited globally.
> Anonymous
> > -      functions in the class or classes are not executed for the base
> > -      configuration and in each individual recipe. The OpenEmbedded
> build
> > +      functions in the class or classes are executed either for the ba=
se
> > +      configuration, or in each individual parsed recipe. The
> OpenEmbedded build
>
> I ran a quick test, and I do see the anonymous function called for
> individual
> recipes, but I have trouble understanding what the "base configuration"
> is. Does
> this mean the anonymous function is also called in the top-level context =
/
> top-level configuration, with no recipes associated to it?
>
> The original sentence could be interpreted differently IMO, and I would
> have
> phrased it this way:
>
> """
> Anonymous functions in the class or classes are not executed for the base
> configuration but are executed in each individual recipe.
> """
>
> Which is what I observe when testing=E2=80=A6 I don't see any call to it =
without an
> associated recipe.
>
> What do you think?
>
> Thanks,
> Antonin
>
> --
> Antonin Godard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>
>

--000000000000aeec0c06403ff0f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Anonymous Python functions are called either when a recipe is=
 finalised, or when</div><div class=3D"gmail_default" style=3D"font-size:sm=
all">Bitbake is called to show just the base configuration, i.e. &#39;bitba=
ke -e&#39;.</div><div class=3D"gmail_default" style=3D"font-size:small">In =
a normal build those two cases don&#39;t coincide, so your proposal is full=
y correct,</div><div class=3D"gmail_default" style=3D"font-size:small">but =
perhaps it would be good to hint on why their execution can be observed in<=
/div><div class=3D"gmail_default" style=3D"font-size:small">the &#39;show e=
nvironment&#39; case?</div><div class=3D"gmail_default" style=3D"font-size:=
small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Tha=
nks,</div><div class=3D"gmail_default" style=3D"font-size:small">Adam</div>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Fri, 3 Oct 2025 at 13:55, Antonin Godard &lt;<a hr=
ef=3D"mailto:antonin.godard@bootlin.com">antonin.godard@bootlin.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed O=
ct 1, 2025 at 11:37 AM CEST, Adam Blank via <a href=3D"http://lists.openemb=
edded.org" rel=3D"noreferrer" target=3D"_blank">lists.openembedded.org</a> =
wrote:<br>
&gt; Current wording makes it difficult to understand what<br>
&gt; exactly is done with INHERIT-ed anonymous functions and<br>
&gt; when.<br>
&gt;<br>
&gt; Signed-off-by: Adam Blank &lt;<a href=3D"mailto:adam.blank.g@gmail.com=
" target=3D"_blank">adam.blank.g@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | =
4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables=
.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br>
&gt; index 810f88689..9d0cbd71d 100644<br>
&gt; --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt; +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst<br=
>
&gt; @@ -1200,8 +1200,8 @@ overview of their function and contents.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0:term:`INHERIT`<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 Causes the named class or classes to be inh=
erited globally. Anonymous<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 functions in the class or classes are not execut=
ed for the base<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 configuration and in each individual recipe. The=
 OpenEmbedded build<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 functions in the class or classes are executed e=
ither for the base<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 configuration, or in each individual parsed reci=
pe. The OpenEmbedded build<br>
<br>
I ran a quick test, and I do see the anonymous function called for individu=
al<br>
recipes, but I have trouble understanding what the &quot;base configuration=
&quot; is. Does<br>
this mean the anonymous function is also called in the top-level context /<=
br>
top-level configuration, with no recipes associated to it?<br>
<br>
The original sentence could be interpreted differently IMO, and I would hav=
e<br>
phrased it this way:<br>
<br>
&quot;&quot;&quot;<br>
Anonymous functions in the class or classes are not executed for the base<b=
r>
configuration but are executed in each individual recipe.<br>
&quot;&quot;&quot;<br>
<br>
Which is what I observe when testing=E2=80=A6 I don&#39;t see any call to i=
t without an<br>
associated recipe.<br>
<br>
What do you think?<br>
<br>
Thanks,<br>
Antonin<br>
<br>
-- <br>
Antonin Godard, Bootlin<br>
Embedded Linux and Kernel engineering<br>
<a href=3D"https://bootlin.com" rel=3D"noreferrer" target=3D"_blank">https:=
//bootlin.com</a><br>
<br>
</blockquote></div></div>

--000000000000aeec0c06403ff0f5--

