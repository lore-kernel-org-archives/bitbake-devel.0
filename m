Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706DCC3ABBF
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 14:07:43 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web11.10297.1746626858173030220
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 May 2025 07:07:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lY+qWvkD;
 spf=pass (domain: gmail.com, ip: 209.85.208.179, mailfrom: setairidis@gmail.com)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30db1bd3bddso67323911fa.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 May 2025 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746626856; x=1747231656; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sHyMHsqpqoonyAZQDhCMV1NPWom48apAduuVfgdOfQQ=;
        b=lY+qWvkDrIwlT5tVfeUx6oHnhnnFEgjQqIr7M75meEqNtVEmreZemK1E3wHDxeDcdN
         IBa2K9kPOTjXAqKm5NAMV5TuRZ00VU+UxA7wQP9VTCX7b0bVIQrjcQE+ZVEzjTNMsULP
         /KnKGlNMHV9O25k+3T2hHmX52iudg+rfHjLJdPObq66YoNWalLqiJvxpBdHMpS6ChuIW
         QUbWkOR95rGXn3XbCYwZ4SibZw3/GjJIwF+/ghge9rkFJb7vXoh/yWDjRP2oEC8pqTyN
         Qx1qixCsP4sGaesagCXFg09Qstge8G0qqqu43ZEEugIp6xV36yXKACoEarJ9REuIuBjU
         TEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746626856; x=1747231656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHyMHsqpqoonyAZQDhCMV1NPWom48apAduuVfgdOfQQ=;
        b=uGq9G2LbSYLpwHFk9fTUvUH2grZc6/Ff1J9VkxkQp+m0uHwpyUOVIGlr+jhm20u0FU
         9MWRHTDTnGfPVhPozV14ug27bHY3txPyi4pIzETazoztx5HHxWQN/SzVoXYxeolA7Q7e
         8oLYr4Lchfk0wjSNWQgJiF3ClB9CA8VwPo05U1WBtNZf0EeMxiEBK0sq/opBzcNGQtNJ
         1HHU6yOXN4XF2Ok+pSZCfBYz8DcK3valuEliqGGbLlDbeAc0DA2ak3ENc4asnmHUbMNj
         UPZTHmgU+6xHyzE19yEdAtmxhou0fxAU83reDwLMfsuNHQPbxE+EEDlWf6SDGCCP5xOS
         1gLA==
X-Gm-Message-State: AOJu0Yz4OTL4fOC8ZiyqVB7nx1VL+3gU/go/H8WeXoqfG542VYL8wALA
	K4UCR7MyGz8v1W9rK2TB51Zkp6C/szYSOQ8qCuyDuoOZ9PNg4RlF/8yRtsN0yRXVruBqC1AA/9U
	oa6/IGa1SJB7hl/FpU2x1Cbff0dg=
X-Gm-Gg: ASbGncu5Kwhh15XFcvgv2YUauPhRfZFdIyemxXqJ5D2WXr/jZO1372A4FmKL3i2xpun
	vneIUCblTIEwiGIGBXCuAessUdoj0PUG0y60gq9hjZG/9nh2qKSXJo2u7cOfwz2CJgttNwF3Gjf
	HlnMxwtHW55sEyXjeacQVeUo1z
X-Google-Smtp-Source: AGHT+IFF/j66aBg82g7oKVa49Xm1u0kzVHnV9ShNe25ZJeNNiD86hTDP54TTqO4o0wSnNdNZsSUThJAfzYE6e68Wpvk=
X-Received: by 2002:a2e:a5c5:0:b0:30d:e104:a497 with SMTP id
 38308e7fff4ca-326ad33d12dmr9880971fa.41.1746626855594; Wed, 07 May 2025
 07:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250505185755.1952-1-falital@hotmail.com> <292ee69d270d71860a7ebada65e4f6aeeca01d13.camel@linuxfoundation.org>
 <CAKJXz6d061e5h-_7vV6iWVj90gFvKqnKC=yRQqWaobqjvzfLgg@mail.gmail.com> <4ea9b9dcda4e5482050f472b03b69bdaf062d532.camel@linuxfoundation.org>
In-Reply-To: <4ea9b9dcda4e5482050f472b03b69bdaf062d532.camel@linuxfoundation.org>
From: Sawas Etairidis <setairidis@gmail.com>
Date: Wed, 7 May 2025 16:07:24 +0200
X-Gm-Features: ATxdqUFL1IOHYyc53SdGja_FmQ7E_AfdI--jyldWmHixLqQkorJlI1RDNortNmI
Message-ID: <CAKJXz6fXHGPuFbjiD2Z+jsOGA9Yj3XGazp9EjU58pWvy1wtT0Q@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch: Add support for remapping URL's
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
	Savvas Etairidis <falital@hotmail.com>
Content-Type: multipart/alternative; boundary="00000000000048717606348c41ab"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 May 2025 14:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17599

--00000000000048717606348c41ab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

My bad, I never noticed this was in another component. Sorry to waste your
time on this.
I will look if I can work on this in the layer index project if not, I move
to NEW again.
If you think it is of value, I could build a check if a URL is the same,
but the access protocol is not the same to at least inform the developer
that something is wrong.
For example, if the following is configured.

recipe_a.bb
SRC_URI =3D  "git://github.com/project/repo"

recipe_b.bb
SRC_URI =3D  "https://github.com/project/repo"

The following warning should be generated.
WARNING:  recipe_a-0.0.0-r0 do_fetch: Url github.com/project is accessed
with diffrent protocols

Regards,
Savvas

=CE=A3=CF=84=CE=B9=CF=82 =CE=A4=CE=B5=CF=84 7 =CE=9C=CE=B1=CE=90 2025 =CF=
=83=CF=84=CE=B9=CF=82 10:05=E2=80=AF=CF=80.=CE=BC., =CE=BF/=CE=B7 Richard P=
urdie <
richard.purdie@linuxfoundation.org> =CE=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:

> Hi Savvas,
>
> On Wed, 2025-05-07 at 09:28 +0200, Sawas Etairidis wrote:
> > I think it would be better to not modify how PREMIRRORS and MIRRORS
> > work since users already depend on them and expect them to work on
> > specific way.
> > Like this you can add extra rules to rewrite the source code url and
> > then use  PREMIRRORS and MIRRORS if they exists.
> > I could instead provide an example how someone could have the same
> > result using PREMIRRORS if you think it is not worth having this as
> > standalone feature.
>
> Looking at the bug in question
> (https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D10699), the issue is
> filed against the layer index and the issue in question was more about
> allowing layers to list their mirror urls so that we could canonicalise
> different urls.
>
> Your patch is against bitbake itself and it is unclear if we need that
> support in bitbake itself to solve that bug which was targetting a
> layer index change if I understand correctly.
>
> There is already some discussion about changing the way
> PREMIRRORS/MIRRORS work for other issues and given that, I'm reluctant
> to add new code paths that add complexity and do things in a different
> way. I've been hoping rather than adding complexity, we could try and
> simplify whilst still maintaining the different use cases we need.
>
> Cheers,
>
> Richard
>

--00000000000048717606348c41ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Richard,<div><br></div><div>My bad, I never noticed thi=
s was in another component. Sorry to waste your time on this.<br>I will loo=
k if I can work on this in the layer index project if not, I move to NEW ag=
ain.<br>If you think it is of value, I could build a check if a URL is the =
same, but the access protocol is not the same to at least inform the develo=
per that something is wrong.<br>For example, if the following is configured=
.</div><div><br></div><div><a href=3D"http://recipe_a.bb">recipe_a.bb</a></=
div><div>SRC_URI =3D=C2=A0 &quot;<span style=3D"color:rgb(0,0,0)">git://<a =
href=3D"http://github.com/project/repo">github.com/project/repo</a>&quot;</=
span></div><div><span style=3D"color:rgb(0,0,0)"><br></span></div><div><spa=
n style=3D"color:rgb(0,0,0)"><a href=3D"http://recipe_b.bb">recipe_b.bb</a>=
</span></div><div>SRC_URI =3D=C2=A0 &quot;https<span style=3D"color:rgb(0,0=
,0)">://<a href=3D"http://github.com/project/repo">github.com/project/repo<=
/a>&quot;</span></div><div><br></div><div>The following warning should be g=
enerated.</div><div>WARNING:=C2=A0

recipe_a-0.0.0-r0 do_fetch: Url=C2=A0<span style=3D"color:rgb(0,0,0)"><a hr=
ef=3D"http://github.com/project">github.com/project</a> is accessed with di=
ffrent protocols</span></div><div><br></div><div>Regards,</div><div>Savvas<=
/div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">=CE=A3=CF=84=CE=B9=CF=82 =CE=A4=CE=B5=CF=84 7 =
=CE=9C=CE=B1=CE=90 2025 =CF=83=CF=84=CE=B9=CF=82 10:05=E2=80=AF=CF=80.=CE=
=BC., =CE=BF/=CE=B7 Richard Purdie &lt;<a href=3D"mailto:richard.purdie@lin=
uxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi Savvas,<br>
<br>
On Wed, 2025-05-07 at 09:28 +0200, Sawas Etairidis wrote:<br>
&gt; I think it would be better to not modify how PREMIRRORS and MIRRORS<br=
>
&gt; work since users already depend on them and expect them to work on<br>
&gt; specific way.<br>
&gt; Like this you can add extra rules to rewrite the source code url and<b=
r>
&gt; then use=C2=A0 PREMIRRORS and MIRRORS if they exists.<br>
&gt; I could instead provide an example how someone could have the same<br>
&gt; result using PREMIRRORS if you think it is not worth having this as<br=
>
&gt; standalone feature.<br>
<br>
Looking at the bug in question<br>
(<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D10699" rel=
=3D"noreferrer" target=3D"_blank">https://bugzilla.yoctoproject.org/show_bu=
g.cgi?id=3D10699</a>), the issue is<br>
filed against the layer index and the issue in question was more about<br>
allowing layers to list their mirror urls so that we could canonicalise<br>
different urls.<br>
<br>
Your patch is against bitbake itself and it is unclear if we need that<br>
support in bitbake itself to solve that bug which was targetting a<br>
layer index change if I understand correctly.<br>
<br>
There is already some discussion about changing the way<br>
PREMIRRORS/MIRRORS work for other issues and given that, I&#39;m reluctant<=
br>
to add new code paths that add complexity and do things in a different<br>
way. I&#39;ve been hoping rather than adding complexity, we could try and<b=
r>
simplify whilst still maintaining the different use cases we need.<br>
<br>
Cheers,<br>
<br>
Richard<br>
</blockquote></div>

--00000000000048717606348c41ab--

