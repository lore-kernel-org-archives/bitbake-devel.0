Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABA2C76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 10:05:44 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.154703.1680775538515442774
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Apr 2023 03:05:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Afc8R2tU;
 spf=pass (domain: gmail.com, ip: 209.85.208.174, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-lj1-f174.google.com with SMTP id s20so19856223ljp.7
        for <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680775537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyDVJKWc65zl97OGERhk8WiwLUvYuJleHLhLvGub9h0=;
        b=Afc8R2tUX2TZvcJRB5HrfOyT0uKsTZgmthC0A7PbJDYLHpvODQ5VD8wUj0EqkGbi2m
         h+gkOYF4vd6tt4tlQ0aZNL9hDaDNaE0yvaD2NPHAuOxoXTGwg3M7L+RsnyeXDArZHbgg
         CsxVVWcFe70Veg+oloeHiwk02tBxCyF/8RbZ/UK8ybwWHIm2bOmitgnciH5poEYiLh3G
         efgGWYVKvVij3v8ziTd/YYdeQGkeAUiqE5TIVg2d4PvT7lHR8V7KldX+PwOxADkoFOsI
         dmAvEE2lnocIMPdx444KHO2ArevXg8dUWtGJ5m3EpgNps7uXDZrPAhWgaOlMhZOLcpyg
         YA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680775537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyDVJKWc65zl97OGERhk8WiwLUvYuJleHLhLvGub9h0=;
        b=smcm95Z0xMBJTrHMPdb93c1YZCNlzaSaFBbNUncki/bSNI2F5C9eaM4kPMh7WzfqYJ
         voUPFO4sLOh6i7+f42K80qmqJ5NdEWifGX91aiHGKr+pQ+26tUqrpE62NoXijh28qAB0
         XbM6ESWYXnbzRCtxQLrBPtl3mAhj0JsVT1RIWecFA+IxKh3ovw47lgRmCeISeEeSLPW3
         c/xskOFxd6h6ArwLT5+FHtiZaiYikCwsZK8+20gPef6qlRcF/xYEVqCwDEftv1ycvXC5
         gaGyeFfuDTLsIPWeOS1jCpKDDjQEzxdFrDGJWh3y8iJ4k1iuvp6HqjGUa4rApS9IcBg8
         K1Hw==
X-Gm-Message-State: AAQBX9dsC+ewBngjRvD3v3g1WFXbkOI6gGr7IM2Zi0ldrykr9c+/5Q1x
	zYukf0pxsccvE4fMvOSzRBSCDE190t7h5vGQn5k=
X-Google-Smtp-Source: AKy350aP7MWtPae/HQxVX1PY8LR1v+eDZD8Aq+8iKGssH+Pj/T2XO3uPsKiLyqUQ6UN4KzJ7JSn/chJ0hkP5HkAR9Nk=
X-Received: by 2002:a2e:a40e:0:b0:294:6de5:e642 with SMTP id
 p14-20020a2ea40e000000b002946de5e642mr3281732ljn.3.1680775536522; Thu, 06 Apr
 2023 03:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230405101609.3309660-1-enrico.scholz@sigma-chemnitz.de>
 <CA+cAkerT+8E=Td+HEzKw_O7Xa8LSdF1DZvjyf9Kze+XergaCNg@mail.gmail.com>
 <lyh6tucyz9.fsf@ensc-pc.intern.sigma-chemnitz.de> <CA+cAkerceUTAyZ6DveoQF1d-i4nHg6f64UJ2PUr-=L0igeCsFg@mail.gmail.com>
 <lycz4icya8.fsf@ensc-pc.intern.sigma-chemnitz.de> <17530ADB1695B5D1.3977@lists.openembedded.org>
 <CA+cAkerZx=NLx_xiVU=gT9Pwuidv5iaW2PSCCtYaxqt-z-LqMw@mail.gmail.com>
 <ly8rf6cm7u.fsf@ensc-pc.intern.sigma-chemnitz.de> <CA+cAkeo9e9tUqizBJi=RM3S37j4N5VXm7Jdww_5PLxySU7GEqg@mail.gmail.com>
 <088f748bc07ec93c833dbdbf1a941225de62f553.camel@linuxfoundation.org>
In-Reply-To: <088f748bc07ec93c833dbdbf1a941225de62f553.camel@linuxfoundation.org>
From: =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= <frederic.martinsons@gmail.com>
Date: Thu, 6 Apr 2023 12:05:25 +0200
Message-ID: <CA+cAkeq2e=F-LUqkODdQPTgL7VzzAKGssks2z0rEc0AHLH-DAA@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] fetch:crate: create versioned 'name' entries
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>, bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000cd3a7205f8a80c28"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 10:05:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14666

--000000000000cd3a7205f8a80c28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 6 avr. 2023, 10:45, Richard Purdie <
richard.purdie@linuxfoundation.org> a =C3=A9crit :

> On Wed, 2023-04-05 at 19:05 +0200, Frederic Martinsons wrote:
> >
> >
> > Le mer. 5 avr. 2023, 18:45, Enrico Scholz
> > <enrico.scholz@sigma-chemnitz.de> a =C3=A9crit :
> > > Fr=C3=A9d=C3=A9ric Martinsons <frederic.martinsons@gmail.com> writes:
> > >
> > > > No, I take that back, it should not be an issue since you set the
> > > > name
> > > > only if it is not already there. But, to be sure, did you try to
> > > > build
> > > > some existing cargo based recipe (zvariant but also python3-
> > > > bcrypt for
> > > > example).
> > >
> > > It will break cargo related recipes which were created between
> > > 2023-03-16
> > > and 2023-03-31.  Packages before this date do not contain sha256sum
> > > and
> > > after this date, they have an explicit 'name' (which matches the
> > > one
> > > generated by my patch).
> > >
> > >
> > > Enrico
> >
> > Ok, I guess these dates match my patches series, if I do things
> > rights, I handle all the recipes I know of (in meta-openembedded and
> > openembedded-core at least)
>
> This now gives me a problem as rc1 for 4.2 built yesterday. I'm
> guessing we don't want a stable release series with one form for urls
> for six months and a different one in master?
>
> Does this mean I need to scrap rc1, merge this, wait for the recipe
> updates and then rebuild the release?
>
> Cheers,
>
> Richard
>

I'm not sure I understand, is the patch we talk already merged? In the 4.2?

This patch seems to me an improvement and without it, all the recipes I
know of was correctly built (even those in meta-security from what I read
from Armin in https://lists.openembedded.org/g/bitbake-devel/message/14658)

--000000000000cd3a7205f8a80c28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Le jeu. 6 avr. 2023, 10:45, Richard Purdie &lt;<a href=
=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank" rel=3D"nor=
eferrer">richard.purdie@linuxfoundation.org</a>&gt; a =C3=A9crit=C2=A0:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">On Wed, 2023-04-05 at 19:05 +0200, Fre=
deric Martinsons wrote:<br>
&gt; <br>
&gt; <br>
&gt; Le mer. 5 avr. 2023, 18:45, Enrico Scholz<br>
&gt; &lt;<a href=3D"mailto:enrico.scholz@sigma-chemnitz.de" rel=3D"noreferr=
er noreferrer" target=3D"_blank">enrico.scholz@sigma-chemnitz.de</a>&gt; a =
=C3=A9crit=C2=A0:<br>
&gt; &gt; Fr=C3=A9d=C3=A9ric Martinsons &lt;<a href=3D"mailto:frederic.mart=
insons@gmail.com" rel=3D"noreferrer noreferrer" target=3D"_blank">frederic.=
martinsons@gmail.com</a>&gt; writes:<br>
&gt; &gt; <br>
&gt; &gt; &gt; No, I take that back, it should not be an issue since you se=
t the<br>
&gt; &gt; &gt; name<br>
&gt; &gt; &gt; only if it is not already there. But, to be sure, did you tr=
y to<br>
&gt; &gt; &gt; build<br>
&gt; &gt; &gt; some existing cargo based recipe (zvariant but also python3-=
<br>
&gt; &gt; &gt; bcrypt for<br>
&gt; &gt; &gt; example).<br>
&gt; &gt; <br>
&gt; &gt; It will break cargo related recipes which were created between<br=
>
&gt; &gt; 2023-03-16<br>
&gt; &gt; and 2023-03-31.=C2=A0 Packages before this date do not contain sh=
a256sum<br>
&gt; &gt; and<br>
&gt; &gt; after this date, they have an explicit &#39;name&#39; (which matc=
hes the<br>
&gt; &gt; one<br>
&gt; &gt; generated by my patch).<br>
&gt; &gt; <br>
&gt; &gt; <br>
&gt; &gt; Enrico<br>
&gt; <br>
&gt; Ok, I guess these dates match my patches series, if I do things<br>
&gt; rights, I handle all the recipes I know of (in meta-openembedded and<b=
r>
&gt; openembedded-core at least)=C2=A0<br>
<br>
This now gives me a problem as rc1 for 4.2 built yesterday. I&#39;m<br>
guessing we don&#39;t want a stable release series with one form for urls<b=
r>
for six months and a different one in master?<br>
<br>
Does this mean I need to scrap rc1, merge this, wait for the recipe<br>
updates and then rebuild the release?<br>
<br>
Cheers,<br>
<br>
Richard<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">I&#39;m not sure I understand, is the patch we talk already merged? =
In the 4.2?=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">This p=
atch seems to me an improvement and without it, all the recipes I know of w=
as correctly built (even those in meta-security from what I read from Armin=
 in <a href=3D"https://lists.openembedded.org/g/bitbake-devel/message/14658=
">https://lists.openembedded.org/g/bitbake-devel/message/14658</a>)=C2=A0</=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote=
"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000cd3a7205f8a80c28--

