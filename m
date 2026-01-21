Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C50C44506
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 19:07:53 +0000 (UTC)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19902.1769022464405994306
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 11:07:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VyKx3nfr;
 spf=pass (domain: gmail.com, ip: 74.125.82.49, mailfrom: rybczynska@gmail.com)
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12460a7caa2so293394c88.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 11:07:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769022464; cv=none;
        d=google.com; s=arc-20240605;
        b=CkcQ8/9AGYpIOQV4tJdLzf4jqo3huUIZQp2yZdSBzkd9Go7Vk84PiE/p2SWTfxdkN/
         iRy4U+oBvw/yXure5nZ3FERnAEVEpto+0i9FYAWStNy38ntZDi95H7USlUPvVhfua60R
         LeyxGpYfHQf5eAmzuEvdvrbNuRIxKEflgE5YK7Uvd9r3NUsw6OTt6wmPNbulrpC2zfPg
         1pdrhP477sLi8TL59c+KZkhTAbylY1D/xbaNtE2BoOQjAftZbZqLvt3OgpACxMWm1hSx
         5+AGVvV8ChYSltDwDPtsTVHV25DUZnApe8XCZa/p8yTL8pDenT0rvhxWcGrZkJdHVY+/
         AFMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CYhcjog6V09ezuuLcgP5l3lk3gfm/MyHas/1BDTKYhs=;
        fh=kwhZ3Li+yPVxdlH3ayfQoAuPa3/pJuSlz2Co5M6h6T8=;
        b=dCbC6OFR2zADxkmWwtp5QdZHUZXf1S8Jz3mM3DA5OASFsd4GBMf7uBmJE7MxVk6cd0
         fEi9YSY2qav5e2NfZkxYz8EQdsYJ9Tf7X2+T/PMwu95aZreBsH+RvCgZ+IDJJOjUhQxD
         Y7vl0s00MWPkS7j/vWDJknR4Oe6SBJZBxw+1efsl0mnhEd+5P6UDanueGmnneOuw5hUw
         f/vJGDMNlW3wjKkGvOznHjH3OQcbGj9GcjA0PJ3vCwQVdeFqQ1NGquylT4jcg4e86Oy6
         P6z0/o3FyPOM8NFNP1knzr6Chazj81TgieL+pxY+pIsf1Vp87eLpdFOqeYe9Fp1ws13D
         WQAQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769022464; x=1769627264; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CYhcjog6V09ezuuLcgP5l3lk3gfm/MyHas/1BDTKYhs=;
        b=VyKx3nfr3BrMlssUIs3ynCgBmPGIu35U4HNEocJ5yS+mInLGf9QcwuqQQltincg4gI
         1XCMMznUORqKXKkhav3gu85UTF5KluiSSjxI30KJWx2H4juaOh5eDZvO9lnzXNO3or+M
         hrbLHiGIK1bsWoAmRThiMD0aWHyH+45yRO2Qew+ezG1MNQ4znAvo6oKuuxf0dov1hiGC
         k82ONllPY10f3Mq6YMCcMD+rJ5xyThx0ieF4fMrbd8XAI9wQYEpO4OclS9BntLA3YVlh
         M/xYsS3vUU6oyDvGQS5VL8pjWoqfYsFShxHpFs79llecXS586vXZ1lqzpBbRIMKqWl4h
         kWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769022464; x=1769627264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYhcjog6V09ezuuLcgP5l3lk3gfm/MyHas/1BDTKYhs=;
        b=nbrrrFV00jZ7DzQCYEYNeF0N3QM9zrzNvOSA2wNelQaoWeQvDakecuGN/TkDLPviwe
         xsQtkom3rvNyqTal8rc6SGXem8/u6NA/+VU0QtdSiJwsWWgFxLqlYI0OWAlC7aMHyibV
         lL4eFalC9HjV2lcxNYDT6oCrebHbwXzTj1ZnWzCWypedJ7/YIjSJma+7KVAdvAog+Mjf
         uSroRLuki+SqJOxKGnkdsSpzw9JJIw78tmng73frNno+1AKm2DICuker0PHZk6dISYwn
         H197GSPQNBnGyvQ8mOaUsALIXVF/iOF9tarjHlh4hh6uVJOmnt2V7TWS9sPsHJ77p/71
         c+AQ==
X-Gm-Message-State: AOJu0Ywjl5R6gthOiVSJL8mSo+GUW4hJ4mnvfWk82UmzVXZRnOJpPtyO
	MqIduZRGp9Sj0LD9ZwBMX5P+MspcVnO2rVPAlnuHt66xJMebWjax5CDrTXJjqDgTefXfuk3LFf2
	PZxRjc/6PhGZgQ3HU/wx8AbBdC2xi55k=
X-Gm-Gg: AZuq6aIWxVuL9+sTCJuyBWGKxjBm0n4Z4PdLz9600sHQVsijpW1Fn2028B/E1E8fK0Q
	2LR9ib0cCYTB1QUVDCjBqVhzK0fCr5xtGJczn1enR4Q5qAjFBbVScWDDD/jg7SKyzfPiaTVv3VZ
	tA9M5rvInoaZWEXgpyn1H1UuLcR0WIEkuxf0DuULw+Zj9ePwrzEkhjd0k4DXwEjo8eR4P2yIj5j
	fNvdfZsSHzWlWmXM3Hyd8Ae1Jh/cX49syA2slL9bTo2QsTusNt2Ye+QF7yzbJB5A3Jg6fBk1Zjw
	83KmW4OghVB+dc3o0a3rTsoNGfaKPOd31io6lGbRd29X66pEhWpapcRZpUo=
X-Received: by 2002:a05:7022:b88e:b0:11b:aca4:be1f with SMTP id
 a92af1059eb24-1244b31eca9mr9891141c88.17.1769022463617; Wed, 21 Jan 2026
 11:07:43 -0800 (PST)
MIME-Version: 1.0
References: <188CD19B4A7A27E1.3547823@lists.openembedded.org> <80835073604216efd7372b2b019f3d4463f11e0e.camel@linuxfoundation.org>
In-Reply-To: <80835073604216efd7372b2b019f3d4463f11e0e.camel@linuxfoundation.org>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Wed, 21 Jan 2026 20:07:32 +0100
X-Gm-Features: AZwV_Qj7aQVJ4OHEw2qp2Nsvpsa0QyueuI5GbkmhoKgli689uNuPpZsRbn-PJts
Message-ID: <CAApg2=SyaJyU=SFTKnYZXBsApc6Abgff+upMnAePdEEend5-Pg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch2/npm/npmsw: Disable npm and npmsw
 fetchers due to security concerns
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="0000000000008b2f810648eaa346"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 19:07:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18841

--0000000000008b2f810648eaa346
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Jan 2026, 19:44 Richard Purdie via lists.openembedded.org,
<richard.purdie=linuxfoundation.org@lists.openembedded.org> wrote:

> On Wed, 2026-01-21 at 18:13 +0000, Richard Purdie via
> lists.openembedded.org wrote:
> > We've been made aware that are security issues within the npm/npmsw
> fetchers.
> > The issue is that the code accepts data like checksums from the upstream
> > servers, rather than verifying it against local data from the recipes.
> This
> > means the upstream servers could feed aritrary data into the build.
> >
> > There have been maintainance issues on these fetchers for a while and
> despite
> > asking in multiple forums, we've been unable to find anyone to help fix
> the
> > issues. Until that issue is resolved and we can be convinced the fetcher
> is
> > secure and modelling best practices for reproduciblity (inc. mirroring),
> this
> > patch disables the fetchers. This has been discussed and agreed by the
> OE TSC.
> >
> > Parsing will not show errors but the recipes using these fetchers will
> not be
> > available. Recipes will be skipped at parsing amd will show an error if
> a user
> > tries to build a recipe using them.
> >
> > [YOCTO #16105]
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/fetch2/npm.py   | 5 ++++-
> >  lib/bb/fetch2/npmsw.py | 4 ++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> > index e469d667687..15057da7d3f 100644
> > --- a/lib/bb/fetch2/npm.py
> > +++ b/lib/bb/fetch2/npm.py
> > @@ -39,6 +39,7 @@ from bb.fetch2 import URI
> >  from bb.fetch2 import check_network_access
> >  from bb.fetch2 import runfetchcmd
> >  from bb.utils import is_semver
> > +from bb.parse import SkipRecipe
> >
> >  def npm_package(package):
> >      """Convert the npm package name to remove unsupported character"""
> > @@ -150,7 +151,9 @@ class Npm(FetchMethod):
> >
> >      def supports(self, ud, d):
> >          """Check if a given url can be fetched with npm"""
> > -        return ud.type in ["npm"]
> > +        #return ud.type in ["npm"]
> > +        if ud.type in ["npm"]:
> > +            raise SkipRecipe("The npm fetcher has been disabled due to
> security issues and there is maintainer to address them")
>
> I will fix this to say "there is no maintainer to address them" on both
> messages.
>

Thanks Richard, there's also a typo in the commit message "amd" -> and if
you're rebasing.

Cheers,
Marta

>

--0000000000008b2f810648eaa346
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 21 Jan 2026, 19:44 Richa=
rd Purdie via <a href=3D"http://lists.openembedded.org">lists.openembedded.=
org</a>, &lt;richard.purdie=3D<a href=3D"mailto:linuxfoundation.org@lists.o=
penembedded.org">linuxfoundation.org@lists.openembedded.org</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">On Wed, 2026-01-21 at 18:13 +0000, =
Richard Purdie via <a href=3D"http://lists.openembedded.org" rel=3D"norefer=
rer noreferrer" target=3D"_blank">lists.openembedded.org</a> wrote:<br>
&gt; We&#39;ve been made aware that are security issues within the npm/npms=
w fetchers.<br>
&gt; The issue is that the code accepts data like checksums from the upstre=
am<br>
&gt; servers, rather than verifying it against local data from the recipes.=
 This<br>
&gt; means the upstream servers could feed aritrary data into the build.<br=
>
&gt; <br>
&gt; There have been maintainance issues on these fetchers for a while and =
despite<br>
&gt; asking in multiple forums, we&#39;ve been unable to find anyone to hel=
p fix the<br>
&gt; issues. Until that issue is resolved and we can be convinced the fetch=
er is<br>
&gt; secure and modelling best practices for reproduciblity (inc. mirroring=
), this<br>
&gt; patch disables the fetchers. This has been discussed and agreed by the=
 OE TSC.<br>
&gt; <br>
&gt; Parsing will not show errors but the recipes using these fetchers will=
 not be<br>
&gt; available. Recipes will be skipped at parsing amd will show an error i=
f a user<br>
&gt; tries to build a recipe using them.<br>
&gt; <br>
&gt; [YOCTO #16105]<br>
&gt; <br>
&gt; Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@lin=
uxfoundation.org" target=3D"_blank" rel=3D"noreferrer">richard.purdie@linux=
foundation.org</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0lib/bb/fetch2/npm.py=C2=A0=C2=A0 | 5 ++++-<br>
&gt; =C2=A0lib/bb/fetch2/npmsw.py | 4 ++++<br>
&gt; =C2=A02 files changed, 8 insertions(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py<br>
&gt; index e469d667687..15057da7d3f 100644<br>
&gt; --- a/lib/bb/fetch2/npm.py<br>
&gt; +++ b/lib/bb/fetch2/npm.py<br>
&gt; @@ -39,6 +39,7 @@ from bb.fetch2 import URI<br>
&gt; =C2=A0from bb.fetch2 import check_network_access<br>
&gt; =C2=A0from bb.fetch2 import runfetchcmd<br>
&gt; =C2=A0from bb.utils import is_semver<br>
&gt; +from bb.parse import SkipRecipe<br>
&gt; =C2=A0<br>
&gt; =C2=A0def npm_package(package):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &quot;&quot;&quot;Convert the npm package nam=
e to remove unsupported character&quot;&quot;&quot;<br>
&gt; @@ -150,7 +151,9 @@ class Npm(FetchMethod):<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 def supports(self, ud, d):<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &quot;&quot;&quot;Che=
ck if a given url can be fetched with npm&quot;&quot;&quot;<br>
&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ud.type in [&quot;n=
pm&quot;]<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #return ud.type in [&quot;=
npm&quot;]<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.type in [&quot;npm&q=
uot;]:<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ra=
ise SkipRecipe(&quot;The npm fetcher has been disabled due to security issu=
es and there is maintainer to address them&quot;)<br>
<br>
I will fix this to say &quot;there is no maintainer to address them&quot; o=
n both<br>
messages.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Thanks Richard, there&#39;s also a typo in the commit message &qu=
ot;amd&quot; -&gt; and if you&#39;re rebasing.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Cheers,</div><div dir=3D"auto">Marta</div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
</blockquote></div></div></div>

--0000000000008b2f810648eaa346--

