Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEEECCD183
	for <webhook@archiver.kernel.org>; Thu,  9 Oct 2025 17:12:48 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.6022.1760029963753085091
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Oct 2025 10:12:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=JkqsM1rT;
 spf=pass (domain: smile.fr, ip: 209.85.221.42, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso745841f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1760029962; x=1760634762; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ImClTWpgRNyu2o2BCvyY7+ktLwZN5fd3O0JvW9ZaLtI=;
        b=JkqsM1rTHu1HqMULgFS2EKj2Chwj5b4D3WKLzMbW5YQOf1G9/jLwhXxyxVCKyQRTHe
         vWFCPXx/5Eg76ebXWtAD4QrPEwdRCr7O//jGnp/WQ6F2hX3ZslPQRPIXehgYgiXL7cL1
         D82II0BEu0mr2lJFyIVtRvTuQcu6EEfDV5e0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760029962; x=1760634762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImClTWpgRNyu2o2BCvyY7+ktLwZN5fd3O0JvW9ZaLtI=;
        b=sU4sczzqJuH27icEPh9klIpxeG+xpA3rORYOZlu/22ZrcDjwXbcU3dgud0y7gWNnHt
         X0nQnDC+yB3iKTAoiVZHqPiOXQrOrxN7y6uHwm/3D0mHm288SNc23wc11L18e/2VvOPz
         EVXzkHdSKvw+kkKL3KdyU7o/Z3b+/y2hMjsv5bx8ZKYFx/E+mFPxydvyKP51DAWMpAY3
         6PdDmulGbJKi8126C8NBReLYC8q7HyaNLUe6fZh17cMDkWK2U9maMxxvNg+l+K4I325X
         Se5153MGzr1ogVRzHNm5Vqr+aV364j0Ly4+ThtvkXHOvgIbeezqFI71vs8Q7s0rVq0Sd
         ow9w==
X-Gm-Message-State: AOJu0YwSAuW1bKs0nO4mSf5Y821tDExYmIIZiLSlBsth7oPKEyjexauF
	mKqF/DulaWTH2gImtOELiS3VSgnH7njUd7v39C7MfGkcYOLYvuwkQcbqgiR46E0fnv1JYW2qNwy
	drTGtzRtlS7D/WKXtU3MIT1D260kpx9UDiU5dAalIcQ==
X-Gm-Gg: ASbGncugIfM0Rbz2LY1ptTiCFm9PSbZmX2M+/r/c9I7XJ+WGemqiZYWekNcRhBp4waD
	h2+Raq458V2/BMVrX3M/wOnwzqyGbZ2lfrKh9CmBuc3jFS9ss8OwJWSPpTV7srz1uC+xqHtMXbc
	/cTpIZF0SypNesdsnUunFKSuY11hpvGfU7eaf8v1OkWB7EzqcxMpZyxfzWRewWRWHrzXkGxrZNT
	2+1c27eYOflYRHBSJgf23+7M9Nj21ycl6v3WZGLdH2QPa6frv6EbY77B5me5g==
X-Google-Smtp-Source: AGHT+IFIua72CHeFKwKtS61+7rAWkmy5rZdys6KmW05j20hY8o9FtrV/KTgcAN78xTlxVI027/5cXGkrV6Iy3X3OUjw=
X-Received: by 2002:a05:6000:2f83:b0:3e4:f194:2886 with SMTP id
 ffacd0b85a97d-426670835d8mr4942087f8f.19.1760029962095; Thu, 09 Oct 2025
 10:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20251009160717.2527351-1-yoann.congal@smile.fr> <CANNYZj-NPGrWypiuh8hU-BB+fM5pVsTh=4ZPOJt6seu-AKN=Cg@mail.gmail.com>
In-Reply-To: <CANNYZj-NPGrWypiuh8hU-BB+fM5pVsTh=4ZPOJt6seu-AKN=Cg@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Date: Thu, 9 Oct 2025 19:12:15 +0200
X-Gm-Features: AS18NWBoN1lXyrnyvExsYhiuBA1ie1nkTkvyvTiVN1UmmqPWKn243FXltjnRRoI
Message-ID: <CAMSfU+5=K4oe1P8udCcJG728Nv1VtiCzFmOJzRL5DKi885GFNA@mail.gmail.com>
Subject: Re: [bitbake-devel] [RFC PATCH] ast: Better variable history for
 builtin fragments
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="000000000000af61a10640bce88f"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Oct 2025 17:12:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18154

--000000000000af61a10640bce88f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 9 oct. 2025 =C3=A0 18:29, Alexander Kanavin <alex.kanavin@gmail.com=
> a
=C3=A9crit :

> On Thu, 9 Oct 2025 at 18:07, Yoann Congal via lists.openembedded.org
> <yoann.congal=3Dsmile.fr@lists.openembedded.org> wrote:
> > But, (and this is why this patch is a RFC), on a complex case : adding
> > a fragment, another, then the first one again, history looks like this:
> >    $ bitbake-getvar MACHINE
> >   NOTE: Starting bitbake server...
> >   #
> >   # $MACHINE [4 operations]
> >   #   set .../auto.conf:4     # <<<<=3D=3D=3D This line number is wrong
> >   #     "qemux86-64 (OE_FRAGMENTS contains "machine/qemux86-64")"
> >   #   set .../auto.conf:3
> >   #     "test (OE_FRAGMENTS contains "machine/test")"
> >   #   set .../auto.conf:4
> >   #     "qemux86-64 (OE_FRAGMENTS contains "machine/qemux86-64")"
> >   # pre-expansion value:
> >   #   "qemux86-64"
> >   MACHINE=3D"qemux86-64"
> > I don't know how to match OE_FRAGMENTS history with MACHINE history in
> > this case. When MACHINE is set to "qemux86-64", how does the code can
> > know whether it is the first instance or the second? (My patch take the
> > last one)
>
> I don't think this is something we should worry about. The tool for
> managing fragments is fixed to not allow this anymore:
>
> https://git.openembedded.org/openembedded-core/commit/?h=3Dmaster&id=3Dae=
a2d69d0533bf005cd58eb91fd9b3a3ae194610
> and if users end up setting the same built-in fragments multiple times
> some other way, that's a misconfiguration on their part.
>

Should we think about displaying a warning in this case (multiple values
for the same fragment) ?
--=20
Yoann Congal
Smile ECS

--000000000000af61a10640bce88f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Le=C2=A0jeu. 9 =
oct. 2025 =C3=A0=C2=A018:29, Alexander Kanavin &lt;<a href=3D"mailto:alex.k=
anavin@gmail.com">alex.kanavin@gmail.com</a>&gt; a =C3=A9crit=C2=A0:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 9 Oct 2025 at =
18:07, Yoann Congal via <a href=3D"http://lists.openembedded.org" rel=3D"no=
referrer" target=3D"_blank">lists.openembedded.org</a><br>
&lt;yoann.congal=3D<a href=3D"mailto:smile.fr@lists.openembedded.org" targe=
t=3D"_blank">smile.fr@lists.openembedded.org</a>&gt; wrote:<br>
&gt; But, (and this is why this patch is a RFC), on a complex case : adding=
<br>
&gt; a fragment, another, then the first one again, history looks like this=
:<br>
&gt;=C2=A0 =C2=A0 $ bitbake-getvar MACHINE<br>
&gt;=C2=A0 =C2=A0NOTE: Starting bitbake server...<br>
&gt;=C2=A0 =C2=A0#<br>
&gt;=C2=A0 =C2=A0# $MACHINE [4 operations]<br>
&gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0set .../auto.conf:4=C2=A0 =C2=A0 =C2=A0# &lt=
;&lt;&lt;&lt;=3D=3D=3D This line number is wrong<br>
&gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0&quot;qemux86-64 (OE_FRAGMENTS contai=
ns &quot;machine/qemux86-64&quot;)&quot;<br>
&gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0set .../auto.conf:3<br>
&gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0&quot;test (OE_FRAGMENTS contains &qu=
ot;machine/test&quot;)&quot;<br>
&gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0set .../auto.conf:4<br>
&gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0 =C2=A0&quot;qemux86-64 (OE_FRAGMENTS contai=
ns &quot;machine/qemux86-64&quot;)&quot;<br>
&gt;=C2=A0 =C2=A0# pre-expansion value:<br>
&gt;=C2=A0 =C2=A0#=C2=A0 =C2=A0&quot;qemux86-64&quot;<br>
&gt;=C2=A0 =C2=A0MACHINE=3D&quot;qemux86-64&quot;<br>
&gt; I don&#39;t know how to match OE_FRAGMENTS history with MACHINE histor=
y in<br>
&gt; this case. When MACHINE is set to &quot;qemux86-64&quot;, how does the=
 code can<br>
&gt; know whether it is the first instance or the second? (My patch take th=
e<br>
&gt; last one)<br>
<br>
I don&#39;t think this is something we should worry about. The tool for<br>
managing fragments is fixed to not allow this anymore:<br>
<a href=3D"https://git.openembedded.org/openembedded-core/commit/?h=3Dmaste=
r&amp;id=3Daea2d69d0533bf005cd58eb91fd9b3a3ae194610" rel=3D"noreferrer" tar=
get=3D"_blank">https://git.openembedded.org/openembedded-core/commit/?h=3Dm=
aster&amp;id=3Daea2d69d0533bf005cd58eb91fd9b3a3ae194610</a><br>
and if users end up setting the same built-in fragments multiple times<br>
some other way, that&#39;s a misconfiguration on their part.<br></blockquot=
e><div><br></div><div>Should we think about displaying a warning in this ca=
se (multiple values for the same fragment) ?</div></div><span class=3D"gmai=
l_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature=
"><div dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Congal</font><div>=
<font face=3D"Raleway, regular">Smile ECS</font></div></div></div></div>

--000000000000af61a10640bce88f--

